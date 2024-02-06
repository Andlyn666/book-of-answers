/*
 * Create the system calls that the client can use to ask
 * for changes in the World state (using the System contracts).
 */

import { Entity, getComponentValueStrict } from "@latticexyz/recs";
import { ClientComponents } from "./createClientComponents";
import { SetupNetworkResult } from "./setupNetwork";
import { singletonEntity } from "@latticexyz/store-sync/recs";
import { SystemSwitch } from "@latticexyz/world-modules/src/utils/SystemSwitch.sol";
import * as crypto from 'crypto';
import { random } from "@latticexyz/utils";

export type SystemCalls = ReturnType<typeof createSystemCalls>;

export function createSystemCalls(
  /*
   * The parameter list informs TypeScript that:
   *
   * - The first parameter is expected to be a
   *   SetupNetworkResult, as defined in setupNetwork.ts
   *
   *   Out of this parameter, we only care about two fields:
   *   - worldContract (which comes from getContract, see
   *     https://github.com/latticexyz/mud/blob/main/templates/react/packages/client/src/mud/setupNetwork.ts#L63-L69).
   *
   *   - waitForTransaction (which comes from syncToRecs, see
   *     https://github.com/latticexyz/mud/blob/main/templates/react/packages/client/src/mud/setupNetwork.ts#L77-L83).
   *
   * - From the second parameter, which is a ClientComponent,
   *   we only care about Counter. This parameter comes to use
   *   through createClientComponents.ts, but it originates in
   *   syncToRecs
   *   (https://github.com/latticexyz/mud/blob/main/templates/react/packages/client/src/mud/setupNetwork.ts#L77-L83).
   */
  { worldContract, waitForTransaction }: SetupNetworkResult,
  { Randcast}: ClientComponents
) {
  
  const getRandomness = async (entityId, subId) => {
    const estimatePara = "1234".padEnd(64, '0');
    const estimateCallBackGas = await worldContract.estimateGas.fulfillRandomness([`0x${estimatePara}`, BigInt(0), `0x${estimatePara}`]);
    console.log(estimateCallBackGas);
    // Send the transaction
    const tx = await worldContract.write.getRandomness([BigInt(subId), entityId, Number(estimateCallBackGas)]);
    // Wait for the transaction to be mined
    await waitForTransaction(tx);
    let attempts = 0;
    const maxAttempts = 10; // Try for 10 seconds
    
    while (attempts < maxAttempts) {
      try {
        // Get the component value
        const randomnessComponent = getComponentValueStrict(Randcast, entityId);
        if (randomnessComponent && randomnessComponent.randomness) {
          // If randomness is found, return it
          // return randomnessComponent.randomness;
          const randomness = worldContract.read.getRandomnessByKey([entityId]);
          return randomness;
        }
      } catch (error) {
        if (attempts === maxAttempts - 1)
        console.error("An error occurred:", error);
      }
  
      // Increase the attempt counter
      attempts++;
  
      // Wait for 1 second before trying again
      await new Promise(resolve => setTimeout(resolve, 1000));
    }
  
    throw new Error("Failed to obtain randomness within 10 seconds");
  };
  

  return {
    getRandomness,
  };
}

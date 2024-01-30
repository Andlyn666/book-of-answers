import { mudConfig } from "@latticexyz/world/register";
import { resolveTableId } from "@latticexyz/config";
 
export default mudConfig({
  tables: {
    Answers: {
      valueSchema: {
        page: "uint256",
        answers: "string",
      },
    },
  },
  modules: [
    {
      name: "RandcastModule",
      root: true,
    },
  ],
});
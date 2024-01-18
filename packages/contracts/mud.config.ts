import { mudConfig } from "@latticexyz/world/register";

export default mudConfig({
  tables: {
    Answers: {
      valueSchema: {
        page: "uint256",
        answers: "string",
      },
    }
  },
});

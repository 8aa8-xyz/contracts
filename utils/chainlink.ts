export const getChainlinkTokenAddress = (chainId: number = 1): string => {
  // https://docs.chain.link/docs/link-token-contracts/
  switch (chainId) {
    case 1:
      return "0x514910771af9ca656af840dff83e8264ecf986ca";
    case 4:
      return "0x01BE23585060835E02B77ef475b0Cc51aA1e0709";
    case 5:
      return "0x326c977e6efc84e512bb9c30f76e30c160ed06fb";
    case 42:
      return "0xa36085F69e2889c224210F603D836748e7dC0088";
    case 31337:
    // handle local network
    default:
      throw new Error(`No recognized chain found for ID: ${chainId}`);
  }
};

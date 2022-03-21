/* Autogenerated file. Do not edit manually. */
/* tslint:disable */
/* eslint-disable */

import { Provider } from "@ethersproject/providers";
import { Contract, Signer, utils } from "ethers";
import type { ENSResolver, ENSResolverInterface } from "../ENSResolver";

const _abi = [
  {
    inputs: [
      {
        internalType: "bytes32",
        name: "node",
        type: "bytes32",
      },
    ],
    name: "addr",
    outputs: [
      {
        internalType: "address",
        name: "",
        type: "address",
      },
    ],
    stateMutability: "view",
    type: "function",
  },
];

export class ENSResolver__factory {
  static readonly abi = _abi;
  static createInterface(): ENSResolverInterface {
    return new utils.Interface(_abi) as ENSResolverInterface;
  }
  static connect(
    address: string,
    signerOrProvider: Signer | Provider
  ): ENSResolver {
    return new Contract(address, _abi, signerOrProvider) as ENSResolver;
  }
}
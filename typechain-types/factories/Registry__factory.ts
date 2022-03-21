/* Autogenerated file. Do not edit manually. */
/* tslint:disable */
/* eslint-disable */

import { Provider } from "@ethersproject/providers";
import { Contract, Signer, utils } from "ethers";
import type { Registry, RegistryInterface } from "../Registry";

const _abi = [
  {
    anonymous: false,
    inputs: [
      {
        indexed: true,
        internalType: "address",
        name: "owner",
        type: "address",
      },
      {
        indexed: true,
        internalType: "bytes32",
        name: "",
        type: "bytes32",
      },
    ],
    name: "Dispute",
    type: "event",
  },
  {
    anonymous: false,
    inputs: [
      {
        indexed: true,
        internalType: "address",
        name: "owner",
        type: "address",
      },
      {
        indexed: true,
        internalType: "bytes32",
        name: "",
        type: "bytes32",
      },
    ],
    name: "DisputeSuccessful",
    type: "event",
  },
  {
    anonymous: false,
    inputs: [
      {
        indexed: true,
        internalType: "address",
        name: "owner",
        type: "address",
      },
      {
        indexed: true,
        internalType: "bytes32",
        name: "proof",
        type: "bytes32",
      },
      {
        indexed: false,
        internalType: "bytes32",
        name: "",
        type: "bytes32",
      },
    ],
    name: "VerificationSuccessful",
    type: "event",
  },
  {
    anonymous: false,
    inputs: [
      {
        indexed: true,
        internalType: "address",
        name: "owner",
        type: "address",
      },
      {
        indexed: true,
        internalType: "bytes32",
        name: "",
        type: "bytes32",
      },
      {
        indexed: false,
        internalType: "bytes32",
        name: "",
        type: "bytes32",
      },
    ],
    name: "Verify",
    type: "event",
  },
  {
    inputs: [
      {
        internalType: "bytes32",
        name: "",
        type: "bytes32",
      },
    ],
    name: "dispute",
    outputs: [],
    stateMutability: "nonpayable",
    type: "function",
  },
  {
    inputs: [
      {
        internalType: "bytes32",
        name: "",
        type: "bytes32",
      },
    ],
    name: "resolve",
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
  {
    inputs: [
      {
        internalType: "bytes32",
        name: "",
        type: "bytes32",
      },
    ],
    name: "verify",
    outputs: [],
    stateMutability: "nonpayable",
    type: "function",
  },
];

export class Registry__factory {
  static readonly abi = _abi;
  static createInterface(): RegistryInterface {
    return new utils.Interface(_abi) as RegistryInterface;
  }
  static connect(
    address: string,
    signerOrProvider: Signer | Provider
  ): Registry {
    return new Contract(address, _abi, signerOrProvider) as Registry;
  }
}
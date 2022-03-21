/* Autogenerated file. Do not edit manually. */
/* tslint:disable */
/* eslint-disable */
import { FunctionFragment, Result } from "@ethersproject/abi";
import { Listener, Provider } from "@ethersproject/providers";
import {
  BaseContract,
  BigNumber,
  BytesLike,
  CallOverrides,
  PopulatedTransaction,
  Signer,
  utils,
} from "ethers";
import { OnEvent, TypedEvent, TypedEventFilter, TypedListener } from "./common";

export interface PointerInterfaceInterface extends utils.Interface {
  contractName: "PointerInterface";
  functions: {
    "getAddress()": FunctionFragment;
  };

  encodeFunctionData(
    functionFragment: "getAddress",
    values?: undefined
  ): string;

  decodeFunctionResult(functionFragment: "getAddress", data: BytesLike): Result;

  events: {};
}

export interface PointerInterface extends BaseContract {
  contractName: "PointerInterface";
  connect(signerOrProvider: Signer | Provider | string): this;
  attach(addressOrName: string): this;
  deployed(): Promise<this>;

  interface: PointerInterfaceInterface;

  queryFilter<TEvent extends TypedEvent>(
    event: TypedEventFilter<TEvent>,
    fromBlockOrBlockhash?: string | number | undefined,
    toBlock?: string | number | undefined
  ): Promise<Array<TEvent>>;

  listeners<TEvent extends TypedEvent>(
    eventFilter?: TypedEventFilter<TEvent>
  ): Array<TypedListener<TEvent>>;
  listeners(eventName?: string): Array<Listener>;
  removeAllListeners<TEvent extends TypedEvent>(
    eventFilter: TypedEventFilter<TEvent>
  ): this;
  removeAllListeners(eventName?: string): this;
  off: OnEvent<this>;
  on: OnEvent<this>;
  once: OnEvent<this>;
  removeListener: OnEvent<this>;

  functions: {
    getAddress(overrides?: CallOverrides): Promise<[string]>;
  };

  getAddress(overrides?: CallOverrides): Promise<string>;

  callStatic: {
    getAddress(overrides?: CallOverrides): Promise<string>;
  };

  filters: {};

  estimateGas: {
    getAddress(overrides?: CallOverrides): Promise<BigNumber>;
  };

  populateTransaction: {
    getAddress(overrides?: CallOverrides): Promise<PopulatedTransaction>;
  };
}

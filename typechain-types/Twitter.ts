/* Autogenerated file. Do not edit manually. */
/* tslint:disable */
/* eslint-disable */
import { EventFragment, FunctionFragment, Result } from "@ethersproject/abi";
import { Listener, Provider } from "@ethersproject/providers";
import {
  BaseContract,
  BigNumber,
  BigNumberish,
  BytesLike,
  CallOverrides,
  ContractTransaction,
  Overrides,
  PopulatedTransaction,
  Signer,
  utils,
} from "ethers";
import { OnEvent, TypedEvent, TypedEventFilter, TypedListener } from "./common";

export interface TwitterInterface extends utils.Interface {
  contractName: "Twitter";
  functions: {
    "fulfill(bytes32,bytes32)": FunctionFragment;
    "onTokenTransfer(address,uint256,bytes)": FunctionFragment;
    "resolve(bytes32)": FunctionFragment;
  };

  encodeFunctionData(
    functionFragment: "fulfill",
    values: [BytesLike, BytesLike]
  ): string;
  encodeFunctionData(
    functionFragment: "onTokenTransfer",
    values: [string, BigNumberish, BytesLike]
  ): string;
  encodeFunctionData(functionFragment: "resolve", values: [BytesLike]): string;

  decodeFunctionResult(functionFragment: "fulfill", data: BytesLike): Result;
  decodeFunctionResult(
    functionFragment: "onTokenTransfer",
    data: BytesLike
  ): Result;
  decodeFunctionResult(functionFragment: "resolve", data: BytesLike): Result;

  events: {
    "ChainlinkCancelled(bytes32)": EventFragment;
    "ChainlinkFulfilled(bytes32)": EventFragment;
    "ChainlinkRequested(bytes32)": EventFragment;
  };

  getEvent(nameOrSignatureOrTopic: "ChainlinkCancelled"): EventFragment;
  getEvent(nameOrSignatureOrTopic: "ChainlinkFulfilled"): EventFragment;
  getEvent(nameOrSignatureOrTopic: "ChainlinkRequested"): EventFragment;
}

export type ChainlinkCancelledEvent = TypedEvent<[string], { id: string }>;

export type ChainlinkCancelledEventFilter =
  TypedEventFilter<ChainlinkCancelledEvent>;

export type ChainlinkFulfilledEvent = TypedEvent<[string], { id: string }>;

export type ChainlinkFulfilledEventFilter =
  TypedEventFilter<ChainlinkFulfilledEvent>;

export type ChainlinkRequestedEvent = TypedEvent<[string], { id: string }>;

export type ChainlinkRequestedEventFilter =
  TypedEventFilter<ChainlinkRequestedEvent>;

export interface Twitter extends BaseContract {
  contractName: "Twitter";
  connect(signerOrProvider: Signer | Provider | string): this;
  attach(addressOrName: string): this;
  deployed(): Promise<this>;

  interface: TwitterInterface;

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
    fulfill(
      _requestId: BytesLike,
      _twitterHandle: BytesLike,
      overrides?: Overrides & { from?: string | Promise<string> }
    ): Promise<ContractTransaction>;

    onTokenTransfer(
      from: string,
      amount: BigNumberish,
      data: BytesLike,
      overrides?: Overrides & { from?: string | Promise<string> }
    ): Promise<ContractTransaction>;

    resolve(
      twitterHandle: BytesLike,
      overrides?: CallOverrides
    ): Promise<[string] & { ownerAddress: string }>;
  };

  fulfill(
    _requestId: BytesLike,
    _twitterHandle: BytesLike,
    overrides?: Overrides & { from?: string | Promise<string> }
  ): Promise<ContractTransaction>;

  onTokenTransfer(
    from: string,
    amount: BigNumberish,
    data: BytesLike,
    overrides?: Overrides & { from?: string | Promise<string> }
  ): Promise<ContractTransaction>;

  resolve(twitterHandle: BytesLike, overrides?: CallOverrides): Promise<string>;

  callStatic: {
    fulfill(
      _requestId: BytesLike,
      _twitterHandle: BytesLike,
      overrides?: CallOverrides
    ): Promise<void>;

    onTokenTransfer(
      from: string,
      amount: BigNumberish,
      data: BytesLike,
      overrides?: CallOverrides
    ): Promise<boolean>;

    resolve(
      twitterHandle: BytesLike,
      overrides?: CallOverrides
    ): Promise<string>;
  };

  filters: {
    "ChainlinkCancelled(bytes32)"(
      id?: BytesLike | null
    ): ChainlinkCancelledEventFilter;
    ChainlinkCancelled(id?: BytesLike | null): ChainlinkCancelledEventFilter;

    "ChainlinkFulfilled(bytes32)"(
      id?: BytesLike | null
    ): ChainlinkFulfilledEventFilter;
    ChainlinkFulfilled(id?: BytesLike | null): ChainlinkFulfilledEventFilter;

    "ChainlinkRequested(bytes32)"(
      id?: BytesLike | null
    ): ChainlinkRequestedEventFilter;
    ChainlinkRequested(id?: BytesLike | null): ChainlinkRequestedEventFilter;
  };

  estimateGas: {
    fulfill(
      _requestId: BytesLike,
      _twitterHandle: BytesLike,
      overrides?: Overrides & { from?: string | Promise<string> }
    ): Promise<BigNumber>;

    onTokenTransfer(
      from: string,
      amount: BigNumberish,
      data: BytesLike,
      overrides?: Overrides & { from?: string | Promise<string> }
    ): Promise<BigNumber>;

    resolve(
      twitterHandle: BytesLike,
      overrides?: CallOverrides
    ): Promise<BigNumber>;
  };

  populateTransaction: {
    fulfill(
      _requestId: BytesLike,
      _twitterHandle: BytesLike,
      overrides?: Overrides & { from?: string | Promise<string> }
    ): Promise<PopulatedTransaction>;

    onTokenTransfer(
      from: string,
      amount: BigNumberish,
      data: BytesLike,
      overrides?: Overrides & { from?: string | Promise<string> }
    ): Promise<PopulatedTransaction>;

    resolve(
      twitterHandle: BytesLike,
      overrides?: CallOverrides
    ): Promise<PopulatedTransaction>;
  };
}

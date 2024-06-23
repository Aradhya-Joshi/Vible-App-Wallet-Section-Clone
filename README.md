## Getting Started

## Table of Contents

1. [Introduction](#introduction)
2. [Features](#features)
3. [Usage](#usage)
4. [Screenshots](#screenshots)
5. [Architecture](#architecture)
6. [API Reference](#api-reference)

## Introduction

The Vible Wallet Clone is a Flutter application that replicates the core functionalities of the Wallet Section in of the Vible App. It allows users to manage multiple wallets, view transaction history, and send/receive cryptocurrency across different networks.

## Features

- User authentication
- Wallet management
- Transaction history
- Send and receive cryptocurrency

## Usage

- **Authentication:** Log in with your registered credentials.
- **Wallet Management:** Create, view, and manage multiple wallets.
- **Transactions:** View transaction history and perform send/receive operations.
- **Network Selection:** Switch between different supported networks like Polygon Mainnet, Ethereum Mainnet, etc.

## Screenshots

![Login Screen](screenshots/login.png "Login Screen")
_Login Screen_

![Login Filled Screen](screenshots/login_filled.png "Login Filled Screen")
_Login Filled Screen_

![Login Successful Screen](screenshots/login_success.png "Login Successful Screen")
_Login Successful Screen_

![Dashboard](screenshots/dashboard.png "Dashboard")
_Dashboard_

![Select Network](screenshots/select_network.png "Select Network")
_Select Network_

![View More From App Bar](screenshots/view_more_from_app_bar.png "View More From App Bar")
_View More From App Bar_

![Select Way To Send Or Transfer](screenshots/select_way_to_send_or_transfer.png "Select Way To Send Or Transfer")
_Select Way To Send Or Transfer_

![Send By Address](screenshots/send_by_address.png "Send By Address")
_Send By Address_

![Send By Address-2](screenshots/send_by_address-2.png "Send By Address-2")
_Send By Address-2_

![Send By Address Select Currency](screenshots/send_by_address_select_currency.png "Send By Address Select Currency")
_Send By Address Select Currency_

![Send By Address Error](screenshots/send_by_address_error.png "Send By Address Error")
_Send By Address Error_

![Enter Pin To Authenticate Transaction ](screenshots/enter_pin_to_authenticate.png "Enter Pin To Authenticate Transaction ")
_Enter Pin To Authenticate Transaction_

![Enter Pin To Authenticate Transaction Filled](screenshots/enter_pin_to_authenticate_filled.png "Enter Pin To Authenticate Transaction Filled")
_Enter Pin To Authenticate Transaction Filled_

## Architecture

The Vible Wallet Clone app follows the MVVM (Model-View-ViewModel) architecture.

- **Models:** Represent the data structures and business logic.
- **Views:** UI components such as screens and widgets.
- **ViewModels:** Handle the logic to update the UI and interact with models.

### Key Components

1. **Authentication Module:** Handles user login.
2. **Wallet Module:** Manages wallet creation and storage.
3. **Transaction Module:** Handles transaction operations and history.

## API Reference

### Authentication API

- **Endpoint:** `/user/login`
  - **Method:** POST
  - **Description:** Authenticate user
  - **Parameters:**
    - `mixed`: User's email address
    - `password`: User's password

### Wallet API

- **Endpoint:** `solana/wallet/create`

  - **Method:** POST
  - **Description:** Create a new wallet
  - **Parameters:**
    - `walletName`: Nick-name given to the wallet by the user
    - `network`: Network type (e.g., Polygon, Ethereum)
    - `userPin`: Pin set by the user

- **Endpoint:** `solana/wallet/balance`
  - **Method:** GET
  - **Description:** Get the balance of user's wallet
  - **Parameters:**
    - `network`: Network type (e.g., Polygon, Ethereum)
    - `wallet_address`: User's wallet address whose balance is to be found.

### Transaction API

- **Endpoint:** `solana/wallet/transfer`

  - **Method:** POST
  - **Description:** Send cryptocurrency
  - **Parameters:**
    - `senderAddress`: Sender's wallet address
    - `recipientAddress`: Receiver's wallet address
    - `amount`: Amount to send
    - `network`: Network type (e.g., Polygon, Ethereum)
    - `userPin`: Pin of the user to authenticate the transaction

- **Endpoint:** `solana/wallet/airdrop`
  - **Method:** POST
  - **Description:** Request Airdrop
  - **Parameters:**
    - `walletAddress`: Receiver's wallet address
    - `amount`: Amount to send
    - `network`: Network type (e.g., Polygon, Ethereum)

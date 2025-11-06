Received: from SN4PR2101CU001.outbound.protection.outlook.com (mail-southcentralusazon11012042.outbound.protection.outlook.com [40.93.195.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F5A11FC8
	for <linux-block@vger.kernel.org>; Thu,  6 Nov 2025 04:09:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.195.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762402198; cv=fail; b=T+Q78nOxMgiBXqm3dHw81jHSeCnjelnKvPXk0sScmO2Uo2cCQzM8JP67R9FDx8zA3LCXBgUyE5ECzr+N1PIWPlYhUTjhlzIcHXajAvEbtMIx/NuTJZmbH6o30q1xofCGmU3OHtuEkniXYfTGO0KTY1zzaBasrgyNgtyzeTkA3qs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762402198; c=relaxed/simple;
	bh=t+pOeJ++QJF1DQIxvph/8mk02gqnY+rWxHw51UrkPVk=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=o1iyHBiZNS7ef/wuqRrnDGj9j2Wg4hyP4mD0Vue7JIrCvM8o2hr3r3d0zmmRkE17JVHmqPEtjCyHMhuJltqOaeDTO+xWqtPI7jC3quck7A/9VP2/+c6KcQMywE8PyJC2ZBXukacM07GL9ruafW/ijy7LXZKTf3ub8dsfoJ7vmo4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=jxDSv3xe; arc=fail smtp.client-ip=40.93.195.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="jxDSv3xe"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=guN6kNCiq+62NGlrl8lfbyaTZenVaYX1Zznq4QNbGXCmBWr7mdSP6Lu/4+UQix13F10pPMeiadj9V5gTKToxXV33b8Af4XGhoYNKY8P0ixoV7sBZqITrpHcA5RlwAD/zfjJIf2Cf6dotGXOElc6Y48jYGGsnavKf1VT+mfl++8VbzZIIEhfBiB+tzZuaAErznlw56a/c8erO+K/2jZQ7eOnpSVlNOJMp7K1Ezyk+DgVTd9Sdbl1ueS86axv90IxnpDTNceejXS4bBDfJA2zfajiTr8L5nH8Vd7eCKgPJJFDjzSBJsL91XhmGREFJsx6uNO7vE4ALANMoR588OZ3v4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=t+pOeJ++QJF1DQIxvph/8mk02gqnY+rWxHw51UrkPVk=;
 b=ANPdcBM8mWwtzxuLbrf4PDUp+w9gn4wHXC/UKvJc/TcZKPdQmg7D2zrmjk5MuGyKzP4xvxaYZbs+MXYZirmWxJEk+Jbvew6dhEebDQlq5Bk9XtxeFrbbMgHtOcaHOBpciWuwl/6+uuMiTCKKiLxj3e5qoDWuU99+9nSsstEw9/2lLMuuv+AUPabUGpSZUjd6mG9i+tehNkZHqWvo2LmEpf4MFy/S7nNQdVRa4BacArpDIogQ96j6M4C8KyyunJ41FcsvlNGrbejr7nR7DuWDwSBfHAanyErp2lfEL1JzNk/xOYJkn7+OIV4rXEp2WmFeVGuk+9B3Nr6rEaR5J3otMQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=t+pOeJ++QJF1DQIxvph/8mk02gqnY+rWxHw51UrkPVk=;
 b=jxDSv3xecpQmiKLNIaNqK6j52bBVesIfRqRcUDLvbBAfyfDEBbiTjclX9nIMPCd9w0KM8lXfak6r5Q3ZkgrpQqFXGZNDDIWVMc/QY3RVnRet/N/xMpLM5eDa1ru/v0kAma2royd0XsVBp8GeFTrKfvJQx6XeNTtYSR/5XGz8fTJ6rNY5brVV3ufwNqCDQxLmRrRE3gJsUUFo/eHocYODD9jG99wjAXbx1P4byKx6kubRS4UluiZIqn4gImOTUaBAEnduGQ3BCbTCBCVUSEPl1vrQBemDJ9dy8Ya0e1mEji9eTg651cKCa+LRLxMaXZ65HBO+VEKPOSH78EAnqlmJ8Q==
Received: from LV3PR12MB9404.namprd12.prod.outlook.com (2603:10b6:408:219::9)
 by CH3PR12MB8075.namprd12.prod.outlook.com (2603:10b6:610:122::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.9; Thu, 6 Nov
 2025 04:09:51 +0000
Received: from LV3PR12MB9404.namprd12.prod.outlook.com
 ([fe80::57ac:82e6:1ec5:f40b]) by LV3PR12MB9404.namprd12.prod.outlook.com
 ([fe80::57ac:82e6:1ec5:f40b%5]) with mapi id 15.20.9275.015; Thu, 6 Nov 2025
 04:09:51 +0000
From: Chaitanya Kulkarni <chaitanyak@nvidia.com>
To: Keith Busch <kbusch@meta.com>
CC: Keith Busch <kbusch@kernel.org>, "linux-block@vger.kernel.org"
	<linux-block@vger.kernel.org>, "hans.holmberg@wdc.com"
	<hans.holmberg@wdc.com>, "axboe@kernel.dk" <axboe@kernel.dk>,
	"dlemoal@kernel.org" <dlemoal@kernel.org>, "hch@lst.de" <hch@lst.de>
Subject: Re: [PATCHv2 4/4] null_blk: allow byte aligned memory offsets
Thread-Topic: [PATCHv2 4/4] null_blk: allow byte aligned memory offsets
Thread-Index: AQHcTsBxiH7Q1ATMXk6iJaEuEeP6JbTlCOMA
Date: Thu, 6 Nov 2025 04:09:51 +0000
Message-ID: <17c3fa95-2f08-4f06-bcee-f5ebdf836235@nvidia.com>
References: <20251106015447.1372926-1-kbusch@meta.com>
 <20251106015447.1372926-5-kbusch@meta.com>
In-Reply-To: <20251106015447.1372926-5-kbusch@meta.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV3PR12MB9404:EE_|CH3PR12MB8075:EE_
x-ms-office365-filtering-correlation-id: 2b941065-d3ea-4992-65c9-08de1cea5544
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|10070799003|366016|1800799024|38070700021;
x-microsoft-antispam-message-info:
 =?utf-8?B?SFg2czZQaTRiZFRTWlFPZmRyNEJLWm95V2ZVYm53TG5lVEpxaFFWcmhmdm4v?=
 =?utf-8?B?M2NsLzJXUnN1eDAySGdqQis1d1pMQXA4SGVZTUVPZzBLZ1lwamh0UmN1QUdF?=
 =?utf-8?B?QzBnekNIQXRGWnFCbWpGZUFISmVJLzh2RHlzcFowek1IRmJneGVrR3hDVkth?=
 =?utf-8?B?N25XZlZKTmZ2WXhERUtRaHFlaWszR09sS3ZBeG90QTd4U2wveHpRUVkrYXpH?=
 =?utf-8?B?Q1V2UlRVNDY2a1R5Nkp3cEhUY2RWRndsNURpQjR3MG8zOVQwTWxQQytmTit6?=
 =?utf-8?B?OVNwRVUzWURHYlFkVUVtbXBCOHl3TGpYMVkva1RpYmRubllXYTVwM0YwT0JJ?=
 =?utf-8?B?ZVIrejN4bnN4eXBQQzl5dElrbHI2MlE0VWdRYU5PZVZ3djlGVE5SVDBYL01N?=
 =?utf-8?B?NkdnQnc5bEpZNnNHaUkzTVhyUkV0SU9ZbHowM1FYSkYvQXJWRURxRERpZWJy?=
 =?utf-8?B?M3BTV3N4akVJeTN6V3pCT2RyMEVFbXFoOUJFYUNFZWZLWDdRb2lMbm1KODkw?=
 =?utf-8?B?OUtuMnk0ckV4eGpMMkRhRjNwTlBKa1NFVXZ1K0NXYytnQysvTXhValM4UW1D?=
 =?utf-8?B?dGNONWlxMEFiV2R0RHlYZ2NiWG1hMGZ4RHVNTnZjaEZYZjRuSEkrbFcxWWpT?=
 =?utf-8?B?c1F1dVAraE5oNVlVcnpXOFFaU21iZk5VRnZPcXo2NnR0b25TblBtMWorbE8x?=
 =?utf-8?B?NXBuWWRNS3NrUFQrSDhkMGd2V3ZUTUxIOWpnbERRZ25ERnNjQjlVZXV2SmhV?=
 =?utf-8?B?cXJiaGNiSE1ST2xCN1ZvS21IdnpYdGYwSDdJNHNBNk0yNStaRTlMRTB5L2RE?=
 =?utf-8?B?NWp0c2ZBdUVIUUhoSmNNRXFuQnU4ZHc3WmljOWt2VnhNSVhaanhmTEVmMVcw?=
 =?utf-8?B?SjhpLzBTTTFsRHBnRHVNbVhVY25TU0pVVTlrNTBvUnE3TGp1RXNGVmIzL2xa?=
 =?utf-8?B?UHduVXNISzF2OG9KLzArZDhHWW9MemxhdUhPWEIwY3FIV3RQZExuOHJ6MGo0?=
 =?utf-8?B?ZmpwVnFsd09acnUrK2ZNSG5SUXA3QmMyY2lJNUtyTFBLNTdvWUltOGpIbWE1?=
 =?utf-8?B?cXVueDQrUEJLbzAxVTAzYWZMVjZzcUNqd1g0dzlMODFNRUdTNnlCTmZ1bEoy?=
 =?utf-8?B?cGpFRFd2MjE5RlZueVZpK0tlbm5TaDJJZ01lMzB3MjVpS0h6YW45QnczN3l5?=
 =?utf-8?B?c01oaUpMOStCUXNxd1dpbWdYek5DSHpXZkhYdktNcDNsU1VmMWVLeTdTVTdw?=
 =?utf-8?B?Q2tmZlJVdzZyMStnTUw3QVZNTzJDZEpoaHJDVHVXYS9Hd2s3R1RDVEFUMTJs?=
 =?utf-8?B?c29WVzVMZU84S1RoU1E3OFBhL0I0bThxSWswelRQQU9IdW9SZVlTcWNYK0cr?=
 =?utf-8?B?TFkwazVSSnBmRGcrVjVCSnF6K3JVbVk3R0tURnJnaVRiUDhURVhPYzNEalpO?=
 =?utf-8?B?Qm9iamlDQjJBZzNacG1NMGZUckQzOVpMQ1pLZjFUQkFmTU5BcGx1VkpaeUp5?=
 =?utf-8?B?ZlZRT2NJL2ViVTBPWlo3YWIwdDlNTFdtbnBRY2hWc0NIeWdlYkV1Vkptb3BY?=
 =?utf-8?B?bXJUMFQ4aGtkWGpuS21pZytFV2FLSEttcGJESjZkZkxob0phRk0vN2ZORGkw?=
 =?utf-8?B?WXBnUDhEK1VsenkremdKMVVMWUV2NkxtVXF2TmYrYkM1MHREcmtqZHZ6UDJD?=
 =?utf-8?B?UThlby92V1ZwQ3N5eDllUzFYUldYN3NsbjhGaVpxQzNFYlpxMVYvQnJKaHMy?=
 =?utf-8?B?bkkzbTQzdjFrNjQxNTdDSVEwVk8wOE1yODM5ZGYyNnQ5WVdiTXBpSVZ5Z3Z3?=
 =?utf-8?B?WW1xNURqZElWaS8wNFlmUVpaM01odG5vQkpkSTY4Tmhza2FPQ0ZmcEJtTEg2?=
 =?utf-8?B?djNmWFRpTEdMajNEQ2JZbmF4NkhXQytITVZadysxSmJvbEpoa3VlQUc3WDFW?=
 =?utf-8?B?T3ZvODBZN01nbGZYN2Nkc2djTDRiMlpISUhsY3VRU3FKYUxndUxZdzRqcDkw?=
 =?utf-8?B?ckh2MGFodnFOQnVZY2hIYjVCVFlabmRRNTZPSW1EeXNEVmZYTlRHYkh0U3hJ?=
 =?utf-8?Q?J+7WWv?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR12MB9404.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(10070799003)(366016)(1800799024)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?RjJVR2Q0YVdkM0pBVnNNTFNBN1RlY1FjQ2lnWC9ERHV5VWoxaG85cGI0R2hE?=
 =?utf-8?B?cXhhZDBjQ3NWOTZVUWN2dDlGdzFpY0w0S2Y5WTZtR1RSZGltck13Z1c4MlFw?=
 =?utf-8?B?YncwNkQ0VnhTaXIxRjdWRHdMekRUSnJXNzhwYUFHZjMvdG1qQjE0SjNjNXN5?=
 =?utf-8?B?U0VENE03YUYzc096eVVhZzJwSkppYTFhdEZNem55WncveUc2YlkxOHo1UWxX?=
 =?utf-8?B?TmxJUzl3dnNMT1JSUVhkTEEzbGczSnlETkxPYUNsb0d0RGczTW5qSkRDemJU?=
 =?utf-8?B?MnlNeElPaU9rem9QTGkzT3dvRGNZODR6eTNqZ1poZ0xtQkFNei9qRVhiQjUr?=
 =?utf-8?B?cTd3YUpVNUpWdEdtUXJZTzRPZjkyREpBRVY2SldEZkRUbE5HTzBNK1oxT2dY?=
 =?utf-8?B?TGlLT0VCWUpkN2NDM0VCL3Awa3MwczY3WHlEcVZ3RmFOdWlBNFk3WTd4K0dB?=
 =?utf-8?B?RzRsOHZETG4wcVJjUUVUeHFMV2ZKdHd4blhIdEpaemdCM2RseVpDVU8wdUkz?=
 =?utf-8?B?aU5KZFhvamt5NTFCK3UvMWp2N3h3YUdjMVBXRUhGbzAzZW5UOGhoQm4vRVhi?=
 =?utf-8?B?YWkvNGZOUWlzanN1UWpiSGpDNlFUamkyK0FDdERvZDhaUDFSemt0TG0rZlB6?=
 =?utf-8?B?YUdhQXJLakJieUdzWWdJU0gwNTNiUFAvWVNxcW5KQzR2MFAwVmVmYml0bEVY?=
 =?utf-8?B?UjBwVytUcjVuNVZCRzh1Z1FtZ3U0SmJ3UmlXRUN6RjMzSnlxSittUGQwL2lT?=
 =?utf-8?B?aytCTEpidlpzMkx2d1htaHJJNTRGQjhRVWxXUGc2SmF6Tm4zbUU3V29FaDl1?=
 =?utf-8?B?V01HNlJkM2N6cTk5c3hHbGpVRXFUOG5jbjBnNnh2YXB5K3VYOEtlYy9YMEFO?=
 =?utf-8?B?WWUrVFA0QTExMTZXVUJCTzNhckU0N09rUnhHZGFzKzNHTEt5bUhVSmNJVUlS?=
 =?utf-8?B?VnQ3QlhNOFVQNDNyZU40OWdKYWg4dU15bVhVaDR4KzdhTjk5a0ttWjFyU3lK?=
 =?utf-8?B?UnBlVW9FaTR2THRjaWxpMjRwbHlVR0dSdWtvZ1BlSlZZbkxXeFo1N2YzandM?=
 =?utf-8?B?OTNqeDYyYVVFaTN4eW44YU5XMlV1LzNMbnUzb3E0eVd5L0ZaOXd5clhxMUhE?=
 =?utf-8?B?Sm1OTHI3ZFFlV21RRUhJSTVxZitVTHZQRDh2b1R5SG1vK1g1ZjR1aGpST3ZB?=
 =?utf-8?B?aVFpQlVOZnRyZUFFQ2NPSmxZK0lMMHNUcWdLRmFHMTNFQVpndkoyZmZGSVF6?=
 =?utf-8?B?SVBxTm8xd3U5ZUFlRDJwNFhNRjlkTmZVNis2TnVDMEZDNlBNQVBTMTF0Zkxi?=
 =?utf-8?B?S1lLeEtXQnkzWHZZWXRJZ2NCRWRnT1pTY0NHblVBU2xkTTJtWmprNSs5Q0F4?=
 =?utf-8?B?TjdKdWdueUs1QWt2L0hMT09LMTYvdGQxcGNKUVY0Zkwxd2thQno4Wk5Ca3Rx?=
 =?utf-8?B?RU5KMStMV1pGWWVoYXVpSStTcU5MTDZYWkVpZmxLZW40TWFHRjBpeFpFK29Z?=
 =?utf-8?B?UG5DWFZHck1jSXBsK3BVaG9idkJzSVgzNEs2d1lXT0xhMFpYZUZ6di9MaDMz?=
 =?utf-8?B?cDRIVGxsNVIzSUk5YWxTbEl5dmJLL2R3V1R1bFo5WHg3Q2hBaUl0ZTBUdnFh?=
 =?utf-8?B?UzVUUVpBRzd3b2FFWTYyRWJSUHozQXVVUGxjMXBEVSttRmw0aWFpb2tQTThp?=
 =?utf-8?B?YzNZZmZxSHo2cWtMWFZpWGtIWkZvTkszZUppcE81a09lb2JFbmhFcEtLYmNs?=
 =?utf-8?B?WmlNOThKNTJ1Nk1CUlBNeDZCOUMxNjVqT0QvckFWOXNrdmQ3cnZEV00rWFJV?=
 =?utf-8?B?eHNITWkxZkptWEJ4RmRRL2lBaWpMZ2hHMmJmV3AwN05LMTJ6YVFxR3F3dE1a?=
 =?utf-8?B?U1ZBQTIrK3BiZytxV0t4VjFiblI0TXJUMy80dHkxOVR6US9FMThmVmtRQ3ov?=
 =?utf-8?B?NENFQUZwNDFxOEZBM2tQbmpMTWpEOHVzUndEbE9GUHErNlR4OGt6TzZHa2Zt?=
 =?utf-8?B?TDc2VUZod3k4Z1lESHBkaFNqZXQvdVdjT2dIVGFCOERiSmJvVVJlT1BGbHZV?=
 =?utf-8?B?eXE5WXFEYk1RckJhYkRMWFBkOTBHK0YwTEVvS1dqWkFXVzBzd1JUVk5ES25Z?=
 =?utf-8?B?QXVMN0ZJVlZGSzFtNG4rTmMvcnJraVVNdWwyQnI3WVVRYWk1VGwxeWlYS0Ey?=
 =?utf-8?Q?ITvR6blipJ7UuRp7RmGpznQ39NVCmH3wXfK7UcQUqFQ4?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <4997B87FE91EA2439FB07EBA167CE72A@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV3PR12MB9404.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2b941065-d3ea-4992-65c9-08de1cea5544
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Nov 2025 04:09:51.1058
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: /JeIUt7kzXqWIZa34P9cv7lw2ak6o6UYVuQpt8SRmTgxUlZjslnZDKmmmXTinlPGBjYKJDmK/xgANeMiP4mQXA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8075

T24gMTEvNS8yNSAxNzo1NCwgS2VpdGggQnVzY2ggd3JvdGU6DQo+IEZyb206IEtlaXRoIEJ1c2No
PGtidXNjaEBrZXJuZWwub3JnPg0KPg0KPiBBbGxvd2luZyBieXRlIGFsaWduZWQgbWVtb3J5IHBy
b3ZpZGVzIGEgbmljZSB0ZXN0aW5nIGdyb3VuZCBmb3INCj4gZGlyZWN0LWlvLg0KPg0KPiBTaWdu
ZWQtb2ZmLWJ5OiBLZWl0aCBCdXNjaDxrYnVzY2hAa2VybmVsLm9yZz4NCg0KDQpMb29rcyBnb29k
Lg0KDQpSZXZpZXdlZC1ieTogQ2hhaXRhbnlhIEt1bGthcm5pIDxrY2hAbnZpZGlhLmNvbT4NCg0K
LWNrDQoNCg0K

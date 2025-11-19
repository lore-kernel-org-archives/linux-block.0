Received: from esa2.hgst.iphmx.com (esa2.hgst.iphmx.com [68.232.143.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06E672DF12F
	for <linux-block@vger.kernel.org>; Wed, 19 Nov 2025 07:56:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=68.232.143.124
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763539001; cv=fail; b=W+Lxry8r5XfJTAfKyvuKGk+BRP7zbxfBBgg9dqzCsVcl4pMJJOYJq8854jBo/+fig089U1WQKSeF93P2vLckd3yArlZ4jn81ayHRoZbD5r0Zsl3x7dsv9sJJpzi6wV0qTxgOqU8ozQyoSJJA+BfjCIhURVSpCdX2cku/U3ibjwY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763539001; c=relaxed/simple;
	bh=UhSxlq6gqPNp14SM1n6IGk6G+ETsAdqWxc+Sjshljcs=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Q2AUWOQUMCXDEOil8+G59FdFk8Nuf4ZRzavAGdzhMg7eL4YYtlhUsGpwD0QKWXLvG+jCKCPaJouqofPYF/zU3obbKFMb8iaEekVs9ygquyY0Qfj4fMBhRmdFXPUj4FCTttM0PJBsJUaQ8Ok3S+afvrCxSJR+MtQkqqeJz70xLOk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=p0Hbg1FS; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=VVnwPCF+; arc=fail smtp.client-ip=68.232.143.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="p0Hbg1FS";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="VVnwPCF+"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1763538999; x=1795074999;
  h=from:to:subject:date:message-id:references:in-reply-to:
   content-id:content-transfer-encoding:mime-version;
  bh=UhSxlq6gqPNp14SM1n6IGk6G+ETsAdqWxc+Sjshljcs=;
  b=p0Hbg1FS3oHNpJWTnA7ecJXpTg7rLBnbNiqdYO9b11Vq5cI+7dSp0SOV
   EwWTGJZH7k05hBm+Bnbi0nPFNZdD510ao9MHPYVrH/kE9eprKMXOF4yPS
   V/kuJR3VlUsXPhS1aFYNIBAwZQFQ0ihbK64LFkSOjU8UHQ2pz2wxhF7ol
   DcQiPgupRGe+qc12wGd/nPPf8UYchYNR/bEWmzJS8xQS02ObXIAhAhXrh
   f6BdaUA7UwminLfe00V5M0YnPH9U4QISxqiCfEX8LOTgPuHCsLfYo1BZY
   NI1WDsajTMRTk19h00ZdP92bvZsLfnuclhjP1B4FUt6zRAAU/qDn8MJbz
   A==;
X-CSE-ConnectionGUID: SIDQftlmTKeOiEKRIJqmEg==
X-CSE-MsgGUID: txsZ5BLcSKKZjbgSY17OkA==
X-IronPort-AV: E=Sophos;i="6.19,315,1754928000"; 
   d="scan'208";a="136705688"
Received: from mail-southcentralusazon11013043.outbound.protection.outlook.com (HELO SA9PR02CU001.outbound.protection.outlook.com) ([40.93.196.43])
  by ob1.hgst.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 19 Nov 2025 15:56:31 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EOeqsuDBsUIVvw4GQOV1JZer0mlJMF1lZOaYOdp4aoxN9wVk/IHCaDGnyb7ziYdsxYsWMWC1cHmaTBADhBGnsJS4PDAsH3jMKPMqFOJbiDb9DPwEW6WF/4muDTx4d70PU1o4JLhxfQYW3DbcwnNalqM2vSHmDJSZDRK4HIjF9fJCzuih6Mo6OamEIp0e5DKh7JDnhzNbwlcWgySZBudviJUvY9dfwhQgjr88Iw0kCJp4qXfzBDXXTyNdnE6Y5SeCOOu3j8QajI9cMh20nABsaqlWmiVKOeRixfIBrbcmxlAWtgt8/VH/0MkhCH4oxaO6YlGRnvGp2KjkGcCRwUMSEw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UhSxlq6gqPNp14SM1n6IGk6G+ETsAdqWxc+Sjshljcs=;
 b=ONAy4EvtaECJ+nWaB1CF1HnD2NTpqMNq5dH2w8IsuUNo7G7n4/YHHzutQzLhQ8FUGcLqKXU3yxzdAUd9qq4g7ZjFklxAfR8i+Y/MZafFJCgUFlD3Xq3V8wsMJR8Z9VUN62hMrL3XX5ihlnKcYtCIQCAJCPNq+DG16HS0yEw3moH1OnQZPGlSFftmNymkzYDE1Vd6wRA3mkNHgwgWrMNA8fgVXphRmVoGl0CKjD6Qg3UZk96/sv209Sa+AWoRFisRwsU2W3U0xlGUsDi2mmZkQ2sRquwXo8CWfaXR6InjpOndb+p7gBMkTvPLI/Jc8YYf7L8EDXOIcJf7lcKsi+HNWQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UhSxlq6gqPNp14SM1n6IGk6G+ETsAdqWxc+Sjshljcs=;
 b=VVnwPCF+8AZfc0NSGOKwLDEHw7n1vO9qsltSQoqIdh+FLNsBWfLkw48i4P+dVOyxm1jnvHQaIh6fp7exC40NP8O31Q0enx7piS5VjtmkrtE+O0iQikw2EJngCFFyvCCyxgaabogBgavYVlRK/UmNh9oCES4mq8nW8yBpvmb8o/c=
Received: from SA0PR04MB7418.namprd04.prod.outlook.com (2603:10b6:806:e7::18)
 by CH3PR04MB8925.namprd04.prod.outlook.com (2603:10b6:610:1a6::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.21; Wed, 19 Nov
 2025 07:56:30 +0000
Received: from SA0PR04MB7418.namprd04.prod.outlook.com
 ([fe80::17f4:5aba:f655:afe9]) by SA0PR04MB7418.namprd04.prod.outlook.com
 ([fe80::17f4:5aba:f655:afe9%3]) with mapi id 15.20.9320.021; Wed, 19 Nov 2025
 07:56:30 +0000
From: Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To: Damien Le Moal <dlemoal@kernel.org>, Jens Axboe <axboe@kernel.dk>,
	"linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Subject: Re: [PATCH 1/2] MAINTAINERS: add missing block layer user API header
 files
Thread-Topic: [PATCH 1/2] MAINTAINERS: add missing block layer user API header
 files
Thread-Index: AQHcWQGKG34lzybBW0yFL9Rd5yt1w7T5ogQA
Date: Wed, 19 Nov 2025 07:56:30 +0000
Message-ID: <1bb72fb2-fd97-4d00-92a1-e4d7ade5a1f0@wdc.com>
References: <20251119030220.1611413-1-dlemoal@kernel.org>
 <20251119030220.1611413-2-dlemoal@kernel.org>
In-Reply-To: <20251119030220.1611413-2-dlemoal@kernel.org>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA0PR04MB7418:EE_|CH3PR04MB8925:EE_
x-ms-office365-filtering-correlation-id: 9d1653f8-5fc1-4a8d-d2fb-08de27412687
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|19092799006|10070799003|376014|1800799024|366016|38070700021;
x-microsoft-antispam-message-info:
 =?utf-8?B?N21TR05FOGdtVkdlbytoSzIwYjducmdQb0V4VEM4TFBGVHJmWk0rNzV5VWVV?=
 =?utf-8?B?MFUwelRrNklpYnZtTVRQNGhOYzFHbE9MUWViN29rS3JlOEpLRmVlUExRWDFT?=
 =?utf-8?B?NEZoNUdVRHlJT1EyVEdoVW0xZE5Oc1k1SWF6TTF3cHlONExwRG5NT2NsZnZM?=
 =?utf-8?B?T2pyTzl3a0phQzJ0dGprSnd1bUJ3dDVuMHY5aFpvZXJFZG1MMEdzVWEzdlhD?=
 =?utf-8?B?dWRydlRKdGN1N21hNzV2cUtrTFZNZGNnd20rUC9KMmRTMktwemhRLzFIYjVq?=
 =?utf-8?B?Wk5SWG5keUR4TjNwcmVrZUpEYm1vckt4aE44QUwwa3ZJdzJadUt2ek5CSFAy?=
 =?utf-8?B?Q3FuQnRNWXc0TXA5L1VqU0UrajdmV0lmaTFnNm44YmJWbVNGRnZvSEpKMmtq?=
 =?utf-8?B?dWozNndOSDl1NDdtRkhtY1g0alhoRmkraXFIWHdtRUE2YzVrU3BiYmtDOGw0?=
 =?utf-8?B?ZkhGTGlHNGcyK3lhZEJSdkV3T281VUp0TFpZN3hUQXJYQkhKT2o3UXg1dXFw?=
 =?utf-8?B?dm5URXd0R1M4V0dxUk5ISFJLVGlhYmVlYWljNDVlaGZSbnFzVm12REdPdUc3?=
 =?utf-8?B?ZUgyZVlQNTRONElvTk5PYWRFbTJYay9za1JGYmcrMHhHOGllWEQ0RVNjZHRC?=
 =?utf-8?B?OFFVNE9TOHJFL3IrSVFxMG56NUtqZnFVRThTaUV0eUQ3SjVKb202UzlWbXg5?=
 =?utf-8?B?cEdiU2gzbFlZY2NWTm4rMTVoclVLVmV4OUlLenNnSHliRFgxamdkZFF3UEwz?=
 =?utf-8?B?b04rMmcxRjA0VUZWT2srQkRpRjN3NXBWR0hQNURnK2o1SUJ2dHdTK2pQRElS?=
 =?utf-8?B?dmJ3S1piQlVjbXkzS3lua0VqbUtmb1NmV2V6RjB2U0FPOXF6WTNVWjNkOUVH?=
 =?utf-8?B?VHJ4aG94YklZd0pBZTFDNHZ2UVIxYi8vWnZIZ1MrbVdFK2xaZTFSd0pKVE5z?=
 =?utf-8?B?SDRPdU5yQlljdkZYNUJmdjJnSFVNbm9nMnlzRnp5a2ozNEgvMjRrZkNneHJ6?=
 =?utf-8?B?ZDFmUmdNQ3lEVTkxb3V4TCtNckVJVVNsWGZ5RlV5cmFuM2dVZFkwRENmWGFQ?=
 =?utf-8?B?alpkYXdXZm5SUVQ4dHBxbnlBalU2Q1NNOWJrc0RqNjMvYk5FcUt6ejh3SVNX?=
 =?utf-8?B?ckR0SUlac0l2SFBsR0dQaEtIMWVrOTNOQzhkTTFqMFcrb0p2Z1d4aWk4R0xp?=
 =?utf-8?B?YWFENjI0cENNbVp4TC93aGJGVUJRVkFMd1FzSVpXdEJTczlkYU5HNTJGQXVH?=
 =?utf-8?B?dkhSNzFsTUtMYnc0VUFPb210WDYzWk9OS29DTXBmWVVFd2VncW1PTlFQUWpm?=
 =?utf-8?B?L0JOdVJsTEdMRVhSTUZ6cmhlNHFJUEhiMjIwdFZOVjZnUStSeTY2SGZaOVow?=
 =?utf-8?B?UUcyenlyRDhURENteU9iMjh0NXJoa3g4T294Vm1MRkh1VmFwN1VqMXJCbHVP?=
 =?utf-8?B?UnFsVW5BQ2dDTUwwNmpQNjMrN0hOMFRWVFhoN1BOZlRqVzAxbTAydVhVQURV?=
 =?utf-8?B?Wk5CakJSbXo2U3BLR1RVZFdIT05acXZlUkUxR2oyZnVNSUFqKzBWc0J0NmEr?=
 =?utf-8?B?QTVYRW1YL2Z0RFNPSTlzWmVpdU9qcDErdS92QnlHMjdrRi85clpYUUV3L2Uw?=
 =?utf-8?B?a01YbkNsa3RKSEJNOGdFQ3V4VGo2TFRid2dLYXdyUkhxT01ncCtVYTBiSGQ4?=
 =?utf-8?B?ZlJZRTByTTQrOU9rVytrdVdkemw1OFFmNUJVOVFpNDh1ZzdpV2dSY04zVlJz?=
 =?utf-8?B?Q3FTdUFNUlRBRTY3Q1MrTXpGNTNLdUhPVUZSbGFRTVF2NnNWVDhVNXc5TlNJ?=
 =?utf-8?B?enNtdjVIdUtyNUluYkZXTFQxNGFkZi82NENMcGQzNzhkZEtkbmFCOXZDMFZQ?=
 =?utf-8?B?TDNPYlRJcklFREhWK05VVXE1L0N0ell0MHVjSzR3WHQwQi9TOXRwYXNKVjN0?=
 =?utf-8?B?Kzg1UGdVamwwRmJKSnd5WVVZZ1g5aC9rTDl0ck1wSHRzeG1qWThoSXBUdDFR?=
 =?utf-8?B?bWdtRWIrcDJMVENMbUJRWlBUUGVaOU1XTzhYenlQdTY4QWIzdjNiNmZQSEs0?=
 =?utf-8?Q?dhrtl/?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA0PR04MB7418.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(10070799003)(376014)(1800799024)(366016)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?ME1uZ1hzY0pobllVUWNUOFA3WW9zb0ZwSWVyeFQ1R1JnRlRCTFU0dm9rK3RP?=
 =?utf-8?B?SC9BV25CZTdHbWtXbDdMSjBrS0RDcDVLbnpEWjM3ZWQ2Zy9FTzNxdWN1ZnFC?=
 =?utf-8?B?N0hLUjlNaUE4UWlIRlYxQkRhYXk4eTVjdzIvT3EyWDg5L09Wcncxb29iN0N5?=
 =?utf-8?B?RVBQUVU0ajczNVlWdmFWWjhyUWhBamNJZ3FEb0h1L0wwVThOekhlcnNiL2d2?=
 =?utf-8?B?UGM0WG1UMC84ZjZNUXg0ZStGSWJyS3hJbnFzOU5CcXRQdndCaE5kYkZPOXQy?=
 =?utf-8?B?UTgzbkN0VlVBL1JIN1hlZnh6b0dnWUdRSUpwY3VRditKeVZFL1k3K2VqY05F?=
 =?utf-8?B?WklNSktrdFVlYlBoNnRhdGI1dnVCK0tmNzRjdEl0SHJCb0tDdmRqUTBROWxZ?=
 =?utf-8?B?WWw4ZlhTQU9JeXF5VE9CcW40aXRMczRFcU1iaHVROWZzRVBoZWpiQWdBTUda?=
 =?utf-8?B?MmFLa0ZUK29BVDR5YWF5T2M0N1Z5Y0x5ekROVk82SEtKQzhsbUtpNHpNTkYr?=
 =?utf-8?B?NW5icVJ5S3p3cXBzR2hvY0xOalVhcmhTMzl2RkZyZjdvRGI5VTNEbjZQaW1J?=
 =?utf-8?B?MklEa29CdkRBTkM2Q3JqWDhBQW1XeG9NcTA4K2FyejE4YmlmbVlLWEgvTG04?=
 =?utf-8?B?T0NPWmJTVHMyeHpPVk1NT3VObDR5cmh5VnViMXVFRm9hdTJEYTBuTHVQRSs2?=
 =?utf-8?B?bmprOG84UHBoeFludlRZYWJqSm40TWlmNWhrcHlzM3VSYmR1NTFlWXlHbWlC?=
 =?utf-8?B?SjVVYXc3K3o2aHNrYnVmdXpXOEtLSzdTTGU3K0VJWlZwVmNEYXljRm9zY3Jz?=
 =?utf-8?B?R0NUZk9zajFwUEMwV3g5NGV2SFRvRy9HZTh5dzlPMG9oNit6aHppUG1pRVA4?=
 =?utf-8?B?eXlqZko5NWx4UStRQURqUVkzbFJWNzUwWEYramlNRUhwKzlmRHo3UHdvSlNT?=
 =?utf-8?B?WHcvQzdSZU9aWmxIdm1FU3BQTG9FMlplcit3bWRia2NBNW5uSllLb2NOeXpX?=
 =?utf-8?B?bWQ2Y0RsdkpGVEo0a0lXNGxqWm4va1NnOERxc1czVmpqUUtaR1EvNDVYNklB?=
 =?utf-8?B?RkJtbDBjbTRXWGV5cC9MYlRUL2pEaWo4ZHBhSm5uZ2plbDRqYkZkY0NMZjBE?=
 =?utf-8?B?cHpZT0tJNjJray9DMXM5WFRQWThGMFcxT2txRHpnc3NEVDVQYXptZG9ielpi?=
 =?utf-8?B?S05PNm0wMWoxMTk5SVhiVVhySC90VmI1bnZtQUVrcEdCZW0wbldlZXJQRm9Z?=
 =?utf-8?B?WDEzK0o0bzlzYlNaeUNhLzhzMjJkU2RyZU5NOTB3ZGRjM3hOQ1FLNzhKUjhJ?=
 =?utf-8?B?bmp5T3RkZmxPcmpuR1BWRjNoYWR2RUE5R2R5WmU2YVRsOUgwa3k2ZFlKRFA4?=
 =?utf-8?B?Vi85L0lWMnJrU3VUMlNOVkxBZHdrc1FRSnk1NjRJQTZJcDNOdEx4UnhUT3BI?=
 =?utf-8?B?azBJL1B6MmptWXg4SHNuVUZsOGpjRXRYa2hDY3V1WE9CL2NDYWxYbkRZaGhz?=
 =?utf-8?B?a28rV285OWs2c0syNUhsNHRvb2xISGxEd3pZMGF2Q1VmSHVyM0pEd0d3aHpa?=
 =?utf-8?B?RGJSdDNnNng3MFZYRmcxYnRuMzYxcm9SY1BrK1M2aWFvaGNYL3lrR1FiWktT?=
 =?utf-8?B?UGt4UzJHVU1lekJZbkk5MXJCUC9tQUthNjhNOEMzNmdJTWVWZk1GOHZGZ1BW?=
 =?utf-8?B?eDV2OGtXT2M0YitwRGtCN2xHcXBjdVoyY09tOEQ3bU56cFRWVFBMVGVmZ0ZW?=
 =?utf-8?B?NlNRdW92VGVvZlV4ckxHRFlJSy9BQ0FFN2owQlR2Ukh2Sit3eVYvNnJqcFoy?=
 =?utf-8?B?aHNOVFEyUGwxSjJGQjdUNjFzWDF5NTZWK1o5MlB0U1RucEE3bjlPbTZEY3lh?=
 =?utf-8?B?YnFDZmRFT0sybHNMbWFYNnFTT3drYndIamhLNFBVY0k1VDUvRWxsYzVIb0tC?=
 =?utf-8?B?Smg0SUZuNTczTjRMRk8wKzlQV0ZyWXBZRW5zcThLWjRtZllycjhiM3VROGlI?=
 =?utf-8?B?RmM3eWo5alRBWG5lSGNHK25DZjM3OHVqaDVzSzFubDRkQUgwRGc3bmNwOEJN?=
 =?utf-8?B?bDBxMS9kZXJMZ3BJMGtmeUNaQUFiT2xWL2owNjl0V0pqZHNMa3hyWVRqeHBt?=
 =?utf-8?B?blFmNXJoVmZPV0pEUVRjRlRaTEQxbDZUVCtxaGFMMEpSNkk4ejZVV0lJbEpC?=
 =?utf-8?B?UE5NaXJmbjYvSnBSWk5CVWRLZFgvNjlqbVI5Q0R1bFIybjVZVkhnOE45cm12?=
 =?utf-8?B?WmFsRmQwcnE1MFVFRSthSkVDSG1BPT0=?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <07051B198B7E4A45AE177BBDBAE56B0A@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	wgaWT1Xta6YZpar++B1hZAmqdPfyA6Gs8APcIjtgL7kIDLb/k0OqMnEXDCY37iTst5voPXvm4ozf8mubC45jZAbjGvM1cQ0dFRtkJ99Izyp1jixKJ+/+aG/IVAxPtBGHqiFPY1JlfkAZzI1GcIEYLHSGMNQ0fZrGuGo4qWca+t9xYIbegOofkeUmTRnOxqMPEpHRuhfjzYvoGHegKtyWtZ1xvL4B8vNYcmqTIhAbJv39rxiWuCD5iccXiVoQ9hp76lX233QxxrUa3TsO74XLnQezk12KLi+862ljfu37rFVbXativElBQ5UAMweLB5YDwezFEZDa/4V9Wq+bNp52hgwbQNGKjTE/3qTg3dRGY4IThia3H78nw1lfKX7Zry0SfMs84grOvDczhLrQ20obnvu76ZSgbZyaq7L29R7pM8zl7A4RwJKqZweINbOr5VsC58bOKXs4KLKmkfTC7qvl4N2kVm1Ro5PQg7K019mjnbk8dP1EWkKhq/mj3GfWusz7gyLmim+Wl9xmf94TKg1mtQqvddQltchZDC851+z+Ny8U5nPKkWX6H8Dd1d2DoyUUzcqF466btyiChw9Md8J3AuQDY6fOd81eOpaYU2dbrhNwx1GYZYiUY2iWx4dxKNj/
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA0PR04MB7418.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9d1653f8-5fc1-4a8d-d2fb-08de27412687
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Nov 2025 07:56:30.5449
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: KD1cN8gfohnCZL9XWOb4ZQhBYIJaBFmcWrpUgGdPDzHqW22/lHhkS0jwRMIENob7HKEWii6e5NulFcMYcbvem0RouDf5p2Tf6JGmuHkWssY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR04MB8925

T24gMTEvMTkvMjUgNDowNiBBTSwgRGFtaWVuIExlIE1vYWwgd3JvdGU6DQo+IGxpc3Qgb2YgbWF0
Y2hpbmcgZmlsZSBwYXR0ZXJucyBmb3IgSmVuJ3MgYmxvY2sgbGF5ZXIgZW50cnkuDQoNCkplbnMn
DQoNCg0KT3RoZXJ3aXNlLA0KDQpSZXZpZXdlZC1ieTogSm9oYW5uZXMgVGh1bXNoaXJuIDxqb2hh
bm5lcy50aHVtc2hpcm5Ad2RjLmNvbT4NCg0K

Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2069.outbound.protection.outlook.com [40.107.101.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F174026AF6;
	Mon, 10 Jun 2024 18:32:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.101.69
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718044332; cv=fail; b=C9X0D24YTjwTwocTBxlaEKYuvzbofRyPKOr4+y9xJMRCE0ZWDJa4ZNMFEMSUjsba4uLNBr2GQNF7YoXhWwfjz5I+Jbfuwtx7IcrQRr4O4vQot3VF9xaZ4lxGTXFmnRWrCtfSxDJpwyIU8XFG21nm94Wy+rtVQYG3SGaP/R9BSWY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718044332; c=relaxed/simple;
	bh=g70rMSIi1JFeN5QljCL08QN9/gHaTFkPhNgRS464mQ0=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=cxXmHukEapwHbo6H1NhghcViSP0tQgydYOJqkTESAGkkMWuGmOSXIr/6ktxWyj8u2ysGLazvdjpVHceL3EDdcRdTPtxEN+e7SbS8A5ZpS5MuHspoiD9w6PUKJF5B4CLk1yUtcnNwkLGL5pnWMFzPczxLKBKIVCQYPDrzCy1cZwA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=bM5PLeQS; arc=fail smtp.client-ip=40.107.101.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="bM5PLeQS"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=j/brgVfnLkd8sSdZd3FxDLvtwcs60FWV/CcpULPa4uzvvR+al2p+EXEDWvSukbnfJlajT4Eo4kOiN1Ji00/V/QOgISU8PNvQsisL+o7cDiJRUx/dPM0to8cdovUPHtBe1cLgeTdrLZwUYSrbrJ4ah8zWQh3Ovg5u9XUnZ1N8DXLFIYYp3PPxqQqjFjr9hJIznR6odG/jH2s5SdDZhzFJLNLoRJxweH6dHVfStb4zUK1e4cdK2YvoCioX81dCwlIP0AFRFst/cH/kvxBrqmMKvXPErQzaEzKXP6PRstItoIJY3Gi/oip8AIItLe3JRgVKtCEGfXbV6wa2TO84mIKv7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=g70rMSIi1JFeN5QljCL08QN9/gHaTFkPhNgRS464mQ0=;
 b=GJchLj60Qtiv7aRw994TvSbQDB7o5940asG1hx7rm5PWdyVSYvaAKJSXyNzw+6np5AcFldw7juLoK7EBWjQjOXqznLhn2s+ImMW0HPvs16+3SPvCAsp3Do8tgT9GzA6kmiE+LMBz28/nY/Edhjz+BsThmJs6oBa/mVJ6ybQuZBJsAmr1ubwRWa2AG9Ls9oaKM3a5HP/ICXs/7Sg139LSSadAgSr7SkJHP6fPl970vOxWU2eAOOHW3lS6qaQ3y4+JIrDzyyvwsb+9BRdFM+lKim9V1wGRWYE/ku1gUTFilnAKsAooCfMDZwEpv+wVDKVIqZ0xhE9jVzDzsDYouSgnPQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=g70rMSIi1JFeN5QljCL08QN9/gHaTFkPhNgRS464mQ0=;
 b=bM5PLeQS/rc76hzIEgZpumheiB2wdVTVyfp3HN9fYp1eRiVshcx+CEV/KFC1UY4IuTWP3daEsS4eFDKayGfLFHZGEDNYEe5dsvccDHaYazgw7NwTRnzLwKLEIsTfuMfn1cFtAl6C+OdWj93NOQYN34b09/CxK941EuiZsB0os9fiFOFs0sN0UduLQVF5Ej3W46Bf4yabpTqxzAGuSLl65CjSt1a/KY/8QWSrjoDaKYCA7yrjTU5jbfTGrOlguk10HeMcoUAdVGMIdChhZihPSYpimj0zNPXcy2OLn3k1EF2FDUWrzu4Be0Lim5aRLEy7eti0xDjc0PjfskKuewkVvw==
Received: from LV3PR12MB9404.namprd12.prod.outlook.com (2603:10b6:408:219::9)
 by LV3PR12MB9095.namprd12.prod.outlook.com (2603:10b6:408:1a6::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.36; Mon, 10 Jun
 2024 18:32:03 +0000
Received: from LV3PR12MB9404.namprd12.prod.outlook.com
 ([fe80::57ac:82e6:1ec5:f40b]) by LV3PR12MB9404.namprd12.prod.outlook.com
 ([fe80::57ac:82e6:1ec5:f40b%5]) with mapi id 15.20.7633.036; Mon, 10 Jun 2024
 18:32:02 +0000
From: Chaitanya Kulkarni <chaitanyak@nvidia.com>
To: Venkat Rao Bagalkote <venkat88@linux.vnet.ibm.com>
CC: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
	"sachinp@linux.vnet.com" <sachinp@linux.vnet.com>, "kbusch@kernel.org"
	<kbusch@kernel.org>, "sagi@grimberg.me" <sagi@grimberg.me>
Subject: Re: Kernel OOPS while creating a NVMe Namespace
Thread-Topic: Kernel OOPS while creating a NVMe Namespace
Thread-Index: AQHauwsHPSBODhXG30iTeBpCs6o+kbHBUuIA
Date: Mon, 10 Jun 2024 18:32:02 +0000
Message-ID: <34d5aae8-3a90-433d-87d8-75eedb1d18db@nvidia.com>
References: <2312e6c3-a069-4388-a863-df7e261b9d70@linux.vnet.ibm.com>
In-Reply-To: <2312e6c3-a069-4388-a863-df7e261b9d70@linux.vnet.ibm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV3PR12MB9404:EE_|LV3PR12MB9095:EE_
x-ms-office365-filtering-correlation-id: ca8f069d-6fb5-4892-a156-08dc897b9f2c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230031|366007|376005|1800799015|38070700009;
x-microsoft-antispam-message-info:
 =?utf-8?B?WUdjd21SMFlGTVI5bEJ5cSt1SHhLb3dUM3lHOWFNSlg3SlM5c2dlVUZWZGVO?=
 =?utf-8?B?WFRqMUF5TzJadGlpcEVYSXd2ZEpLaUY3Z3RWTlRwWVorSzhYdDJRV2wxK0pZ?=
 =?utf-8?B?RUdUWTdKSDA0M2hZenpydytvbTJmazZqeG9UaFpMZm5qNVhZd3J6OW5Fdm9t?=
 =?utf-8?B?QjlWRUVtQ3ZzWG1HN2JsUnJvUlZreUZIK3FWbjgxL0g2ekJ3R2ZQMVVucVRB?=
 =?utf-8?B?QWxDb0FzcTRhTFhWM3NUWGlnS2RhUG05VmcyQkt3aUh6b1dYcU53VDF3cllv?=
 =?utf-8?B?R29OcHFSRmdpdVEwRDZlQ0VlNDhXb2c3TTY0TFBQRlp4RkFTZkZXQ3R3azdP?=
 =?utf-8?B?bG9TQkZ3ZGoxamVIVTk1dkh2VUN2eUlkVXF0ckhNT0RxRUxQR3dUdjV5ZXU1?=
 =?utf-8?B?V3NKUXJleWU2Y2N3bGRtUUZZdXVobkZIbC9BUHpPbG41RXB5VGlmdnFIK1Ra?=
 =?utf-8?B?TldoTGZyOEprTk9Qb1dXK1duQ0lLWUdVUzdMNjg5WGlGMzQ1dEZGOTlRK3VP?=
 =?utf-8?B?R0hjMDEwOStneVk2SmFtMk92b01HTnhEMU5pOUtRc2NvN0RRa2doS09hYU52?=
 =?utf-8?B?ek5Yams3S01YZUQwQnNZOGlwYzByZk5vcHRRSFIrYVl4RUlRTUlYSi84Tnh3?=
 =?utf-8?B?bk95VElaZmJtdkorVmlkYk5pQ05oUWxFcU5CNFplcC8wVHRQQVo2TDQ3ekpw?=
 =?utf-8?B?angyMlVObGloRHpOa1ZVR2hPdG5GTmZvZGtWSEw4R2VjU1JFV2lIb0VSUnNp?=
 =?utf-8?B?dG40NFVwZWtoekhBc3U1bTIzR0h2bVNRalJUOEo0RVRXWmZRUXZ3VEJDVFZ2?=
 =?utf-8?B?elFNVk84TlJOL2lHVlQxdjdMMG1NTTlHVFNIaUdCSzYwYmtwbE11MG9uMi9n?=
 =?utf-8?B?T0FZRElmMWM2QU9XNEVCWWlMRERXYXd3RUh2LzJvTm8xUDhqZEhTR3pkSmd4?=
 =?utf-8?B?enhDRS8yZW42ODFsdXpueEoxV0tDZE1GVlNMSEJKU2E1QzN1aEE1czU3U2dC?=
 =?utf-8?B?L2RRUDROcExEOUtTWTJYUG5Cb1ZpQzRNMEJCTnZXdkRoNUNiQXVtYW0zMUx0?=
 =?utf-8?B?eVpud2FUVzBTQXRpN3gydDgyNFVFVWRVZkk3ajk5dWl4NXdrcGJCU2RCRHY0?=
 =?utf-8?B?cEdxVmp2RzJQT1pwaXNPeUZUSEJqRjM0cEpUVjZ6Q2tTdVZKUFBQc0VCRkhj?=
 =?utf-8?B?TEgwOFB0MDQvRC9XdVQ1OUZYczBIY0hnbFhoOUhYVHZVWURqSTJRV0xGNE10?=
 =?utf-8?B?L0ZINUVnaWVXOXhXS0xmblBXSzN6RkRKK0FMTFhBMjE1bzllUFZNa29teVpW?=
 =?utf-8?B?Z0pMb2xpLzRSRnpZcExTaWlITG83VzlxcFRTb3ZmQWJ5UHozOWV0eEEvZ3VM?=
 =?utf-8?B?Wjh1S3c0eFVrdWRXOEROSnJubVQ0eExyZEU2eXhGTFdlNFg5WWNxMmxWV1F3?=
 =?utf-8?B?Z0V6M0pLUEczajZKRk9LWW1sMlVOdlNRcE0wRXE0WG5JVk13ZEcyYUt5Nmc3?=
 =?utf-8?B?bERhbXJPSXR2VXVtYVpEKzNZaEtkS0Q2cXdmMDk1QnYwVko4NDBzQjdxRE9n?=
 =?utf-8?B?U3dUdzg4U2lncks1aStRRzZmMGJYeG9lOWtBOEE5clU5dVMyTlBzNk9kLzZr?=
 =?utf-8?B?ZUczYm1NNXFDN3p2L3BFMGVEb0NRbjRab0JLR3lwblI1L1I3MTBpaHcvdE5x?=
 =?utf-8?B?U3hTdytWNy9zSTRzNFZBcDVBcUppSlpwOE5YaXE1dVlnRVl5YVlMdEduVUV3?=
 =?utf-8?B?TmRwUEpEeEU3QUpzMXBRY0tlRE41cjVub0w5VE1FMEc4YkZMTjZleElVUjdY?=
 =?utf-8?Q?MMqvxz901z9WX6y2rlz5gjLqktdZFg7D8IRE4=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR12MB9404.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(376005)(1800799015)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?QW1GRGNiUlhFajA5SHcrVE5Hc3pUOCtyZGRDcVZiV0VEYnpyZ3E3OWtmSmQx?=
 =?utf-8?B?QXh1aytHbGR3M1g5RDRNQXhCYUd4RTQ4MVR6YitBc1p5OXY2bUxPcmE0YXpu?=
 =?utf-8?B?THd1d1BQZEp3RElpb3h0djlWMmdiTTI0cGFndWN4UEVVRnJTNGhwUlZEclRz?=
 =?utf-8?B?djAybzhTaGpSMmxxazNDTDd0SS9WbU5hS2sveGdFN2Y1Y3grTVpqNHJMV0kw?=
 =?utf-8?B?MUdxTGU5b3I2aHN3a01XN0Z3NlBTYkhPMEt1VnNuQTJEeENXZHJVY3lsTXNP?=
 =?utf-8?B?aXh1RU9OMFVpZjdEMzdLQWVmdmtlenhsN1hZU3M1Y1g2MUlQQlVDKzl6SnZo?=
 =?utf-8?B?Qm5tNjVONkpHbmVtcVBwWnNFb1Vib2krblJrTWcwcDB2UUZSclF2aExVR2xI?=
 =?utf-8?B?VE1oVzltVDd1dzkrM3hxT1pzSTNYN0tMTFJMZktqRWNHYXRPMzBVazB5aWEw?=
 =?utf-8?B?alU4bjBWRFBjSXhwWVU3Z3JCUzZXbi9weVZSL3FTck41UEVpb3J3N0JLOHdO?=
 =?utf-8?B?OEJuVnd1bVhsYi9jY2VNMVlmQXlPWkIyMGJhQmJmNTVNc2QxdGpxOWdRd3NC?=
 =?utf-8?B?dlEwSXJUWURjbFFhQXp3cU9oMDdWZDRibzl1aklkSHNNK3d1ZjhvbzRMdnli?=
 =?utf-8?B?S2tNbjdKSExXbVplN09UZEM2QURIcTM0R2VFYlFDY0c2cnpQcjRrMEpxaWNL?=
 =?utf-8?B?T3pHUzRrY0pQSXRWWEZTblZCYVZUdENmMTY2WnE1eUpUK1kzUS9NbVI2cDVn?=
 =?utf-8?B?eTBjaDBPaUxYT2JId0MreUhtWGZyTUhmdW0welBFSzR0R2dNR3Z4ejlhcDdn?=
 =?utf-8?B?ZXRlYnYxeW56MTM2MUhIcHJpeUl1akk0eHNocVc2anVxbHpjVm4xaHE4d3hB?=
 =?utf-8?B?RGlBeTNxNTY3SGFXWXNtZkhIRzExYkdUVUxQYlRvUEd1Wm1WMUFmcHdGeTBm?=
 =?utf-8?B?T0t5M2JSUkR3RTFUbmxxZzhrTE96KytGaVFDQngyUEFXSElPSmgxNElPWUQx?=
 =?utf-8?B?a0pHakhiQ0RZTUc4em11dFNxcEtXdjY5MVRVZUE3QVR2TXllY2FWdnJxN1Zx?=
 =?utf-8?B?WE01V2tlWnlSWDdwVldBUWlyb3hqZWZPak5nTVJ2ZkpXZUZNMFJXcStKR1ZB?=
 =?utf-8?B?ZFNJOUNMMTJRRDVtYno3VTdVMEFTeiswcWMzWUs0QjBtbXgyeE1kQ3dzRWYw?=
 =?utf-8?B?bkFpK3I4S1ZRcXdXbzJPMEJSQmFkbDBMaUZ5T3hVd2tvZXQ2RytuOEtoa3dF?=
 =?utf-8?B?MXRRTGRhUVFib0hQRWZkelRNcDBrcHFHbEg5bkczRHFXMUUrZmRGdFBRUUIy?=
 =?utf-8?B?UlJIblBJK0xhVlhHRlFIMXRRMXhaZW9tUWVCeDNUQTlTS1pQRCtKTGIzMWJi?=
 =?utf-8?B?Z1FJOWJzS0JRZG41SnM5c2JaNmZLUkJzK3ZqUEE5VDV0TnlwSXp5VEhncElY?=
 =?utf-8?B?bnJOUjhEektWUnBVRGNqZG5zYVl6M1UyS3ZOcDRacFNnUGJYRWd6all5RG0r?=
 =?utf-8?B?WXNyQVRod04xRXNRSkR0ZkpYN0ZjK1VxRkhLT2w4Z1R0VjJJaDErRGl2TDla?=
 =?utf-8?B?dExoNm82QnVzWkxHcHBHRTl6aXhQWjEzaFZRb3dnSTNMYU4wbXBMU0pzRldw?=
 =?utf-8?B?cHdkQ01HekNVTElsS1VHdEd2YXhvSHRqb0tzSHJha0VleE5zeDZta1FGMXRR?=
 =?utf-8?B?cm91U1pHcVZ1VjJsS1FDWUduQnJwY1kzOUVxbzlUbEc0dTNoTWdyaWxra25R?=
 =?utf-8?B?QnNRNVlPcUNSS3N0bFpBWGJ6Q2cwMHRwWHRncEwyYU9QRVB0YllneGZnYzlX?=
 =?utf-8?B?aEdjcVhsdTlLUVEycndQcHVyOTRIU2FZMmREeTVpOERFNmVvVCt0SnVVODUz?=
 =?utf-8?B?SHY4U3VNQjVQOVdOOXRCRkc5MjJWM0xJYjdmd2JTSUtoMkNUVi9Vb1FtamNs?=
 =?utf-8?B?Rnk5eVVWTFZZRVc0d09pNTh2eXZiclBZNzJhN085cVhweEpWejZzYy9GQkJG?=
 =?utf-8?B?cmt6alBST2pYblh2TS8yaVNQa2xyVTliWlR5NllDWVc1c3YxaEZ4bGcyTll6?=
 =?utf-8?B?SE0wT3lRY0FOOTk2RGtTQnpBN3REK1JzT1lnM1BCeFV6cFExUW84cGp4WmdG?=
 =?utf-8?B?YzZKQXQvUEt3d0JpUCs5ZkJqdnl0TnpWcjhtQU1VUFJLOXRNL3ZsTUF3NmlB?=
 =?utf-8?Q?PWogzAz7qfsG7mo6BeRkcdODJ4hNzDzrcghXCAftqvdA?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <6B3993EE45EA8B4F859FBBB9F583CCF1@namprd12.prod.outlook.com>
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
X-MS-Exchange-CrossTenant-Network-Message-Id: ca8f069d-6fb5-4892-a156-08dc897b9f2c
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Jun 2024 18:32:02.4221
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ZiRF2tlMdP+z+IzQBZA81amPSeymMMuo+v+gUdgorHJ8L/rpjcn9zPzu8lNAfP2hc8Tqs0auRguXFi3QgruK1g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR12MB9095

T24gNi8xMC8yNCAwMDo1MSwgVmVua2F0IFJhbyBCYWdhbGtvdGUgd3JvdGU6DQo+IEdyZWV0aW5n
cyEhIQ0KPg0KPiBPYnNlcnZpbmcgS2VybmVsIE9PUFMsIHdoaWxlIGNyZWF0aW5nIG5hbWVzcGFj
ZSBvbiBhIE5WTWUgZGV2aWNlLg0KPg0KPiBbwqAgMTQwLjIwOTc3N10gQlVHOiBVbmFibGUgdG8g
aGFuZGxlIGtlcm5lbCBkYXRhIGFjY2VzcyBhdCANCj4gMHgxOGQ3MDAzMDY1NjQ2ZmVlDQo+IFvC
oCAxNDAuMjA5NzkyXSBGYXVsdGluZyBpbnN0cnVjdGlvbiBhZGRyZXNzOiAweGMwMDAwMDAwMDAy
M2I0NWMNCj4gW8KgIDE0MC4yMDk3OThdIE9vcHM6IEtlcm5lbCBhY2Nlc3Mgb2YgYmFkIGFyZWEs
IHNpZzogMTEgWyMxXQ0KPiBbwqAgMTQwLjIwOTgwMl0gTEUgUEFHRV9TSVpFPTY0SyBNTVU9SGFz
aCBTTVAgTlJfQ1BVUz04MTkyIE5VTUEgcFNlcmllcw0KPiBbwqAgMTQwLjIwOTgwOV0gTW9kdWxl
cyBsaW5rZWQgaW46IHJwYWRscGFyX2lvIHJwYXBocCB4c2tfZGlhZyANCj4gbmZ0X2ZpYl9pbmV0
IG5mdF9maWJfaXB2NCBuZnRfZmliX2lwdjYgbmZ0X2ZpYiBuZnRfcmVqZWN0X2luZXQgDQo+IG5m
X3JlamVjdF9pcHY0IG5mX3JlamVjdF9pcHY2IG5mdF9yZWplY3QgbmZ0X2N0IG5mdF9jaGFpbl9u
YXQgbmZfbmF0IA0KPiBib25kaW5nIG5mX2Nvbm50cmFjayB0bHMgbmZfZGVmcmFnX2lwdjYgbmZf
ZGVmcmFnX2lwdjQgcmZraWxsIGlwX3NldCANCj4gbmZfdGFibGVzIG5mbmV0bGluayB2bXhfY3J5
cHRvIHBzZXJpZXNfcm5nIGJpbmZtdF9taXNjIGZ1c2UgeGZzIA0KPiBsaWJjcmMzMmMgc2RfbW9k
IHNnIGlibXZzY3NpIHNjc2lfdHJhbnNwb3J0X3NycCBpYm12ZXRoIG52bWUgbnZtZV9jb3JlIA0K
PiB0MTBfcGkgY3JjNjRfcm9ja3NvZnRfZ2VuZXJpYyBjcmM2NF9yb2Nrc29mdCBjcmM2NA0KPiBb
wqAgMTQwLjIwOTg2NF0gQ1BVOiAyIFBJRDogMTI5IENvbW06IGt3b3JrZXIvdTY1OjMgS2R1bXA6
IGxvYWRlZCBOb3QgDQo+IHRhaW50ZWQgNi4xMC4wLXJjMyAjMg0KPiBbwqAgMTQwLjIwOTg3MF0g
SGFyZHdhcmUgbmFtZTogSUJNLDkwMDktNDJBIFBPV0VSOSAocmF3KSAweDRlMDIwMiANCj4gMHhm
MDAwMDA1IG9mOklCTSxGVzk1MC5BMCAoVkw5NTBfMTQxKSBodjpwaHlwIHBTZXJpZXMNCj4gW8Kg
IDE0MC4yMDk4NzZdIFdvcmtxdWV1ZTogbnZtZS13cSBudm1lX3NjYW5fd29yayBbbnZtZV9jb3Jl
XQ0KPiBbwqAgMTQwLjIwOTg4OV0gTklQOsKgIGMwMDAwMDAwMDAyM2I0NWMgTFI6IGMwMDgwMDAw
MDZhOTZiMjAgQ1RSOiANCj4gYzAwMDAwMDAwMDIzYjQyYw0KPiBbwqAgMTQwLjIwOTg5NF0gUkVH
UzogYzAwMDAwMDA1MDYwNzhhMCBUUkFQOiAwMzgwwqDCoCBOb3QgdGFpbnRlZCANCj4gKDYuMTAu
MC1yYzMpDQo+IFvCoCAxNDAuMjA5ODk5XSBNU1I6wqAgODAwMDAwMDAwMjgwYjAzMyANCj4gPFNG
LFZFQyxWU1gsRUUsRlAsTUUsSVIsRFIsUkksTEU+wqAgQ1I6IDI0MDAwMjQ0wqAgWEVSOiAwMDAw
MDAwMA0KPiBbwqAgMTQwLjIwOTkxNV0gQ0ZBUjogYzAwODAwMDAwNmFhODBhYyBJUlFNQVNLOiAw
DQo+IFvCoCAxNDAuMjA5OTE1XSBHUFIwMDogYzAwODAwMDAwNmE5NmIyMCBjMDAwMDAwMDUwNjA3
YjQwIA0KPiBjMDAwMDAwMDAxNTczNzAwIGMwMDAwMDAwMDQyOTFlZTANCj4gW8KgIDE0MC4yMDk5
MTVdIEdQUjA0OiAwMDAwMDAwMDAwMDAwMDAwIGMwMDAwMDAwMDYxNTAwODAgDQo+IDAwMDAwMDAw
YzAwODAwMDUgZmZmZmZmZmZmZmZlMDAwMA0KPiBbwqAgMTQwLjIwOTkxNV0gR1BSMDg6IDAwMDAw
MDAwMDAwMDAwMDAgMThkNzAwMzA2NTY0NmY2ZSANCj4gMDAwMDAwMDAwMDAwMDAwMCBjMDA4MDAw
MDA2YWE4MDk4DQo+IFvCoCAxNDAuMjA5OTE1XSBHUFIxMjogYzAwMDAwMDAwMDIzYjQyYyBjMDAw
MDAwMDBmN2NkZjAwIA0KPiBjMDAwMDAwMDAwMWExNTFjIGMwMDAwMDAwMDRmMmJlODANCj4gW8Kg
IDE0MC4yMDk5MTVdIEdQUjE2OiAwMDAwMDAwMDAwMDAwMDAwIDAwMDAwMDAwMDAwMDAwMDAgDQo+
IDAwMDAwMDAwMDAwMDAwMDAgMDAwMDAwMDAwMDAwMDAwMA0KPiBbwqAgMTQwLjIwOTkxNV0gR1BS
MjA6IGMwMDAwMDAwMDRkYmNjMDAgMDAwMDAwMDAwMDAwMDAwNiANCj4gMDAwMDAwMDAwMDAwMDAw
MiBjMDAwMDAwMDA0OTExMjcwDQo+IFvCoCAxNDAuMjA5OTE1XSBHUFIyNDogMDAwMDAwMDAwMDAw
MDAwMCAwMDAwMDAwMDAwMDAwMDAwIA0KPiBjMDAwMDAwMGVlMjU0ZmZjIGMwMDAwMDAwMDQ5MTEx
ZjANCj4gW8KgIDE0MC4yMDk5MTVdIEdQUjI4OiAwMDAwMDAwMDAwMDAwMDAwIGMwMDAwMDAwMDQ5
MTEyNjAgDQo+IGMwMDAwMDAwMDQyOTFlZTAgYzAwMDAwMDAwNDkxMTI2MA0KPiBbwqAgMTQwLjIw
OTk3NV0gTklQIFtjMDAwMDAwMDAwMjNiNDVjXSBzeW5jaHJvbml6ZV9zcmN1KzB4MzAvMHgxYzAN
Cj4gW8KgIDE0MC4yMDk5ODRdIExSIFtjMDA4MDAwMDA2YTk2YjIwXSBudm1lX25zX3JlbW92ZSsw
eDgwLzB4MmQ4IA0KPiBbbnZtZV9jb3JlXQ0KPiBbwqAgMTQwLjIwOTk5NF0gQ2FsbCBUcmFjZToN
Cj4gW8KgIDE0MC4yMDk5OTddIFtjMDAwMDAwMDUwNjA3YjkwXSBbYzAwODAwMDAwNmE5NmIyMF0g
DQo+IG52bWVfbnNfcmVtb3ZlKzB4ODAvMHgyZDggW252bWVfY29yZV0NCj4gW8KgIDE0MC4yMTAw
MDhdIFtjMDAwMDAwMDUwNjA3YmQwXSBbYzAwODAwMDAwNmE5NzJiNF0gDQo+IG52bWVfcmVtb3Zl
X2ludmFsaWRfbmFtZXNwYWNlcysweDE0NC8weDFhYyBbbnZtZV9jb3JlXQ0KPiBbwqAgMTQwLjIx
MDAyMF0gW2MwMDAwMDAwNTA2MDdjNjBdIFtjMDA4MDAwMDA2YTlkYmQ0XSANCj4gbnZtZV9zY2Fu
X25zX2xpc3QrMHgxOWMvMHgzNzAgW252bWVfY29yZV0NCj4gW8KgIDE0MC4yMTAwMzJdIFtjMDAw
MDAwMDUwNjA3ZDcwXSBbYzAwODAwMDAwNmE5ZGZjOF0gDQo+IG52bWVfc2Nhbl93b3JrKzB4Yzgv
MHgyNzggW252bWVfY29yZV0NCj4gW8KgIDE0MC4yMTAwNDNdIFtjMDAwMDAwMDUwNjA3ZTQwXSBb
YzAwMDAwMDAwMDE5NDE0Y10gDQo+IHByb2Nlc3Nfb25lX3dvcmsrMHgyMGMvMHg0ZjQNCj4gW8Kg
IDE0MC4yMTAwNTFdIFtjMDAwMDAwMDUwNjA3ZWYwXSBbYzAwMDAwMDAwMDE5NTBjY10gDQo+IHdv
cmtlcl90aHJlYWQrMHgzNzgvMHg1NDQNCj4gW8KgIDE0MC4yMTAwNThdIFtjMDAwMDAwMDUwNjA3
ZjkwXSBbYzAwMDAwMDAwMDFhMTY0Y10ga3RocmVhZCsweDEzOC8weDE0MA0KPiBbwqAgMTQwLjIx
MDA2NV0gW2MwMDAwMDAwNTA2MDdmZTBdIFtjMDAwMDAwMDAwMDBkZjk4XSANCj4gc3RhcnRfa2Vy
bmVsX3RocmVhZCsweDE0LzB4MTgNCj4gW8KgIDE0MC4yMTAwNzJdIENvZGU6IDNjNGMwMTM0IDM4
NDI4MmQ0IDdjMDgwMmE2IDYwMDAwMDAwIDdjMDgwMmE2IA0KPiBmYmMxZmZmMCBmYmExZmZlOCBm
YmUxZmZmOCA3YzdlMWI3OCBmODAxMDAxMCBmODIxZmZiMSBlOTIzMDAxMCANCj4gPGU5MjkwMDgw
PiA3YzIwMDRhYyA3MTI5MDAwMyA0MTgyMDAwOA0KPiBbwqAgMTQwLjIxMDA5M10gLS0tWyBlbmQg
dHJhY2UgMDAwMDAwMDAwMDAwMDAwMCBdLS0tDQo+DQo+DQo+IElzc3VlIGlzIGludHJvZHVjZWQg
YnkgdGhlIHBhdGNoOiANCj4gYmU2NDdlMmM3NmIyN2Y0MDljZGQ1MjBmNjZjOTViZTg4OGI1NTNh
My4NCj4NCj4NCj4gUmV2ZXJ0aW5nIGl0LCBpc3N1ZSBpcyBub3Qgc2Vlbi4NCj4NCj4NCj4gUmVn
YXJkcywNCj4NCj4gVmVua2F0Lg0KPg0KPg0KPg0KDQpkbyB5b3UgaGF2ZSBzdGVwcyB0aGF0IHlv
dSBjYW4gc2hhcmUgPw0KZGlkIHlvdSBmaW5kIHRoaXMgdXNpbmcgYmxrdGVzdCA/IGlmIG5vdCBj
YW4geW91IHBsZWFzZSBzdWJtaXQNCnRoZSBibGt0ZXN0IGZvciB0aGlzIGlzc3VlID8gdGhpcyBj
bGVhcmx5IG5lZWRzIHRvIGJlIHRlc3RlZCByZWd1bGFybHkNCnNpbmNlIHBlb3BsZSBhcmUgd29y
a2luZyBvbiB0aGlzIHNlbnNpdGl2ZSBhcmVhIC4uLg0KDQotY2sNCg0KDQo=

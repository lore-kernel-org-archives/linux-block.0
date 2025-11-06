Received: from CH1PR05CU001.outbound.protection.outlook.com (mail-northcentralusazon11010014.outbound.protection.outlook.com [52.101.193.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 062B81A3172
	for <linux-block@vger.kernel.org>; Thu,  6 Nov 2025 03:58:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.193.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762401536; cv=fail; b=hMzBiYIQbSl5BPH2rNhGtpRm+kuxSP/e2ryQrkVu8KV72MAGuuT5VPLX5N+Z8rWZJZJgbs7jy5A9yRzruimVUfLVNCnjOJAKzbHBdaE+gmVCDSsuKDxFoQAFs8yslJo7emQkO3OzjenJtBGCZ09ZC3k3n15xeRJjuoQOg4iS25Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762401536; c=relaxed/simple;
	bh=+ukSQ+0xnzbP9L9uyH3Tsg4C3EPqlXA4Rm9pRQYAnns=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=IPGM+QJLwlws16mGrwd6gjIIZhv8tP6DGXNL9vokWRs15oxIUGIVrCDG+ar7j3DnBjStP+aXVoxWkb4u4y1H40r8YRXSRN1xAXFBmaCUl9eeevkSDalwvTvt/ZEG9lnOEpQ4nVTs1njBGQgcV/QyUW46PPeIy2Hxiz3ZuQVUsho=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=apUTgFLG; arc=fail smtp.client-ip=52.101.193.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="apUTgFLG"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iIdv5pXW3iqhkkR71+KOejvAD4AeeZBpfig7+/lsCARVOs8JpPmk8U8cbfVmZhvLOsPyOjsObSTYD783t3Y+NUFcLxOPzDYuyGBz5j9SbilwebYjp3Q8XWULn2VEKpXlJkpv2fOxTNddT727CkUy1B3Dp2Cnq86ECRsA8CNOyKUtSOJWUdALWHe93Fjx2gwMLUKJHq6wvndA7Uep2PubRXL2X5dsWjNbJM5lMBLWvjzr4LNlHeaINH6dIr83cw7LVwNzex9HKsh/0R5RunRLqSVdnYu9Z5mOfnz7uvs2nhxCxzQ9IEpFU+UR0MWXgWXYNJS62AeP1YLqIBIhVv8uXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+ukSQ+0xnzbP9L9uyH3Tsg4C3EPqlXA4Rm9pRQYAnns=;
 b=wQ2bgboXJPVe/TNYuDl+JMmxWapTl14Dt8IHBes36Cq9S5JeT24hDLaCu/YhbUS8PBVCvEgvjy4e1gqRjs0BAdD0MEwSDi7LY5leyxgXR+2Y/+MFUokt4+9bZW5+p83oTFz/Btbza1Kn4TF6oExR/CPiXNHmhHzCg/r/1/CMMT64Y+Czb6nJVXgRteMR5O0SMI9uYIo6DES51KXgpcqBQyizaNImZJjq1wBALisn8IP/fHzAkVrKnO1nBwxodzJdri73M614lgP+Sl5BRVGNOYKJN3qC9G+E9b7+y6hRI3g3VWgF+Nc4F9fgTQGGDDADRQjJKfha12VMNDrFk4ZLsw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+ukSQ+0xnzbP9L9uyH3Tsg4C3EPqlXA4Rm9pRQYAnns=;
 b=apUTgFLGtghALtEQMv0hhFXnG/GjcqVr7Dx7tgpO+FBKaORfnra4xJF5d2tlr67xmZ4CYwyYVA7jvVbKDsLNoznOH+wKaId3xpPguUZ1ilR7ZNXGiGaPIBP/hkbiACTEZjfCopidwAJZNk4Dia1BNPnuOILHHtkeL8HuEZ7d2R46AcVZCR+1Xgwt5YUpdrwq6N8LPpEVFcTJMCVx9yxceQGL5K1eBXOGY4xRl1YQzQ+8BCcv+2S2qtv8K68Ypg1YYYLyZrhVY0Z3tHCT5mktWGLDan98XizxnqLixDC9DGOzRVAQ5xaILbwkxjcqq/Oh3/aIbHkQqz57kSrWz/BLjg==
Received: from LV3PR12MB9404.namprd12.prod.outlook.com (2603:10b6:408:219::9)
 by BY1PR12MB8445.namprd12.prod.outlook.com (2603:10b6:a03:523::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.8; Thu, 6 Nov
 2025 03:58:49 +0000
Received: from LV3PR12MB9404.namprd12.prod.outlook.com
 ([fe80::57ac:82e6:1ec5:f40b]) by LV3PR12MB9404.namprd12.prod.outlook.com
 ([fe80::57ac:82e6:1ec5:f40b%5]) with mapi id 15.20.9275.015; Thu, 6 Nov 2025
 03:58:49 +0000
From: Chaitanya Kulkarni <chaitanyak@nvidia.com>
To: Keith Busch <kbusch@meta.com>, "linux-block@vger.kernel.org"
	<linux-block@vger.kernel.org>, "hch@lst.de" <hch@lst.de>, "axboe@kernel.dk"
	<axboe@kernel.dk>, "dlemoal@kernel.org" <dlemoal@kernel.org>,
	"hans.holmberg@wdc.com" <hans.holmberg@wdc.com>
CC: Keith Busch <kbusch@kernel.org>
Subject: Re: [PATCHv2 3/4] null_blk: single kmap per bio segment
Thread-Topic: [PATCHv2 3/4] null_blk: single kmap per bio segment
Thread-Index: AQHcTsBp5FCE1mm/QEefJMMqKRhxdbTlBc+A
Date: Thu, 6 Nov 2025 03:58:49 +0000
Message-ID: <9c39b853-5f2c-47ac-9c00-c341d5998a2d@nvidia.com>
References: <20251106015447.1372926-1-kbusch@meta.com>
 <20251106015447.1372926-4-kbusch@meta.com>
In-Reply-To: <20251106015447.1372926-4-kbusch@meta.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV3PR12MB9404:EE_|BY1PR12MB8445:EE_
x-ms-office365-filtering-correlation-id: b73444ac-7c31-4799-f974-08de1ce8caf6
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|10070799003|376014|366016|38070700021;
x-microsoft-antispam-message-info:
 =?utf-8?B?eThieG1aVmdmOUE5VDJVK1dLdzRPSHUrOVprNXZaRXlqcEwrV3R2Qzhwckt3?=
 =?utf-8?B?Y3pKOVd2cUMvQS84b2Y1Ri9tODk2NDllak83cEIxYktrdXNwQk5RbDRCYlZ0?=
 =?utf-8?B?V1RaQWQrOW1PaHY2c01HWXV2VWZmWGRLVVFkUlprbkJCeHdDRnBaU05UTDhi?=
 =?utf-8?B?R25RRVcwN2xpM1FmSU80Wk5icGRKaHhub2RvUkZYTDRkYU5TSTJpbG1XejRu?=
 =?utf-8?B?blFvc0c3bjFyUk9SMzd3TkZVNEU0T0FoRkEwaTJJczkvRU10Y0JCTmE4NFoz?=
 =?utf-8?B?dWZtQ0YwYzR5MXNuSGtuUVorc3o5ci9WZlJqWFdBRm9abEpxRXQ4N0phQlRX?=
 =?utf-8?B?T3BnZmpOZTkrYWJlZDI1OXFMVkhTUmV4WE1ZZTFRUG9wS2xkN2N2LzVqL3o4?=
 =?utf-8?B?Q0E2ZTZNYVZVcStTOVd5eFMrYkkxYUtIM1JvNzRUbmtrZEs5eHpERWp0N3gw?=
 =?utf-8?B?TXg5Rk0xRXI0QjIzS21udnhHSTc4WUdpTHc1OHlPRTZBVktoelpLNlBTNHFi?=
 =?utf-8?B?STUzb0xnOGJ2aHRDVllyVnZTa2tGQmpxVlduUXM2N0xWcnB3bkM5YzJISE1I?=
 =?utf-8?B?RytaNVAraG9IR3NuZ2craCtOb05oZGxKc0drVTg5cHcrbkZWNHF4eDNuUmpR?=
 =?utf-8?B?ZlpuME9OSnMxWXUwYUlydU9ma3FxY0F1Z0VTTVZocWRZZlY3ZGkvVU9tdkNX?=
 =?utf-8?B?ZG1ud3pacndMb2VCUkVVODg5UGp4MnRWNHRjQTdnZUh3SCs1aUp4K3drK3kx?=
 =?utf-8?B?RGpQd2wySklKeHdqWFR0QVB5R1drNnVZdVZ6Q3dRd2phSHJJR00rTk0xTGFs?=
 =?utf-8?B?Vyt4TTNIcU1hbktLbXc0ZWp4U2FDZlBOcmFMOC95MHpDaTJJd0ZDR3k1WG5m?=
 =?utf-8?B?Q296MzVtNE9namNtaVBnbFdSQUJIc1g5bGIxdjNtckx6SUxkd3RmbmR1T2Zw?=
 =?utf-8?B?Yk1EVTViTFk5Z21qdGFNaFY2czliQXRvOXpRNTJtRDFZbUFSZmFxUWpreXFv?=
 =?utf-8?B?cjRpbjZrd3lnc1hjSzVJWGtkUVUyME9ra3dnWGV6S2pXTkJtcGVYTUdHQmZH?=
 =?utf-8?B?WW9wSUlLQ2NxR25BaVN0RHZNYkdjejFITHJ5c3l2SzNhUHBkNmhFSW5jL1d5?=
 =?utf-8?B?UHFocDUvcFl2bkpvdWVTN1lMd2pVVHZXN1ZxQVRVaExWWkF5Y25GYXNVVVB1?=
 =?utf-8?B?VVQ5eXhiNG5IcnkxWWY3NEJHM2RyUzA3Q2ZyQ2c4RFM0elZzQ1VDK04velN2?=
 =?utf-8?B?OGtpL0Vxem9hM1lYYnBreW50V0hLQVpOSGFvYVQxMEY4S0NmYWtOTy9Kelp1?=
 =?utf-8?B?WDIrRGFoNmFKQ3VvZU5TM1I4eGF5YXpncHdDeHA1OStobE9xNmlsR1JhYVZU?=
 =?utf-8?B?elRVYVc2VUNreFBHYnpFSTFFNW9WdTFXaWh3MGwyRUJrSFlsbUpWYTRldDdn?=
 =?utf-8?B?djQ2N1JDNk5DT1pMT0pNRHI0S010ZkxuYktrbDRtZGFHNDFOYlpRZ3VPejN1?=
 =?utf-8?B?dmw5UEY2MTRNdi9LcERpcnhjbWlMK0V4dDZUWnhMTHpzaDhGNllJQ1AzdExF?=
 =?utf-8?B?TmQvZTZYcmZ6ZGxwZnFVOGI1LzVlOHh2dXVOYXJZMHBXd2c1dHltQ1V0T3BR?=
 =?utf-8?B?b0FENk5nTkdIbUVtay9mZzJXcFhSdlltTGxQV0VJb2YyOEd1M0RRd28xajAv?=
 =?utf-8?B?aGlzbmFVcTRaSEQ1UXNmUzhXN3JOYmJ2MXZ5MXZTYno0bkpYVmNwRHJYNmxl?=
 =?utf-8?B?YjNNYjduUzBRaWdxa3d2TjhXb1pLeUsrZWNRcWwyb0s5QjZpRVo5NUlSYUVo?=
 =?utf-8?B?UjY4V2Yxd1hCZEg2ZFlhVkpuQk1IWm9BQ2g0dTV3N1ZmZThGWEIrQVZZTmxo?=
 =?utf-8?B?OUxhNno2SHJOR2h1KzFkcFA1WnozeFdBeGF6NWpUcThTZGNZTE9FNE5TWFZl?=
 =?utf-8?B?Z2V3RUt6emZ1N003YlZqNTlqaHN0SUswakZNSTc0Rmg2R2d6TnRSajNRcTJD?=
 =?utf-8?B?SklHQlBGKzZkSFYwSzFYWG5MbTNRa08xZ1g1M0RkRjZCeElzVEd6eWFJcjRK?=
 =?utf-8?Q?Z3wkBu?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR12MB9404.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(10070799003)(376014)(366016)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?NEREVEYvYktIeVJOUzBJZFZzRnNMNkY4eGRyVitqc0VIQUdPWW8vUkt3eGVr?=
 =?utf-8?B?RkhtOWM5TUVHWm1SL2VvSmsxTWtzcGhxMHdWSXBCLytodXVhVjNFUHFPRU12?=
 =?utf-8?B?MHV6bHpEcGxqK3VHeHlFdWV6L2pzMkc2Q29NVHgwTWlra2ovbHloSkgzSEd1?=
 =?utf-8?B?S1pEOFE5R3E5bUwxcENNR0xUaWVEY1l0bGlVZzlHckhXQ3EvbWZBK2Z5SnNR?=
 =?utf-8?B?NHh5SlpRdzcyQlV0UG9zeEVNdi9hcVZudnA5L3M1SlRnZzNyUFp1TGNVL3Fw?=
 =?utf-8?B?cGZPdmpoRVNQSlpMQzkxQkNaaExUanZhMURBUmJYS25GQ05UU0xKTitRRU1J?=
 =?utf-8?B?dHE1Z2RUMVYxS3dxTXZjT0RjdUM0SnpWYitONVhNSm9CNGxEZWpCTUF3d29H?=
 =?utf-8?B?cWl5K0lYVWhmNWxUQzRQcUZ1NUtnZjVURlRnYkVWaEExR3F6cmltUmE5elg0?=
 =?utf-8?B?ajAzR3ZDaGNPc1JVSHppN29ic29rQTBrWWlJRVR1bU5rNU9kLzUzOTM5aTJp?=
 =?utf-8?B?dG9kNHVTalZqekxDM2NWU2VxN3JkNjI5RklnS0FzVWh5dVFGVnk2RWhxTVk3?=
 =?utf-8?B?eGtMdjJlQTI3RFlwaU1aOW1zZytkZUV6ZjR2d1BPSVBhY0ZIWHNZZlUvR1FV?=
 =?utf-8?B?eVJVTEtyQmRrNERObTd5VnhmM2daN0JjeHFUZ2F6dlZnS0w2amhEcGhtSDQ0?=
 =?utf-8?B?aUltakdub0NWN2h1Z05ITnlja2R1NklXU1gvdEZkWkppTFpTNG9sNDdhYVhH?=
 =?utf-8?B?QkIzRnlFeGFUWXdUdGsrWHUrZlNPeDFMckplZjFWTlZKM3IvVFlybWsvMmNn?=
 =?utf-8?B?NE5rWUg4bXBpaFRkeHlVR3BvUVhXcWpqaDJGbTg2MmtaTitrQmI4SWlacXA5?=
 =?utf-8?B?RmRzSERnSGIrSnRjTVJRTTlzQjcwdTVwVmduMVRIZ01Mbk5FZDlUakI2Nmh6?=
 =?utf-8?B?Z2syMkVybjFIMkVaWEgrSVdGOVE2TkRhREpkVVhPTFN5Sk4xTUVyYzBoeTEx?=
 =?utf-8?B?RkdDQ1hHN0xCbHRDUWhBUEswc1A4Um5ETzBpay9IRzg2Rmhkb2ppUjVYejFR?=
 =?utf-8?B?aVNWczcvY3FoUU9Bc3FNQlQ1SUtCN0dlRGEwLzcyY1hZRkpFMFNsbDQyVUtL?=
 =?utf-8?B?RzJoT3VJNVU1aGRCNG5DRnZ5cGhvb3pKc1AvWTY0cmVxcUhCOFI0QlUxTDZw?=
 =?utf-8?B?QlhPQ1ZQbnplUWRGZklhVHJvcEpmeUZiaEY0K1pLYmtNVVRiWlpmYy9JQ2lx?=
 =?utf-8?B?Y0ZyUjNVUHZBbVd2UEVIMmVta3ZTdU9QdzcwaUlieXljbDJxUTZyMzFYVU83?=
 =?utf-8?B?WEpxNnJYNUxONlhVNG80MGlaRm11bktqNTljTHVCQzBySzNqTG1zcnZYOE1q?=
 =?utf-8?B?KzFlbk0vaFRpcFg3TE1XdWFISGI0cUFERWJRN0sxTW8xcGM1MmN2eFV4aUNl?=
 =?utf-8?B?U2E5YTZaUmxWSjljSkFuRnFCR0JsTGJaR2p1SmpZNWxhUVRKWFQ5RERnUXNZ?=
 =?utf-8?B?UE14R2pNOWJ0UnhidEhIUVVVMTcrditkMDVQa2FYNVVYR2tXSkRabkhnb0pv?=
 =?utf-8?B?bExFYlpBUEZBQ0hzaDRFbklhaWFmcVFiRnBYamtrWHFueTNKQUF6b3Z4aGxR?=
 =?utf-8?B?b3l6WGhyRXJwRTA1N3hZV2tzVldlOFZRbVJUdnpkdENXWGhDaFlTditjcmdh?=
 =?utf-8?B?WThkYnd0Yk5obnRHRXFTOWJ1OUpUTGdsdVczUkEvT1dER0xZaTQ0aldnOGNU?=
 =?utf-8?B?ZGh0NElIZmUwTFJCQ21tZzZyV1RxeWZCTzVPTm5jZzIveEcwc2czNU9LaExn?=
 =?utf-8?B?eDk0Z1l4UEFrbDUrWXExQ2Y1UVJoWllHbVA1K2c4ditveDI2MnpKbnU0ZWcz?=
 =?utf-8?B?TDk2Q0FXYnZkK2JPYXRhZHlONjNTZ0lHTncxLzlGWW13ZTE2Nms5ZmlscVQ2?=
 =?utf-8?B?RDhvQ0ZVSW5WTUJkbVgrUHBQUHFFOUFRZXpCRXlEQ0lPK3NkeHppTVRKQ1k0?=
 =?utf-8?B?MzZLVU5hcThuOGExSjhCbVFkQ3lDL1kwaHQxRDVNOTU0Y1o3UDhqQk90STFE?=
 =?utf-8?B?Wnd1QW5nL0txMm9ISHpRM1RKUjBKdC9FUUM3a01jN251cWVnbFJPeXppS1JU?=
 =?utf-8?B?Z3F3ZTUxVUFOVWg2enlNeXRhRUIyMXB6MTM1dG4rUGY1VGRSaEdJOS9nSFpj?=
 =?utf-8?Q?mnG8dI1kCOW2f+wopxEf+1kX7QhHzw9Tpn1cITNDWqRj?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <CC6C864F9C81C34CA3925AA88D0CA0DF@namprd12.prod.outlook.com>
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
X-MS-Exchange-CrossTenant-Network-Message-Id: b73444ac-7c31-4799-f974-08de1ce8caf6
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Nov 2025 03:58:49.5983
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: xx0TIeQlC0vJqHJ+Drum29up0BAfFtq7Q/M/aUQ65dT51TVFc516AodhXctLRVY/VYXbbFOxbC6WWAqmzFGlkw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY1PR12MB8445

T24gMTEvNS8yNSAxNzo1NCwgS2VpdGggQnVzY2ggd3JvdGU6DQo+IEZyb206IEtlaXRoIEJ1c2No
PGtidXNjaEBrZXJuZWwub3JnPg0KPg0KPiBSYXRoZXIgdGhhbiBrbWFwIHRoZSB0aGUgcmVxdWVz
dCBiaW8gc2VnbWVudCBmb3IgZWFjaCBzZWN0b3IsIGRvDQo+IHRoZSBtYXBwaW5nIGp1c3Qgb25j
ZS4NCj4NCj4gU2lnbmVkLW9mZi1ieTogS2VpdGggQnVzY2g8a2J1c2NoQGtlcm5lbC5vcmc+DQoN
Ckxvb2tzIGdvb2QuDQoNClJldmlld2VkLWJ5OiBDaGFpdGFueWEgS3Vsa2FybmkgPGtjaEBudmlk
aWEuY29tPg0KDQotY2sNCg0KDQo=

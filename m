Received: from DM5PR21CU001.outbound.protection.outlook.com (mail-centralusazon11011056.outbound.protection.outlook.com [52.101.62.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25E873A1D2
	for <linux-block@vger.kernel.org>; Wed, 18 Mar 2026 00:26:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.62.56
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773793613; cv=fail; b=fWvGkyOxGQR6iyciH8o8i7AwsEsSKiGg9T3jGcRpkW1llDpRCxZMLxnaDAgZTA4Soh0TIiA7dJTEFSpSIf9R6Oso5QYIGMph35G/VHmHVICQhUpn5kRR+z/7DCctbGkUQKbfezVEWViCzsiOSYC0ptZo0/qbDiAW4G4NpFKOEiA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773793613; c=relaxed/simple;
	bh=aziAryLuRze1vuIpG8T3l8zeO0rNsNmb6yiT1ZflQL4=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=ldoXqPIcrU8s5E34UA5FP0SlUxA4Qf+M5fkuEltXxeODay0+vjwWHIS0/h2RwDh3EvgGhKPLJ648oIaH1XI/AXCyAAxUSz2IY7BUlQcBr1fkdQA1/27P/6u7NoWh1wpMbZmhxGbP5QAspBxHF9FeyHjKA/ztMNXPogT97xqKchM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=L+iSojYk; arc=fail smtp.client-ip=52.101.62.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="L+iSojYk"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RJGt2iLFSGxgdAGiJ6tfymWv/1hbHrhGPHBKjds/50i4UV2ziy6aQJ2Gb8JGmK0Oipb8uCn8nx3NfIr+aLNlGfQG2wHkWn7eHzSU7eJM3XqIFxhCEQMP1AVZ/Douxt2uglHk8XVRZaayzJZrNxNUBWmeDz1kEZCUW55ryXs/1Z3mwdTgEICj7K0bERB8qkaES4BsiN0YS/B6pK/IPx6BXr5PvoDmYk5BF5Z4sxdsrlnwz5EtnWJHR0tTviE4/fKiue++UFlJ6cVDBGzlWlkZRfF476v/OVsJNZhKm4GDQciChOeUdRn212VD0JsDe8NIWGgUez2BNKSE39lFfVMBiA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aziAryLuRze1vuIpG8T3l8zeO0rNsNmb6yiT1ZflQL4=;
 b=yocAZmfpzqHp1yejGpt1x2TxRVJ3Pk242pouMr6bS42ED2TROR0QXJrMsiY0yICbHTR/26eflxSp2wEDT7v1zvjf1pldrKG+Sx4G2EHJOJaAYXxt5s5wNOPP0xGzhAO7slVChC5AcE39ZokqpiIqXrG/FZth6R3ZKyHVk9zweZ39r1HgXz4UHBVz4/tO4GJUGLPkJTnQpq4LB4ZjOljvVlkd/+Fbg37RV/2LGc5PNRByR2sjyr0EMxpIQuMRpIynkGHFmbjddkaKnduq0aa5F5awFdtqCUTPUrbfyz+fheMxW5MwwdcQPgg2/M7BTPwmbifCJ7pKFYtxNXAo+RPiqw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aziAryLuRze1vuIpG8T3l8zeO0rNsNmb6yiT1ZflQL4=;
 b=L+iSojYkK102finbSHitHHsqdXbJ1L8gr8JGW74CmRX8Q8KdV3harOmYU1HhHUbHx4A11Z3kLcBq2KqGd6q7xL/TIKm4WHJE0MMZqxjd2yTkEonHBzFK8tQUyNL7bwMCsn0FNYG3ibe9wdsYmompGGXAKdest3/npP37bPwOY7qqW13J8P5cfZptYwMPb6A/YB7QAw6aJweQxGe3L0t9M7eeWn7lsJsul+ZjBvrHGS9O3PR+tPT9xbMwHQldSEur7rUBe2a1d5skZHVGpcdklnYzMlCvLRMWgkqeWFKdDvI2KP71ZhIk4MTt0+NKVZJq60oFYe9Nl2h+GIZnJy7U9w==
Received: from CYXPR12MB9386.namprd12.prod.outlook.com (2603:10b6:930:de::20)
 by DM4PR12MB7622.namprd12.prod.outlook.com (2603:10b6:8:109::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.19; Wed, 18 Mar
 2026 00:26:49 +0000
Received: from CYXPR12MB9386.namprd12.prod.outlook.com
 ([fe80::edab:eb80:ee7e:e9b7]) by CYXPR12MB9386.namprd12.prod.outlook.com
 ([fe80::edab:eb80:ee7e:e9b7%3]) with mapi id 15.20.9723.018; Wed, 18 Mar 2026
 00:26:49 +0000
From: Chaitanya Kulkarni <chaitanyak@nvidia.com>
To: Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>
CC: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Subject: Re: [PATCH 1/3] block: mark bvec_{alloc,free} static
Thread-Topic: [PATCH 1/3] block: mark bvec_{alloc,free} static
Thread-Index: AQHctV/THyW3zp4DBUete/Wx1K3j+LWzcRKA
Date: Wed, 18 Mar 2026 00:26:49 +0000
Message-ID: <9ad70ad1-d042-44e4-af9f-9924ab406d97@nvidia.com>
References: <20260316161144.1607877-1-hch@lst.de>
 <20260316161144.1607877-2-hch@lst.de>
In-Reply-To: <20260316161144.1607877-2-hch@lst.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CYXPR12MB9386:EE_|DM4PR12MB7622:EE_
x-ms-office365-filtering-correlation-id: a8494f6c-4812-44ad-f318-08de84850bb5
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|10070799003|376014|366016|1800799024|18002099003|56012099003|22082099003|38070700021;
x-microsoft-antispam-message-info:
 gPtFQ6BaM94Ifx52X/iyF5XJWfykiyosL6bsoU+Bup7QrXIODK82v+lmJOTi+I+Hry5liMSmLSN/aCx2ttsTW0pvpjYekLvh/5L6BKtsZbPaSBAr1nMpv+hKwAOF4/UWUwv2EiB2FyLyGUFUZJbsAihjcGlVsburkEgk+T1KJgG+iEbvIeCKVfTjW1c+w8mAm/w6qYdi/LMKVAtCvxsP+i7ITWn1ItUOljwsB+jbpd4Di4AkLff2s6A06t8XLjyH0lYGgjJh4SiupJoo5vH4SBVpXSq1SZM+OOSstjzRVs19vlDWu1cuoFo8UUneoZ3FHneBYOmUZtwM+hiMSqF3XgzV0erGNPkaev6FtbpG1OJmrhhhiIEWZCZhv3wyDNhIYLNPlwQxBisfOkqyRPYMAebIEsTP2XsP2HQN/POmBqQ18ps3KeWOpzbOzmcEU0VZb6nsRlFSlP33SshFcNeqKBJr9gd1r0eef2FVDIm5JeeWe2OMNQz0U8dEeoOYCLITDSE0ceBdxsxwtUI0xISiIetUbN807fiGNRXbAidhxvdUmlMGu0+oFLDjKPr5+JK1TJ31ALuXRhmw7oA3W/RXDA1PABTlzWpPc5bn3j0JEjzQBtua+OIQbxEIrrZyzoMp6uTrIhHRBcVfoq0ygWRityRj1jDb5PT9qW477hOAQKnozASVl+W9QFlRQOLXWQfI2go3WasVceUmuveWk8SiJQvplSa52vt2hHMh9dpFHxEtcQdn5F6aAyY8cZd4EQeiEZkrux3zse2ToPOlqoMoZwbGIBWmO/sKpyFi7Up97ng=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CYXPR12MB9386.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(376014)(366016)(1800799024)(18002099003)(56012099003)(22082099003)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 2
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?Nk9qWlhlaVFITUdQWVl2TXo1ZzZCaVplYUN4dWRWM3lGQVh4YU5tU21FNUJt?=
 =?utf-8?B?bWJlTlc2RnR5QTJ5bTI2N0szdUxlVkF2eGpFUUhYK08vL3BmSXhpWk5mdXlZ?=
 =?utf-8?B?NDRVckpiMGFmdlZEVGxiZjlLRmlzMk5LUElZVzZ2T1lWTkVPSTNWNnFHNjlm?=
 =?utf-8?B?WXdqa005OXBzVWxxWnRkTlhBRzE1TGVuVXdub1dXb1o2SXNlY3pzU1pzeXNU?=
 =?utf-8?B?TW0zd2NVT3Y5SXhJWXVZN0Rxd3BmMzZJMjJIdzNPMFo5bUI4U0NTYVJCRzhK?=
 =?utf-8?B?d2pIYy9FcHF3a0hmSUNLOWtEcm1Ba3B2TE5kd1FPVnowV3pVVzVaZzBqYnJN?=
 =?utf-8?B?WFBvVGpXOWR5dnpHRnNVK3lVV3B6eFdGME1DS1Z5eVAva1ZKeWNiUDVZOVRh?=
 =?utf-8?B?dGR2VVdidmszNnM3U0FRVkdCM2N0M3NXWWxLUDZvQi9sT1gxOUJkOEZjQkdD?=
 =?utf-8?B?djRSanN4bmtRVkxOS1ZGejNSZENydDRwa0h6eGRWWm5OQVFaOE55MmZFZlVa?=
 =?utf-8?B?MGh4eUYyWThwVTE0VkFKZUorbTdoOXgvYjVHM1FjVmt5Szh0N1RLL04ya1ZL?=
 =?utf-8?B?cUJvSHIyYWllczFBemlwbkdxTzN1dDY4bVV4TE9yR0FmRjQvZE1GQmR0Lzhx?=
 =?utf-8?B?bWtkTjVaV05BMVNKVHgzNFg2dENEVDlYbjVXSHRkUXowWFJkMEtYRUhSNWpE?=
 =?utf-8?B?Nnd5WWZVb0dObDBURWlwMXlqVC85NGEyanl4WDE5L3hjRFJ2TFJsYW9MOW9s?=
 =?utf-8?B?TUh6S1d1UzNuLzJ4R21LamNhbFJiVjR4M2dUUG5GMTZ2ejNmbllTQlZzaXhU?=
 =?utf-8?B?WFY4VGRGdmxQcnZSZS9BaGJPdHYzcUZWVGEyeTVTN0pvWWlHVXB2S2dlek5W?=
 =?utf-8?B?YXVuelRGcHIxdlM2K3JEbmtJSFVsOXRjb0tFby9LTGJEN05ybzNQYnZneHB0?=
 =?utf-8?B?THpZREduQU04cHF1UlhWSHIzdU1Wa2VZWVE1cW1aYzdqZFhnaDhEVDFIeURi?=
 =?utf-8?B?QzhRUG1YMmRHcnZKTzVwZytwcDdGL21vL0UzNng3b1lhVDI1c1NjTUltbzli?=
 =?utf-8?B?NWx6VDkwNHh1bjBCYXFwSG1PY05rS0wyb3VHVUpOTWVLd3Z1YmN0aTBwSENH?=
 =?utf-8?B?TysrTjZBWDI2UjNLTlM3RHBlNkw0SHBlQXZpM2hmRU8wWWZ2Z0RacjdLMmZP?=
 =?utf-8?B?cnE2ZHFOdVJ1eXZORWt0bHhRa2N6N2JZYTFjc1hyYk82VFpMOGhtT3kxc3Bn?=
 =?utf-8?B?WldFL01kQ1N6WE1JNDEwWHdpODZsK216TXpSVkZES1p3WVpGbW5XTEEwc3g3?=
 =?utf-8?B?My9EMDF3bDFEd1g1VElpVUNYd1ltOUVLaWsvM1krK1RQKzBiK1F3YnZhWWpP?=
 =?utf-8?B?Z2hWanpISmx2TjVhU1g1eUdBck5WaTlvQ2duR0RmRWVPaC92aVBaL1BtcHVJ?=
 =?utf-8?B?UlY5bG95UUc0T3ZxQVdUcjMzNFdYSGh0K1FTWDQrQzE2aUI1RDlMeTNlNDRO?=
 =?utf-8?B?SzltY0l6anNNVjdZSHA2R2RUYXd0MEcvUW9CeDVJUVpzV21GRWlzdGlLUW1h?=
 =?utf-8?B?M3QyclRhQk82L0dGK2pQT3RDamU3UFpPTzY4OTJIcXU2WlFYdHdpck1paVE1?=
 =?utf-8?B?alZyOUpvVGhzeXN6ZTQxQ2pBeC95Mnh5Q1pEa2cyRE5wVmxHQ2JZWkFZK3Ni?=
 =?utf-8?B?em4xUXhwc3JEL3JhNjVJQmNoVlJ4RlFMRXdlTGkvNmMzbGVFNENDdU9zQXFY?=
 =?utf-8?B?N1k4YmdYdFJRYk95QXhNK0t4QjVFamVaczVtbFVmRkk4MVVIQjFvVDlCWUYw?=
 =?utf-8?B?Rm5qVURmeWVXR2tVWkUrcWx1QjF4WFNmMXEvdWVXZ3FRR0xETkhNOVY0ek9T?=
 =?utf-8?B?NjhzS0MxSDBFZFRmdkVCb3lpUUIyVnFlVXQ1bjRLaU1NTHpGSUppeGIzN2hl?=
 =?utf-8?B?Q2d0RDAyK0tkWExJaFNOZmF1N3IwcFZSQkZlSmw5YVZCSzJuVjF1Y2R0MHFE?=
 =?utf-8?B?Ynp1YjZwa3BtTmhsWW1tVXd2M2RRSWhiTlNBWHFLdGRDV3dlT1Ura21vQTh3?=
 =?utf-8?B?eFVWRGoweFlQVUdlTndXQndONkhYSW0xR05nL0F1R1hkcjdSaXlkN2Q5Y3I5?=
 =?utf-8?B?alBOUm1mVHVwUnhDV2dPWEc4bVl1Zyt1UWhxM2gyeENscnhPR0syQ1ZUMGVn?=
 =?utf-8?B?K1FaNTA4ZXdaRnh1MndsT2l6bzZlRUsxN2VvdWplM0dLTTVaSU9BaTJCcVF6?=
 =?utf-8?B?cThLTzJtNHRaUGJYa0ZRQjd3UGJGaFB2cE5wUVkxNmpVMVczYWlYNHdmcWNt?=
 =?utf-8?B?VTkvbm0xUUlQU1VoUlY3ZkY4akZNS0ZZL2VYUGdYU2l2WTVLTDNadzlJcW9O?=
 =?utf-8?Q?AivtlHRHbJr8+javEBSLjFamfMt1W07wEwU8EX3mcEa7T?=
x-ms-exchange-antispam-messagedata-1: Umjeamy85wtU3A==
Content-Type: text/plain; charset="utf-8"
Content-ID: <AF41CB8D2A1EC94680BFCB92DE143209@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CYXPR12MB9386.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a8494f6c-4812-44ad-f318-08de84850bb5
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Mar 2026 00:26:49.4586
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: /kTuobD6SE1PoCNtPrYcEtcRiEp1flSRQVUfwyy2OTXZ6BJ4eewAviB28g7Nx2itA89RPlGQ7MMQ5AAtyExB1g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB7622

T24gMy8xNi8yNiAwOToxMSwgQ2hyaXN0b3BoIEhlbGx3aWcgd3JvdGU6DQo+IE9ubHkgdXNlZCBp
biBiaW8uYyB0aGVzZSBkYXlzLg0KPg0KPiBTaWduZWQtb2ZmLWJ5OiBDaHJpc3RvcGggSGVsbHdp
ZzxoY2hAbHN0LmRlPg0KDQoNCkxvb2tzIGdvb2QuDQoNClJldmlld2VkLWJ5OiBDaGFpdGFueWEg
S3Vsa2FybmkgPGtjaEBudmlkaWEuY29tPiAtY2sNCg0KDQoNCg==

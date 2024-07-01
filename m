Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2041.outbound.protection.outlook.com [40.107.237.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3AAB4A0F
	for <linux-block@vger.kernel.org>; Mon,  1 Jul 2024 06:37:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719815828; cv=fail; b=LuYS7g8yEWVkU4vt+7DBay/Jy7X4PW970HTrvPXlWdfLqFpVzypbnijo+8B/ilmGIVw5+yftz1hv5P6kz9txqXaI+MRlONyWsCaYhQu7JNpfyqRSk5o0DVPSq7bHr0511EHxS9n4CTGGpDyGnzoW28l7keiXiQwWjxARflIoz6c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719815828; c=relaxed/simple;
	bh=vnDLqaL+L9g9JsCbbiCwjCkmxB8XS4p1DKVfnRgfQKE=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=nclGCRj7Q1oQeGu1UpdXYcXLxmXwNVIA9gFhXHnIsgW7eM43/Onve3rvLqYN9ejMt3T9Yaj6AtJot5FRewqyPqCi8p+RO6pglUKaJc4EGkilt4e83HDE2Sn5hbocLOFk/7s8aWJhhe7YSzC7OOE510H2tCMTUCEUiaBIWG3nC4U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=CBUk0lp/; arc=fail smtp.client-ip=40.107.237.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="CBUk0lp/"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=czZI72dNPJn36noz54A3MwG4TSK1GHgmh+L3B85ahR8QyeMZi9/5kDtdggik+myZdNhC1CiyJ09vRP/mIt03A6pfkF60/BektOqJNSEbJrGXcxt3dYmPdkbUOBCxgkWnK1Lz9MyH0MGdpOThjLHwV4+Q7yTTewpAvD7Xkkg0kQLfNy/HCTLiAjxo0FVc7heR+O6v98R60dq49+U8FEggegg1NXNmjLRtIF+oLIpmTFvlpNWQzXkw+psu/j0VFG709RsDI0L5y/h5AaAuCqqKNs1FYaGn6V4e/pCX6LCvqh7cyQZWZTcCLIOnhvYsLkI2Gei4o06lxxDTFEAMdgEmew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vnDLqaL+L9g9JsCbbiCwjCkmxB8XS4p1DKVfnRgfQKE=;
 b=VlbYiCl6LTyESYVjzrs7s7DiUO/9SYEJpm97jZVX2Dejkl8VQ7RW4167mYLQPDkdb/h3EoEwLIk/taYnw+SnLLjAAfkQ27dwSpjtmvykC9ZXI1l3w2yi0MhdI99Nnhz+an80meXcLUU8BmWQu+kbDSxEsN9ADr4YPCwIIdLipysRDkp28LmpU6RXpU3nr3a40/xo67U+GVfut/7jcCN7GoJT0T+qbgMiHI7l9zaY+B8tN7rky2S24boIff5GJbPxXHQIwoilN+0HEUv96G3cS6+hgFEbJxNhDBwoFWUzlgyBUaxv5PPGSenCcn+vGE/Eq6mSdBXwXVXtdrAczO747w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vnDLqaL+L9g9JsCbbiCwjCkmxB8XS4p1DKVfnRgfQKE=;
 b=CBUk0lp/bxfLJRFJvAS8QuIPJ+mjBnA+pYH+cYaeUs4OorW/Jz8d6B5YwfiFEEhvuOd8zWN4m2B05alzygbeHvulPnKQ6bLjaGsmIDfJBXCwj1+aCQKCSv+4DzIYbcs520/viD7/ZMhEY/ba8ahjt1MzoJxZcgAIAH3TvbCzijfDrB9rG9ONyJ017kdo6cN7qXoercwe5ig6kKj0yEJ/5zxC+IibHZx/jZSUoesegxKuqF1EjKmnOrD9ggfw17cWLg9bnnK7drWbwVyr2Q8+GZOxBw+wR1gIqWpz+21MjL3F1R58LgC7v01vS2n9D55kc1Bi3mlyzXlm+8VJHycUQA==
Received: from LV3PR12MB9404.namprd12.prod.outlook.com (2603:10b6:408:219::9)
 by CH0PR12MB8579.namprd12.prod.outlook.com (2603:10b6:610:182::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7719.32; Mon, 1 Jul
 2024 06:37:02 +0000
Received: from LV3PR12MB9404.namprd12.prod.outlook.com
 ([fe80::57ac:82e6:1ec5:f40b]) by LV3PR12MB9404.namprd12.prod.outlook.com
 ([fe80::57ac:82e6:1ec5:f40b%5]) with mapi id 15.20.7719.029; Mon, 1 Jul 2024
 06:37:02 +0000
From: Chaitanya Kulkarni <chaitanyak@nvidia.com>
To: Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>
CC: Keith Busch <kbusch@kernel.org>, Sagi Grimberg <sagi@grimberg.me>, "Martin
 K . Petersen" <martin.petersen@oracle.com>, "linux-block@vger.kernel.org"
	<linux-block@vger.kernel.org>, "linux-nvme@lists.infradead.org"
	<linux-nvme@lists.infradead.org>
Subject: Re: [PATCH 1/3] block: remove a duplicate io_min check in
 blk_validate_limits
Thread-Topic: [PATCH 1/3] block: remove a duplicate io_min check in
 blk_validate_limits
Thread-Index: AQHay3YTYGDSn0u3y0yf6sBuDDBIGbHhaz0A
Date: Mon, 1 Jul 2024 06:37:02 +0000
Message-ID: <8ade86c3-3f8c-4536-8f59-62eea0566fd9@nvidia.com>
References: <20240701051800.1245240-1-hch@lst.de>
 <20240701051800.1245240-2-hch@lst.de>
In-Reply-To: <20240701051800.1245240-2-hch@lst.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV3PR12MB9404:EE_|CH0PR12MB8579:EE_
x-ms-office365-filtering-correlation-id: 722e6cf1-c6e3-41f9-db53-08dc999837a4
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|376014|366016|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?T2lzUFNObmg2MTBRTVI0eFZHelcvdHRUQ0JkVFNaYVArQy9vRG5Zd09LK0R6?=
 =?utf-8?B?MnNxWlUvNmNGU0srUm9QS2NqZWRDdXlNcmROalh4T0ptS0ZqUERlT3ovSGkv?=
 =?utf-8?B?RlR0eEFMbTVzeUJxQ2NvczlRUkFnWmRsVWxBVUY2aXVkb0ZlZzhua2VSTUVx?=
 =?utf-8?B?YXlac2hHZERnSlJOWkZvb2NNTU1ObFM1RmpDRUFqQTUvVkdyUDVXRmNTNjl3?=
 =?utf-8?B?ck1kR3lRYi9vWW5NR3k0OHN6M21jUlBUalVXZmxzZG43eFVXNFJTYXdJL0Q1?=
 =?utf-8?B?cWQ4Q2RuS1FjZk93ejNwNTI0azNkRDNQckkyM1NLZ2g2ZDdnaTJvSTQ2cTJa?=
 =?utf-8?B?UDdQMHVHYmpPRHBVS3NwWUp2WmhvejF6R1JveTJvRXltbW1iZzNsS0k4dUdH?=
 =?utf-8?B?a2s4eWJCVVVQMGdFc0syVy9FMjgrekdwS3dKZ2ppY2hzd3VQMmwvN082OGhw?=
 =?utf-8?B?bWg0elFUNWYvTUxMa2NvNGtpMnk0ZStPOG1pejJtL1poUzYyakQxUkpvNzZa?=
 =?utf-8?B?RTNGeW96a2dJcE9tZzNNUTlsQnFVQmw0RWtlazJESTJFc3NqaHNwYmxQdWxJ?=
 =?utf-8?B?NEJBM0RDSnVieG5aYmdVcVNNaHJiSWtGbTgxd3lvOGFWWnlRMzNUMHJOMkZX?=
 =?utf-8?B?QjJ4MzhSb040WVF0N094N3dPcml2RDd6SnRxTEV2aUxaN2Jhd0J0aFNJRHVk?=
 =?utf-8?B?bHludytKMjRXS1o2YWpUM0Roa05DOEVKNXU1cmVTaFVkNSs1QjYvNCtqQUhh?=
 =?utf-8?B?dTFMdDdDMFREUElWRXloc05aYlBQck1xR2VkZnZVSGNYNFVoa3F3RFl0M3Fh?=
 =?utf-8?B?OFpEVEhGTnJWNXc1MTBjd3FnMGtQSFZ2ZGZ4RUVNSk9PRTdDT1lnamtyNk96?=
 =?utf-8?B?N2o4WXdVRHV0a3piMXYwUTg3SDBjZmVKOENOaFNqakJUSURVWjNvbWNuOFUz?=
 =?utf-8?B?cGxiRC8yNTFrN05nSUtuMFlIdzJmaW51TlY1Uk85R2hWL3g5U2VMUVhKZ2Vz?=
 =?utf-8?B?dmFTUFdKa2lGZ0lBck5jWGRlVGZKbExlWWFqQVZIb1hGYUk2N3drV3YwaFJ3?=
 =?utf-8?B?MXJQYTJsZHVveWtRK1MzcldKMHR5T2JHZTAzVXl0NjVUNTNTNVhFYnl5Y3pH?=
 =?utf-8?B?cWF0K01ISFJvNW9SQkdOR2RCOGs5aWxKUkVkZ3BUc3N6MDl3RXdKNmIzTmpM?=
 =?utf-8?B?VWZiRkpLQTZ3YzllV0Exd20vL1FaYkh5VXl5Y2VNeGFYM0NucmdBbS9SV3o0?=
 =?utf-8?B?akxvUHNWaEVlTTZVU1ducjRUV3h3STJTVjJjV1FZME02TG45RkhhZ3RSY3B1?=
 =?utf-8?B?dWpadTcvN1VyeEJmK0tTd2ErTTl2OTRMVkErMTlyMkp4emYrQnFVQnJXRDBj?=
 =?utf-8?B?R2ZMYXdSMEIyVU9zcE9FYkU5alJBSUFnTUhTbmJBb1E4M2RGM2hmcFc1ZHUr?=
 =?utf-8?B?dXNSYVNBdG9CVWFJRmp5RUozM2lIaG11QmF4ZWdQYkFYNlV4bkZPTzF2MnpW?=
 =?utf-8?B?cGxzdnlpaC9UalpqNlNvUGNVRU54WFNLYlZ0RHlEc3h3QjU4U1E3ZG11UFdZ?=
 =?utf-8?B?d3U5VWJuWndYUllTNXZkVnJvOGI4QkVVendiYmxCbzNreG82cmRZbDlsYVh5?=
 =?utf-8?B?THd2S2QxOTE5KzM4bDBIaXRVVkF6cWJmdk90aGxCYlltcENEbVlWQ1dvQ0x6?=
 =?utf-8?B?Tm1jMXMvcktqRXU2cHZxQUxnTkNUZTluVFgzRDlHWWdCcnZDNnRGRW1HcXdo?=
 =?utf-8?B?ZWVTVGhDNmpPTkxMRDVCbU5saEgwT05MUnArZE01TzY5TjI3cmlRa1ExYnRs?=
 =?utf-8?B?Wnc4T1FNaWFJRkNZT1ZVMGQrTm5TMzhNVVMvd3pVR21jVGR5M0V1amc5VE9q?=
 =?utf-8?B?WVExaUJzVHJGZTNRZHh2YXhNbGcxNlU3TGhWcXB5cGlUdEE9PQ==?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR12MB9404.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?d3dpc0NrU0xSVzJEdGhBNmwycVg0ODZxb2dvM3dLR1RNZDd1clovTitRaW4v?=
 =?utf-8?B?UWhMOUxBQVU5ZWRqR2FjZXBwemJhaHh5QVk3Yk1RS1RjeUttcjdiUTlmMDhl?=
 =?utf-8?B?TXkvZ1hxR1JMWlBNV1Y5NUtqd3QxVVlTa2hDWC8xQmNaV0VLSTRPSTJiVnl3?=
 =?utf-8?B?TVZFMWY5UDhvSzAveUtQYytWdzhaYVkzTVBUNjhFNFc1UXIrbDc5bFdLZ3JF?=
 =?utf-8?B?RkI2YjRMbGg2N29zdU90MWE1dWEwSzJyWi90eVgrNEVaOWE1T3hyOWZ6MDBH?=
 =?utf-8?B?Y3dwMkd1M25vQkdoeUxpWFZjUzFlRUZGekJuYmhQVzVHT2RWVEhMbUR5K24v?=
 =?utf-8?B?SVZjczByZVF2aEQwYVlyaUVRZDdDZmEyeGN2S0hiT3hra1Q0eGQ1QjA5NUlX?=
 =?utf-8?B?REZ6aHJodTZrNkFwekRoTnlOVWpaa1A4OHRyMHJna0podmRabVVTVEZyOU5u?=
 =?utf-8?B?eWxMWS9QV1RTSzgwZFJCVmh0WXVUa2pFUUZHM1lIVmdzdzZSR2ZhMWtwaVNZ?=
 =?utf-8?B?eXhDNXVBOEU3ZXcycnVXYWVSd29mU3laMzliOXpUQVpLVU9BanlRRHNuZW5Q?=
 =?utf-8?B?U0hmQVYxczNyRFltNDBSN0hVNUExUkZKQmlnbmFkbXVIUjRsR0cyeTJZczlP?=
 =?utf-8?B?c25UWGFoTko3Z1V4b1FxcEZsK3ZzUTQyU01NOUxERzVNVFQvWmFtTVpvMHNC?=
 =?utf-8?B?L0twa1FwcDZPeWpLQ1RySkIvb0FFVURTMzE5d21sSmU3Umtad0x6OHNRdkxo?=
 =?utf-8?B?UzMwVW5ZS2hXMW1sa1c0R294NUpEalY1R05XcFlFaUZuZnhXRGtrZTVtdmhz?=
 =?utf-8?B?c2UvcGMwWmpZSmdodnE4N2UvanhGVFBNMzhodjJkbnc2L1RvS2ZQQjNHRDFW?=
 =?utf-8?B?dDR5cys5Q1ljMGdmYXVtZFh0YTQrT2tEK0toYkFGM0U2b054Mi9keFlLUDBC?=
 =?utf-8?B?NEtodVBOUituQ1loUnNhc0lXa29JNGppRUltdjRWRy9VRm1jTEpiMXMwN3Bn?=
 =?utf-8?B?cmxkbmRhVWxwNkhzQk1tbGNXUGdIQW1pYU40VmlRZUV1Tk1Qbi9mN1JkR2FG?=
 =?utf-8?B?cU4wRzhSZTBoY3BqeEJ2RU4yTGlzOUNpS1hmdEJoS3RFd3BOakUxazlZTUVm?=
 =?utf-8?B?aXVrTWZpYjY2VzBkRFIwcHpRa2JFR1JxNjYrUmNMbTlGY3hEUTVHaEc2OVJH?=
 =?utf-8?B?MW9oclYvQU1nL1JLUnJvamZFSlBSM0Nsc2FPcUc1RDA0WkFaOTBTMFd0UXRF?=
 =?utf-8?B?aWZiMC9HVTdYWk9OSzNkMlRrR2lONTNaNHZLZ00yZzRPVFFrbFRXUmR2dUVh?=
 =?utf-8?B?Q09ES2RCZ3ZFT3ZUM29rYmE2OG5IbElydkhPdk1ZSE1sODJQdHZBcGZ2Tis4?=
 =?utf-8?B?a1BhOWUyWnFXY3Z3RXJDeXp2ZmFXd0ZnZ3JEMkg2dklPYUNPL1NTdTZoaVdu?=
 =?utf-8?B?MDA2L1ZCRDBYeXNkZEc5N2lKbGVMVlV4YVg1WEdHdkx5b2ZyNmhJUnpxS0ti?=
 =?utf-8?B?Y3h6UytZQWFjTm9NZmZTR0Q2Mnd1NmRXRGN1TXk4amcvM1hOa3lDQVQxSkNQ?=
 =?utf-8?B?UXoxcThyTjgzYlYvT2x2RDlmNzZnak11WE5MbzhUcElsQ1RLd0owV05sQ3Rx?=
 =?utf-8?B?cXR1a1lHOXF3QjRyS0JtdkREZ0RxNHRiL244bTBFaVhMYU1tb0IxaTFkN3VH?=
 =?utf-8?B?dmJDNExZWndQeEdEWkcrVlVnYmd6eTlndDhyRWNuSktqcE9sRWZyL2NLNVhJ?=
 =?utf-8?B?Z3lCTTE3MXg1MmlIZXZzUlpnWVduK1kwYVRqT3JJblpwampDWXczSGh6NG0r?=
 =?utf-8?B?bFNIWElSaDZ0R2g0eHJHWXNyaGl4WXdLek45RnBxbG44aW1mRjdIVW56TXdi?=
 =?utf-8?B?QXpxRFNiaXRycUJKRjNlZjNBU2liUW1oRXEyTHBSbHFYZjVGTnVReThqNUla?=
 =?utf-8?B?T0V3N2xFazhVRkwzZlhaajAzU0tVZUsvR0tpRXZGaFQyc3RBMzFCTy95Tkxs?=
 =?utf-8?B?SHNPUitNZzlOM3JnMHhDK2RVbHpzNXpDUzdUMW82WjNIcGJmTHc2OGcrdEw5?=
 =?utf-8?B?YnQrMVI2cVJFK2wyTkRodmxjSVNDZzF0MmE5Ym5mTWFkOVVuSUMyODA2QzFQ?=
 =?utf-8?B?OTBqaC95RjVGZG1YYk4wa00rNjhWbHkxdkdKZWx5V0hjeWFhdCsxTHFCZVJs?=
 =?utf-8?Q?lB7tbWBsSUee3QA6hXFLABMjzB7qJN9rc94zgZgujACp?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <4907E6343AD61646AEFB35196032FE24@namprd12.prod.outlook.com>
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 722e6cf1-c6e3-41f9-db53-08dc999837a4
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Jul 2024 06:37:02.6855
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: gEotFjP4twm34BlWx49nntN7bEC+ULtUge9WJza+iQuUY8z3OnZnwwYmr7PGfcoTdiigxdYwOu2/tpfeucMGvg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB8579

T24gNi8zMC8yNCAyMjoxNywgQ2hyaXN0b3BoIEhlbGx3aWcgd3JvdGU6DQo+IElmIGlvX21pbiBp
cyBsYXJnZXIgdGhhbiB0aGUgY2FwLCBpdCBtdXN0IGJ5IGRlZmluaXRpb24gYmUgbm9uLXplcm8u
DQo+DQo+IFNpZ25lZC1vZmYtYnk6IENocmlzdG9waCBIZWxsd2lnPGhjaEBsc3QuZGU+DQoNCmdp
dmVuIHRoYXQgQkxLX0RFRl9NQVhfU0VDVE9SU19DQVAgPSAyNTYwdS4NCg0KTG9va3MgZ29vZC4N
Cg0KUmV2aWV3ZWQtYnk6IENoYWl0YW55YSBLdWxrYXJuaSA8a2NoQG52aWRpYS5jb20+DQoNCi1j
aw0KDQoNCg==

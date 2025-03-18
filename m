Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2076.outbound.protection.outlook.com [40.107.223.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89B181F4164
	for <linux-block@vger.kernel.org>; Tue, 18 Mar 2025 20:40:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.76
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742330444; cv=fail; b=VYwAl8LTi/hrxiHEngocp9vpjgx7efalgsOHcf9EOGpI0Z1fojdmJfsj2ot1TQAenQHi4I0FrsTQnfcHkM9IBssb7RiRqKDakkIXIovqdhNsvkKQakbTMH8MadfEkR5ncALg0/7kh95UD6IxjFH62QeecHmD+LPaoGjS3nQ8OFk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742330444; c=relaxed/simple;
	bh=7ngSd9Y7h2BUrZtOJF/ZMp6aMBqCVOeuktSHERbow5A=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=rOT1uBGZLZz96m1R6lwFGs037/VSpMJIDDQ4/Q0GknIEJTC0dzihnxxImP8x/nt8TnoHeSWT8akOApDU1bI54e5r5A7tkGNp2Ou1iVD5cuaD+XRYcYV3A+CTqOupcGHepBJyXqMA2HZRM14QUkJ3XlvJ0SxE2jgBxHpYL8JXbx0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=fv24QSnM; arc=fail smtp.client-ip=40.107.223.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="fv24QSnM"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hDl5kbmbNaMuHVC2Qti3pmv5wkYhoHD02ZvuMIY0+QmuD5pJAJk9LBd81dgPO3WgJmxN5pILmeqELB3WH+Q+2pE3Gk2PJjR1UO7nQIFUglYCRvjX4zrsDUaXLMdHD9KcxB+MfRkSvkKibtSdZrUMu7lOv4KpMOiV5EUY1lM6p/POz3jgWmnJoeuobeRAko0S4AIxcPsz7gR42eHGGtb4a7BTUmpzIJme8zmSLLirf9Zdxl7UI/EI2zxecoxBKtYLAPfbrFPHh4N0p/jhXw7ZsAkUF8DgkO2j5liUt/NtvPo13Fvv+1to4ZabOZbPLbNGbfiseCRK0UUsiDDZxMN7dg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7ngSd9Y7h2BUrZtOJF/ZMp6aMBqCVOeuktSHERbow5A=;
 b=pesytTkfm0JWlLSE1t6gIa60ZicI4hMvQCZuDi4VQ0xkNE+bHyAqed9scnXj6bkatJ1sPy+gS0WlylBC7XBGJ0EpRwT8C/asmUaA2zMhQ8hB/Ve9vx8KdQ5l/TsYoB9BP1O/4PnGOluzqpN+VfmlVdHkqEeIusQGsitmOSwrt5ri302JV4SpHuZG9T44RL1liO3euKzZDqiDsoC806Op3uamXz5oQSNEuMHoSDtcbCOGteH0+Nkp630z1VkgS+EzLD/0kmSoc1DhFUbqhVNMCwNnNdlAJvHSvLoRKx522JI4pTWU92Vj17Co6tutwtHPRNoC6mBnAZPz1DifaEcr8w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7ngSd9Y7h2BUrZtOJF/ZMp6aMBqCVOeuktSHERbow5A=;
 b=fv24QSnM1D9EgfmJ5oP8sAvJGGIGoIEaLe+d02HlDbnfKsyPIm50/JfXGga+m+NWtqrF3tEdRTwd5croY3Q1+Mcj6lh+PdnA3KATqGEQZFhvuf8b3xwFsN5tKOV/8d03u+ibhvRhbD9u+7gjw0JHzzkFxJPGau1OTSPJFDrNakNi4ziaDjoVvfbd0sBMUEfS79CAaBWwyAnsOFAYsZO43WnInkoS73CfkdcPAiDhatKmQj6F4/rejmbQ31vGBi323Qy1zRqWAIzxH3CIneiJ/ZghsL1nakbv4KezsLqhUytHmPH5t7aSWkaksAoO16zgb21vqhYf3F1/bMkYeISgmw==
Received: from LV3PR12MB9404.namprd12.prod.outlook.com (2603:10b6:408:219::9)
 by MN0PR12MB5761.namprd12.prod.outlook.com (2603:10b6:208:374::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.33; Tue, 18 Mar
 2025 20:40:39 +0000
Received: from LV3PR12MB9404.namprd12.prod.outlook.com
 ([fe80::57ac:82e6:1ec5:f40b]) by LV3PR12MB9404.namprd12.prod.outlook.com
 ([fe80::57ac:82e6:1ec5:f40b%5]) with mapi id 15.20.8534.031; Tue, 18 Mar 2025
 20:40:39 +0000
From: Chaitanya Kulkarni <chaitanyak@nvidia.com>
To: Daniel Wagner <wagi@kernel.org>, Shin'ichiro Kawasaki
	<shinichiro.kawasaki@wdc.com>
CC: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Subject: Re: [PATCH blktests 2/3] nvme/060: add test nvme fabrics target
 resetting during I/O
Thread-Topic: [PATCH blktests 2/3] nvme/060: add test nvme fabrics target
 resetting during I/O
Thread-Index: AQHbl/IXg+UsERowl0G4c2riNFe+TbN5XCCA
Date: Tue, 18 Mar 2025 20:40:39 +0000
Message-ID: <4b2433c7-5291-4b44-b7c7-ec4521b0a3d8@nvidia.com>
References: <20250318-test-target-v1-0-01e01142cf2b@kernel.org>
 <20250318-test-target-v1-2-01e01142cf2b@kernel.org>
In-Reply-To: <20250318-test-target-v1-2-01e01142cf2b@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV3PR12MB9404:EE_|MN0PR12MB5761:EE_
x-ms-office365-filtering-correlation-id: 0e2d07e2-d456-4f05-82aa-08dd665d2504
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|376014|366016|10070799003|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?TlpmMWRTdWIxc2FaMzdXSnBXaS9ibTd4TFA5VHhHU3FtQlBycGJ3aTFLQVp1?=
 =?utf-8?B?TkRMVCszUHFrZmFPdXVuV280ZEZHS3lST3IzckFLUXRvVXJGRy8vNTBMZHNk?=
 =?utf-8?B?RWRhVkwrMVFwcXhqTU5SZDBqRDl0RlpReTZnUUNJVFRhelVTWnpQaEFXQjZU?=
 =?utf-8?B?SkEvellpVjJmVm1mNUs4RmhoMitpNG8xK0p3cDFWNjBuWnhGWDBJVm5sMkJm?=
 =?utf-8?B?ZWZZRjZrcndOTkpQUXVQbEJZeGdRdFVObVc5QkoxV09kcitINmN5eW9JZ3Mv?=
 =?utf-8?B?K1NYVTVaaVBTRDlRUXpoL2JSMEZvenprTVBRTVlPTmczRnNaRnVjWEMvNlVn?=
 =?utf-8?B?ZFFRU2NaRU9yZVNWWmlpNkxhWngyT1ZTVUZSeW5NWjU2YUVCSVlxanJsVkNF?=
 =?utf-8?B?ZHByOG9Oa0NKZnNxT0RLVXVpTkVLNnNPbHBQU09uKzNVOERZOUo3cUhqVGdC?=
 =?utf-8?B?YmtrNDhibkVJNG1ZMUZoU1FMdXJPN2JKd1YzNG1zS0NlSmttZ1FROXBlWC9p?=
 =?utf-8?B?MExkWlBEejZBRmZlQ05SMG81Yit2MUwweWVYT3h1NGhlNXB5UEF1YjRBckdL?=
 =?utf-8?B?STg2SWdtTkZJRGxQTStPYy80Zm9yejF5SHl0ZHJHYWRnT2E5bW95eWNJaS9U?=
 =?utf-8?B?YmN5WUU4REw4cHNVZUg3bXZ0YlpjVHRNbVp0S2txWUdmUGZVdk9xcHNwSm9n?=
 =?utf-8?B?dldCc2w1MXNGcFVkb3crY2VzNU1HU0UxS240NVZmcFFiMzczV2tpUlpqZDdP?=
 =?utf-8?B?dmg3cW1NRFpQWnRDdTRGa0VsRHlWZDVXYjE4aVlJb0hmN3p1M1MrZ3JVZ0x6?=
 =?utf-8?B?Vm1EN3FFZkk0RUlIS3lTNHBkUW1HVWwwSGNJcGwwM1dMZkJabm44RTRpb0FG?=
 =?utf-8?B?L1JiYzRkTHQxWEgya0NsMDZrdElwbURTYjRxcU1LZmtpQXppYzYvQWpLNnM3?=
 =?utf-8?B?RDRkaDJXTzdjTm5mc1R5WWltK1BBbmQ1U3M4anlVb2lFMXZkQmppUGgvSEIv?=
 =?utf-8?B?b04zWTlDK3RqeDRacTBDVmZScmtERGJPQVJWU3o4NWFLK0llZHNkTW5CNDEy?=
 =?utf-8?B?RWx3blRXdVBCK284NDZBcDc1bXBuMnFIcHVMa05nSjJhSmdzem85M1U2ZkdH?=
 =?utf-8?B?UXBaRUtvS09vREQwTmd5OGF2RmwxZzdRbnFOZWplTUdneHJCOFVhWnZ1anNU?=
 =?utf-8?B?S2t0bnJ3d3FOQ0ozdk5WUURPdnlYdGZDL0lSR2JGbGd4cVN1MDk3eXIrT0Jr?=
 =?utf-8?B?RlJseDNCcnYrY0kwTHNpTmloc3BaWDJqQ3BZaERId2VtTWZaejJrYW5Mcytw?=
 =?utf-8?B?bzRpUUc0eExDaDE1ekNCL1F4Q3lNQm9YMG40Um1hb2s0VklZSVoyaWtaS1d1?=
 =?utf-8?B?cDRMV2Z1OVg0SlpSN3hhZUNlMkJUZU9jSjdjU1pOVXNqeXMxWHVtZkFTWFBZ?=
 =?utf-8?B?MDRQZXlVUzNkQUdBem5sMzZUblgwZUhNMzdPL1BTQ2lUcGE4dENacnVNbTgy?=
 =?utf-8?B?NU1yU0d2ejByeTJsOUpTQUQ4TW1TZmFPbUc0RjZFRTAxajdqZnVUSEoxdEh3?=
 =?utf-8?B?cXNVQTVTTkRqZ1M4Tkt1bTFhYWszN0pza0dvbjgrTWxHRWF0eU1LSGFGMjNO?=
 =?utf-8?B?ZE5zVmNuV3k4dldTSm1yTnlkWDUxU1RES3V5N0RxSUE5dGV6eWlBdUtOVlB1?=
 =?utf-8?B?OGRaMTdMZGRVNTFLM2pFRitmSjA5VU4vNTNkbUd3TkRWQkYvQWtjaUJiU3hw?=
 =?utf-8?B?a1h5V3ZWUGdFNHE3Um84VERHblh2dkIraUdEWDM5TXVocm0yWjhSMmE0Q2pF?=
 =?utf-8?B?Z1VuYjNNdlRFZHE1L3BnOUpHd2hZY2tFUzFXYmw2MjF1ZS9VQlhuQkRjMFJI?=
 =?utf-8?B?SFRCSWU5U3JEYUdQMEcxSmpuU3BuSmliSEVsSC82blVISFdWMVJIWEVGY2tr?=
 =?utf-8?Q?Rwo+rpAZLjhxWCGvXOQ8X5ul61eWzQoo?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR12MB9404.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(10070799003)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?VHFiaXFEL20zUzFLa3JiTVhZbCtuQVFkdm5yOUtsTEgzNWR2VzZscjFXUU1k?=
 =?utf-8?B?UnVpRnAxMUQ1MHMvbjZBMHo1NVd1WlZLeDF4ZlZ1dzBQOEdUV1pQZE16MTZG?=
 =?utf-8?B?Q1VHR3BwZkJGemRxNDRlTU8rUTAzM3hOYmdWTmVpSVRsN1FsazNOaTZ5OXJS?=
 =?utf-8?B?NVFCKzJiWDVmVHQvVjdhWmFUL2daTjV5QTJtNnFzREFNYXNMMjB5TldkTFlB?=
 =?utf-8?B?aVJRVUZ4dzNyZ3FvcHR4SC9zQXpJdnNTQ1F3NnV4TlBhcHZlSGpsNGpBcFZS?=
 =?utf-8?B?VEdOYU5yOVhvMklHSTlqT3dtSzZtd3ZpcVJlaFMycW14bEhkTDh2MENOZlVa?=
 =?utf-8?B?SUtBRUdab3FxNlI4dHNRTlFvMW5qeHU2Yk9pL3BDS0Y0eGNhUXY5L2NnUzcz?=
 =?utf-8?B?TnZ3aXpyaVdkV1l2NVBHcmRxbTcrWVNEcXJvVWRBWXExUFh2OWpka1FqQ04r?=
 =?utf-8?B?Ti9YOEUyZ3M4c1hLaENXOHErbk40NmhySWs0SE9mWEdrNmFCa3JoS3lyRGsr?=
 =?utf-8?B?Wko5M1hFYWVyMHJMMGR2Kzc0TFdGWHZLMW05bzUxNjk3dnU2Y01aRFg2cFpL?=
 =?utf-8?B?aW1EUGpMS3dPWEtGS0lNV21RU0lmQmdtSmZYdGJMelR2NVF1aGNia1dQOUpD?=
 =?utf-8?B?T2xqS2ZhVTA5eWRKYTBQMU93eFNqZHpRNUMwME5vUkFJQXliOGdsMWd1VnQ0?=
 =?utf-8?B?ZExLTGJoVkQ4RTZLMW44N1pOYkNReVRLS2l3T2F3WUlDM3dubEJGb2FkSC8x?=
 =?utf-8?B?YTROUVZHd2NHVElDbEZqYXkxTUtsdFViTVhJNEU1Z2FPbEpmSTBKK0R6eWpy?=
 =?utf-8?B?N1RCN2huSWU4N0c1U3lxTFZrRi9ZRmxJUitMSFEybjdYNzR0TEVpUXZzcXI2?=
 =?utf-8?B?d21WZW1pbWwzdXdOVFZqZUl2TEcyUWNQOEpZOFhyQ2wrT0FFcWdjVEdPbVFI?=
 =?utf-8?B?akN3OGpOOC9JZzV2dnFyc0VCdWZ4UEw5WXlKd3NRZVVaOVV2SnRNSGNoMjBk?=
 =?utf-8?B?Tm5GT3I3UWRXempveEZzU2hBYlpSMHd6UzhJdll2c3ZUb3hIWTl3K2FLeTV0?=
 =?utf-8?B?cFZLVThodWVoZThsNzdUZm83TjZJVzlOcHhZbGhiUEZ2NFhpTlEyVjJ5Wjk1?=
 =?utf-8?B?NWQyT2NFemRTRzhibXlrRkx6OVBMKzhIMGdWZFRGdUs2REJqSEx1YUhCYWdX?=
 =?utf-8?B?bjhzZTc2RXA4OU1VQVBEWm9vTXZjL2l3UENyV013ZFpobnVyTzdJdGc2dzQ3?=
 =?utf-8?B?SjMxYUEvOXMzT3h1SmdaR1EwZHQzNmVabEpVaWY0VWY0NUlZRk1Db2Y4SmxS?=
 =?utf-8?B?dVN4WGJsRTBvOVhuYWtaaG5WTnJWdjN2VFByNDRVNmNZZGs3bm5sMktTK3BJ?=
 =?utf-8?B?RHM0YnRORVhDa2p0bHVaM3ZPUlRSVisyaUZ3eHdDKy9tM0RwRHBMelA3RlR4?=
 =?utf-8?B?MDJmd0M3YmFETHpuZkpxbnBnaGpCMjlMSE9QWU84UUJEZUdnWGJSdWFnNjJM?=
 =?utf-8?B?Y21ucjY2MmQrMXhNS0Q2Q0cwK2VvTVEzWDQ4UzR6dGV1Mit6T3ZGWHpIdmF4?=
 =?utf-8?B?c2Q0VCtGUmVqUlBBNzFMa093aUk0cUYrTEVTTmNXM0Fpa2dZSk9qQktya3pN?=
 =?utf-8?B?NlJmN2tMWElQR2VUdStRZE52eFg5aGh6WkF4Q0tOcjhZN1l3VExWd3hyZDJ1?=
 =?utf-8?B?VStBZDcvVnNtbHRXMTlpVHFWajBLZVFoTkx2OXVSMENMQ2E3REh0TGlabGZm?=
 =?utf-8?B?eDIrdHJ1dFlhZjNZc2VQblkxYm9oSE1ZRXJ4cHRXWVhMK3duekxhdUxBSWpX?=
 =?utf-8?B?aVZ0YytDaEY5eVozRXUvR0crTVFqaVRyS1YwM0F0SnZMYTN0K1NLcDlXN0FM?=
 =?utf-8?B?Z2pwa1NPdW03K3ZyZjlRanpBbHg5VjdEdExaQXVSNmxpSmIzVXZkdHhqNHVk?=
 =?utf-8?B?bklLZk9LTmdFdGdKY1p6RmNSQ0s5blV4UWZkdUJPQkRnclZ4ZG1XaWlzbWxk?=
 =?utf-8?B?ZVVXOVM5b1dhYytXSHVCZHFHRUljR1lVUjlNOTRKbEZVNWhzZjRrM1FCelZ2?=
 =?utf-8?B?citJdHg4R0Y4ZXcxZXd6d1NhYkJpWUNuc1U4SWVCZzk2c3BlS3RqZXB6Qmls?=
 =?utf-8?B?Y2pwd0lHbk56VVlkai94OC93Vy8rd3JtTDNYb1cvbFc2Zmx0OGNqZ0QxcmZY?=
 =?utf-8?Q?QU+3bcbEiOy+QQLaIUDHW4zULwce8bcoVrFYBMGI4xn+?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <EDDB558C0647C142B56D2E01315BBB13@namprd12.prod.outlook.com>
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 0e2d07e2-d456-4f05-82aa-08dd665d2504
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Mar 2025 20:40:39.5157
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 1nYIuwrdxsHnBfU4EFPWFdWP5cwFAju9oDsQOcrp9nAX+7dnD+a1Qe2aVjdRuJMIuZ1nVrLpk3cn71QscahSfA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB5761

T24gMy8xOC8yNSAwMzozOSwgRGFuaWVsIFdhZ25lciB3cm90ZToNCj4gTmV3ZXIga2VybmVsIHN1
cHBvcnQgdG8gcmVzZXQgdGhlIHRhcmdldCB2aWEgdGhlIGRlYnVnZnMuIEFkZCBhIG5ldyB0ZXN0
DQo+IGNhc2Ugd2hpY2ggZXhlcmNpc2VzIHRoaXMgaW50ZXJmYWNlLg0KPg0KPiBTaWduZWQtb2Zm
LWJ5OiBEYW5pZWwgV2FnbmVyPHdhZ2lAa2VybmVsLm9yZz4NCg0KTG9va3MgdXNlZnVsIHRvIG1l
IGdpdmVuIHRoYXQgaXRzIGEgZGlmZmVyZW50IGNvZGUgcGF0aCBpbiB0aGUgdGFyZ2V0Lg0KDQpk
byB3ZSBoYXZlIGFueSB0ZXN0Y2FlcyBzaW1pbGFyIGZvciBub24tZGVidWdmcyBjb2RlIHBhdGgg
Pw0KKGRvbid0IHJlbWVtYmVyIGF0IHRoaXMgcG9pbnQpDQoNClJldmlld2VkLWJ5OiBDaGFpdGFu
eWEgS3Vsa2FybmkgPGtjaEBudmlkaWEuY29tPg0KDQotY2sNCg0KDQo=

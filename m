Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2077.outbound.protection.outlook.com [40.107.236.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 181A41EDA37
	for <linux-block@vger.kernel.org>; Wed, 12 Mar 2025 20:33:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.77
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741811628; cv=fail; b=DD3eY6UtKIbpGYgTeSu2yqSBM7yEVm7I3JFJB3Xhp2yljGA/0Wzqc6Usa84q6LSnhN+tOGJAobEAFOM3S5HiL3HB0S5Hg4ctdnQxJTEhB8tl49lddxjYJcmNn79BUXFPDOJIA2zntTAV/UYim6uZFakqaxfmcj+SCZkUtGTOFTI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741811628; c=relaxed/simple;
	bh=+AHE6gY7hpWp2Q4gg8M/gZp6GDVkrravPJXrmihLGuU=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=bzeCvLmn0N0tIFmlh2qVjEXqoQCTO6u/1lrSJOw1urOCjEMBD3z1/8WO6K6NP0dX0/8dA3aWCfg0evnImLkLFofoSo/VjyVi9xWP7Cp7GKjzLpcWinfN15OvGebMrXvTlFROugS7WaZRZfGdUDcQQd2s1mOU74VRDo/r4ohBtYk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=ksL1Rdih; arc=fail smtp.client-ip=40.107.236.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="ksL1Rdih"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tTZM5WpnhpuHIyuHZgpnLTyhKGpFoY8qaavAaQtMxD7lHOhZ94ZYL0apw+STwtN2+n6sALFVisM3/bpe8HOJOOpljG8HbX6jyiiFTbh3gUHuwG82PVLhJ76gx6bOUa5VsAEK3Uhp3PI1qqV6mOyxa3Aq22PcWWaMtKzOZgOc+hlSPZtNjapq/xkhcLwdbIEdhCNVAwgBv59pJ7Djh4iOPJRlhMuQPR4Rm68z1Ux8YaGDWkAeGGu9iZ36sEPChCFJ2Y0ESiNpfwFZNHpH1cgGL/4xcRK6IIlCkV8KfMwTcBVGYZYNlmtz3bSOD290ESnW0tf5tP0RbeEkVXbyAeH8iQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+AHE6gY7hpWp2Q4gg8M/gZp6GDVkrravPJXrmihLGuU=;
 b=xQCM5cMEsPMnpNwe+4rNzHhpycz4LdJZnvddDVNoBEskKwCKxsr64iXCekrn9CBAV6mGaom0nsIftpjw6id+jVyJVSnhCJIcGXaNKKW7T0DucEgXrb4E0QOm/7MGJbmuRFEBXqKdvc1Fxw7M0UXggcQj6baHCfr8jAgKiLLqnVnhaK6dcLgbZuMnqKzxtQ2wLj0zheZ7DrHRmdC3TKODTw7Ih+WwgGKWo5CSA2Ps/zw11aUCW/akEKQ5103H7f6wa8FOp/nYum8uU2prfPcRrXmbymupO+tFzVXb/Xi/hTCvu1C5X8nTCeQO0MzNRQjyFRF4UyiS+mIjxzWLU+8Zuw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+AHE6gY7hpWp2Q4gg8M/gZp6GDVkrravPJXrmihLGuU=;
 b=ksL1Rdih8Kt8k86epvt76OwNCDUbWQWDJiMLTDhFhKn69FE9BGukprgnzHiEfwABPSN8BAWBNRZZjX0tk3fVp3CTilxe+qFKtEwSjbEg+BfucaysZ67c82fqoQj+J8iJliLm8NIPjfFtleFiJy42hkw5P/Myk2xz11Z9txTNjCQm4r+gT/e4xeTVYJJBD+DLtrK/SoFrw7cWg2E7nPjs9ZFB+TLo0IQf2Dm774szjdn929FoTn1ilTvME9K2RUCeif9V5CbTJtPol3ckskkxgtP7u1tn9zS1uFue5C8i4mXQXmhCzyzJdYtWpA3nR3n4BPslSoFdVIW7yfCpekuspg==
Received: from LV3PR12MB9404.namprd12.prod.outlook.com (2603:10b6:408:219::9)
 by MN2PR12MB4255.namprd12.prod.outlook.com (2603:10b6:208:198::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.27; Wed, 12 Mar
 2025 20:33:43 +0000
Received: from LV3PR12MB9404.namprd12.prod.outlook.com
 ([fe80::57ac:82e6:1ec5:f40b]) by LV3PR12MB9404.namprd12.prod.outlook.com
 ([fe80::57ac:82e6:1ec5:f40b%5]) with mapi id 15.20.8511.026; Wed, 12 Mar 2025
 20:33:43 +0000
From: Chaitanya Kulkarni <chaitanyak@nvidia.com>
To: Christoph Hellwig <hch@lst.de>, "axboe@kernel.dk" <axboe@kernel.dk>
CC: "nilay@linux.ibm.com" <nilay@linux.ibm.com>, "linux-block@vger.kernel.org"
	<linux-block@vger.kernel.org>
Subject: Re: [PATCH] block: fix a comment in the queue_attrs[] array
Thread-Topic: [PATCH] block: fix a comment in the queue_attrs[] array
Thread-Index: AQHbk1+srLz2AOQ2/UGcUy45Ul6ukbNv9ViA
Date: Wed, 12 Mar 2025 20:33:43 +0000
Message-ID: <1e7e02e7-9caa-43a6-b58e-95e45d92c0c9@nvidia.com>
References: <20250312150127.703534-1-hch@lst.de>
In-Reply-To: <20250312150127.703534-1-hch@lst.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV3PR12MB9404:EE_|MN2PR12MB4255:EE_
x-ms-office365-filtering-correlation-id: cb19b967-4970-4aaf-7e77-08dd61a52e90
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|10070799003|1800799024|376014|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?NkhDWENBLzJxS0M3ZEJOTnZHWlFnSFdLZlBvRndQZUNjOTgxaWtJcWxwWjBa?=
 =?utf-8?B?cmlOSnd1eVhHQUZuQmtJeDlhNGRNODhMK1pEODF3OTZQcW5JU2RIcWdkZytB?=
 =?utf-8?B?dEJaWVloTjhxeUN1QWxUMWplWW5LUDR1Z3NucDhRdmlEYlJqc0NxOU9SOU1O?=
 =?utf-8?B?a2ZOcExxY1RoTjdiNGs3NDRYYTdKVTR2aXlzRzMxMlBpUmlIWmJtRUltOFk0?=
 =?utf-8?B?QWpuRHYyYzB4VHBtLzRtUndDbk55dXc2T0lORkZTT0p2SVEyRDAyYmZoWm5x?=
 =?utf-8?B?K0dqNzZiQURkNTBCaW9aZmhmZ3luSU5NYkw4UVA0Mmh3clppbjl5bGU2dk4v?=
 =?utf-8?B?ZStPM290S0lvb25RMTRqdTVDRlhhYjdocitBZk1Lck1zL3drOHZNSXc5TGJI?=
 =?utf-8?B?MnU4VWd1VTdZaDJXS0QyNFNQY1RodHlpUzl2YnlpU0RKc202NGQxbDdSQ201?=
 =?utf-8?B?RzViUVJIRWl3bVRLWkw0aGxIRlpSQW9CNHlUbmR0SEdtdU4wYkw0TWsvaTZt?=
 =?utf-8?B?SVdNbURrVWdTbFBZT3Fxdk9rWCtURFloY212NmJ1NUJDRG9iVXV6TTRQT1NX?=
 =?utf-8?B?amViL2svbUM0dytad3plV0Rzbk1sWWhOZXp3YkM4UWRsRVBGMi96RGJva2VQ?=
 =?utf-8?B?OEk2ZVNFWXZIL2NKUGliSWp4VmhxcGp4M1NSL1FGT1VXd1FHSHd0Y3VVYU00?=
 =?utf-8?B?VEkvUUhKYjc1eXBGOXc4ZlU1dFUzckdYTnN3Y0ZpRnlLMnB2MEM1VllIcUV4?=
 =?utf-8?B?NFdqeXZwMGpJalRuRytBRW9OY2pUck5udWMvSkY4SzRKTzkwMG8rOHJCdjN6?=
 =?utf-8?B?Z2VVN1B2U010QmRYWUZMdHhrWmhsSlk3dURYZlJOK21mT2dWMTd0aHJncWsy?=
 =?utf-8?B?SHdqbVZ1NzNWTC9jdUdpRjVybVp4ZklLV2pmekErcnhmU0hXUXpUbWtHU3FT?=
 =?utf-8?B?MWNXQS9BbUpCUmlrTWxXYnpTdlJmOTNJMGtGL3RSSnNFaW1jYjVYTlV6dUdi?=
 =?utf-8?B?ek90YUhoZitEVncvbVZqUjRkQXJpd1lCd0xOQUZwcUU0b29DYlJtelpXU24w?=
 =?utf-8?B?QWVObjVUSzRpRUQyVmJGcjZVK3dkaStRZGtFeDhzSFNuaVZIMGloQjlnZVo3?=
 =?utf-8?B?a2x0ejVjT0l3VzR5K000cjA5cFJUMGxzQXk4MGo3b09YdEhka3AvZ1kxWWxu?=
 =?utf-8?B?clFZY2c5eDJjNGlVaHpqa3pyV1pSOW1PYjZkbFJDRERuQUxtUkVMUi9VTW5q?=
 =?utf-8?B?NlkwOEJrUzd2REU5ODBlUGJPbEpGK09XVENOS2tPUStVSy9yQUdCWG8zTjg0?=
 =?utf-8?B?LzZkWjhMb2NqeGZBQUVFbFdiZ1FFMHVIVWhnMmkySERsTGpuS3ptZlk2cENM?=
 =?utf-8?B?RXdtaFNFTS9PRE4wb2VDeHUyZHpHTmxqUWFlbUxlemo3MlM4ZTZISDdXY01W?=
 =?utf-8?B?OEZFdnRleGFrSHUxQm83WnBpajZJenZnbytVUU1IUDRaVFJBWm42UkhNZkk2?=
 =?utf-8?B?T2diTDdwcnZEY2VCOWFFQ1I0R0xkOUdXNm1Xb2FKKy9xeTNnSkROQXVvS3l6?=
 =?utf-8?B?MFNmc0h6RWk2bjcweHY3a1F4VU9UdTNNRWlYNkJBKzRMWjhWd2RyUGZWL2V5?=
 =?utf-8?B?Q3VQU2l5T3lvSHJXV3VFeGJqSGUwNFM3YS9hS2JqdmVWdHJKUnRXZmdTSXV3?=
 =?utf-8?B?VjdwTklKWDNDb0NHUTYxbk5QOVpOa2tUeXQ4NkVpOTVLbDE2U3daeVVGM0VD?=
 =?utf-8?B?NEZQcHFKeVhnaG1GNDdnZ0xqQnNJUjlYS0JiTUJHeEZuejhNZW0vZld1My8y?=
 =?utf-8?B?bzUxQ1A4NytraFBHNjFOOG1BN0NjaFMwV0Rmd0kyeU1QdEErSFh6cWFjOFJn?=
 =?utf-8?B?TzlkaVB5Qm1ram1BcXNYeHpDdGg5cUx4RjAzdnM5KzFZRzNIZ2cvRDhKc0lU?=
 =?utf-8?Q?5Qx/hYvwOhvXvupsvGMW+4HjXFp4HYwT?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR12MB9404.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(10070799003)(1800799024)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?aEc3L0c2bURHbitHeE9OSlZ0eHdGN05IcXc4QnljSm5RUE9ucnJEK0I1bWVi?=
 =?utf-8?B?dWd4dEFFdVl1TEFkeE03UXY2YlhKYjVIWlk4QzBDTERTeGZPYVlDVTNva0pK?=
 =?utf-8?B?SWIyZ0pHTVJZZUl6TUN5UHBpSFlKNGhPb1lyV2NqYkhKY25tWFgwYXUyVzFY?=
 =?utf-8?B?Rjl4MW90QllleVB1eXlab1F6THVZcldXUUI0bFFXWTVlSk1oMmtPZHlUeENa?=
 =?utf-8?B?WDZvY0VHRmtlQmlCZnRxMkM0b2dVbzdyLzF6VHVpQnFLbHBoRkEwRVZzVzZ4?=
 =?utf-8?B?SUYrUzZiSndHSzUwY1JxTE5GS0NhWE5oTzVaOEZQUmlaQTdBd2ZESVFYakdT?=
 =?utf-8?B?SENrR0FERThVZlEvaFJoSHU3R05lU1NPV1pCYlVWQlhrSDlxVGY4UU4ySWNP?=
 =?utf-8?B?amdFMTc5YllpRTN2d3lDNzdNNXhMRll1eVJtN2xJZjVTT2hMUUhlTzBHM3Fx?=
 =?utf-8?B?TFRUdnNUUGVhck51bGE2ZnFScWtQcy8rRFZnL08yNTZIT3F0bkppSkd0YWJ1?=
 =?utf-8?B?a1hWYXlvcjhvemFHMkR1VzNSK25JaEN2WkRaKzFCdk1HWGNYa3NTWXJqUEFC?=
 =?utf-8?B?dDgrNGVvVkdXQ25vUFhoOGRkNnl4OS81djNzV1o4RFBDODN5RUNqa3V4TnFO?=
 =?utf-8?B?MmpoQjYyQlppMHlzZ05oUjIrcS8ycTlSb0lGdVdRVGlCcHVVQjMrbmhidkV1?=
 =?utf-8?B?UmpsM1Iyc3VyL3psSE5ZaXM0bndYS29RK2lsNlNWWVFTaTVTYUJNMml4bjMw?=
 =?utf-8?B?aXR2Um9NV01iWEVsRkVYemkrNHcxd0tUMU9mbll5ZGxrVjkyNWMwRmg4Wnpj?=
 =?utf-8?B?WlBiK0dwZkoyY2lRcTN3YktQV05UdlcvK0ZjQTU4NSsxN05SRk5DUmtwNFFC?=
 =?utf-8?B?Z2t5OWNmdTNBNlpsWGZhUERDNEMwM3E4dWtZMzNaajkxOWRLeE52cE1uQmlU?=
 =?utf-8?B?YTNWVG9wVHltQk1PYlFxOXF5b3VPU3JxNnFSZmlycVVHY2x6MjBxcEV3SWlS?=
 =?utf-8?B?OVcreWNQSkdVbmhWNmtiS0syMHN0VjhFOE5kVm8xOVpEcjRzZ2NXWkpJR2Rz?=
 =?utf-8?B?NTZ5d0dTYzNLclJ4c3UxQU5BSCtTeURHdm9VenFTVWd4Z1ptazJRbTJQQk1V?=
 =?utf-8?B?L2J2K1d2d3hmOTNxcWxPcUtscTU1SGFZQlZ1T3plQjRDeU5jSXlhc3dDVHUr?=
 =?utf-8?B?dG9ub2MxcWZrRXF1OGVIaFNibWpIQzdvTllRaHp1bDl6WWJOeElKZExpV2d3?=
 =?utf-8?B?clhjZXRpRS9IeVBqQ0VaQlJ1VVhJZVBYRGE1NWhXb0pyZFlYdVFPNGZPeFF3?=
 =?utf-8?B?S09id2xWeEYwUnViUUNXS0Fqcm9zVFRMRk9vTkFvWnczUDhsVzBvMjk5c0lS?=
 =?utf-8?B?ZTVZSGxQQnNETEp0MXFVVmxEbG1mSXpuYm5IOWR5aURKY0c0N1FVbVN2d0Zq?=
 =?utf-8?B?dUt5RU50a25tajYzMGJoQmRwNW83K1pRTW55Ymo1U0g4Tk5aRUpjRTBPUmJY?=
 =?utf-8?B?SUNpYy9uRnhGbzh3WHFmd1duVy9WVU5LOHpCNWlVS0g1MXJoWWdSa2M1OXFq?=
 =?utf-8?B?S2FreXRReTFmc2RqZndBbzFacUNJQUYyL1h6RWoyeVRPc3dmMFVzNTJyejl5?=
 =?utf-8?B?OVF4cHdVMzI0cHVPVlBsQUNVZHBzUEd3OW5NZUx6QkYwWkwvY09TbFVlSk8r?=
 =?utf-8?B?MlduT0kzdFZCTjdvdGptcE5ZNTZSV0lPZWtEU01heFFKT0VIQ0Q2bUFkZlVD?=
 =?utf-8?B?VVBxdkdjMXd2bFcvWG1USkpPS3pOS09LMUxyZFhlckY4QmVHV2Q1Z0p3VkxI?=
 =?utf-8?B?N1BqZ1cvc21LM1NXSW1qV3Rsd0tqUXlZOWR4ZUswZjYxSzQ5OGdVa1JpQjJ5?=
 =?utf-8?B?Y0N2aTBZblEvc3BML2JKMmovMFF0bnBOSDR0WDBWQkJWakVXdk8rU1RhUjdK?=
 =?utf-8?B?ekk5T1g2RlVLRzc1L1U0K0dENkxEbm1KTUpRT3oxd241dGQ0WlFIWWZncTZ1?=
 =?utf-8?B?ZThjejNIZ3dIRklHSUV6OXJVTkxzem5pam84WEhjNzZSWTVsVTBtUDVFWXhh?=
 =?utf-8?B?Y3h5b25veHFpWmszRVZnNjF2NGl0RGwvYnJkejE4YktyOWo3U0FxN0lUT3No?=
 =?utf-8?B?YitkaWF4cTVJTkJVWHhURWpqM3VVZkRSSVV3aVBJVDNjYWNRUG92OFVMWG8w?=
 =?utf-8?Q?/O6OZIqpj5noRclgX8Z4+W9yg4o8MnIUjslu8ken2ehy?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <33CFF351C6F90A41B03F12D095AF0ACA@namprd12.prod.outlook.com>
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
X-MS-Exchange-CrossTenant-Network-Message-Id: cb19b967-4970-4aaf-7e77-08dd61a52e90
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Mar 2025 20:33:43.5085
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Zn3ssH8bAdP6LgSXdwa0C4f5zDHZOMUTqQ+97I1giAr+TGCB1/Sra5JxjG18TL2mkGyMOZYr765Ur6jCCCwVFQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4255

T24gMy8xMi8yNSAwODowMSwgQ2hyaXN0b3BoIEhlbGx3aWcgd3JvdGU6DQo+IHF1ZXVlX3JhX2Vu
dHJ5IHVzZXMgbGltaXRzX2xvY2sganVzdCBsaWtlIHRoZSBhdHRyaWJ1dGVzIGFib3ZlIGl0Lg0K
Pg0KPiBTaWduZWQtb2ZmLWJ5OiBDaHJpc3RvcGggSGVsbHdpZzxoY2hAbHN0LmRlPg0KDQpMb29r
cyBnb29kLg0KDQpSZXZpZXdlZC1ieTogQ2hhaXRhbnlhIEt1bGthcm5pIDxrY2hAbnZpZGlhLmNv
bT4NCg0KLWNrDQoNCg0K

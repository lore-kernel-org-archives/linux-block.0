Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2085.outbound.protection.outlook.com [40.107.236.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CCD64D8A7
	for <linux-block@vger.kernel.org>; Sat,  6 Jul 2024 10:37:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.85
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720262238; cv=fail; b=kD0+bQSQDlY/OkhGVJa4+tdt4BOQFxown8AaSntQshDtn8Ttis6vXv9R3umtAN1L14mQOD07mdvFn/6uyEYEZEX9MzSpkQVA0pIuUYCRCXGGp1IvykWxDoaDy3ar92Qu30fc2npDRJk5hB+3VAEWSf24mhRg3E7KQd5D28S53ww=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720262238; c=relaxed/simple;
	bh=T+rvLL4i/7FsbG0v3ZNYFGhsY7W4sDZYtnvtZYHgte0=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=UItnRoVLebBneQ+rQpqSfRZJ1TwYmf4BQLEoQWwMnDKvrrFLiJu5p5EtUFOOHyg0YL+eLduUZUM4bU2cr+tY/TAbTns3KlhWUBYlqOIywFa7MSOEcstpRWPLTKZNVfYkFWvNPjHfC/qqU/CYH3WIhJP9ARi3xAhgsESciDQJ8IA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=MJ7xvPv1; arc=fail smtp.client-ip=40.107.236.85
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="MJ7xvPv1"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OmFdUYbsV5Tq6Jc4oievWgMG0OVkpYD5K9IPNg2VjvCX7eXWDa9Sj3NY7KNDgpVAIoEWWMOyX7/1TthK6bEUmKw70shvqu8ATAgiMw4T96/BYCBMhfIhnVLdGnlmnHRbN7yKceFGf0HlFL8+PAl+W1XEwb2UYdVk4MAZV6HqmIIOw6iOXMIYrbn3bqDGe2VicgDuui0ihZ6nUlbM1uJLNZxDsBsIa18tqBPK+y0aF8BfQ8icliH0Yq4Q53HgkE5FGrunBQ/j3ytmDzrZjewBW1IHSbcNBxnXCzbcenqWN8m6cESphxKYTaEHjdqYMN/ISn30VXUwi5ia3QM7d3IzNg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=T+rvLL4i/7FsbG0v3ZNYFGhsY7W4sDZYtnvtZYHgte0=;
 b=a7KK+ZEjNtfXNmCbuVXFxI9XGWlCls+OJVe+MHGK7aqsE3vgQLfmf6WIalEczVMsMVtPIhDmb6fp6PxJ003aNfARzzPmHV4yfjIn//IT3Q5psgYP47HLPEE0NCRHPn9LGWtryvWQryCDYUeGt6jh3llOJXeTd5dSSNgaRZuKGwIp1CY8D4g2N6cESBPN7BbErpJJOWxSASzSfT9aHkgAGz94s6EHeCO7DNdVy9QJU2t8MaEbgnVz6y6sVBYGe0JtV9Tm96C+FzkgfMjfXDihTVJhbFchvt+JE6qoXHEFLR1X/e7RAR7gX0rEcSMI/nwqa6noYq//ok72oD+vQcf+3w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=T+rvLL4i/7FsbG0v3ZNYFGhsY7W4sDZYtnvtZYHgte0=;
 b=MJ7xvPv1/nMX5btTJKirCyMCyFCv6uB0T5wAQJEVuELGXHFPrJfGZUbUyQ+Rg0NAARy9+zSIi2KCalLvDJcxtNLfQ8Nf13Y/kLZ1EQF4VDFAkwWGuGkv8VHOJ+i2QHkL5tBedTDFgdkMWqxhN+wIRJKx2Ivme78oJxDbRjdY0tlRm8WeKm6dB3mnw1KryRDQs957UhJ8mexqHD6jaXkuSWld1QO+JVLmkKVOMEELR7czsRQwaxDB3RbDjz/6OGKr60xWZ91JOoEpF70erado02YpkG0mxTGOt9og1SJbOdq+svRLTedIJ+RzkyiTz/cPdrEHULRLxnPRrweexDO1cg==
Received: from LV3PR12MB9404.namprd12.prod.outlook.com (2603:10b6:408:219::9)
 by MW3PR12MB4427.namprd12.prod.outlook.com (2603:10b6:303:52::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.33; Sat, 6 Jul
 2024 10:37:11 +0000
Received: from LV3PR12MB9404.namprd12.prod.outlook.com
 ([fe80::57ac:82e6:1ec5:f40b]) by LV3PR12MB9404.namprd12.prod.outlook.com
 ([fe80::57ac:82e6:1ec5:f40b%5]) with mapi id 15.20.7741.027; Sat, 6 Jul 2024
 10:37:11 +0000
From: Chaitanya Kulkarni <chaitanyak@nvidia.com>
To: Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>
CC: Geert Uytterhoeven <geert@linux-m68k.org>,
	"linux-m68k@lists.linux-m68k.org" <linux-m68k@lists.linux-m68k.org>,
	"linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Subject: Re: [PATCH 2/2] block: pass a phys_addr_t to get_max_segment_size
Thread-Topic: [PATCH 2/2] block: pass a phys_addr_t to get_max_segment_size
Thread-Index: AQHaz3l+valHZOo6CEWTtPYtvsnkmLHpgfgA
Date: Sat, 6 Jul 2024 10:37:11 +0000
Message-ID: <6ae64d5e-bc86-4c4b-bc3a-3d72e86d0dbf@nvidia.com>
References: <20240706075228.2350978-1-hch@lst.de>
 <20240706075228.2350978-3-hch@lst.de>
In-Reply-To: <20240706075228.2350978-3-hch@lst.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV3PR12MB9404:EE_|MW3PR12MB4427:EE_
x-ms-office365-filtering-correlation-id: 097f8472-99e1-44fe-b5be-08dc9da797ed
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|376014|366016|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?RzE5Vk5wMlpleDZva3dWMmxaakxaSEJyTU1YcEZ0RmVnQWpPNUpXZUVGWE1X?=
 =?utf-8?B?c0FDOWdUMklYcG5CdDR6R0tRZlNwNVZwM3d0ZVRkd2Z1R0tDWE8zQXBTQUc4?=
 =?utf-8?B?QnJBdWZNTVdvUGRaV0Z4dFRJMGFBcU91dHowQkNqbmc3a1JaZ2NGZFZCa0hh?=
 =?utf-8?B?NVcrcnp4NFZTR2hPOVlERkZqaHJ5VzFScU5nbjBYeFdUVEhiTjNoWUVJMU50?=
 =?utf-8?B?NmFxN1dKSnZTUDl5WWY0S0ZUd0dGcmEzMjhlTUV4OUNlakFRMTVvNlBtVS9j?=
 =?utf-8?B?bUZ2Tm0rVFJRNU95YU9RRk43LzNvS294VUNpdVdFL1FWckdkcDFHdmpJNXJ4?=
 =?utf-8?B?Ums4RURzZDkwRUZIZ3VvZVRrQ1pnNXc3c21Xb0ZCSHpZVlhUaHZJYStaVVdD?=
 =?utf-8?B?eGxyWjZzN2REek1zOVZ3c0duRHJkMFFCdU16SlM2KzlCdi9VVjEwQ3krTExI?=
 =?utf-8?B?NWhxd2U4a2V3S2dEZzlEK1pKejZqcEhHU0o3VXBOVXNpWm5xUXBzRHRYaUVL?=
 =?utf-8?B?M0JvODZoSFFIMEV2djh2azJtYWViSGNLVnU5QUliTE56eHUwQm9Kb3h4a1p4?=
 =?utf-8?B?V2lNQ0p3bTNaTW53Q3ZrTFA0Lzk5NU5DWUQvRXNxcGRUTVR6eWtZeUdKSVpY?=
 =?utf-8?B?Q0ljL2ZYNGFtVFZnZmgxekFFRm1lZEwrbkE1VmViY2xYR3ZPazExQWVMSDZs?=
 =?utf-8?B?cW5tNmZkaUJRUmJCK0xDdzM3ai91M3dWeVVWMUNEM1FMQVZSdkMycDdhbHBE?=
 =?utf-8?B?T3FON2Z1WldydjJzY29FeU5IcEQvTnQ4bWFWR2lhVlAyNEwrS2RsVmFLdTNJ?=
 =?utf-8?B?RzNMWUNVK0piZGdVMkRHZkhrTDhiMlo5TjBtK09vejNFQzkzN1lxMExURVN3?=
 =?utf-8?B?Rlo1V3A5MENLZE5WQlpxNTBlWERzWVNTZkMrckxVcGV3WmFKM0lWcks3cUhI?=
 =?utf-8?B?S3N2QnZRV0ZvQmZ5SWdMaHlTblU5TUNCNXJsem8yTkpzdWVTNWh4cnJ5WDE1?=
 =?utf-8?B?Yi9pL3hpN3RITy9IYndJMnBsTng4OEFjRGtHY3F4T3Q1bFF5UzlNTm5nZ2NO?=
 =?utf-8?B?ZmNQYmFsNjBRemlaM1EvMVQvS0JZTmoyLzJLU0JNSE8vUGpEY3p4QnRTa0h2?=
 =?utf-8?B?WlVGQXZ5emhrY0tzNHBoMG9aclZNSXV6WjlIL3lOcG0wczBnWXRVWjBHOFhN?=
 =?utf-8?B?MTZXaVpheW1Tb3RNVDNqRFJWeEwyVSs2ZjZLR3Y1US9qY3djWk1sTXdoR2Rz?=
 =?utf-8?B?UzZDczIrRWcrMlQwcDB2NElwODB0ZW9YNC81M09iRkVmYURvdGM0UVlOaFNa?=
 =?utf-8?B?bGdKMk40Zjg2ekpaYTZNQ0x0anRqaWFrQ1pqejVHcUNFOE8xQ2svYVFrb3k1?=
 =?utf-8?B?YXVwWFlLQS9OM0ZkQ3dyUytZYUhuampQL3lZM2I3Q2NpUUlHbkpBSXZIUVUx?=
 =?utf-8?B?UjlzN3pNUTdMK0ZXVk1ORjkwOGplbGs3VHUyVHFnOHR4aHR1cFI2dXlTcEV6?=
 =?utf-8?B?RHI1bGhqaUF2dUZ6VFBUcFJCYndUOTN2Z2p0M2Jrb254bnVtbGhERFZ1dVZW?=
 =?utf-8?B?cTFIa3A4MEdFdExjTXBzU3ZjRUI3MndNR0FYUExDRERuOEJmZ2lDTEZEaDZh?=
 =?utf-8?B?M3NjZDdxalhKT3hHTHlCd3c0cCtWbm9CeUpGZFdLcVFkSHpVbUZwYjU0SHhM?=
 =?utf-8?B?S095RFZiMUJQMFp6Z3BKZDZQbEt1eDFSVkhibTdzRkw2STdPOS9kVmZiVjBM?=
 =?utf-8?B?enJUdHp3S1pUUnVxT3ZVRGtyU1BPWTJLbkwxaDVyQkh2anBXaDM4M2xXZUpE?=
 =?utf-8?B?cDE3V1ZiYUVDeU1lMmYrek1LVTRrcDBXYmRMbmM4eE0wL3VDclpSbktDVWc5?=
 =?utf-8?B?eW42TW8vVDRCVmFhYVg0Z1RWRjZ2Z2hDcVFFZFRNdmNYbkE9PQ==?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR12MB9404.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?RHNMQ2dWKzVkU3lSYmxpdjlpUE45UytVbyt3VUx6eFNobXkxemZScVBTeEl0?=
 =?utf-8?B?azBvSWE3T0szSmpZTHVBeVZuaS90OHFabC84NURveGYxZkU0REFkQmE0OEFZ?=
 =?utf-8?B?dmNXbUc0a2NMd2RnbDVzVGc0OFJabks2UnB6eTAzcmJlSW8vWjJubXN2ZFIr?=
 =?utf-8?B?YjZDZlZ2cXR1RWN6Rmx0SWZzRHViNy92ZXRnSWtYOVZIVGxRaXNhbk5VN1F2?=
 =?utf-8?B?SXRiRHBiVHBpS1NrOHhCSUNyUVRYUkw0OTB0MmhROU95cmdzaktyd1pWV2Y3?=
 =?utf-8?B?R2s0Z2hiTHFnUS94WTc2bVR3NkVBdWlxbGVoSjZKWDY5RUxXbkpVM3JmODlM?=
 =?utf-8?B?WXYxeDJ3dFVNK3V4R3FxbEd5ZHVjM3Bzd1pXeHd6U2JjNVNvc2kwMlQ2Z2FM?=
 =?utf-8?B?RWpuYy9uNmlhVlA2TW9NdTJnc3NGRTF4YmticndXblVtNDhsajdwSWpCVWtC?=
 =?utf-8?B?NVJ4dkdpR1hkNlUvQ1ZMamZFa1luQTZkM3M3NTdUTVZUUGRnaThlRE5FZUl3?=
 =?utf-8?B?dytUMExjbFRHYUo5WmZlVmFJQksvYTVXRzM2Vnh5a0kyZGR1ZFRVNk11N1Ny?=
 =?utf-8?B?VTh3cjJJeWdQb2JPbkJPTmxlZVh3dW1vWTc0T2NOZFJvcWFCQWxXM3VKcEI0?=
 =?utf-8?B?R1ZlY05BZGZTKzJreXJhTXliUmlsWWpjV0JxS1g4TjE3OFpxYXVzNDVWZ2Vt?=
 =?utf-8?B?emlLck9xaTc0Qm1EOWhET0JFNmJTN0xPWlNJYmEwZDk2a2xOVFhaaVAxSjFK?=
 =?utf-8?B?bGc1aUFoNG1aTm94aldCanlxMktuWnh2V2RKVW43eUtzUUFNMy80Z0YvSEZT?=
 =?utf-8?B?bCsybXQrVGo0dDI0MWxXMlcyYzhYU0swVEU4SEplaFZaQWNYajAvd1I3YjdL?=
 =?utf-8?B?RUJLSGdPdzdXNlB3THYrUDRtdXhhWm5oY1NtYXhpbWxud3grVkpuc3N6a1RQ?=
 =?utf-8?B?cmgzaThObXIza1FQNWw2NHpRVlBuQ01CR2NwRldPdHpvRHgzZ1B0Vld2cldh?=
 =?utf-8?B?QlBFUWpQTEY5UndLdXZIU01ZYm9mZHRlRVB1bG9JTWg4Q0k3Nzd4SUlmZmlJ?=
 =?utf-8?B?MHljVFJxeUNkVHBhRDVxZzNTQ1lRRmVnczU2U0tMdm5LQ0FsVUc4eFFnc1ZP?=
 =?utf-8?B?UkpjY3c1QmV2WXA3OGR5TzlnMVhhQzFoUGg4MlhpTlV0c0lrdE5xci8yZVV4?=
 =?utf-8?B?M002ekg1dm1NamhtdFZJVFo2cUNrL3JWdkxIVkdIU3F4Nm8vRnNkeVJNc3Rw?=
 =?utf-8?B?TkFHVENibDFvb2xUaWZnLytVWEJoZmxoWVpJMnBVQ010NHIxVjJTYkcyNzRM?=
 =?utf-8?B?MjRqMlA3QUk3clErelMxMUh2WTk4QWU4WDMvWWJsL2Jwd1hnaG1zZW1hZEND?=
 =?utf-8?B?RjZEczAyVll2MkJ3QUJCcUpXMGIyWWcvd1JlT3pZb2ltSjdsMG1uVzdySEFk?=
 =?utf-8?B?Vk9mcytPVGhTZXdIU084Q3pISEtkQkR0UDR1d3h0OWJEODUzNzFtaGhUYVBP?=
 =?utf-8?B?YzF2Y2NuU1k0azloUjJ6U3ZKeHo5N0VhVlIzZnFxV3ExaHVpb3dPK3NxVS9w?=
 =?utf-8?B?OTBNZ0VvQlZYTkdkNSs4UXVUSVArak5JeEpuYnM0bmpGYTJ0bTFIVjZ6S093?=
 =?utf-8?B?VUpVcHpBKzYzaGJSN3RLRWF0N3FpUndyUFIxdUEyY1ZwcXhLVUJYNFZWcFZ6?=
 =?utf-8?B?eGRDbXZSV1NXVEFLaU5yc1ZzMWxuWjRleUUvS3RPTk1wUElTNUZob0FOZUVR?=
 =?utf-8?B?U09hcU5JRzdwRStSR2NwZFB0dFdjN0VlMWswcnFNdWRVUWtDb0ROTXErM1RP?=
 =?utf-8?B?SEV2b1ptenE5RGdpektUd2U1elF2cXBVTGZVbmVTV2tsUFZwN1J0SzQydmtB?=
 =?utf-8?B?VGNMdVBwYUpFcTlOaTUxVDNiQjh5d0RSSG9aZElOVUtjMWN5Qnh5SGVBLzJh?=
 =?utf-8?B?dEhLanUyejlzOVU0enpqd2FTbGJKTFBVM045cXNGNFNjTjN5UlVPbm5DZVMy?=
 =?utf-8?B?OFpHMFQ2a3hrWDhFU1EvaHh3aTJ4VTFpU0w4WXFHUnZWTjg0SjV0YU5lQThJ?=
 =?utf-8?B?dTRlb1ZQY1B5Z1lHbUt0UlpNcDFUeFhIWjF4Tm9peGlVdzlIajRrelpCVURa?=
 =?utf-8?B?VjNqcjRPTktlc1AyQ3VKU0ZiaTVjWWFIUzNWb3c5Nkkrd0JhWU1aWldNZ0Ja?=
 =?utf-8?Q?g0EWhV86CSCAorqAok4cR6BVGQ7aeTH0xFHd7bpJ+UpF?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <F9EAE4D61FC1654F920A74034CD395E2@namprd12.prod.outlook.com>
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 097f8472-99e1-44fe-b5be-08dc9da797ed
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Jul 2024 10:37:11.3500
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: at02xGG4KjZIVcDCvo5hmklO7Af+WEuM4kLeK8b2cPiQ7WmomjrO+vGOEB3CJuVrCCaM6ahd0egosYuk0EP4pA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR12MB4427

T24gNy82LzIwMjQgMTI6NTIgQU0sIENocmlzdG9waCBIZWxsd2lnIHdyb3RlOg0KPiBXb3JrIG9u
IGEgc2luZ2xlIGFkZHJlc3MgdG8gc2ltcGxpZnkgdGhlIGxvZ2ljLCBhbmQgcHJlcGFyZSB0aGUg
Y2FsbGVycw0KPiBmcm9tIHVzaW5nIGJldHRlciBoZWxwZXJzLg0KPiANCj4gU2lnbmVkLW9mZi1i
eTogQ2hyaXN0b3BoIEhlbGx3aWc8aGNoQGxzdC5kZT4NCj4gLS0tDQo+ICAgYmxvY2svYmxrLW1l
cmdlLmMgfCAyNSArKysrKysrKysrKy0tLS0tLS0tLS0tLS0tDQo+ICAgMSBmaWxlIGNoYW5nZWQs
IDExIGluc2VydGlvbnMoKyksIDE0IGRlbGV0aW9ucygtKQ0KPiANCj4gZGlmZiAtLWdpdCBhL2Js
b2NrL2Jsay1tZXJnZS5jIGIvYmxvY2svYmxrLW1lcmdlLmMNCj4gaW5kZXggY2ZmMjBiY2MwMjUy
YTcuLmU0MWVhMzMxODA5OTM2IDEwMDY0NA0KPiAtLS0gYS9ibG9jay9ibGstbWVyZ2UuYw0KPiAr
KysgYi9ibG9jay9ibGstbWVyZ2UuYw0KPiBAQCAtMjA5LDIzICsyMDksMjIgQEAgc3RhdGljIGlu
bGluZSB1bnNpZ25lZCBnZXRfbWF4X2lvX3NpemUoc3RydWN0IGJpbyAqYmlvLA0KPiAgIC8qKg0K
PiAgICAqIGdldF9tYXhfc2VnbWVudF9zaXplKCkgLSBtYXhpbXVtIG51bWJlciBvZiBieXRlcyB0
byBhZGQgYXMgYSBzaW5nbGUgc2VnbWVudA0KPiAgICAqIEBsaW06IFJlcXVlc3QgcXVldWUgbGlt
aXRzLg0KPiAtICogQHN0YXJ0X3BhZ2U6IFNlZSBiZWxvdy4NCj4gLSAqIEBvZmZzZXQ6IE9mZnNl
dCBmcm9tIEBzdGFydF9wYWdlIHdoZXJlIHRvIGFkZCBhIHNlZ21lbnQuDQo+ICsgKiBAcGFkZHI6
IGFkZHJlc3Mgb2YgdGhlIHJhbmdlIHRvIGFkZA0KPiArICogQG1heF9sZW46IG1heGltdW0gbGVu
Z3RoIGF2YWlsYWJsZSB0byBhZGQgYXQgQHBhZGRyDQo+ICAgICoNCj4gLSAqIFJldHVybnMgdGhl
IG1heGltdW0gbnVtYmVyIG9mIGJ5dGVzIHRoYXQgY2FuIGJlIGFkZGVkIGFzIGEgc2luZ2xlIHNl
Z21lbnQuDQo+ICsgKiBSZXR1cm5zIHRoZSBtYXhpbXVtIG51bWJlciBvZiBieXRlcyBvZiB0aGUg
cmFuZ2Ugc3RhcnRpbmcgYXQgQHBhZGRyIHRoYXQgY2FuDQo+ICsgKiBiZSBhZGRlZCB0byBhIHNp
bmdsZSBzZWdtZW50Lg0KPiAgICAqLw0KPiAgIHN0YXRpYyBpbmxpbmUgdW5zaWduZWQgZ2V0X21h
eF9zZWdtZW50X3NpemUoY29uc3Qgc3RydWN0IHF1ZXVlX2xpbWl0cyAqbGltLA0KPiAtCQlzdHJ1
Y3QgcGFnZSAqc3RhcnRfcGFnZSwgdW5zaWduZWQgbG9uZyBvZmZzZXQpDQo+ICsJCXBoeXNfYWRk
cl90IHBhZGRyLCB1bnNpZ25lZCBpbnQgbGVuKQ0KPiAgIHsNCj4gLQl1bnNpZ25lZCBsb25nIG1h
c2sgPSBsaW0tPnNlZ19ib3VuZGFyeV9tYXNrOw0KPiAtDQo+IC0Jb2Zmc2V0ID0gbWFzayAmIChw
YWdlX3RvX3BoeXMoc3RhcnRfcGFnZSkgKyBvZmZzZXQpOw0KPiAtDQo+ICAgCS8qDQo+ICAgCSAq
IFByZXZlbnQgYW4gb3ZlcmZsb3cgaWYgbWFzayA9IFVMT05HX01BWCBhbmQgb2Zmc2V0ID0gMCBi
eSBhZGRpbmcgMQ0KPiAgIAkgKiBhZnRlciBoYXZpbmcgY2FsY3VsYXRlZCB0aGUgbWluaW11bS4N
Cj4gICAJICovDQo+IC0JcmV0dXJuIG1pbihtYXNrIC0gb2Zmc2V0LCAodW5zaWduZWQgbG9uZyls
aW0tPm1heF9zZWdtZW50X3NpemUgLSAxKSArIDE7DQo+ICsJcmV0dXJuIG1pbl90KHVuc2lnbmVk
IGxvbmcsIGxlbiwNCj4gKwkJbWluKGxpbS0+c2VnX2JvdW5kYXJ5X21hc2sgLSAobGltLT5zZWdf
Ym91bmRhcnlfbWFzayAmIHBhZGRyKSwNCj4gKwkJICAgICh1bnNpZ25lZCBsb25nKWxpbS0+bWF4
X3NlZ21lbnRfc2l6ZSAtIDEpICsgMSk7DQo+ICAgfQ0KPiAgIA0KDQpMb29rcyBnb29kLCBpcyBp
dCBwb3NzaWJsZSB0byByZS13cml0ZSBsYXN0DQpyZXR1cm4gbWluX3QoLi4uLCAuLi4sIG1pbigu
Li4sIC4uLikpIHN0YXRlbWVudCBzb21ldGhpbmcgbGlrZSB0b3RhbGx5DQp1bnRlc3RlZCBpbiBb
MV0gPw0KDQpJcnJlc3BlY3RpdmUgb2YgdGhhdCwgbG9va3MgZ29vZC4NCg0KUmV2aWV3ZWQtYnk6
IENoYWl0YW55YSBLdWxrYXJuaSA8a2NoQG52aWRpYS5jb20+DQoNCi1jaw0KDQpbMV0NCg0Kc3Rh
dGljIGlubGluZSB1bnNpZ25lZCBnZXRfbWF4X3NlZ21lbnRfc2l6ZShjb25zdCBzdHJ1Y3QgcXVl
dWVfbGltaXRzICpsaW0sDQogICAgICAgICAgICAgICAgIHBoeXNfYWRkcl90IHBhZGRyLCB1bnNp
Z25lZCBpbnQgcGFkZHJfbGVuKQ0Kew0KICAgICAgICAgdW5zaWduZWQgbG9uZyBwYWRkcl9tYXhf
c2VnX2FsbG93ZWRfbGVuOw0KICAgICAgICAgdW5zaWduZWQgbG9uZyBwYWRkcl9zZWdfYm91bmRy
eTsNCg0KICAgICAgICAgcGFkZHJfc2VnX2JvdW5kcnkgPQ0KICAgICAgICAgICAgICAgICBsaW0t
PnNlZ19ib3VuZGFyeV9tYXNrIC0gKGxpbS0+c2VnX2JvdW5kYXJ5X21hc2sgJiBwYWRkcik7DQog
ICAgICAgICAvKg0KICAgICAgICAgICogUHJldmVudCBhbiBvdmVyZmxvdyBpZiBtYXNrID0gVUxP
TkdfTUFYIGFuZCBvZmZzZXQgPSAwIGJ5IA0KYWRkaW5nIDENCiAgICAgICAgICAqIGFmdGVyIGhh
dmluZyBjYWxjdWxhdGVkIHRoZSBtaW5pbXVtLg0KICAgICAgICAgICovDQogICAgICAgICBwYWRk
cl9tYXhfc2VnX2FsbG93ZWRfbGVuID0gbWluKHBhZGRyX3NlZ19ib3VuZHJ5LA0KICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICh1bnNpZ25lZCBsb25nKWxpbS0+bWF4X3NlZ21lbnRf
c2l6ZSAtIA0KMSkgKyAxOw0KICAgICAgICAgcmV0dXJuIG1pbl90KHVuc2lnbmVkIGxvbmcsIHBh
ZGRyX2xlbiwgcGFkZHJfbWF4X3NlZ19hbGxvd2VkX2xlbik7DQp9DQoNCg0K

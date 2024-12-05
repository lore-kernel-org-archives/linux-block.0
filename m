Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2048.outbound.protection.outlook.com [40.107.100.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28F641B4F3E;
	Thu,  5 Dec 2024 07:49:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.100.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733384981; cv=fail; b=C5CX404kq9IBXfN1aDaTrMV9I6jyMD03U9NedXBYY5qKSUoqfb6dkge4No/rkiCihoAD6SnbXN+EsOuK/ldOiBWhhkiZWEDUKyf68ic6DlvnH9w59wVQb4a9QC1Ha80iX5XR9gCnKci4tILxe0d7J7k1M3jG4wmt8Z3heqxsd/0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733384981; c=relaxed/simple;
	bh=rUjgtMyUXBNsEx357arY1sHjtBHofS8ISLE+yqhp8Os=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=oMhu/JKkhTjoIlsgdP9htHY67w3MdGPgQfywKgfrn4gULIlw1a5e8nSMp4l11ZjKVoDwb2MMbRjbC2I6FMKSFsIvRX6uXda336d9IrPvwxlL9zXhsmGQsrXWxoTTkl/ZOtHzS8cLGN/FaGrhH+pP85ZeWEV0bOY3elsfjvkTmWs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=bpv6HQ1N; arc=fail smtp.client-ip=40.107.100.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="bpv6HQ1N"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=n6o+hunJDMqZ/TB4lDvi6isUwsXTlFFJ1kQtQYlA6Jvl7Da212ZI2KOPCmdM33CMdRKlCiCW4loztRSdWtu+xcutV9JpmWnbMQEnECu19D1V6pVJxsidAHK6YTJ1tj/mLJqXTPbEm1rnOLFX1/CZy9mnvK1Q+ZmvLMkvxf4Nx1S1m2DvK17mG8a0kcZFShCoOFSp4EOaj3Yv99J+2vc0+gbdF7rQMVKMdWBUNgAMl5pADNWpmYYS2+Ud3ti3JRvu2H+1z4IftFGm45HagJpwAXehSG6qk1PGIqQlK9Pw4NzgzGsdCqrHquwVDAFpQ4eCAXM7BLCeLIEvvzhFSM6YdQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rUjgtMyUXBNsEx357arY1sHjtBHofS8ISLE+yqhp8Os=;
 b=er2+q6skH4YKa3zKOb9kp+cfBreryU4+DsnJNA1sJdWZWgZejzYp6IXusf9tcLAsn73vEnehSMPVPSy6RGpYxj6gpGMTTywD+5XPJpcsR4AQCEDy2oqKgyukMmUj2M4AgC8wRGARwieUO1GmZXtfltqj7NlB85ldVTGNLI7pTEyIL9CWlIKs3CWeWNI5Nfyzq7iCRRYEG8EzGMZSC4vxCDSSBYDF1/W9Bh+sfFPvQjPcZG/1qTJEx+9XP3HcgV12EHtlBaGQMxqODxDdtGfJbrwvuVFCY8kaE9G7jXDB7sWI0zLz+Yvxav2EdaBeVa5nacEplz2D9epYpXq/N2uYSw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rUjgtMyUXBNsEx357arY1sHjtBHofS8ISLE+yqhp8Os=;
 b=bpv6HQ1Nn9/SF7F1AC3BjC44IAAZCEplnDb0P7gEuIAZK4HQ2Lkgsk6K1gA8KWHbWe6jblFLcd2Tqnz9tLVvtXSPZhL/pE/r/+gI+0ThHZ6vWwmWh7n9KW2k8BUko0MGExB0HT5snwI7FhkpE+FBmYh7KOLCJhLjKGcsEvJKKIJ/j8RpOJOiw91wwEdWfSw82EiMaBzO9+gGG3ttmlgflgXFB8H7lo/sNhPXZXV5P5HvLNzTIeKaHADY7cV//pBhb+wU6+zG55umTMjfDmn/jFblzghjv95MisSI7Ek62+SXgTHYx22TG2PLrTPNA6j3LRrE3fQkPU2UOV8nq3VQuQ==
Received: from LV3PR12MB9404.namprd12.prod.outlook.com (2603:10b6:408:219::9)
 by CY8PR12MB7753.namprd12.prod.outlook.com (2603:10b6:930:93::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8230.11; Thu, 5 Dec
 2024 07:49:35 +0000
Received: from LV3PR12MB9404.namprd12.prod.outlook.com
 ([fe80::57ac:82e6:1ec5:f40b]) by LV3PR12MB9404.namprd12.prod.outlook.com
 ([fe80::57ac:82e6:1ec5:f40b%5]) with mapi id 15.20.8230.010; Thu, 5 Dec 2024
 07:49:35 +0000
From: Chaitanya Kulkarni <chaitanyak@nvidia.com>
To: liujing <liujing@cmss.chinamobile.com>, "axboe@kernel.dk"
	<axboe@kernel.dk>
CC: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] block: Fix the wrong format specifier
Thread-Topic: [PATCH] block: Fix the wrong format specifier
Thread-Index: AQHbRltrhNGmF4ZgVEmF38C+OcverbLXR7wA
Date: Thu, 5 Dec 2024 07:49:35 +0000
Message-ID: <16b70aac-fc5d-4aed-934d-19cb5ead1b8f@nvidia.com>
References: <20241204144502.7960-1-liujing@cmss.chinamobile.com>
In-Reply-To: <20241204144502.7960-1-liujing@cmss.chinamobile.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV3PR12MB9404:EE_|CY8PR12MB7753:EE_
x-ms-office365-filtering-correlation-id: ca2d0be2-e224-477a-2715-08dd15015ceb
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|10070799003|1800799024|366016|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?bC9tZnFjdHdxUGRoa213TW9EOVU1QmdnMm4wZ0xLOUgzZjhkNjdYcEtaR3g1?=
 =?utf-8?B?bUc5N2g2TWVoR1JZK2Zwei9JTmZlUE00d1k2V0ZzdUVEZjNBTWpqTm5TZTdG?=
 =?utf-8?B?QkdQcXYwdU5GQTRmek9RQ2YxNUY2UHNvUVRYQ3U2L2k2WEhnRG8xMk1tMkZE?=
 =?utf-8?B?VUxBNGs1a3RkMld3cDA2bUVidDg0Q25uZzU5Y2ZzazRYTjk0dXVydVFkSitw?=
 =?utf-8?B?dVo4dHFFZ0ZMNFV0bEJoY3hZYklwbkMvb2VabjRSdkIwdWxUM2dmdEU0KzNB?=
 =?utf-8?B?UlFYcSt1WnFBcXp1cjlaU1NwN1BRQjh1KzQwaGRycDhYWE93KzFjcmxGdFVU?=
 =?utf-8?B?a3o4emZ5TTBMamJCRGlkai9nd1ZOdExoREl2U2NWckM3WVMwSm9pTGpNKzZT?=
 =?utf-8?B?K0hvWXRjQzhxbVZWbnQ2Z2FHZ2tBeks0bXAraFd4YzRSUTVqRWtGNmZVdFM3?=
 =?utf-8?B?YXFGWVNZRHBkQ0ZKYWVUTHI4VnRJc1RWUHN2YXpTbkV0Rm1pNGFYd3JySi9Q?=
 =?utf-8?B?cEpQM3BsVXc0VXFlcUxVMjY1a1dDVTd4U2oveDVBZkJMRE9zNE1LQ0plK1li?=
 =?utf-8?B?TXhLUytnNkQzMWpqMlAwZzlpejZPU1lmenF3VW1kZm15R3JpeHFiVjJKUWky?=
 =?utf-8?B?VFllZUticGowckNmYjdqSkpVaVBXRC9pZGJzRjN4UjZhaXQxYjJ3dzl4S254?=
 =?utf-8?B?NDY3ZFp5aUJrWVBhTGdnelpDL0I4UUc0eWZNMVk3dksrVzJPTFJ6ZjFoUlUv?=
 =?utf-8?B?azl5QUM1RHN1MTB6aVRkZCtKbGs1SGZ4N2UvM1FDVmVOcmlSOEQ2T0FMblZC?=
 =?utf-8?B?cXdZWkVVWWZyK0R2ZnJzVUtHcThsS0JKM0Q5RVFyVW5tVktqazBkd0dUZm5M?=
 =?utf-8?B?RkVwWjU3dGxLd0hxK1lkeEFzWlU3ejZpR1g1VGViVXNnSVQ2MFFicEVsQlc4?=
 =?utf-8?B?R3RuQVBYQ1lBM3ZTQzY1bVpYNElPdFJqV01WOHRkWG5ZR0dINTd4VUJTcU4r?=
 =?utf-8?B?QWVNZXBtY2E5WERGczZsT1BTRW5tSFY1dFlMVVhZR2kyZUhHZHB2clErb2gv?=
 =?utf-8?B?S0JlbDJDZWNqdEZaY0Nvem5ETE1ha2g3NU01QWgyZTRjeGZSSEtUN2txcDFs?=
 =?utf-8?B?bGJnU0F5VHhQREh5RTlUckZzWmpvckdycWFCV0UzeTZrQitDT0hmblRVRzBG?=
 =?utf-8?B?N1dWY0U5YU50YSthOFRTMnJVbjJ3cWZCdHBQY01ZVkJhZS9nQkZmZ2lScW5n?=
 =?utf-8?B?a2s4TU1haWhLQXlPWE9VN0ZuUzZ5MWNFUVhsMmJIRG14amxVNmRKRDhKd3My?=
 =?utf-8?B?Unl2bzFXMlN4eGFackFoRWFKa05WVXg4cURFUVNwTEdzK2VldzhPOXFwTWUx?=
 =?utf-8?B?MG9GcWZkb3czeExqMVN2LzI5YnV2eVYrNFV0VjBoQUpzeHN3dk90VXkrcHZk?=
 =?utf-8?B?eFVGZnZ5VG55REhKWDQvNkRBTmdxN2ppVVRoVEdpTkxNV2N2Z1JTZ1ZhUVdV?=
 =?utf-8?B?WnhsNGNRNzdhV2FMdTBQQlFvazdVTTdyWVlDa2owaWhDVjA0UWFKekR5VGRz?=
 =?utf-8?B?RFhGdEVvb0hPYmdwTjBRQlROYkRDdnVRQkFTVGJFT2tyNndGZ0RZeFRZeXNR?=
 =?utf-8?B?eVEzbFZCclNLMWp3MzhEYnpCdWVCSjVMVy9WTG9nRUlVQnBONkFhS09KdnJw?=
 =?utf-8?B?ZTJ3UHhTelVCNlEyem9IZUk0Q1NFOU83azZuVXB6R3Y0eFVkUW9KUnBKbjZx?=
 =?utf-8?B?QzF6emEyNjlTd0ZWSUV3OWRHc0lhTmxVeTcvazhWMldOTE03bWRYek45MnN6?=
 =?utf-8?B?VER4bExNZUE4QWh4YUc4eUZsLzd4Y1pjYXVCK3pPRjN1NTUxQUdpUDJRbHhv?=
 =?utf-8?B?SUlIazErMk9rUzI5S2sxQmF2bjVnS0FZc0NlU0UrTTJxSmc9PQ==?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR12MB9404.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(10070799003)(1800799024)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?NG81Kzd3S2xwUXhBU0QybytSeXJ0Rk90ZGpaV3J3c0t6UmU3NGU0UzhidDZk?=
 =?utf-8?B?d1pTYWxudzhVUTFjaUk4SURlbDNwZ3hZbE1RSTk3VEl1MHQ3VGkzMWp1VW1H?=
 =?utf-8?B?ZE9IVWhreW9BOENBYWVmaHphclZRNDcya2NtWjFscHpMRXNwOVVxSlR3NUVQ?=
 =?utf-8?B?SW51ejF1TzRJam9iTytJVnVMQSsxK0JOYXN3ODdueFlCUlQvcXdEWksxT3M4?=
 =?utf-8?B?eVFhNTVFNGpGOWJqc3psSmJzZU1XZlUrVkVyOEU2WmJ6b29HWTFkMncwUjRF?=
 =?utf-8?B?MTZEYzEzeEg4ek1Lei9XNjN5N0NqZHU2VUoxNG1wYmZ5Ym9jUk1nbWp2ZDh3?=
 =?utf-8?B?YjVRdFhWQkVQaTdTMG1NRjJ1RnJVUGFYZGJLbU5iYUhacjNXVVlxdHNycnFY?=
 =?utf-8?B?T0NSYUFyV2NqTnBmWXFkaDBsQ2N5eFhYbGd3dGhoTG5GRzdycXpLU1QwbWdP?=
 =?utf-8?B?Ly9kTkVCTlBOOGxzdmlnZEFDd2w5KzhzTTJxOGphdmljcSs5R0trNUgySEFw?=
 =?utf-8?B?OXpyeFVKZ2wwbWlVZEMwcWxsUzlZSmJ2b0xsd0tqSkhQbGFGY3pNTDFvSmxm?=
 =?utf-8?B?blg2dkpVZ3k0REhIM3VDdG1WWDNreGFDVHZNTXNSMlBWWXpXdmhmMFAvbkkv?=
 =?utf-8?B?STVwdnFnQzUwNHFoVzFNTVRzOGdxNFF6ZGN1ak1SSnJ6VVFyNG10S2xCb1oy?=
 =?utf-8?B?SlZYQkhGWmRiMjR1bTJUaWlPZkI4ekRZbkJpM3dEdnZGZU02NjJIL1laSTUv?=
 =?utf-8?B?T2dqZXllNGpybE9RbEpKQmpueWgvZDQvVUxHZXFqazJBRkF4RVNHaDdKWUFP?=
 =?utf-8?B?TGsxWnB4cmFUeHFhZ1ZiN3dMWlRzNFBuN3hsNkNGS0ZaZHRyaWxxL29qYjZK?=
 =?utf-8?B?QkF1OE5LV05UMkFKaDIyeHo4bUs3OG5aLzNLWEhkQTRDS1JHUFo4cDQ4c0Vo?=
 =?utf-8?B?VFhyN21zcy96QzFuNjNWOHBOWmlLTlRqeHd1eU5mUDBVU2ZKV3hJZE9LaVB1?=
 =?utf-8?B?QTJFdTVSMm1FRTBNM0IyTTFLUEh6bGI0b1daUm1sM1VPT04xQ2lOZGJ4d3Zj?=
 =?utf-8?B?QjREbG5XbWNsd21ndEtHY3Q4OUpqYkFIWUFKbHJVUSt4eThwV01qVGNhbVBz?=
 =?utf-8?B?cTlEVjJLWjJvRXNvcnR3VEQ1UFNuNlQ0bktLWkxURjR4S2M0bDB3SEhFR05w?=
 =?utf-8?B?NDhlSmxWTitHdFAySnlFdmozQjZYODF4aG1zeFJJQk43ODNRZnNKbkR4QjZy?=
 =?utf-8?B?dW9MZHU1aXpxREhMS2VNd0Eva1lRMnBUbXpkUEQ5ZVVOS3pVbTgzTmF1bnZ1?=
 =?utf-8?B?V2pxWDZvVlY0NHNXUXVXSms5dDJBQzNwYW5TdjBacU9KZEp5azdJMU5veVhI?=
 =?utf-8?B?V05sTm44ci82ZjJFemVpRy9hOHJrRWtiNWRyWitVKzdQbzNLVmxuUWlCL2th?=
 =?utf-8?B?UEZNSXZnVmp3Z0RQQmpjV3ZHcTFDbld5YnlwSndZbDVrVW5YdVpZbElGcCsv?=
 =?utf-8?B?NEZqVVowMGdnT05kZGJ2Zi9SNGhBL050M0ZyRHRhakdra0FTdy9nTDZjZFF1?=
 =?utf-8?B?bWMyMmIvNm1wMjRCcEJvdEdtZHNra0NZMU5EL3NXQTlYWGFWVkMzMEE0ZWk2?=
 =?utf-8?B?cHYySzlmT0JHbVBZTXNscTQ2blhXZzhTLzFTeG1xR01RalhZNnhhRVdHQTBl?=
 =?utf-8?B?Vnl2dEp3bG9WV1RqdEZJVFBWQlZ2UEJJK2E5WllIWGJWelQrS1V5UHdhY3hN?=
 =?utf-8?B?cmhrN1BPazBmZ3RCSDJQQkxJbTQydVhMMDZoYlBydzloaUhYcEFwTzJ4NWs5?=
 =?utf-8?B?L09nT0NnNG9MaHZkalg2aVFkRWxjWnRUMmQ4ZVVhRUlqQzAyaVd5VDA1d3kw?=
 =?utf-8?B?SzZNTDh3SFYvbmozbE5YS0lJTEJKdnhOb05raXYvOGh4QnNhZE5SdVpZNE5m?=
 =?utf-8?B?OFIrdmlLR2dqNGphSjJTV3B5ZE92cnBMOGxCcDI3WWpQZFMvaHEvNDUvN2NZ?=
 =?utf-8?B?WE12VkQwbWxGTXZ3RkIrRm51SkNkMDVPN0dLZHZsMW1PQWh0VzdDbytiazVn?=
 =?utf-8?B?dnpHRWJ0a0RPYlhHWittRTE2WnFOdC81KzRLb3FvcUFCRGlZY1VoUkdkMk56?=
 =?utf-8?B?NGNZNWs2QnZyVVFuK25FRlhUNEcrbGtraHpDbk1ZZkRuZUZPSFdWTFNoVHFy?=
 =?utf-8?Q?UiB1CW8n1yrX7VGIvj3ia2lxNW60W/ulmIGu2tMf3GDU?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <B3C661AD10A7614F92146410BF91A9B6@namprd12.prod.outlook.com>
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
X-MS-Exchange-CrossTenant-Network-Message-Id: ca2d0be2-e224-477a-2715-08dd15015ceb
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Dec 2024 07:49:35.4377
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ZEnoJgbeYgGfhZg3wN9y5J7Rl6gjNqRLK93o1U/KAW25pRVSJY1jnxbXEpe0k3KrjvVat3X59jSmQ7DEZzrX+w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7753

T24gMTIvNC8yNCAwNjo0NSwgbGl1amluZyB3cm90ZToNCj4gTWFrZSBhIG1pbm9yIGNoYW5nZSB0
byBlbGltaW5hdGUgYSBzdGF0aWMgY2hlY2tlciB3YXJuaW5nLiBUaGUgdHlwZQ0KPiBvZiAnc2l6
ZScgaXMgdW5zaWduZWQgaW50LCBzbyB0aGUgY29ycmVjdCBmb3JtYXQgc3BlY2lmaWVyIHNob3Vs
ZCBiZQ0KPiAldSBpbnN0ZWFkIG9mICVkLg0KPg0KPiBTaWduZWQtb2ZmLWJ5OiBsaXVqaW5nIDxs
aXVqaW5nQGNtc3MuY2hpbmFtb2JpbGUuY29tPg0KPg0KPiBkaWZmIC0tZ2l0IGEvYmxvY2svYmlv
LmMgYi9ibG9jay9iaW8uYw0KPiBpbmRleCBhYzRkNzdjODg5MzIuLjNhNzVkZTQ1MDc5OSAxMDA2
NDQNCj4gLS0tIGEvYmxvY2svYmlvLmMNCj4gKysrIGIvYmxvY2svYmlvLmMNCj4gQEAgLTg5LDcg
Kzg5LDcgQEAgc3RhdGljIHN0cnVjdCBiaW9fc2xhYiAqY3JlYXRlX2Jpb19zbGFiKHVuc2lnbmVk
IGludCBzaXplKQ0KPiAgIAlpZiAoIWJzbGFiKQ0KPiAgIAkJcmV0dXJuIE5VTEw7DQo+ICAgDQo+
IC0Jc25wcmludGYoYnNsYWItPm5hbWUsIHNpemVvZihic2xhYi0+bmFtZSksICJiaW8tJWQiLCBz
aXplKTsNCj4gKwlzbnByaW50Zihic2xhYi0+bmFtZSwgc2l6ZW9mKGJzbGFiLT5uYW1lKSwgImJp
by0ldSIsIHNpemUpOw0KPiAgIAlic2xhYi0+c2xhYiA9IGttZW1fY2FjaGVfY3JlYXRlKGJzbGFi
LT5uYW1lLCBzaXplLA0KPiAgIAkJCUFSQ0hfS01BTExPQ19NSU5BTElHTiwNCj4gICAJCQlTTEFC
X0hXQ0FDSEVfQUxJR04gfCBTTEFCX1RZUEVTQUZFX0JZX1JDVSwgTlVMTCk7DQoNCkluZGVlZCwg
bG9va3MgZ29vZCwgYnV0IHBhdGNoIGZvcm1hdCBsb29rcyBsaXR0bGUgYml0IGRpZmZlcmVudCAu
Li4NCg0KUmV2aWV3ZWQtYnk6IENoYWl0YW55YSBLdWxrYXJuaSA8a2NoQG52aWRpYS5jb20+DQoN
Ci1jaw0KDQoNCnN0YXRpYyBzdHJ1Y3QgYmlvX3NsYWIgKmNyZWF0ZV9iaW9fc2xhYih1bnNpZ25l
ZCBpbnQgc2l6ZSkNCnsNCiDCoMKgwqDCoMKgwqDCoCBzdHJ1Y3QgYmlvX3NsYWIgKmJzbGFiID0g
a3phbGxvYyhzaXplb2YoKmJzbGFiKSwgR0ZQX0tFUk5FTCk7DQoNCiDCoMKgwqDCoMKgwqDCoCBp
ZiAoIWJzbGFiKQ0KIMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCByZXR1cm4gTlVMTDsN
Cg0KIMKgwqDCoMKgwqDCoMKgIHNucHJpbnRmKGJzbGFiLT5uYW1lLCBzaXplb2YoYnNsYWItPm5h
bWUpLCAiYmlvLSVkIiwgc2l6ZSk7DQogwqDCoMKgwqDCoMKgwqAgYnNsYWItPnNsYWIgPSBrbWVt
X2NhY2hlX2NyZWF0ZShic2xhYi0+bmFtZSwgc2l6ZSwNCiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIEFSQ0hfS01BTExPQ19NSU5BTElHTiwNCiDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIFNMQUJfSFdDQUNIRV9BTElH
TiB8IFNMQUJfVFlQRVNBRkVfQllfUkNVLCBOVUxMKTsNCiDCoMKgwqDCoMKgwqDCoCBpZiAoIWJz
bGFiLT5zbGFiKQ0KIMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBnb3RvIGZhaWxfYWxs
b2Nfc2xhYjsNCg0KIMKgwqDCoMKgwqDCoMKgIGJzbGFiLT5zbGFiX3JlZiA9IDE7DQogwqDCoMKg
wqDCoMKgwqAgYnNsYWItPnNsYWJfc2l6ZSA9IHNpemU7DQoNCiDCoMKgwqDCoMKgwqDCoCBpZiAo
IXhhX2Vycih4YV9zdG9yZSgmYmlvX3NsYWJzLCBzaXplLCBic2xhYiwgR0ZQX0tFUk5FTCkpKQ0K
IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCByZXR1cm4gYnNsYWI7DQoNCiDCoMKgwqDC
oMKgwqDCoCBrbWVtX2NhY2hlX2Rlc3Ryb3koYnNsYWItPnNsYWIpOw0KDQpmYWlsX2FsbG9jX3Ns
YWI6DQogwqDCoMKgwqDCoMKgwqAga2ZyZWUoYnNsYWIpOw0KIMKgwqDCoMKgwqDCoMKgIHJldHVy
biBOVUxMOw0KfQ0K

Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.85.62
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793494094;
	b=rpshe09Hv4ylbKnulFgFL5nCh2ELw3T2ajNvpcTvDNLccYhsm6m4h3Uq+c9b6WZUa1MT
	 xfLdSfk+6PLFzoAkO55c3Ld4IBer8JFhEywNhucB4S/wG3Pp15bCkbacQ4rEHCOD0aeCm
	 WM41uKUJqMHrl9ddFb0ddtEKwoRkzVNHzTQHUPndkTWnTfl4gNEbSIvgaOAak0qb6g5il
	 Gu0SkLyeXpkkHwpygeBD0JeeDX60gNKPTnmVxFKvNKeYtaIHbqGVSKxIj9hMYPCq8Xa6a
	 BvDlzsTmj1gAiEPli/fK21k6pPNlbSwY4dP0a/YCf7qIKrbBBHM/PZD1pzwNgpo6k7A==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793494094;
	h=DMARC-Filter:DKIM-Signature:Received:Received:
	 Content-Transfer-Encoding:Content-Type:Date:Message-Id:Subject:From:
	 To:Cc:References:In-Reply-To:X-ClientProxiedBy:MIME-Version:
	 X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:
	 X-MS-Office365-Filtering-Correlation-Id:X-MS-Exchange-SenderADCheck:
	 X-MS-Exchange-AntiSpam-Relay:X-Microsoft-Antispam:
	 X-Microsoft-Antispam-Message-Info:X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:
	 X-MS-Exchange-AntiSpam-MessageData-1:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
	 X-MS-Exchange-CrossTenant-UserPrincipalName:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=Jkl6KJhNPuKiHhWTZB98cRR7BnsO7r93WistNrnnAnY=;
	b=5UMU3/gBiJCDd19MSkyDeWUhtWt+srZiDspcuKXTwk4XP14UTGiP4aLwOcKyJmRMikqw
	 /zYpQ+n/+B9lS/YADY5p4KrwHrFsBrmMmPBytlF/CGyaGacb6MGO0N7Gxs2CYT+aK+DQf
	 WM/3ljlyvQLOmUmipOnG3zUXvN7xsreTP5Faq8NRZwzJ1vNTYdMfgCmPzKb0Yl+EBYh59
	 ZQF5lTtSqZjgawtFKU7ASna/XMIfD0DZ8sP9KDFjFgfuwR8bZY/MwBlQ9ZTokS7wnASoU
	 WwoDSktloMj/HGrstGAB0Vcm/OHNindsFrjQRIsvMYcHsKTkP/et2SbVKdV8YStChlg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nvidia.com;
	spf=fail smtp.mailfrom=nvidia.com;
	dkim=pass header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=QsFGNFPm;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.85.62
Received: from BYAPR05CU005.outbound.protection.outlook.com (mail-westusazon11010062.outbound.protection.outlook.com [52.101.85.62])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE760606A31A;
	Sun,  1 Nov 2026 00:48:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BE760606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=QsFGNFPm
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YmolrTVPjdE6bB5QszSzyEQvoLzcUiHJh0Z/xHAJg1NtPW2y1mPCvFBfAAgncAbFhLJR0iw8RuF1pfgLzybUVAbZcYz5CwW4L9JBSIaRC28mNe7h4ZUyAbgTGr1+8baTw5dX6SNM2/y9EU702HR09xojGvQbhMygtjVtGBt5+k8NqjxoMarOtJ2YAYLp59acS5+z++bRaRjjJdOzJxXeWWw5ixWKON+hqnOxEAuMN7E2bCB+j8QnXyzRNBZ2dx6SXv7zoRJ4U56cF+RutSJ0GLxsYyC8vLlV73DIL1ap+0+H/yUxxmlL5P35kVQheaBkV71K6tfWj4uo1ifK9ATNag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Jkl6KJhNPuKiHhWTZB98cRR7BnsO7r93WistNrnnAnY=;
 b=T8fkh0a2Sg4pnTYF8BjC932H6jqOR9z/nbJ7MM96l/41AsMOvhBZDgMhEW4Fvly21nIvHUfKK5btTjFGkMfU4bWQOG6Qg8ddoWmyAxpFAVdj1UHPUNWso7jacMzrrH3ew/8a6dIhRQdOcSYZNJVMpnk6fu4U0pcoV4Y3iD77DcitqgaqwQDoSa8Iua/wgXQKgUfL1qKapl7dLdbOMRuNn9qAkBWJyDu19hXYSM2/DXx2NK8Kmdtg/P3xWWhG/l5qmopbsREBRuscE6IpTinuPgjaz3y/G01e9CJNT1V+BYkNCXh5G5WowOgoY1QozXv0d/RcL8v+aYM6A+B2tJE43Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Jkl6KJhNPuKiHhWTZB98cRR7BnsO7r93WistNrnnAnY=;
 b=QsFGNFPmySvlBqk3iXQfmi5hN+9fX0vqajaC8SQB7w6VygAIoPHBiFUQ4vOpvc9ZN8pl4HFS2RORtWO2es67IOIzqX4BGbXb124lbKIkz2yH6XZ2Ggc2z5uxFjt2dV1GdludwSJmWTaW5fSaucJylLwe3vDS4U1AbuXzsZ4vYhIvaiMCOjxD4YPvMmiji+9e5Kp6+LSs4aUJqF/QxcG8zUvEQtzyW1dyaASzX72Z/oz49Bf51aPyA9V0H+B175wRNIgbdF+3HIxNuFq2B1Ld3fHmtZH0O43ueiJbESQFsKas1/54HiXM3hvbjEHQ7qkoCgX3eru9vXUCpD55DBzYVw==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MW4PR12MB6873.namprd12.prod.outlook.com (2603:10b6:303:20c::17)
 by SAWPR12MB999267.namprd12.prod.outlook.com (2603:10b6:806:55f::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.11; Sun, 1 Nov
 2026 00:48:10 +0000
Received: from MW4PR12MB6873.namprd12.prod.outlook.com
 ([fe80::a338:bd2c:3a38:ece1]) by MW4PR12MB6873.namprd12.prod.outlook.com
 ([fe80::a338:bd2c:3a38:ece1%5]) with mapi id 15.21.0569.010; Sun, 1 Nov 2026
 00:48:10 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Sun, 01 Nov 2026 09:48:07 +0900
Message-Id: <DMJGLDDKA84T.34HT9JC8SSZG3@nvidia.com>
Subject: Re: [PATCH] rust: bindings: derive Zeroable for bindgen's opaque
 array wrappers
From: "Alexandre Courbot" <acourbot@nvidia.com>
To: "Sasha Levin" <sashal@kernel.org>
Cc: "Miguel Ojeda" <ojeda@kernel.org>, "Jens Axboe" <axboe@kernel.dk>,
 "Linus Torvalds" <torvalds@linux-foundation.org>, "Josef Bacik"
 <josef@toxicpanda.com>, "Boqun Feng" <boqun@kernel.org>, "Gary Guo"
 <gary@garyguo.net>, =?utf-8?q?Bj=C3=B6rn_Roy_Baron?=
 <bjorn3_gh@protonmail.com>, "Benno Lossin" <lossin@kernel.org>, "Andreas
 Hindborg" <a.hindborg@kernel.org>, "Alice Ryhl" <aliceryhl@google.com>,
 "Trevor Gross" <tmgross@umich.edu>, "Danilo Krummrich" <dakr@kernel.org>,
 "Nathan Chancellor" <nathan@kernel.org>, <rust-for-linux@vger.kernel.org>,
 <linux-block@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <27b58e47-723b-4d67-a1f0-ccb8b0ae66a9@kernel.dk>
 <20261031152846.746656-1-sashal@kernel.org>
In-Reply-To: <20261031152846.746656-1-sashal@kernel.org>
X-ClientProxiedBy: TYWP286CA0030.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:262::20) To MW4PR12MB6873.namprd12.prod.outlook.com
 (2603:10b6:303:20c::17)
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Post: <mailto:linux-block@vger.kernel.org>
List-Help: <mailto:linux-block+help@vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-block+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR12MB6873:EE_|SAWPR12MB999267:EE_
X-MS-Office365-Filtering-Correlation-Id: ee4279f3-0d5e-49ce-5cba-08df37b1cd35
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|23010399003|366016|376014|7416014|10070799003|4143699003|11063799006|56012099006|261009223027099003|261028144727099003|261026121527099003|261021121427099003|261026140227099003|261022105027099003|261022075727099003|10067099003|22082099003|18002099003|6133799003|3023799007;
X-Microsoft-Antispam-Message-Info:
	wBpPTFC2Ps0Fv46tMEabJT9WBBbdbTUAupyCIAfT19dqOd9haOQh0wqa/0rf1x8bTyy0QzlY4+Zps4j/XAf1XwZef0tgcRV/A6dHbaGr4JTRZcWZYEakqQo8OqZCZOh6r8h7kh0v6UhQk7jqFbyDTWYg1b4J5J8qj7yTG9lyDIXZSmnnCahgPJgmv8mcNt9NsvzwDMI6oJy6wF0mybCWFkIzSZDMlFGFjxG4gKgs+k6hxd/7kbcS68eWfLLkQxWfbFR080BgqzZIQDpR9UPvAX85Gk8h171+5UdKWYue106SwfuZoSmtdyrNGKI1nVLVfs7IzKE69p0P05SiENKQpN8IJ+NoQRMbM4ej/mG/X6q7htNjQDRZ74ztrlJsz6oIMnGXjjBKuC4eZC5ZQKEmKNf3p+H74Y6a+IjFwgtHolJmN3aXoE9gloA8ou5Okq3irGkDY3axChAw8+wcKhdDNxJv7J88tWSuEp8f/CqsfDfFEciRNOrEAZVYs6WJUPBCZqSwSelzRt9xD0DuJU7U9Ev6Uw5Rd6TPo3H978NIkwsfWkgWZtqbzBmA1/BbbQEaKNB69k1XmzWVXZaeSun36i4AqI/p06Ha8Yv1mXdMOeQ7wBbzeikmLaUdwk5tQe/7yQYiOFNLNtc1QSmdg2agGrHH+Z94SOWkMkIA1Z3cSWY=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW4PR12MB6873.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(23010399003)(366016)(376014)(7416014)(10070799003)(4143699003)(11063799006)(56012099006)(261009223027099003)(261028144727099003)(261026121527099003)(261021121427099003)(261026140227099003)(261022105027099003)(261022075727099003)(10067099003)(22082099003)(18002099003)(6133799003)(3023799007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ZXhSaHdQOUczVHUreXRlQlhycjJ3aSt3SWdQbEJ3Z3hSQkdwdk5Oalh6Z3dy?=
 =?utf-8?B?cUkwMUdHK1oxUnRnbnNsdlljVDFNVjNaYnVuK2RVcmpmZmdpL0E2MVdKdjhT?=
 =?utf-8?B?L3pxOVo2MEVadDh0czZzWHdqUTdwbDljZkpqOUFGbWR1R0NIRjEyM2w4VENS?=
 =?utf-8?B?c0VGN05xZWVkVDFrSmNGK3ZpZUk1UklwaWtPZmRFTmRhQUMwYlphWDRtZmxI?=
 =?utf-8?B?aExuSDhVRkVVQXk5eXpEWmNqR3laWU4xbFo4MDV4VTJ1SDNadWFFRC8zVDds?=
 =?utf-8?B?VGlkUFZkTXJNdFNucEx1ZzV3NkYyUzk5NVhKU21hTHVUTUNzc2xmczZ4VnM4?=
 =?utf-8?B?NmNnRHBWTGdlakJUVkxDQWpDZVVTbmFFaEtEdHJlTXJaMjJ1YzhZaVZjVVJ3?=
 =?utf-8?B?UXIxSDcwOVdRb1FJUmVycGRGOVdLQm9qeTUzeks4ZFBZVXR0VDRueW9YRjMz?=
 =?utf-8?B?Qkx4NmUwdU0wS3diNENoVUFPUmlac2dVZUhTaDdKUzlkT0tiSmxVejRZcXVa?=
 =?utf-8?B?KzN0SzdUTDFUam9wTk1WWStvbitLRVRSbHRaWjM0aCsva1QyWGVqMUtIRDN5?=
 =?utf-8?B?MXNjbGxrRUVGeGcwZXRUdFNUZGRWczNFZTNiQjJQL0lVRkRGQ0hLTUt5UVMz?=
 =?utf-8?B?cnhLb280SWE4SDR4UEEyM1FSQURFS0FraUptTmtteGY3eXpNaHlLOC9HYmxO?=
 =?utf-8?B?WW0wcnJ3VlM1Mlk4M0dSaUhMdU5mYlZRa1VvUi9MdU16eFA0YmhFeXlENkhy?=
 =?utf-8?B?UTY0OStMRUhGRU5ua1lmL0UvbnBmQktvUzhoVlZSa2tCZFZ2Rk5rZWlEQjBL?=
 =?utf-8?B?MDRDbEZjM0lTdk9aOUNvUG5ZR2RZb3VQZ3U0NEVwWmtTdHNRWURBRVA5eVBa?=
 =?utf-8?B?bWg4ZWRzTnkyWlVhbGFmdjZGMVl6a3BmcisrRHJwY0FDNm9LVjlGeG9KejRo?=
 =?utf-8?B?aFFtaXF2R1FZeW9hU1hleTA0N1Y1enNEa29vV3ZNVnpVV2JYNE9tUGNlVFRY?=
 =?utf-8?B?QTQ1VXN2VzY5cTFnWENGU3p1SU44OTg0OFhHVHBteEQ5ZlFDYW53eHZvYlds?=
 =?utf-8?B?ZzIyRnY5OENjeTNnOGlsdzhTTTlFZVV4UnFYL2NRcE1jbHlNdVdySUZkVmhq?=
 =?utf-8?B?S0MzV0U0SFRhZExEQ2s1dC9nSzBrT293UmhlOGY2TTF5NmwzMUxRVXAvVzdo?=
 =?utf-8?B?VFVzb3djd25BQTJxYTRSVnprdWFBVW9NeEgvNC9ONURIOXkwREJQYzdYOWR0?=
 =?utf-8?B?WldibjM3bGpOaFo1V3pxVFlrZ01uM280TkZodEFrUnVBSDhBRS9URFBzWWZ0?=
 =?utf-8?B?V1pHZDlHYTl0QktsbDNZQUJOYjEvKytTbzRJYjZHSVVybVRqU2Nuc3g4MC92?=
 =?utf-8?B?cU1naW5OTWZwUGU4TFBNeXFNelpjeFpIenlEQno5emFKaWVDODlzdXQ0Smlr?=
 =?utf-8?B?U1I4em1yYU13dEhQZjlqQk5WL1RJYTFtcGs4dGVpZ1NNQ2luVCs0ZTNDT3Ix?=
 =?utf-8?B?MGtNTlJJTDE3Q3FZTVM5T2dEZVRJWjUzWXl5SFdwM1hyYzFNTUFIKy9RVFpY?=
 =?utf-8?B?UkRCSXlOaHBFZzhEb3JVeDJ5K2hpY2ZvTXZ6WndrZTFDVXpneGxlOVJyaVI5?=
 =?utf-8?B?YzBDVUpXN1B5dkREZ1g2cUNWbjNPcWZMNG5vdlVjUHpVOHdURWVKS1NSZkZH?=
 =?utf-8?B?M1hsdG1JdmxpMGlSQkdSMXgvc08rT2VnS1hKRUplMEJ4Rmd0WVhqTGg5akhP?=
 =?utf-8?B?aDNvVExEZ0xEWU5YWGtncUhDOHl4amxKdUIvWkxTMTc3WWdTMm5pY0pwTGxL?=
 =?utf-8?B?OHcreWtLL0QybTlHSFY5UWpYTGd1eExSc3NYRGl4bGZPczlzd1lUQVRjaDdH?=
 =?utf-8?B?MmN6L2IzdmRVa1Vna05xVTMwTGQyeUhDRDJXYUxRWWtuL3kwbGZMbkhrWS9h?=
 =?utf-8?B?dDJjMnVVelFmKzhTR0t2K1gzNG5zMXoyNWNjVXhacXY5UGJKdmxqMEh2RDdu?=
 =?utf-8?B?WDhWN2prZWF4L0l4cElFTkVSMlU0ZG8yRkVqWXU1YTNFTFI2dWtTRXNGN3J0?=
 =?utf-8?B?N1dvbXNNdy9JV0lYUVBrR1IwazlSOFRzYklOMUNlbVo2dDN1S3lnQ3VDMG5U?=
 =?utf-8?B?T0N1ZmRpTSs4SFM1SkgzZmVQOTZqNTk0Zmltd3lkamY2ekJkeGgremZGTUww?=
 =?utf-8?B?Y25kU0pDRFhnT0Q1YU9ZZlE2anduZllXZGdtbFRzZkJNVjhDdWJOYkZtNzlR?=
 =?utf-8?B?aTFDN2FXQndZcHpkWDRPWk9ocElVMFFtSFMvb3ZvRDQycjV0NDM4RllFbWdJ?=
 =?utf-8?B?VkllOVNEOFdSS2NjelY1a2t1TU14bDR2YnNyK3Vzd0ZmQTZpcDlHOSttZVdk?=
 =?utf-8?Q?KYzRtSjBfUqA0VBeCA6twEefy65TJwOCrDEhSJYmQKI6C?=
X-MS-Exchange-AntiSpam-MessageData-1: sMNkVKfXkKpmzQ==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ee4279f3-0d5e-49ce-5cba-08df37b1cd35
X-MS-Exchange-CrossTenant-AuthSource: MW4PR12MB6873.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Nov 2026 00:48:10.3808
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AGW+luP3SYBym2S9bCd94lwUWvnhowWkeoCs4KO0YlLhB1w+icWyefG5S1b5fs3aS+KJYQAFldBweAz3a0qiGw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SAWPR12MB999267

On Sun Nov 1, 2026 at 12:28 AM JST, Sasha Levin wrote:
> bindgen 0.73 emits the blob of some opaque types, such as ones aligned
> to more than 4 bytes, as a `__BindgenOpaqueArray` or
> `__BindgenOpaqueArray<align>` newtype instead of a plain array. The
> newtype only derives `PartialEq`, `Eq`, `Copy`, `Clone`, `Debug` and
> `Hash`, and the `MaybeZeroable` custom derive does not reach it, so a
> struct that embeds such an opaque type is no longer `Zeroable`.
>
> `spinlock` is opaque (see rust/bindgen_parameters), and with lockdep its
> blob becomes a `__BindgenOpaqueArray8<[u8; 72]>`. Commit 71ec3c7d6db8
> ("blk-mq: quiesce a queue that joins a quiesced tag set") added a
> `spinlock_t` to `struct blk_mq_tag_set`, so an allmodconfig build with
> bindgen 0.73 now fails:
>
>   error[E0277]: the trait bound `bindings::__BindgenOpaqueArray8<[u8; 72]=
>: pin_init::Zeroable` is not satisfied
>     --> rust/kernel/block/mq/tag_set.rs:41:49
>
> Which wrappers exist depends on the bindgen version and on the opaque
> types of the configuration, so they cannot be covered by unconditional
> impls in rust/bindings/lib.rs like `__BindgenBitfieldUnit` is. Derive
> `Zeroable` for each wrapper in the generated bindings instead. The
> pattern allows for the spacing of bindgen's output when rustfmt is not
> available.
>
> Fixes: 71ec3c7d6db8 ("blk-mq: quiesce a queue that joins a quiesced tag s=
et")
> Signed-off-by: Sasha Levin <sashal@kernel.org>

I think this is going to be useful for Nova as well, so thanks!

Reviewed-by: Alexandre Courbot <acourbot@nvidia.com>

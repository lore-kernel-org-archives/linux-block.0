Received: from BL0PR03CU003.outbound.protection.outlook.com (mail-eastusazon11012010.outbound.protection.outlook.com [52.101.53.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9F4C27E045
	for <linux-block@vger.kernel.org>; Wed, 10 Dec 2025 11:45:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.53.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765367102; cv=fail; b=uqhunceKvDIfeFTU4eeoDMZukOXLEI9Ni9pVibA3DZc1M4CPjIn0ROJ/zvFeizgfkkqKFvb1e8G1da+xKf2pCVsf46jFpmsZ+1XMYBiWyhHPTJEiwnScLfqS42cO1pvLb4O4zW91EpOiFDLZcIeLP+o7EwS6NBhMBiW0kN/8v3k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765367102; c=relaxed/simple;
	bh=aKDc1s4/FWBXeKanc3xv5IRh/8/Q/lCBn41lGeXwOwI=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=PvtnDCtznbvlxB4sEYWj8IO11WIJhqp+AxLq7B8ZyiWzqqSIXV3sdF2xVPg0rOrXEzRpxYCc6ay7F+vdzVumgQU+1EfR51R562bZZH/qQ1V6UQ3UDAJhTyTD6NtsoGfo8sRCytOxxZJsS19Vk5uQCMyQ+4uUdAQHP6O6eWGVdjA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=f6Nm+J+X; arc=fail smtp.client-ip=52.101.53.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="f6Nm+J+X"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=a9+3RUggEMljFeWBOkm9XVmhBpuR3lj6IaepjrO39OieuEweVcFKErgY3eQusvEW/fxv/LCa+qv1fDt8+rV+suUMR1FzpdmSOzf1/Z9Cw5+NYUAOuBvY8RT44vLpv/gzDM9TjvK+Qq4Kcs/ixaGQ+/kXr53cXyl+A2FD/bT7jVBy1XjXJOYdjsHngxupsWjWyA+/Stk7SiFpRmhMKPsHTfRTM5GYklmFvaAgOi00KndclAKEDCUg6qWQfcmPAnCPDAJQQpO/kR1zlfOUctEgNl7SHcYX9XzAMOXHR9rUvVVB22Q3Xf50bftrGlnc14JUEEnIt/LeINoGG+IWM4dcwA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gFeCj8C1UU36PYv5cwT1TxtAUfZUnqOMli0q8aEufJs=;
 b=kNzFP/hzD2WQHy6tJtSeEBtNhiJCF+hq6AfKe/yVPdqDj34GFMFfJvbzOsxkP72TT2XPhsaKryVSKa5tqDGvouy087VLPWzQw4HogT8PntC6TyTq9lG5fBZGtU2kxxvu6JoFnUmbtdwHiQ1/r0dQg8DQ8ZotApDLXcg8HBUfNqL1fln9AVH+qumOZ9PRwRKnEIJIHas/ra5VaJpYsgrFl6XZ6cyYwGu2AYoOO3eBxABUJqRgaDtW/+3PPOZeU1vAgqhbTVG8ua6W3ZvpAYW8ete9A0nrYRCjASS6wb9/3SZODndhKlHyjTL8Fl+KSoPTYa0uYgXC18Sid38TcY3ikg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gFeCj8C1UU36PYv5cwT1TxtAUfZUnqOMli0q8aEufJs=;
 b=f6Nm+J+X0LfGmFrKo1eDwp/Zft7nDb1YSATUdE0ymnkOGJVpEsFkY8QZT5mmEJLWaXyA733gb9Lfnv99QowgGWnMI/LhBqsA25HCBPitlpgKs32y0jBw2JMWxtK5t+YszjLUMHCy1z9IpYIBm20hSazbfdK8hBvL2o+sXSfMKg/MWz37HA0sGctitjIc5To9PIR9mle8RwAJmAfBK96mkpgFHpwS1ZlOwCCPWEfNQmlBnngr6UJqfIe8NCleAUxpqg2WDcXRYyRbndnEO4Iflk2NpDNT+498uIWYs5ZPQb220n1pXYpA/fhHUETkMpskcP3Eyk6olQtmGSKLVYroew==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CY5PR12MB6369.namprd12.prod.outlook.com (2603:10b6:930:21::10)
 by MW3PR12MB4395.namprd12.prod.outlook.com (2603:10b6:303:5c::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9412.9; Wed, 10 Dec
 2025 11:44:56 +0000
Received: from CY5PR12MB6369.namprd12.prod.outlook.com
 ([fe80::d4c1:1fcc:3bff:eea6]) by CY5PR12MB6369.namprd12.prod.outlook.com
 ([fe80::d4c1:1fcc:3bff:eea6%4]) with mapi id 15.20.9412.005; Wed, 10 Dec 2025
 11:44:56 +0000
Message-ID: <b2951bb5-212d-43d5-a11d-61512179fad9@nvidia.com>
Date: Wed, 10 Dec 2025 13:44:50 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/1] nvme-pci: set virt boundary according to capability
To: Keith Busch <kbusch@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>, sagi@grimberg.me,
 linux-nvme@lists.infradead.org, kch@nvidia.com, axboe@kernel.dk,
 linux-block@vger.kernel.org
References: <20251208222620.13882-1-mgurtovoy@nvidia.com>
 <20251209064015.GC27728@lst.de>
 <6649eb8e-ae68-460d-95db-deece134e9d1@nvidia.com>
 <aTlZU_2SqgajJ64v@kbusch-mbp>
Content-Language: en-US
From: Max Gurtovoy <mgurtovoy@nvidia.com>
In-Reply-To: <aTlZU_2SqgajJ64v@kbusch-mbp>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: TL2P290CA0014.ISRP290.PROD.OUTLOOK.COM
 (2603:1096:950:2::17) To MN0PR12MB6368.namprd12.prod.outlook.com
 (2603:10b6:208:3d2::15)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY5PR12MB6369:EE_|MW3PR12MB4395:EE_
X-MS-Office365-Filtering-Correlation-Id: 56c15ed1-019d-4622-0aa5-08de37e18998
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?RWF2b3NPMDUwMHFYNG0vYXNHRllZaFo0MlZPRUVpaktXTHJ6ZW5ZbDRSaEc0?=
 =?utf-8?B?eXpGQU5jOU9oWGdPVWQ1S1M0REpQcDlMOXBQTTNWdEwrTzJod1gxVCtYRjF0?=
 =?utf-8?B?bHNRQXY4bTZyUFV0bEpXeE90Ri9TZHkzUWd0RnZKL0NoSERMMVBwZ01HUlND?=
 =?utf-8?B?bTFUVDZmZm9Oak1idFQ1SlNPa014dGVhMlNtQkt3Ym1VcUk3V3hCOTJFU3hT?=
 =?utf-8?B?VmVHdVN6dnBYQXlaNlVFcVIwZDVwdEFGWVdoNnhHZ0piZ3VUTDdJRDVBMkxC?=
 =?utf-8?B?SEI0SUlKK3F4ZUhHL1FDeVRkWGRIZzBjTmZNQjZiY0c1YTBydTdTNWFiWkta?=
 =?utf-8?B?WkFUMTFYWm9SNVZJYkQ4MGo4R2NRUTR0L0FwdktCa3hWQjI0UVB6TmNtaTJK?=
 =?utf-8?B?QStRbWhKME96cnNFRW1OVzU5ek1wSjBYSTFId3JXVlVrdzRGWTF6alpRTlpw?=
 =?utf-8?B?N2JhL2F6RnRqb29jeDNkRVYvU0trejNjQTRFUnRod1dYMlV5cUlIWERQZkwz?=
 =?utf-8?B?M3ErNmxmM1lGRmVGMFlxSE9sc0dqMmtLQVBwK2MzSzhYQks1RkZvT0poVXhY?=
 =?utf-8?B?R3VBYkVkYjJwR3M0VXBaVE5OZHpQQTRVS0V4RkIyUnkxY0NrTzlmUjFIWmpm?=
 =?utf-8?B?czl5RFViTnNUWHQ0YVZuQmhidnpzdXZvMXBabk9HWnVaNGlhSXRoWFkvM09h?=
 =?utf-8?B?aWRjY0xDejhVTzc4ZUIyYzlRbDFwL0hCS0ErcU81eitaR1VsYjJHUU93MFM1?=
 =?utf-8?B?b1JoMlladk9VUHJ0YWk1bXVYdFg5Zjk0WW9OeTFTUGZoZ055TGs2cGtYanVh?=
 =?utf-8?B?SUU2c2lwKzZOWlZWS0NmZzdFbFFkaXh5TVpNV08wQ0pPTXVpWm1FdWIxaUdY?=
 =?utf-8?B?cEZ0emlJUUdENC9vc1FHaVhlbkVJNlNmUmVVclB6VVdBcVhpajcxNDF2bjVy?=
 =?utf-8?B?bHdjVVJvYXJxNVRwOGpqR09TWlUxWEVtNHdiME9YL1V2Q0I3ejFXNkNFNUh3?=
 =?utf-8?B?QkV0dWhxdzI2a21ud3ZPZlFoRisxYnFvbFJqVjFrUGJDMlFwcVFsUTlZVFNv?=
 =?utf-8?B?bFlyV1kwa0k5dUwzT2lXdGdEVWNldGd5eVVORFJVcjBtYk5RQURaTDJ2YWg0?=
 =?utf-8?B?em5NNGRjeUpSK3kxWk5BQlNyVW5ucklnY0lPRTFocW9xTFhJVnp4YlM0WTVJ?=
 =?utf-8?B?dXZaVmk2cjVJM2h4K1F3bzlRU1VxcnNLNWo1TzRVa0NYTW1QZ1pPWlp3QTY5?=
 =?utf-8?B?TkNQWDBvcHZLRE5VamtxNUprd1ZRMTI4VTRPYlNXUzZ6bkZxakR2djVqWWlQ?=
 =?utf-8?B?ckpDVWZ3U2QzVklKb3BrQWVwV3FlMGJ5MDZhWWI4L3p3MFdsKzdSNGRUM21R?=
 =?utf-8?B?eG40dStLV0xPWmFIK2k2WVMwNXI0b0k4UDJmY1hrcDAxNFlPSnoxbkVQWitW?=
 =?utf-8?B?aktucDNuUlNiYnluNStDWitLSURZa3NadWJoWWh3MFo2Y2t1cVRnRTZwVHFS?=
 =?utf-8?B?ditNWGdhakxJN2tzSTFvUExGZG9pemlWZTh0M3JtcHhCTHR2T3dBVzhJVGtv?=
 =?utf-8?B?T3VIZ3dUWE01ZmtORitsdVBWanlMb2habnNqNThNNnRlVHhVTnVSenlQU2lr?=
 =?utf-8?B?WG9zWEVYWFhEZ0ZHMFAwRXcwam9UQ3RaaDBYT1QzTWhaVkg4c1I0SXNVQ3RP?=
 =?utf-8?B?OXFWMGF1RmZwN0hhUFF0ZlAxMEZCV1F6QVNOSjVGamJrU2Y0RnBNQ1JQVTZ3?=
 =?utf-8?B?Wi9CSUNQejF2Y0pKa0tYOFN6MitPZnk1Z1NxRmFaMG82OThyNGV3M0IraDBy?=
 =?utf-8?B?ZE9FT0RYemh4dXUrbWxuYnhHamR3SExRaUdYV0l4bjVqUUpMdFNVVFFHc1Bz?=
 =?utf-8?B?N1FPTzNLdzlMMEk5ZkxBT2dnb3g2eDRqQjBuOWdpQUExY3pVLzhpWHJWaWJJ?=
 =?utf-8?Q?5+zZkuTZpFZHLSwk4su8Pp8F2HJMWZjC?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY5PR12MB6369.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?bDdkRDl3VGU0SXowNktKNW04UmEvSDZwbE1qV3lBWHl1WHVON3k3blJJeXJp?=
 =?utf-8?B?cC9TUndsRVBTZ3pJZXVjZ2w1RUE2MjJuS2FhVEc0V2oxSFJRbk5kQ1RROVBp?=
 =?utf-8?B?YzNkU25jRnZpa0xKZEF5Yjg3M0NxTFBBMjVRaU1mbGVLNlFqcExPS0pnVzZC?=
 =?utf-8?B?N0ZXUXlOUzhhSmlVNEpMdEZMTDBlbEZEcEIvVHRHNUttQ0U5bVlFZWZYMFll?=
 =?utf-8?B?ekhseG9oc2xoeHFrczdGa1BWb1JuRkNsd3dSM2ZHaUhoK1RKd0ZNd1FaWHlk?=
 =?utf-8?B?MjBDTFIwRVZ6OXJNWm5sUUxYdTVFbWkwbjBrcFVQdVVvbnVXZkgyM0JUeGhm?=
 =?utf-8?B?WmRQWS9RYWIrUTVwSVIyRUlBTzhUNXdXSmxPSFhDTG9sa2huM1M1V1V3dnh4?=
 =?utf-8?B?T2xPdjRpZ3JmNGJub1RxZzlCQ1E0Qkt3aXFmQ04valc2a3BkYTBvSGY1VEZq?=
 =?utf-8?B?ODhESWw4SDdEN1Mzc3BZazI2TFZ2OGNtUXhzVy9keHExYnBMUWNJS09Ld2Jn?=
 =?utf-8?B?YWFsSEJMVnJ5MDlrRVR5a1dFVlkzUzlBakFlNDQzVTB5WGtUcXdQS056QVho?=
 =?utf-8?B?THZmOW5tQkc0eWlQL290ZWNVTkhTczZhMzJlbjRjYlRkVVJyWTJIQzVsTnF5?=
 =?utf-8?B?SFBmMCtmcEhEVzZxRjBkTDlMSTRwaUZlT3BheW1vZUtueTRNamcvQ0NWZFBZ?=
 =?utf-8?B?UWc4a0JsVnBIREpBaDNiaHJ4Mncxejk0RGtpSElRbmYraG01MTFKVmhmVG80?=
 =?utf-8?B?RlFoK1V2UnlrWEtCcEFYUC80MEQ3UGRLL2JUcTcvV3MvcDE5VXdZWENpL2dr?=
 =?utf-8?B?dlJQWFZkdGZjVXo1aEUyRVgwMXNjMTFEbDlZbjdKSnlvN0JZcUZhemQ4TTNu?=
 =?utf-8?B?cW5UTTg3a2Y1RTZiQ1AyUng1MVFoNTViRE1yMGxPUDZWV25Cb1BQT2tWM2hw?=
 =?utf-8?B?cVRMS0NIaHdWQXpCdFh4VzdLQlFTbUNPQmp3WTAzcitOazlnTHhPWTRSNXJO?=
 =?utf-8?B?b1lKMmFWUnhQNCs0cngzLy9SemNHMDFpUzFGWGxNWUdDb056V2poS3R6SCt5?=
 =?utf-8?B?SERyaFc5aUZwRnN3M0Jqd3dqZ1hSKzhlMFpZKzZEa2cxU0h0b0IrZENVZitt?=
 =?utf-8?B?VTA1Zm1rMVFlaFBYdnhOdE1xTnY3VjhyaUVmdENhNTU2cXJob1ZyQTFhb29H?=
 =?utf-8?B?SnloVkFhMjh4a0g3SERnaDdON1dzaHFqSDVrNDRRWld3Qll2djduYURlNXRz?=
 =?utf-8?B?QzNraFpSSGoxODJpVmF2bFFxdHlJRHNOQmtjbWhPR0FUV0VPQWhEakMwWnNI?=
 =?utf-8?B?Nml6N2xBNUcrVGsxUzFqWGdNelRTT1RGa29UQ2I5eVNQS0RzV1BqZU9FVEdT?=
 =?utf-8?B?dTBQWDY0UVdsQjBhTStYSVdyNUc2aDBvSm1jWkxzYldSTU1vdmh0QldOQVhN?=
 =?utf-8?B?M1Rpc2M0SW9UUTVtS0dhdytLR05WMk5wWEM3NUNaT0VvK0VSYzV3VExXeWtz?=
 =?utf-8?B?ODVzN1Ywbi9NbnUzR2pQOU53cDZBU3lBN3ROVFBzL1pIM2c3YWF3bkFibDgv?=
 =?utf-8?B?WCtscUFFYmlNTUJmM3NDdDVFZTczM25TZjRGblNqdTFiZkpiYnRCZHVTY2Yv?=
 =?utf-8?B?aTVIUU9vYjFqbVc0T0Z2eDFMb0w4Vk5XT3NqWXY4cTRjVXczRzhMa1B2ZFFZ?=
 =?utf-8?B?UjVnd3ZUYW9NcTJIR0ptbm94a2Fuc3ZQdDV3WHk5NFcrWmlvOU56Y2tOTk14?=
 =?utf-8?B?cWE0eFhZSi9QcmtQcTA3aHlUTkxCVnovbHdiUGFvYTBKdUMxQXh6T2tsalNp?=
 =?utf-8?B?cnRlQzEzNzJmQWg1Wm1oTlU1OGh6NFJOQU5Lcy9wVTlNNjBtVkx2MVhpZDQ2?=
 =?utf-8?B?NEMzbHArMHJ1ZXVUQi9TTFpXQndaVTUxRzNnRWF2d1Avbno4N3pxSDFqdjIx?=
 =?utf-8?B?KzczMFo0MXRDVDNUMVF1MGxIZVBGV2NRa2dKYmFLdnlkNG5uZEh4TW05K29w?=
 =?utf-8?B?eXRMWDV6M3AvNDhXL1d0WXd5NlBMQ2t3b0lnZ1Q5ZTZTT2NlbzFjNXFXWmdI?=
 =?utf-8?B?SzRzUk10UmlFVk8yVjU0ZlNkbHBidjVicnJsZG1iOWhkQ0VDWm14NGE3NGlM?=
 =?utf-8?Q?2+I65Qxf5ZABXB9beHVB2cmGg?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 56c15ed1-019d-4622-0aa5-08de37e18998
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6368.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Dec 2025 11:44:56.1775
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: b/q/maSVTDxLyE4FfZDvkbsMHuFW6izT1s1Y8Aq/xmPI8qcZskTQXKlyuzcIsHbCFYcwFSCmo2Z1lUB0qawM7A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR12MB4395


On 10/12/2025 13:28, Keith Busch wrote:
> On Tue, Dec 09, 2025 at 01:31:21PM +0200, Max Gurtovoy wrote:
>> dma_set_min_align_mask(dev->dev, NVME_CTRL_PAGE_SIZE - 1);
>>
>> and
>>
>> lim->dma_alignment = 3;
>>
>> to ease the restriction for capable devices with NVME_CTRL_SGLS_BYTE_ALIGNED
>> support ?
> Yeah, the dma_alignment is the limit you'd need to change. Note, you
> can't actually set the dma_alignment to be byte aligned as it's a mask,
> so you'd want the value to be 0 to allow any alignment, but the block
> layer currently won't let it be 0, so you'd have to set it to 1, for
> word alignment.
>
> But I'm surprised to hear of a device that can do byte aligned SGLs, as
> PCIe fundamentally can't do byte aligned DMA. It's all dword based, so
> if you have a device that does report byte alignment, it's still sending
> dwords over the wire. It's just using the "byte enable" fields in the
> TLP header to have the receiver strip off preceding and/or trailing
> bytes, so it is a bit inefficient way to transfer data.

I saw some devices that report byte alignment. But if it's actually 
sending dwords over the wire than it's useless.

what about dma_set_min_align_mask(dev->dev, NVME_CTRL_PAGE_SIZE - 1); ? 
won't it mandate 4K alignment ?


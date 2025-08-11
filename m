Received: from TYPPR03CU001.outbound.protection.outlook.com (mail-japaneastazon11012071.outbound.protection.outlook.com [52.101.126.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5068AD23;
	Mon, 11 Aug 2025 07:40:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.126.71
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754898042; cv=fail; b=K4lfwJKRuRtfMiIHK+/+I+F65gjA06l0D//h9oqYUS/E1gSKpQYMKkqbnlsNnwEPcBdW6cEvbu3LGrMKeuSAr8VWar5DL6ZjAis83Avq1VMGQP4a/chSWEsvTShJ6ZrIVBXnFT1x/uSO4Gb1XmDxyp5f0Ee+GHKqMnSifI57o2k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754898042; c=relaxed/simple;
	bh=O0r9yHdo8ZJFfuXB+WXqKxc9POFAKqkKHg8dsSyyFNk=;
	h=Message-ID:Date:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=fvPVigtZ7DG51JgT+3Tlmz74ZILpFKI5J27PXNuObA/u09Q/BknGhfamV83eFwNGSF55Gw6eOQAGYglahJZkWTLI3V0oOf5V898jVCA7lMo52C4+CJmozT0jjszF+HIgfBACXGDhTklhhwhah2fqSI0uiWHSRyvadze2g/C/UIo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=R83JZSED; arc=fail smtp.client-ip=52.101.126.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="R83JZSED"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cy7W6lkhBPLdwl4TLCrQzhbAt/nn8F1JVyZiypPZzbGuykW/82lDBTI0c5IWVDLtuzLNLl4Zms6PRAPOTy0WLZk4k8Zx24j3CBz651UhMXJ79sZOdzVe2YzK2QavOViZ36uP2GHIijwmACFwPfYMHCn4JOfpadu4WxcvgIMmEaKW8pRnqrWQEoUizvkRDCdd6gYidpzCQ9DohYZ07mSCMKVLpPUDGzv1thX7l5QJdSW35nhEycXggvQ9U/DwlVNPlYe2sOrPqj8z9w52xWSH9/4w8N6tYWb38yAqyE8xqZbbbfO8eGRVDIF3X0uldFWVYvCQ9ggp7snrqVUqJfeZeA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CvGCxZlYNZmUlAubhslOXodCVN6wnzRsCeofUdZesck=;
 b=CpNI4mbVdQ8O7juon9xc9Ld6aKYzMuPJT86N+TiE5buQv47IkTiKC4q/XEDVP/1ZCnoM/jKzXHPA7wTqoQzkL3zDW/fx77ydR5OzKiIT81dvda18yKLWEzWaznj7dzBwUNuuNwbmcU4OpCFVTqLfGocckWc35hpbCovcSMCpYwrKEuzMBYNjYTuz/T7Q6NRBeeneE+/boBdaPAjemWBjkoVk0NWZjH50xHQoWGiMpM1WiDR24AoXvYdNI0KFeHDJBHsPtglcxXa6IxYOlwq2Cv69AyT1FGAatHTTyPsde4+Xe693ITsZdPfJ5f9D3FcY20/jE4zoIhdwLaMC3mjxWA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CvGCxZlYNZmUlAubhslOXodCVN6wnzRsCeofUdZesck=;
 b=R83JZSEDc5Rq6Ci+Um/yj49kN9cOTWs23/tOaV1BLVAFKwP0qLSBHgVYZ/2vAd6T9y/He7ccrNj7R174boKahEOmBOZdtB5+lx5JU74rNqX2SaKOtZEekadzgGGt2mYWqAn33st+OptZcw8UJ7gRh2qTr7UazNDIIaFYy2UUG6LwjKrUUlHPToCyx+sU0Nnr6vEKpjZeAIz64Fl7OXr5Mxh7rv4brhLBmCjwanROkWqu7RMKmak1dJo2c6L8ZZ/OJYcAMJikZCNKBJNQLHlBQ1KhegUuVd0WxEA1eWWrAVUfsrKerHDfuHwL6dqVZleEeDYjDvYd49QQseVQhtBwQg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from TY0PR06MB5128.apcprd06.prod.outlook.com (2603:1096:400:1b3::9)
 by TYZPR06MB5052.apcprd06.prod.outlook.com (2603:1096:400:1c7::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9009.21; Mon, 11 Aug
 2025 07:40:37 +0000
Received: from TY0PR06MB5128.apcprd06.prod.outlook.com
 ([fe80::cbca:4a56:fdcc:7f84]) by TY0PR06MB5128.apcprd06.prod.outlook.com
 ([fe80::cbca:4a56:fdcc:7f84%3]) with mapi id 15.20.9009.018; Mon, 11 Aug 2025
 07:40:37 +0000
Message-ID: <6bf7177d-ceac-40b4-8f79-e211ecaa42b1@vivo.com>
Date: Mon, 11 Aug 2025 15:40:32 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] block, bfq: remove redundant __GFP_NOWARN
Content-Language: en-US
To: Yu Kuai <yukuai1@huaweicloud.com>, Jens Axboe <axboe@kernel.dk>,
 linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
 "yukuai (C)" <yukuai3@huawei.com>
References: <20250809142240.174197-1-rongqianfeng@vivo.com>
 <233497ad-4d0e-2aa0-96ab-fbabdc68bb5e@huaweicloud.com>
From: Qianfeng Rong <rongqianfeng@vivo.com>
In-Reply-To: <233497ad-4d0e-2aa0-96ab-fbabdc68bb5e@huaweicloud.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SI2PR06CA0015.apcprd06.prod.outlook.com
 (2603:1096:4:186::7) To TY0PR06MB5128.apcprd06.prod.outlook.com
 (2603:1096:400:1b3::9)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY0PR06MB5128:EE_|TYZPR06MB5052:EE_
X-MS-Office365-Filtering-Correlation-Id: 65b4dde9-3eb6-4893-783c-08ddd8aa5cf0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?WXA1T3YzRXgwczZ2eWw0QklrTVhnZEd2clJGVUpXWjRWdGtXU3pQdUJhZ3Qy?=
 =?utf-8?B?MDNqVEo5RkN4L0F2VHZoU2lKaFN0NDJEd2piSXFxQlk4RHJyQWpHaTlGMFQr?=
 =?utf-8?B?OWpEdGsxYnRhOEhOVXJkb2F5THZ6eVdkS0Q3Syt4QnlLOG1TSVlkZGFYbDI3?=
 =?utf-8?B?dmhGVTJKUmRucGIzcktjdUVTcDV6UGdxTjVnS0NPWGxwQnI3RWhUZjhremVB?=
 =?utf-8?B?bEZ0UTJDRWlFQ3BENkEwMVhhRjFGWllkdk82MHZDeG41NGd1L25GY00reDBN?=
 =?utf-8?B?V081QlROWVBPZzJiRnRmZjZTOE1zbk5nK2xISm5SY1dhdlQvQnc1b2R3OWZT?=
 =?utf-8?B?dXVlRlhLT2lBQXROZ0RLYWt6UFJzb2crUXRZNjMzNE1MTGh3a1E3VTVzUEVH?=
 =?utf-8?B?ZURmTnpLRlNmUHpwU1ZxZVdlS0kzSXBwbVlIa3pyNENobXluT0U3Wk83d3Iz?=
 =?utf-8?B?N0p4UGkwOVk4QURJY2ozMXQ1cHpzajR0bW1uS1VsVCtOTmc0WUpzMnVURTll?=
 =?utf-8?B?OVFJWVY2QncvQzd6S2wrNnpXcXN6bE1UL2JiZitQblJLSlNpbEVQZ2JPT1Yz?=
 =?utf-8?B?SUJFK1llVVRhQTRtUVFDbnJlK1F5ZWlXRURVSE1SZ3loY21BSTZDSnloejBs?=
 =?utf-8?B?dGRkTXpsRFMxNnhWOUpPdHYwVnVHY3JkSk1icVF0bVkrRXdrQVl1eC8vMkFl?=
 =?utf-8?B?VmRlL3h3Vk5PTmF4aVJZV3pta0k1VjZPUmpEM1hyRCt5R3Z3ZDF3TEttMCtC?=
 =?utf-8?B?S2ZFQ1U2Z0c1WXBkU3ZaT1k5N2crWFI0Yng2eU5UbzBydm1HUm1NYjFKOXc5?=
 =?utf-8?B?M0htdDRrRDU3WCticnVtL2ZsckF0b2dQbmxOYno1d2x1VlY1NG01YkFVaFE4?=
 =?utf-8?B?TElvRmdsVjVkNjlxZ1ArcUtxRWRLSDlVUVFjbE0xNitrTE9kcUkwT2F5UFk2?=
 =?utf-8?B?cGdRTmpEWkFseFU3ME5CWXgzTWJGYVBvS3dpWVpNM3U5ODErSHd3NXM2TFZV?=
 =?utf-8?B?ZjNnY01pUDVXQ2pvcWZ6d0lJZ1hXOFFoSzJTcStrR0lybEZxTjc5TUM3ZmhH?=
 =?utf-8?B?bXg3Z0lBTDFlenNWR3oyR1JUd1hwYk1OZ0dTOTZ2VnNEOHRPb0dWeTdDMW8r?=
 =?utf-8?B?dkhaZ2thdnBybGpEbDB1VjlremM0NWZyMk1FMmZJU2ZoVEJyRkZxdGltTzBk?=
 =?utf-8?B?YXc5a0Q2UWo1OXJCK1pUM3NFNXFFUW1QU2d1Vkc5bWk0ZU01dERLQ25yVE50?=
 =?utf-8?B?b0Q5MVU0MXZ1V2NQT2xqbnFybVozR08wOC91aXhLU0c5L05rNXhSZGxENWt3?=
 =?utf-8?B?bE5JZzgyVDFmck5CZlpNSkM0Wk13aklibU9IaGorR2FBb1ZVYVY5WEtUYmlq?=
 =?utf-8?B?dWVQQzlBRzdSeWU1OGcvMkJseFpiOGtJcy8rdmhTamRISGI0Z3ZiYmpzZUcx?=
 =?utf-8?B?bHEzKzkrOENEQ0ZBWitIQTNubmlKd1JBZ2toNnBOZmZuOU5yUm9uRm43SVVC?=
 =?utf-8?B?RUU3dEtJdzNQekUvYjc2azVqdjJadWN1UC9tUUFUSytBK0pzT25kUStHRFF3?=
 =?utf-8?B?SW9mQkFpS0x6d25JTy9FRDBhL1Q0U0Z1MUg3bG5VSCtmSDJhR203U0srUnlw?=
 =?utf-8?B?ekorbCtPWXZmU1BrcHNPN0VlTzJkZzVKZ0Y4YU1FZW14c0I2ZFBYUTlLREFY?=
 =?utf-8?B?NEhlU05xMnpVa1NJQ0dhaEIxNUlwR21sKzJVMVB5NUFlRUNNbkQxYWJ3dWpQ?=
 =?utf-8?B?dEVpQWUycVU2VHluclZnYUFDT3hhZHZEVUhzaTNGbm0zSUt2UldGTHUxdmFY?=
 =?utf-8?B?Uk9IUlNka1ovc1pjTVh0R2hFaFJUUi9GME5xdXdlT1lmSkNqYXJhVGdWQzYz?=
 =?utf-8?B?Y1NDbW5jVVBYWWJBaFprK3NRbjhZbFFObldsckJtR3JubnZSRmp4Q2NGdmQ4?=
 =?utf-8?Q?2NZPjz16N+E=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY0PR06MB5128.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?MVdxN3UzbnhTNjVwamZkRGVmT0NaZWpIaVNwRFByL05lWjRwK29ydmlTM0NC?=
 =?utf-8?B?TTVGMXJxVnJuMFZHcmV1eUN3TGxaNWl3ZkJKMWFUSWg5ZVVNN0ZnQ2x1cXZN?=
 =?utf-8?B?dkRnTjlnaVB6NmpYY3ZFUHpNcDlzMjFLbXJZaFdtL01CTmlCRWpmdFp5RHFl?=
 =?utf-8?B?OXhwVHFKN2tEZTJLdGNCckhJWWp1T1VDTnowb254Yi9vMGF2QXNhQmxwU3NL?=
 =?utf-8?B?UGNlQWJ1bmM1dFFieDg4YzBMbHlNTk45dWVPODZ2akZwY0F5YjByTzBjdWlH?=
 =?utf-8?B?dkx2Yzd4Z2xwa2ptSEJmVjJqSW9mUW5UTnpTS1BMbjBvdnJLb1djbFJGcVBW?=
 =?utf-8?B?VlcwVzhCejVDVFNRbjJPckRvczZhOGpuaU00N3k5Y09EMUg4MXpOL2JycjA4?=
 =?utf-8?B?c0tBVXdYaXo3WWQ2dTRYcUluN2dveSs3ZTJBWFNwZUlTNnBPcm00cUtGb2V4?=
 =?utf-8?B?Unp2TG9FWGwwbG9iM0QzQmE4VzRHTjFKOFBvYmRMenhNWXFuTk9yKzQxNzhQ?=
 =?utf-8?B?YlpncXdBVzVCV05VUFNSTDJBVjhvK3p5MW1MbHRsVldKVUJXeUJOLy9rWnU4?=
 =?utf-8?B?UXE5S29sd2dMTjMxK1ZJSFZocnlrNldqOXRLOG9wTXcxUFFCTnZ5Y00vSWY3?=
 =?utf-8?B?UnRiRWNpeTVNbnpFREsvTkQxNE11V21UNHM3a21UeWVNVmdQNFVUcUMxbVlQ?=
 =?utf-8?B?YXdJelBPays2bWpQblhZdnhDMHVxNFhyS3F1ZnJBaERYb0I4L1JjTmpjYzdW?=
 =?utf-8?B?T0l2V2VTSnB2aVlJaXM0RDlLcGsvOUJPaHllUHhWZ2FlNUNYbmxCV2U1eDcy?=
 =?utf-8?B?NWNHUm1za3I5V0FJZXd3ZWlkRkEzQTNTVmEzb1ZnbDhUUmNYRTVhMjdWM1Zj?=
 =?utf-8?B?UjB5N3BOSHlDSVV4bmYxeCtDYlFBZ09UaWprRStObHdqblF0WXdhQ3NOTHBo?=
 =?utf-8?B?eXFEWkFqVTJqU3hES1ZKb0JXUFZxcGhlaTBQR0l4Y2VYUGtJMzczRUhmTEp1?=
 =?utf-8?B?M0I4SGdMbkZDU0hzTHlkZVkxWUJ0SlJYZkRlV3BnQ3ZWb3lMbDlLWlRmNzVC?=
 =?utf-8?B?TGgwa2dRUFFEek1LSEt2bHI4VHdoV2NEaEVoamZGTmlYM1ppVTJjdVE3MTUr?=
 =?utf-8?B?NUtveHpOYWxzMkFzV2hPeDBSb1AxZUhpeUVkTXBCZXUrcHRqOHFFNHg1aTM4?=
 =?utf-8?B?UTcrYVpQWjBGcWRwZFZad1RGQlhZUlQvNkU1U1ZhMlVOWHBWOTBUMWg5blpX?=
 =?utf-8?B?ZWxpVnlXeHhUdWR1Y282akFja0ZuZ2JuQllXd2N1NDZDSExOcDhFZVhERlBZ?=
 =?utf-8?B?ZGRQK0doK1FYOEFWak9wYU8rZFZlZHE4T0M5dXN4S3IvRjU1MjByZ1RhYits?=
 =?utf-8?B?SEVXZnJMdHBrWEJXcW9jUmpHQnZJdXd6MkJTemZTVWtQUnZBU29aNHdPL2I2?=
 =?utf-8?B?aEVGNDMyM2xwMndwSWxNZWlBWEVjcGdKNG9JZnJDbUVWTUpLaDNWd2Z5OUxN?=
 =?utf-8?B?OGZLYmExMHdGZkQrVUh6Z2pZK2VvNXU0YldWZ3VESWRjU1BEL250Yk5WRlBG?=
 =?utf-8?B?aTZXWlBjOFhPb3NJL3FjMkZiUC9EbUtWb3p6TldXa3hycTV0YVlyV2FGcEx4?=
 =?utf-8?B?T0UvSXM4RmZGMFEyUlViWnAwaGhtSzV5ZW1zZzl0d2t3NnpKZDVEOWtUY2pF?=
 =?utf-8?B?UWY2QUVtZitoeGpTY2R1VkcxZ24yY21DRE50SkY4ZlBoZ2NRb2JuN2gycXpN?=
 =?utf-8?B?VUp2akFTU0VpVzFoSkR1bDl6N2dlQkI1RGVjSmJGV0diU0NmcEc4S1JvTFMx?=
 =?utf-8?B?QWRhOW5FVHFQZkxRNVlMbGpLVEF2RFEyckk4bHB2RG10QVQ3bU4xZUNxbDZI?=
 =?utf-8?B?VG9NSXkzRUgzQ3JhK1BkVzdWSndQR1FNOU5VQTlIOU5JN3Z3Rk56M0tIZTA0?=
 =?utf-8?B?YVRBUksxcnU0aVZKL1VJaWJNRjhtWUlCbDVyZ3Q4cng0VVRoOWcwbDJncExF?=
 =?utf-8?B?TTJYcmg1L0s3dXR2RGRvNXBlU3E5R2pnamUwUG9SWXlOL2RJZTVqZUVCdG54?=
 =?utf-8?B?Ykp1Rkw0R0toTVlnQkx5d2RHNDg3OGo2QXI4K2VkeG1iWFF6MmNxOERVSDBs?=
 =?utf-8?Q?FkvxcSyG/bjKghhzMo7GzP2dV?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 65b4dde9-3eb6-4893-783c-08ddd8aa5cf0
X-MS-Exchange-CrossTenant-AuthSource: TY0PR06MB5128.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Aug 2025 07:40:37.4162
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QfpRu2YYj7BPvdPueKQKTDpNyYqegIN3RwnyeZYj2FLeHIPbr6t81ZrUq1CJPg38k6CtRv1g9P3rXJLQ70RQ6w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR06MB5052


在 2025/8/11 8:59, Yu Kuai 写道:
> [You don't often get email from yukuai1@huaweicloud.com. Learn why 
> this is important at https://aka.ms/LearnAboutSenderIdentification ]
>
> Hi,
>
> 在 2025/08/09 22:22, Qianfeng Rong 写道:
>> Commit 16f5dfbc851b ("gfp: include __GFP_NOWARN in GFP_NOWAIT") made
>> GFP_NOWAIT implicitly include __GFP_NOWARN.
>>
>> Therefore, explicit __GFP_NOWARN combined with GFP_NOWAIT (e.g.,
>> `GFP_NOWAIT | __GFP_NOWARN`) is now redundant.  Let's clean up these
>> redundant flags across subsystems.
>>
>> Signed-off-by: Qianfeng Rong <rongqianfeng@vivo.com>
>> ---
>>   block/bfq-iosched.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/block/bfq-iosched.c b/block/bfq-iosched.c
>> index 3bf76902f07f..db0ae65186ec 100644
>> --- a/block/bfq-iosched.c
>> +++ b/block/bfq-iosched.c
>> @@ -5848,7 +5848,7 @@ static struct bfq_queue *bfq_get_queue(struct 
>> bfq_data *bfqd,
>>       }
>>
>>       bfqq = kmem_cache_alloc_node(bfq_pool,
>> -                                  GFP_NOWAIT | __GFP_ZERO | 
>> __GFP_NOWARN,
>> +                                  GFP_NOWAIT | __GFP_ZERO,
> Can you also combine this line with the one above?

OK, I'll post the second version soon.

Best regards,
Qianfeng

>
> Otherwise LGTM. Feel free to add:
>
> Reviewed-by: Yu Kuai <yukuai3@huawei.com>
>
>> bfqd->queue->node);
>>
>>       if (bfqq) {
>>
>

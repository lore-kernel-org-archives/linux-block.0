Received: from APC01-TYZ-obe.outbound.protection.outlook.com (mail-tyzapc01on2075.outbound.protection.outlook.com [40.107.117.75])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9C801E52F;
	Tue, 11 Jun 2024 12:28:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.117.75
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718108921; cv=fail; b=WRwSy4NhDq7xHmCpcTK20zARsDhSRkYUxCzE+aA2Iu+ReoJMo5EzdRAyIUQoUr5tFOdXPmFDIaTKvpJBC1ww1pRvmit9XuZyCky8/l8EqN0L09XI7AGALSS/itMwzJJZc4FWujBclMROwzLtEsxDWSvqh88amFRhy+oMsILCmxI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718108921; c=relaxed/simple;
	bh=y84hZuy+41sSjsvy4RS1GjX4Hjuw1NAl63yl1TuqnH0=;
	h=Message-ID:Date:From:Subject:To:Cc:References:In-Reply-To:
	 Content-Type:MIME-Version; b=atuaW2cba67twJ1Bl64XTSp+BsGZGoUT3nY5yBTXh/04oNQ0vX5Uqr0vCW7GP/DnbKy8jPJFuLUDk1AMRK9AVFYR5kgd5RWEQBbIv4V4vc9+R4aPgYPUu+SOxg3P6uyyScpRtui3uBUQScc4jT86vvQh92ahp5XfoOJISSegwjs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=gGd3iTDj; arc=fail smtp.client-ip=40.107.117.75
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="gGd3iTDj"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dL6TPqzi19cUKzlO0zRKLQV+fSZ5je7xF4Zqb8guyTYWjc0/y/1bGbrKMq8ugIjIWTL67qiC40/mH5yephVWNmfH2uJMwmGTcvPndWD+wOpMsDBaVSB2MHzp6nr9Wfp1+ma6TSoU6v1DmOaDOaUDvFxxMbMZSjljleEf/tyqe2x6R0fYazQ7IpfaKOEdqt7Ec5/UJlPRhI7az8WO3m9+tt3reTVM+0WKyTZmVqS1x/VoI1WkmAwxu+nG/363K6+6tvraOYblrRLp5XCN0LWKoBgKZmUvzhNhouSW34eRPWoEl84GrlNaAIVsZ1P++RKmgV46hxMkK5ruJm6EMKr9Hg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ii0pQCYrNfYCXuK87cGWrs5bZYMktPrMDY+Z0uBTo3E=;
 b=nRO1Zw3Kl2gn08vzeH27cmXU1WXmNGnSRoaIbu7y4c/diJ6OY9qVCCdsJzUPgZIzx3+/aA3FTXlISl6GeNLwkIDJBff6iLQz+Qh5abigO1RR2RgW+RiHb1tszYKhvP7i6g1qxvBp/amestYciJyfho8Ua1JR3VzbTGxE7ia+sONWFvCT2MIMldrYHrwqTuMfLG1SZx5UTtz4Prc0nH/u8X6VVZKRqHeMrr6ueNmWBFfwRuQ4+07zfbDaibPvszg271cy49PsEMH6nieigtZqpKeOYzK9IWvF5KHH+5Vt1iC/Ppcayaw0g5KdowMe4yONV7kPV8u4AmSAWPWIMNm60g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ii0pQCYrNfYCXuK87cGWrs5bZYMktPrMDY+Z0uBTo3E=;
 b=gGd3iTDjGd3kukT338uOOfhOb6N82YLlnftHPCi7NHcCUEC6CjuMYfBsDF/Qkv+N4swwTPnhsxP/YrXvi71Y3T+nTaH4VvwoWkBZBb9pZkbue3F4j9T5F0YdSn6rWvZ0rQRZRW1zQdLpOao6+uv2/HmM2+wICYLzjgzXlKvRTFOmtuccXjWV/gupZQL/HTBgaoydF5CYb7LZRpOHCQOqKu+rkinx53H1zd+LJiEezhDMi7PmAChfthT8d55xUKXUaTGE910e+T7Tv6mdP1UtsGNN1PHx9a2Kb7x37Kin6xJaTXOKZxf8nm4m5u3JCfNsiq8+djB0QFRNBLq8tgz7sg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from KL1PR06MB7401.apcprd06.prod.outlook.com (2603:1096:820:146::12)
 by SEZPR06MB5342.apcprd06.prod.outlook.com (2603:1096:101:7e::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.36; Tue, 11 Jun
 2024 12:28:31 +0000
Received: from KL1PR06MB7401.apcprd06.prod.outlook.com
 ([fe80::f4f:43c4:25e5:394e]) by KL1PR06MB7401.apcprd06.prod.outlook.com
 ([fe80::f4f:43c4:25e5:394e%4]) with mapi id 15.20.7633.036; Tue, 11 Jun 2024
 12:28:27 +0000
Message-ID: <64a8dcab-4f3f-49de-9940-129307371c84@vivo.com>
Date: Tue, 11 Jun 2024 20:28:26 +0800
User-Agent: Mozilla Thunderbird
From: YangYang <yang.yang@vivo.com>
Subject: Re: [PATCH v3] sbitmap: fix io hung due to race on
 sbitmap_word::cleared
To: Ming Lei <ming.lei@redhat.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, Jens Axboe <axboe@kernel.dk>,
 Pavel Begunkov <asml.silence@gmail.com>, linux-kernel@vger.kernel.org,
 linux-block@vger.kernel.org
References: <20240606135723.2794-1-yang.yang@vivo.com>
 <ZmLWfJ7OFgj+yoxV@fedora>
Content-Language: en-US
In-Reply-To: <ZmLWfJ7OFgj+yoxV@fedora>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: TY2PR02CA0058.apcprd02.prod.outlook.com
 (2603:1096:404:e2::22) To KL1PR06MB7401.apcprd06.prod.outlook.com
 (2603:1096:820:146::12)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: KL1PR06MB7401:EE_|SEZPR06MB5342:EE_
X-MS-Office365-Filtering-Correlation-Id: e145f361-1ea8-4fcf-1185-08dc8a11fe68
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|366007|376005|1800799015;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?VE5aKzlsSzRzZWoyWEU0RmZaTTBLR0VENnhXK3l4RXBXUXNYclQ5eGdtMHNW?=
 =?utf-8?B?MmNaY3M3UFcwRVhvN0NLVnJCRXZxYzlEMWlwakt5bG51bFIzeGsyWGx4eTJl?=
 =?utf-8?B?OTF4NWk5eGtKa092L0xUYzlNYjFyeWkzREovMDhmQlZuQkFjSlNqU3pSZnJ2?=
 =?utf-8?B?dmVJbFBvTzEvaDljekZwQXdTNjY3WUVLRjF5bHJoMUd5WEd3ZVByNkl5OGlR?=
 =?utf-8?B?UGFXUzVsUkhJdHlNWkdkdEx1NDR5MHBzQXFYWDZ6aGZiQnljcmxiN1NzR0FO?=
 =?utf-8?B?clJQVVFmYlBvRkJOYllQM1RNL3ZRZ204aGxkaHJZZGpJdk4xM3c4WlkwekY1?=
 =?utf-8?B?dERodjUxaXBVWENUUURDT2NlNUNneE9NcHJNeUhKWE92VkhjU1NPMXZmemNJ?=
 =?utf-8?B?cXBpYjZjeGtTdVpGTXhPcFhmN0Nyb3pKTUFqWXhmVllaRnlMSTZPMmllNmNL?=
 =?utf-8?B?UXVId3F2Zk9tOUxXTmM5Z1VyWXFxc1kxLy9Vd2REZzNOb3VpdHAwbXllODZQ?=
 =?utf-8?B?eFhtbVZIRFhYblhoYXAyYUtmNkNkTk9PWDh4S1FPUmdNd1dvR3lFUnJFeWZX?=
 =?utf-8?B?Um5aYWQxWjcwNzVrT3RBbHRYR0luL0wzL0xDVCtLNkNSYnRjOGxzemxIdWpX?=
 =?utf-8?B?YVRFbWF1SVczVzRYMEg5dGtqdWNNc29QZGprWmIvdWxQSWFKM2xPR2FMdFBy?=
 =?utf-8?B?UXVhcm9BNmM2U1p1N0c1RS83emFRbmJ4bUsxUjUvdWZ6MUVyem9uZ1RoUkNI?=
 =?utf-8?B?S2ZoL2VIM0hjSXFBL2JDYXZqQlZOOGRDcFMyUGYxbjdvemw3Q3dBcS9kOFRE?=
 =?utf-8?B?bWJjdjdvbXZYRi83RDliWnZORFJWL2ZVaHl5S0hoUVRiWk9IL1NLRDlCN1I2?=
 =?utf-8?B?WnhYZ2wzVllGdWMwU1VYTW9hME5EOXlDQXA3TWlJamN1bXhYRE9RR2ZadTlk?=
 =?utf-8?B?S2syR0dTTlViazVNZlQ0cm80RzBPdjczK1pWZmFrSTZIaXdzRkVHcGViWlRY?=
 =?utf-8?B?ekpIeDUvN3lsK1RkRnIrWDJGQlVZbDJrUjBNbFp4YXZMN01ScitlcnZ6QjBa?=
 =?utf-8?B?ZWRyUllGVDlWaXRlTnE1Sjl5RThuTzN1SytmN05xN1c3ZUZ6eVUvN3g3ZE84?=
 =?utf-8?B?dGVocHhMaFFYYndnN25Yb1pob1B6dERNcUJjeGxPWTR3aytCU3NteW5kZDg5?=
 =?utf-8?B?OWcycG9LMkNIdDBIdGhZUzl0YUs5YWtvaHJCZlByU1J1NzV3RUt4SG1SSnBy?=
 =?utf-8?B?emh3M01YWHVVaGM0elQ1RFdPSWROanY4dHRXdnY1eXFVQm02MWxleVBHd3V5?=
 =?utf-8?B?TVdxWlBOSU9QdEJMUkN3TSsyNURCbXVRcHUrQ1JVeGFDYnJvQTVicGc4Um9m?=
 =?utf-8?B?L1dsMElNa0N2NW9GeHZIK0JXeG9QNmQwN1NLcnoySVJBQjdrVmR3QU9BWEFV?=
 =?utf-8?B?M1VkclI3UXZnQmhlZkFQQ3c2Y2NrNnB6ZTBuK250SmpFTHEvY2VOcUlUcmhX?=
 =?utf-8?B?RzNoRXlIWFlxNFV4TUpUUWFod0FhbGJVMDdaTGtOcWdYL2hQRHNpNktvdGpv?=
 =?utf-8?B?cTFXbkQ5UFpySzlyRTZOMWRzS1ZtVVUrdVFaMFVwVXdCZ0RLTm1WQXVjQnpC?=
 =?utf-8?B?ZERlOE9hY3lidHY0bHNKbVNROS9wZHlHQlpwTEdOQXZLeSs1Zkwrd2d4d29l?=
 =?utf-8?B?VkpmV0NsU2ZXMUkxckxyV1pXODRlcmdvVFh2MWJOaHRaL2I3a1djRXQvMERT?=
 =?utf-8?Q?88tKq0Z7EuitBAq9g+0KcKCyU4fFxpoLd46zxla?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:KL1PR06MB7401.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(376005)(1800799015);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?anJFMkk1VHVLc1Z4bmJXUkUzN0poMklZZ2pUNUJsUURwUnZ5bk0zeXJ2RlNB?=
 =?utf-8?B?NUJtMWdoZFRpdmx3WEhRcWRCbDhXNEQxRmpYdHMwL0FiZDI4ZWpuczJUMko0?=
 =?utf-8?B?NURzTE1zUSt2SVBrZGE5MHhVcXRLZUZoODZncFdyYmwzdUR3WE5xVXl3Nkt0?=
 =?utf-8?B?S3NnME43eUI4OVprYS85WE82dE93TytrcHpHMFJQRDUyZ2ROdml3QjU1MmRV?=
 =?utf-8?B?RUlBd0RyYjBUNlRUVGxjUG9wVERkOWc5clo0Z2pGZktBaW9XZlNuaEFwODJI?=
 =?utf-8?B?bTZaOHJDcmRZNk9HRUFkQ0lMUDluTUNYOTZXcDYvQ2tsaFlIYnFiODF4Ky9p?=
 =?utf-8?B?Ny9WTzBvVWFNSWV4M1pwQmcwdE9lcFc3dWIvcXo3Q1E5VUVOVytEWUxHYzRv?=
 =?utf-8?B?RFdiV04wQ3lVNms4VlhiQnR3YzBNeXlLUXFmRUxEMThzakRYSHE3bWhBcExF?=
 =?utf-8?B?emZDWjJRREd1R2ZUazNQTzZWRndiaE1vazFGWjBZZGhYYytRekMwelFFK1dW?=
 =?utf-8?B?Y2JWdWpsRlg2RmhFNmdxdTdOeWtQeWVOYm1LbGpHdy9mVktpRUFJaVpaTHp0?=
 =?utf-8?B?ZGZZVmZtSjVnd1kzeEx0MzFuZW5Sam9zdUk0cEZBZCt5KzJ2S3RDa3VjcUVH?=
 =?utf-8?B?SldaeVlST0d1cUE1L1BKOUdpM0JlZWxhSTMzL1N4dzBod0lFaGt4WDZ1LzFC?=
 =?utf-8?B?S2NGOHlHQXJSclVydVFyUEw1TEp3am5nTFpwV2ZYbW1ROUtLNE5TVU9HTngv?=
 =?utf-8?B?azRrRzlqZnJKbHM0YjJZVkVxRm95ck8rNklqS1ZwQmo2ZXA4U3p5Sitza1lj?=
 =?utf-8?B?aFZmMGtXZlZxNituaklkMHdtV0t2Ky8xMWJQZEtwRFhzRUN6dU9CMlgyUkgv?=
 =?utf-8?B?TS94QjgxalRkMXZMMWNUSVdDMXZnckZ3dHFLd3lOQWMyZnMyMHZDUFNCZmVv?=
 =?utf-8?B?VkN5VXpGYzdhNzhyVFlZVHlJaGRweUt2ZVk0WHZQa3VLMjhyVFJLR0pOYmU3?=
 =?utf-8?B?SzhxUjJuSnplcTRRdTJYaXN5Mmx6NncxckVKVnVuT0pyaGpEUmhud3dzeG55?=
 =?utf-8?B?MEZTUzVYSXhnTmJQbHFWL3dlVTBWaVF6NGp3eG9uSDNJenREMy9mTUE0cGEv?=
 =?utf-8?B?TVFBSTdlNXgydzhmbm43dG1tMm8xcSs2cTFmc1dGTEZzRVpuL0Fyd2dENzNG?=
 =?utf-8?B?cm44QkJFaEVtR0NqZlV6SDljc1VGNm9oUWxHWTg3VjZRU2JLRHd5ZzZKakl0?=
 =?utf-8?B?QVhVMmthYkhUZmJJcFE1NGxGT2RtcXl3djYwNW1WOUc4dEwwQ2Npc3VQKzJY?=
 =?utf-8?B?a1g5TEdzMjY5eStac0t0V2RuSjRNUUJMbjJkYk9XcHNhQTNyanU4RXg2VmRV?=
 =?utf-8?B?RG1RNHhEbkZDM29IU3hzNTJkUXNtMXZuT3JkcmVZcTBJMGhRVWt5ck9PbW90?=
 =?utf-8?B?VXRFKys1bFFiR25JUHloUXNCNFUyY2s3MEt2ZVJoRmdsY3NHbXJZakRpY0NO?=
 =?utf-8?B?d3VKNXBMZktadW9zckdmdHYwbTYyUTVOZktzY1N0L2toaHZtRFJvTWEwcDB2?=
 =?utf-8?B?RURyNk5uTVpnL1FvMzFOZTltUlVtRmxPVEtyN2RHMmZXMDFWMGduZUtPL1F3?=
 =?utf-8?B?MWdaeWRrSC9kYVZBaGhKaTBhaVNaR1hiVHdZZEZrK1Z4MitvRExiV0hVRitZ?=
 =?utf-8?B?YkRpV1d4TXlNUDJ0Y1dYTjBtd0ZjRktjV0xITWFlZGNQcWhrRW80MDRWd1N1?=
 =?utf-8?B?dEh2WElkVW4zYTl4Y25oTEVuUGFianQyM3RrOHVabFd0S2NDNDVhSVhmYUdL?=
 =?utf-8?B?cGF2UURFQ1ZvMUtIZFEzUDdDdUl1R0VzenF6ZG81NG1zbldIeEllQ1ROY2ha?=
 =?utf-8?B?QXhQMTlSTDIxR01uOE5Hb3czSGt5T3NHOWlscG9OMVluazIvMHNnNC8veGNR?=
 =?utf-8?B?eE12VTdwSW9odnVVdnYwamwyOWZHL2ZhMGtyUUszbnZ5bER1V29SYVVqaGxB?=
 =?utf-8?B?MDN4MUF3SG1PQ3VNeldTQTgyYkNzYUpNTmxXSldTd1UyWTByVkVLUFF6dXBt?=
 =?utf-8?B?dU9zeVFhTjFsWmcvWjZhNUFtbUlKMWRnY3lPeGlVUzFNc2h6OW9uWU56UWZq?=
 =?utf-8?Q?6XUzyZ/C5b87EtuAjorz4orBi?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e145f361-1ea8-4fcf-1185-08dc8a11fe68
X-MS-Exchange-CrossTenant-AuthSource: KL1PR06MB7401.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jun 2024 12:28:26.8723
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: eDWJHQ0oHu1DWfXBccwVkK637k1/MK8A+rDPSuQG0n91k8gNBQ6sbNd8/kb7EA0bNJvBm6Gk7fIPYTRACchHtA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEZPR06MB5342

On 2024/6/7 17:44, Ming Lei wrote:
> On Thu, Jun 06, 2024 at 09:57:21PM +0800, Yang Yang wrote:
>> Configuration for sbq:
>>    depth=64, wake_batch=6, shift=6, map_nr=1
>>
>> 1. There are 64 requests in progress:
>>    map->word = 0xFFFFFFFFFFFFFFFF
>> 2. After all the 64 requests complete, and no more requests come:
>>    map->word = 0xFFFFFFFFFFFFFFFF, map->cleared = 0xFFFFFFFFFFFFFFFF
>> 3. Now two tasks try to allocate requests:
>>    T1:                                       T2:
>>    __blk_mq_get_tag                          .
>>    __sbitmap_queue_get                       .
>>    sbitmap_get                               .
>>    sbitmap_find_bit                          .
>>    sbitmap_find_bit_in_word                  .
>>    __sbitmap_get_word  -> nr=-1              __blk_mq_get_tag
>>    sbitmap_deferred_clear                    __sbitmap_queue_get
>>    /* map->cleared=0xFFFFFFFFFFFFFFFF */     sbitmap_find_bit
>>      if (!READ_ONCE(map->cleared))           sbitmap_find_bit_in_word
>>        return false;                         __sbitmap_get_word -> nr=-1
>>      mask = xchg(&map->cleared, 0)           sbitmap_deferred_clear
>>      atomic_long_andnot()                    /* map->cleared=0 */
>>                                                if (!(map->cleared))
>>                                                  return false;
>>                                       /*
>>                                        * map->cleared is cleared by T1
>>                                        * T2 fail to acquire the tag
>>                                        */
>>
>> 4. T2 is the sole tag waiter. When T1 puts the tag, T2 cannot be woken
>> up due to the wake_batch being set at 6. If no more requests come, T1
>> will wait here indefinitely.
>>
>> This patch achieves two purposes:
>> First:
>> Check on ->cleared and update on both ->cleared and ->word need to be
>> done atomically, and using spinlock could be the simplest solution.
>> So revert commit 661d4f55a794 ("sbitmap: remove swap_lock"), which
>> may cause potential race.
>>
>> Second:
>> Add extra check in sbitmap_deferred_clear(), to identify whether
>> map->cleared is cleared by another task after failing to get a tag.
>>
>> Fixes: 661d4f55a794 ("sbitmap: remove swap_lock")
>> Signed-off-by: Yang Yang <yang.yang@vivo.com>
>>
>> ---
>> Changes from v2:
>>    - Modify commit message by suggestion
>>    - Add extra check in sbitmap_deferred_clear() by suggestion
>> Changes from v1:
>>    - simply revert commit 661d4f55a794 ("sbitmap: remove swap_lock")
>> ---
>>   include/linux/sbitmap.h |  5 +++++
>>   lib/sbitmap.c           | 28 +++++++++++++++++++++-------
>>   2 files changed, 26 insertions(+), 7 deletions(-)
>>
>> diff --git a/include/linux/sbitmap.h b/include/linux/sbitmap.h
>> index d662cf136021..ec0b0e73c906 100644
>> --- a/include/linux/sbitmap.h
>> +++ b/include/linux/sbitmap.h
>> @@ -36,6 +36,11 @@ struct sbitmap_word {
>>   	 * @cleared: word holding cleared bits
>>   	 */
>>   	unsigned long cleared ____cacheline_aligned_in_smp;
>> +
>> +	/**
>> +	 * @swap_lock: Held while swapping word <-> cleared
>> +	 */
>> +	spinlock_t swap_lock;
>>   } ____cacheline_aligned_in_smp;
>>   
>>   /**
>> diff --git a/lib/sbitmap.c b/lib/sbitmap.c
>> index 1e453f825c05..06b837311e03 100644
>> --- a/lib/sbitmap.c
>> +++ b/lib/sbitmap.c
>> @@ -60,12 +60,19 @@ static inline void update_alloc_hint_after_get(struct sbitmap *sb,
>>   /*
>>    * See if we have deferred clears that we can batch move
>>    */
>> -static inline bool sbitmap_deferred_clear(struct sbitmap_word *map)
>> +static inline bool sbitmap_deferred_clear(struct sbitmap_word *map,
>> +		unsigned int depth)
>>   {
>>   	unsigned long mask;
>> +	unsigned long flags;
>> +	bool ret;
>>   
>> -	if (!READ_ONCE(map->cleared))
>> -		return false;
>> +	spin_lock_irqsave(&map->swap_lock, flags);
>> +
>> +	if (!map->cleared) {
>> +		ret = find_first_zero_bit(&map->word, depth) >= depth ? false : true;
>> +		goto out_unlock;
>> +	}
> 
> Direct check over map->word should be more efficient than find_first_zero_bit():
> 
>    		if (READ_ONCE(map->word) == (1UL << depth) - 1)
> 			ret = false;
> 		else
> 			ret = true;

Got it. A little modified as follows, because:
1. The depth may be shallow_depth, which is less than __map_depth()
2. (1UL << depth) may overflow

  72 #if BITS_PER_LONG == 64
  73         unsigned long word_mask = U64_MAX >> (BITS_PER_LONG - depth);
  74 #else
  75         unsigned long word_mask = U32_MAX >> (BITS_PER_LONG - depth);
  76 #endif
  77
  78         if ((READ_ONCE(map->word) & word_mask) == word_mask)
  79             ret = false;
  80         else
  81             ret = true;

>>   
>>   	/*
>>   	 * First get a stable cleared mask, setting the old mask to 0.
>> @@ -77,7 +84,10 @@ static inline bool sbitmap_deferred_clear(struct sbitmap_word *map)
>>   	 */
>>   	atomic_long_andnot(mask, (atomic_long_t *)&map->word);
>>   	BUILD_BUG_ON(sizeof(atomic_long_t) != sizeof(map->word));
>> -	return true;
>> +	ret = true;
>> +out_unlock:
>> +	spin_unlock_irqrestore(&map->swap_lock, flags);
>> +	return ret;
>>   }
>>   
>>   int sbitmap_init_node(struct sbitmap *sb, unsigned int depth, int shift,
>> @@ -85,6 +95,7 @@ int sbitmap_init_node(struct sbitmap *sb, unsigned int depth, int shift,
>>   		      bool alloc_hint)
>>   {
>>   	unsigned int bits_per_word;
>> +	int i;
>>   
>>   	if (shift < 0)
>>   		shift = sbitmap_calculate_shift(depth);
>> @@ -116,6 +127,9 @@ int sbitmap_init_node(struct sbitmap *sb, unsigned int depth, int shift,
>>   		return -ENOMEM;
>>   	}
>>   
>> +	for (i = 0; i < sb->map_nr; i++)
>> +		spin_lock_init(&sb->map[i].swap_lock);
>> +
>>   	return 0;
>>   }
>>   EXPORT_SYMBOL_GPL(sbitmap_init_node);
>> @@ -126,7 +140,7 @@ void sbitmap_resize(struct sbitmap *sb, unsigned int depth)
>>   	unsigned int i;
>>   
>>   	for (i = 0; i < sb->map_nr; i++)
>> -		sbitmap_deferred_clear(&sb->map[i]);
>> +		sbitmap_deferred_clear(&sb->map[i], depth);
> 
> The above 'depth' is whole sbitmap depth, and you need to figure out
> word depth from __map_depth().

Got it.

Thanks.


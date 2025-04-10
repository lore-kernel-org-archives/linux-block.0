Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2080.outbound.protection.outlook.com [40.107.244.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC6091E5206
	for <linux-block@vger.kernel.org>; Thu, 10 Apr 2025 19:34:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.80
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744313693; cv=fail; b=rAaZxLiOD5YhHSOXtHB+UK3yU3qif24Fv7HOjciUD7sbFSzGaRLqQJm0UI8Aj2FFhM9kKH9wrlU/sgDI0DI/Huc12pu2CwusE0ayPMEaHSwT7CuyUkjIm4DeD6G2U19WJotD2jptpG7yaRdjE5F8n46rRoOQg+W1dVW6VJoLSmY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744313693; c=relaxed/simple;
	bh=q5T9seyKe+GuZRMpag/NYkK5p2DhM+LcsxTYtyAXTr4=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=U7oDRShtIMk5mV2RIaINxbEFp0cMjTGK3E/1lfP9kE584OPmkKWqGN/OJzXuUGA70Ewe3dadF20vakY24UXFwiaVyt5ZQXeQyK+No4JsyJEkLwWjWfun3mVRD+VScGvUTZ6eJc9HXLlToSaiSN5NejircqrDMCdUN8Dewx/UKAM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=kEg5ieXq; arc=fail smtp.client-ip=40.107.244.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="kEg5ieXq"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dzsL7G/TMESLLEjUuZQJOLCWWPrIpwmXvjb5iLxZC9mqTbHD0AIz2LRSx7Gi1Qn4qeI87OesgEC2XKmVnzx3iLi6qR6KdivaORjnNa5oaVUHg8XkqHQdksNiTh2iRCkH+Q1tfi0MdTWYH/9qVCP/vGLZ8eahOVyRjAlKRpGrsKJXZXwFm1L7AVL/LPKY8kp0AHx9N0pTUw3mJC+SWbfRKgbUKbmxZcn5GUfl5eFv38zZG780RA4tWoUzbrjtqlGFhRoNDpTHUhpLM+Fq5EAM/hEWJmn7cyCpvV4AB+fgm5DiKcDp68HlKkNWnLIUoNq24ela6JjTZN/WKFiaDyTC0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0KEd3VD672Iq4sVlxvW7fG8ZhiZAW71CgUu4j5N/wQo=;
 b=fWw8pV0M7bj4qeUjCExK+ZxXZn8ZwPKqce2MWcbT1OH0uDe+BmK/lcXBZyXEPioo+jzAWw9jhAis7sFKr7FzJDDPxrcmwAPOPEq7f2QYmivQJBKNwLwMqoSQAdK0wLHXMpHJRiRzc7riBirVzaTiTzKkgjfS2+AWwdpQCc3XNIEWX0Ce78APUqtAvVITuosEh2WLg9SrNigKfikHmIzEkW4oQkmXR4cUDxSf27H4PriVlUPoXNJUhibE3UzPWs89C8yg5H7mdw5Mxn7TukrT3sgEB0i3zwyS2LLQJKkH9T5Qh2fQ+vvq2pkMvo3peFasAmXzYJvzdW6S/woLKg0yNw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0KEd3VD672Iq4sVlxvW7fG8ZhiZAW71CgUu4j5N/wQo=;
 b=kEg5ieXqEkcdlE4fZiGFHNO0EgzH4ydb9s9qV+pW/+Zk8iYfW/448cvJS/lwuEeS8Ik1im2i8f8TQcI7BtB9sCH908NbuPSGZ1e5kZZudH6Bkiu+KoylbUlmTuNWWikJlstZT2pZZfW+XUvcXrSBhXKn9DuXxim/muV8dVL9662bnRfKPMes955+BidC9+y1+9y8aY0/3vP0T+swx1D4Xrfel33e9eNstDmV/B+CyxAeBXXfNFXBygMl3G5epQgi6IDipttwaPo5tr56V6dcdCatPSK4tH37m/4co/A2oZY+kef2tDkhPP+UJ9hC1jE36QADCnQAMmXqprfSaaXopA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5968.namprd12.prod.outlook.com (2603:10b6:408:14f::7)
 by BL1PR12MB5995.namprd12.prod.outlook.com (2603:10b6:208:39b::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8632.21; Thu, 10 Apr
 2025 19:34:47 +0000
Received: from LV2PR12MB5968.namprd12.prod.outlook.com
 ([fe80::e6dd:1206:6677:f9c4]) by LV2PR12MB5968.namprd12.prod.outlook.com
 ([fe80::e6dd:1206:6677:f9c4%7]) with mapi id 15.20.8632.024; Thu, 10 Apr 2025
 19:34:47 +0000
Message-ID: <f7d0df82-18a6-41e7-9588-e841b2a01d18@nvidia.com>
Date: Thu, 10 Apr 2025 12:34:44 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: Does GUP page unpinning have to be done in the pinning context?
To: Matthew Wilcox <willy@infradead.org>
Cc: Christoph Hellwig <hch@infradead.org>,
 David Hildenbrand <david@redhat.com>, David Howells <dhowells@redhat.com>,
 "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>, linux-mm@kvack.org,
 Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org
References: <939183.1743762009@warthog.procyon.org.uk>
 <67d4486b-658e-4f3f-9a67-8785616e6905@redhat.com>
 <dcb80dc4-a9f7-44d8-b88c-7221ea29deab@nvidia.com>
 <Z_NzBWIy-QvFBQZk@infradead.org>
 <f04289cd-128a-492e-a692-6f760e2271e2@nvidia.com>
 <Z_dzKUp1ukaArcSx@infradead.org>
 <21dfcbfc-5295-4493-8ae1-eaa82f018472@nvidia.com>
 <Z_gYpwn5TvvYap6N@casper.infradead.org>
Content-Language: en-US
From: John Hubbard <jhubbard@nvidia.com>
In-Reply-To: <Z_gYpwn5TvvYap6N@casper.infradead.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR03CA0280.namprd03.prod.outlook.com
 (2603:10b6:a03:39e::15) To LV2PR12MB5968.namprd12.prod.outlook.com
 (2603:10b6:408:14f::7)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5968:EE_|BL1PR12MB5995:EE_
X-MS-Office365-Filtering-Correlation-Id: ba5bcbea-6440-47a9-d4e5-08dd7866c0cc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Q1RtYU12U1ZXYUxWTXNIT0lYWUE0L1pwVzdkblJPcFppbmgvcm91a0d0MEZr?=
 =?utf-8?B?Nitia2p6VENqVFYyb3ViSndzREdsdmFTWTEzc3llN1VLSkxWOU5PTmpQb1Jo?=
 =?utf-8?B?RmZnRTlSbFlkMWpMSjhTMS92czUwUlFFTjEwNG1JaFRoWjQyYXMyTktKU3dq?=
 =?utf-8?B?S2RaZDMvNVI2V1BsMjI4Z1lGZTJZTEZLMExDL2xZY0FxZlZGNTRSckg0LzIv?=
 =?utf-8?B?Y1o2bUM4NVJxZWZNNUxBTVpVdWRiV09WVEdqdkpmOEpiTUZFdFdvZnRNNmVE?=
 =?utf-8?B?dnJ5dyttQVBoSURZQlhDcXRVbThXZm1Mbk5tQVBMUy82RlVuaS9TWUFQMzht?=
 =?utf-8?B?SXhLWTZzWDhDa1dsSW9GRmtSWXozZnZmaTl6dzllS01pVjM3UVZPUjNQRFA0?=
 =?utf-8?B?OWZNV1NUdXUzVWtMalFjN2dxblQvUDVITWFnelNBcSt2M21aWGVta293aTdV?=
 =?utf-8?B?U0V1TzRTaWExSU5ocnAxTGZ6cUVCK0UzaEJDOWpsek1xVnkweG92RXprVWc5?=
 =?utf-8?B?bjE0ZHBPbHc2Ukt5NC9haVp6bVQwVGNackFqaEJxUEw1VWFvT0xpNVIxMkU1?=
 =?utf-8?B?MzQ0NVVYcitrNjlCOE5KaHoyWDQrSDJMeEFxekVZZ2tmTmRYZ1hDbjBZM1B0?=
 =?utf-8?B?dW1Wc0VFR2I2ekxYaDVPaThMbGxYdkhkcWZodVNXSmtwYitaRVRVSXFOS1lH?=
 =?utf-8?B?eG1RQ0dVc2JVb3ArcFkyN1Ira0RNeG1vbmFHTUJ0NGd4SmpVV0R5TnZZcTVK?=
 =?utf-8?B?MEdVTjRka003d2Y4QnpyamMrbnZnbTEwRFVpbGxqREloU092V0NzaDlkRXRN?=
 =?utf-8?B?K1FVSWVpTEtSaHh4aDJxVHJXTzdic2VVRHlwcFQ2WUFTemY3Zlc2WDlKUlNR?=
 =?utf-8?B?Q1gybHhkY2FZL0czNGZ5dktnZDE2MUxWd2d2SC9hcldWVHo3RS9sTEd3ckhj?=
 =?utf-8?B?Zmt2blVMZGFIdEZ2Nm4vZ3M4amRGRVBuQksxcTVld3BKb3RrVytyN2F0NFVa?=
 =?utf-8?B?NWtRUlVMVktPN2dsejJLZVM1bVd4Vmt1a1BJdVlmY1diSEwxd1l4aWRncFE2?=
 =?utf-8?B?dWFWbnlzTjB6NkIraDFCWlE1c3QxbjdWOFZkLzVQc2hhMzlmVVhxbW5hZmo5?=
 =?utf-8?B?bkgxSnpXMUZxMzBtUXdjclg5TDk4Nk10Mi94WUFQSU9LR01oeDI1K0RSQWZU?=
 =?utf-8?B?RVpwKzVPNGhuSk83Y1kvZ1A0ZmVWRG4wUUJYMCtwTGI2aE1aVnBidU85Qk5P?=
 =?utf-8?B?dThZaXR5L0JuaUIzZjV0MnloaVdBSnNDSmMzZXFGcVZEOUltZnYxSDNuenc2?=
 =?utf-8?B?NG5uSEZDUVhZTHd0c1BvZXgrVFhkUSt4MTJMRlNNeXBGME1GNFY1UGpvK1Nm?=
 =?utf-8?B?K3RzOXVKZ0FvbUpGWXpFNHkvNHNsOGg5Ty8xaFUyZTJraGk4Qk1nYndmWEhr?=
 =?utf-8?B?ektiRmN0eVlWYUVXVW53QVlqMXNJUVRJQmNCZkQ0Z3NxUUxIU0xyUURGNzhC?=
 =?utf-8?B?ZEVHSU9tdDVuWWxneWhiSmRFTXVDQXFmY1ZUaVlkOS9qajRlaWx3ZC8wRnp3?=
 =?utf-8?B?NFk0dmtrZVZrMU85NUNLR3pOcE1rNlFqNm5nVitLMjAwcGk2ekpXSW0xLzcv?=
 =?utf-8?B?YnF4cENoTFNaZHBZMFdOVDRWallUVzBrWWVLRkZkVEFMcTlHTzZNT2pYcGZk?=
 =?utf-8?B?cmZLZUNvUEVMbkRncXB6V0NrdDFmT3cwTUZ1bFluQ2VrK00xMUE0WFVhZXZm?=
 =?utf-8?B?Zys2ZHZCbE03TloyampKRVdSNlM4ZHBHV2VoTjAwRnEvZVJyZ1dGajV2UmxU?=
 =?utf-8?B?ZC9uWG4rbkw1RzRhR3hBaHE4K256Zmt1MERDRjBEUmtyMEpQSWxzOTFkd0RF?=
 =?utf-8?B?bWI3MjdVOGhYQllIZjh4ZmdrSDZNTTBNWE1hMTFlODM2eERNQ0Q3dHRqUmtY?=
 =?utf-8?Q?oQyCSk07D1w=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5968.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?N21kU3hiVk8vd0ZmTk02YnpjcStqcjJIOGlCODN6c2NLWlhNUHJCVVBGanZv?=
 =?utf-8?B?U0dGbXJ4Qmp3dm5Rem53TGh4RGU1QzFpZDFKaER0S1FOQTBiVnk5NnJ3WXBZ?=
 =?utf-8?B?VnRCWW1wSEFRMnNYc0pGSDVaZWplZ1QvMEpqZXZJUTh6d0hLUW1BaEpHZW1t?=
 =?utf-8?B?VVVna0xwRHNWUXBFVzhadGtMQU4xbHNLOXJwS01yOGsrZkZEMmFLTVZGcDZr?=
 =?utf-8?B?cGREQzJnNk0xZzZpUGQ2UitobXdkc3RsSTZ6T2E5NjVTaFRSaXIrdWZmZ0ZC?=
 =?utf-8?B?MzVqYXJqQjJWc3BxNGZ1dkE1SWFXY1pWb08xMHJMVUxJZVp2Nklhb2ZWb01D?=
 =?utf-8?B?S3RVUmF3dnc5K0pCcTRINHpxamgzdGdTcE1qRFVQMTkwSE9kR2g1TDQ2amFy?=
 =?utf-8?B?algySkRJNXhNM2VieXBaMmFlTFp1cjNINk0zNmNaTjlTcVhEUmpXMXFmWk9N?=
 =?utf-8?B?WG5NZjhFV1MvWmMyN0lZemRkSi9Id0ZiRVl1WFRVd1YzYzJYd0pFNjFOSEtB?=
 =?utf-8?B?UkNXcUQ1V1YwK1dZOWRaUGo1OXFPN0FoLytQWHhTUWV3NklVUzBoNno0MjI5?=
 =?utf-8?B?TDZWdVdINVNCNzMzUlBHUzA3dDlDRjhFdVJ6ZC9Bb2dmS3BOeUJ5eVozdGVa?=
 =?utf-8?B?a0F3UzZ5Qm1NWE1CWG5EclBrbGpMenNmSjFZTnRkTE4xSmc0cGRiWDkxQ1lp?=
 =?utf-8?B?dTYzWHY2a1RBU2daWFhUbDNjamRhbWhBSUpCRVhQMmZlMGJJWG5sNXB5YWNv?=
 =?utf-8?B?QXh0bTVqcFdVb1Fuem90Unk0NDh2VG9BT3RSSldHMDB5ZjBTM2FZem5PajBP?=
 =?utf-8?B?RFdtdEdEZG05blVRMUFrekNYdmRXb08vL3I0aHdDMk56ZVpYMHdSUEVhWXZU?=
 =?utf-8?B?bVppUWtQZEJPaTFhQk1IWU9DQm83Qk1YZHlHL29KZFhVS3ZnWTlFVDRGeXVW?=
 =?utf-8?B?Y00rUWNEdkMvUlF4TG45L3NTSmp2LzlvVzEvUHd2Z3hUZWh0d2hUU3lTWlBr?=
 =?utf-8?B?MW5DejBQSXpyZUIvWXEySGcvR0JMVEYyNU5BdWtaZWhjdGtKajRmZDdjZ3ZG?=
 =?utf-8?B?dXFUa3puaGZEa3BpRjJJUW8zY3AyYVRhRFhTYVl1QmFBa0ZqYWxvQXZHTVda?=
 =?utf-8?B?aCt6bHF4UFNESURrRjhZT0tRbzZzak8yZ0ljdFVSek9ENFlhNUh5UXd2RVAx?=
 =?utf-8?B?ZURyVTVOUGhFQWVqUEFzVWxINWhUb29DYm5TQ3NGWmQ2aTZUOUk1bW9NbFRM?=
 =?utf-8?B?c2FteGZIUWpUblM5WWdMeHZFNzVDYVJ0QkJPNnJ4QjdOamxVV1RuVkZMVHhV?=
 =?utf-8?B?UU00WWE3N3FpUUpCZDEyOXYvaUYybCtZUnZzYlFFWjg5ODZTenY1aHZKUi9x?=
 =?utf-8?B?ZVcva2N6R2xlY2xrenBCL01Dc3RNdzBZc25zaXRIZzNlUVBWRm5wOTVGbnl0?=
 =?utf-8?B?NWNVY1VoRXl1MDNjaTQ2TURKUFo5UFIzRW1ENTNmekViNk5pa2dPNWh4dUJz?=
 =?utf-8?B?RHdCT3VyaHdoL0h2U3JxM2cwU3djeC9wZzMzYk82a2dlS2I5MVB6WUhwREYw?=
 =?utf-8?B?clNuK2RZMXVFOVZjZmkveGdZaEh1T1EyTUF5SWhoQ1lPUDNoYkNoQjQ3MzBr?=
 =?utf-8?B?ZWxBM2U0UW5HejV5cWt1aFhQQnZUeUFtbXgvMm5kTEVydVpKTnBIS1hjVnRS?=
 =?utf-8?B?dUpjVGhnR2pKWVNzeWtNdkQ3VTJuZ2thVk1INDFkanJ1RXIwTG5rR0E5NUFh?=
 =?utf-8?B?QmRyOHBURjVCNElVSURpbWc1RjM5WldtWUtmblk5Nytmak13OTlSYjVEbE8r?=
 =?utf-8?B?V09yWXFnZjgyYk9EUWVLYy8yZW9DODZsRjhreU13NjE2N2dSVVpIU0xGSlNU?=
 =?utf-8?B?ZWRJdkdoeEtmRUt6S0RFWUxLRFZxeUFOZTZXLzdGWUdqNlNsL2hMWngvVVR0?=
 =?utf-8?B?OWozYzRSSEZEU2lML3NJSHRJNFNtUlRad09lZ2hsUmZZQVpvajk2WGNmRnBy?=
 =?utf-8?B?S0tMR1pNMEE4WmpzeStRT0IxRnFYZzVtd2o3bWN6R2JNMUVkUUtUUmJlNWFC?=
 =?utf-8?B?UDlQNklmN1ppcnhyeTVGSU0vWEhwWkozTTl5YXljMXUxSm5qYmxYRS9oby9G?=
 =?utf-8?Q?wR/Yn8Nanmkg7lgfjnVj4K8R4?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ba5bcbea-6440-47a9-d4e5-08dd7866c0cc
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5968.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Apr 2025 19:34:47.5089
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lZkuUD1ejKxP8aeaHW4BR3yNQf3UzdxHGAPemIh699K55+NIcfynHbGO+A5z+QFrZ7ZtBg3S7lRowVoxOu82DA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5995

On 4/10/25 12:14 PM, Matthew Wilcox wrote:
> On Thu, Apr 10, 2025 at 12:11:42PM -0700, John Hubbard wrote:
>> On 4/10/25 12:28 AM, Christoph Hellwig wrote:
>>> On Wed, Apr 09, 2025 at 07:56:07PM -0700, John Hubbard wrote:
...
>> Oh actually I think I was wrong in my earlier reply about clearing
>> the dirty bit. Because in Jan Kara's original bug report, what
>> happened was that periodic writeback came in while the pages
>> were pinned, and cleared the dirty bit--and also deleted the
>> page buffers (file system specific behavior) that are required
>> for writeback.
>>
>> So then later when the pages are unpinned and marked dirty,
>> that causes the next writeback to fail in an unexpected way
>> (it used to cause ext4 BUG checks, in fact).
>>
>> So the problem here is that these pinned pages can get cleaned
>> while they are pinned, and then dirtied again by DMA (invisible
>> to the filesystem).
> 
> Did we fix that already?  Because it's relatively easy to writeback

Maybe not?

On a closely related note, I do still see folio_clear_dirty() being 
called from ext4's mpage_prepare_extent_to_map(), along with the ext4
bandaid [1] that was applied to mitigate the problem:

	/*
	* Should never happen but for buggy code in
	* other subsystems that call
	* set_page_dirty() without properly warning
	* the file system first.  See [1] for more
	* information.
	*
	* [1] https://lore.kernel.org/linux-mm/20180103100430.GE4911@quack2.suse.cz
	*/
if (!folio_buffers(folio)) {
	ext4_warning_inode(mpd->inode, "page %lu does not have buffers attached", folio->index);
	folio_clear_dirty(folio);
	folio_unlock(folio);
	continue;
}

[1] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=cc5095747edf


> pinned pages and _not_ clear the dirty flag.  That handles the two
> problems which are falsely thinking that a heavily-mapped order-0 page 
> is pinned (we write it back anyway, so don't lose data on crash),
> and doesn't strip the bufferheads.

That sounds like a viable solution!

thanks,
-- 
John Hubbard


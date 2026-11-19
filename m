Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.57.62
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795047568;
	b=kjAfB3jUdEOCTbed3Yam/jAgHjsaJ9enXiBmN0TXBmpobs8p0BmuOoHFi5y21zUMW/TA
	 Mq3uMq4LwgGGsZxNk05WlasOx//r25GPKwnG3AkqQsUdEGBNWKLB34RnFD2zFkmoXr7K0
	 jTjBzcex2+MtajXIP66TKm4S8NhMeQ9TUEqNnwEsviubx+0YqAFmyXqYdNzsE11T1hKhX
	 34lkeju8r3PWHSKarmfqMQoEtz4EMaIimLcpmLo9fLiOXLMBEN7/2gz5P6ELtUvn7S6wA
	 WIrI6GFJbbe6C5K+tACUyPnQASjE8PbfnMHYCm4R7d3UBxDfP+uAdoCL1lIqCbITCzw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795047568;
	h=DMARC-Filter:DKIM-Signature:Received:Received:Message-ID:Date:
	 User-Agent:Subject:To:Cc:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:X-ClientProxiedBy:MIME-Version:
	 X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:
	 X-MS-Office365-Filtering-Correlation-Id:X-MS-Exchange-SenderADCheck:
	 X-MS-Exchange-AntiSpam-Relay:X-Microsoft-Antispam:
	 X-Microsoft-Antispam-Message-Info:X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
	 X-MS-Exchange-CrossTenant-UserPrincipalName:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=b2iWOMkOOrJXcXP48QdCvlsxKBp7T1cxHopv55FZL9Q=;
	b=udGGiJW+tCC0HlJ3+z1304brUVEBQG297T5/+48J1eKSo4HparrSV1UES4IA2mUw8foO
	 EVI2KlyTUi7e/U4nXdi2XIw+agUYvhCcN2PcQA8Op5LYP7YJf/dVqCXh+UWzkXPgIyGTz
	 YkBSVTUYqFSvJPqoeFqzxCKNybZGSUjCEVVVIaS56hJvsaEIxi3v4StqM4NRjXDMp2EM9
	 l9iANxg6iKzROSANHZl68CXbC5RY7wOjuX8k99/9vSYY9s/7uZ51H3eRDro0xaf5+9B2p
	 AOLpT7+QX8+TwDCA60jdY6VM4Plj+GMPiXNYwfysB9F7eXeQdWy3ld20fynme4WX/bA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nvidia.com;
	spf=fail smtp.mailfrom=nvidia.com;
	dkim=pass header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=K4Pn1zdY;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.57.62
Received: from BN8PR05CU002.outbound.protection.outlook.com (mail-eastus2azon11011062.outbound.protection.outlook.com [52.101.57.62])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19B87606A31C;
	Thu, 19 Nov 2026 00:19:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 19B87606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=K4Pn1zdY
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TCqV+bOxL72uLEyqU8dNfQpfuqoyPssagyUCijMUSNSCZreFh+FLITIKUCu3aod9b1yaR0si2s611MveN2G9OkDcGIHZIgnzmsG/uNYw8NHFFDi5UYlBIehYCQQqi/l1PIgPDIp7u9HJhz1tkk2UH7/qHMLAI+Y7Hmdc0qlqarO6NEmveDs34NM5EBTXRy05R+jI7XMW0wGAAtb8BKzQ7/sRGsqmhl5si1fowdhYfOSwXGycQOJEItZ4DzvR97+QmjRc4fnKZhrApzm+UdIKJI2LiZaEJSbbWSJjntDOzs8iGWQHP2AUhTsvcDQ++mlD13Lx3x4Jcnqx++gx/HAR2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=b2iWOMkOOrJXcXP48QdCvlsxKBp7T1cxHopv55FZL9Q=;
 b=aYjvnN4i8UTF9s7BzxTM/a5DMqKBI9DCoj8tfQjYveUYZOj3cGS8+JQx9w3iYSsppTdFP6g6I7iJnXwiAYHD/zBC0LKQ62rc203KdxACXzDZZ9jLO7Aj9t5DzNK03UuUq17/717HX3UD9olrFqU3WMcykCzIIvN2/SQtw4R+65vwC6qBi/Aslh1jctylJF/DDECpVqO3q7T2J7WL6Cl9oo7LKgiYdxW37bmJOG/LLRlpdTrn5m+juZOCEklLj6VRatGwtBCUb770oCLAKTngKCpQk5TBQ3A5YzJ/C8VjQuBh8cL+0dIaFWVp18EtWIwe0iLEHG/vQG5nFDX/nje8ug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=b2iWOMkOOrJXcXP48QdCvlsxKBp7T1cxHopv55FZL9Q=;
 b=K4Pn1zdYZKw19eFlkAbLmNyQOEtZt9b8s2xl3l6ZkWvGYIWBY7Pj9oZZ3JDc8GvfMCLEEHeIKC8IHTRI2RjKRbD+hHUdc6Nd3jKskYBCYfRLCi30sKRn2cpv0VKLWbVNbwb40Xs/3AjYfJbqS1vTPKcI168/IN8ZzGUV+1Hs8Y8oi3cZ5qVFquKpFNUUtSPWdnlLYS0aLM8P9rmi9nqtGAATNrwqKzs0An8ZOk2sXaA+PCkAW4XPSlsh0TsZWenJ61c0Fid/gHJO7Xd0ZVEmkLLFNdgMy5rADVoG+KEdiEVdUVoQUwUsjNzTkUBsysWaYWFJioM2XByM59xlfxMmQw==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SA1PR12MB5614.namprd12.prod.outlook.com (2603:10b6:806:228::7)
 by PH7PR12MB5687.namprd12.prod.outlook.com (2603:10b6:510:13e::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.14; Thu, 19 Nov
 2026 00:19:23 +0000
Received: from SA1PR12MB5614.namprd12.prod.outlook.com
 ([fe80::1a0c:e9e8:f3a5:d9d6]) by SA1PR12MB5614.namprd12.prod.outlook.com
 ([fe80::1a0c:e9e8:f3a5:d9d6%6]) with mapi id 15.21.0615.013; Thu, 19 Nov 2026
 00:19:23 +0000
Message-ID: <41616012-6526-4350-b348-96d2c4946a7c@nvidia.com>
Date: Wed, 18 Nov 2026 16:19:21 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 0/5] gup: introduce folio-range interface for pinning
 user memory
To: Swarna Prabhu <sw.prabhu6@gmail.com>, akpm@linux-foundation.org,
 david@kernel.org, jgg@ziepe.ca, viro@zeniv.linux.org.uk
Cc: linux-mm@kvack.org, linux-block@vger.kernel.org,
 linux-kernel@vger.kernel.org, dave@stgolabs.net, riel@surriel.com,
 yeoreum.yun@arm.com, hch@lst.de, Swarna Prabhu <s.prabhu@samsung.com>
References: <20261118213458.377258-1-sw.prabhu6@gmail.com>
Content-Language: en-US
From: John Hubbard <jhubbard@nvidia.com>
In-Reply-To: <20261118213458.377258-1-sw.prabhu6@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR03CA0271.namprd03.prod.outlook.com
 (2603:10b6:a03:39e::6) To SA1PR12MB5614.namprd12.prod.outlook.com
 (2603:10b6:806:228::7)
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
X-MS-TrafficTypeDiagnostic: SA1PR12MB5614:EE_|PH7PR12MB5687:EE_
X-MS-Office365-Filtering-Correlation-Id: 54b4a242-f9fa-41f2-de2a-08df45d2c32d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|376014|7416014|366016|1800799024|261022113327099003|261022075727099003|261021123027099003|260925021311599003|260925022911599003|11063799006|260925021911599003|56012099006|261026140227099003|10067099003|261028144727099003|261021121427099003|261022105027099003|261026121527099003|261102123227099003|261009223027099003|22082099003|18002099003|6133799003|3023799007;
X-Microsoft-Antispam-Message-Info:
	uEo4sqyKcmBf673s7hQRLOQC3DWHVOS0GuIsT3Rs4N3zQ+xPlXeDg6FODH5PkeZEE30W7b63FjEUZg169EAK+RRhddrSMWR4ON6rISK0vA9A6Nr3KEDRgC/YRyV3qRextRyMNdQOYPtJG/Tn4RTU+WLIJ5FNbv26JlBByWmsydzo4p63QwSEuPJ+jA4s4gX52TIj6C8C+aeKNP2rnOOb3n1xEXVsKFW36o5dIpnR7R4MR1Om2mgAc+ssGGeVjJHCgQ3NRml8PzfJ/mMSANgWUOAOueP0jid+De1/y/x4JFPPmD0unIs2XeBFGKXUWayjQI1PsKZayfS+oledecNTDzxhEXarpujocSZw5OqV+y88g+2IuLnU7cBGx5UEexbOq+TgZl+7JhV+V2YtUZ37cgc+cdLj+dXdqyZoLNZdBvTw1m8ooou/hM1yg7NpECOaGCclZqJ9Itw7JLaB8LIqwtouY82fGd6t1ttkAfMrYnq1B6qKA5YMUQewaKJ0WZauXeR4XPsC9ZTTTYtyu1dQoInmDbP64nKNkCgBv70PfAckaFpCKF1I6ZGsYeHs6cNPSQhXjXnloNLB5xRVanEZzC2rSK2hOd4t9u4i+4ZU6AMn2SPGhTnD4Yteo8DBHFsKWyZ3e2QOIiwhW7FRi6uRdH57e/1IYb43lSP9/UTJjTE=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR12MB5614.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(376014)(7416014)(366016)(1800799024)(261022113327099003)(261022075727099003)(261021123027099003)(260925021311599003)(260925022911599003)(11063799006)(260925021911599003)(56012099006)(261026140227099003)(10067099003)(261028144727099003)(261021121427099003)(261022105027099003)(261026121527099003)(261102123227099003)(261009223027099003)(22082099003)(18002099003)(6133799003)(3023799007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?N2VpRWZxMWJMbXVzeWpkaEczdlYrbkFta2pDaUVQRCtZZnQ0R096K3dtV0Zm?=
 =?utf-8?B?V3drV20zbnVKYzliWTZaRGVIcTBlUlhqeTRDQ3Y4QzdjZDBYR2dIdnJpamFp?=
 =?utf-8?B?ck81anJGYS9YYmFzUFdYQjg3cUlWaFJ1cnl1UUpvNDNGR2dadGdwSVdvZVFS?=
 =?utf-8?B?YmVJQ0lkb2Z0dk93VjBLMzllejhXOStMTmdPVkpoNTJoVGQ5WkplVGg3Rnpn?=
 =?utf-8?B?K1dmZXQzeC9sUk03a2dMTkNOaTZqY2ptdnB4VzdqYW94L1BDRytzNjNhYTBS?=
 =?utf-8?B?RW5TRFlxalhEa0ZmUEEyRTFqYzllNSttVWFkSlAyVDNYRVFXSFAvdXErMXhG?=
 =?utf-8?B?ZzA2WW9MYWVlNTc3MUluRXk0RHU5OWh6NTRVN1B5Vzg4U1d0cFN5bDBqbFkx?=
 =?utf-8?B?bk9XOXd2U0tZV3U0WlNhTmFLcEdsYmhrL3RMdE0zaHdWWittRi9aV3VTd0RM?=
 =?utf-8?B?NFJURHpZUmorZEdMaEhSSGxUejJHb2ZpT3IxNjFjT3UvOXRscTBXUGRzbWI0?=
 =?utf-8?B?Wk1ySEQvVUZwbjVmWWVOcmFWOCtCeG0xczRoNGdzeHZmb2NlT0RSaGR5ZVpj?=
 =?utf-8?B?Z3VjS2xmSXdPZFlEeGk1TmhUN2YvOXl4SGM4anhmOEx3WXcrbXR2Y3cxd2VE?=
 =?utf-8?B?SE0ySUg3am5mVitMTnVzNzZDOWxkRit1TmFuWGNzYTBaWnhGMFgzT3JuSGo3?=
 =?utf-8?B?REtZQ3FScmpKQmhDWFl6cGJYU25idTU1d2JTb1F5cC82QmRMSGpxNTV6WVVQ?=
 =?utf-8?B?MGRkTGFjQUNtY29hTEo0ME5ua0Z1bEdzeEdabmdCL0YvQ0F2ZFZUTXVjVktE?=
 =?utf-8?B?QURuOHJ3NWMyWExBdGN1UzZFcjIzaDV2WHFVN0c1VjNRUmovSlNMdjhBa3lG?=
 =?utf-8?B?LzZnK3JXUDZkUlpBS3dLZG8xU1UzaTZvdmY3dzhSMVN4dlZWQXB5WTV5TE1L?=
 =?utf-8?B?YnJyQWp1dWpEeFJvYmp0VWlQY2x4RUtrQ1pvcTI2MW5UUjUwVnlrTTkzSE4y?=
 =?utf-8?B?aHo4YXdmVEN2T1V2VFBiclZWL3k4SWRVcmh3REszanZXV1JvV25pLzZ6R20v?=
 =?utf-8?B?alR4RWhTajdnQ1Z0THJ6aWdMN2FrVnBoRGU0TzZwenJ1VzQwTnY3OE1tUnR6?=
 =?utf-8?B?R3l1Zno5OHoxTlQ1UUE2L1NVejhCbyt1REI5NmlnMXF1QzMvbnZTczJicG9Z?=
 =?utf-8?B?WXNlS1dpU2p2aE9kdlFURFlUeXFVNURxR0R2WXN1Z2FacTdWUmlnNCtLMkFx?=
 =?utf-8?B?SEFGVzhQMkxuR3lodlRSdWV6OXRONEZwVnZkSmUyckQwNUROaFJrMFhPZXR3?=
 =?utf-8?B?bWY4bmZ6LytSRlpZM09aZ3ArL3ZaQlhkZG1OZVVmdkNPZlJLeS9EVkNZeVZI?=
 =?utf-8?B?dlVEQi81cjdJUXJGcllEY1F3MTdwVGJhQUIvaTBVVHREcXAxODBIS3BuWTJC?=
 =?utf-8?B?VTcxV29aN1hOakdvT0p6eDJ3dGtHaStBbDFubnlFRTBJUGd4N1VWRXVpTklC?=
 =?utf-8?B?V29EeFd1Y3FveXQwWUNIbDFOOUNLUUdESE1JdE5IdjZpVnlZTTFqSGtRL0hK?=
 =?utf-8?B?STNjTU9hK1g2SHpnaWdIaVFyZHQ5NE9CaTVzSU4xZDFmZjQ0ZkxvVzd1QlV4?=
 =?utf-8?B?d3BDNmhkVDd3eUFrbUQ3MnNWSHJnVGw3VlFvTUV4V2NDY3Y0N0puNitRN2pu?=
 =?utf-8?B?NnVhditRbklSclJCV3paemRtdlYzVWlsaFltalFLZ2JkeWtLZXlyWS8wL3lB?=
 =?utf-8?B?cG9sL3Z1Tk45RHEySk1BOERrWE1pQkJzYWl5cmZTSnM0ZGJsck8vdHZ0QnV2?=
 =?utf-8?B?d2JKckpOb20rdUZXQm81UWVhWHIwTFZ4dE96SUxucDdaTmpGSVN1bkFKL3U2?=
 =?utf-8?B?Qk9RdlZPMmdqOVBxcWhWUGRwUmllaHNwRjFtbU1wOHp6R1p0QnNHb0c2MHZU?=
 =?utf-8?B?VGkxeFpZSjBKTHFPMzl0eWp5bDFxck12MlJReDlxM0NBYUFvRDRzNVpVSEh3?=
 =?utf-8?B?NWtqTHdLaU10ZjYyVVhJY244VjJqMjdROTIzSDdaZXYvYlp6amE5YW50YmdS?=
 =?utf-8?B?NllvSmRxalRxS1JJb0dwQ0lVV2hacW5qNVRFTVhqc3BoVmxVemlEOWhvaUFF?=
 =?utf-8?B?ZHkxRHlUVkVVSnp3UDIweG9qRnpHN3FTVkhPaVJOenZxdXJhMDhIZ3VHT3Jz?=
 =?utf-8?B?bDV6L1JJNzI0VWNnbFZIa1FPU3V6dVNZRHN3VG1KRWd0M0p2L1RMR0E2U0Vo?=
 =?utf-8?B?YjA0cUVhR1VzZFhmVWQrbTNCTG1pVkIxaWthQllyNVJyZHlYZ3dQSkNIdnRh?=
 =?utf-8?B?dHo1Q0NNb3JHbGN3VU5LZ2picVdPWkNUSzdLT3ZIS2poR0IzbCtrZz09?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 54b4a242-f9fa-41f2-de2a-08df45d2c32d
X-MS-Exchange-CrossTenant-AuthSource: SA1PR12MB5614.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Nov 2026 00:19:23.1714
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IxcTHxXsY2KKsWyoawg09f/TDudrgMx02T7rorEW/zKNoLOOMmANuf2yoSFe9K+aC+CUDvtGgU2Ukb0kFmRUTw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5687

On 11/18/26 1:34 PM, Swarna Prabhu wrote:
> From: Swarna Prabhu <s.prabhu@samsung.com>
> 
> This series is an RFC to gather design feedback to introduce a folio-range 
> interface for pinning user memory in the GUP fast path. Pinned memory is 
> returned as folio ranges instead of a page array: a run of consecutive PTEs 
> mapping consecutive pages of one folio is pinned once and handed back as a single 
> range. Block direct I/O converts each range into a single bvec, hence reducing the 
> per-page pin and merge work.
> 
> Base and dependencies
> =====================
> 
> This series is rebased on the following two series applied:
> 
>   - "mm: gup: batch PTE-mapped large folios in gup_fast_pte_range()"
>     v4 (Yeoreum Yun; originally posted by Yuan-Hao Hsu [3]), applied to
>     mm/core.git gup-7.5.ptebatch [4]. It batches the reference grabs for
>     PTE-mapped large folios in GUP-fast.
> 
>   - "batch lookups in follow_page_mask()" v5 (Rik van Riel) [5]. It makes
>     follow_page_mask() return a page count and record pages through
>     gup_fill_pages().
> 
>     Note: "[PATCH v5 1/8] mm/gup: break out gup_fill_pages() helper" was
>     posted just as testing for this RFC was done. To avoid delaying
>     feedback on the overall design, this RFC retains the tested base
>     linked in [5] and will be rebased onto the latest revision for next
>     version.
> 
> This series builds on both: the run detection in gup_fast_pte_range() and
> the batched slow-path lookup are reused, and this series changes how the
> result of a run is recorded and returned.
> 
> Background
> ==========
> 
> Kundan's LPC '24 talk "Transitioning get_user_pages to folio based mapping"
> [1] proposed a struct folio_vec (based on bcachefs) passed in place of a
> pages array. Building on that and on suggestions from the community [2], 
> this series exposes folio + index + nr_pages, where each range spans a 
> single folio:
> 
>         struct folio_range {
>                 struct folio *folio;
>                 unsigned int  idx;
>                 unsigned int  nr_pages;
>         };
> 
> Design
> ======
> 
> A "struct gup_out" descriptor in mm/gup.c holds either the page array or
> the folio-range array. The fast and slow page-table walkers append to the
> descriptor instead of advancing a pages[] pointer, so a single walk
> serves both interfaces without duplicating the walkers.
> 
> The PTE batching in gup_fast_pte_range() is provided by Yeoreum Yun's
> series [4], which this RFC builds on. This series reuses that batching
> and its page-table revalidation logic. For the folio-range interface,
> each pinned run is recorded directly as a folio range instead of being
> expanded into individual page pointers in the output array.
> 
> pin_user_folio_ranges_fast() stops once the caller's range array is
> full, so callers size the array in ranges, independently of the number
> of pages requested. A single GUP-fast walk is additionally capped at
> EXTRACT_MAX_PAGES (1024 pages) to bound the time spent with interrupts
> disabled when the buffer is backed by small pages.
> 
> unpin_user_folio_ranges() walks the range array and calls gup_put_folio()
> once per range, releasing the references pin_user_folio_ranges_fast()
> took for it.
> 
> In iov_iter_extract_bvecs(), the pinned folio ranges are stored into the 
> free slot of the bvec array and converted in place, one bvec per range. 
> Block direct I/O picks this up through bio_iov_iter_get_pages() without 
> changes to the block layer.
> 
> Non-folio mappings
> ==================
> 
> Memory that is not backed by folios, such as pages a driver inserted
> into a VM_MIXEDMAP VMA, makes pin_user_folio_ranges_fast() fail with
> -EOPNOTSUPP when no pages were pinned; such iterators fall back to the
> page-array path.
> 
> For folio-range output, gup_fast_folio_allowed() additionally requires
> a non-NULL folio->mapping, except for hugetlb folios. If the mapping is
> NULL, it falls back to the slow path, where the VMA can be checked.
> The existing file-backed and secretmem restrictions remain unchanged.
> 
> FOLL_LONGTERM is not supported yet and is rejected.
> 
> Testing
> =======
> 
> Measured the time spent in bio_iov_iter_get_pages() per I/O with
> function_graph, on the baseline and the baseline plus this series.
> Both kernels ran with the performance governor, boost disabled, all
> C-states except POLL disabled, and fio pinned to one CPU:
> 
>   trace-cmd record -p function_graph -g bio_iov_iter_get_pages \
>     --max-graph-depth 8 -O funcgraph-overhead -O nofuncgraph-irqs -F -c \
>     fio --name=io_uring_test --filename=/dev/nvme1n1 --ioengine=io_uring \
>         --rw=randwrite --direct=1 --bs=<bs> --iodepth=8 --iomem=mmap \
>         --iomem_align=2M --numjobs=1 --size=64M --cpus_allowed=23
> 
> Median of calls not interrupted during the walk:
> 
>   bs    buffer          baseline        patched          result
>   128K  64 kB mTHP      13.08 us        13.09 us         neutral
>   1M    64 kB mTHP      63.0 us         63.6 us          neutral
>   4M    2 MB THP (PMD)  25.9 us         8.65 us          ~3.0x faster
>   8M    2 MB THP (PMD)  49.4 us        ~17.0 us          ~2.9x faster
> 
> Note: the baseline is the upstream kernel with Yeoreum Yun's [4] and
> Rik van Riel's [5] changes applied.
> 
> For larger I/O, the baseline's bio extraction path requests at max
> 256 pages per GUP call, limited by the available bvec slots. This
> series instead uses those slots for folio ranges, each of which can 
> describe many pages, thereby allowing the series to request up to 1024 
> pages per call which accounts for the speed up observed in 
> 'bio_iov_iter_get_pages' for 4MB and 8MB DIRECT I/Os.
> 
> Testing: Ran selftests gup_test, gup_longterm and cow on the patched kernel
> and no regressions were observed.

This is very light testing for such an intrusive set of changes.

The series was clearly written via LLMs, and patchset submission requires
mentioning that in the cover letter.

I see that FOLL_LONGTERM is not supported.

So I think this is one of those series that will basically required the
reviewers to rewrite all of the commit messages, the prose, and probably
lots of the code too. People might be up for doing this if you were already
a contributor, but as a first submission, it is a lopsided request imho.

I'd suggest trying something 10x smaller, and with less AI bloat, first.

thanks,
-- 
John Hubbard

> 
> Link [1]: https://lpc.events/event/18/contributions/1773/
> Link [2]: https://lore.kernel.org/all/f2b5189f-10de-4685-97f3-6ee08d159743@kernel.org/
> Link [3]: https://lore.kernel.org/all/20260917083747.786-1-aa9736195201@gmail.com/
> Link [4]: https://lore.kernel.org/all/20261110-refactor_gup_fast-v4-0-e779a7674274@arm.com/
> Link [5]: https://lore.kernel.org/all/20261102193026.3860700-1-riel@surriel.com/
> 
> Swarna Prabhu (5):
>   mm/gup: add struct gup_out output descriptor
>   mm/gup: make the slow path walkers record into struct gup_out
>   mm/gup: make the GUP-fast walkers record into struct gup_out
>   mm/gup: return pinned memory as folio ranges
>   iov_iter: extract bvecs of user-backed iters from folio ranges
> 
>  include/linux/mm.h       |  37 +++
>  include/linux/mm_types.h |  23 ++
>  lib/iov_iter.c           | 100 ++++++
>  mm/gup.c                 | 695 +++++++++++++++++++++++++++++++--------
>  4 files changed, 717 insertions(+), 138 deletions(-)
> 



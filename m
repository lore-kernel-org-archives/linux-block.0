Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sgaapc01on2077.outbound.protection.outlook.com [40.107.215.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07CA417C7CF;
	Thu, 30 May 2024 10:56:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.215.77
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717066568; cv=fail; b=Cs+FG2hhYHYS6tfe/+pZSzHc5nlhMmEiy9mOSz1e5j5P4/i+k2UlAoQsHEg5A+YLnfC/DzCq9j0pLgUaDXu/cURGjyfn8Kf+qk/cGu2lPvMmxuIQetivNFqe9wRtUdiBT1An8FDrEdmMWhpjdmJy2gNJHoVy3eGuC7ZT0W1KxDs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717066568; c=relaxed/simple;
	bh=X1T2cOLDk5gi75mIJzLPIUyjkrA8EPhZUmtq6SxvAF8=;
	h=Message-ID:Date:Subject:To:References:Cc:From:In-Reply-To:
	 Content-Type:MIME-Version; b=R+dHt5iC6BkRmuFdb/SbreKLVpyeVuXsOSSoYAJ9rrVClzqzFQiUv5EO1AWyH3TVhbX1VK3myUxnRiivO0wNtcKxT+5Eqpuw+9T9BBgW31oHSyaNKijOtt5pIqg5z0NNfJvoiYrFdLxFN0mkOFvQxg01Q2SMySdClyg3SiW+o+0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=p+cbcKrI; arc=fail smtp.client-ip=40.107.215.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="p+cbcKrI"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XdOMzSDAENcVohxLnlLWpR7oa8rdNwVIf2ZyNuyyqJf3KAZ4J1C1dmh6F34VLS636OeAXUlI+NMzR8vboKsbXIL+CnPhoWIGy5O1+XLI1aQmgKxvJPjUyZpKzRTbuhMcarIo6GleMoP1TpSqZFu4PmrSabbUBV5wHmXHegZ9MKj72t8LM2uqtr7wblYjeUbm8nnmFDZi3ySAECk/K28BHpQYzLzm1Y3/JnqnB1SoKElcWkBB3ibHZryDK953A94YxFz4Xq8qhZJqgYZEukJVmi5f2t9+U6gvSM1Xa0AMQXRSn6T0zeoBwYNg05On1HzbWufW+MAvp04C90cFA6NPZg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GvRxXXZaLGfFISdq2D/dkRRTnXa7JqQ//gJ+dToazRY=;
 b=gjhEPgh2KI9994CaO/trcW+fZ8wqUBHJ4IOQ/A8Gq28Tf6e8y5wV0c8ZnvFEYCd2D9tfAkHOTvfi2/bXIrxz+ovoD3qATpQZQrMsgM3PiiaIzXNbSRjccxzl5KSOO3Hj5rVErC/WBaQ+uOO1v2IFJ4wjtDpT6J4ZkqurJYRKNOtI/V+HkhCbmylhTVDRGIVKdDMZmJ4pOiisrUiOwFdyt8ZIy8TgFJKLKGzv9RjeDVUNLIkiH30xbISiYGnLAZEIVLQ3jDb54Lo63Zd5y+C1yqJAXyBrwgPbG2OaVnVLeeWQm8Gz0N6To2KoDbXXdprFcJSmKTOegtHlI90R1nqYQw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GvRxXXZaLGfFISdq2D/dkRRTnXa7JqQ//gJ+dToazRY=;
 b=p+cbcKrIgP+Xg6GXgdEYZBGgqag2S1iMx4qgw6CLvoBVx2viuFeABXTVS3kE5NdLS7JMQB6mD3jl92rssorPPeQb5Le0KmV7faWfwJgDWbvMn4Uysa8EIkKXBp3FWORK2eI5jPlO5xYDuaIkV9ZEev/7jJ0zQskWomlYC49NKZ2c2QuJS44nEOaTD8r8ZhB62nlRNSQjGk2hUuimaM4ees6weQ+a3x+TeSr8EwCaapAqduxXGiAljQ/Zyzd+lOro2EKdo2e65p1g7oVzWBsTzNtbTVsiva7HU5ns+gSdEBU2c2z5J0FdYOMnL0RTWIwlMGz6Ov+/7IRjD5xe3kn+4w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from KL1PR06MB7401.apcprd06.prod.outlook.com (2603:1096:820:146::12)
 by TY0PR06MB5683.apcprd06.prod.outlook.com (2603:1096:400:273::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.17; Thu, 30 May
 2024 10:55:59 +0000
Received: from KL1PR06MB7401.apcprd06.prod.outlook.com
 ([fe80::f4f:43c4:25e5:394e]) by KL1PR06MB7401.apcprd06.prod.outlook.com
 ([fe80::f4f:43c4:25e5:394e%4]) with mapi id 15.20.7611.030; Thu, 30 May 2024
 10:55:59 +0000
Message-ID: <aa873af0-9b14-4926-833f-2e4005d988c2@vivo.com>
Date: Thu, 30 May 2024 18:55:53 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH] sbitmap: fix io hung due to race on
 sbitmap_word::cleared
Content-Language: en-US
To: Yu Kuai <yukuai1@huaweicloud.com>, "yukuai (C)" <yukuai3@huawei.com>
References: <20240527042654.2404-1-yang.yang@vivo.com>
 <bd176002-90e8-030d-f8d8-9388d3b40241@huaweicloud.com>
Cc: Jens Axboe <axboe@kernel.dk>, Andrew Morton <akpm@linux-foundation.org>,
 Pavel Begunkov <asml.silence@gmail.com>, linux-kernel@vger.kernel.org,
 linux-block@vger.kernel.org
From: YangYang <yang.yang@vivo.com>
In-Reply-To: <bd176002-90e8-030d-f8d8-9388d3b40241@huaweicloud.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: TYAPR01CA0131.jpnprd01.prod.outlook.com
 (2603:1096:404:2d::23) To KL1PR06MB7401.apcprd06.prod.outlook.com
 (2603:1096:820:146::12)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: KL1PR06MB7401:EE_|TY0PR06MB5683:EE_
X-MS-Office365-Filtering-Correlation-Id: 99b5b1ee-1cd8-4db5-f797-08dc80971694
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|376005|1800799015|366007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?SVA2RVBVVEU2QjU1ZUFuRFdseDBzYzZmbkF0Z3NCaG04OHN2MHJsbTYrbjQ2?=
 =?utf-8?B?UGpIdFVGRDNKTnplNHUyNGtBdEVXRTZFODcvVW5VQnRhOVBBZXFWVUcvWmFY?=
 =?utf-8?B?ZXpSMFpzRk9CL1d6N0VHU1h3ems0VGowdG5rTW9JTHZSK004ZTJBdGZtRTlF?=
 =?utf-8?B?V0s3VTNueDhqamdLTG9xSXV0aU43elNtLzczYm5mUnJsUGRCR1NLQnBzMVFM?=
 =?utf-8?B?T1ZyVCtRQkpwSkZIWHgwV1gxTnhiQ25YRWR5SDBQOGxrWm9MTStHM0dMa3Nv?=
 =?utf-8?B?OXdDUnhQS3NGSHNablVDWHpJVENiU3ZIc2VBYndtZWxIdXJicDFXYk9rMDlY?=
 =?utf-8?B?RmpyaDNCT3lDNFZtdEgra2N3TER3UmxrVWJTaVJGc1NBQ3FFa2o5c1dGcXB4?=
 =?utf-8?B?R3NQaVRNcnZTd1p6OTZvK2grUFdzV1RtVHBwTUFOaWNnd1Ftd3Z6TWdSdmww?=
 =?utf-8?B?MHlvUTd3WUE0dk5hUFlHLzQ0cmNpMkQ3aXlxTHJYNTRjTHJvNkpqTjhKVXZo?=
 =?utf-8?B?eU1RMTFZRWJiNlZDOVJRQmZHQ3Rqc0JKYU9pNnlJcnd3VC81Uk85ZGFMM2t1?=
 =?utf-8?B?ZWcvdEZEZVVOYk5Lbm1BOGc1R0NuTUszQ0F4UmJOc2wxRmhnMTZET3IvaUg3?=
 =?utf-8?B?MXRtV3FNWWpzeEYxT2ttdkhTdDFKVE03Ri9LbXJyVDJkcDRIZUhmZzBsYlM1?=
 =?utf-8?B?ZmE4Z0NROGJhOUNqcmIxUWFSYjR4bXp6bDlaRGFhc1VNYWlxUmpFQ0I3Vk1O?=
 =?utf-8?B?bjlQWVJ6TzhUNEJsUy9NQjB2VDNvSDIyL1VOWXVGdktPSUtUMGoxdU1RWEpJ?=
 =?utf-8?B?TnEzd1BoK2kzY01rTzladVYyS0NTZkVHYnNGOGs2YStFL3VxaWxwUmpUMHUw?=
 =?utf-8?B?MEtPOXFVWGRRUUYrcW9tNWluMkVFVk9pM3BUdEJNd21FVldRcGN2UU5YOG5X?=
 =?utf-8?B?UG12M2lpQ3N1b04rejk0TnF5aFRxV1V0M3NRaUppY1ZnVHp1YXN0cS9WcW5R?=
 =?utf-8?B?Ny9aZm4zcktQanRyTG9TVWJ3Y2x3ZkxsUjA5U2liV2FjeTJ4RlovdTdqbkI2?=
 =?utf-8?B?M2NpRjRsSTJsVG5uZnFyMm9ld1V4cUVSUnFPOFZHaEoxWE5RV0tGTmtsTFZZ?=
 =?utf-8?B?ZDMyVjZDWkZqTml1QVJwd2VvY0VwYTFvVTZndXZubVNFd0dTN0ZlalZFbGE0?=
 =?utf-8?B?Qkx0NFlJZXdVWHNQRGNJeFBiQU54NWk3cktvVXhHb2FGQWVJVlE5RFlnZnRM?=
 =?utf-8?B?RzljUU1reHFtQnprVFZ4QktNRU9WNFB3VkNCUVh4a2lOaDdSUnMzZ2VkdzdC?=
 =?utf-8?B?QjZzcWkxZ2ZnNGJueTZ1Q2ZiUllTZUg5OVY4NDFyNVdibW1VWVpiTDYyZHZv?=
 =?utf-8?B?VW1VQnhCMHB0UmtCS1F5dkRJS2NYS3U2Q3JCZmVSVWdQbDJuMUdzVUpWVnBP?=
 =?utf-8?B?T25FVS9kRWFGSEl3bllrekZzY3paVTE4RmtaYW9SNFlnaVlrMnJ4YVpJSFpC?=
 =?utf-8?B?ZzhjY3ZGMSt3QUIvWkVBdmhQYmpkQjZjNEN5QncwN2gyMjMzSkJiNCtkS2cy?=
 =?utf-8?B?UVhZQ0tmTlh1amxDVytGK3RZVlB4QUJsVnhqVmp5RkVzSkdnbGVsR2NIQ2Er?=
 =?utf-8?B?RWlERWZPVGllVlFyS3hTRWRGNHcrcE9xMnUwdDdjSWhYTjB1VGlHdStMMnNy?=
 =?utf-8?B?cmlLTmZvTjAvMDJJb2pORFFKVm5tVUJOdS8vZWI4dUJlQTVEMktKZE9RPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:KL1PR06MB7401.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(1800799015)(366007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?WHhyM1VNVmc5ZFJIL0JEczZIZEVBa2M5VmEvMFhqc2FvVjJDVWY0Rnh0L2pW?=
 =?utf-8?B?Rnl5TTVhNk1mc3ZTOEJnVjF5Z2MyM0pyTEZUMjVwazhzditZUUZNZHRBRkZk?=
 =?utf-8?B?TllHZzUxeGt6N1RiT0trMFRITmlrak5sZWphS21XM2dDc1NwU1hMUHlXUjE2?=
 =?utf-8?B?Rno0UFNkNHV0aHVZNjNGOTVYekVXdWVEY3NHNHo1dFNub3dxZEtlYXZLVTBQ?=
 =?utf-8?B?SGRKQXBRQ2Q1RDJhYkJ4Z29mMjFwb01tNUZuUG01ck9mRk9qVTFCN0JjOFgx?=
 =?utf-8?B?RFJ2UkJtTVpSazRRZUowb0lFNEo4QmpYbGlLenQ1ZXl4Y0prU3k1WURwYkFz?=
 =?utf-8?B?NWJyTnVWMjR3NkR3ODZJcE9LM2czSUVuSGZya3AyeHowdFYzbXB6UnJQdjQ2?=
 =?utf-8?B?ZU9malBVYTVQaUkwM2pTTFE1L0orQm0yS2tmTXQyeEpndlVnWmNBWmo1a3Rn?=
 =?utf-8?B?RlJpRWhXVlNubGYwQ1FmVGFtZEdsSUJyYVVBU0hyL2VzRlJyUjhOL1c5Ykg0?=
 =?utf-8?B?bU9UTmtwdkk4S2EvdDJUMUlkZXpnOW90dXBtL2JRQUxyVWUvSHcySFFUdzNB?=
 =?utf-8?B?WjdDeEUvVmhOSEtDTmpBK1VQRkJ6cWE4S3RVYnRiMnlmeHI0S1VVWDVqbnRq?=
 =?utf-8?B?aVhhMS9Pb1RTSklQS2hHWWVsMWh5R2JidWZsc24xSHZaNThway93UC9jeXU2?=
 =?utf-8?B?bjNBM0RJdkN2R1Zyc1Vha2NVQ0I2SG05cWR5ZlptSHp0aVdYYWFwSHI5b3gz?=
 =?utf-8?B?VEV0dnlOVkloWlZaMU9KK0xiQmxFclV0bGU3K1Zic3lzaUlHRzFXdTNMODRn?=
 =?utf-8?B?YmFaRUZib2kxV3NpaFNDclFCck56ak5iU2hreXJjTFVocUVOZk1UdHcydXBG?=
 =?utf-8?B?bk1qbnFjTWpYcUg0YTZtUlN3ellYaTNkcE5tZytrdjBEUTJMY1E2VDdIKzJr?=
 =?utf-8?B?WlJweDcvOE5aaWNJOENFWWZlZzhvVjAwS2lSM2FFYmhFWjVKYU9wL29BVHky?=
 =?utf-8?B?QlJZd0FaVU8vWUZpMWFTVmZTSm9EWnY2bCs2MmRWRzlKUzZRZTlhRnNieXp4?=
 =?utf-8?B?d241dTc2ZjhOczdlNlJqZ3FRV25UUDNEYXcrVkJIQXhyQjZvU0ozTkN1V09N?=
 =?utf-8?B?MUNRYmtFelFFSXhrc2wwb1JhRW9CeEJQeEZwclBpa1A0REFpUEg2bjBBSS9Z?=
 =?utf-8?B?bEkvcHcvd0dLbnhHUnFnaENUS0IvaHJhdlVHdjkvU2pjTVJZT2pJbXIzTDRK?=
 =?utf-8?B?eWV0c2FjZTc2aHJsZ3l4UVRDQXExdkJxOVhwWWxrY09yMmtSRUloeDhVbkZk?=
 =?utf-8?B?Qm56NWUwK0pRa3BZeEUycmdDQVRrYXlRdHZNclJjS0FBRXFlTUxSbENEZ1Fa?=
 =?utf-8?B?cHdPcWZhWDFaa2RHcmpRQ25yeS9jL2UreVpueVNUQkp3YnpPemk4aGRKbWFU?=
 =?utf-8?B?K0h4Rlk1dVp1ZkFCS2JVOHprMnU3N3Z1OWYyUXcrOFJxYzI2RjJ1RjdGVlZw?=
 =?utf-8?B?N3dZZlI0L2g0ekdFSTBVZGVjYUdHZkhMQjI3Y2dGelVlYnE4SzVXZklxSm92?=
 =?utf-8?B?SjdsL3d3VlhDRmpsUkRETGZRcG9UdnkxU0Q3OVovUk1yUm5qY3FoNEJIQ0lw?=
 =?utf-8?B?VVFxOThvcDBnVjBjRm1qcDFTcXFqS3dPYWJXZmtSV1k3MXBjaXRVUnZOMjUz?=
 =?utf-8?B?d3JXN05UazIzVGtKME9BVjlNaXhDeFNtcG84MUZtdjBIRVY0TDVxZm4rRm1S?=
 =?utf-8?B?K0xGQzRTQkJkaVlITzVJeTI5QUY0NU80MmpEK0NjQ1RjVnN1aEZUdnlMVERr?=
 =?utf-8?B?dk4zbkptL0lsU3FiSUZMNVd0THZWSG9CVU0rRHp2b1V2RjE3c09ObHBVb2Z0?=
 =?utf-8?B?OXphM3N4OHhMalYyYmhRNlRnb0RiVGJLSEN0emJPL3FtU1B2dWZvNmo0WWho?=
 =?utf-8?B?aThYOGJBcTE3VGZxRUg1MGk4NVVsMUR1UkpzdlE4djNRcXdtbENQSGhGZVdn?=
 =?utf-8?B?dURVY0lZQ3BWSHduRmxsQzhTaUdGNkNMZUk2OXQyM2w3NFVTb01zNHBIWFlx?=
 =?utf-8?B?RnY4ZDFJL3BrZUZTc29qTmFyaGZJenlqR25udkd5dlR0WnBZVVovMkYxcDdi?=
 =?utf-8?Q?Lna2++ucXFM9k2iJyw/QA4q+i?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 99b5b1ee-1cd8-4db5-f797-08dc80971694
X-MS-Exchange-CrossTenant-AuthSource: KL1PR06MB7401.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 May 2024 10:55:58.8763
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6901evMV84dRrfUccib8mouqtYTxOthiSmI/ZYZnlrHHr1+o6oUvgf7gS1bzgC3jt4l6zzbdcgtB3jWd0kNGHg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY0PR06MB5683

On 2024/5/30 9:49, Yu Kuai wrote:
> Hi,
> 
> 在 2024/05/27 12:26, Yang Yang 写道:
>> Configuration for sbq:
>>    depth=64, wake_batch=6, shift=6, map_nr=1
>>
>> 1. There are 64 requests in progress:
>>    map->word = 0xFFFFFFFFFFFFFFFF
>> 2. After all the 64 requests complete, and no more requests come:
>>    map->word = 0xFFFFFFFFFFFFFFFF, map->cleared = 0xFFFFFFFFFFFFFFFF
>> 3. Now two tasks try to allocate requests:
>>    T1:                                       T2:
>>    __blk_mq_get_tag                          .
>>    __sbitmap_queue_get                       .
>>    sbitmap_get                               .
>>    sbitmap_find_bit                          .
>>    sbitmap_find_bit_in_word                  .
>>    __sbitmap_get_word  -> nr=-1              __blk_mq_get_tag
>>    sbitmap_deferred_clear                    __sbitmap_queue_get
>>    /* map->cleared=0xFFFFFFFFFFFFFFFF */     sbitmap_find_bit
>>      if (!READ_ONCE(map->cleared))           sbitmap_find_bit_in_word
>>        return false;                         __sbitmap_get_word -> nr=-1
>>      mask = xchg(&map->cleared, 0)           sbitmap_deferred_clear
>>      atomic_long_andnot()                    /* map->cleared=0 */
>>                                                if (!(map->cleared))
>>                                                  return false;
>>                                       /*
>>                                        * map->cleared is cleared by T1
>>                                        * T2 fail to acquire the tag
>>                                        */
> 
> This looks correct.
> 
>>
>> 4. T2 is the sole tag waiter. When T1 puts the tag, T2 cannot be woken
>> up due to the wake_batch being set at 6. If no more requests come, T1
>> will wait here indefinitely.
>>
>> Fix this issue by adding a new flag swap_inprogress to indicate whether
>> the swap is ongoing.
>>
>> Fixes: 661d4f55a794 ("sbitmap: remove swap_lock")
>> Signed-off-by: Yang Yang <yang.yang@vivo.com>
>> ---
>>   include/linux/sbitmap.h |  5 +++++
>>   lib/sbitmap.c           | 22 ++++++++++++++++++++--
>>   2 files changed, 25 insertions(+), 2 deletions(-)
>>
>> diff --git a/include/linux/sbitmap.h b/include/linux/sbitmap.h
>> index d662cf136021..b88a9e4997ab 100644
>> --- a/include/linux/sbitmap.h
>> +++ b/include/linux/sbitmap.h
>> @@ -36,6 +36,11 @@ struct sbitmap_word {
>>        * @cleared: word holding cleared bits
>>        */
>>       unsigned long cleared ____cacheline_aligned_in_smp;
>> +
>> +    /**
>> +     * @swap_inprogress: set to 1 when swapping word <-> cleared
>> +     */
>> +    atomic_t swap_inprogress;
>>   } ____cacheline_aligned_in_smp;
>>   /**
>> diff --git a/lib/sbitmap.c b/lib/sbitmap.c
>> index 1e453f825c05..d4bb258fe8b0 100644
>> --- a/lib/sbitmap.c
>> +++ b/lib/sbitmap.c
>> @@ -62,10 +62,19 @@ static inline void update_alloc_hint_after_get(struct sbitmap *sb,
>>    */
>>   static inline bool sbitmap_deferred_clear(struct sbitmap_word *map)
>>   {
>> -    unsigned long mask;
>> +    unsigned long mask, flags;
>> +    int zero = 0;
>> -    if (!READ_ONCE(map->cleared))
>> +    if (!READ_ONCE(map->cleared)) {
>> +        if (atomic_read(&map->swap_inprogress))
>> +            goto out_wait;
>>           return false;
>> +    }
>> +
>> +    if (!atomic_try_cmpxchg(&map->swap_inprogress, &zero, 1))
>> +        goto out_wait;
>> +
>> +    local_irq_save(flags);
>>       /*
>>        * First get a stable cleared mask, setting the old mask to 0.
>> @@ -77,6 +86,15 @@ static inline bool sbitmap_deferred_clear(struct sbitmap_word *map)
>>        */
>>       atomic_long_andnot(mask, (atomic_long_t *)&map->word);
>>       BUILD_BUG_ON(sizeof(atomic_long_t) != sizeof(map->word));
>> +
>> +    atomic_set(&map->swap_inprogress, 0);
>> +    smp_mb__after_atomic();
>> +    local_irq_restore(flags);
>> +    return true;
>> +
>> +out_wait:
>> +    while (atomic_read(&map->swap_inprogress))
>> +        ;
> 
> However, I really don't like this change.
> 
> How about following patch? I think it can fix the prblem as well.

The following patch cannot fix the problem.

Thanks.

> 
> diff --git a/lib/sbitmap.c b/lib/sbitmap.c
> index 1e453f825c05..d1b9bd61d296 100644
> --- a/lib/sbitmap.c
> +++ b/lib/sbitmap.c
> @@ -175,12 +175,14 @@ static int sbitmap_find_bit_in_word(struct sbitmap_word *map,
>          int nr;
> 
>          do {
> +               bool clear = READ_ONCE(map->cleared) != 0;
> +
>                  nr = __sbitmap_get_word(&map->word, depth,
>                                          alloc_hint, wrap);
> -               if (nr != -1)
> -                       break;
> -               if (!sbitmap_deferred_clear(map))
> +               if (nr != -1 || !clear)
>                          break;
> +
> +               sbitmap_deferred_clear(map);
>          } while (1);
> 
>          return nr;
> 
> Thanks,
> Kuai
>>       return true;
>>   }
>>
> 


Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01on2082.outbound.protection.outlook.com [40.107.255.82])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E718817B4F8;
	Wed, 29 May 2024 10:31:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.255.82
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716978677; cv=fail; b=czHopN0QT6Qls706WnmY0/KT+Sx+3d8gLMh5Tn0BANj2+AvkSDY/JlTinIeb/jkWzO+6nmFigBKeeb7GwujWxMxo8xJ7lcPTzG14WYYl+QR8thY5iw/YEHaq8i6Snh/AZSRZrtLA1QUg2/2manXX5DSNaB0NspopV5NXVtzkPTc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716978677; c=relaxed/simple;
	bh=H60oVrCkJKmSq07ZB/A9Dvnywx6QKSkdhRhshEo0JiQ=;
	h=Message-ID:Date:From:Subject:To:Cc:References:In-Reply-To:
	 Content-Type:MIME-Version; b=TrvjGC3PXdQjPJ1G6eeawRWooEozVmQO1+i0eje5DQGSmefgj09C+/IkzgCC3FU/gvkmpxHzI3m6v7VhX0H/FUz6vzgDzci1GWzx6A3uKOioEhmhWTBtbRPFCAR0Wva9tzswkL8MaZUX8xBCKls3qRpo3lBcYVcpN2viY2GDIRc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=eisjOdm9; arc=fail smtp.client-ip=40.107.255.82
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="eisjOdm9"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YyXegPD2wGKuW4iSRG2P9DJP3exHzk0lVq1gm6sBzXlSGt2bhCGckXgLDVy5AjzDno6y6LX7EEENdWOAXMSVbZ89R/ExGY6lNG6WdcJrnTNy/IqXldOhWBlPn/bs6yZ2JwyTrEUOh4aRvu/Zi+9vUKR+WcILOgyqokxLwVuQIYe98CpQ6bS9Ej3xzBwjFjUrYRKThh1bSkNcW+LgdHiBRcGeOKZMtH1bGjI/msI5W3izkebkvXQW431DbbBa+L4a9Yiak4WxvofbDXietqJhhBUghXy3zCBgSxgk9MxNKxK+8fPKylmsTTKVt8qer1Pn8NLlCfCDLRaLSxRki3R7hA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=l2eRLldZWxjXX5WbWTWCbZMpaP1Hir3XojT12wyonnc=;
 b=IHc21XSm5Z4m0fnmxKSYIIbavtqK/UHccbKZ3Y5h9kKI+BCgMYKrFvs8icbFdcL9FL4yg2mvNSrRWAq0Ntv4ok/jwfNnUcTMo+Mm4cDFD6T7AWz//NMt+imACDDaGUktn1xtK46StMCIO357waNWpbOc1IOTZ0cRVCNl7LfatDy8M8wsGtRLE2NvEQYpJlm7pEA/EH/t5yJxiI7tszLZWWNB3E8vpJgNmsMBuSNKt4t5w0ULLPGx17IZ0ULJv7R1QcffaomST00HTdOgSpF7iAehQdgTPGIT63+TaKl5nCvbtfekCBSRaPfGJznxbhblw/rT/c8pN1PzEvipy/Y02w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=l2eRLldZWxjXX5WbWTWCbZMpaP1Hir3XojT12wyonnc=;
 b=eisjOdm9/IsFjbv9qZBn1mUwxg064OloDon6O8J+3Q8iq+29lhcnS9jg2cg2Hx6puwO4EXWfXJbYzfb4xiSdNuVx3T+6TVyEWalT6XPgbTh2lvjSueNNdOOZsRKcGF91HpsTs8vL9gfk7++7G5gVhaRyqVL2fXCPpusvgHSU3mSJ8s2SUus095f4SFe3uxuMi/b0foJEjFQXnlU8qQvfJAy6dAroJJPRWNk4AA6c/dX0yIviNedA9GKODdj9Tws28jTSVbBjR/0pNF8RVWiwXSnx2MMJaJrf9juKfKoReb8fUimDRBVVABYRBoSUpxmlTV6fg50YJhBWwdK/On+/uQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from KL1PR06MB7401.apcprd06.prod.outlook.com (2603:1096:820:146::12)
 by TYSPR06MB6541.apcprd06.prod.outlook.com (2603:1096:400:47d::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7611.32; Wed, 29 May
 2024 10:31:12 +0000
Received: from KL1PR06MB7401.apcprd06.prod.outlook.com
 ([fe80::f4f:43c4:25e5:394e]) by KL1PR06MB7401.apcprd06.prod.outlook.com
 ([fe80::f4f:43c4:25e5:394e%4]) with mapi id 15.20.7611.030; Wed, 29 May 2024
 10:31:12 +0000
Message-ID: <da901f5c-c14e-4e1c-b3c0-d3dead195ca1@vivo.com>
Date: Wed, 29 May 2024 18:31:09 +0800
User-Agent: Mozilla Thunderbird
From: YangYang <yang.yang@vivo.com>
Subject: Re: [RFC PATCH] sbitmap: fix io hung due to race on
 sbitmap_word::cleared
To: Jens Axboe <axboe@kernel.dk>, Andrew Morton <akpm@linux-foundation.org>,
 Pavel Begunkov <asml.silence@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux-block@vger.kernel.org
References: <20240527042654.2404-1-yang.yang@vivo.com>
Content-Language: en-US
In-Reply-To: <20240527042654.2404-1-yang.yang@vivo.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI2PR02CA0026.apcprd02.prod.outlook.com
 (2603:1096:4:195::19) To KL1PR06MB7401.apcprd06.prod.outlook.com
 (2603:1096:820:146::12)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: KL1PR06MB7401:EE_|TYSPR06MB6541:EE_
X-MS-Office365-Filtering-Correlation-Id: 243af9ef-fcf9-45f4-be8c-08dc7fca7610
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|1800799015|376005|366007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?TTdPWWEwRXZwMkhDcHJPeC9uSU4xUDRHbnorbU4zdiszdjRZenY2Q3d3SlNK?=
 =?utf-8?B?aGFITkJXMEtEMlByY1VSeG4yYnMwSmh2WUMvRXRZS1pWTDcvZXJ2a2dxWURh?=
 =?utf-8?B?NVhHN1VnR0tSY0VLczBDZDJobHRGLzVnb3JDME9YVnVBdFVpcUdDWUxyWXcz?=
 =?utf-8?B?andVcFVHNVdBc3B0S1dNNW5TVnUrcUV4ZzBybHo3WHozd2ZwVENPSHBTdG9o?=
 =?utf-8?B?QkJJclZtNVExcWpja3llemt3Q3FNdUhXYzlyQWQ0M1R6Nmd2Z1VtcVgvRHMx?=
 =?utf-8?B?Z0lXV01rYlpyTDREOVN4d0tKdU8vWTZSeGNqUi9GSEgwR3R6SzhJRmxhZVZ0?=
 =?utf-8?B?UjdNbnJMVEk4VGxJblQ5TmdIeGU4Sm5jZjlGNFUrcnJZNVJxQW13MzFBV1NR?=
 =?utf-8?B?aWgzeE84NDhBcFNvUDRTcGRVbWRVdWVpK2Z1N3dEVTJFTC9pc1RMb0V3K1Ba?=
 =?utf-8?B?TUdLa3lnN3dPK1QrdXlZWVgvZk5WWjMvMmdPTCtSR0hhTnMvUmU1QXhCNCt4?=
 =?utf-8?B?aitsSGZBWlU2WDZKeXFCNm9GQy9uaGZVWCtiZHdjTHV0bmtlVWRjdTUrTVBB?=
 =?utf-8?B?OFZxWG04R3NBQTNnejgxaURDYXJtVFR1UlZDcEt4bk1RS2ZQa1FpWHlpWVZR?=
 =?utf-8?B?eiszWEphRFNuMkxIZFpYbGpBQVNjVDZUZHdhZktjZ2RRRm1IQ1RoZFV4Ukh0?=
 =?utf-8?B?QkY3bHBXTTU2RE8xbG50dHFsaFFkSlR5VU5ZMy8wNWFVakpBM0psbmdhMXJE?=
 =?utf-8?B?VTRBYUtRZnBSWlhNa3hiTWdRRHpWdmhsWTNFVnV6K0JIc1FBSWZFSFhpZjlZ?=
 =?utf-8?B?ODZEWTQ0VlA2Mkg0d1dmSVpMT1RQSVdTN0tuWjdtbWhEc0ZZYnFGcmYySlNI?=
 =?utf-8?B?Rm9OcHUrMWdBQjFoTXdxZ1l4L2pqeU5ONndzYWI2cmxvUGpOc0E4WVFOWFNq?=
 =?utf-8?B?dmhHWlV5SnAzWjNXUTl2eUJYNFdjRWVoSlJmb2tLeTRVRHo4SW1FY1E3SUpW?=
 =?utf-8?B?RThDa2RyQThsdGlQMVZRK0RxQ2xkYTljT0EwcFRDelZoWXpzZkgzclRjT3JM?=
 =?utf-8?B?R0lGUCs3TFRJQ25UQW1xTDNZRy9GWnVORXcycFJxamZFRHFtYXp5RzF5cGph?=
 =?utf-8?B?SjNZZEh5R2Z5UDdiZ1o2S0FxUlE2RmlDaHAvSHRScmtiSFk5UzNxbE13ZVFT?=
 =?utf-8?B?N001aW04R3V6NHpaNlRyZDlhSzZXVitCZXAzZTF6czVST3FWSW12a2VQUlFZ?=
 =?utf-8?B?UTdqc1ZjSzVyNXE0NlVINERweFJnNTNOd0UwMzlyU1dYRDNOTTZQTzdqOUd2?=
 =?utf-8?B?WEJGR29QYjlvY2k1Q0dodHczaE9tQUl0aUFkSUt3c2ZZOHFMdEUwOTZacHVZ?=
 =?utf-8?B?NjhPU0k1U25vUEFqdEdNNVRWcjBXUHBFbGVYM0NmNXVJbG9kdmRONnlpU1lB?=
 =?utf-8?B?SldZRzZMdDJHYUwyRDR2RXRXbDFkWU1zQ0RhbC9hQmJrWkpDcWpkNlVrN2J2?=
 =?utf-8?B?UUs4Q2lVQkVDSjJndkF3K083OTI4MGpobE5PTWc0ZTRyQjd1TWg5c1BWRFZU?=
 =?utf-8?B?eHVTNmxqQXZ0dVR0dHpOWGJxYW9kTkdabGQzYXpUamtNZVM4dTl3L0wvN1g5?=
 =?utf-8?B?b25WakppdHhSUWhSa0VyeEM3bm5oakhneFdPZk9qYlp1cngyMHZ3b1NFYmxt?=
 =?utf-8?B?SjU0cjZwbmhMS0lYOTBQazlFbXMyRnRUdjZ4Z1lvMGpPSCtOT3o3Z1RRPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:KL1PR06MB7401.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(376005)(366007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?NkRwSVA3dVZlUCt3S1FLV05KY2xWSHk0YVZmTGRyU1ozNU5zdXlXUWpoT2ZC?=
 =?utf-8?B?KzFiSG1sblhRNjRNcFRCSjJSWTBkNUpCVnhKd001MzY2WlR0V3VHWTlKZFpx?=
 =?utf-8?B?UHNUeU10Y1J2aTNVcVpKbUNmazlIak5wTzFDOEVFdkhJYU1hOThISTl1VjEr?=
 =?utf-8?B?OTRneHFnU1lmdjYxY3UyZkdPeGN3YkJWZ2RpaVVTeENRa3QyNjdxQnJEd1I2?=
 =?utf-8?B?N013OFczY0NId3JoNGowMmh2dFZnandBNmJERDJmenZ5a25pTzdwOTdKbjRX?=
 =?utf-8?B?WC9FeVlLbldOTWJ6YzMwVnBINVVMODgxZ012ZjJQVmRnaVFkbGF1Vm9rbnZN?=
 =?utf-8?B?clhzVW5DSFgyNVZSeStpTzNzU081Q1RGMDgvc0tVK0p2ZkFGcXAvdERIUEMx?=
 =?utf-8?B?Qy9qcmxqbFBBRHljSzBFUEZDcGFQSkNHV3FUUW5sZHkvZ1kwOFBja0RkTkcx?=
 =?utf-8?B?V3R5b0ppMGRDZURZczZvVE1vS3g4dW5LblgydnZydVhBOVdhMkd5QlF1Umk5?=
 =?utf-8?B?VTVUaytpQ2xrdEVDWE4xUGdTNlgxU3BqTUdyTTNnZkh3SVBJTFdIb1c0MzF0?=
 =?utf-8?B?OTh6am0xcVB5MlozS1UvTWpWWXNxMlFicmh6NGs2NzV4aE1tQUQya1gvbXJi?=
 =?utf-8?B?UnVzUHZlc014Q29sTXh1OE0yMkxST2NrMll6YUtrbGk2Qks4ajF5K0lUSFd1?=
 =?utf-8?B?cWw3a3MvYk9jRmhTb2xVNHQxTEQvaGhQc0dHWGVhb3h1MkZ6OUlHWjR5MC85?=
 =?utf-8?B?ODE5WlJxZmtYcG1raDBPUDRYdE9lOGIrMW0wQWErMXhKS0xIQ2RLZUR0MlB1?=
 =?utf-8?B?RDJXWXdEOGhvbEcyNG5qdGZLS0pkVnhQdURUaEFPNjJrWElQTmZFNUJEa2E1?=
 =?utf-8?B?ZzZkbWZCT0s4dCtGQ2VCQ01DYzZ1NW9WNlB2OEhnTWtUUWVMaktERDNzdTJi?=
 =?utf-8?B?MjMxdk8rRzVKZHFmakVsRUZOSVEwY2dhdVJieTIzT3J6Q3NaejBzdS9wK3ps?=
 =?utf-8?B?WDBkdUpNMXJ6TTh3elc3Z1ovbTlaL2hiZWx1RTZSUjczQndIQXpxbjVvTW5l?=
 =?utf-8?B?bEVxcWF6NHhDSWVpMkhuMXBiVjV3SnJqd3IzY2FYYnA4emR4ZWRZS0xtNDZZ?=
 =?utf-8?B?d092emkwOHNPNk9GR2RwSyt5N1RwSEc3OFVsR1dsODFEU29hNUZEVmh6VTZa?=
 =?utf-8?B?eTFvWVQ0RzF0TzZ6bzJBa0FsLzE3TUxNdXJpSlUyWHFjVjJlZ050aVJ0aGxG?=
 =?utf-8?B?UVBxSzJBNDcyKzVlbzVtWWFKUFJDSlRKWEMvNFIzYkhSTktHTHEyQnptbWpZ?=
 =?utf-8?B?OGR1MDk2Qm1wWHo5K1lZT2NIT0o3c0RqeENoQWlFamJvN1RKcnZTZkRFa3E2?=
 =?utf-8?B?Y01nTDFvdEdKRXpUdVc0M2ZGUXQ2QzNEQWNiMGN6cDZOUXdvb2RWeDdlMTMw?=
 =?utf-8?B?aHQ4SlVLdWlTY2JnR3J5OHFQVW00VGtUS3ptcFhUWUVuTTBRekszd0h6M2hy?=
 =?utf-8?B?a3d4VnpsQVh6ZDYweDlqcTBrcXJrN2kyZFNiOElpVmxKWUh3U2wrWlBtVXQr?=
 =?utf-8?B?aVBteTM1UjBNc0psU1JybGZBclVrQmNYYk11Q1N1K1phSW9vS0JTL3lXVXg1?=
 =?utf-8?B?K1NrNzdIK1JpWUZ5SExJUlZJZHpnUjlnQjhqdTBqOEZwUmwySUhIc2FZQjNU?=
 =?utf-8?B?aGd2L0pvaUhhZDRvNzlORjE4UXJjekJsKzQ3SjZya0ZhVTlVTWhVTkxOSzU3?=
 =?utf-8?B?RTR2OVZOTlVoL1Urb3FnSjZ2WW5DTjlpUHNQTHQ4VGc3NFc5a2lQRHZKL3V1?=
 =?utf-8?B?amlnVTFaSVR1T2R2YktybFdKR0k2anExRDJLdERWTUVnUEoralNXTzdnZHl2?=
 =?utf-8?B?VDNIaWNzYi94cGxSR3IrUW5nZ01rbHVuQnZaSWk5dVQ4TFFndENEUGlKMEJV?=
 =?utf-8?B?U2RURFNuUHJNQXpTYkcxNFp3NGMwYVJoSU9XUXl4dmlKUUlPR0h1TUZGbVNx?=
 =?utf-8?B?ZGZwMmlwanZnWmNqUFF4dTFyNlZyMDF1TnNYTmZ1OCtZZEw5L0tIK2NrVjNN?=
 =?utf-8?B?UnNLSS9WVUt3R0VSK21LYWN6M0l6MzJQRGQrc3MwU25tbTcrak5EQlgrYW1p?=
 =?utf-8?Q?lrNrDK3b0fnGVM6G7ExbPDl/9?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 243af9ef-fcf9-45f4-be8c-08dc7fca7610
X-MS-Exchange-CrossTenant-AuthSource: KL1PR06MB7401.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 May 2024 10:31:12.1823
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kkZiyU+c2KPifPKdbGfrIvwMrjKZAbSh6nWC5zDektAWhsmNo/pf+3ZzM7SclJeZK9DETjEguM0sCKrUGuUSgA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYSPR06MB6541

On 2024/5/27 12:26, Yang Yang wrote:
> Configuration for sbq:
>    depth=64, wake_batch=6, shift=6, map_nr=1
> 
> 1. There are 64 requests in progress:
>    map->word = 0xFFFFFFFFFFFFFFFF
> 2. After all the 64 requests complete, and no more requests come:
>    map->word = 0xFFFFFFFFFFFFFFFF, map->cleared = 0xFFFFFFFFFFFFFFFF
> 3. Now two tasks try to allocate requests:
>    T1:                                       T2:
>    __blk_mq_get_tag                          .
>    __sbitmap_queue_get                       .
>    sbitmap_get                               .
>    sbitmap_find_bit                          .
>    sbitmap_find_bit_in_word                  .
>    __sbitmap_get_word  -> nr=-1              __blk_mq_get_tag
>    sbitmap_deferred_clear                    __sbitmap_queue_get
>    /* map->cleared=0xFFFFFFFFFFFFFFFF */     sbitmap_find_bit
>      if (!READ_ONCE(map->cleared))           sbitmap_find_bit_in_word
>        return false;                         __sbitmap_get_word -> nr=-1
>      mask = xchg(&map->cleared, 0)           sbitmap_deferred_clear
>      atomic_long_andnot()                    /* map->cleared=0 */
>                                                if (!(map->cleared))
>                                                  return false;
>                                       /*
>                                        * map->cleared is cleared by T1
>                                        * T2 fail to acquire the tag
>                                        */
> 
> 4. T2 is the sole tag waiter. When T1 puts the tag, T2 cannot be woken
> up due to the wake_batch being set at 6. If no more requests come, T1
> will wait here indefinitely.

Right at this moment, if a new task attempts to switch the elevator, these
tasks may hang forever.

   T2:                      T3:                          T4:
   blk_mq_submit_bio        .                            .
   __blk_mq_alloc_requests  .                            .
   blk_mq_get_tag           .                            .
   io_schedule              .                            .
                            elevator_switch              .
                            blk_mq_freeze_queue          .
                            blk_freeze_queue_start       .
                            q->mq_freeze_depth=1         .
                            blk_mq_freeze_queue_wait     .
                                                         blk_mq_submit_bio
                                                         __bio_queue_enter
                                                         wait_event(!q->mq_freeze_depth)

> 
> Fix this issue by adding a new flag swap_inprogress to indicate whether
> the swap is ongoing.
> 
> Fixes: 661d4f55a794 ("sbitmap: remove swap_lock")
> Signed-off-by: Yang Yang <yang.yang@vivo.com>
> ---
>   include/linux/sbitmap.h |  5 +++++
>   lib/sbitmap.c           | 22 ++++++++++++++++++++--
>   2 files changed, 25 insertions(+), 2 deletions(-)
> 
> diff --git a/include/linux/sbitmap.h b/include/linux/sbitmap.h
> index d662cf136021..b88a9e4997ab 100644
> --- a/include/linux/sbitmap.h
> +++ b/include/linux/sbitmap.h
> @@ -36,6 +36,11 @@ struct sbitmap_word {
>   	 * @cleared: word holding cleared bits
>   	 */
>   	unsigned long cleared ____cacheline_aligned_in_smp;
> +
> +	/**
> +	 * @swap_inprogress: set to 1 when swapping word <-> cleared
> +	 */
> +	atomic_t swap_inprogress;
>   } ____cacheline_aligned_in_smp;
>   
>   /**
> diff --git a/lib/sbitmap.c b/lib/sbitmap.c
> index 1e453f825c05..d4bb258fe8b0 100644
> --- a/lib/sbitmap.c
> +++ b/lib/sbitmap.c
> @@ -62,10 +62,19 @@ static inline void update_alloc_hint_after_get(struct sbitmap *sb,
>    */
>   static inline bool sbitmap_deferred_clear(struct sbitmap_word *map)
>   {
> -	unsigned long mask;
> +	unsigned long mask, flags;
> +	int zero = 0;
>   
> -	if (!READ_ONCE(map->cleared))
> +	if (!READ_ONCE(map->cleared)) {
> +		if (atomic_read(&map->swap_inprogress))
> +			goto out_wait;
>   		return false;
> +	}
> +
> +	if (!atomic_try_cmpxchg(&map->swap_inprogress, &zero, 1))
> +		goto out_wait;
> +
> +	local_irq_save(flags);
>   
>   	/*
>   	 * First get a stable cleared mask, setting the old mask to 0.
> @@ -77,6 +86,15 @@ static inline bool sbitmap_deferred_clear(struct sbitmap_word *map)
>   	 */
>   	atomic_long_andnot(mask, (atomic_long_t *)&map->word);
>   	BUILD_BUG_ON(sizeof(atomic_long_t) != sizeof(map->word));
> +
> +	atomic_set(&map->swap_inprogress, 0);
> +	smp_mb__after_atomic();
> +	local_irq_restore(flags);
> +	return true;
> +
> +out_wait:
> +	while (atomic_read(&map->swap_inprogress))
> +		;
>   	return true;
>   }
>   


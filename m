Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sgaapc01on2056.outbound.protection.outlook.com [40.107.215.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1ACC233CA
	for <linux-block@vger.kernel.org>; Tue,  8 Oct 2024 04:02:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.215.56
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728360151; cv=fail; b=HE2Cjg+a9/ZFXV6jeMevygNWLQTf/eykLOnNXYPBGjDtgi/kPsb9aqgQwnMUczYbpkpdiOzI85dWRc8Skj4Bx+VvbVmivpzg+qxcqwqqpIcUS2JhkruiHBPRZT8K8H4gbcG0JZwTc4dSQrlqNEBYZYfIB6ksnCQzLLCWCdIYmWc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728360151; c=relaxed/simple;
	bh=5FjCSgpW++yoBRxAtAXD3YxIXAVv8N62CdyUyCdfZT4=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=TAzoW+i/1HOSxprHRCM5LhQR/HX3whudGhro9xDazycROQvLaFMXA433U78ItJEl5xqDWEKTWRX6X/OoxrhCjSL4TbYNDxzAQXdwzNYPbai/v41ROkh7mAsuKul9dshXr6DDVNDr4xab+iq+cvDTMCUWB0xE1O3SUfh0cmJypEo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=D4futbU2; arc=fail smtp.client-ip=40.107.215.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="D4futbU2"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gTYz0y3DYBW86+inTTo2hmiHZpNfpyneA9eo/S4Xvp5rlw3yYeIuMEbaMWb5pbMD6Nvwi5+yLs4rqmTO11gaM4/X2vWy5OvxsXg9G/EZmDoCoMf375eDR/oosSpy8CVyMwPJHPPjeE4atcB+yqh/ckU6R184Ep47Ao1VZjDKJdhGnfXy0+F3ITZzuSeFt3o0Uz0lyNb4tmmD1E4Yt62ZuTajcGFaNE93jgEU/8+98UIL9DKjlIkq8mzwJSAPVO2gGn+6XeDlD9Ck1gKCCrd4H6ITyo6bpdz36apuHbXVQ6vq/umhgH9LmmbhbBAx7lf+fHMyRnh0EmOECGds7dcNTw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JsKrnqMFd4jHzOMRwg7Cz1VTJE+l5qWp9YwxapXfCso=;
 b=hnYmkZ748IMNGGoi1VmNac2e7M7IBJ9RQlPp1P2lB1YvEWcadNe8ypUSwPWIDp9KjlWrmJAbRojOq6sYzmvGStwNFJQOhFT68Oay7NJKTN7kTqz1soE+4Gc7WkhqVrnfV7wXUOVjQgLScouuoeLzzQdlzqI3MXcTL2ZaJmMEUGvx5vvoTWwZGcb7Ka+/Q5MstQcFeq5pk7AzPePS33CtIwWK0u4EZ2deMmuRvdFxnoNxJ/grTBKp4/PPdNpZOKUV8BgAYy3Jogt6b1ROfMM4ByPC3PtrrdHOl3jUq5VeVDxEmdAHcZEq6IdqqBBkmyGoCWZoEujZ+N7ZmWf77E1GyA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JsKrnqMFd4jHzOMRwg7Cz1VTJE+l5qWp9YwxapXfCso=;
 b=D4futbU2p+zfNeB66CMwRGGb4A3jfp5B+sh/mptqXE/SB8AagBEABQJw5z+3MnBLRT5H4Qf8n5h+C7c+XJTPOxFNnWisJi3464w+bMEldRON+J7CGacTnHwFSLTub2jphjmEwwvQ8Etpi625OMjnRLPwvx/VBAgEKmg/wmya2C8PPfKxHubYQPoQTpBZkIxKzGvvtfrgQ7aaJD/X389fUw/hRrKc07Bm8RfdwR1rvqPzFwZYUvDNrwtfqZlTQzrGq1iEE1sWEzPnTLK4IZaDNfN+vc+s1hDuhTr+/cs9wbibZIAqAAo5jvJec07a/30HR9hnyzRShxsp2mW1dj7rnA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from KL1PR06MB7401.apcprd06.prod.outlook.com (2603:1096:820:146::12)
 by TYSPR06MB6337.apcprd06.prod.outlook.com (2603:1096:400:42b::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.16; Tue, 8 Oct
 2024 04:02:23 +0000
Received: from KL1PR06MB7401.apcprd06.prod.outlook.com
 ([fe80::f4f:43c4:25e5:394e]) by KL1PR06MB7401.apcprd06.prod.outlook.com
 ([fe80::f4f:43c4:25e5:394e%5]) with mapi id 15.20.8048.013; Tue, 8 Oct 2024
 04:02:23 +0000
Message-ID: <b3690d1b-3c4f-4ec0-9d74-e09addc322ff@vivo.com>
Date: Tue, 8 Oct 2024 12:02:06 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: block: del_gendisk() vs blk_queue_enter() race condition
To: Sergey Senozhatsky <senozhatsky@chromium.org>
Cc: linux-block@vger.kernel.org, Jens Axboe <axboe@kernel.dk>
References: <20241003085610.GK11458@google.com>
Content-Language: en-US
From: YangYang <yang.yang@vivo.com>
In-Reply-To: <20241003085610.GK11458@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: TY2PR0101CA0024.apcprd01.prod.exchangelabs.com
 (2603:1096:404:92::36) To KL1PR06MB7401.apcprd06.prod.outlook.com
 (2603:1096:820:146::12)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: KL1PR06MB7401:EE_|TYSPR06MB6337:EE_
X-MS-Office365-Filtering-Correlation-Id: 17bddeff-123c-4e72-03fb-08dce74e0339
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?aDBaYUxQME9GaER3SXNwYVNUbkFoMDJESGwwUDd4eVNqNG1BZ2J4OTlpSmxz?=
 =?utf-8?B?SDZrV2NEQU8zY29lVk1Ic0FuUGhJQXMwUnJxR3hWUDVLb2t4d0d0UER2aStz?=
 =?utf-8?B?L2l6cW9jaFNWbFQwNEZDSE9rVGNYQ2g4NThCV2l1MGc1bDRnWTUrZldqbGUv?=
 =?utf-8?B?eGFKcE9hOXlCa1lzOCtha0dVTFN0dEwxdFpEM1dCdGo0RW9IVm1nZytIcEdD?=
 =?utf-8?B?QjFaTHZyaVFDNElWN2hsTlk3eWc2TG9nVkgxNnBYZ2oreXJramExWmhlZmRi?=
 =?utf-8?B?VkE5WHZkcDQ5Sm0yQ3lIOGZ5MWpGTFVwMUNEM09LV2FuY0FPSmwzNWo5MCtB?=
 =?utf-8?B?SWh2YlZNbWJVV0d4TTFPb0hidExzaVpyWWVyS0lDU3BWV1pQdm1xcHRxbEw5?=
 =?utf-8?B?WkVYVndKUnVPcTVJR29qeHhXYTQ3Rm1KTUpNSTdYL1ZJYnNRSlFuSWlzM0xr?=
 =?utf-8?B?anBCSUFNV0V4NU1MK3BUVGV5anB3RmFzQXFobko1cVloN3dQZGF0VUNidjNJ?=
 =?utf-8?B?U2F5MnNqeEZTNEcrR2xCQzVCMnNRZDdaZ3ExRkxYeXNUOFl5SzJsOGRaalhE?=
 =?utf-8?B?c2hQc3J0QW9VRGZSQ3dURTN4N0FGamR0c3FmK3BneURWQ1czeDJVeXgwQkNj?=
 =?utf-8?B?VGNzTnNGNGZhVUgwVG9vdnN3aTZZb01BaFJXQ2h4Z29kdDZMbm1IUm5jUzNK?=
 =?utf-8?B?RWhFRWNXK3kyenRlRXN6ajF3c3h4RW9FZVZkTFQ4bzRyZEM0T09oS3N0RnNT?=
 =?utf-8?B?VjF3dlJWYy84WmdYMkI0dXg3dE1aejQzbjIzV1E1Y3IzQjNwbmU1Ymxiaklv?=
 =?utf-8?B?Q0s3a24xU2pRaTRzODA0QStpMURZejhUcW5TVktTSlZsQUcxRkkzbmR4M2xj?=
 =?utf-8?B?ZFhPNXd6RmVEUk1RUW9CWEZHUDdsRXBEYTFoTFN6dzRodjJvM3pxYmNwa0d4?=
 =?utf-8?B?QVN2M09LYzNrdm5USWZhdDJEL0VxY3pkN1N5anZXWFdrbW1jdCtySy9uVUh5?=
 =?utf-8?B?QWo0K3hWNjR5L2NDQVlJdVhsOVdjWEs5THhZYXpTOTBhS1FlODBOL3FFZldx?=
 =?utf-8?B?UFFMN1kwOXdSSVJKODhiajBBNkRuT0crT0JuS2NFaGFBK04xMFdWK0RGMjVh?=
 =?utf-8?B?U3p2cHNBRmloWVRzVTFvcE10N28vTDRNNzJMOHhUNE9RQWx6enhxemdiUXBa?=
 =?utf-8?B?bnFHTmRtWGZZVmlHaHRVMGZLS240Umw3R002Y0Z6Slo5bkhPejJmN0Q1STk0?=
 =?utf-8?B?WHNlejBuMnFjUG1aWWV0M2NHZW0wSmMrQWNSY25oS01Bb3VkVmdEeTZzbmti?=
 =?utf-8?B?bjN0QjRlemc1OW9aK3laT3RUZkZDZ0lTVGRJYTdEQkR4dWR0WmtaK3FpaGpx?=
 =?utf-8?B?dnkrWnQySXliaGFGT3dTSWxsT0hCWkxkN1lFUyttWW53bFprK21YbjFkVStX?=
 =?utf-8?B?aDN2YlNIZEVPQ2MvUzNJenAzTEVBUUZxSmpWa3FHOXQ3QlE2a3QzZVJ1T3NP?=
 =?utf-8?B?N2FXUy95Sk8rb3BaSHNEc1RxaUZSeGJLSHFjU2dicXFwMXFKZHJ5SHcvUWZ5?=
 =?utf-8?B?Tkt2WU1wOU5kNXlJUHJwTldUTzY0aUg1WjlBaE1xdW1Dc0p6WWlsS0R6elVl?=
 =?utf-8?B?OCtkQlVsUXRFT0s2NklBVXMwdjlrbk13ODVNNGYrUkZ3TGl2SWJzekVHYURo?=
 =?utf-8?B?LzVnN3NpU2JkOVM1WVhkWk9yWUhNL3JLYUdETktzKzRJb1IwL0lqWjFnPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:KL1PR06MB7401.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?QlMvRWlJSmF6NUlSZGFhRm5UNUprM0NaWE5VLzFmOE5tazdiVm12VEwyeExn?=
 =?utf-8?B?VEVvVi8xcG5Pa2dxZUdHaGdPcEFrR1NqdFNnL2hwYXYrN1hjSGc2cnp0TXN6?=
 =?utf-8?B?YXpCc0VabVFXeUZpZGRRVWFhMkYwR2h1QUk0aXJoUmcyQ3htK0RHR0hkeXVm?=
 =?utf-8?B?aCt2WkRqMmFRU0tTQ3JpaTdTdGNUYk9wN1RYVkszMEliUTNoVnFlRklWOGUx?=
 =?utf-8?B?UzBFdEJOdWdmekwwNk45NTM0ZXE5bU1WZ29adlV1b1lpWlJtRkVXekttbEUv?=
 =?utf-8?B?VFljRGQ1ZmhRcmdpeEFtUWhMZUlvRWJSUnBKbU9LZEJmdHFuUjVNUkdWZkdm?=
 =?utf-8?B?Kzg0UzdGRndjdnJmMmlxbmMvTHc1S2ZxY05GcmIwRWR6M2RkZEU0T3RGMXRJ?=
 =?utf-8?B?amMvd3pUcGplZ1V2RDhuYWE5UzY3QzlnVzlVVlhiU1B1UVN5dGZWWVA1azB6?=
 =?utf-8?B?R0VGSWxNWG9scGZwaHdselYybGY0ck1ZSCtaaXBWR0NoMEJGWVFXQUdsY3dB?=
 =?utf-8?B?bnhrUnptWm1wU0s0RkdydHBSaFpYbmJTMFRkbWlQQ0o0aktFdUJ3N3A0SmhY?=
 =?utf-8?B?VXpzbEhBKzhHRU15SEp3Q0xOTjF2Z0hLcURuSDhPeDJOZWtBNldSM0ZzZVZq?=
 =?utf-8?B?NnFNZktPRU91L0x5QWZNSDRCSFBpZkl3SmdJT3ZEVzEvMXAwc0FpYjN4QnJG?=
 =?utf-8?B?R1dOZzVtMnFFM0lrNmdVWjQxL3YzLzdTRDE1ODdlbnJxYW95NlMzdlU2V3Fz?=
 =?utf-8?B?ZGttSEhLdHpPNURhUXF1bHhyZGJsRW9PcXhRd3kzWjJ1OTlVVmhWYkxhbC9a?=
 =?utf-8?B?N1NMMHhHY0plZFdRSUJGbldCbmg5KzRmL29nc0daVmlxN094ZHJKQnl2eTBL?=
 =?utf-8?B?ako5Ni8vUjNTemlMNHJUUHExcHhoWHpLWVdVT2N5VG5QeFE2TDRpVmJUN21X?=
 =?utf-8?B?U1RtTzc4V01rV2NPZDJheWVJNEVsYlZsSUVZcUpqNjV6SUdxUEZWN05xakIr?=
 =?utf-8?B?N3NLczhJbzNoNkhpeE5SUzV0b2NMVjBGL2JKU3FLS0VwTmhpSjgvYzY5MlNR?=
 =?utf-8?B?VXFlbFR6bTRjVU9BQkN2VFhRbjN4L3E2d0VMdUkycDNJWGdSM1NKKzhCRm1Q?=
 =?utf-8?B?Q2dNQUVLa25hTW9WdzRqNWNrMHJvNDNJWTR5blpOK2VLSGgwM1JFODZYU1ZO?=
 =?utf-8?B?NXpIbFVoeGVTbTJiSmlCN3JrNVZpNEhEZlIwVTZLU1JCWTlqa1pXaUpWQ2Jn?=
 =?utf-8?B?c3FIMExMMUlKa0VMNFdidDRyaWlzNEtCczA1REk5OExPMi9BQ1lDclRTQytj?=
 =?utf-8?B?aXNyV1IzOW5QU1Vtb08xcHRxVjZTWVo2MU5yVWxNbjZNc0tkVm5BeDBVRWFn?=
 =?utf-8?B?RmpsU0U5aXZvcWVMRUJ1RkxuN2l3cFM2MWplZ0Y3VThMNjhNa0dDa3pYcWlN?=
 =?utf-8?B?dFQza0ZnZDlodUZuaGJ1SWlkNnV5dDBHT1NYRjVObXdvUlVXOWhEWElvMkFu?=
 =?utf-8?B?UmJ6UnVyUjRqRTJtcERZNWV6ZUxacCthbDVTTHVRWUpTVnBqOG5Bak9rS2I3?=
 =?utf-8?B?bHBWUTRXR3VNWEg2aUh3dGZWcE1MT0hvYmVGSXg5T2gxTU53ZWNwTmJPbjhJ?=
 =?utf-8?B?NEtPSGVZWVFxa2xldldCTE50VTdXOTBndlh5a1RjNCtiRU9iS1RjaEhqMk1w?=
 =?utf-8?B?OEtxYVl1c1R2Kytmem0xLzFvQXdjOG5CSllwT1crWVZESDdjZ1loRFQ3YlJV?=
 =?utf-8?B?eDJiRUlQUnNQYlJoVlNvK1M5TXY0OG85UXRlcEo5VEtDSFBIY2FOTStaQzE0?=
 =?utf-8?B?eExQWEVIaEc0dVB3c01JdkQ0cmZxWjZ6ZWNiN3krd1hlQ3p6UCtUclBkMFlq?=
 =?utf-8?B?bjRXNWpOd3piTjB2ZDVMb25PTGpoMWpoK1ROV0xnV1Rjb21LakFoa1cwZXY3?=
 =?utf-8?B?RVdiakQ2NG5WWE0wZG1EbW1OSkgrOE95d09CSlgvSmp6V25mWEdVdEMwNFlP?=
 =?utf-8?B?bGNGbFFmVWdDeGkzRnlpbUdNVE8vd2VPTTZTaWsxMHJWNTNjcHdIaTZyWm55?=
 =?utf-8?B?YncxbDdrRDQxMXA3bitCRnRIMENWYnpjY25xbWI0dURMQjV0OS9ZZXBaSkF3?=
 =?utf-8?Q?qj0ubRNqUy0gjOWb36OF3o2Cz?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 17bddeff-123c-4e72-03fb-08dce74e0339
X-MS-Exchange-CrossTenant-AuthSource: KL1PR06MB7401.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Oct 2024 04:02:23.2908
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Wg2JhR/mNDP1Br77PX7T3RY5pOMVtg7aq5QMp8XjywEI7g79rvN8hNWDhCuJmeuSx3QQ27t4Nij77fMPx8qkyA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYSPR06MB6337

On 2024/10/3 16:56, Sergey Senozhatsky wrote:
> Hello,
> 
> I'm looking at a report from the fleet (don't have a reproducer)
> and wondering what you and block folks might think / suggest.
> 
> The problem is basically as follows
> 
> CPU0
> 
> do_syscall
>   sys_close
>    __fput
>     blkdev_release
>      blkdev_put              grabs ->open_mutex
>       sr_block_release
>        scsi_set_medium_removal
>         ioctl_internal_command
>          scsi_execute_cmd
>           scsi_alloc_request
>            blk_mq_alloc_request
>             blk_queue_enter
>              schedule
> 
> at the same time:
> 
> CPU1
> 
> usb_disconnect
>   usb_disable_device
>    device_del
>     usb_unbind_interface
>      usb_stor_disconnect
>       scsi_remove_host
>        scsi_forget_host
>         __scsi_remove_device
>          device_del
>           bus_remove_device
>            device_release_driver_internal
>             sr_remove
>              del_gendisk
>               mutex_lock     attempts to grab ->open_mutex
>                schedule
> 

I'm a little confused here. How is the queue getting frozen in this 
scenario? Normally, the queue should be frozen by 
__blk_mark_disk_dead()->blk_queue_start_drain()->blk_freeze_queue_start(), 
and this cannot occur without grabbing ->open_mutex.

  670     mutex_lock(&disk->open_mutex);
  671     __blk_mark_disk_dead(disk);
  672     xa_for_each_start(&disk->part_tbl, idx, part, 1)
  673         drop_partition(part);
  674     mutex_unlock(&disk->open_mutex);


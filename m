Received: from LO0P265CU003.outbound.protection.outlook.com (mail-uksouthazon11022115.outbound.protection.outlook.com [52.101.96.115])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 623C047F2CB;
	Wed, 23 Sep 2026 18:38:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.96.115
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790188699; cv=fail; b=r9SfJkbbsz8hDHnWkQSFy1zykpEeL+a3RauvgJCMrw6JzbpqMv1JU/CDna3zZVf8pw90aR6v5+UnIgJPn+f8Q99Ro0r8ET+ni9KhKvA+gwKiof/Y4Ike7Yc1juHo3mBe+fdL1JkBkWx72ZgunOnTY/aZcHJhAXO/j9HjTYqEMoY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790188699; c=relaxed/simple;
	bh=aZXnN5kcDMhQciC5cSFXrNlnb+y5I0Tcm8frtS0NoRY=;
	h=Content-Type:Date:Message-Id:Cc:Subject:From:To:References:
	 In-Reply-To:MIME-Version; b=s5Kt1lrQukK+WU6k37TPsVGSycTl8knKNAm/QyR62hHsNYqmBlvLW7m44Xs+Pvy7kvbVC3FRi6Vqq6Rq3pd0UrmHiOJwkCT6NRc+Js+kJzsYeYPoPKqzsd/bFwxbaP/qYTXIAQhowAg0T1dr9h6nM+HmXsZLrU/+QyfhKVMziUo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=garyguo.net; spf=pass smtp.mailfrom=garyguo.net; dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b=mUI+CeD4; arc=fail smtp.client-ip=52.101.96.115
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=garyguo.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=garyguo.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b="mUI+CeD4"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=v0GkvTEVdXE05PYjIRpgS9+m9ZcpgSTJQrMD8/uCnW5egVsVCwH5h+luRx3TC7IAJT17fWBRJtr1MvZcNtK+5L7Kar7zt8Kn4oTkHmFlvLXeKw5eP5Qxy7fXIFuItBF6JAL9g3q03vaWx5ajknPU9O5hgygjE5Sul6D6CU6NHi4vsEWXVT6Xcfzo7diXV6v3X6odlJiCkpaNVzFnEAFgi03az04UWoWFGKTvGNuPqbx8w3sbJ4wsSU4tzEnx2g2MpKKZcd/ELLrSwiuYIv3GovPb+kPdZJIviirRd/3fgGZVlqML4ZCPsF2bzUEcMJFpor/ZUv+VZmHVgv4hneLMRg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TWGvps0VVFjiCNR208VlXHIVNIRls3taWvnho+rDxc0=;
 b=fFb8YYV+zqUifF0v0rtpxVREk/nheK6A+v2ykakr3bAII7jlgkCqwBrkcx7d8pCAnjkYCfaF8pvSggL5IR3L0D84Cj+Lg6exoeClVmlJqYtS1imMnQalcYO/vHPqWyNhLkIloyHUwuXzcw5KYi5Yi5EpyRE28elYFfRLseEk3Lf4KpApEnWt3klqIHTrHIqu/KMNBmx/HRxI6fGIeXwwIuGhs1IBjgKXi8aNpRDckbjOVNQYsThF3sK0WqTlZJmgg1GjfLKIes8/qGRH6/db54X8tt1dB3QglXDk0pADilcFFc16tF+BvGa9Adup7X4snAtMk3UWGzwu7kKqPHXu3w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=garyguo.net; dmarc=pass action=none header.from=garyguo.net;
 dkim=pass header.d=garyguo.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garyguo.net;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TWGvps0VVFjiCNR208VlXHIVNIRls3taWvnho+rDxc0=;
 b=mUI+CeD4cl5wcCf3y/N2xBHn1wk5dq3D1yFk7EEUdmUsb10toXzdwFXq2oRTJL0FPnnuEkAnbtzYlslGoi9/3tjjkB7QUwZgxDo48C76lZY4C4eycTBq9rpm4uRcdG3uUHQ4hyK1VkAdOyqbz2c7iIs71jodMaRkcVN0X13aqc8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=garyguo.net;
Received: from LOAP265MB8560.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:4ab::19)
 by LO9P265MB7724.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:3b7::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.17; Wed, 23 Sep
 2026 18:38:10 +0000
Received: from LOAP265MB8560.GBRP265.PROD.OUTLOOK.COM
 ([fe80::f60b:1537:68d7:4fc1]) by LOAP265MB8560.GBRP265.PROD.OUTLOOK.COM
 ([fe80::f60b:1537:68d7:4fc1%6]) with mapi id 15.21.0451.014; Wed, 23 Sep 2026
 18:38:10 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 23 Sep 2026 19:38:09 +0100
Message-Id: <DLMWXEJS130L.2WSB0G2YD3LY7@garyguo.net>
Cc: "Al Viro" <viro@zeniv.linux.org.uk>, "Andrew Morton"
 <akpm@linux-foundation.org>, "Brian Foster" <bfoster@redhat.com>, "Damien
 Le Moal" <dlemoal@kernel.org>, "Hillf Danton" <hdanton@sina.com>, "Markus
 Elfring" <Markus.Elfring@web.de>, "Ming Lei" <tom.leiming@gmail.com>, "Qu
 Wenruo" <wqu@suse.com>, "Tao Cui" <cui.tao@linux.dev>, "kernel test robot"
 <lkp@intel.com>, <rust-for-linux@vger.kernel.org>, "Linus Torvalds"
 <torvalds@linux-foundation.org>, "Nilay Shroff" <nilay@linux.ibm.com>
Subject: Re: [PATCH v5 1/2] block: Add post_release() operation
From: "Gary Guo" <gary@garyguo.net>
To: "Tetsuo Handa" <penguin-kernel@I-love.SAKURA.ne.jp>, "Bart Van Assche"
 <bvanassche@acm.org>, "Jens Axboe" <axboe@kernel.dk>, "Christoph Hellwig"
 <hch@lst.de>, "Jan Kara" <jack@suse.cz>, "linux-block"
 <linux-block@vger.kernel.org>
X-Mailer: aerc 0.22.0
References: <69960302-1535-441a-be4e-d652766d65c2@I-love.SAKURA.ne.jp>
In-Reply-To: <69960302-1535-441a-be4e-d652766d65c2@I-love.SAKURA.ne.jp>
X-ClientProxiedBy: LO4P123CA0230.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:1a6::19) To LOAP265MB8560.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:4ab::19)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LOAP265MB8560:EE_|LO9P265MB7724:EE_
X-MS-Office365-Filtering-Correlation-Id: d34a1d08-5e33-4cb0-45e2-08df19a1d13f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|23010399003|10070799003|7416014|10067099003|56012099006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	9qIPFTiBCtFxMmgnawNFLbBPoPNXoh7X/izAITR3vMnxzOCKTGMQPGTceD2CtucpPdrhHn/Uwdoyr6FwjtVSFaliVue2ARvW2oO747u+aE4L5Gi3tbXoDKSzgmOrPNbPRcJhE8AiVh29b3Q/0lhjvVuu/Fva4WMI3PLu+yFYhDI6DKLUL8FqhRpVH/CKuXg7X5jOhlY9+Fqp+g6uIQzzrLrBIc4XTlpb+nYtlXvIJLzrOfOz/Y1O24SVn4M0VfKUvdNpGzdfiXkVtj9A7E3OlBpQp6dUXJVSrFffGeGhZgUC1CT7U9DC/fOX9PlDUJ2k26d93yD/1i3U9szyraRdgNnBIsR7GTEsBY40zFluUEaBY5XNgX4enHWzrtzzDgqz8Iy15YnM1y7/QfZ2k1P9bDo/G58Qsv5a3QmRVggiEILvX8GzleAahYr4ZqKZhkV7Q7pM6pZH7AkfNjPO8cZ+iWjeppCbeeu0OZqJl7qKd3vumzm4396iBe6wqaz4VKL1PI9wgHCA87rDVsN3TeDNMDHvRGzUdI+j0Mf7KUssWtUQvdvkPcsAtZZsroLH1S1QJ1hPfh4IflQglM///nKuKKwabPstMt8TAWs6C9hL1hyv9cx6RNfHwMJCSY0LBnzFwbM1gCNuuvi5ZemeMD0z8Ksso4yJaL/jzokzlEkMOtg=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LOAP265MB8560.GBRP265.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(23010399003)(10070799003)(7416014)(10067099003)(56012099006)(22082099003)(18002099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?S3RVb1FXTkFldE9hSTArRTZBK2puMC9wWEpLWU91TnNoazhPUlhHeW5hWXVX?=
 =?utf-8?B?QmRmUG1OdnRnajV3YXRtS3FtNUI2WDA5M0g5QnBuS3AvWHBDSXFkUjg4N1JF?=
 =?utf-8?B?bHpOa3BqM21EN2pVcGRGRVg5Sm53V2kvdzJTc0pmYmZFODNqRXc2ZWU1dkV3?=
 =?utf-8?B?bDFYNzNudzZTZnBadUJ6b2RHYUtSZ090dGFrVkpuQ3E3ZTd2SkhXMkVSRUpq?=
 =?utf-8?B?VE9lYnJqWVVZNWgxTWtUS1RvREFhVXF2VzdBSXQ5RlFXcTBRWG52U1pLYTY4?=
 =?utf-8?B?TnJCcHFOQTcyYnFkcmNKK2dvVXMvcmE2S3l3UlJSTHZBcUt4alN1TWJCampF?=
 =?utf-8?B?MFZBVG5QMjFWV2ZUWkNLUG81RzQxYlpaU3RmdHB2ZHlwRE50OHRrNVNFZmFw?=
 =?utf-8?B?eWtEMXc0bmRLZzkrWUVHdjNPRHlUd01Rc2FXZmF1R2EwTlZiQ0FGem5WSE0x?=
 =?utf-8?B?dHFnOUJZb0pLTWZMVUxCUTE0ZVdwcndDN3VjUUtJSjEwNTFwNk1ucC9nVkpa?=
 =?utf-8?B?TUU2c1A2bVFQbG1YYnNqcG1mL2pzSTRRdm41U3R4VFA4TDlWb290R3JVM1FB?=
 =?utf-8?B?UThBdUlUUTE4UEVWSjJJb1lpbThXUlE1RDRPVTNCN1JLMmMyTWtEejFYSEdT?=
 =?utf-8?B?dnhLY1R0QWVqUHRkaVJVcmMyamlxWHh0YXVlQkhXVThzK1drbTZiUGUrQ3Ns?=
 =?utf-8?B?bFpXaXFyOEVFaHNYSXFCZnVrejBUem5MUFk4dHI1SE1SdGVUZ21TdG15NEsv?=
 =?utf-8?B?cGVTNGFPQkhkVWNQYzlkbnRjdjJGd2xoYVVyb0pNck1ETVZyeUZaRHB5OUw3?=
 =?utf-8?B?QXhwOHdCanh5ajJUa1cwTlJYbzBFZ1FPQmxWWnZMblhQdlI2OTdVSFBMNFlD?=
 =?utf-8?B?bitZL0JPbURFMVNKcENqUEpCbzkzUDRTMk5RM3NsRXJyM0o3WWVaWC9tYWpm?=
 =?utf-8?B?cmRiVHFCVUVSeS9rQkdMR2FOeVlscFl6SFpXSDFZRk1RRldFM2w5S3VKdCtN?=
 =?utf-8?B?OXozeFQ0NkpJbHAwVlVqbERVZkx4WUVsRWNudmxUb0orNWsvdUhLZnNVUmh0?=
 =?utf-8?B?Z1Y1UU9oYnJObTJOV1BiS09BbkFuc1JVcjNSVVZtNnBuZ0lFRVpkaTNueDZI?=
 =?utf-8?B?UU9oZk85VlhQbkRGTWt6OFJhZ25mYlZWeHBwZi9GZSsxdit1OTM2ZHNuaVZs?=
 =?utf-8?B?enozN2Q2L00wcHVHQjhUTTFJUStDTGkyaTRYYUZWUWw0UU1YK29PU2VML2RQ?=
 =?utf-8?B?ZENUeGdja2N1SXlpSXFWejRkQ1RYZ2RhK05ZT1FqekJIekhFZjBSaFQ2eWVY?=
 =?utf-8?B?dUozMVFPb1JlMjExV0NUVjBId2h1RlN1NkJzSHQ0ZmNMOXBTcW9UZXNlWnUz?=
 =?utf-8?B?dTI4czZUVTdEMVV0MDBUWUt2YjFHYWo3czI5UU5oT2h2RmFmR01KWWt4d3pU?=
 =?utf-8?B?Y3FFQW44NjVoNTZ5ZnNFcEU5UlI1UEg1VUtVWWdqSXhzRkMrdlNTZzVMTGpz?=
 =?utf-8?B?emJzMGpzYzFoYXc1YUVWUCsvd0R0RmZFVTU4bDJwSkgyNEdoY015UmhnZnRx?=
 =?utf-8?B?MDFFSVIrQ2pNR041Ry9SOElVVjBMckVVSDVKUndLWVcvN3VsUU1Bc05XUkN4?=
 =?utf-8?B?WSt4Q3RZZ0t4OWpkQklSU1c2em5xalA5ZkE3QU13MFBUKzA3ZVNOWUtQNkY2?=
 =?utf-8?B?eHNCS1F6N2F6d1VkRHEyQUF0bkRxMU84SDNLWTdnM0o3OU53OVJpc1FqdElD?=
 =?utf-8?B?alBweHVVcXdIbHZJaVFmT3RCOFNSaDNBa01iZmFVTC9iOVpwa3UyUGREMUJo?=
 =?utf-8?B?ZUxSWEhtMiswdit4eXZZNFlIbnJJL2oxOWlodFhUR1pTLzBuYzJaY2hSS1hG?=
 =?utf-8?B?eVhXVGNaOWx2NFNIdmJRK0JIVWMva25DSFlJMDM5M2R5Q3c1alloOS9IV0xD?=
 =?utf-8?B?UlhjS3huaUdEQUNvN3NyYm5VVHJTLzF6SG1Ccm1UbUo0SkthT1JsRk9UcUg1?=
 =?utf-8?B?bHFta09YcHpySEhQTXRhN01TdFFmUm1LbFdVdld6V1VWQklFR1htRWxVTUIw?=
 =?utf-8?B?ZWhkR3lvcUwwYkMzSDlrTlRaQVdERlgxSnQ5Unk0cXlLZEt0RWlzRVBjVGoy?=
 =?utf-8?B?UFI0UWFlVG9TbHRYYnhlTUU5UjZzbURJWmR0NkQzZTY0KytQUTFraktVZ0k4?=
 =?utf-8?B?NWtIczNTTlVUcnNjU24xTDBwZWUzNUNVWS91QmVDNDBXMmdHUER6ZDYxS1J3?=
 =?utf-8?B?SFRwZURZWUVHZjZyRVpHRXd1bW1vQU9NN0k1U1M4bkFKbFpWeHRaeW9YaEdy?=
 =?utf-8?B?M0g4M25kdldJL0lFTFhWeHNZb3cvSG9QWWo4UjcvRE4zNGZxRHU2dz09?=
X-OriginatorOrg: garyguo.net
X-MS-Exchange-CrossTenant-Network-Message-Id: d34a1d08-5e33-4cb0-45e2-08df19a1d13f
X-MS-Exchange-CrossTenant-AuthSource: LOAP265MB8560.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Sep 2026 18:38:10.1558
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bbc898ad-b10f-4e10-8552-d9377b823d45
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0UQROPnLVefJmK4z6aGrR8S9YW1sRgvp2TpMOKmYQ13jVu6e5ARqxzxWws/N72zApYsL+fyWXX7PunaQv+WD0w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LO9P265MB7724

On Wed Sep 23, 2026 at 6:09 AM BST, Tetsuo Handa wrote:
> Add post_release() block device operation which provides a hook for
> performing synchronous cleanup without disk->open_mutex held, which is
> needed by the loop devices.
>
> Real-world container engines, test suites, and system utilities rely on
> fput() from __loop_clr_fd() being completed when lo_release() returns.
> But changes which went to the v7.1 merge window broke an assumption that
> there is no outstanding I/O when __loop_clr_fd() is called, causing NULL
> pointer dereference problem in lo_rw_aio().
>
> In order to fix this regression, we want to allow __loop_clr_fd() to flus=
h
> outstanding I/O. But calling drain_workqueue() from __loop_clr_fd() with
> disk->open_mutex held causes lockdep warnings. We need a mechanism which
> can flush outstanding I/O without disk->open_mutex held.
>
> But deferring __loop_clr_fd() to WQ context has a problem that there is n=
o
> way to wait for completion of __loop_clr_fd() before the calling thread
> returns to the userspace, for there is no hook for calling flush_work().
> Despite what LO_FLAGS_AUTOCLEAR can guarantee is to clear backing device
> "eventually" after the last thread called lo_release(), abovementioned
> programs are expecting "synchronously" when a thread who is going to call
> umount() or open() as soon as returning from close() called close().
> That is an unsatisfiable expectation because the former is an objective
> behavior and the latter is a subjective dependency. Nonetheless, we need
> to try to wait for completion of __loop_clr_fd() at best-effort basis.
>
> Also, since __loop_clr_fd() calls module_put(THIS_MODULE) and there is no
> API for waiting for completion of remote thread's task work context,
> deferring __loop_clr_fd() to task work context has a problem (aside from
> task_work_add() being not exported to loadable modules) that module unloa=
d
> operation can unmap code/data segment before __loop_clr_fd() completes.
>
> Therefore, allow the loop driver to safely know completion of
> __loop_clr_fd(), by adding a hook which is called after disk->open_mutex
> is released.
>
> Signed-off-by: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
> ---
> Changes in v5:
>   Since Bart Van Assche commented that post_release() is more clear
>   and more descriptive than run_todo(), renamed run_todo() back to
>   post_release(), and make it be called only if release() was called.
>
>  block/bdev.c                     | 28 +++++++++++++++++++---------
>  include/linux/blkdev.h           | 10 ++++++++++
>  rust/kernel/block/mq/gen_disk.rs |  1 +
>  3 files changed, 30 insertions(+), 9 deletions(-)
>
> diff --git a/rust/kernel/block/mq/gen_disk.rs b/rust/kernel/block/mq/gen_=
disk.rs
> index fc97dd873974..2ff77ef49781 100644
> --- a/rust/kernel/block/mq/gen_disk.rs
> +++ b/rust/kernel/block/mq/gen_disk.rs
> @@ -129,6 +129,7 @@ pub fn build<T: Operations>(
>              submit_bio: None,
>              open: None,
>              release: None,
> +            post_release: None,
>              ioctl: None,
>              compat_ioctl: None,
>              check_events: None,

Ideally we'd use

    ..pin_init::zeroed()

At the end of the struct expression to zero out all other fields instead of
manually zeroing each single field.

This is pre-existing issue though, so leaving as is is also fine.

Best,
Gary

Return-Path: <SRS0=2amJ=TA=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AFFF9C04AA8
	for <linux-block@archiver.kernel.org>; Tue, 30 Apr 2019 16:20:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7F87321743
	for <linux-block@archiver.kernel.org>; Tue, 30 Apr 2019 16:20:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="PGyU6Gmh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725942AbfD3QUh (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 30 Apr 2019 12:20:37 -0400
Received: from mail-it1-f196.google.com ([209.85.166.196]:35275 "EHLO
        mail-it1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726449AbfD3QUa (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 30 Apr 2019 12:20:30 -0400
Received: by mail-it1-f196.google.com with SMTP id l140so4428295itb.0
        for <linux-block@vger.kernel.org>; Tue, 30 Apr 2019 09:20:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=03ijMv3pe9wYEbXxfAK0xCr66KgdDf7vWbmZYlw+LGA=;
        b=PGyU6Gmho9l/ZEy0l80G3ZBJ9GXjRmIO54nH4zlUDdlQWbPvOPm+kkJ5pXgC1uPvcE
         DSGoqrba32u3DihKxfzsvcJ9X8U+U1pWzrMTMXKlKnEjl49pDOE75v9mDxPTBudyQYUF
         0Ia9XgYnSNupinYJvomlYvrCwIzMTShGJdZJmpDBnKssQm1s0+v30K46NP03JlDaQhsq
         JqvamY51I2GjnEUIKgJ1q5ZRITcuga/GOVtXwbePQQrceIOhr9Csx5XG43lT5ji7ES3u
         VVeGmovdkwnXOjfsBZqvcBkUnxtqF2+SyVguJ54T8CoV1CjiwWrokj0YJfsE0fsfdDVn
         Z2Fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=03ijMv3pe9wYEbXxfAK0xCr66KgdDf7vWbmZYlw+LGA=;
        b=quQb/7HOSA1Fk6fLgyTniD2nn+A0erjgRiffischx+Y/q8Vgu2GOCMXD/8eXEcImgA
         gEoGEo5VKq5FxEHMD8bC0vWOLjOsZbkOYdMnyMVRH795wqJe2LYiFsAdjhwFAdbwMCA+
         XTBHmUcibPwxiLvBOe80NqQyKXpQYV66AGwsh53c3bZeCiMnlBP3y6pftuMko5rIpm1i
         zpIYkUuT8GW1aOTq5TFCfLipNV2EoWnSnMPJRXEwaW/NsBtDqOXnlWrognCbTgRzba09
         7kFVKtMMAjdTV8pJjrNHYUX5rz7BmGiGW7w0KQjj6jAKUFEfwMQ7+0DcNri7FBldPcCL
         jsdg==
X-Gm-Message-State: APjAAAUNnOqqr3hGoTz5nLBQ/1c8hZhQrhUupjz08LSkCbRfYx+R6GUc
        H0aVlnLENGqo1dahrVzAkPNowA==
X-Google-Smtp-Source: APXvYqwUryhDnffsFIh3zZKpZsR5lr+x1JWy0gtNIlVE7+ofo3OlcHTgfSCFq1qKOOUrG4fjMTNL8A==
X-Received: by 2002:a24:5f90:: with SMTP id r138mr4298837itb.43.1556641229584;
        Tue, 30 Apr 2019 09:20:29 -0700 (PDT)
Received: from [192.168.1.158] ([216.160.245.98])
        by smtp.gmail.com with ESMTPSA id i203sm1676403iti.7.2019.04.30.09.20.27
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 30 Apr 2019 09:20:28 -0700 (PDT)
Subject: Re: [PATCH] io_uring: fix SQPOLL cpu validation
To:     Mark Rutland <mark.rutland@arm.com>, linux-kernel@vger.kernel.org
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org
References: <20190430123451.44227-1-mark.rutland@arm.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <4acfc374-1d4d-4698-51b9-6d12d30fb488@kernel.dk>
Date:   Tue, 30 Apr 2019 10:20:26 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190430123451.44227-1-mark.rutland@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 4/30/19 6:34 AM, Mark Rutland wrote:
> In io_sq_offload_start(), we call cpu_possible() on an unbounded cpu
> value from userspace. On v5.1-rc7 on arm64 with
> CONFIG_DEBUG_PER_CPU_MAPS, this results in a splat:
> 
>   WARNING: CPU: 1 PID: 27601 at include/linux/cpumask.h:121 cpu_max_bits_warn include/linux/cpumask.h:121 [inline]
> 
> There was an attempt to fix this in commit:
> 
>   917257daa0fea7a0 ("io_uring: only test SQPOLL cpu after we've verified it")
> 
> ... by adding a check after the cpu value had been limited to NR_CPU_IDS
> using array_index_nospec(). However, this left an unbound check at the
> start of the function, for which the warning still fires.
> 
> Let's fix this correctly by checking that the cpu value is bound by
> nr_cpu_ids before passing it to cpu_possible(). Note that only
> nr_cpu_ids of a cpumask are guaranteed to exist at runtime, and
> nr_cpu_ids can be significantly smaller than NR_CPUs. For example, an
> arm64 defconfig has NR_CPUS=256, while my test VM has 4 vCPUs.
> 
> Following the intent from the commit message for 917257daa0fea7a0, the
> check is moved under the SQ_AFF branch, which is the only branch where
> the cpu values is consumed. The check is performed before bounding the
> value with array_index_nospec() so that we don't silently accept bogus
> cpu values from userspace, where array_index_nospec() would force these
> values to 0.
> 
> I suspect we can remove the array_index_nospec() call entirely, but I've
> conservatively left that in place, updated to use nr_cpu_ids to match
> the prior check.
> 
> Tested on arm64 with the Syzkaller reproducer:
> 
>   https://syzkaller.appspot.com/bug?extid=cd714a07c6de2bc34293
>   https://syzkaller.appspot.com/x/repro.syz?x=15d8b397200000
> 
> Full splat from before this patch:
> 
> WARNING: CPU: 1 PID: 27601 at include/linux/cpumask.h:121 cpu_max_bits_warn include/linux/cpumask.h:121 [inline]
> WARNING: CPU: 1 PID: 27601 at include/linux/cpumask.h:121 cpumask_check include/linux/cpumask.h:128 [inline]
> WARNING: CPU: 1 PID: 27601 at include/linux/cpumask.h:121 cpumask_test_cpu include/linux/cpumask.h:344 [inline]
> WARNING: CPU: 1 PID: 27601 at include/linux/cpumask.h:121 io_sq_offload_start fs/io_uring.c:2244 [inline]
> WARNING: CPU: 1 PID: 27601 at include/linux/cpumask.h:121 io_uring_create fs/io_uring.c:2864 [inline]
> WARNING: CPU: 1 PID: 27601 at include/linux/cpumask.h:121 io_uring_setup+0x1108/0x15a0 fs/io_uring.c:2916
> Kernel panic - not syncing: panic_on_warn set ...
> CPU: 1 PID: 27601 Comm: syz-executor.0 Not tainted 5.1.0-rc7 #3
> Hardware name: linux,dummy-virt (DT)
> Call trace:
>  dump_backtrace+0x0/0x2f0 include/linux/compiler.h:193
>  show_stack+0x20/0x30 arch/arm64/kernel/traps.c:158
>  __dump_stack lib/dump_stack.c:77 [inline]
>  dump_stack+0x110/0x190 lib/dump_stack.c:113
>  panic+0x384/0x68c kernel/panic.c:214
>  __warn+0x2bc/0x2c0 kernel/panic.c:571
>  report_bug+0x228/0x2d8 lib/bug.c:186
>  bug_handler+0xa0/0x1a0 arch/arm64/kernel/traps.c:956
>  call_break_hook arch/arm64/kernel/debug-monitors.c:301 [inline]
>  brk_handler+0x1d4/0x388 arch/arm64/kernel/debug-monitors.c:316
>  do_debug_exception+0x1a0/0x468 arch/arm64/mm/fault.c:831
>  el1_dbg+0x18/0x8c
>  cpu_max_bits_warn include/linux/cpumask.h:121 [inline]
>  cpumask_check include/linux/cpumask.h:128 [inline]
>  cpumask_test_cpu include/linux/cpumask.h:344 [inline]
>  io_sq_offload_start fs/io_uring.c:2244 [inline]
>  io_uring_create fs/io_uring.c:2864 [inline]
>  io_uring_setup+0x1108/0x15a0 fs/io_uring.c:2916
>  __do_sys_io_uring_setup fs/io_uring.c:2929 [inline]
>  __se_sys_io_uring_setup fs/io_uring.c:2926 [inline]
>  __arm64_sys_io_uring_setup+0x50/0x70 fs/io_uring.c:2926
>  __invoke_syscall arch/arm64/kernel/syscall.c:35 [inline]
>  invoke_syscall arch/arm64/kernel/syscall.c:47 [inline]
>  el0_svc_common.constprop.0+0x148/0x2e0 arch/arm64/kernel/syscall.c:83
>  el0_svc_handler+0xdc/0x100 arch/arm64/kernel/syscall.c:129
>  el0_svc+0x8/0xc arch/arm64/kernel/entry.S:948
> SMP: stopping secondary CPUs
> Dumping ftrace buffer:
>    (ftrace buffer empty)
> Kernel Offset: disabled
> CPU features: 0x002,23000438
> Memory Limit: none
> Rebooting in 1 seconds..

Applied, thanks.

-- 
Jens Axboe


Received: from mail-io1-f54.google.com (mail-io1-f54.google.com [209.85.166.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 452D61C2325
	for <linux-block@vger.kernel.org>; Wed, 16 Oct 2024 13:23:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729085013; cv=none; b=DaBy53+89IfsaQ4mJD63OTPMoHokk1pDeip1/Xiu8WO0ASUadMPvpvvx3nwqZwxqcLuf8aBkbL0ugRG9ptLQMQsIbGAPf3z4t9GPFwwujJS4Om2gViC37M5CDuqDGEcRhAKG0Y41a4Vy47yitkGFA0fjRteBH1byZBlrLtn0lgk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729085013; c=relaxed/simple;
	bh=AW/MuenrFj0MlA0ePJHi4Tp0/yOK0JsHFpwLH7740Ik=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WUqfLENwfnLvl7+hjOorYMB3PR0R8GZQDgkF8eiZHPPoWGjF3p3BalbOSGfNCMEQoDIXRtmXgbK4CGzYKRAVcrsluaH2Prcpkof6SnL7v2PNK/Ub2ksIr7/pBgRMVYuqwEj3UM+5zbCyRoedyyBVC4cQXaWZoHW4R+RTXFZgBg8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=O+I/DTxR; arc=none smtp.client-ip=209.85.166.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="O+I/DTxR"
Received: by mail-io1-f54.google.com with SMTP id ca18e2360f4ac-8378db14280so342857739f.1
        for <linux-block@vger.kernel.org>; Wed, 16 Oct 2024 06:23:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1729085010; x=1729689810; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=RbtFkZml360qVZXYTPpWcgwaPRedkuV7ihCiYHUQr8Q=;
        b=O+I/DTxRHkTVhV3DAU1rOtrzZR+CqbaBuLd9b5T4ghp66RN7mADf7GygLMV/u1XF9F
         aMw1svokKF5IEn73Z8uZJUQLRM6IaHuiMf9pcYBgYULXIK24ON9qL6k2Aln22gsZv91c
         z3oAF7fdNXi/ZmY+4SKEZbl5uEdAtA+xB5WHyGayaxz7yylDv6u25rHNWjeGwhfwgYvn
         hycRb20+053uNDDyC0w97OQI7BvEWWPsOMwJHLqtOnP1c06SucJ0J9+TfTuOPMkdwPaS
         fQW4UM1ffFwVfyjpCyRzEERxJSWNJF0rPo5eAkAKPhGLDwXphikYTqzhY40B5dJj1uiX
         muZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729085010; x=1729689810;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=RbtFkZml360qVZXYTPpWcgwaPRedkuV7ihCiYHUQr8Q=;
        b=dnwCbgBcQ8fFpa2pBgkuvI5xJK/HVLpAgkVBK+8ui2t0rgYs3SNvawPqZzNklHkh/C
         7K9pDxDjGDXtepSeLGAFXXQxurVZK0UiA9csBeR7qPPxMUPVVGUs3Dvdn6PxPnU/6/Lj
         Qbey8XqdwNgpHFs0Mf+J/9s/JT5LnIvIEkwXqfZaSyi/Y0PqoyNUUsaFYK+CxCWltP/9
         omGqErs/IMy+q9qqykviVXyCfDtsN3I3AMmUzKHLyVTgvtV518lB/K2C3mihc2V1ZG0S
         htUoSMK3mxedBWRHFx8bEHWcz1nbkTmjk8ZpEje8/uSZV/1qrDPK33PK/c3iL4afLYkX
         mecQ==
X-Forwarded-Encrypted: i=1; AJvYcCVD/0oVvjnrYtvm2Oatu5KMsj8Jo1NeHwN1VbElrlC+4CczmOXoyPht8UPaKImVE5lckPO/c2FW49Akew==@vger.kernel.org
X-Gm-Message-State: AOJu0YwUvwE2da2bGUfBS23wu99poo3WHyfgkZaxEYml1o1qebsX9JQU
	Rzukw2BYtvYf/oBKuNUSK7OKKRduJjQHwe27J6bBudjgL350SFHFbCVNMwxBJJEKQG6nKC9kaF6
	x
X-Google-Smtp-Source: AGHT+IFt87NNyTBb/GzZvw9EwBXgg2u3ZpimpBvRJiMgQWTc3HkyiNsEESlD8H0oVsncL/2WIOgT3A==
X-Received: by 2002:a05:6602:158a:b0:837:7e21:1688 with SMTP id ca18e2360f4ac-83a946fb25dmr401729439f.11.1729085009716;
        Wed, 16 Oct 2024 06:23:29 -0700 (PDT)
Received: from [192.168.1.116] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id ca18e2360f4ac-83a8b2c3111sm73156839f.23.2024.10.16.06.23.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 16 Oct 2024 06:23:29 -0700 (PDT)
Message-ID: <c55bcb77-e39a-4591-ba4e-827770b4ba35@kernel.dk>
Date: Wed, 16 Oct 2024 07:23:28 -0600
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] blk-rq-qos: fix crash on rq_qos_wait vs.
 rq_qos_wake_function race
To: Omar Sandoval <osandov@osandov.com>, linux-block@vger.kernel.org
Cc: kernel-team@fb.com, Josef Bacik <josef@toxicpanda.com>,
 Tejun Heo <tj@kernel.org>
References: <d3bee2463a67b1ee597211823bf7ad3721c26e41.1729014591.git.osandov@fb.com>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <d3bee2463a67b1ee597211823bf7ad3721c26e41.1729014591.git.osandov@fb.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10/15/24 11:59 AM, Omar Sandoval wrote:
> From: Omar Sandoval <osandov@fb.com>
> 
> We're seeing crashes from rq_qos_wake_function that look like this:
> 
>   BUG: unable to handle page fault for address: ffffafe180a40084
>   #PF: supervisor write access in kernel mode
>   #PF: error_code(0x0002) - not-present page
>   PGD 100000067 P4D 100000067 PUD 10027c067 PMD 10115d067 PTE 0
>   Oops: Oops: 0002 [#1] PREEMPT SMP PTI
>   CPU: 17 UID: 0 PID: 0 Comm: swapper/17 Not tainted 6.12.0-rc3-00013-geca631b8fe80 #11
>   Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.16.0-0-gd239552ce722-prebuilt.qemu.org 04/01/2014
>   RIP: 0010:_raw_spin_lock_irqsave+0x1d/0x40
>   Code: 90 90 90 90 90 90 90 90 90 90 90 90 90 f3 0f 1e fa 0f 1f 44 00 00 41 54 9c 41 5c fa 65 ff 05 62 97 30 4c 31 c0 ba 01 00 00 00 <f0> 0f b1 17 75 0a 4c 89 e0 41 5c c3 cc cc cc cc 89 c6 e8 2c 0b 00
>   RSP: 0018:ffffafe180580ca0 EFLAGS: 00010046
>   RAX: 0000000000000000 RBX: ffffafe180a3f7a8 RCX: 0000000000000011
>   RDX: 0000000000000001 RSI: 0000000000000003 RDI: ffffafe180a40084
>   RBP: 0000000000000000 R08: 00000000001e7240 R09: 0000000000000011
>   R10: 0000000000000028 R11: 0000000000000888 R12: 0000000000000002
>   R13: ffffafe180a40084 R14: 0000000000000000 R15: 0000000000000003
>   FS:  0000000000000000(0000) GS:ffff9aaf1f280000(0000) knlGS:0000000000000000
>   CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>   CR2: ffffafe180a40084 CR3: 000000010e428002 CR4: 0000000000770ef0
>   DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
>   DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
>   PKRU: 55555554
>   Call Trace:
>    <IRQ>
>    try_to_wake_up+0x5a/0x6a0
>    rq_qos_wake_function+0x71/0x80
>    __wake_up_common+0x75/0xa0
>    __wake_up+0x36/0x60
>    scale_up.part.0+0x50/0x110
>    wb_timer_fn+0x227/0x450
>    ...
> 
> So rq_qos_wake_function() calls wake_up_process(data->task), which calls
> try_to_wake_up(), which faults in raw_spin_lock_irqsave(&p->pi_lock).
> 
> p comes from data->task, and data comes from the waitqueue entry, which
> is stored on the waiter's stack in rq_qos_wait(). Analyzing the core
> dump with drgn, I found that the waiter had already woken up and moved
> on to a completely unrelated code path, clobbering what was previously
> data->task. Meanwhile, the waker was passing the clobbered garbage in
> data->task to wake_up_process(), leading to the crash.
> 
> What's happening is that in between rq_qos_wake_function() deleting the
> waitqueue entry and calling wake_up_process(), rq_qos_wait() is finding
> that it already got a token and returning. The race looks like this:
> 
> rq_qos_wait()                           rq_qos_wake_function()
> ==============================================================
> prepare_to_wait_exclusive()
>                                         data->got_token = true;
>                                         list_del_init(&curr->entry);
> if (data.got_token)
>         break;
> finish_wait(&rqw->wait, &data.wq);
>   ^- returns immediately because
>      list_empty_careful(&wq_entry->entry)
>      is true
> ... return, go do something else ...
>                                         wake_up_process(data->task)
>                                           (NO LONGER VALID!)-^
> 
> Normally, finish_wait() is supposed to synchronize against the waker.
> But, as noted above, it is returning immediately because the waitqueue
> entry has already been removed from the waitqueue.
> 
> The bug is that rq_qos_wake_function() is accessing the waitqueue entry
> AFTER deleting it. Note that autoremove_wake_function() wakes the waiter
> and THEN deletes the waitqueue entry, which is the proper order.
> 
> Fix it by swapping the order. We also need to use
> list_del_init_careful() to match the list_empty_careful() in
> finish_wait().

Thanks Omar, nice debugging!

-- 
Jens Axboe


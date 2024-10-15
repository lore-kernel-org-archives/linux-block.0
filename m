Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A75D91B6CF7
	for <linux-block@vger.kernel.org>; Tue, 15 Oct 2024 19:40:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729021203; cv=none; b=OUOU+G3cq12oqgNKDt+LO+/dT2kETzZkgjjOYsmNfjSW6SbuaNcqHK3XLWgzd6MqYePaENJURwAb2ug/zdWOIUEaC2DcevwfZUrjJ2aFYsULD3Sy47+0rtYCvd/LpGdgEuVhV3btp80RWdQULB0W69uhHVEAwWg2B+vvAeYOmSU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729021203; c=relaxed/simple;
	bh=QMYwYqXMsc+r449a5eUDZ2mrEocrPxqYsLAcm+HSYDw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TohoxqFkqcoZCJf+k4t+6ik+NLr377M9E6ZiYOQ2V4f/p+d55+1vswrR+4z3+vIuvOthyj0h1aeZlhrR6eHpkaoe2olmvUpffjvLxQR0b2oPIGMGD6W9AusGFWBhzt6XxJcarJouwUlmCffnR2beIvPi8K0FtRTnZp98/NjHlmg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dQFa2kve; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dQFa2kve"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 236E3C4CEC6;
	Tue, 15 Oct 2024 19:40:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729021203;
	bh=QMYwYqXMsc+r449a5eUDZ2mrEocrPxqYsLAcm+HSYDw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=dQFa2kveQRHb1E8ODH8gaNOClmZAyH0fRnzY12YVrqArcI4HvreDlGY4bJ6Uua7Ce
	 oELf0MyZ31+BWYqTCKt+STVAs8E8BU8sz+uquAUeAU/Ou6FO/Z4O5xBQJlhsUW5UBZ
	 a/3S4ZkvRcFQ68+sesF1xPe2AjfuwTQ65/C/PlhP9RmVBiAM6XkegUtevm1vACF/nE
	 O1OfcECf1GEm8MpOXBs0sxQZoF6vFPPmEKUtOSDAxSbRnZbSPhlGkNyeakOImSYV2M
	 6dfx7TtIdO3gmI5MPh2CYAhosRrXZW2DxK1RPze5GPaE1XH321Ca1jTmf4UUS0rw36
	 SSVA9rSmHjkZA==
Date: Tue, 15 Oct 2024 09:40:02 -1000
From: Tejun Heo <tj@kernel.org>
To: Omar Sandoval <osandov@osandov.com>
Cc: linux-block@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
	kernel-team@fb.com, Josef Bacik <josef@toxicpanda.com>
Subject: Re: [PATCH] blk-rq-qos: fix crash on rq_qos_wait vs.
 rq_qos_wake_function race
Message-ID: <Zw7FElEtIs8TI2yM@slm.duckdns.org>
References: <d3bee2463a67b1ee597211823bf7ad3721c26e41.1729014591.git.osandov@fb.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d3bee2463a67b1ee597211823bf7ad3721c26e41.1729014591.git.osandov@fb.com>

On Tue, Oct 15, 2024 at 10:59:46AM -0700, Omar Sandoval wrote:
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
> 
> Fixes: 38cfb5a45ee0 ("blk-wbt: improve waking of tasks")
> Cc: stable@vger.kernel.org
> Signed-off-by: Omar Sandoval <osandov@fb.com>

Acked-by: Tejun Heo <tj@kernel.org>

Thanks for debugging this!

-- 
tejun

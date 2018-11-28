Return-Path: <SRS0=FxMo=OH=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8453C43441
	for <linux-block@archiver.kernel.org>; Wed, 28 Nov 2018 16:06:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8D443208E7
	for <linux-block@archiver.kernel.org>; Wed, 28 Nov 2018 16:06:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="lG4+wbJQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8D443208E7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728747AbeK2DIZ (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 28 Nov 2018 22:08:25 -0500
Received: from mail-it1-f196.google.com ([209.85.166.196]:37880 "EHLO
        mail-it1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728833AbeK2DIZ (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 28 Nov 2018 22:08:25 -0500
Received: by mail-it1-f196.google.com with SMTP id b5so4992865iti.2
        for <linux-block@vger.kernel.org>; Wed, 28 Nov 2018 08:06:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=LLBsbC2SSp6TA8yJpUt438nG8UOzJ+ePqa0cn4WEb9M=;
        b=lG4+wbJQH7bteRIqLMRJqBdlD4Mk0h52VyHhjP+KI/tWzmp0iDWnVrYNNOF9syv470
         6jnvT11/A+v2eJhBJASJ8GqBJLlrhRo4Qdz8mo0fnNeOBQOUInL2oWktTUq2BhYrV3BO
         l8fbVjpIGwIq86QxuTYzUFLDHmKzULQjNjGvtAIkCsxYg5euTdvZhGEDjIYoBm4nla/e
         vbjFgihrlBaVZKcdsLqsN1burEH92N4Dz0XSdHp/HKXPaQcsH+hiL36FrOFQcc5Lh619
         Xy31JhhvqLYkaXI+fwmugK2FPxlX6kAXazN/O4LHi7SSpIGcBAeB2HG6YlGjLzLjItKZ
         dQYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=LLBsbC2SSp6TA8yJpUt438nG8UOzJ+ePqa0cn4WEb9M=;
        b=kF2CpXg1/NpJwR60iFCh4gLe2L3qM2KX7/xuQNxoM67XYsBM69cwZcE/Vhd+uokk6j
         HTlXu3b5K148r98uIriX4l/bT+QwHlFt8FqPdH4zjvdBA+CpW/2aO5oNA45o1VvkwEiU
         QRgYwPZXEYW1pxbuX8947WF7NcriHma+VAD0ULWT+b9a9kgEd9/Okum7AGsDwnUjuqu8
         WehAzxWl6AzOCtu2DCDwXoO7XggTMGc5DTpdb8kXHb++Q9AAaE+ajyOlWhr9YULQMu+u
         K93x+d0/SowAMO199NP88Vj93RX5N3DFGxgZ1c0WNIresGbnRwK9twZrFq/LKv4ctWla
         AXUA==
X-Gm-Message-State: AA+aEWYClNkJ+Nr9rgFPd6pHdJFjWyvK0UXy69QmPegdjzCoixGZPTXL
        jb321/jZnEZqDa4nVfsf686Poiq6wuY=
X-Google-Smtp-Source: AFSGD/VPN4DMq7l38b99hohftgwM3fEkml1iLaS+Iu4tA+rE2X5YxLg6oZMU6RdtZ+mqcaFN+FJhVw==
X-Received: by 2002:a02:9c34:: with SMTP id q49mr7003708jak.101.1543421175355;
        Wed, 28 Nov 2018 08:06:15 -0800 (PST)
Received: from [192.168.1.56] ([216.160.245.98])
        by smtp.gmail.com with ESMTPSA id z10sm2739275ioh.20.2018.11.28.08.06.13
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 28 Nov 2018 08:06:14 -0800 (PST)
Subject: Re: [PATCH] block: use rcu_work instead of call_rcu to avoid sleep in
 softirq
To:     Yufen Yu <yuyufen@huawei.com>
Cc:     linux-block@vger.kernel.org, tj@kernel.org,
        paulmck@linux.vnet.ibm.com, ming.lei@redhat.com
References: <20181128084201.69211-1-yuyufen@huawei.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <e49ffe44-c341-dd9f-cb08-511186c83b03@kernel.dk>
Date:   Wed, 28 Nov 2018 09:06:13 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20181128084201.69211-1-yuyufen@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 11/28/18 1:42 AM, Yufen Yu wrote:
> We recently got a stack by syzkaller like this:
> 
> BUG: sleeping function called from invalid context at mm/slab.h:361
> in_atomic(): 1, irqs_disabled(): 0, pid: 6644, name: blkid
> INFO: lockdep is turned off.
> CPU: 1 PID: 6644 Comm: blkid Not tainted 4.4.163-514.55.6.9.x86_64+ #76
> Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.10.2-1ubuntu1 04/01/2014
>  0000000000000000 5ba6a6b879e50c00 ffff8801f6b07b10 ffffffff81cb2194
>  0000000041b58ab3 ffffffff833c7745 ffffffff81cb2080 5ba6a6b879e50c00
>  0000000000000000 0000000000000001 0000000000000004 0000000000000000
> Call Trace:
>  <IRQ>  [<ffffffff81cb2194>] __dump_stack lib/dump_stack.c:15 [inline]
>  <IRQ>  [<ffffffff81cb2194>] dump_stack+0x114/0x1a0 lib/dump_stack.c:51
>  [<ffffffff8129a981>] ___might_sleep+0x291/0x490 kernel/sched/core.c:7675
>  [<ffffffff8129ac33>] __might_sleep+0xb3/0x270 kernel/sched/core.c:7637
>  [<ffffffff81794c13>] slab_pre_alloc_hook mm/slab.h:361 [inline]
>  [<ffffffff81794c13>] slab_alloc_node mm/slub.c:2610 [inline]
>  [<ffffffff81794c13>] slab_alloc mm/slub.c:2692 [inline]
>  [<ffffffff81794c13>] kmem_cache_alloc_trace+0x2c3/0x5c0 mm/slub.c:2709
>  [<ffffffff81cbe9a7>] kmalloc include/linux/slab.h:479 [inline]
>  [<ffffffff81cbe9a7>] kzalloc include/linux/slab.h:623 [inline]
>  [<ffffffff81cbe9a7>] kobject_uevent_env+0x2c7/0x1150 lib/kobject_uevent.c:227
>  [<ffffffff81cbf84f>] kobject_uevent+0x1f/0x30 lib/kobject_uevent.c:374
>  [<ffffffff81cbb5b9>] kobject_cleanup lib/kobject.c:633 [inline]
>  [<ffffffff81cbb5b9>] kobject_release+0x229/0x440 lib/kobject.c:675
>  [<ffffffff81cbb0a2>] kref_sub include/linux/kref.h:73 [inline]
>  [<ffffffff81cbb0a2>] kref_put include/linux/kref.h:98 [inline]
>  [<ffffffff81cbb0a2>] kobject_put+0x72/0xd0 lib/kobject.c:692
>  [<ffffffff8216f095>] put_device+0x25/0x30 drivers/base/core.c:1237
>  [<ffffffff81c4cc34>] delete_partition_rcu_cb+0x1d4/0x2f0 block/partition-generic.c:232
>  [<ffffffff813c08bc>] __rcu_reclaim kernel/rcu/rcu.h:118 [inline]
>  [<ffffffff813c08bc>] rcu_do_batch kernel/rcu/tree.c:2705 [inline]
>  [<ffffffff813c08bc>] invoke_rcu_callbacks kernel/rcu/tree.c:2973 [inline]
>  [<ffffffff813c08bc>] __rcu_process_callbacks kernel/rcu/tree.c:2940 [inline]
>  [<ffffffff813c08bc>] rcu_process_callbacks+0x59c/0x1c70 kernel/rcu/tree.c:2957
>  [<ffffffff8120f509>] __do_softirq+0x299/0xe20 kernel/softirq.c:273
>  [<ffffffff81210496>] invoke_softirq kernel/softirq.c:350 [inline]
>  [<ffffffff81210496>] irq_exit+0x216/0x2c0 kernel/softirq.c:391
>  [<ffffffff82c2cd7b>] exiting_irq arch/x86/include/asm/apic.h:652 [inline]
>  [<ffffffff82c2cd7b>] smp_apic_timer_interrupt+0x8b/0xc0 arch/x86/kernel/apic/apic.c:926
>  [<ffffffff82c2bc25>] apic_timer_interrupt+0xa5/0xb0 arch/x86/entry/entry_64.S:746
>  <EOI>  [<ffffffff814cbf40>] ? audit_kill_trees+0x180/0x180
>  [<ffffffff8187d2f7>] fd_install+0x57/0x80 fs/file.c:626
>  [<ffffffff8180989e>] do_sys_open+0x45e/0x550 fs/open.c:1043
>  [<ffffffff818099c2>] SYSC_open fs/open.c:1055 [inline]
>  [<ffffffff818099c2>] SyS_open+0x32/0x40 fs/open.c:1050
>  [<ffffffff82c299e1>] entry_SYSCALL_64_fastpath+0x1e/0x9a
> 
> In softirq context, we call rcu callback function delete_partition_rcu_cb(),
> which may allocate memory by kzalloc with GFP_KERNEL flag. If the
> allocation cannot be satisfied, it may sleep. However, That is not allowed
> in softirq contex.
> 
> Although we found this problem on linux 4.4, the latest kernel version
> seems to have this problem as well. And it is very similar to the
> previous one:
> 	https://lkml.org/lkml/2018/7/9/391
> 
> Fix it by using RCU workqueue, which allows sleep.

Applied, thanks.

-- 
Jens Axboe


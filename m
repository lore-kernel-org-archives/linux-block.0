Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95042C6FD1C
	for <linux-block@archiver.kernel.org>; Wed, 22 Mar 2023 13:24:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229984AbjCVNY1 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 22 Mar 2023 09:24:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229719AbjCVNY0 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 22 Mar 2023 09:24:26 -0400
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C069B136C5
        for <linux-block@vger.kernel.org>; Wed, 22 Mar 2023 06:24:24 -0700 (PDT)
Received: by mail-wm1-f46.google.com with SMTP id fm20-20020a05600c0c1400b003ead37e6588so13014523wmb.5
        for <linux-block@vger.kernel.org>; Wed, 22 Mar 2023 06:24:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679491463;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fmnrNNIihsL2m7bJ09oCMNw0+jKVUUERpsFM6QsRyz8=;
        b=oSxdHhB0Oyw1rVDiH+yxpjaI02yNjofCk6zoH1jEWXLJs7EITk2FL9PFhyfM0h/tJ3
         WbdJTzzINyF4R1MW0oB4JLZByyj7B5cD4ICJxMHkYSEjZ7X/MJuNBSLgypK8ROjz3mrV
         uK/occ0eyRK6Lp130N+dmmxP+DKokwUwHWsLawCjgcdajLjpiyaJxEfBVdtEHJxLc8Wd
         vmmbcl0LMHv/ogGWroSSUxITV8p1r5sNn8JWKNhGDTRfWj8kZZGeGn750nsdNS6V3VsB
         wpu/tsdOmATmF3gpUwR9FM8+8rkKgi+lpb1i6+6AL05up6vRRGi2DpTpvBbnk593PlBO
         uuAA==
X-Gm-Message-State: AO0yUKUo1SVy6n23WPcCgdm49pA0Ci2BipUCcC4LZFHUkoE+7pHCrRm5
        cxydkJqNScf0a+ege9G0xWo=
X-Google-Smtp-Source: AK7set/KqmgrooUP+AxwhcG1nHCnmIjZjzY1SJG+2jkjfok7J8DmpBrKW/n/3WnjQAbejAgnfG8mrA==
X-Received: by 2002:a05:600c:4ec7:b0:3ed:d119:df36 with SMTP id g7-20020a05600c4ec700b003edd119df36mr6553475wmq.0.1679491463123;
        Wed, 22 Mar 2023 06:24:23 -0700 (PDT)
Received: from [192.168.64.192] (bzq-219-42-90.isdn.bezeqint.net. [62.219.42.90])
        by smtp.gmail.com with ESMTPSA id s20-20020a7bc394000000b003ee3e075d1csm4485742wmj.22.2023.03.22.06.24.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 22 Mar 2023 06:24:22 -0700 (PDT)
Message-ID: <d6e49031-5f61-c96d-ad26-5c591a21ac54@grimberg.me>
Date:   Wed, 22 Mar 2023 15:24:20 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH 0/3] nvme fabrics polling fixes
Content-Language: en-US
To:     Daniel Wagner <dwagner@suse.de>, Keith Busch <kbusch@meta.com>
Cc:     linux-block@vger.kernel.org, axboe@kernel.dk,
        linux-nvme@lists.infradead.org, hch@lst.de,
        Keith Busch <kbusch@kernel.org>
References: <20230322002350.4038048-1-kbusch@meta.com>
 <20230322084831.qwdarhmrs3uv5y43@carbon.lan>
From:   Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20230322084831.qwdarhmrs3uv5y43@carbon.lan>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

>> From: Keith Busch <kbusch@kernel.org>
>>
>> I couldn't test the existing tcp or rdma options, so I had to make a
>> loop poll option. The last patch fixes the polling queues when used with
>> fabrics.
>>
>> Note, this depends on patch I sent earlier today that I should have just
>> included in this series:
>>
>>    https://lore.kernel.org/linux-block/20230321215001.2655451-1-kbusch@meta.com/T/#u
> 
> I've tested this series with
> 
>    https://github.com/igaw/blktests/tree/queue-counts
> 
> and while for rdma all is good I got a lockdep warning for tcp:
> 
> 
>   ======================================================
>   WARNING: possible circular locking dependency detected
>   6.3.0-rc1+ #15 Tainted: G        W
>   ------------------------------------------------------
>   kworker/6:0/54 is trying to acquire lock:
>   ffff888121d88030 ((work_completion)(&queue->io_work)){+.+.}-{0:0}, at: __flush_work+0xb9/0x170
> 
>   but task is already holding lock:
>   ffff888100b0fd20 ((work_completion)(&queue->release_work)){+.+.}-{0:0}, at: process_one_work+0x707/0xbc0
> 
>   which lock already depends on the new lock.
> 
> 
>   the existing dependency chain (in reverse order) is:
> 
>   -> #2 ((work_completion)(&queue->release_work)){+.+.}-{0:0}:
>          lock_acquire+0x13a/0x310
>          process_one_work+0x728/0xbc0
>          worker_thread+0x97a/0x1480
>          kthread+0x228/0x2b0
>          ret_from_fork+0x1f/0x30
> 
>   -> #1 ((wq_completion)nvmet-wq){+.+.}-{0:0}:
>          lock_acquire+0x13a/0x310
>          __flush_workqueue+0x185/0x14e0
>          nvmet_tcp_install_queue+0x63/0x270 [nvmet_tcp]
>          nvmet_install_queue+0x2b1/0x6a0 [nvmet]
>          nvmet_execute_admin_connect+0x381/0x880 [nvmet]
>          nvmet_tcp_io_work+0x15e8/0x8f60 [nvmet_tcp]
>          process_one_work+0x756/0xbc0
>          worker_thread+0x97a/0x1480
>          kthread+0x228/0x2b0
>          ret_from_fork+0x1f/0x30
> 
>   -> #0 ((work_completion)(&queue->io_work)){+.+.}-{0:0}:
>          validate_chain+0x19f1/0x6d50
>          __lock_acquire+0x122d/0x1e90
>          lock_acquire+0x13a/0x310
>          __flush_work+0xd5/0x170
>          __cancel_work_timer+0x36b/0x470
>          nvmet_tcp_release_queue_work+0x25c/0x1000 [nvmet_tcp]
>          process_one_work+0x756/0xbc0
>          worker_thread+0x97a/0x1480
>          kthread+0x228/0x2b0
>          ret_from_fork+0x1f/0x30
> 
>   other info that might help us debug this:
> 
>   Chain exists of:
>     (work_completion)(&queue->io_work) --> (wq_completion)nvmet-wq --> (work_completion)(&queue->release_work)

This came up before.

Its because in nvmet_tcp_install_queue we flush the nvmet_wq, to let
queue releases flush before accepting new queues. Without it, there is
no back-pressure and a host can simply reconnect in a loop and exhaust
nvmet system memory...

I don't think its a deadlock, because the queue that flushes the
nvmet_wq cannot be in release, this is only possible that other queues
would be releasing. So I can't see how it would deadlock. But I don't
know how to teach lockdep.

I'll try to see if there is a different way to do this, without annoying
lockdep.

> 
>    Possible unsafe locking scenario:
> 
>          CPU0                    CPU1
>          ----                    ----
>     lock((work_completion)(&queue->release_work));
>                                  lock((wq_completion)nvmet-wq);
>                                  lock((work_completion)(&queue->release_work));
>     lock((work_completion)(&queue->io_work));
> 
>    *** DEADLOCK ***
> 
>   2 locks held by kworker/6:0/54:
>    #0: ffff888109ff6d48 ((wq_completion)nvmet-wq){+.+.}-{0:0}, at: process_one_work+0x6c8/0xbc0
>    #1: ffff888100b0fd20 ((work_completion)(&queue->release_work)){+.+.}-{0:0}, at: process_one_work+0x707/0xbc0
> 
>   stack backtrace:
>   CPU: 6 PID: 54 Comm: kworker/6:0 Tainted: G        W          6.3.0-rc1+ #15 f4d05de834b07d62567d33b70ec70fb0fa06f103
>   Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 0.0.0 02/06/2015
>   Workqueue: nvmet-wq nvmet_tcp_release_queue_work [nvmet_tcp]
>   Call Trace:
>    <TASK>
>    dump_stack_lvl+0x5a/0x80
>    check_noncircular+0x2c8/0x390
>    ? add_chain_block+0x5e0/0x5e0
>    ? ret_from_fork+0x1f/0x30
>    ? lockdep_lock+0xd3/0x260
>    ? stack_trace_save+0x10a/0x1e0
>    ? stack_trace_snprint+0x100/0x100
>    ? check_noncircular+0x1a6/0x390
>    validate_chain+0x19f1/0x6d50
>    ? lockdep_unlock+0x9e/0x1f0
>    ? validate_chain+0x15b2/0x6d50
>    ? reacquire_held_locks+0x510/0x510
>    ? reacquire_held_locks+0x510/0x510
>    ? reacquire_held_locks+0x510/0x510
>    ? add_lock_to_list+0xbf/0x2c0
>    ? lockdep_unlock+0x9e/0x1f0
>    ? validate_chain+0x15b2/0x6d50
>    ? reacquire_held_locks+0x510/0x510
>    ? reacquire_held_locks+0x510/0x510
>    ? xfs_buf_find_lock+0xb0/0x430 [xfs e56ce85f3b18232dbd061be3c73dc29bed4ad37b]
>    ? reacquire_held_locks+0x510/0x510
>    ? validate_chain+0x176/0x6d50
>    ? trace_lock_acquired+0x7b/0x180
>    ? lock_is_held_type+0x8b/0x110
>    ? lock_is_held_type+0x8b/0x110
>    ? rcu_read_lock_sched_held+0x34/0x70
>    ? reacquire_held_locks+0x510/0x510
>    ? xfs_buf_get_map+0xd72/0x11a0 [xfs e56ce85f3b18232dbd061be3c73dc29bed4ad37b]
>    ? lock_is_held_type+0x8b/0x110
>    ? rcu_read_lock_sched_held+0x34/0x70
>    ? trace_xfs_buf_read+0x7c/0x180 [xfs e56ce85f3b18232dbd061be3c73dc29bed4ad37b]
>    ? xfs_buf_read_map+0x111/0x700 [xfs e56ce85f3b18232dbd061be3c73dc29bed4ad37b]
>    ? lock_is_held_type+0x8b/0x110
>    ? lock_is_held_type+0x8b/0x110
>    ? xfs_btree_read_buf_block+0x205/0x300 [xfs e56ce85f3b18232dbd061be3c73dc29bed4ad37b]
>    ? rcu_read_lock_sched_held+0x34/0x70
>    ? trace_xfs_trans_read_buf+0x79/0x170 [xfs e56ce85f3b18232dbd061be3c73dc29bed4ad37b]
>    ? xfs_btree_read_buf_block+0x205/0x300 [xfs e56ce85f3b18232dbd061be3c73dc29bed4ad37b]
>    ? xfs_trans_read_buf_map+0x303/0x4f0 [xfs e56ce85f3b18232dbd061be3c73dc29bed4ad37b]
>    ? trace_xfs_trans_getsb+0x170/0x170 [xfs e56ce85f3b18232dbd061be3c73dc29bed4ad37b]
>    ? xfs_verify_fsbno+0x74/0x130 [xfs e56ce85f3b18232dbd061be3c73dc29bed4ad37b]
>    ? xfs_btree_ptr_to_daddr+0x19b/0x660 [xfs e56ce85f3b18232dbd061be3c73dc29bed4ad37b]
>    ? xfs_buf_set_ref+0x1d/0x50 [xfs e56ce85f3b18232dbd061be3c73dc29bed4ad37b]
>    ? xfs_btree_read_buf_block+0x233/0x300 [xfs e56ce85f3b18232dbd061be3c73dc29bed4ad37b]
>    ? mark_lock+0x8f/0x320
>    ? xfs_btree_readahead+0x250/0x250 [xfs e56ce85f3b18232dbd061be3c73dc29bed4ad37b]
>    ? xfs_verify_fsbno+0x74/0x130 [xfs e56ce85f3b18232dbd061be3c73dc29bed4ad37b]
>    ? xfs_btree_ptr_to_daddr+0x19b/0x660 [xfs e56ce85f3b18232dbd061be3c73dc29bed4ad37b]
>    ? xfs_dio_write_end_io+0x32f/0x3f0 [xfs e56ce85f3b18232dbd061be3c73dc29bed4ad37b]
>    ? xfs_dio_write_end_io+0x32f/0x3f0 [xfs e56ce85f3b18232dbd061be3c73dc29bed4ad37b]
>    ? xfs_dio_write_end_io+0x32f/0x3f0 [xfs e56ce85f3b18232dbd061be3c73dc29bed4ad37b]
>    ? xfs_dio_write_end_io+0x32f/0x3f0 [xfs e56ce85f3b18232dbd061be3c73dc29bed4ad37b]
>    ? __module_address+0x86/0x1e0
>    ? ret_from_fork+0x1f/0x30
>    ? deref_stack_reg+0x17f/0x210
>    ? ret_from_fork+0x1f/0x30
>    ? unwind_next_frame+0x16b/0x2240
>    ? ret_from_fork+0x1f/0x30
>    ? stack_trace_save+0x1e0/0x1e0
>    ? arch_stack_walk+0xb7/0xf0
>    ? lock_is_held_type+0x8b/0x110
>    ? find_busiest_group+0x104e/0x2480
>    ? load_balance+0x2540/0x2540
>    ? stack_trace_save+0x10a/0x1e0
>    ? mark_lock+0x8f/0x320
>    ? __lock_acquire+0x122d/0x1e90
>    ? lock_is_held_type+0x8b/0x110
>    ? rcu_lock_acquire+0x30/0x30
>    ? xfs_buf_ioend+0x248/0x450 [xfs e56ce85f3b18232dbd061be3c73dc29bed4ad37b]
>    ? xfs_buf_ioend+0x248/0x450 [xfs e56ce85f3b18232dbd061be3c73dc29bed4ad37b]
>    ? __module_address+0x86/0x1e0
>    ? ret_from_fork+0x1f/0x30
>    ? deref_stack_reg+0x17f/0x210
>    ? ret_from_fork+0x1f/0x30
>    ? unwind_next_frame+0x16b/0x2240
>    ? stack_trace_save+0x10a/0x1e0
>    ? deref_stack_reg+0x17f/0x210
>    ? look_up_lock_class+0x65/0x130
>    ? register_lock_class+0x5d/0x860
>    ? mark_lock+0x8f/0x320
>    __lock_acquire+0x122d/0x1e90
>    lock_acquire+0x13a/0x310
>    ? __flush_work+0xb9/0x170
>    ? read_lock_is_recursive+0x10/0x10
>    ? lock_is_held_type+0x8b/0x110
>    ? rcu_lock_acquire+0x30/0x30
>    __flush_work+0xd5/0x170
>    ? __flush_work+0xb9/0x170
>    ? flush_work+0x10/0x10
>    ? lock_is_held_type+0x8b/0x110
>    ? __lock_acquire+0x1e90/0x1e90
>    ? do_raw_spin_unlock+0x112/0x890
>    ? mark_lock+0x8f/0x320
>    ? lockdep_hardirqs_on_prepare+0x2d5/0x610
>    __cancel_work_timer+0x36b/0x470
>    ? cancel_work_sync+0x10/0x10
>    ? mark_lock+0x8f/0x320
>    ? lockdep_hardirqs_on_prepare+0x2d5/0x610
>    ? nvmet_tcp_release_queue_work+0x24d/0x1000 [nvmet_tcp f61749ac066e0812c28869697bc2623872f02bd4]
>    ? datagram_poll+0x380/0x380
>    nvmet_tcp_release_queue_work+0x25c/0x1000 [nvmet_tcp f61749ac066e0812c28869697bc2623872f02bd4]
>    process_one_work+0x756/0xbc0
>    ? rescuer_thread+0x13f0/0x13f0
>    ? lock_acquired+0x2f2/0x930
>    ? worker_thread+0xf55/0x1480
>    worker_thread+0x97a/0x1480
>    ? rcu_lock_release+0x20/0x20
>    kthread+0x228/0x2b0
>    ? rcu_lock_release+0x20/0x20
>    ? kthread_blkcg+0xa0/0xa0
>    ret_from_fork+0x1f/0x30
>    </TASK>

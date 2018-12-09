Return-Path: <SRS0=93Gy=OS=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,T_MIXED_ES,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E060C07E85
	for <linux-block@archiver.kernel.org>; Sun,  9 Dec 2018 18:47:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D8EEE20645
	for <linux-block@archiver.kernel.org>; Sun,  9 Dec 2018 18:47:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sK9I2ma1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D8EEE20645
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726179AbeLISru (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sun, 9 Dec 2018 13:47:50 -0500
Received: from mail-pl1-f194.google.com ([209.85.214.194]:44403 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726097AbeLISru (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Sun, 9 Dec 2018 13:47:50 -0500
Received: by mail-pl1-f194.google.com with SMTP id k8so4136510pls.11
        for <linux-block@vger.kernel.org>; Sun, 09 Dec 2018 10:47:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=1JX6W3TMyuqpEqoq1jl9cInVzwmNesKCoChEP8VRoBQ=;
        b=sK9I2ma1VKIUcSFA+Y+dBmb7qkFfClo0mzfeIIha375tk89soRUE/CZLIIZkG08Aqi
         F9hxKTMaBt1oAKcDnmL43SBNTgaqEBfazw1guVpvhd9WPknWeW1IObtsQi/sqtj8o8fk
         u9aQ41NMphgSbXGvb8BNFwUEzJ9GJLgImLAY5ZQb0FDM4HeaNPtpEj4VNXC0NJh2m9LF
         sdt0kRnlikD2Kb3q42pqRBksZ6ld2gOPtM48uB/NykbKpLhwhE1RxRlFz5I7GjRAEr3v
         Xwm9GLn4Cpgf/iYEbbOJy6DnSpB/dq0DuwI2K3veLJiwwbJZ+W7xFrbM0s7AuLyQJYyB
         cEIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=1JX6W3TMyuqpEqoq1jl9cInVzwmNesKCoChEP8VRoBQ=;
        b=Hbo8/8EgLXyWljD3VvI7t+BqxFx4POTCWoNzAAaKCWcsk9g3U0f9O1oQernUIntG+x
         jBadQw6GrTTdKMK8F4mOUVVdO40wyLY81QxIzFwQ7jTGYKq1hyc+FFxfErg3NGNhWqOe
         TLW3vSy+Dlvic7Ai11r2OgEnM6fmOqkcn8e65GuNK7JqwJHjE3+GqSM6KpaeLdYWL4xV
         /5GyojG+0mNvBVACPyMCMNQ02M/K7d97FmNQGa7LhHVL8A5DzjcvT92bOebZX/gXGU4c
         kqM5KvHCXKiJegPJuWAaK8dm6yvafxDRwchzQDzYaRd2kjR1rW8Pbd1iMrV2OmUAlW6N
         eWgw==
X-Gm-Message-State: AA+aEWYN+1EDTzokohnsHDr7W8ykW/0Jg9HoVVxqmNjEeYTeUNjb5pGa
        H4kK9G4vDdNTWGJOKirMJAA=
X-Google-Smtp-Source: AFSGD/XYnNu5NHTXL4SgcmxRK3gmh9iJLh9B3fxzwvWseoM0DOSrNC13iGcqy8n85cHSuF1MqQnGtg==
X-Received: by 2002:a17:902:714c:: with SMTP id u12mr9296182plm.234.1544381268589;
        Sun, 09 Dec 2018 10:47:48 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id 125sm11793984pfg.39.2018.12.09.10.47.46
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 09 Dec 2018 10:47:47 -0800 (PST)
Subject: Re: [PATCH v2] sbitmap: silence bogus lockdep IRQ warning
To:     Jens Axboe <axboe@kernel.dk>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Cc:     Ming Lei <ming.lei@redhat.com>, Omar Sandoval <osandov@osandov.com>
References: <d4dca36f-d694-0dae-7e30-87c0490497b1@kernel.dk>
From:   Guenter Roeck <linux@roeck-us.net>
Message-ID: <82dac8af-bb91-09b5-51b4-fecfc0bcbf50@roeck-us.net>
Date:   Sun, 9 Dec 2018 10:47:46 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <d4dca36f-d694-0dae-7e30-87c0490497b1@kernel.dk>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 12/9/18 10:24 AM, Jens Axboe wrote:
> Ming reports that lockdep spews the following trace. What this
> essentially says is that the sbitmap swap_lock was used inconsistently
> in IRQ enabled and disabled context, and that is usually indicative of a
> bug that will cause a deadlock.
> 
> For this case, it's a false positive. The swap_lock is used from process
> context only, when we swap the bits in the word and cleared mask. We
> also end up doing that when we are getting a driver tag, from the
> blk_mq_mark_tag_wait(), and from there we hold the waitqueue lock with
> IRQs disabled. However, this isn't from an actual IRQ, it's still
> process context.
> 
> In lieu of a better way to fix this, simply always disable interrupts
> when grabbing the swap_lock if lockdep is enabled.
> 
> [  100.967642] ================start test sanity/001================
> [  101.238280] null: module loaded
> [  106.093735]
> [  106.094012] =====================================================
> [  106.094854] WARNING: SOFTIRQ-safe -> SOFTIRQ-unsafe lock order detected
> [  106.095759] 4.20.0-rc3_5d2ee7122c73_for-next+ #1 Not tainted
> [  106.096551] -----------------------------------------------------
> [  106.097386] fio/1043 [HC0[0]:SC0[0]:HE0:SE1] is trying to acquire:
> [  106.098231] 000000004c43fa71
> (&(&sb->map[i].swap_lock)->rlock){+.+.}, at: sbitmap_get+0xd5/0x22c
> [  106.099431]
> [  106.099431] and this task is already holding:
> [  106.100229] 000000007eec8b2f
> (&(&hctx->dispatch_wait_lock)->rlock){....}, at:
> blk_mq_dispatch_rq_list+0x4c1/0xd7c
> [  106.101630] which would create a new lock dependency:
> [  106.102326]  (&(&hctx->dispatch_wait_lock)->rlock){....} ->
> (&(&sb->map[i].swap_lock)->rlock){+.+.}
> [  106.103553]
> [  106.103553] but this new dependency connects a SOFTIRQ-irq-safe lock:
> [  106.104580]  (&sbq->ws[i].wait){..-.}
> [  106.104582]
> [  106.104582] ... which became SOFTIRQ-irq-safe at:
> [  106.105751]   _raw_spin_lock_irqsave+0x4b/0x82
> [  106.106284]   __wake_up_common_lock+0x119/0x1b9
> [  106.106825]   sbitmap_queue_wake_up+0x33f/0x383
> [  106.107456]   sbitmap_queue_clear+0x4c/0x9a
> [  106.108046]   __blk_mq_free_request+0x188/0x1d3
> [  106.108581]   blk_mq_free_request+0x23b/0x26b
> [  106.109102]   scsi_end_request+0x345/0x5d7
> [  106.109587]   scsi_io_completion+0x4b5/0x8f0
> [  106.110099]   scsi_finish_command+0x412/0x456
> [  106.110615]   scsi_softirq_done+0x23f/0x29b
> [  106.111115]   blk_done_softirq+0x2a7/0x2e6
> [  106.111608]   __do_softirq+0x360/0x6ad
> [  106.112062]   run_ksoftirqd+0x2f/0x5b
> [  106.112499]   smpboot_thread_fn+0x3a5/0x3db
> [  106.113000]   kthread+0x1d4/0x1e4
> [  106.113457]   ret_from_fork+0x3a/0x50
> [  106.113969]
> [  106.113969] to a SOFTIRQ-irq-unsafe lock:
> [  106.114672]  (&(&sb->map[i].swap_lock)->rlock){+.+.}
> [  106.114674]
> [  106.114674] ... which became SOFTIRQ-irq-unsafe at:
> [  106.116000] ...
> [  106.116003]   _raw_spin_lock+0x33/0x64
> [  106.116676]   sbitmap_get+0xd5/0x22c
> [  106.117134]   __sbitmap_queue_get+0xe8/0x177
> [  106.117731]   __blk_mq_get_tag+0x1e6/0x22d
> [  106.118286]   blk_mq_get_tag+0x1db/0x6e4
> [  106.118756]   blk_mq_get_driver_tag+0x161/0x258
> [  106.119383]   blk_mq_dispatch_rq_list+0x28e/0xd7c
> [  106.120043]   blk_mq_do_dispatch_sched+0x23a/0x287
> [  106.120607]   blk_mq_sched_dispatch_requests+0x379/0x3fc
> [  106.121234]   __blk_mq_run_hw_queue+0x137/0x17e
> [  106.121781]   __blk_mq_delay_run_hw_queue+0x80/0x25f
> [  106.122366]   blk_mq_run_hw_queue+0x151/0x187
> [  106.122887]   blk_mq_sched_insert_requests+0x13f/0x175
> [  106.123492]   blk_mq_flush_plug_list+0x7d6/0x81b
> [  106.124042]   blk_flush_plug_list+0x392/0x3d7
> [  106.124557]   blk_finish_plug+0x37/0x4f
> [  106.125019]   read_pages+0x3ef/0x430
> [  106.125446]   __do_page_cache_readahead+0x18e/0x2fc
> [  106.126027]   force_page_cache_readahead+0x121/0x133
> [  106.126621]   page_cache_sync_readahead+0x35f/0x3bb
> [  106.127229]   generic_file_buffered_read+0x410/0x1860
> [  106.127932]   __vfs_read+0x319/0x38f
> [  106.128415]   vfs_read+0xd2/0x19a
> [  106.128817]   ksys_read+0xb9/0x135
> [  106.129225]   do_syscall_64+0x140/0x385
> [  106.129684]   entry_SYSCALL_64_after_hwframe+0x49/0xbe
> [  106.130292]
> [  106.130292] other info that might help us debug this:
> [  106.130292]
> [  106.131226] Chain exists of:
> [  106.131226]   &sbq->ws[i].wait -->
> &(&hctx->dispatch_wait_lock)->rlock -->
> &(&sb->map[i].swap_lock)->rlock
> [  106.131226]
> [  106.132865]  Possible interrupt unsafe locking scenario:
> [  106.132865]
> [  106.133659]        CPU0                    CPU1
> [  106.134194]        ----                    ----
> [  106.134733]   lock(&(&sb->map[i].swap_lock)->rlock);
> [  106.135318]                                local_irq_disable();
> [  106.136014]                                lock(&sbq->ws[i].wait);
> [  106.136747]
> lock(&(&hctx->dispatch_wait_lock)->rlock);
> [  106.137742]   <Interrupt>
> [  106.138110]     lock(&sbq->ws[i].wait);
> [  106.138625]
> [  106.138625]  *** DEADLOCK ***
> [  106.138625]
> [  106.139430] 3 locks held by fio/1043:
> [  106.139947]  #0: 0000000076ff0fd9 (rcu_read_lock){....}, at:
> hctx_lock+0x29/0xe8
> [  106.140813]  #1: 000000002feb1016 (&sbq->ws[i].wait){..-.}, at:
> blk_mq_dispatch_rq_list+0x4ad/0xd7c
> [  106.141877]  #2: 000000007eec8b2f
> (&(&hctx->dispatch_wait_lock)->rlock){....}, at:
> blk_mq_dispatch_rq_list+0x4c1/0xd7c
> [  106.143267]
> [  106.143267] the dependencies between SOFTIRQ-irq-safe lock and the
> holding lock:
> [  106.144351]  -> (&sbq->ws[i].wait){..-.} ops: 82 {
> [  106.144926]     IN-SOFTIRQ-W at:
> [  106.145314]                       _raw_spin_lock_irqsave+0x4b/0x82
> [  106.146042]                       __wake_up_common_lock+0x119/0x1b9
> [  106.146785]                       sbitmap_queue_wake_up+0x33f/0x383
> [  106.147567]                       sbitmap_queue_clear+0x4c/0x9a
> [  106.148379]                       __blk_mq_free_request+0x188/0x1d3
> [  106.149148]                       blk_mq_free_request+0x23b/0x26b
> [  106.149864]                       scsi_end_request+0x345/0x5d7
> [  106.150546]                       scsi_io_completion+0x4b5/0x8f0
> [  106.151367]                       scsi_finish_command+0x412/0x456
> [  106.152157]                       scsi_softirq_done+0x23f/0x29b
> [  106.152855]                       blk_done_softirq+0x2a7/0x2e6
> [  106.153537]                       __do_softirq+0x360/0x6ad
> [  106.154280]                       run_ksoftirqd+0x2f/0x5b
> [  106.155020]                       smpboot_thread_fn+0x3a5/0x3db
> [  106.155828]                       kthread+0x1d4/0x1e4
> [  106.156526]                       ret_from_fork+0x3a/0x50
> [  106.157267]     INITIAL USE at:
> [  106.157713]                      _raw_spin_lock_irqsave+0x4b/0x82
> [  106.158542]                      prepare_to_wait_exclusive+0xa8/0x215
> [  106.159421]                      blk_mq_get_tag+0x34f/0x6e4
> [  106.160186]                      blk_mq_get_request+0x48e/0xaef
> [  106.160997]                      blk_mq_make_request+0x27e/0xbd2
> [  106.161828]                      generic_make_request+0x4d1/0x873
> [  106.162661]                      submit_bio+0x20c/0x253
> [  106.163379]                      mpage_bio_submit+0x44/0x4b
> [  106.164142]                      mpage_readpages+0x3c2/0x407
> [  106.164919]                      read_pages+0x13a/0x430
> [  106.165633]                      __do_page_cache_readahead+0x18e/0x2fc
> [  106.166530]                      force_page_cache_readahead+0x121/0x133
> [  106.167439]                      page_cache_sync_readahead+0x35f/0x3bb
> [  106.168337]                      generic_file_buffered_read+0x410/0x1860
> [  106.169255]                      __vfs_read+0x319/0x38f
> [  106.169977]                      vfs_read+0xd2/0x19a
> [  106.170662]                      ksys_read+0xb9/0x135
> [  106.171356]                      do_syscall_64+0x140/0x385
> [  106.172120]                      entry_SYSCALL_64_after_hwframe+0x49/0xbe
> [  106.173051]   }
> [  106.173308]   ... key      at: [<ffffffff85094600>] __key.26481+0x0/0x40
> [  106.174219]   ... acquired at:
> [  106.174646]    _raw_spin_lock+0x33/0x64
> [  106.175183]    blk_mq_dispatch_rq_list+0x4c1/0xd7c
> [  106.175843]    blk_mq_do_dispatch_sched+0x23a/0x287
> [  106.176518]    blk_mq_sched_dispatch_requests+0x379/0x3fc
> [  106.177262]    __blk_mq_run_hw_queue+0x137/0x17e
> [  106.177900]    __blk_mq_delay_run_hw_queue+0x80/0x25f
> [  106.178591]    blk_mq_run_hw_queue+0x151/0x187
> [  106.179207]    blk_mq_sched_insert_requests+0x13f/0x175
> [  106.179926]    blk_mq_flush_plug_list+0x7d6/0x81b
> [  106.180571]    blk_flush_plug_list+0x392/0x3d7
> [  106.181187]    blk_finish_plug+0x37/0x4f
> [  106.181737]    __se_sys_io_submit+0x171/0x304
> [  106.182346]    do_syscall_64+0x140/0x385
> [  106.182895]    entry_SYSCALL_64_after_hwframe+0x49/0xbe
> [  106.183607]
> [  106.183830] -> (&(&hctx->dispatch_wait_lock)->rlock){....} ops: 1 {
> [  106.184691]    INITIAL USE at:
> [  106.185119]                    _raw_spin_lock+0x33/0x64
> [  106.185838]                    blk_mq_dispatch_rq_list+0x4c1/0xd7c
> [  106.186697]                    blk_mq_do_dispatch_sched+0x23a/0x287
> [  106.187551]                    blk_mq_sched_dispatch_requests+0x379/0x3fc
> [  106.188481]                    __blk_mq_run_hw_queue+0x137/0x17e
> [  106.189307]                    __blk_mq_delay_run_hw_queue+0x80/0x25f
> [  106.190189]                    blk_mq_run_hw_queue+0x151/0x187
> [  106.190989]                    blk_mq_sched_insert_requests+0x13f/0x175
> [  106.191902]                    blk_mq_flush_plug_list+0x7d6/0x81b
> [  106.192739]                    blk_flush_plug_list+0x392/0x3d7
> [  106.193535]                    blk_finish_plug+0x37/0x4f
> [  106.194269]                    __se_sys_io_submit+0x171/0x304
> [  106.195059]                    do_syscall_64+0x140/0x385
> [  106.195794]                    entry_SYSCALL_64_after_hwframe+0x49/0xbe
> [  106.196705]  }
> [  106.196950]  ... key      at: [<ffffffff84880620>] __key.51231+0x0/0x40
> [  106.197853]  ... acquired at:
> [  106.198270]    lock_acquire+0x280/0x2f3
> [  106.198806]    _raw_spin_lock+0x33/0x64
> [  106.199337]    sbitmap_get+0xd5/0x22c
> [  106.199850]    __sbitmap_queue_get+0xe8/0x177
> [  106.200450]    __blk_mq_get_tag+0x1e6/0x22d
> [  106.201035]    blk_mq_get_tag+0x1db/0x6e4
> [  106.201589]    blk_mq_get_driver_tag+0x161/0x258
> [  106.202237]    blk_mq_dispatch_rq_list+0x5b9/0xd7c
> [  106.202902]    blk_mq_do_dispatch_sched+0x23a/0x287
> [  106.203572]    blk_mq_sched_dispatch_requests+0x379/0x3fc
> [  106.204316]    __blk_mq_run_hw_queue+0x137/0x17e
> [  106.204956]    __blk_mq_delay_run_hw_queue+0x80/0x25f
> [  106.205649]    blk_mq_run_hw_queue+0x151/0x187
> [  106.206269]    blk_mq_sched_insert_requests+0x13f/0x175
> [  106.206997]    blk_mq_flush_plug_list+0x7d6/0x81b
> [  106.207644]    blk_flush_plug_list+0x392/0x3d7
> [  106.208264]    blk_finish_plug+0x37/0x4f
> [  106.208814]    __se_sys_io_submit+0x171/0x304
> [  106.209415]    do_syscall_64+0x140/0x385
> [  106.209965]    entry_SYSCALL_64_after_hwframe+0x49/0xbe
> [  106.210684]
> [  106.210904]
> [  106.210904] the dependencies between the lock to be acquired
> [  106.210905]  and SOFTIRQ-irq-unsafe lock:
> [  106.212541] -> (&(&sb->map[i].swap_lock)->rlock){+.+.} ops: 1969 {
> [  106.213393]    HARDIRQ-ON-W at:
> [  106.213840]                     _raw_spin_lock+0x33/0x64
> [  106.214570]                     sbitmap_get+0xd5/0x22c
> [  106.215282]                     __sbitmap_queue_get+0xe8/0x177
> [  106.216086]                     __blk_mq_get_tag+0x1e6/0x22d
> [  106.216876]                     blk_mq_get_tag+0x1db/0x6e4
> [  106.217627]                     blk_mq_get_driver_tag+0x161/0x258
> [  106.218465]                     blk_mq_dispatch_rq_list+0x28e/0xd7c
> [  106.219326]                     blk_mq_do_dispatch_sched+0x23a/0x287
> [  106.220198]                     blk_mq_sched_dispatch_requests+0x379/0x3fc
> [  106.221138]                     __blk_mq_run_hw_queue+0x137/0x17e
> [  106.221975]                     __blk_mq_delay_run_hw_queue+0x80/0x25f
> [  106.222874]                     blk_mq_run_hw_queue+0x151/0x187
> [  106.223686]                     blk_mq_sched_insert_requests+0x13f/0x175
> [  106.224597]                     blk_mq_flush_plug_list+0x7d6/0x81b
> [  106.225444]                     blk_flush_plug_list+0x392/0x3d7
> [  106.226255]                     blk_finish_plug+0x37/0x4f
> [  106.227006]                     read_pages+0x3ef/0x430
> [  106.227717]                     __do_page_cache_readahead+0x18e/0x2fc
> [  106.228595]                     force_page_cache_readahead+0x121/0x133
> [  106.229491]                     page_cache_sync_readahead+0x35f/0x3bb
> [  106.230373]                     generic_file_buffered_read+0x410/0x1860
> [  106.231277]                     __vfs_read+0x319/0x38f
> [  106.231986]                     vfs_read+0xd2/0x19a
> [  106.232666]                     ksys_read+0xb9/0x135
> [  106.233350]                     do_syscall_64+0x140/0x385
> [  106.234097]                     entry_SYSCALL_64_after_hwframe+0x49/0xbe
> [  106.235012]    SOFTIRQ-ON-W at:
> [  106.235460]                     _raw_spin_lock+0x33/0x64
> [  106.236195]                     sbitmap_get+0xd5/0x22c
> [  106.236913]                     __sbitmap_queue_get+0xe8/0x177
> [  106.237715]                     __blk_mq_get_tag+0x1e6/0x22d
> [  106.238488]                     blk_mq_get_tag+0x1db/0x6e4
> [  106.239244]                     blk_mq_get_driver_tag+0x161/0x258
> [  106.240079]                     blk_mq_dispatch_rq_list+0x28e/0xd7c
> [  106.240937]                     blk_mq_do_dispatch_sched+0x23a/0x287
> [  106.241806]                     blk_mq_sched_dispatch_requests+0x379/0x3fc
> [  106.242751]                     __blk_mq_run_hw_queue+0x137/0x17e
> [  106.243579]                     __blk_mq_delay_run_hw_queue+0x80/0x25f
> [  106.244469]                     blk_mq_run_hw_queue+0x151/0x187
> [  106.245277]                     blk_mq_sched_insert_requests+0x13f/0x175
> [  106.246191]                     blk_mq_flush_plug_list+0x7d6/0x81b
> [  106.247044]                     blk_flush_plug_list+0x392/0x3d7
> [  106.247859]                     blk_finish_plug+0x37/0x4f
> [  106.248749]                     read_pages+0x3ef/0x430
> [  106.249463]                     __do_page_cache_readahead+0x18e/0x2fc
> [  106.250357]                     force_page_cache_readahead+0x121/0x133
> [  106.251263]                     page_cache_sync_readahead+0x35f/0x3bb
> [  106.252157]                     generic_file_buffered_read+0x410/0x1860
> [  106.253084]                     __vfs_read+0x319/0x38f
> [  106.253808]                     vfs_read+0xd2/0x19a
> [  106.254488]                     ksys_read+0xb9/0x135
> [  106.255186]                     do_syscall_64+0x140/0x385
> [  106.255943]                     entry_SYSCALL_64_after_hwframe+0x49/0xbe
> [  106.256867]    INITIAL USE at:
> [  106.257300]                    _raw_spin_lock+0x33/0x64
> [  106.258033]                    sbitmap_get+0xd5/0x22c
> [  106.258747]                    __sbitmap_queue_get+0xe8/0x177
> [  106.259542]                    __blk_mq_get_tag+0x1e6/0x22d
> [  106.260320]                    blk_mq_get_tag+0x1db/0x6e4
> [  106.261072]                    blk_mq_get_driver_tag+0x161/0x258
> [  106.261902]                    blk_mq_dispatch_rq_list+0x28e/0xd7c
> [  106.262762]                    blk_mq_do_dispatch_sched+0x23a/0x287
> [  106.263626]                    blk_mq_sched_dispatch_requests+0x379/0x3fc
> [  106.264571]                    __blk_mq_run_hw_queue+0x137/0x17e
> [  106.265409]                    __blk_mq_delay_run_hw_queue+0x80/0x25f
> [  106.266302]                    blk_mq_run_hw_queue+0x151/0x187
> [  106.267111]                    blk_mq_sched_insert_requests+0x13f/0x175
> [  106.268028]                    blk_mq_flush_plug_list+0x7d6/0x81b
> [  106.268878]                    blk_flush_plug_list+0x392/0x3d7
> [  106.269694]                    blk_finish_plug+0x37/0x4f
> [  106.270432]                    read_pages+0x3ef/0x430
> [  106.271139]                    __do_page_cache_readahead+0x18e/0x2fc
> [  106.272040]                    force_page_cache_readahead+0x121/0x133
> [  106.272932]                    page_cache_sync_readahead+0x35f/0x3bb
> [  106.273811]                    generic_file_buffered_read+0x410/0x1860
> [  106.274709]                    __vfs_read+0x319/0x38f
> [  106.275407]                    vfs_read+0xd2/0x19a
> [  106.276074]                    ksys_read+0xb9/0x135
> [  106.276764]                    do_syscall_64+0x140/0x385
> [  106.277500]                    entry_SYSCALL_64_after_hwframe+0x49/0xbe
> [  106.278417]  }
> [  106.278676]  ... key      at: [<ffffffff85094640>] __key.26212+0x0/0x40
> [  106.279586]  ... acquired at:
> [  106.280026]    lock_acquire+0x280/0x2f3
> [  106.280559]    _raw_spin_lock+0x33/0x64
> [  106.281101]    sbitmap_get+0xd5/0x22c
> [  106.281610]    __sbitmap_queue_get+0xe8/0x177
> [  106.282221]    __blk_mq_get_tag+0x1e6/0x22d
> [  106.282809]    blk_mq_get_tag+0x1db/0x6e4
> [  106.283368]    blk_mq_get_driver_tag+0x161/0x258
> [  106.284018]    blk_mq_dispatch_rq_list+0x5b9/0xd7c
> [  106.284685]    blk_mq_do_dispatch_sched+0x23a/0x287
> [  106.285371]    blk_mq_sched_dispatch_requests+0x379/0x3fc
> [  106.286135]    __blk_mq_run_hw_queue+0x137/0x17e
> [  106.286806]    __blk_mq_delay_run_hw_queue+0x80/0x25f
> [  106.287515]    blk_mq_run_hw_queue+0x151/0x187
> [  106.288149]    blk_mq_sched_insert_requests+0x13f/0x175
> [  106.289041]    blk_mq_flush_plug_list+0x7d6/0x81b
> [  106.289912]    blk_flush_plug_list+0x392/0x3d7
> [  106.290590]    blk_finish_plug+0x37/0x4f
> [  106.291238]    __se_sys_io_submit+0x171/0x304
> [  106.291864]    do_syscall_64+0x140/0x385
> [  106.292534]    entry_SYSCALL_64_after_hwframe+0x49/0xbe
> 
> Reported-by: Ming Lei <ming.lei@redhat.com>
> Signed-off-by: Jens Axboe <axboe@kernel.dk>
> 
I'll give it a try.

> ---
> 
> V2: don't use lockdep_set_novalidate_class(), it doesn't work for
> spinlocks.
> 
> diff --git a/lib/sbitmap.c b/lib/sbitmap.c
> index a89fbe7cf6ca..23da156f7a17 100644
> --- a/lib/sbitmap.c
> +++ b/lib/sbitmap.c
> @@ -118,8 +118,13 @@ static int __sbitmap_get_word(unsigned long *word, unsigned long depth,
>   static inline bool sbitmap_deferred_clear(struct sbitmap *sb, int index)
>   {
>   	unsigned long mask, val;
> +	unsigned long flags;

Probably asks for __maybe_unused.

>   	bool ret = false;
>   
> +	/* Silence bogus lockdep warning */
> +#if defined(CONFIG_LOCKDEP)
> +	local_irq_save(flags);
> +#endif
>   	spin_lock(&sb->map[index].swap_lock);
>   
>   	if (!sb->map[index].cleared)
> @@ -142,6 +147,9 @@ static inline bool sbitmap_deferred_clear(struct sbitmap *sb, int index)
>   	ret = true;
>   out_unlock:
>   	spin_unlock(&sb->map[index].swap_lock);
> +#if defined(CONFIG_LOCKDEP)
> +	local_irq_restore(flags);
> +#endif
>   	return ret;
>   }
>   
> 


Return-Path: <SRS0=93Gy=OS=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.2 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D18A2C07E85
	for <linux-block@archiver.kernel.org>; Sun,  9 Dec 2018 05:55:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6934120831
	for <linux-block@archiver.kernel.org>; Sun,  9 Dec 2018 05:55:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DiFm08Z4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6934120831
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726074AbeLIFvu (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sun, 9 Dec 2018 00:51:50 -0500
Received: from mail-pg1-f196.google.com ([209.85.215.196]:42858 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726071AbeLIFvu (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Sun, 9 Dec 2018 00:51:50 -0500
Received: by mail-pg1-f196.google.com with SMTP id d72so3483998pga.9;
        Sat, 08 Dec 2018 21:51:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=CmmUvLr/1HuIpFWj0Tcf3qq/rmh5agbOWlOKs4TrsRQ=;
        b=DiFm08Z4AmoMViT5kXFYKRxHGgtn8fyWO9I9BYs3cAmEOjb/zB13Dozl5NJxxHLy24
         QajLfkfGR+MkQvLTVCnRi6xosiVnrenq4HTYoKMI8PwAjUQNoe6cBnFPQRBUEE5yAoTx
         0/yTelheyxG5f/W4aZzxyz9+0MX4+Xu1kCZHGen69wQX5chqsjclQi0pQ6r/V2nQ3TiG
         BPDRC+qkdlIry98sbus2nN8LGDVe2dfiB6pm11ZYkR/JApvZNANZ5bMYX/jHnTC3i/Ck
         X3vD6BUenWVkBnYcg1WrsECuSDM9Y93MBJKfK6h+2SudX4xiQInLdy/4ETyuYJx7ey1g
         l03w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=CmmUvLr/1HuIpFWj0Tcf3qq/rmh5agbOWlOKs4TrsRQ=;
        b=EswEW2gB65snqcv+jlPTfXdFlKuaeasZKYEL+zu/G1x4rPTjOqhF9+SQZNkV9aPDY1
         PwAwgAY9IuXrt+bp5zchbKiY9TL/bhIQZvJ0rpZDB7lAwnirgnfpfrlqI445jASbIFPl
         1X5NIFeJQPFy0f/u71m9DkxZMmNjot4lMU1YIcirbtSflgsRhUs8aUNRPpgq179TMDek
         0ZhhbpbmatAWwxjt+66fAbmeboxS7SgrsO6PU1rMVU7VILqQfzoA7Ul8FjrCcoUvaVj9
         twa4wFTinBA7AEvCpnY3GoOGf1yxclwIZmS9akaoWItL9R3ZcRG9vwXFzxONNVWB4plE
         UG9w==
X-Gm-Message-State: AA+aEWbF/GmNOQpH5sfVeymeGWZLFTmRpitCpC/gWnEqPEvdRkVOlHjC
        /NOyoNreZkzRLgxOlgo+jm1o5Uk3
X-Google-Smtp-Source: AFSGD/WaZf4z/3CzexzQF2I+eu990GhycPyZsLce5VX73a9wCgBq+gnm6WOxLwkZksq3uzxXCP/nSw==
X-Received: by 2002:a62:9913:: with SMTP id d19mr7945437pfe.107.1544334708294;
        Sat, 08 Dec 2018 21:51:48 -0800 (PST)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id t29sm11820029pfa.158.2018.12.08.21.51.46
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 08 Dec 2018 21:51:47 -0800 (PST)
Date:   Sat, 8 Dec 2018 21:51:46 -0800
From:   Guenter Roeck <linux@roeck-us.net>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, osandov@osandov.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/3] sbitmap: ammortize cost of clearing bits
Message-ID: <20181209055146.GA17190@roeck-us.net>
References: <20181130011234.32674-1-axboe@kernel.dk>
 <20181130011234.32674-3-axboe@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181130011234.32674-3-axboe@kernel.dk>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi,

On Thu, Nov 29, 2018 at 06:12:33PM -0700, Jens Axboe wrote:
> sbitmap maintains a set of words that we use to set and clear bits, with
> each bit representing a tag for blk-mq. Even though we spread the bits
> out and maintain a hint cache, one particular bit allocated will end up
> being cleared in the exact same spot.
> 
> This introduces batched clearing of bits. Instead of clearing a given
> bit, the same bit is set in a cleared/free mask instead. If we fail
> allocating a bit from a given word, then we check the free mask, and
> batch move those cleared bits at that time. This trades 64 atomic bitops
> for 2 cmpxchg().
> 
> In a threaded poll test case, half the overhead of getting and clearing
> tags is removed with this change. On another poll test case with a
> single thread, performance is unchanged.
> 
> Signed-off-by: Jens Axboe <axboe@kernel.dk>

This patch results in irq lock inversion warnings when trying to boot
from usb drives. This was observed with qemu boots of aarch64, x86, and
x86_64 images.

Log output as well as bisect results are attached below. I ran the bisect
twice, once with aarch64 and once with x86_64, with the same results.

Unfortunately, reverting the patch results in a compile error, so I was
unable to test if reverting the patch fixes the problem.

Sample qemu command line (x86_64):

qemu-system-x86_64 \
	-kernel arch/x86/boot/bzImage -M q35 -cpu SandyBridge \
	-no-reboot -snapshot -smp 4 -m 1G \
	-usb -device usb-storage,drive=d0 \
	-drive file=rootfs.ext2,if=none,id=d0,format=raw \
	--append 'root=/dev/sda rw rootwait panic=-1 console=ttyS0 console=tty' \
	-nographic

Guenter

---
...
[   19.035262] Waiting for root device /dev/sda...
[   19.139135] scsi 6:0:0:0: Direct-Access     QEMU     QEMU HARDDISK    2.5+ PQ: 0 ANSI: 5
[   19.161632] sd 6:0:0:0: Attached scsi generic sg1 type 0
[   19.171661] sd 6:0:0:0: Power-on or device reset occurred
[   19.186664] sd 6:0:0:0: [sda] 20480 512-byte logical blocks: (10.5 MB/10.0 MiB)
[   19.197035] sd 6:0:0:0: [sda] Write Protect is off
[   19.209327] sd 6:0:0:0: [sda] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[   19.330020] sd 6:0:0:0: [sda] Attached SCSI disk
[   19.363210] EXT4-fs (sda): mounting ext2 file system using the ext4 subsystem
[   19.392150] 
[   19.394410] ========================================================
[   19.397051] WARNING: possible irq lock inversion dependency detected
[   19.399744] 4.20.0-rc5-next-20181207 #1 Not tainted
[   19.402294] --------------------------------------------------------
[   19.404981] swapper/3/0 just changed the state of lock:
[   19.407185] (____ptrval____) (&sbq->ws[i].wait){..-.}, at: __wake_up_common_lock+0x5e/0xb0
[   19.409500] but this lock took another, SOFTIRQ-unsafe lock in the past:
[   19.411650]  (&(&sb->map[i].swap_lock)->rlock){+.+.}
[   19.411663] 
[   19.411663] 
[   19.411663] and interrupts could create inverse lock ordering between them.
[   19.411663] 
[   19.421461] 
[   19.421461] other info that might help us debug this:
[   19.425187] Chain exists of:
[   19.425187]   &sbq->ws[i].wait --> &(&hctx->dispatch_wait_lock)->rlock --> &(&sb->map[i].swap_lock)->rlock
[   19.425187] 
[   19.432974]  Possible interrupt unsafe locking scenario:
[   19.432974] 
[   19.436954]        CPU0                    CPU1
[   19.439002]        ----                    ----
[   19.440897]   lock(&(&sb->map[i].swap_lock)->rlock);
[   19.442828]                                local_irq_disable();
[   19.444767]                                lock(&sbq->ws[i].wait);
[   19.446767]                                lock(&(&hctx->dispatch_wait_lock)->rlock);
[   19.448716]   <Interrupt>
[   19.450574]     lock(&sbq->ws[i].wait);
[   19.452330] 
[   19.452330]  *** DEADLOCK ***
[   19.452330] 
[   19.456951] no locks held by swapper/3/0.
[   19.458648] 
[   19.458648] the shortest dependencies between 2nd lock and 1st lock:
[   19.461928]   -> (&(&sb->map[i].swap_lock)->rlock){+.+.} ops: 38 {
[   19.463648]      HARDIRQ-ON-W at:
[   19.465233]                         _raw_spin_lock+0x27/0x40
[   19.466837]                         sbitmap_get+0x8b/0x160
[   19.468490]                         __sbitmap_queue_get+0x24/0x90
[   19.469988]                         blk_mq_get_tag+0x28a/0x2c0
[   19.471455]                         blk_mq_get_driver_tag+0x7a/0x100
[   19.473051]                         blk_mq_dispatch_rq_list+0x95/0x550
[   19.474653]                         blk_mq_do_dispatch_sched+0x71/0x110
[   19.476137]                         blk_mq_sched_dispatch_requests+0x114/0x160
[   19.477712]                         __blk_mq_run_hw_queue+0x67/0xf0
[   19.479282]                         __blk_mq_delay_run_hw_queue+0x150/0x170
[   19.480830]                         blk_mq_run_hw_queue+0x83/0xe0
[   19.482302]                         blk_mq_sched_insert_request+0x14a/0x1c0
[   19.483868]                         blk_execute_rq+0x64/0x90
[   19.485396]                         __scsi_execute+0x104/0x250
[   19.486779]                         sd_revalidate_disk+0xe7/0x1cf0
[   19.488184]                         sd_probe_async+0xae/0x194
[   19.489598]                         async_run_entry_fn+0x34/0x100
[   19.491025]                         process_one_work+0x237/0x5d0
[   19.493611]                         worker_thread+0x37/0x380
[   19.496588]                         kthread+0x118/0x130
[   19.498871]                         ret_from_fork+0x3a/0x50
[   19.501009]      SOFTIRQ-ON-W at:
[   19.502991]                         _raw_spin_lock+0x27/0x40
[   19.505302]                         sbitmap_get+0x8b/0x160
[   19.507375]                         __sbitmap_queue_get+0x24/0x90
[   19.509440]                         blk_mq_get_tag+0x28a/0x2c0
[   19.510859]                         blk_mq_get_driver_tag+0x7a/0x100
[   19.512334]                         blk_mq_dispatch_rq_list+0x95/0x550
[   19.513960]                         blk_mq_do_dispatch_sched+0x71/0x110
[   19.515388]                         blk_mq_sched_dispatch_requests+0x114/0x160
[   19.516909]                         __blk_mq_run_hw_queue+0x67/0xf0
[   19.518433]                         __blk_mq_delay_run_hw_queue+0x150/0x170
[   19.519831]                         blk_mq_run_hw_queue+0x83/0xe0
[   19.521232]                         blk_mq_sched_insert_request+0x14a/0x1c0
[   19.522638]                         blk_execute_rq+0x64/0x90
[   19.524015]                         __scsi_execute+0x104/0x250
[   19.525393]                         sd_revalidate_disk+0xe7/0x1cf0
[   19.526795]                         sd_probe_async+0xae/0x194
[   19.528213]                         async_run_entry_fn+0x34/0x100
[   19.529810]                         process_one_work+0x237/0x5d0
[   19.531178]                         worker_thread+0x37/0x380
[   19.532548]                         kthread+0x118/0x130
[   19.533892]                         ret_from_fork+0x3a/0x50
[   19.535232]      INITIAL USE at:
[   19.536504]                        _raw_spin_lock+0x27/0x40
[   19.537939]                        sbitmap_get+0x8b/0x160
[   19.539411]                        __sbitmap_queue_get+0x24/0x90
[   19.540782]                        blk_mq_get_tag+0x28a/0x2c0
[   19.542134]                        blk_mq_get_driver_tag+0x7a/0x100
[   19.543495]                        blk_mq_dispatch_rq_list+0x95/0x550
[   19.544925]                        blk_mq_do_dispatch_sched+0x71/0x110
[   19.546312]                        blk_mq_sched_dispatch_requests+0x114/0x160
[   19.547712]                        __blk_mq_run_hw_queue+0x67/0xf0
[   19.549097]                        __blk_mq_delay_run_hw_queue+0x150/0x170
[   19.550692]                        blk_mq_run_hw_queue+0x83/0xe0
[   19.552086]                        blk_mq_sched_insert_request+0x14a/0x1c0
[   19.553494]                        blk_execute_rq+0x64/0x90
[   19.554862]                        __scsi_execute+0x104/0x250
[   19.556233]                        sd_revalidate_disk+0xe7/0x1cf0
[   19.557621]                        sd_probe_async+0xae/0x194
[   19.558993]                        async_run_entry_fn+0x34/0x100
[   19.560383]                        process_one_work+0x237/0x5d0
[   19.561751]                        worker_thread+0x37/0x380
[   19.563267]                        kthread+0x118/0x130
[   19.564715]                        ret_from_fork+0x3a/0x50
[   19.566050]    }
[   19.567296]    ... key      at: [<ffffffffa2f27468>] __key.23877+0x0/0x8
[   19.568691]    ... acquired at:
[   19.569986]    sbitmap_get+0x8b/0x160
[   19.571279]    __sbitmap_queue_get+0x24/0x90
[   19.572619]    blk_mq_get_tag+0x28a/0x2c0
[   19.573957]    blk_mq_get_driver_tag+0xda/0x100
[   19.575308]    blk_mq_dispatch_rq_list+0x2f6/0x550
[   19.576643]    blk_mq_do_dispatch_sched+0x71/0x110
[   19.577968]    blk_mq_sched_dispatch_requests+0x114/0x160
[   19.579328]    __blk_mq_run_hw_queue+0x67/0xf0
[   19.580671]    __blk_mq_delay_run_hw_queue+0x150/0x170
[   19.582047]    blk_mq_run_hw_queue+0x83/0xe0
[   19.583517]    blk_mq_sched_insert_request+0x14a/0x1c0
[   19.584932]    blk_execute_rq+0x64/0x90
[   19.586256]    __scsi_execute+0x104/0x250
[   19.587617]    scsi_probe_and_add_lun+0x1b5/0xc00
[   19.589020]    __scsi_scan_target+0x1f9/0x530
[   19.590367]    scsi_scan_channel.part.10+0x51/0x70
[   19.591742]    scsi_scan_host_selected+0xc9/0x140
[   19.593200]    scsi_scan_host+0x18f/0x1d0
[   19.594621]    usb_stor_scan_dwork+0x1a/0x80
[   19.595943]    process_one_work+0x237/0x5d0
[   19.597271]    worker_thread+0x37/0x380
[   19.598566]    kthread+0x118/0x130
[   19.599845]    ret_from_fork+0x3a/0x50
[   19.601128] 
[   19.602384]  -> (&(&hctx->dispatch_wait_lock)->rlock){....} ops: 1 {
[   19.603964]     INITIAL USE at:
[   19.605271]                      _raw_spin_lock+0x27/0x40
[   19.606670]                      blk_mq_dispatch_rq_list+0x270/0x550
[   19.608277]                      blk_mq_do_dispatch_sched+0x71/0x110
[   19.609808]                      blk_mq_sched_dispatch_requests+0x114/0x160
[   19.611239]                      __blk_mq_run_hw_queue+0x67/0xf0
[   19.612650]                      __blk_mq_delay_run_hw_queue+0x150/0x170
[   19.614080]                      blk_mq_run_hw_queue+0x83/0xe0
[   19.615497]                      blk_mq_sched_insert_request+0x14a/0x1c0
[   19.616949]                      blk_execute_rq+0x64/0x90
[   19.618374]                      __scsi_execute+0x104/0x250
[   19.619787]                      scsi_probe_and_add_lun+0x1b5/0xc00
[   19.621226]                      __scsi_scan_target+0x1f9/0x530
[   19.622666]                      scsi_scan_channel.part.10+0x51/0x70
[   19.624117]                      scsi_scan_host_selected+0xc9/0x140
[   19.625557]                      scsi_scan_host+0x18f/0x1d0
[   19.626992]                      usb_stor_scan_dwork+0x1a/0x80
[   19.628441]                      process_one_work+0x237/0x5d0
[   19.629832]                      worker_thread+0x37/0x380
[   19.631235]                      kthread+0x118/0x130
[   19.632724]                      ret_from_fork+0x3a/0x50
[   19.634252]   }
[   19.635499]   ... key      at: [<ffffffffa2f256a0>] __key.49100+0x0/0x8
[   19.636925]   ... acquired at:
[   19.638255]    blk_mq_dispatch_rq_list+0x270/0x550
[   19.639655]    blk_mq_do_dispatch_sched+0x71/0x110
[   19.641076]    blk_mq_sched_dispatch_requests+0x114/0x160
[   19.642517]    __blk_mq_run_hw_queue+0x67/0xf0
[   19.643961]    __blk_mq_delay_run_hw_queue+0x150/0x170
[   19.645424]    blk_mq_run_hw_queue+0x83/0xe0
[   19.646831]    blk_mq_sched_insert_request+0x14a/0x1c0
[   19.648265]    blk_execute_rq+0x64/0x90
[   19.649634]    __scsi_execute+0x104/0x250
[   19.650983]    scsi_probe_and_add_lun+0x1b5/0xc00
[   19.652360]    __scsi_scan_target+0x1f9/0x530
[   19.653808]    scsi_scan_channel.part.10+0x51/0x70
[   19.655364]    scsi_scan_host_selected+0xc9/0x140
[   19.656751]    scsi_scan_host+0x18f/0x1d0
[   19.658086]    usb_stor_scan_dwork+0x1a/0x80
[   19.659416]    process_one_work+0x237/0x5d0
[   19.660750]    worker_thread+0x37/0x380
[   19.662057]    kthread+0x118/0x130
[   19.663353]    ret_from_fork+0x3a/0x50
[   19.664649] 
[   19.665860] -> (&sbq->ws[i].wait){..-.} ops: 3 {
[   19.667186]    IN-SOFTIRQ-W at:
[   19.668474]                     _raw_spin_lock_irqsave+0x30/0x40
[   19.669878]                     __wake_up_common_lock+0x5e/0xb0
[   19.671278]                     __sbq_wake_up+0x8d/0xa0
[   19.672650]                     sbitmap_queue_clear+0x3b/0x60
[   19.674036]                     __blk_mq_free_request+0x64/0x90
[   19.675438]                     scsi_end_request+0x109/0x350
[   19.676911]                     scsi_io_completion+0x72/0x600
[   19.678477]                     blk_done_softirq+0x9a/0xd0
[   19.679847]                     __do_softirq+0xc8/0x455
[   19.681212]                     irq_exit+0xcc/0xe0
[   19.682543]                     call_function_single_interrupt+0xf/0x20
[   19.683941]                     default_idle+0x19/0x160
[   19.685311]                     do_idle+0x1d3/0x250
[   19.686643]                     cpu_startup_entry+0x14/0x20
[   19.688000]                     start_secondary+0x18f/0x1c0
[   19.689443]                     secondary_startup_64+0xa4/0xb0
[   19.690983]    INITIAL USE at:
[   19.693258]                    _raw_spin_lock_irq+0x2d/0x40
[   19.696185]                    blk_mq_dispatch_rq_list+0x25c/0x550
[   19.699217]                    blk_mq_do_dispatch_sched+0x71/0x110
[   19.702076]                    blk_mq_sched_dispatch_requests+0x114/0x160
[   19.704737]                    __blk_mq_run_hw_queue+0x67/0xf0
[   19.707182]                    __blk_mq_delay_run_hw_queue+0x150/0x170
[   19.709412]                    blk_mq_run_hw_queue+0x83/0xe0
[   19.710880]                    blk_mq_sched_insert_request+0x14a/0x1c0
[   19.712307]                    blk_execute_rq+0x64/0x90
[   19.713697]                    __scsi_execute+0x104/0x250
[   19.715083]                    scsi_probe_and_add_lun+0x1b5/0xc00
[   19.716574]                    __scsi_scan_target+0x1f9/0x530
[   19.718206]                    scsi_scan_channel.part.10+0x51/0x70
[   19.719641]                    scsi_scan_host_selected+0xc9/0x140
[   19.721184]                    scsi_scan_host+0x18f/0x1d0
[   19.722697]                    usb_stor_scan_dwork+0x1a/0x80
[   19.724077]                    process_one_work+0x237/0x5d0
[   19.725460]                    worker_thread+0x37/0x380
[   19.726820]                    kthread+0x118/0x130
[   19.728167]                    ret_from_fork+0x3a/0x50
[   19.729508]  }
[   19.730752]  ... key      at: [<ffffffffa2f27460>] __key.24146+0x0/0x8
[   19.732169]  ... acquired at:
[   19.733509]    __lock_acquire+0x8c6/0x1880
[   19.734865]    lock_acquire+0xaa/0x180
[   19.736210]    _raw_spin_lock_irqsave+0x30/0x40
[   19.737564]    __wake_up_common_lock+0x5e/0xb0
[   19.738927]    __sbq_wake_up+0x8d/0xa0
[   19.740276]    sbitmap_queue_clear+0x3b/0x60
[   19.741635]    __blk_mq_free_request+0x64/0x90
[   19.743008]    scsi_end_request+0x109/0x350
[   19.744361]    scsi_io_completion+0x72/0x600
[   19.745690]    blk_done_softirq+0x9a/0xd0
[   19.747017]    __do_softirq+0xc8/0x455
[   19.748342]    irq_exit+0xcc/0xe0
[   19.749637]    call_function_single_interrupt+0xf/0x20
[   19.750979]    default_idle+0x19/0x160
[   19.752318]    do_idle+0x1d3/0x250
[   19.753758]    cpu_startup_entry+0x14/0x20
[   19.755129]    start_secondary+0x18f/0x1c0
[   19.756470]    secondary_startup_64+0xa4/0xb0
[   19.757954] 
[   19.759225] 
[   19.759225] stack backtrace:
[   19.761899] CPU: 3 PID: 0 Comm: swapper/3 Not tainted 4.20.0-rc5-next-20181207 #1
[   19.763359] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 0.0.0 02/06/2015
[   19.765024] Call Trace:
[   19.766589]  <IRQ>
[   19.768074]  dump_stack+0x67/0x90
[   19.769580]  check_usage_forwards.cold.54+0x20/0x29
[   19.771137]  mark_lock+0x2ca/0x620
[   19.772705]  ? check_usage_backwards+0x110/0x110
[   19.774300]  __lock_acquire+0x8c6/0x1880
[   19.775676]  ? select_task_rq_fair+0x1ca/0x1110
[   19.777062]  ? __lock_acquire+0x38a/0x1880
[   19.778424]  ? __lock_acquire+0x38a/0x1880
[   19.779751]  lock_acquire+0xaa/0x180
[   19.781070]  ? __wake_up_common_lock+0x5e/0xb0
[   19.782422]  _raw_spin_lock_irqsave+0x30/0x40
[   19.783766]  ? __wake_up_common_lock+0x5e/0xb0
[   19.785129]  __wake_up_common_lock+0x5e/0xb0
[   19.786483]  __sbq_wake_up+0x8d/0xa0
[   19.787809]  sbitmap_queue_clear+0x3b/0x60
[   19.789143]  __blk_mq_free_request+0x64/0x90
[   19.790631]  scsi_end_request+0x109/0x350
[   19.792150]  scsi_io_completion+0x72/0x600
[   19.793671]  blk_done_softirq+0x9a/0xd0
[   19.795121]  __do_softirq+0xc8/0x455
[   19.796441]  irq_exit+0xcc/0xe0
[   19.797730]  call_function_single_interrupt+0xf/0x20
[   19.799153]  </IRQ>
[   19.800515] RIP: 0010:default_idle+0x19/0x160
[   19.801932] Code: ff 48 89 ea 48 89 df 31 f6 5b 5d e9 31 73 91 ff 90 41 55 41 54 55 53 65 8b 2d a3 dd e4 5e 66 66 66 66 90 e8 b9 1f 59 ff fb f4 <65> 8b 2d 90 dd e4 5e 66 66 66 66 90 5b 5d 41 5c 41 5d c3 65 8b 05
[   19.806839] RSP: 0000:ffffb6f74020bec0 EFLAGS: 00000202 ORIG_RAX: ffffffffffffff04
[   19.808531] RAX: ffff97563f2bc080 RBX: 0000000000000003 RCX: 0000000000000000
[   19.810312] RDX: 0000000000000046 RSI: 0000000000000001 RDI: ffff97563f2bc080
[   19.811925] RBP: 0000000000000003 R08: 0000000000000001 R09: 0000000000000000
[   19.813555] R10: 0000000000000000 R11: 0000000000000000 R12: 0000000000000000
[   19.815169] R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000
[   19.817002]  do_idle+0x1d3/0x250
[   19.818604]  cpu_startup_entry+0x14/0x20
[   19.820125]  start_secondary+0x18f/0x1c0
[   19.821635]  secondary_startup_64+0xa4/0xb0
[   19.856824] EXT4-fs (sda): mounted filesystem without journal. Opts: (null)
[   19.860450] VFS: Mounted root (ext2 filesystem) on device 8:0.
[   19.870456] devtmpfs: mounted
[   19.975778] Freeing unused kernel image memory: 1348K
[   19.987597] Write protecting the kernel read-only data: 22528k
[   19.999208] Freeing unused kernel image memory: 2008K
[   20.007277] Freeing unused kernel image memory: 1824K
[   20.010030] rodata_test: all tests were successful
[   20.012948] Run /sbin/init as init process
[   20.640528] EXT4-fs (sda): re-mounted. Opts: block_validity,barrier,user_xattr,acl
[   21.570798] random: dd: uninitialized urandom read (512 bytes read)
[   21.621870] dd (1296) used greatest stack depth: 12728 bytes left

---
# bad: [74c4a24df7cac1f9213a811d79558ecde23be9a2] Add linux-next specific files for 20181207
# good: [2595646791c319cadfdbf271563aac97d0843dc7] Linux 4.20-rc5
git bisect start 'HEAD' 'v4.20-rc5'
# good: [8d285caa38663cc22f7166f7cfb9ceb9d06d3c7e] Merge remote-tracking branch 'ipsec-next/master'
git bisect good 8d285caa38663cc22f7166f7cfb9ceb9d06d3c7e
# bad: [a8147fd1777cecc0a0cc57fcd742a2b06660bd12] Merge remote-tracking branch 'backlight/for-backlight-next'
git bisect bad a8147fd1777cecc0a0cc57fcd742a2b06660bd12
# good: [467e8a516dcf922d1ea343cebb0e751f81f0dca3] Merge tag 'drm-intel-next-2018-12-04' of git://anongit.freedesktop.org/drm/drm-intel into drm-next
git bisect good 467e8a516dcf922d1ea343cebb0e751f81f0dca3
# good: [25f68bda094fd6a808d1284abc23b194b0668a47] Merge remote-tracking branch 'sound/for-next'
git bisect good 25f68bda094fd6a808d1284abc23b194b0668a47
# bad: [81b6aa39f339c7ea9fe318580c168e55c5a7f593] Merge branch 'for-4.21/block' into for-next
git bisect bad 81b6aa39f339c7ea9fe318580c168e55c5a7f593
# good: [b6676f653f13f83582985bc713525a48d735b2a3] block: remove a few unused exports
git bisect good b6676f653f13f83582985bc713525a48d735b2a3
# good: [80ff2040ac3dd6d9d68d59159b0a6dffd8adc5ff] ataflop: implement mq_ops->commit_rqs() hook
git bisect good 80ff2040ac3dd6d9d68d59159b0a6dffd8adc5ff
# bad: [79eb7650f7f33f4e63a2380f00fc2fac651da7c1] Merge branch 'for-4.21/block' into for-next
git bisect bad 79eb7650f7f33f4e63a2380f00fc2fac651da7c1
# bad: [6322307809649cba6f545640563f95d686ecf404] nvme-pci: cleanup SQ allocation a bit
git bisect bad 6322307809649cba6f545640563f95d686ecf404
# bad: [2149da0748fc236b9916c53e26b3b0c9ab20a5dd] block: add cmd_flags to print_req_error
git bisect bad 2149da0748fc236b9916c53e26b3b0c9ab20a5dd
# good: [27fae429acee1e9418059e7fa545438075af5256] sbitmap: don't loop for find_next_zero_bit() for !round_robin
git bisect good 27fae429acee1e9418059e7fa545438075af5256
# bad: [ea86ea2cdced20057da4d2c32965c1219c238197] sbitmap: ammortize cost of clearing bits
git bisect bad ea86ea2cdced20057da4d2c32965c1219c238197
# good: [531724abc3bfb556c1dd68086cf9cb51f76464e3] block: avoid extra bio reference for async O_DIRECT
git bisect good 531724abc3bfb556c1dd68086cf9cb51f76464e3
# first bad commit: [ea86ea2cdced20057da4d2c32965c1219c238197] sbitmap: ammortize cost of clearing bits

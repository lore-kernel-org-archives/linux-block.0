Return-Path: <SRS0=uopx=OM=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A637C04EB9
	for <linux-block@archiver.kernel.org>; Mon,  3 Dec 2018 10:02:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 308A420850
	for <linux-block@archiver.kernel.org>; Mon,  3 Dec 2018 10:02:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="P1rNFcLf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 308A420850
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725947AbeLCKCm (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 3 Dec 2018 05:02:42 -0500
Received: from mail-wr1-f50.google.com ([209.85.221.50]:35992 "EHLO
        mail-wr1-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725864AbeLCKCm (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Mon, 3 Dec 2018 05:02:42 -0500
Received: by mail-wr1-f50.google.com with SMTP id u3so11432304wrs.3
        for <linux-block@vger.kernel.org>; Mon, 03 Dec 2018 02:02:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=NGLdznvsZoOMUSfInf+CpLFKyWyjUnfCRuzSN0GFKek=;
        b=P1rNFcLfproy45v5hWz1xYbw5NrwNjEdrFnjRoIcq/Ml8HRZNI30gkt18+HM7GTSXG
         EJKafRgrOLofhCJ4Xj9+r1h+D9Z1MGKWYGbDhpTVz0Fm3Fss1OAsc4B9wrJz+vnImZol
         l60VOrQgsZ1gBwJLgs9h/p7cJMT1lsZ97FqIOU2U0zmE71JOjDGfFXTt95QAEowqKkUb
         1oXtTqlo1tpeP90PC0AI+InZdrjOEH10/V7Q679JfosQOxVVcOkAWiyNSPTu+RulvGd/
         WURZG9xb6494oD/1uTd31Ih/WVMw3dEiF+Hc25PwZDMGtrVU0oxQgvfLSI1x0+Y7E7KL
         dSyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=NGLdznvsZoOMUSfInf+CpLFKyWyjUnfCRuzSN0GFKek=;
        b=B5eLzFgwAsGHdEccGCHkvdcwFofim6FoudAFj9EZmcYDW2+f5920T62R+VdXLqhXTc
         uAGayHvzsf7i5QVRAP6K6fdVjcMEP6RFRc9o3o0XkefSJSjo8/aVeD3Pw3v+8Mka9RBR
         sJZ+su80BZmd2rTDrDlq48XUrG62aPSGzBoi4o80r+40nwJcg15Tx4gyITJ9EqNduclc
         PZkfaYzSaMPLtPtF6OP1lG5YFQEot899jwhAsSVyyC40g9aYiSH5rgIKRBygh5UwNVUT
         of/u8mzicNX9MaPbBybKw5NOigQQpkr1s+02ZyaXuJBWAX0jHjVE8lVOTrxuadj9Dwpv
         t0Qg==
X-Gm-Message-State: AA+aEWbpVFRx3jOyvlR/hSzxcdVJXD3WNqiP14FPCkl79U/9ThGwGHhG
        eS9iq5QOnXhh1eN1vhRrAMAEgSe2hrTEVyiPZolBOG3WjYo=
X-Google-Smtp-Source: AFSGD/XXZBSfSgcoaAAfMrG3J7qNVocy1YbTeyatz4Nqbfmt/cRhy0wJKBOjkgXNqsFNg8CXpkF8sy0+BWxT0bri9Tw=
X-Received: by 2002:a5d:6549:: with SMTP id z9mr12873309wrv.116.1543831337786;
 Mon, 03 Dec 2018 02:02:17 -0800 (PST)
MIME-Version: 1.0
From:   Ming Lei <tom.leiming@gmail.com>
Date:   Mon, 3 Dec 2018 18:02:05 +0800
Message-ID: <CACVXFVObAF+keMw3aDSMBg0vfL-wSVFMw46ubkxEP-09QX4bsw@mail.gmail.com>
Subject: block: sbitmap related lockdep warning
To:     linux-block <linux-block@vger.kernel.org>,
        Jens Axboe <axboe@kernel.dk>, Omar Sandoval <osandov@fb.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi,

Just found there is sbmitmap related lockdep warning, not take a close
look yet, maybe
it is caused by recent sbitmap change.

[1] test
- modprobe null_blk queue_mode=2 nr_devices=4 shared_tags=1
submit_queues=1 hw_queue_depth=1
- then run fio on the 4 null_blk devices

[2] lockdep warning
[  100.967642] ================start test sanity/001================
[  101.238280] null: module loaded
[  106.093735]
[  106.094012] =====================================================
[  106.094854] WARNING: SOFTIRQ-safe -> SOFTIRQ-unsafe lock order detected
[  106.095759] 4.20.0-rc3_5d2ee7122c73_for-next+ #1 Not tainted
[  106.096551] -----------------------------------------------------
[  106.097386] fio/1043 [HC0[0]:SC0[0]:HE0:SE1] is trying to acquire:
[  106.098231] 000000004c43fa71
(&(&sb->map[i].swap_lock)->rlock){+.+.}, at: sbitmap_get+0xd5/0x22c
[  106.099431]
[  106.099431] and this task is already holding:
[  106.100229] 000000007eec8b2f
(&(&hctx->dispatch_wait_lock)->rlock){....}, at:
blk_mq_dispatch_rq_list+0x4c1/0xd7c
[  106.101630] which would create a new lock dependency:
[  106.102326]  (&(&hctx->dispatch_wait_lock)->rlock){....} ->
(&(&sb->map[i].swap_lock)->rlock){+.+.}
[  106.103553]
[  106.103553] but this new dependency connects a SOFTIRQ-irq-safe lock:
[  106.104580]  (&sbq->ws[i].wait){..-.}
[  106.104582]
[  106.104582] ... which became SOFTIRQ-irq-safe at:
[  106.105751]   _raw_spin_lock_irqsave+0x4b/0x82
[  106.106284]   __wake_up_common_lock+0x119/0x1b9
[  106.106825]   sbitmap_queue_wake_up+0x33f/0x383
[  106.107456]   sbitmap_queue_clear+0x4c/0x9a
[  106.108046]   __blk_mq_free_request+0x188/0x1d3
[  106.108581]   blk_mq_free_request+0x23b/0x26b
[  106.109102]   scsi_end_request+0x345/0x5d7
[  106.109587]   scsi_io_completion+0x4b5/0x8f0
[  106.110099]   scsi_finish_command+0x412/0x456
[  106.110615]   scsi_softirq_done+0x23f/0x29b
[  106.111115]   blk_done_softirq+0x2a7/0x2e6
[  106.111608]   __do_softirq+0x360/0x6ad
[  106.112062]   run_ksoftirqd+0x2f/0x5b
[  106.112499]   smpboot_thread_fn+0x3a5/0x3db
[  106.113000]   kthread+0x1d4/0x1e4
[  106.113457]   ret_from_fork+0x3a/0x50
[  106.113969]
[  106.113969] to a SOFTIRQ-irq-unsafe lock:
[  106.114672]  (&(&sb->map[i].swap_lock)->rlock){+.+.}
[  106.114674]
[  106.114674] ... which became SOFTIRQ-irq-unsafe at:
[  106.116000] ...
[  106.116003]   _raw_spin_lock+0x33/0x64
[  106.116676]   sbitmap_get+0xd5/0x22c
[  106.117134]   __sbitmap_queue_get+0xe8/0x177
[  106.117731]   __blk_mq_get_tag+0x1e6/0x22d
[  106.118286]   blk_mq_get_tag+0x1db/0x6e4
[  106.118756]   blk_mq_get_driver_tag+0x161/0x258
[  106.119383]   blk_mq_dispatch_rq_list+0x28e/0xd7c
[  106.120043]   blk_mq_do_dispatch_sched+0x23a/0x287
[  106.120607]   blk_mq_sched_dispatch_requests+0x379/0x3fc
[  106.121234]   __blk_mq_run_hw_queue+0x137/0x17e
[  106.121781]   __blk_mq_delay_run_hw_queue+0x80/0x25f
[  106.122366]   blk_mq_run_hw_queue+0x151/0x187
[  106.122887]   blk_mq_sched_insert_requests+0x13f/0x175
[  106.123492]   blk_mq_flush_plug_list+0x7d6/0x81b
[  106.124042]   blk_flush_plug_list+0x392/0x3d7
[  106.124557]   blk_finish_plug+0x37/0x4f
[  106.125019]   read_pages+0x3ef/0x430
[  106.125446]   __do_page_cache_readahead+0x18e/0x2fc
[  106.126027]   force_page_cache_readahead+0x121/0x133
[  106.126621]   page_cache_sync_readahead+0x35f/0x3bb
[  106.127229]   generic_file_buffered_read+0x410/0x1860
[  106.127932]   __vfs_read+0x319/0x38f
[  106.128415]   vfs_read+0xd2/0x19a
[  106.128817]   ksys_read+0xb9/0x135
[  106.129225]   do_syscall_64+0x140/0x385
[  106.129684]   entry_SYSCALL_64_after_hwframe+0x49/0xbe
[  106.130292]
[  106.130292] other info that might help us debug this:
[  106.130292]
[  106.131226] Chain exists of:
[  106.131226]   &sbq->ws[i].wait -->
&(&hctx->dispatch_wait_lock)->rlock -->
&(&sb->map[i].swap_lock)->rlock
[  106.131226]
[  106.132865]  Possible interrupt unsafe locking scenario:
[  106.132865]
[  106.133659]        CPU0                    CPU1
[  106.134194]        ----                    ----
[  106.134733]   lock(&(&sb->map[i].swap_lock)->rlock);
[  106.135318]                                local_irq_disable();
[  106.136014]                                lock(&sbq->ws[i].wait);
[  106.136747]
lock(&(&hctx->dispatch_wait_lock)->rlock);
[  106.137742]   <Interrupt>
[  106.138110]     lock(&sbq->ws[i].wait);
[  106.138625]
[  106.138625]  *** DEADLOCK ***
[  106.138625]
[  106.139430] 3 locks held by fio/1043:
[  106.139947]  #0: 0000000076ff0fd9 (rcu_read_lock){....}, at:
hctx_lock+0x29/0xe8
[  106.140813]  #1: 000000002feb1016 (&sbq->ws[i].wait){..-.}, at:
blk_mq_dispatch_rq_list+0x4ad/0xd7c
[  106.141877]  #2: 000000007eec8b2f
(&(&hctx->dispatch_wait_lock)->rlock){....}, at:
blk_mq_dispatch_rq_list+0x4c1/0xd7c
[  106.143267]
[  106.143267] the dependencies between SOFTIRQ-irq-safe lock and the
holding lock:
[  106.144351]  -> (&sbq->ws[i].wait){..-.} ops: 82 {
[  106.144926]     IN-SOFTIRQ-W at:
[  106.145314]                       _raw_spin_lock_irqsave+0x4b/0x82
[  106.146042]                       __wake_up_common_lock+0x119/0x1b9
[  106.146785]                       sbitmap_queue_wake_up+0x33f/0x383
[  106.147567]                       sbitmap_queue_clear+0x4c/0x9a
[  106.148379]                       __blk_mq_free_request+0x188/0x1d3
[  106.149148]                       blk_mq_free_request+0x23b/0x26b
[  106.149864]                       scsi_end_request+0x345/0x5d7
[  106.150546]                       scsi_io_completion+0x4b5/0x8f0
[  106.151367]                       scsi_finish_command+0x412/0x456
[  106.152157]                       scsi_softirq_done+0x23f/0x29b
[  106.152855]                       blk_done_softirq+0x2a7/0x2e6
[  106.153537]                       __do_softirq+0x360/0x6ad
[  106.154280]                       run_ksoftirqd+0x2f/0x5b
[  106.155020]                       smpboot_thread_fn+0x3a5/0x3db
[  106.155828]                       kthread+0x1d4/0x1e4
[  106.156526]                       ret_from_fork+0x3a/0x50
[  106.157267]     INITIAL USE at:
[  106.157713]                      _raw_spin_lock_irqsave+0x4b/0x82
[  106.158542]                      prepare_to_wait_exclusive+0xa8/0x215
[  106.159421]                      blk_mq_get_tag+0x34f/0x6e4
[  106.160186]                      blk_mq_get_request+0x48e/0xaef
[  106.160997]                      blk_mq_make_request+0x27e/0xbd2
[  106.161828]                      generic_make_request+0x4d1/0x873
[  106.162661]                      submit_bio+0x20c/0x253
[  106.163379]                      mpage_bio_submit+0x44/0x4b
[  106.164142]                      mpage_readpages+0x3c2/0x407
[  106.164919]                      read_pages+0x13a/0x430
[  106.165633]                      __do_page_cache_readahead+0x18e/0x2fc
[  106.166530]                      force_page_cache_readahead+0x121/0x133
[  106.167439]                      page_cache_sync_readahead+0x35f/0x3bb
[  106.168337]                      generic_file_buffered_read+0x410/0x1860
[  106.169255]                      __vfs_read+0x319/0x38f
[  106.169977]                      vfs_read+0xd2/0x19a
[  106.170662]                      ksys_read+0xb9/0x135
[  106.171356]                      do_syscall_64+0x140/0x385
[  106.172120]                      entry_SYSCALL_64_after_hwframe+0x49/0xbe
[  106.173051]   }
[  106.173308]   ... key      at: [<ffffffff85094600>] __key.26481+0x0/0x40
[  106.174219]   ... acquired at:
[  106.174646]    _raw_spin_lock+0x33/0x64
[  106.175183]    blk_mq_dispatch_rq_list+0x4c1/0xd7c
[  106.175843]    blk_mq_do_dispatch_sched+0x23a/0x287
[  106.176518]    blk_mq_sched_dispatch_requests+0x379/0x3fc
[  106.177262]    __blk_mq_run_hw_queue+0x137/0x17e
[  106.177900]    __blk_mq_delay_run_hw_queue+0x80/0x25f
[  106.178591]    blk_mq_run_hw_queue+0x151/0x187
[  106.179207]    blk_mq_sched_insert_requests+0x13f/0x175
[  106.179926]    blk_mq_flush_plug_list+0x7d6/0x81b
[  106.180571]    blk_flush_plug_list+0x392/0x3d7
[  106.181187]    blk_finish_plug+0x37/0x4f
[  106.181737]    __se_sys_io_submit+0x171/0x304
[  106.182346]    do_syscall_64+0x140/0x385
[  106.182895]    entry_SYSCALL_64_after_hwframe+0x49/0xbe
[  106.183607]
[  106.183830] -> (&(&hctx->dispatch_wait_lock)->rlock){....} ops: 1 {
[  106.184691]    INITIAL USE at:
[  106.185119]                    _raw_spin_lock+0x33/0x64
[  106.185838]                    blk_mq_dispatch_rq_list+0x4c1/0xd7c
[  106.186697]                    blk_mq_do_dispatch_sched+0x23a/0x287
[  106.187551]                    blk_mq_sched_dispatch_requests+0x379/0x3fc
[  106.188481]                    __blk_mq_run_hw_queue+0x137/0x17e
[  106.189307]                    __blk_mq_delay_run_hw_queue+0x80/0x25f
[  106.190189]                    blk_mq_run_hw_queue+0x151/0x187
[  106.190989]                    blk_mq_sched_insert_requests+0x13f/0x175
[  106.191902]                    blk_mq_flush_plug_list+0x7d6/0x81b
[  106.192739]                    blk_flush_plug_list+0x392/0x3d7
[  106.193535]                    blk_finish_plug+0x37/0x4f
[  106.194269]                    __se_sys_io_submit+0x171/0x304
[  106.195059]                    do_syscall_64+0x140/0x385
[  106.195794]                    entry_SYSCALL_64_after_hwframe+0x49/0xbe
[  106.196705]  }
[  106.196950]  ... key      at: [<ffffffff84880620>] __key.51231+0x0/0x40
[  106.197853]  ... acquired at:
[  106.198270]    lock_acquire+0x280/0x2f3
[  106.198806]    _raw_spin_lock+0x33/0x64
[  106.199337]    sbitmap_get+0xd5/0x22c
[  106.199850]    __sbitmap_queue_get+0xe8/0x177
[  106.200450]    __blk_mq_get_tag+0x1e6/0x22d
[  106.201035]    blk_mq_get_tag+0x1db/0x6e4
[  106.201589]    blk_mq_get_driver_tag+0x161/0x258
[  106.202237]    blk_mq_dispatch_rq_list+0x5b9/0xd7c
[  106.202902]    blk_mq_do_dispatch_sched+0x23a/0x287
[  106.203572]    blk_mq_sched_dispatch_requests+0x379/0x3fc
[  106.204316]    __blk_mq_run_hw_queue+0x137/0x17e
[  106.204956]    __blk_mq_delay_run_hw_queue+0x80/0x25f
[  106.205649]    blk_mq_run_hw_queue+0x151/0x187
[  106.206269]    blk_mq_sched_insert_requests+0x13f/0x175
[  106.206997]    blk_mq_flush_plug_list+0x7d6/0x81b
[  106.207644]    blk_flush_plug_list+0x392/0x3d7
[  106.208264]    blk_finish_plug+0x37/0x4f
[  106.208814]    __se_sys_io_submit+0x171/0x304
[  106.209415]    do_syscall_64+0x140/0x385
[  106.209965]    entry_SYSCALL_64_after_hwframe+0x49/0xbe
[  106.210684]
[  106.210904]
[  106.210904] the dependencies between the lock to be acquired
[  106.210905]  and SOFTIRQ-irq-unsafe lock:
[  106.212541] -> (&(&sb->map[i].swap_lock)->rlock){+.+.} ops: 1969 {
[  106.213393]    HARDIRQ-ON-W at:
[  106.213840]                     _raw_spin_lock+0x33/0x64
[  106.214570]                     sbitmap_get+0xd5/0x22c
[  106.215282]                     __sbitmap_queue_get+0xe8/0x177
[  106.216086]                     __blk_mq_get_tag+0x1e6/0x22d
[  106.216876]                     blk_mq_get_tag+0x1db/0x6e4
[  106.217627]                     blk_mq_get_driver_tag+0x161/0x258
[  106.218465]                     blk_mq_dispatch_rq_list+0x28e/0xd7c
[  106.219326]                     blk_mq_do_dispatch_sched+0x23a/0x287
[  106.220198]                     blk_mq_sched_dispatch_requests+0x379/0x3fc
[  106.221138]                     __blk_mq_run_hw_queue+0x137/0x17e
[  106.221975]                     __blk_mq_delay_run_hw_queue+0x80/0x25f
[  106.222874]                     blk_mq_run_hw_queue+0x151/0x187
[  106.223686]                     blk_mq_sched_insert_requests+0x13f/0x175
[  106.224597]                     blk_mq_flush_plug_list+0x7d6/0x81b
[  106.225444]                     blk_flush_plug_list+0x392/0x3d7
[  106.226255]                     blk_finish_plug+0x37/0x4f
[  106.227006]                     read_pages+0x3ef/0x430
[  106.227717]                     __do_page_cache_readahead+0x18e/0x2fc
[  106.228595]                     force_page_cache_readahead+0x121/0x133
[  106.229491]                     page_cache_sync_readahead+0x35f/0x3bb
[  106.230373]                     generic_file_buffered_read+0x410/0x1860
[  106.231277]                     __vfs_read+0x319/0x38f
[  106.231986]                     vfs_read+0xd2/0x19a
[  106.232666]                     ksys_read+0xb9/0x135
[  106.233350]                     do_syscall_64+0x140/0x385
[  106.234097]                     entry_SYSCALL_64_after_hwframe+0x49/0xbe
[  106.235012]    SOFTIRQ-ON-W at:
[  106.235460]                     _raw_spin_lock+0x33/0x64
[  106.236195]                     sbitmap_get+0xd5/0x22c
[  106.236913]                     __sbitmap_queue_get+0xe8/0x177
[  106.237715]                     __blk_mq_get_tag+0x1e6/0x22d
[  106.238488]                     blk_mq_get_tag+0x1db/0x6e4
[  106.239244]                     blk_mq_get_driver_tag+0x161/0x258
[  106.240079]                     blk_mq_dispatch_rq_list+0x28e/0xd7c
[  106.240937]                     blk_mq_do_dispatch_sched+0x23a/0x287
[  106.241806]                     blk_mq_sched_dispatch_requests+0x379/0x3fc
[  106.242751]                     __blk_mq_run_hw_queue+0x137/0x17e
[  106.243579]                     __blk_mq_delay_run_hw_queue+0x80/0x25f
[  106.244469]                     blk_mq_run_hw_queue+0x151/0x187
[  106.245277]                     blk_mq_sched_insert_requests+0x13f/0x175
[  106.246191]                     blk_mq_flush_plug_list+0x7d6/0x81b
[  106.247044]                     blk_flush_plug_list+0x392/0x3d7
[  106.247859]                     blk_finish_plug+0x37/0x4f
[  106.248749]                     read_pages+0x3ef/0x430
[  106.249463]                     __do_page_cache_readahead+0x18e/0x2fc
[  106.250357]                     force_page_cache_readahead+0x121/0x133
[  106.251263]                     page_cache_sync_readahead+0x35f/0x3bb
[  106.252157]                     generic_file_buffered_read+0x410/0x1860
[  106.253084]                     __vfs_read+0x319/0x38f
[  106.253808]                     vfs_read+0xd2/0x19a
[  106.254488]                     ksys_read+0xb9/0x135
[  106.255186]                     do_syscall_64+0x140/0x385
[  106.255943]                     entry_SYSCALL_64_after_hwframe+0x49/0xbe
[  106.256867]    INITIAL USE at:
[  106.257300]                    _raw_spin_lock+0x33/0x64
[  106.258033]                    sbitmap_get+0xd5/0x22c
[  106.258747]                    __sbitmap_queue_get+0xe8/0x177
[  106.259542]                    __blk_mq_get_tag+0x1e6/0x22d
[  106.260320]                    blk_mq_get_tag+0x1db/0x6e4
[  106.261072]                    blk_mq_get_driver_tag+0x161/0x258
[  106.261902]                    blk_mq_dispatch_rq_list+0x28e/0xd7c
[  106.262762]                    blk_mq_do_dispatch_sched+0x23a/0x287
[  106.263626]                    blk_mq_sched_dispatch_requests+0x379/0x3fc
[  106.264571]                    __blk_mq_run_hw_queue+0x137/0x17e
[  106.265409]                    __blk_mq_delay_run_hw_queue+0x80/0x25f
[  106.266302]                    blk_mq_run_hw_queue+0x151/0x187
[  106.267111]                    blk_mq_sched_insert_requests+0x13f/0x175
[  106.268028]                    blk_mq_flush_plug_list+0x7d6/0x81b
[  106.268878]                    blk_flush_plug_list+0x392/0x3d7
[  106.269694]                    blk_finish_plug+0x37/0x4f
[  106.270432]                    read_pages+0x3ef/0x430
[  106.271139]                    __do_page_cache_readahead+0x18e/0x2fc
[  106.272040]                    force_page_cache_readahead+0x121/0x133
[  106.272932]                    page_cache_sync_readahead+0x35f/0x3bb
[  106.273811]                    generic_file_buffered_read+0x410/0x1860
[  106.274709]                    __vfs_read+0x319/0x38f
[  106.275407]                    vfs_read+0xd2/0x19a
[  106.276074]                    ksys_read+0xb9/0x135
[  106.276764]                    do_syscall_64+0x140/0x385
[  106.277500]                    entry_SYSCALL_64_after_hwframe+0x49/0xbe
[  106.278417]  }
[  106.278676]  ... key      at: [<ffffffff85094640>] __key.26212+0x0/0x40
[  106.279586]  ... acquired at:
[  106.280026]    lock_acquire+0x280/0x2f3
[  106.280559]    _raw_spin_lock+0x33/0x64
[  106.281101]    sbitmap_get+0xd5/0x22c
[  106.281610]    __sbitmap_queue_get+0xe8/0x177
[  106.282221]    __blk_mq_get_tag+0x1e6/0x22d
[  106.282809]    blk_mq_get_tag+0x1db/0x6e4
[  106.283368]    blk_mq_get_driver_tag+0x161/0x258
[  106.284018]    blk_mq_dispatch_rq_list+0x5b9/0xd7c
[  106.284685]    blk_mq_do_dispatch_sched+0x23a/0x287
[  106.285371]    blk_mq_sched_dispatch_requests+0x379/0x3fc
[  106.286135]    __blk_mq_run_hw_queue+0x137/0x17e
[  106.286806]    __blk_mq_delay_run_hw_queue+0x80/0x25f
[  106.287515]    blk_mq_run_hw_queue+0x151/0x187
[  106.288149]    blk_mq_sched_insert_requests+0x13f/0x175
[  106.289041]    blk_mq_flush_plug_list+0x7d6/0x81b
[  106.289912]    blk_flush_plug_list+0x392/0x3d7
[  106.290590]    blk_finish_plug+0x37/0x4f
[  106.291238]    __se_sys_io_submit+0x171/0x304
[  106.291864]    do_syscall_64+0x140/0x385
[  106.292534]    entry_SYSCALL_64_after_hwframe+0x49/0xbe
[  106.293472]
[  106.293708]
[  106.293708] stack backtrace:
[  106.294456] CPU: 0 PID: 1043 Comm: fio Not tainted
4.20.0-rc3_5d2ee7122c73_for-next+ #1
[  106.295695] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009),
BIOS 1.10.2-2.fc27 04/01/2014
[  106.296872] Call Trace:
[  106.297246]  dump_stack+0xf0/0x191
[  106.297737]  ? show_regs_print_info+0x5/0x5
[  106.298331]  ? print_shortest_lock_dependencies+0x21d/0x245
[  106.299123]  ? print_shortest_lock_dependencies+0x21d/0x245
[  106.300049]  check_usage+0x863/0x8af
[  106.300733]  ? check_usage_forwards+0x237/0x237
[  106.301492]  ? pvclock_read_flags+0x37/0x37
[  106.302097]  ? check_redundant+0x4e/0x4e
[  106.302659]  ? commit_charge+0x570/0xa24
[  106.303221]  ? class_equal+0x11/0x1d
[  106.303737]  ? __bfs+0xff/0x3f6
[  106.304188]  ? lockdep_on+0x1e/0x1e
[  106.304709]  ? check_prevs_add+0x405/0xc15
[  106.305287]  check_prevs_add+0x405/0xc15
[  106.305972]  ? print_irq_inversion_bug.part.17+0x213/0x213
[  106.306974]  ? __pagevec_lru_add+0x13/0x13
[  106.307598]  ? pvclock_read_flags+0x37/0x37
[  106.308210]  ? zap_class+0x33b/0x33b
[  106.308720]  ? kvm_clock_read+0x14/0x23
[  106.309262]  ? kvm_sched_clock_read+0x5/0xd
[  106.309856]  ? __lock_acquire+0x171a/0x185b
[  106.310443]  __lock_acquire+0x171a/0x185b
[  106.311020]  ? debug_show_all_locks+0x354/0x354
[  106.311664]  ? module_flags+0xd7/0xd7
[  106.312190]  ? __bpf_trace_xdp_devmap_xmit+0x15/0x15
[  106.316831]  ? lock_release+0xa1/0x5b5
[  106.317395]  ? stack_access_ok+0x57/0x7c
[  106.317959]  ? check_flags+0x20a/0x20a
[  106.318488]  ? __rcu_read_unlock+0x137/0x183
[  106.319093]  ? rcu_read_unlock_special+0xb4/0xb4
[  106.319741]  ? __free_insn_slot+0x362/0x362
[  106.320327]  ? rcu_softirq_qs+0x18/0x18
[  106.320875]  ? is_bpf_text_address+0xd2/0xda
[  106.321468]  ? kernel_text_address+0x78/0x8c
[  106.322069]  ? __kernel_text_address+0x1f/0x2a
[  106.322693]  ? __list_add_valid+0x42/0x8f
[  106.323257]  lock_acquire+0x280/0x2f3
[  106.323777]  ? sbitmap_get+0xd5/0x22c
[  106.324294]  ? lock_downgrade+0x338/0x338
[  106.324860]  ? check_prevs_add+0xb3e/0xc15
[  106.325436]  ? print_irq_inversion_bug.part.17+0x213/0x213
[  106.326201]  ? find_next_zero_bit+0x27/0x88
[  106.326792]  _raw_spin_lock+0x33/0x64
[  106.327305]  ? sbitmap_get+0xd5/0x22c
[  106.327824]  sbitmap_get+0xd5/0x22c
[  106.328321]  __sbitmap_queue_get+0xe8/0x177
[  106.328911]  ? sbitmap_bitmap_show+0x2c2/0x2c2
[  106.329527]  ? kvm_sched_clock_read+0x5/0xd
[  106.330123]  __blk_mq_get_tag+0x1e6/0x22d
[  106.330692]  ? blk_mq_unique_tag+0x40/0x40
[  106.331265]  ? debug_show_all_locks+0x354/0x354
[  106.331906]  blk_mq_get_tag+0x1db/0x6e4
[  106.332447]  ? __blk_mq_tag_idle+0x44/0x44
[  106.333026]  ? wait_woken+0x152/0x152
[  106.333541]  ? pvclock_clocksource_read+0x121/0x205
[  106.334222]  ? pvclock_read_flags+0x37/0x37
[  106.334810]  ? print_irqtrace_events+0x101/0x101
[  106.335454]  ? get_lock_stats+0x23/0x51
[  106.336000]  ? lock_contended+0x65a/0x65a
[  106.336556]  ? do_raw_spin_trylock+0x156/0x1a2
[  106.337184]  blk_mq_get_driver_tag+0x161/0x258
[  106.337808]  ? blk_mq_dequeue_from_ctx+0x4c5/0x4c5
[  106.338474]  ? debug_show_all_locks+0x354/0x354
[  106.339112]  blk_mq_dispatch_rq_list+0x5b9/0xd7c
[  106.339767]  ? blk_mq_make_request+0xbd2/0xbd2
[  106.340383]  ? pvclock_clocksource_read+0x121/0x205
[  106.341065]  ? pvclock_read_flags+0x37/0x37
[  106.341661]  ? kvm_clock_read+0x14/0x23
[  106.342201]  ? kvm_clock_read+0x14/0x23
[  106.342741]  ? kvm_sched_clock_read+0x5/0xd
[  106.343322]  ? check_chain_key+0x150/0x1aa
[  106.343904]  ? check_flags+0x20a/0x20a
[  106.344428]  ? deadline_remove_request+0x1e3/0x235
[  106.345100]  ? deadline_next_request+0x77/0x77
[  106.345722]  ? do_raw_spin_unlock+0x144/0x179
[  106.346326]  ? do_raw_spin_trylock+0x1a2/0x1a2
[  106.346955]  ? preempt_count_sub+0x14/0xc4
[  106.347534]  ? _raw_spin_unlock+0x2e/0x40
[  106.348097]  ? dd_dispatch_request+0x4f9/0x540
[  106.348720]  ? deadline_fifo_request+0x159/0x159
[  106.349359]  ? pvclock_clocksource_read+0x121/0x205
[  106.350035]  ? mark_lock+0x11d/0x89d
[  106.350536]  ? pvclock_read_flags+0x37/0x37
[  106.351124]  ? print_irqtrace_events+0x101/0x101
[  106.351770]  ? rb_next_postorder+0x59/0x59
[  106.352342]  ? kvm_clock_read+0x14/0x23
[  106.352881]  ? kvm_sched_clock_read+0x5/0xd
[  106.353460]  ? check_chain_key+0x150/0x1aa
[  106.354039]  ? __lock_acquire+0xf3d/0x185b
[  106.354616]  ? debug_show_all_locks+0x354/0x354
[  106.355250]  ? __lock_acquire+0xf3d/0x185b
[  106.355829]  blk_mq_do_dispatch_sched+0x23a/0x287
[  106.356482]  ? blk_mq_sched_free_hctx_data+0xaa/0xaa
[  106.357173]  ? kvm_clock_read+0x14/0x23
[  106.357711]  ? kvm_sched_clock_read+0x5/0xd
[  106.358290]  ? check_chain_key+0x150/0x1aa
[  106.358871]  blk_mq_sched_dispatch_requests+0x379/0x3fc
[  106.359592]  ? blk_mq_sched_restart+0x2f/0x2f
[  106.360204]  ? lock_acquire+0x280/0x2f3
[  106.360743]  ? hctx_lock+0x29/0xe8
[  106.361224]  ? lock_downgrade+0x338/0x338
[  106.361792]  ? rcu_dynticks_curr_cpu_in_eqs+0xa9/0xdd
[  106.362488]  ? rcu_softirq_qs+0x18/0x18
[  106.363037]  __blk_mq_run_hw_queue+0x137/0x17e
[  106.363658]  ? hctx_lock+0xe8/0xe8
[  106.364143]  __blk_mq_delay_run_hw_queue+0x80/0x25f
[  106.364828]  blk_mq_run_hw_queue+0x151/0x187
[  106.365421]  ? blk_mq_run_work_fn+0x26/0x26
[  106.366007]  ? set_page_dirty_lock+0xd0/0x109
[  106.366611]  ? set_page_dirty+0x2dd/0x2dd
[  106.367177]  blk_mq_sched_insert_requests+0x13f/0x175
[  106.367881]  ? blk_mq_sched_insert_request+0x357/0x357
[  106.368587]  ? __lock_is_held+0x2a/0x87
[  106.369138]  blk_mq_flush_plug_list+0x7d6/0x81b
[  106.369774]  ? blkdev_direct_IO+0x69f/0x8b6
[  106.370357]  ? blk_mq_insert_requests+0x3e3/0x3e3
[  106.371013]  ? aio_poll+0x968/0x968
[  106.371503]  ? __blkdev_direct_IO_simple+0x8bf/0x8bf
[  106.372192]  ? __ia32_sys_dup3+0x44/0x44
[  106.372747]  ? debug_show_all_locks+0x354/0x354
[  106.373377]  ? preempt_count_sub+0x14/0xc4
[  106.373952]  ? _raw_spin_unlock_irqrestore+0x58/0x6b
[  106.374639]  ? rcu_lockdep_current_cpu_online+0x100/0x147
[  106.375388]  ? rcu_pm_notify+0x64/0x64
[  106.375914]  ? __lock_is_held+0x2a/0x87
[  106.376453]  ? aio_read+0x206/0x271
[  106.376948]  ? rcu_read_lock_sched_held+0x6e/0x74
[  106.377598]  ? kfree+0xaa/0x277
[  106.378050]  ? aio_read+0x206/0x271
[  106.378541]  ? kvm_clock_read+0x14/0x23
[  106.379078]  ? kvm_sched_clock_read+0x5/0xd
[  106.379661]  ? check_chain_key+0x150/0x1aa
[  106.380243]  ? ___might_sleep+0x155/0x338
[  106.380811]  blk_flush_plug_list+0x392/0x3d7
[  106.381406]  ? blk_init_request_from_bio+0xa5/0xa5
[  106.382077]  ? io_submit_one+0x686/0x8f1
[  106.382622]  ? io_submit_one+0x686/0x8f1
[  106.383175]  ? aio_fsync+0x1eb/0x1eb
[  106.383691]  ? check_flags+0x20a/0x20a
[  106.384216]  ? ___might_sleep+0x155/0x338
[  106.384781]  ? __schedule_bug+0x111/0x111
[  106.385346]  blk_finish_plug+0x37/0x4f
[  106.385878]  __se_sys_io_submit+0x171/0x304
[  106.386461]  ? io_submit_one+0x8f1/0x8f1
[  106.387017]  ? lockdep_hardirqs_on+0x26b/0x278
[  106.387632]  ? trace_hardirqs_on+0x169/0x19e
[  106.388234]  ? __bpf_trace_preemptirq_template+0x5/0x5
[  106.388955]  ? do_syscall_64+0x140/0x385
[  106.389500]  do_syscall_64+0x140/0x385
[  106.390030]  ? syscall_return_slowpath+0x291/0x291
[  106.390697]  ? trace_hardirqs_off+0x19e/0x19e
[  106.391302]  ? prepare_exit_to_usermode+0x1c4/0x1c4
[  106.391985]  ? lockdep_sys_exit+0x16/0x8d
[  106.392545]  ? trace_hardirqs_off_thunk+0x1a/0x1c
[  106.393205]  entry_SYSCALL_64_after_hwframe+0x49/0xbe
[  106.393910] RIP: 0033:0x7f8dbd04c687
[  106.394411] Code: 00 00 00 49 83 38 00 75 ed 49 83 78 08 00 75 e6
8b 47 0c 39 47 08 75 de 31 c0 c3 0f 1f 84 00 00 00 00 00 b8 d1 00 00
00 0f 05 <c3> 0f 1f 84 00 00 00 00 00 b8 d2 00 00 00 0f 05 c3 0f 1f 84
00 00
[  106.396974] RSP: 002b:00007fff21011358 EFLAGS: 00000202 ORIG_RAX:
00000000000000d1
[  106.398018] RAX: ffffffffffffffda RBX: 00007f8d989f5670 RCX: 00007f8dbd04c687
[  106.399001] RDX: 000000000207b780 RSI: 0000000000000001 RDI: 00007f8dbe52d000
[  106.399989] RBP: 0000000000000000 R08: 0000000000000001 R09: 000000000207b4e0
[  106.400976] R10: 000000000000000c R11: 0000000000000202 R12: 00007f8d989f5670
[  106.401951] R13: 0000000000000000 R14: 000000000207b7b0 R15: 000000000205b7c0
[  204.246336] null: module loaded
[  294.406501] null: module loaded
[  396.936354] null: module loaded
[  497.202198] ================end test sanity/001: (NO_HANG, 0)================


Thanks,
Ming Lei

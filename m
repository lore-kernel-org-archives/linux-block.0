Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83137C6FD1C
	for <linux-block@archiver.kernel.org>; Wed, 22 Mar 2023 08:48:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229656AbjCVIsg (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 22 Mar 2023 04:48:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229452AbjCVIsf (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 22 Mar 2023 04:48:35 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75D995073A
        for <linux-block@vger.kernel.org>; Wed, 22 Mar 2023 01:48:33 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 343D9224DD;
        Wed, 22 Mar 2023 08:48:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1679474912; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=g62l6XWKVisznBRh39TbpQCsNS2EqQCxs5mPmVbplXU=;
        b=pz0Ww5BP0VlZE8TzCNiEAgnqPnI+Qn6PCnQkPrFc8Kq3XcN7f1FW3a3vAdxDSXWSjkBszr
        99gvdx5Ht8oZKmUhh4a1OX/L/F28PfiL04VIKCaWzPCC5wUmlTiha1VmKGiqqWtyOf4obp
        E79bb4UPyTozzSDbRZXiwval064goSo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1679474912;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=g62l6XWKVisznBRh39TbpQCsNS2EqQCxs5mPmVbplXU=;
        b=0yqQNLKPAXpQuT3Ju1qkVDXPlzvF4bxEOVniNrfY//gRYYbrl9l//fXp/24wsq25/7kcAr
        KHP1ytFkFgNvneCA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 25BC0138E9;
        Wed, 22 Mar 2023 08:48:32 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id ZxMyCeDAGmQnSgAAMHmgww
        (envelope-from <dwagner@suse.de>); Wed, 22 Mar 2023 08:48:32 +0000
Date:   Wed, 22 Mar 2023 09:48:31 +0100
From:   Daniel Wagner <dwagner@suse.de>
To:     Keith Busch <kbusch@meta.com>
Cc:     linux-block@vger.kernel.org, axboe@kernel.dk,
        linux-nvme@lists.infradead.org, hch@lst.de, sagi@grimberg.me,
        Keith Busch <kbusch@kernel.org>
Subject: Re: [PATCH 0/3] nvme fabrics polling fixes
Message-ID: <20230322084831.qwdarhmrs3uv5y43@carbon.lan>
References: <20230322002350.4038048-1-kbusch@meta.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230322002350.4038048-1-kbusch@meta.com>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, Mar 21, 2023 at 05:23:47PM -0700, Keith Busch wrote:
> From: Keith Busch <kbusch@kernel.org>
> 
> I couldn't test the existing tcp or rdma options, so I had to make a
> loop poll option. The last patch fixes the polling queues when used with
> fabrics.
> 
> Note, this depends on patch I sent earlier today that I should have just
> included in this series:
> 
>   https://lore.kernel.org/linux-block/20230321215001.2655451-1-kbusch@meta.com/T/#u

I've tested this series with

  https://github.com/igaw/blktests/tree/queue-counts

and while for rdma all is good I got a lockdep warning for tcp:


 ======================================================
 WARNING: possible circular locking dependency detected
 6.3.0-rc1+ #15 Tainted: G        W
 ------------------------------------------------------
 kworker/6:0/54 is trying to acquire lock:
 ffff888121d88030 ((work_completion)(&queue->io_work)){+.+.}-{0:0}, at: __flush_work+0xb9/0x170

 but task is already holding lock:
 ffff888100b0fd20 ((work_completion)(&queue->release_work)){+.+.}-{0:0}, at: process_one_work+0x707/0xbc0

 which lock already depends on the new lock.


 the existing dependency chain (in reverse order) is:

 -> #2 ((work_completion)(&queue->release_work)){+.+.}-{0:0}:
        lock_acquire+0x13a/0x310
        process_one_work+0x728/0xbc0
        worker_thread+0x97a/0x1480
        kthread+0x228/0x2b0
        ret_from_fork+0x1f/0x30

 -> #1 ((wq_completion)nvmet-wq){+.+.}-{0:0}:
        lock_acquire+0x13a/0x310
        __flush_workqueue+0x185/0x14e0
        nvmet_tcp_install_queue+0x63/0x270 [nvmet_tcp]
        nvmet_install_queue+0x2b1/0x6a0 [nvmet]
        nvmet_execute_admin_connect+0x381/0x880 [nvmet]
        nvmet_tcp_io_work+0x15e8/0x8f60 [nvmet_tcp]
        process_one_work+0x756/0xbc0
        worker_thread+0x97a/0x1480
        kthread+0x228/0x2b0
        ret_from_fork+0x1f/0x30

 -> #0 ((work_completion)(&queue->io_work)){+.+.}-{0:0}:
        validate_chain+0x19f1/0x6d50
        __lock_acquire+0x122d/0x1e90
        lock_acquire+0x13a/0x310
        __flush_work+0xd5/0x170
        __cancel_work_timer+0x36b/0x470
        nvmet_tcp_release_queue_work+0x25c/0x1000 [nvmet_tcp]
        process_one_work+0x756/0xbc0
        worker_thread+0x97a/0x1480
        kthread+0x228/0x2b0
        ret_from_fork+0x1f/0x30

 other info that might help us debug this:

 Chain exists of:
   (work_completion)(&queue->io_work) --> (wq_completion)nvmet-wq --> (work_completion)(&queue->release_work)

  Possible unsafe locking scenario:

        CPU0                    CPU1
        ----                    ----
   lock((work_completion)(&queue->release_work));
                                lock((wq_completion)nvmet-wq);
                                lock((work_completion)(&queue->release_work));
   lock((work_completion)(&queue->io_work));

  *** DEADLOCK ***

 2 locks held by kworker/6:0/54:
  #0: ffff888109ff6d48 ((wq_completion)nvmet-wq){+.+.}-{0:0}, at: process_one_work+0x6c8/0xbc0
  #1: ffff888100b0fd20 ((work_completion)(&queue->release_work)){+.+.}-{0:0}, at: process_one_work+0x707/0xbc0

 stack backtrace:
 CPU: 6 PID: 54 Comm: kworker/6:0 Tainted: G        W          6.3.0-rc1+ #15 f4d05de834b07d62567d33b70ec70fb0fa06f103
 Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 0.0.0 02/06/2015
 Workqueue: nvmet-wq nvmet_tcp_release_queue_work [nvmet_tcp]
 Call Trace:
  <TASK>
  dump_stack_lvl+0x5a/0x80
  check_noncircular+0x2c8/0x390
  ? add_chain_block+0x5e0/0x5e0
  ? ret_from_fork+0x1f/0x30
  ? lockdep_lock+0xd3/0x260
  ? stack_trace_save+0x10a/0x1e0
  ? stack_trace_snprint+0x100/0x100
  ? check_noncircular+0x1a6/0x390
  validate_chain+0x19f1/0x6d50
  ? lockdep_unlock+0x9e/0x1f0
  ? validate_chain+0x15b2/0x6d50
  ? reacquire_held_locks+0x510/0x510
  ? reacquire_held_locks+0x510/0x510
  ? reacquire_held_locks+0x510/0x510
  ? add_lock_to_list+0xbf/0x2c0
  ? lockdep_unlock+0x9e/0x1f0
  ? validate_chain+0x15b2/0x6d50
  ? reacquire_held_locks+0x510/0x510
  ? reacquire_held_locks+0x510/0x510
  ? xfs_buf_find_lock+0xb0/0x430 [xfs e56ce85f3b18232dbd061be3c73dc29bed4ad37b]
  ? reacquire_held_locks+0x510/0x510
  ? validate_chain+0x176/0x6d50
  ? trace_lock_acquired+0x7b/0x180
  ? lock_is_held_type+0x8b/0x110
  ? lock_is_held_type+0x8b/0x110
  ? rcu_read_lock_sched_held+0x34/0x70
  ? reacquire_held_locks+0x510/0x510
  ? xfs_buf_get_map+0xd72/0x11a0 [xfs e56ce85f3b18232dbd061be3c73dc29bed4ad37b]
  ? lock_is_held_type+0x8b/0x110
  ? rcu_read_lock_sched_held+0x34/0x70
  ? trace_xfs_buf_read+0x7c/0x180 [xfs e56ce85f3b18232dbd061be3c73dc29bed4ad37b]
  ? xfs_buf_read_map+0x111/0x700 [xfs e56ce85f3b18232dbd061be3c73dc29bed4ad37b]
  ? lock_is_held_type+0x8b/0x110
  ? lock_is_held_type+0x8b/0x110
  ? xfs_btree_read_buf_block+0x205/0x300 [xfs e56ce85f3b18232dbd061be3c73dc29bed4ad37b]
  ? rcu_read_lock_sched_held+0x34/0x70
  ? trace_xfs_trans_read_buf+0x79/0x170 [xfs e56ce85f3b18232dbd061be3c73dc29bed4ad37b]
  ? xfs_btree_read_buf_block+0x205/0x300 [xfs e56ce85f3b18232dbd061be3c73dc29bed4ad37b]
  ? xfs_trans_read_buf_map+0x303/0x4f0 [xfs e56ce85f3b18232dbd061be3c73dc29bed4ad37b]
  ? trace_xfs_trans_getsb+0x170/0x170 [xfs e56ce85f3b18232dbd061be3c73dc29bed4ad37b]
  ? xfs_verify_fsbno+0x74/0x130 [xfs e56ce85f3b18232dbd061be3c73dc29bed4ad37b]
  ? xfs_btree_ptr_to_daddr+0x19b/0x660 [xfs e56ce85f3b18232dbd061be3c73dc29bed4ad37b]
  ? xfs_buf_set_ref+0x1d/0x50 [xfs e56ce85f3b18232dbd061be3c73dc29bed4ad37b]
  ? xfs_btree_read_buf_block+0x233/0x300 [xfs e56ce85f3b18232dbd061be3c73dc29bed4ad37b]
  ? mark_lock+0x8f/0x320
  ? xfs_btree_readahead+0x250/0x250 [xfs e56ce85f3b18232dbd061be3c73dc29bed4ad37b]
  ? xfs_verify_fsbno+0x74/0x130 [xfs e56ce85f3b18232dbd061be3c73dc29bed4ad37b]
  ? xfs_btree_ptr_to_daddr+0x19b/0x660 [xfs e56ce85f3b18232dbd061be3c73dc29bed4ad37b]
  ? xfs_dio_write_end_io+0x32f/0x3f0 [xfs e56ce85f3b18232dbd061be3c73dc29bed4ad37b]
  ? xfs_dio_write_end_io+0x32f/0x3f0 [xfs e56ce85f3b18232dbd061be3c73dc29bed4ad37b]
  ? xfs_dio_write_end_io+0x32f/0x3f0 [xfs e56ce85f3b18232dbd061be3c73dc29bed4ad37b]
  ? xfs_dio_write_end_io+0x32f/0x3f0 [xfs e56ce85f3b18232dbd061be3c73dc29bed4ad37b]
  ? __module_address+0x86/0x1e0
  ? ret_from_fork+0x1f/0x30
  ? deref_stack_reg+0x17f/0x210
  ? ret_from_fork+0x1f/0x30
  ? unwind_next_frame+0x16b/0x2240
  ? ret_from_fork+0x1f/0x30
  ? stack_trace_save+0x1e0/0x1e0
  ? arch_stack_walk+0xb7/0xf0
  ? lock_is_held_type+0x8b/0x110
  ? find_busiest_group+0x104e/0x2480
  ? load_balance+0x2540/0x2540
  ? stack_trace_save+0x10a/0x1e0
  ? mark_lock+0x8f/0x320
  ? __lock_acquire+0x122d/0x1e90
  ? lock_is_held_type+0x8b/0x110
  ? rcu_lock_acquire+0x30/0x30
  ? xfs_buf_ioend+0x248/0x450 [xfs e56ce85f3b18232dbd061be3c73dc29bed4ad37b]
  ? xfs_buf_ioend+0x248/0x450 [xfs e56ce85f3b18232dbd061be3c73dc29bed4ad37b]
  ? __module_address+0x86/0x1e0
  ? ret_from_fork+0x1f/0x30
  ? deref_stack_reg+0x17f/0x210
  ? ret_from_fork+0x1f/0x30
  ? unwind_next_frame+0x16b/0x2240
  ? stack_trace_save+0x10a/0x1e0
  ? deref_stack_reg+0x17f/0x210
  ? look_up_lock_class+0x65/0x130
  ? register_lock_class+0x5d/0x860
  ? mark_lock+0x8f/0x320
  __lock_acquire+0x122d/0x1e90
  lock_acquire+0x13a/0x310
  ? __flush_work+0xb9/0x170
  ? read_lock_is_recursive+0x10/0x10
  ? lock_is_held_type+0x8b/0x110
  ? rcu_lock_acquire+0x30/0x30
  __flush_work+0xd5/0x170
  ? __flush_work+0xb9/0x170
  ? flush_work+0x10/0x10
  ? lock_is_held_type+0x8b/0x110
  ? __lock_acquire+0x1e90/0x1e90
  ? do_raw_spin_unlock+0x112/0x890
  ? mark_lock+0x8f/0x320
  ? lockdep_hardirqs_on_prepare+0x2d5/0x610
  __cancel_work_timer+0x36b/0x470
  ? cancel_work_sync+0x10/0x10
  ? mark_lock+0x8f/0x320
  ? lockdep_hardirqs_on_prepare+0x2d5/0x610
  ? nvmet_tcp_release_queue_work+0x24d/0x1000 [nvmet_tcp f61749ac066e0812c28869697bc2623872f02bd4]
  ? datagram_poll+0x380/0x380
  nvmet_tcp_release_queue_work+0x25c/0x1000 [nvmet_tcp f61749ac066e0812c28869697bc2623872f02bd4]
  process_one_work+0x756/0xbc0
  ? rescuer_thread+0x13f0/0x13f0
  ? lock_acquired+0x2f2/0x930
  ? worker_thread+0xf55/0x1480
  worker_thread+0x97a/0x1480
  ? rcu_lock_release+0x20/0x20
  kthread+0x228/0x2b0
  ? rcu_lock_release+0x20/0x20
  ? kthread_blkcg+0xa0/0xa0
  ret_from_fork+0x1f/0x30
  </TASK>

Received: from mail-ot1-f49.google.com (mail-ot1-f49.google.com [209.85.210.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FDB8331EC4
	for <linux-block@vger.kernel.org>; Tue,  9 Jun 2026 23:12:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781046737; cv=none; b=Gs/SPDcQayDRIqTBUTh1o+M674rF+7PTD/JGma2AJ1Vtg/ocyowBZiOviNYNrZH8RpcZbLJYQRes8HI1WkJmf9SWcEiPHK7Gbrm5hSzESihs/QhTZWu6OzFGUUFwZV/v3jT0bCY2OoYvO2PpkBVLAMDivcWWyRwurv5BvlExNTQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781046737; c=relaxed/simple;
	bh=NMZoR9a4+og5TT6gPaMCYYTlxzObmToWFA3ojjgrgMQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=cIxeeVtDRm0X8TXDQEtxfd+Vx4+9bDKo8NFv/bEI7VdYFyAPJmYPADLxhzWasoVXDDEPlqlx/Oau18DHPjRGyKh/YvIITXrPGvyxc0kp1CV1IMd/B16v8LbCzRSbbdEAb8obtAPNR4W1tQATAGysC+1YEo5YbjxdDnUlg2P6PMk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=purestorage.com; spf=pass smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=fNuMGOUY; arc=none smtp.client-ip=209.85.210.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=purestorage.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="fNuMGOUY"
Received: by mail-ot1-f49.google.com with SMTP id 46e09a7af769-7e6d7263025so1563151a34.0
        for <linux-block@vger.kernel.org>; Tue, 09 Jun 2026 16:12:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1781046734; x=1781651534; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zI6fupU0FppoNTWCTQKWlfeXF58eOXn3yMojhw64nbk=;
        b=fNuMGOUYMawKOKKLwWgd43eNgsgqV01Jyf6mwLjWFo1imhUjo6yVdVNzMliCgUsYR3
         KrXrnGzU4zwAbDDB7QZ9i8brw7kAcaxw67LM/rOI2QQdi9r7E3ECIjBebiOgPFJGDGQU
         aZJ2MRWiTPNCqbwjWDEkqAKTwf71H7Wm0M5hqaoTDHOitW6YK5wcSgoCuFHlORwRmZCv
         BCWyOAQykPcepix3Q1WWe1unRqV5IL1HQEl+FmLFJTTP/bXB9R1UqqE+bn7FbC29e5zY
         ypoUmAxuvPtj0Ugwm4SV1WXtmwHqp/+herqO/ntEuJ/yYWJ7lbhQ+1S9l+dsV6nvWV05
         UC1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781046734; x=1781651534;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=zI6fupU0FppoNTWCTQKWlfeXF58eOXn3yMojhw64nbk=;
        b=hiW/mu7u02Zf/S5JV6ZABgd68tJy9z1rOW6rlSGFUx7zeW0QSgjK2sgjfLUePCB0VA
         de4r90Y1qP6bYFQP7Bahok+5NlFgn5KM0JnU2kKXfYlvEP6td/TpUNw/XFPVzZv9bzoF
         X9h2BqIp3KxGFWJLziibwZoJ1aO94oy/8tPIv26EWDsVzoVHyG5omxbuXapo9p5PKN4w
         A1t2iHIaz6eeDWUgXR5Wpu6U6X3qH0eJDXUnEiAEVOoNfC7sZGwyxHU0WFNcK04cOj9A
         o6IPKknFCrL/GqJnWRsyxALMEuuGqrGs6BOI2eavGt846FsQGx3/Vg8erHs9EtbPcfo6
         1Ahg==
X-Forwarded-Encrypted: i=1; AFNElJ8TL8GNRNErtsGAOkqaQaSNtL2MSWO9GUki+XkL4WxO2TErPnPG2Vp8QM3bdWOT7UsTpgtnsRx/OSNFWg==@vger.kernel.org
X-Gm-Message-State: AOJu0Yx+3jApasS4nymTgH7HFJpG1PDhnrm8C7UNzvf4MTOirv+qFYDl
	3AmVEEtMvcM8rZIGxvhP2ndcpFjSqbZsgY8cbkuj0rIq3lewHskBwYZu6k6kDjlutW4=
X-Gm-Gg: Acq92OGVnlHkyPbLDH6M3O/E+crTmDQnB2fFcJc2oxBuJpjut9FBvITI9zobVTruiKo
	F4MjEouOVi7o/HX2ayzJ4wBWt3PnR3KNO0xyAdQtz16sIu6pQmJA7diVkl1ddRFmFZsZOMfHbWm
	hzvu4/2MvxJEZ+a5wGZXF2J4BtvFYB2Bz/iQkaJbgtMTGe5P1ZjcBj6ad5QpdD/h+nIbcpjrNoM
	Ow01hyWRlN98rprY9MWjk4GupYuK4Y/sqpJtl5zey7Kqg0dvTYED7Iq1NzkXQTZjkadqqszni8L
	8G1C1fBHJDEBWGbIwuIwGj6UXssS+d2zX0lcYmmUotyxPXAQVV+sQSZmKfPhthjonVesOk3tEh9
	OIBGnxzL9K4S6DmAFERBqFY6dYwZOWEkS7bJfLPcZIOf8CEWjHpTch08yrbU5uVV1B3TypOFL65
	kJ6Q4O0hBgIw5YBnrdh4L81Uoac8GmvzpzQsrJKML4DTi1OkKLY2KUidPKiEWHfUVuEqzNDQaZ
X-Received: by 2002:a05:6830:81f3:b0:7d9:b338:a669 with SMTP id 46e09a7af769-7e70c5d052cmr7772080a34.2.1781046733931;
        Tue, 09 Jun 2026 16:12:13 -0700 (PDT)
Received: from dev-cachen2.dev.purestorage.com ([208.88.159.128])
        by smtp.googlemail.com with ESMTPSA id 46e09a7af769-7e6e78e14acsm15951911a34.14.2026.06.09.16.12.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Jun 2026 16:12:13 -0700 (PDT)
From: Casey Chen <cachen@purestorage.com>
To: Mohamed Khalfella <mkhalfella@purestorage.com>
Cc: Keith Busch <kbusch@kernel.org>,
	James Smart <james.smart@broadcom.com>,
	Jens Axboe <axboe@kernel.dk>,
	Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>,
	linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-block@vger.kernel.org,
	Yuanyuan Zhong <yzhong@purestorage.com>,
	Michael Liang <mliang@purestorage.com>,
	Randy Jennings <randyj@purestorage.com>
Subject: Re: [PATCH] block: Fix blk_sync_queue() to properly stop timeout timer
Date: Tue,  9 Jun 2026 17:11:44 -0600
Message-Id: <20260609231145.3712029-1-cachen@purestorage.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250620183419.GC4836-mkhalfella@purestorage.com>
References: <20250529214928.2112990-1-mkhalfella@purestorage.com> <aDjcA_H7Ec9VICps@kbusch-mbp> <20250529223345.GA2013185-mkhalfella@purestorage.com> <20250620183419.GC4836-mkhalfella@purestorage.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On 2025-06-20 11:34:19 -0700, Mohamed Khalfella wrote:
> Following up on this patch. I think the issue with blk_sync_queue()
> needs to be addressed. If adding a queue flag is not the preferred way
> to do it, please let me know what do you suggest and I will make the
> code changes.

I'd like to add a second data point in support of this patch. We hit
the same blk_sync_queue() race in nvme-rdma during torture testing of
an nvme-multipath/dm-mpath stacked configuration, with a call pattern
distinct from the nvme-fc case Mohamed reported. The symptom on our
side is request double-completion leading to dm-rq clone double-free,
not the self-deadlock Mohamed observed; but the root cause is the
same q->timeout rearm window inside blk_sync_queue().

Importantly, nvme-rdma's blk_sync_queue() call happens from a
separate workqueue (nvme_rdma_error_recovery_work), NOT from inside
blk_mq_timeout_work. So Keith's earlier suggestion that the consumer
"just not sync the queues within the timeout workqueue context" --
which addresses nvme-fc's self-deadlock -- does not apply to us:
we already are outside that context, and the race still manifests
because blk_sync_queue() itself doesn't fence q->timeout_work
against post-return rearm. The fix has to be in blk_sync_queue().

Setup:
  - Linux 6.6.77, ~64 CPUs, ~50 nvme-rdma controllers, nvme-mpath
    paths each carrying a dm-mpath clone in flight.
  - "Stall an SPM" torture: target-side faults inducing per-controller
    nvme_rdma_error_recovery_work in parallel across many ctrls.

Call pattern:

  blk_mq_timeout_work       (per-queue, kblockd)
    ... nvme_rdma_timeout(rq) -- ctrl state != NVME_CTRL_LIVE
        path A -> nvme_rdma_complete_timed_out(rq)
            blk_mq_complete_request(rq)        <- forced completion A

  nvme_rdma_error_recovery_work (per-ctrl, separate workqueue)
    nvme_rdma_teardown_io_queues
      nvme_quiesce_io_queues
      nvme_sync_io_queues       <- calls blk_sync_queue per ns->queue
      nvme_rdma_stop_io_queues
      nvme_rdma_cancel_tagset
        blk_mq_tagset_busy_iter(nvme_cancel_request)
          nvme_cancel_request(rq)
            blk_mq_complete_request(rq)        <- forced completion B

We instrumented the kernel to capture per-request event histories
(stack + cpu + timestamp) at each forced-completion entry point, at
blk_mq_complete_request() entry on the orig, and at
multipath_release_clone(). In an unpatched 6.6 we captured the
following sequence on the same nvme-rdma clone within ~5 ms, which
walks step-by-step from the two racing producers through the
double-completion of the orig to the double-free of the clone.
Records below are verbatim from the kernel log:

  rq=ffff889589967d00 tag=10 qid=16 ctrl=nvme33 op=DRV_IN

(1) Timeout (T) and cancel (C) reach forced-completion entry within
    ~1 us, on different CPUs (note 'age=4751us' vs 'age=4750us'):

     by-source[2] source=T age=4751us cpu=8 op=DRV_IN nr_bytes=32768 sts=0 ctx=ffff889589967d00 stack(10):
       [0] nvme_rdma_timeout+0x58/0x110 [nvme_rdma]
       [1] blk_mq_handle_expired+0x5d/0x90
       [2] bt_iter+0x7e/0x90
       [3] blk_mq_queue_tag_busy_iter+0x2b3/0x590
       [4] blk_mq_timeout_work+0x15f/0x1b0
       [5] process_one_work+0x133/0x380
       [6] worker_thread+0x30d/0x420
       [7] kthread+0xe5/0x110
       [8] ret_from_fork+0x2d/0x50
       [9] ret_from_fork_asm+0x11/0x20

     by-source[1] source=C age=4750us cpu=14 op=DRV_IN nr_bytes=32768 sts=0 ctx=ffff889589967d00 stack(10):
       [0] nvme_cancel_request+0x52/0xb0 [nvme_core]
       [1] bt_tags_iter+0x4b/0xa0
       [2] blk_mq_tagset_busy_iter+0x186/0x2c0
       [3] nvme_rdma_teardown_io_queues.part.0+0x73/0xf0 [nvme_rdma]
       [4] nvme_rdma_error_recovery_work+0x41/0xe0 [nvme_rdma]
       [5] process_one_work+0x133/0x380
       [6] worker_thread+0x30d/0x420
       [7] kthread+0xe5/0x110
       [8] ret_from_fork+0x2d/0x50
       [9] ret_from_fork_asm+0x11/0x20

  (The dump CPU is C8; cpu=N inside each record is the producing
  CPU. T came from cpu=8 with stack rooted at blk_mq_timeout_work;
  C came from cpu=14 with stack rooted at
  nvme_rdma_error_recovery_work. Two independent producers, no
  re-entry, captured ~1us apart on the same rq.)

(2) Each chain proceeds through dm-rq's clone-end-io to call
    blk_mq_complete_request() on the dm-mpath orig that owns this
    clone via tio->clone. Our hook at blk_mq_complete_request()
    captured *two* invocations on the same orig, one from each
    upstream forced-completion chain (both age=4743us):

     by-source[6] source=B age=4743us cpu=14 op=DRV_IN nr_bytes=32768 sts=0 ctx=ffff889589967d00 stack(14):
       [0] nvme_rdma_dbg_blk_complete_hook+0xcd/0x130 [nvme_rdma]
       [1] blk_mq_complete_request+0x17/0x70
       [2] end_clone_request+0x1f/0x30
       [3] __blk_mq_end_request+0x60/0x150
       [4] nvme_cancel_request+0x5a/0xb0 [nvme_core]
       [5] bt_tags_iter+0x4b/0xa0
       [6] blk_mq_tagset_busy_iter+0x186/0x2c0
       [7] nvme_rdma_teardown_io_queues.part.0+0x73/0xf0 [nvme_rdma]
       [8] nvme_rdma_error_recovery_work+0x41/0xe0 [nvme_rdma]
       [9] process_one_work+0x133/0x380
       [10] worker_thread+0x30d/0x420
       [11] kthread+0xe5/0x110
       [12] ret_from_fork+0x2d/0x50
       [13] ret_from_fork_asm+0x11/0x20

     ring[4] source=B age=4743us cpu=8 op=DRV_IN nr_bytes=32768 sts=0 ctx=ffff889589967d00 stack(14):
       [0] nvme_rdma_dbg_blk_complete_hook+0xcd/0x130 [nvme_rdma]
       [1] blk_mq_complete_request+0x17/0x70
       [2] end_clone_request+0x1f/0x30
       [3] __blk_mq_end_request+0x60/0x150
       [4] nvme_rdma_timeout+0xff/0x110 [nvme_rdma]
       [5] blk_mq_handle_expired+0x5d/0x90
       [6] bt_iter+0x7e/0x90
       [7] blk_mq_queue_tag_busy_iter+0x2b3/0x590
       [8] blk_mq_timeout_work+0x15f/0x1b0
  (frames [9..13] truncated in our log dump by interleaved console
   output during the dump; the lower frames are the standard
   process_one_work/worker_thread/kthread tail.)

  Two B records on the same orig at the same age=4743us, with two
  *different* upstream chains (frame [4] is nvme_cancel_request in
  the first, nvme_rdma_timeout in the second), is the direct
  observation that the orig has been double-completed.

(3) Each B schedules a per-cpu BLOCK_SOFTIRQ for the orig on its
    mq_ctx->cpu. The first softirq drain runs dm_softirq_done ->
    dm_done -> dm_requeue_original_request -> release_clone_rq,
    which releases this clone via multipath_release_clone ->
    blk_mq_free_request. req_ref_put_and_test sees refcount=1,
    dec to 0, free runs; "R" source captures this (age=4736us,
    7us after the two B's):

     by-source[5] source=R age=4736us cpu=8 op=DRV_IN nr_bytes=0 sts=0 ctx=ffff889589967d00 stack(10):
       [0] nvme_rdma_dbg_release_clone_hook+0x3f/0x120 [nvme_rdma]
       [1] multipath_release_clone+0x1f/0x60
       [2] dm_requeue_original_request+0x61/0xd0
       [3] blk_complete_reqs+0x3a/0x50
       [4] handle_softirqs+0x1ee/0x4a0
       [5] run_ksoftirqd+0x3c/0x70
       [6] smpboot_thread_fn+0xdf/0x1a0
       [7] kthread+0xe5/0x110
       [8] ret_from_fork+0x2d/0x50
       [9] ret_from_fork_asm+0x11/0x20

(4) The second softirq drain on the same orig (queued by the other
    chain's blk_mq_complete_request) runs the same path. tio->clone
    still points to the just-freed clone (dm-rq does not clear it),
    so dm_done -> release_clone_rq -> blk_mq_free_request is called
    again. This is the double-free: refcount is already 0 entering
    req_ref_put_and_test, which trips the WARN_ON_ONCE:

  [ 7122.320733] ------------[ cut here ]------------
  [ 7122.320742] WARNING: CPU: 3 PID: 77382 at block/blk.h:508 \
                 blk_mq_free_request+0x64/0x90
  [ 7122.320811] CPU: 3 PID: 77382 Comm: foed
  [ 7122.320821] RIP: 0010:blk_mq_free_request+0x64/0x90
  [ 7122.320942] Call Trace:
  [ 7122.320952]  ? __warn+0xa3/0x1d0
  [ 7122.320956]  ? blk_mq_free_request+0x64/0x90
  [ 7122.320962]  ? report_bug+0x200/0x230
  [ 7122.320966]  ? handle_bug+0x57/0x90
  [ 7122.320984]  dm_requeue_original_request+0x61/0xd0
  [ 7122.320989]  blk_complete_reqs+0x3a/0x50
  [ 7122.320993]  handle_softirqs+0x1ee/0x4a0
  [ 7122.321003]  __irq_exit_rcu+0x79/0xa0
  [ 7122.321007]  irq_exit_rcu+0xa/0x20
  [ 7122.321011]  common_interrupt+0x43/0xa0
  [ 7122.321014]  asm_common_interrupt+0x22/0x40
  [ 7122.321050] ---[ end trace 0000000000000000 ]---

The premise for the race is that nvme_rdma_teardown_io_queues calls
nvme_quiesce_io_queues -> nvme_sync_io_queues BEFORE
nvme_rdma_cancel_tagset, so after sync returns we expect no
blk_mq_timeout_work can fire concurrent with cancel_tagset. With the
unpatched blk_sync_queue(), that expectation breaks:
nvme_rdma_timeout() returning BLK_EH_RESET_TIMER causes a per-request
blk_add_timer() to re-arm q->timeout from inside the timeout work
that blk_sync_queue is in the middle of draining. After sync's
del_timer_sync (which ran first in the old ordering) and
cancel_work_sync return, q->timeout is once again armed. It fires
shortly afterwards, queueing a new blk_mq_timeout_work that races
nvme_rdma_cancel_tagset on the same rqs.

The race also corrupts wire ordering, since the clone is released
by dm-rq while its SEND/RECV WRs are still outstanding (the forced
completions bypassed end_request's refcount drain gate). A late
recv CQE then lands on the freed slot, dereferences NULL mq_hctx
inside blk_mq_complete_request_remote, and panics the kernel:

  [ 3079.146243] BUG: kernel NULL pointer dereference, address: 0000000000000136
  [ 3079.150802] #PF: supervisor read access in kernel mode
  [ 3079.150811] PGD 0 P4D 0
  [ 3079.150813] Oops: 0000 [#1] SMP
  [ 3079.150819] CPU: 1 PID: 10069 Comm: foed
  [ 3079.150834] RIP: 0010:blk_mq_complete_request_remote+0x15/0x130
  [ 3079.155506] CR2: 0000000000000136
  [ 3079.155516] Call Trace:
  [ 3079.166933]  ? blk_mq_complete_request_remote+0x15/0x130
  [ 3079.166953]  ? nvme_should_fail+0x3e/0x90 [nvme_core]
  [ 3079.166958]  nvme_rdma_end_request+0x55/0x80 [nvme_rdma]
  [ 3079.166962]  nvme_rdma_recv_done+0x1a4/0x5e0 [nvme_rdma]
  [ 3079.185939]  __ib_process_cq+0x79/0x150 [ib_core]
  [ 3079.193425]  ib_poll_handler+0x2c/0xb0 [ib_core]

(CR2=0x136 = offsetof(struct blk_mq_hw_ctx, nr_ctx); the deref is
rq->mq_hctx->nr_ctx with rq->mq_hctx already nulled by
__blk_mq_free_request from the racy double release above.)

We backported your patch to 6.6 (QUEUE_FLAG_NOTIMEOUT is still in
the #define-with-slot-number style there; allocated slot 2). With
the patch applied, both upstream signals went silent across
multiple-hour torture runs:

  - WARN_ON_ONCE at block/blk.h:508 (double-free): 0 occurrences.
  - NULL deref panic at blk_mq_complete_request_remote+0x15 (stale
    CQE on freed slot): 0 occurrences.

In response to Keith's earlier comment about this being an nvme-fc
problem:

  - The deadlock you described (sync called from within timeout work)
    is specific to nvme-fc's call pattern, agreed.

  - The race in blk_sync_queue() is not. nvme-rdma does not sync from
    within timeout work; sync is called from nvme_rdma_error_recovery_work
    (a separate workqueue) under the assumption that after sync returns
    no further timeout work for that queue can run. That assumption is
    what blk_sync_queue's name and existing callers imply, and what
    Mohamed's patch makes true.

  - Any driver returning BLK_EH_RESET_TIMER from .timeout and having a
    teardown path that calls blk_sync_queue is subject to the same
    race. nvme-fc and nvme-rdma both qualify; we expect nvme-tcp does
    too (haven't reproduced there yet).

A driver-local fix for each consumer doesn't address the contract:
blk_sync_queue() should provide what its name says it provides.

Tested-by: Casey Chen <cachen@purestorage.com>

Casey

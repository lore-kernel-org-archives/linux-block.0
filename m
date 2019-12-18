Return-Path: <SRS0=ocaT=2I=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B009C43603
	for <linux-block@archiver.kernel.org>; Wed, 18 Dec 2019 00:24:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EA7BC2176D
	for <linux-block@archiver.kernel.org>; Wed, 18 Dec 2019 00:24:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726227AbfLRAYn (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 17 Dec 2019 19:24:43 -0500
Received: from mail-pf1-f193.google.com ([209.85.210.193]:43175 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726205AbfLRAYn (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 17 Dec 2019 19:24:43 -0500
Received: by mail-pf1-f193.google.com with SMTP id h14so164008pfe.10
        for <linux-block@vger.kernel.org>; Tue, 17 Dec 2019 16:24:43 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ze59zer+GYEGG2Td6k7yLasBF+/gzee4bTZGIMLT6fY=;
        b=ZwoTZjJkPX13A6Wa4tTFspSJfFItnDz1oO9LyWnPAwKkcKgVKj0DfYTsgaJfJIssFq
         6dKn4ymEbF0vTWDsUXlxAlea5qpoGQgx/Bb1NuZQ7a//nrIUrL54wlTb1l2u2n6dPtEI
         wjYt3fXJAJiVa31QffJGupxrJ80svhu5xQMGtM8Qx5NJBN4GQwe+H3I6DniBvQw1Gznr
         Xdo82lMn3azjfAb1T59e3vo/BUAESHARUprY8dKjoZU3PgHlmDmyq9JYtqL11B83oRN3
         rHjtDp6m5XV0ECYPudcS797uUHDhhV8km2Q6+ZNXAt+Z2KJFpFpXnvbPDI8xgrFhW5G/
         xVTQ==
X-Gm-Message-State: APjAAAW07QBU/UHLgfiAxWofWQTM6hURq9XDFHCstt3hjapwChG53+Om
        XUEHTun0p2s2i8KhT2jhWYk=
X-Google-Smtp-Source: APXvYqxnoN9EE7EPKHK5CYTP3DtSOi5upUEocb7hkeEWz1uwSP/Onj8G8/snwDnxI72Pa20uQAcrbw==
X-Received: by 2002:a63:465b:: with SMTP id v27mr142543pgk.257.1576628682764;
        Tue, 17 Dec 2019 16:24:42 -0800 (PST)
Received: from desktop-bart.svl.corp.google.com ([2620:15c:2cd:202:4308:52a3:24b6:2c60])
        by smtp.gmail.com with ESMTPSA id e6sm228889pfh.32.2019.12.17.16.24.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Dec 2019 16:24:41 -0800 (PST)
From:   Bart Van Assche <bvanassche@acm.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Bart Van Assche <bvanassche@acm.org>,
        Christoph Hellwig <hch@infradead.org>,
        Ming Lei <ming.lei@redhat.com>, Hannes Reinecke <hare@suse.com>
Subject: [PATCH] block: Fix a lockdep complaint triggered by request queue flushing
Date:   Tue, 17 Dec 2019 16:24:35 -0800
Message-Id: <20191218002435.48863-1-bvanassche@acm.org>
X-Mailer: git-send-email 2.24.1.735.g03f4e72817-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Avoid that running test nvme/012 from the blktests suite triggers the
following false positive lockdep complaint:

============================================
WARNING: possible recursive locking detected
5.0.0-rc3-xfstests-00015-g1236f7d60242 #841 Not tainted
--------------------------------------------
ksoftirqd/1/16 is trying to acquire lock:
000000000282032e (&(&fq->mq_flush_lock)->rlock){..-.}, at: flush_end_io+0x4e/0x1d0

but task is already holding lock:
00000000cbadcbc2 (&(&fq->mq_flush_lock)->rlock){..-.}, at: flush_end_io+0x4e/0x1d0

other info that might help us debug this:
 Possible unsafe locking scenario:

       CPU0
       ----
  lock(&(&fq->mq_flush_lock)->rlock);
  lock(&(&fq->mq_flush_lock)->rlock);

 *** DEADLOCK ***

 May be due to missing lock nesting notation

1 lock held by ksoftirqd/1/16:
 #0: 00000000cbadcbc2 (&(&fq->mq_flush_lock)->rlock){..-.}, at: flush_end_io+0x4e/0x1d0

stack backtrace:
CPU: 1 PID: 16 Comm: ksoftirqd/1 Not tainted 5.0.0-rc3-xfstests-00015-g1236f7d60242 #841
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
Call Trace:
 dump_stack+0x67/0x90
 __lock_acquire.cold.45+0x2b4/0x313
 lock_acquire+0x98/0x160
 _raw_spin_lock_irqsave+0x3b/0x80
 flush_end_io+0x4e/0x1d0
 blk_mq_complete_request+0x76/0x110
 nvmet_req_complete+0x15/0x110 [nvmet]
 nvmet_bio_done+0x27/0x50 [nvmet]
 blk_update_request+0xd7/0x2d0
 blk_mq_end_request+0x1a/0x100
 blk_flush_complete_seq+0xe5/0x350
 flush_end_io+0x12f/0x1d0
 blk_done_softirq+0x9f/0xd0
 __do_softirq+0xca/0x440
 run_ksoftirqd+0x24/0x50
 smpboot_thread_fn+0x113/0x1e0
 kthread+0x121/0x140
 ret_from_fork+0x3a/0x50

Cc: Christoph Hellwig <hch@infradead.org>
Cc: Ming Lei <ming.lei@redhat.com>
Cc: Hannes Reinecke <hare@suse.com>
Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
 block/blk-flush.c | 5 +++++
 block/blk.h       | 1 +
 2 files changed, 6 insertions(+)

diff --git a/block/blk-flush.c b/block/blk-flush.c
index 1777346baf06..3f977c517960 100644
--- a/block/blk-flush.c
+++ b/block/blk-flush.c
@@ -69,6 +69,7 @@
 #include <linux/blkdev.h>
 #include <linux/gfp.h>
 #include <linux/blk-mq.h>
+#include <linux/lockdep.h>
 
 #include "blk.h"
 #include "blk-mq.h"
@@ -505,6 +506,9 @@ struct blk_flush_queue *blk_alloc_flush_queue(struct request_queue *q,
 	INIT_LIST_HEAD(&fq->flush_queue[1]);
 	INIT_LIST_HEAD(&fq->flush_data_in_flight);
 
+	lockdep_register_key(&fq->key);
+	lockdep_set_class(&fq->mq_flush_lock, &fq->key);
+
 	return fq;
 
  fail_rq:
@@ -519,6 +523,7 @@ void blk_free_flush_queue(struct blk_flush_queue *fq)
 	if (!fq)
 		return;
 
+	lockdep_unregister_key(&fq->key);
 	kfree(fq->flush_rq);
 	kfree(fq);
 }
diff --git a/block/blk.h b/block/blk.h
index 6842f28c033e..0b8884353f6b 100644
--- a/block/blk.h
+++ b/block/blk.h
@@ -30,6 +30,7 @@ struct blk_flush_queue {
 	 * at the same time
 	 */
 	struct request		*orig_rq;
+	struct lock_class_key	key;
 	spinlock_t		mq_flush_lock;
 };
 

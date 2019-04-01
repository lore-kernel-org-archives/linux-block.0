Return-Path: <SRS0=QnQz=SD=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77638C4360F
	for <linux-block@archiver.kernel.org>; Mon,  1 Apr 2019 21:20:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2D2AE206DD
	for <linux-block@archiver.kernel.org>; Mon,  1 Apr 2019 21:20:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727447AbfDAVU3 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 1 Apr 2019 17:20:29 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:35576 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726412AbfDAVU3 (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Mon, 1 Apr 2019 17:20:29 -0400
Received: by mail-pf1-f194.google.com with SMTP id t21so5205442pfe.2;
        Mon, 01 Apr 2019 14:20:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=1r8cG5Bbubh44sas3wFc1Pb54IPJJipwe6rI6YSXQrI=;
        b=dtLNeB+fX1LrNLZ+CKG7O1QkialU8xMky+mDavHjHw35KdgHgRBjeEFIaz+1shPNl3
         BpXXHsqocVH/+3SdRspdOJpH+lkki50zCZg161vaoCvpjQPg4rjro9YrX0d9y9PezZK2
         diB54lO4h99QCJxR92WHWPNur/kostQ6zfU6E5iaqvUh7qWGvocoqNz090mmQCncFx4W
         SUwjuk64ZyCXIBC1gmpDWkiK8rsubP4wPuPqZJ9MPw9R/VQdwVio0NE3MH2vNv0ktbXf
         qQ6FCYFUhPnkGSYV/ElWOQ/KoP/HDls10bK2uyaDphdS81y7wFcZNB1BlR4Pj3ssbcJx
         STqQ==
X-Gm-Message-State: APjAAAVQPZOzhtoGU5sPQUPn21eIcV32iKOGvyu72SkidKnUmJG9vgKp
        PpnKzMy1+HjMMqHMmzVS8+g=
X-Google-Smtp-Source: APXvYqxM5njdiZ4t1OQT4J6UaarAOGmIH+k56Bxlu0vOGTg6xTRQ8NVeXgyCGphkBShvyBHpYKH+Fg==
X-Received: by 2002:a65:5189:: with SMTP id h9mr61930466pgq.304.1554153628363;
        Mon, 01 Apr 2019 14:20:28 -0700 (PDT)
Received: from desktop-bart.svl.corp.google.com ([2620:15c:2cd:203:5cdc:422c:7b28:ebb5])
        by smtp.gmail.com with ESMTPSA id z129sm20178813pfz.103.2019.04.01.14.20.27
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 01 Apr 2019 14:20:27 -0700 (PDT)
From:   Bart Van Assche <bvanassche@acm.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Bart Van Assche <bvanassche@acm.org>,
        Christoph Hellwig <hch@infradead.org>,
        Hannes Reinecke <hare@suse.com>,
        James Smart <james.smart@broadcom.com>,
        Ming Lei <ming.lei@redhat.com>,
        Jianchao Wang <jianchao.w.wang@oracle.com>,
        Dongli Zhang <dongli.zhang@oracle.com>, stable@vger.kernel.org
Subject: [PATCH 2/4] block: Fix a race between request queue freezing and running queues
Date:   Mon,  1 Apr 2019 14:20:12 -0700
Message-Id: <20190401212014.192753-3-bvanassche@acm.org>
X-Mailer: git-send-email 2.20.GIT
In-Reply-To: <20190401212014.192753-1-bvanassche@acm.org>
References: <20190401212014.192753-1-bvanassche@acm.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Any request queue data structure may change while a queue is frozen.
Hence make sure that blk_mq_run_hw_queues() does not access any hw
queue while a request queue is frozen.

After blk_cleanup_queue() has marked a queue as dead it is no longer
safe to access the hardware queue data structures. This patch avoids
that blk_mq_run_hw_queues() crashes when called during or after
blk_cleanup_queue() has freed the hardware queues. This patch is a
variant of a patch posted by Hannes Reinecke ("[PATCH] block: don't
call blk_mq_run_hw_queues() for dead or dying queues "). This patch
is similar in nature to commit c246e80d8673 ("block: Avoid that
request_fn is invoked on a dead queue"; v3.8). An example of a crash
that is fixed by this patch:

BUG: unable to handle kernel NULL pointer dereference at (null)
IP: [<ffffffff8135a10b>] sbitmap_any_bit_set+0xb/0x30
Call Trace:
 [<ffffffff81303a88>] blk_mq_run_hw_queues+0x48/0x90
 [<ffffffff813053cc>] blk_mq_requeue_work+0x10c/0x120
 [<ffffffff81098cb4>] process_one_work+0x154/0x410
 [<ffffffff81099896>] worker_thread+0x116/0x4a0
 [<ffffffff8109edb9>] kthread+0xc9/0xe0
 [<ffffffff81619b05>] ret_from_fork+0x55/0x80

Cc: Christoph Hellwig <hch@infradead.org>
Cc: Hannes Reinecke <hare@suse.com>
Cc: James Smart <james.smart@broadcom.com>
Cc: Ming Lei <ming.lei@redhat.com>
Cc: Jianchao Wang <jianchao.w.wang@oracle.com>
Cc: Dongli Zhang <dongli.zhang@oracle.com>
Cc: <stable@vger.kernel.org>
Fixes: a063057d7c73 ("block: Fix a race between request queue removal and the block cgroup controller") # v4.17.
Reported-by: James Smart <james.smart@broadcom.com>
Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
 block/blk-mq.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index 3ff3d7b49969..652d0c6d5945 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -1499,12 +1499,20 @@ void blk_mq_run_hw_queues(struct request_queue *q, bool async)
 	struct blk_mq_hw_ctx *hctx;
 	int i;
 
+	/*
+	 * Do not run any hardware queues if the queue is frozen or if a
+	 * concurrent blk_cleanup_queue() call is removing any data
+	 * structures used by this function.
+	 */
+	if (!percpu_ref_tryget(&q->q_usage_counter))
+		return;
 	queue_for_each_hw_ctx(q, hctx, i) {
 		if (blk_mq_hctx_stopped(hctx))
 			continue;
 
 		blk_mq_run_hw_queue(hctx, async);
 	}
+	percpu_ref_put(&q->q_usage_counter);
 }
 EXPORT_SYMBOL(blk_mq_run_hw_queues);
 
-- 
2.21.0.196.g041f5ea1cf98


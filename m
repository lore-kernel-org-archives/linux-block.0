Return-Path: <SRS0=N1jC=SE=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E572C10F0B
	for <linux-block@archiver.kernel.org>; Tue,  2 Apr 2019 22:32:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EB2DE20857
	for <linux-block@archiver.kernel.org>; Tue,  2 Apr 2019 22:32:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726078AbfDBWcN (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 2 Apr 2019 18:32:13 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:44235 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726071AbfDBWcM (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 2 Apr 2019 18:32:12 -0400
Received: by mail-pg1-f194.google.com with SMTP id i2so7238500pgj.11;
        Tue, 02 Apr 2019 15:32:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=rQcabysotoQSPcMHyH9q0nwOwWOcOSfXS/4rap+nXrs=;
        b=M8gUe2ac8PFkB3V/3JRu7d8nYGFVJ0YqCR9Ev6DKahyRMXAz04jab5Hxjrgj7WW2wv
         ahf+Kq1KYqthjMSNpz6B/x9U+Udt3Ce50BA/XElsfniP7ork9M7OyacaRvt5p1R3DNca
         qTwvPVImrLsVNPQeH+y0hPz5EQeb/n6sIeunDvA1ddVUQUgt05q7URbMb38CkpT8M4Yy
         aCCbLsZ9YI0tvt/bYzvVzZ8lPZVWUdAz7WXViIMV5d+oHZeCJhSSYd+B1PfbaxSRdtkQ
         +gXyHgjrztVtPxPUe57Bh8WCx2nJAqHC4VN6TP52V9sRYUI9bBhrYsICaFxFHOt1CkMx
         DqjQ==
X-Gm-Message-State: APjAAAV80fyGA3oO09TdsAkFWLDtWIGzCjKVbev/vkwWKASS8TLXU5dU
        JKNx8lIupdQc2QM3M53MWn8hl2DCNpA=
X-Google-Smtp-Source: APXvYqyyPfJ2z/EoG6k6R0qGcexTkZiG3zZABGFs9TTidFMh3dBo5YeBS3FzAg+iD95Gy0TXTIG/Cg==
X-Received: by 2002:a63:7885:: with SMTP id t127mr18736075pgc.338.1554244331994;
        Tue, 02 Apr 2019 15:32:11 -0700 (PDT)
Received: from desktop-bart.svl.corp.google.com ([2620:15c:2cd:203:5cdc:422c:7b28:ebb5])
        by smtp.gmail.com with ESMTPSA id d8sm9455366pgv.34.2019.04.02.15.32.10
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 02 Apr 2019 15:32:11 -0700 (PDT)
From:   Bart Van Assche <bvanassche@acm.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Bart Van Assche <bvanassche@acm.org>,
        Christoph Hellwig <hch@infradead.org>,
        Hannes Reinecke <hare@suse.com>,
        James Smart <james.smart@broadcom.com>,
        Ming Lei <ming.lei@redhat.com>,
        Jianchao Wang <jianchao.w.wang@oracle.com>,
        Keith Busch <keith.busch@intel.com>,
        Dongli Zhang <dongli.zhang@oracle.com>, stable@vger.kernel.org
Subject: [PATCH] block: Fix a race between tag iteration and hardware queue changes
Date:   Tue,  2 Apr 2019 15:32:02 -0700
Message-Id: <20190402223202.30752-1-bvanassche@acm.org>
X-Mailer: git-send-email 2.20.GIT
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Since the callback function called by blk_mq_queue_tag_busy_iter()
may sleep calling synchronize_rcu() from __blk_mq_update_nr_hw_queues()
is not sufficient to wait until blk_mq_queue_tag_busy_iter() has
finished. Instead of making __blk_mq_update_nr_hw_queues() wait until
q->q_usage_counter == 0 is globally visible, do not iterate over tags
if the request queue is frozen.

Cc: Christoph Hellwig <hch@infradead.org>
Cc: Hannes Reinecke <hare@suse.com>
Cc: James Smart <james.smart@broadcom.com>
Cc: Ming Lei <ming.lei@redhat.com>
Cc: Jianchao Wang <jianchao.w.wang@oracle.com>
Cc: Keith Busch <keith.busch@intel.com>
Cc: Dongli Zhang <dongli.zhang@oracle.com>
Cc: <stable@vger.kernel.org>
Fixes: 530ca2c9bd69 ("blk-mq: Allow blocking queue tag iter callbacks") # v4.19.
Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
 block/blk-mq-tag.c | 10 +++++-----
 block/blk-mq.c     |  5 +----
 2 files changed, 6 insertions(+), 9 deletions(-)

diff --git a/block/blk-mq-tag.c b/block/blk-mq-tag.c
index a4931fc7be8a..89f479634b4d 100644
--- a/block/blk-mq-tag.c
+++ b/block/blk-mq-tag.c
@@ -383,14 +383,13 @@ void blk_mq_queue_tag_busy_iter(struct request_queue *q, busy_iter_fn *fn,
 
 	/*
 	 * __blk_mq_update_nr_hw_queues() updates nr_hw_queues and queue_hw_ctx
-	 * while the queue is frozen. So we can use q_usage_counter to avoid
-	 * racing with it. __blk_mq_update_nr_hw_queues() uses
-	 * synchronize_rcu() to ensure this function left the critical section
-	 * below.
+	 * while the queue is frozen. Hold q_usage_counter to serialize
+	 * __blk_mq_update_nr_hw_queues() against this function.
 	 */
 	if (!percpu_ref_tryget(&q->q_usage_counter))
 		return;
-
+	if (atomic_read(&q->mq_freeze_depth))
+		goto out;
 	queue_for_each_hw_ctx(q, hctx, i) {
 		struct blk_mq_tags *tags = hctx->tags;
 
@@ -405,6 +404,7 @@ void blk_mq_queue_tag_busy_iter(struct request_queue *q, busy_iter_fn *fn,
 			bt_for_each(hctx, &tags->breserved_tags, fn, priv, true);
 		bt_for_each(hctx, &tags->bitmap_tags, fn, priv, false);
 	}
+out:
 	blk_queue_exit(q);
 }
 
diff --git a/block/blk-mq.c b/block/blk-mq.c
index 652d0c6d5945..f9fc1536408d 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -3226,10 +3226,7 @@ static void __blk_mq_update_nr_hw_queues(struct blk_mq_tag_set *set,
 
 	list_for_each_entry(q, &set->tag_list, tag_set_list)
 		blk_mq_freeze_queue(q);
-	/*
-	 * Sync with blk_mq_queue_tag_busy_iter.
-	 */
-	synchronize_rcu();
+
 	/*
 	 * Switch IO scheduler to 'none', cleaning up the data associated
 	 * with the previous scheduler. We will switch back once we are done
-- 
2.21.0.196.g041f5ea1cf98


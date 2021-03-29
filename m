Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AEA12C433DB
	for <linux-block@archiver.kernel.org>; Mon, 29 Mar 2021 02:01:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6C2A861927
	for <linux-block@archiver.kernel.org>; Mon, 29 Mar 2021 02:01:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231408AbhC2CBR (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sun, 28 Mar 2021 22:01:17 -0400
Received: from mail-pg1-f173.google.com ([209.85.215.173]:33493 "EHLO
        mail-pg1-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230458AbhC2CAt (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sun, 28 Mar 2021 22:00:49 -0400
Received: by mail-pg1-f173.google.com with SMTP id r17so8479763pgi.0
        for <linux-block@vger.kernel.org>; Sun, 28 Mar 2021 19:00:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=v63PUrNCVhsN9T+d4Vtkdw9Nq0HYnJrmTuXehSJt5JI=;
        b=KeDilxyDlIO8O6b5TfJ39eTR8xjHhMS5Knailbr2EwCQ3JEsENATJH07hRWDsZ1EbF
         FGotPb/Dz9ThZs050Lq6BGZXcOiN/W0cPhu6PgRoY/DXE1LB1Lm7Ylxe4f8tDmDBJULu
         B9eIfyhewwZKQo2tOFyW81IwG/uIPW9ra63Y7ESX23OZe2ZGj0pWcCaRzoNFsct2PXV0
         XninusVSxA39StVxu6eHE+GFQJGdG7QeJ4lqsWuJOpP/Xkse5+oNZRTdbbqCMItsVmw0
         uAzf3NL6R6DmoiP1qIHcDJxkF0H+o1/wBU+nVpVh29h9w/hi+8JJm3tXDV3SC55Jw3SN
         CazA==
X-Gm-Message-State: AOAM530kg61i6MM/7NE5rA997mnrIWU7AcWwK29M4QWDJ8UgGSYr9cQP
        J4PxgiM+97TDJWB4s0cT7Aw=
X-Google-Smtp-Source: ABdhPJzQh7veD8tEJnHs8ql4N9wENpQmaMAlEXwrnZzpg/EPPZ/aQvOCYbGQwuuAQJq5u2AZl2wfSg==
X-Received: by 2002:a63:5c04:: with SMTP id q4mr21839213pgb.369.1616983238097;
        Sun, 28 Mar 2021 19:00:38 -0700 (PDT)
Received: from asus.hsd1.ca.comcast.net ([2601:647:4000:d7:7123:9470:fec5:1a3a])
        by smtp.gmail.com with ESMTPSA id x125sm15784979pfd.124.2021.03.28.19.00.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 28 Mar 2021 19:00:37 -0700 (PDT)
From:   Bart Van Assche <bvanassche@acm.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Bart Van Assche <bvanassche@acm.org>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        Ming Lei <ming.lei@redhat.com>, Hannes Reinecke <hare@suse.de>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        John Garry <john.garry@huawei.com>,
        Khazhy Kumykov <khazhy@google.com>,
        Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Subject: [PATCH v4 2/3] blk-mq: Introduce atomic variants of the tag iteration functions
Date:   Sun, 28 Mar 2021 19:00:27 -0700
Message-Id: <20210329020028.18241-3-bvanassche@acm.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210329020028.18241-1-bvanassche@acm.org>
References: <20210329020028.18241-1-bvanassche@acm.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Since in the next patch knowledge is required of whether or not it is
allowed to sleep inside the tag iteration functions, pass this context
information to the tag iteration functions. I have reviewed all callers of
tag iteration functions to verify these annotations by starting from the
output of the following grep command:

    git grep -nHE 'blk_mq_(all_tag|tagset_busy)_iter'

My conclusions from that analysis are as follows:
- Sleeping is allowed in the blk-mq-debugfs code that iterates over tags.
- Since the blk_mq_tagset_busy_iter() calls in the mtip32xx driver are
  preceded by a function that sleeps (blk_mq_quiesce_queue()), sleeping is
  safe in the context of the blk_mq_tagset_busy_iter() calls.
- The same reasoning also applies to the nbd driver.
- All blk_mq_tagset_busy_iter() calls in the NVMe drivers are followed by a
  call to a function that sleeps so sleeping inside blk_mq_tagset_busy_iter()
  when called from the NVMe driver is fine.
- scsi_host_busy(), scsi_host_complete_all_commands() and
  scsi_host_busy_iter() are used by multiple SCSI LLDs so analyzing whether
  or not these functions may sleep is hard. Instead of performing that
  analysis, make it safe to call these functions from atomic context.

Cc: Martin K. Petersen <martin.petersen@oracle.com>
Cc: Christoph Hellwig <hch@lst.de>
Cc: Ming Lei <ming.lei@redhat.com>
Cc: Hannes Reinecke <hare@suse.de>
Cc: Johannes Thumshirn <johannes.thumshirn@wdc.com>
Cc: John Garry <john.garry@huawei.com>
Cc: Khazhy Kumykov <khazhy@google.com>
Cc: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
 block/blk-mq-tag.c        | 38 +++++++++++++++++++++++++++++++++-----
 block/blk-mq-tag.h        |  2 +-
 block/blk-mq.c            |  2 +-
 drivers/scsi/hosts.c      | 16 ++++++++--------
 drivers/scsi/ufs/ufshcd.c |  4 ++--
 include/linux/blk-mq.h    |  2 ++
 6 files changed, 47 insertions(+), 17 deletions(-)

diff --git a/block/blk-mq-tag.c b/block/blk-mq-tag.c
index 9c92053e704d..3abfa4897ea2 100644
--- a/block/blk-mq-tag.c
+++ b/block/blk-mq-tag.c
@@ -322,18 +322,19 @@ static void __blk_mq_all_tag_iter(struct blk_mq_tags *tags,
 }
 
 /**
- * blk_mq_all_tag_iter - iterate over all requests in a tag map
+ * blk_mq_all_tag_iter_atomic - iterate over all requests in a tag map
  * @tags:	Tag map to iterate over.
  * @fn:		Pointer to the function that will be called for each
  *		request. @fn will be called as follows: @fn(rq, @priv,
  *		reserved) where rq is a pointer to a request. 'reserved'
  *		indicates whether or not @rq is a reserved request. Return
- *		true to continue iterating tags, false to stop.
+ *		true to continue iterating tags, false to stop. Must not
+ *		sleep.
  * @priv:	Will be passed as second argument to @fn.
  *
- * Caller has to pass the tag map from which requests are allocated.
+ * Does not sleep.
  */
-void blk_mq_all_tag_iter(struct blk_mq_tags *tags, busy_tag_iter_fn *fn,
+void blk_mq_all_tag_iter_atomic(struct blk_mq_tags *tags, busy_tag_iter_fn *fn,
 		void *priv)
 {
 	__blk_mq_all_tag_iter(tags, fn, priv, BT_TAG_ITER_STATIC_RQS);
@@ -348,6 +349,8 @@ void blk_mq_all_tag_iter(struct blk_mq_tags *tags, busy_tag_iter_fn *fn,
  *		indicates whether or not @rq is a reserved request. Return
  *		true to continue iterating tags, false to stop.
  * @priv:	Will be passed as second argument to @fn.
+ *
+ * May sleep.
  */
 void blk_mq_tagset_busy_iter(struct blk_mq_tag_set *tagset,
 		busy_tag_iter_fn *fn, void *priv)
@@ -362,6 +365,31 @@ void blk_mq_tagset_busy_iter(struct blk_mq_tag_set *tagset,
 }
 EXPORT_SYMBOL(blk_mq_tagset_busy_iter);
 
+/**
+ * blk_mq_tagset_busy_iter_atomic - iterate over all started requests in a tag set
+ * @tagset:	Tag set to iterate over.
+ * @fn:		Pointer to the function that will be called for each started
+ *		request. @fn will be called as follows: @fn(rq, @priv,
+ *		reserved) where rq is a pointer to a request. 'reserved'
+ *		indicates whether or not @rq is a reserved request. Return
+ *		true to continue iterating tags, false to stop. Must not sleep.
+ * @priv:	Will be passed as second argument to @fn.
+ *
+ * Does not sleep.
+ */
+void blk_mq_tagset_busy_iter_atomic(struct blk_mq_tag_set *tagset,
+		busy_tag_iter_fn *fn, void *priv)
+{
+	int i;
+
+	for (i = 0; i < tagset->nr_hw_queues; i++) {
+		if (tagset->tags && tagset->tags[i])
+			__blk_mq_all_tag_iter(tagset->tags[i], fn, priv,
+					      BT_TAG_ITER_STARTED);
+	}
+}
+EXPORT_SYMBOL(blk_mq_tagset_busy_iter_atomic);
+
 static bool blk_mq_tagset_count_completed_rqs(struct request *rq,
 		void *data, bool reserved)
 {
@@ -384,7 +412,7 @@ void blk_mq_tagset_wait_completed_request(struct blk_mq_tag_set *tagset)
 	while (true) {
 		unsigned count = 0;
 
-		blk_mq_tagset_busy_iter(tagset,
+		blk_mq_tagset_busy_iter_atomic(tagset,
 				blk_mq_tagset_count_completed_rqs, &count);
 		if (!count)
 			break;
diff --git a/block/blk-mq-tag.h b/block/blk-mq-tag.h
index 7d3e6b333a4a..0290c308ece9 100644
--- a/block/blk-mq-tag.h
+++ b/block/blk-mq-tag.h
@@ -43,7 +43,7 @@ extern void blk_mq_tag_resize_shared_sbitmap(struct blk_mq_tag_set *set,
 extern void blk_mq_tag_wakeup_all(struct blk_mq_tags *tags, bool);
 void blk_mq_queue_tag_busy_iter(struct request_queue *q, busy_iter_fn *fn,
 		void *priv);
-void blk_mq_all_tag_iter(struct blk_mq_tags *tags, busy_tag_iter_fn *fn,
+void blk_mq_all_tag_iter_atomic(struct blk_mq_tags *tags, busy_tag_iter_fn *fn,
 		void *priv);
 
 static inline struct sbq_wait_state *bt_wait_ptr(struct sbitmap_queue *bt,
diff --git a/block/blk-mq.c b/block/blk-mq.c
index d4d7c1caa439..5b170faa6318 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -2483,7 +2483,7 @@ static bool blk_mq_hctx_has_requests(struct blk_mq_hw_ctx *hctx)
 		.hctx	= hctx,
 	};
 
-	blk_mq_all_tag_iter(tags, blk_mq_has_request, &data);
+	blk_mq_all_tag_iter_atomic(tags, blk_mq_has_request, &data);
 	return data.has_rq;
 }
 
diff --git a/drivers/scsi/hosts.c b/drivers/scsi/hosts.c
index 2f162603876f..f09e1520a241 100644
--- a/drivers/scsi/hosts.c
+++ b/drivers/scsi/hosts.c
@@ -578,8 +578,8 @@ int scsi_host_busy(struct Scsi_Host *shost)
 {
 	int cnt = 0;
 
-	blk_mq_tagset_busy_iter(&shost->tag_set,
-				scsi_host_check_in_flight, &cnt);
+	blk_mq_tagset_busy_iter_atomic(&shost->tag_set,
+				       scsi_host_check_in_flight, &cnt);
 	return cnt;
 }
 EXPORT_SYMBOL(scsi_host_busy);
@@ -677,8 +677,8 @@ static bool complete_all_cmds_iter(struct request *rq, void *data, bool rsvd)
  */
 void scsi_host_complete_all_commands(struct Scsi_Host *shost, int status)
 {
-	blk_mq_tagset_busy_iter(&shost->tag_set, complete_all_cmds_iter,
-				&status);
+	blk_mq_tagset_busy_iter_atomic(&shost->tag_set, complete_all_cmds_iter,
+				       &status);
 }
 EXPORT_SYMBOL_GPL(scsi_host_complete_all_commands);
 
@@ -699,11 +699,11 @@ static bool __scsi_host_busy_iter_fn(struct request *req, void *priv,
 /**
  * scsi_host_busy_iter - Iterate over all busy commands
  * @shost:	Pointer to Scsi_Host.
- * @fn:		Function to call on each busy command
+ * @fn:		Function to call on each busy command. Must not sleep.
  * @priv:	Data pointer passed to @fn
  *
  * If locking against concurrent command completions is required
- * ithas to be provided by the caller
+ * it has to be provided by the caller.
  **/
 void scsi_host_busy_iter(struct Scsi_Host *shost,
 			 bool (*fn)(struct scsi_cmnd *, void *, bool),
@@ -714,7 +714,7 @@ void scsi_host_busy_iter(struct Scsi_Host *shost,
 		.priv = priv,
 	};
 
-	blk_mq_tagset_busy_iter(&shost->tag_set, __scsi_host_busy_iter_fn,
-				&iter_data);
+	blk_mq_tagset_busy_iter_atomic(&shost->tag_set,
+				       __scsi_host_busy_iter_fn, &iter_data);
 }
 EXPORT_SYMBOL_GPL(scsi_host_busy_iter);
diff --git a/drivers/scsi/ufs/ufshcd.c b/drivers/scsi/ufs/ufshcd.c
index c86760788c72..6d2f8f18e2a3 100644
--- a/drivers/scsi/ufs/ufshcd.c
+++ b/drivers/scsi/ufs/ufshcd.c
@@ -1380,7 +1380,7 @@ static bool ufshcd_any_tag_in_use(struct ufs_hba *hba)
 	struct request_queue *q = hba->cmd_queue;
 	int busy = 0;
 
-	blk_mq_tagset_busy_iter(q->tag_set, ufshcd_is_busy, &busy);
+	blk_mq_tagset_busy_iter_atomic(q->tag_set, ufshcd_is_busy, &busy);
 	return busy;
 }
 
@@ -6269,7 +6269,7 @@ static irqreturn_t ufshcd_tmc_handler(struct ufs_hba *hba)
 		.pending = ufshcd_readl(hba, REG_UTP_TASK_REQ_DOOR_BELL),
 	};
 
-	blk_mq_tagset_busy_iter(q->tag_set, ufshcd_compl_tm, &ci);
+	blk_mq_tagset_busy_iter_atomic(q->tag_set, ufshcd_compl_tm, &ci);
 	return ci.ncpl ? IRQ_HANDLED : IRQ_NONE;
 }
 
diff --git a/include/linux/blk-mq.h b/include/linux/blk-mq.h
index 2c473c9b8990..dfa0114a49fd 100644
--- a/include/linux/blk-mq.h
+++ b/include/linux/blk-mq.h
@@ -526,6 +526,8 @@ void blk_mq_run_hw_queues(struct request_queue *q, bool async);
 void blk_mq_delay_run_hw_queues(struct request_queue *q, unsigned long msecs);
 void blk_mq_tagset_busy_iter(struct blk_mq_tag_set *tagset,
 		busy_tag_iter_fn *fn, void *priv);
+void blk_mq_tagset_busy_iter_atomic(struct blk_mq_tag_set *tagset,
+		busy_tag_iter_fn *fn, void *priv);
 void blk_mq_tagset_wait_completed_request(struct blk_mq_tag_set *tagset);
 void blk_mq_freeze_queue(struct request_queue *q);
 void blk_mq_unfreeze_queue(struct request_queue *q);

Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49657C433ED
	for <linux-block@archiver.kernel.org>; Wed, 21 Apr 2021 00:02:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 25A7F6141A
	for <linux-block@archiver.kernel.org>; Wed, 21 Apr 2021 00:02:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234481AbhDUADV (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 20 Apr 2021 20:03:21 -0400
Received: from mail-pf1-f169.google.com ([209.85.210.169]:37709 "EHLO
        mail-pf1-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233992AbhDUADT (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 20 Apr 2021 20:03:19 -0400
Received: by mail-pf1-f169.google.com with SMTP id y62so3099782pfg.4
        for <linux-block@vger.kernel.org>; Tue, 20 Apr 2021 17:02:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=JF0Me0nlvU6WC5znjax/GIqi38ZLViOnIk+0MVduJIQ=;
        b=XM7F3jteBftPlt5jyMtkAqXhimvxNm2+sX+45FWDyjAIjRu+mCWA90O2gpL83YdTbq
         rcNf4ZRaDKE2rk08gZT+gChU1PkR5G45dSYc34XQGY86kw72an0tYB+xAQq5FU++pLnT
         U0X/TJWFWPLGqFMDxdXUsLhYMsc9aKuA5Mjyd/3EzT5vIhg99pGsIRR1L6DaKkOp+pcu
         nHgrRKVTYQHRg6APc3/6hcU9o15aCrsGSNpcOG0MSkW9EMsXUmXmnaDeBX0KFUkXUc9+
         McuvaDlWbDSs3mB41XeK7JoQU7pdZlNfbkYUiLqjKkmkYvd8Sl7Z6XH9pIC8dTuNt2Sp
         V7kw==
X-Gm-Message-State: AOAM530D6gxStE/Q0p4fGra2UD2TI4jUESWN73NyYycYlhRN3vdvIxIy
        HgOqiyecpjZVD5SuIdbrDjM=
X-Google-Smtp-Source: ABdhPJwBCQc50GTJvpeVB3/IDJaZxC2sSz4jviNfIcYUrKetOTrqq8aIDBRmxsa/ui9pPmJJpMzbRg==
X-Received: by 2002:a63:4513:: with SMTP id s19mr18844193pga.34.1618963365825;
        Tue, 20 Apr 2021 17:02:45 -0700 (PDT)
Received: from asus.hsd1.ca.comcast.net ([2601:647:4000:d7:6cb:4566:9005:c2af])
        by smtp.gmail.com with ESMTPSA id 33sm149560pgq.21.2021.04.20.17.02.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Apr 2021 17:02:45 -0700 (PDT)
From:   Bart Van Assche <bvanassche@acm.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Daniel Wagner <dwagner@suse.de>,
        Bart Van Assche <bvanassche@acm.org>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        Khazhismel Kumykov <khazhy@google.com>,
        Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
        Ming Lei <ming.lei@redhat.com>, Hannes Reinecke <hare@suse.de>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        John Garry <john.garry@huawei.com>
Subject: [PATCH v7 2/5] blk-mq: Introduce atomic variants of blk_mq_(all_tag|tagset_busy)_iter
Date:   Tue, 20 Apr 2021 17:02:32 -0700
Message-Id: <20210421000235.2028-3-bvanassche@acm.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210421000235.2028-1-bvanassche@acm.org>
References: <20210421000235.2028-1-bvanassche@acm.org>
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
- The nbd_clear_req() callback that is passed to blk_mq_tagset_busy_iter()
  by the nbd driver may sleep.
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

Reviewed-by: Christoph Hellwig <hch@lst.de>
Acked-by: Martin K. Petersen <martin.petersen@oracle.com>
Reviewed-by: Khazhismel Kumykov <khazhy@google.com>
Reviewed-by: Daniel Wagner <dwagner@suse.de>
Tested-by: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Cc: Ming Lei <ming.lei@redhat.com>
Cc: Hannes Reinecke <hare@suse.de>
Cc: Johannes Thumshirn <johannes.thumshirn@wdc.com>
Cc: John Garry <john.garry@huawei.com>
Cc: Khazhy Kumykov <khazhy@google.com>
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
index 2a37731e8244..d8eaa38a1bd1 100644
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
index 927189a55575..79c01b1f885c 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -2484,7 +2484,7 @@ static bool blk_mq_hctx_has_requests(struct blk_mq_hw_ctx *hctx)
 		.hctx	= hctx,
 	};
 
-	blk_mq_all_tag_iter(tags, blk_mq_has_request, &data);
+	blk_mq_all_tag_iter_atomic(tags, blk_mq_has_request, &data);
 	return data.has_rq;
 }
 
diff --git a/drivers/scsi/hosts.c b/drivers/scsi/hosts.c
index 697c09ef259b..f8863aa88642 100644
--- a/drivers/scsi/hosts.c
+++ b/drivers/scsi/hosts.c
@@ -573,8 +573,8 @@ int scsi_host_busy(struct Scsi_Host *shost)
 {
 	int cnt = 0;
 
-	blk_mq_tagset_busy_iter(&shost->tag_set,
-				scsi_host_check_in_flight, &cnt);
+	blk_mq_tagset_busy_iter_atomic(&shost->tag_set,
+				       scsi_host_check_in_flight, &cnt);
 	return cnt;
 }
 EXPORT_SYMBOL(scsi_host_busy);
@@ -672,8 +672,8 @@ static bool complete_all_cmds_iter(struct request *rq, void *data, bool rsvd)
  */
 void scsi_host_complete_all_commands(struct Scsi_Host *shost, int status)
 {
-	blk_mq_tagset_busy_iter(&shost->tag_set, complete_all_cmds_iter,
-				&status);
+	blk_mq_tagset_busy_iter_atomic(&shost->tag_set, complete_all_cmds_iter,
+				       &status);
 }
 EXPORT_SYMBOL_GPL(scsi_host_complete_all_commands);
 
@@ -694,11 +694,11 @@ static bool __scsi_host_busy_iter_fn(struct request *req, void *priv,
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
@@ -709,7 +709,7 @@ void scsi_host_busy_iter(struct Scsi_Host *shost,
 		.priv = priv,
 	};
 
-	blk_mq_tagset_busy_iter(&shost->tag_set, __scsi_host_busy_iter_fn,
-				&iter_data);
+	blk_mq_tagset_busy_iter_atomic(&shost->tag_set,
+				       __scsi_host_busy_iter_fn, &iter_data);
 }
 EXPORT_SYMBOL_GPL(scsi_host_busy_iter);
diff --git a/drivers/scsi/ufs/ufshcd.c b/drivers/scsi/ufs/ufshcd.c
index d3d05e997c13..d6975c501e44 100644
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

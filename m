Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 722F3C43334
	for <linux-block@archiver.kernel.org>; Thu, 14 Jul 2022 18:09:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240486AbiGNSJf (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 14 Jul 2022 14:09:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240586AbiGNSJS (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 14 Jul 2022 14:09:18 -0400
Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C84B813F21
        for <linux-block@vger.kernel.org>; Thu, 14 Jul 2022 11:09:08 -0700 (PDT)
Received: by mail-pj1-f45.google.com with SMTP id o15so3575728pjh.1
        for <linux-block@vger.kernel.org>; Thu, 14 Jul 2022 11:09:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=aeMYSY8iDviRZiTG9cEA+YD61nSxKsTjjgptB5cDRxU=;
        b=pQc4HMo2E9x2edl8elbSCxD42TkYg2K7YXhQGkeXSKdX/SwJJlmmq5qdApbv31+TN2
         jeNIk5bLMY6mWsVb14Rt35+Va9idvBBQZ+xyuy3yxuzZ8Mx4495p8jiEN+9ZzWfy7oUh
         dV/hkc5pNUZ9nTw69lbkjtNZMPjDp6p5DvMmrBWJO/0adpjtsa+bwx0osditwxgbS4UK
         3wRLvTjHGUehRCZPMec2ngNGUuNXNwGQnDg2u2iqYRI5HWSX/dzik8Vcw/RIrUn/67bG
         stkY87D7gD0b/Fbueh1tEu7ZvsERfalPlkFIeoA/Bw7gwZzEQW3uVk85XrodL2TEKtRs
         Z7mA==
X-Gm-Message-State: AJIora/ka+gWSdygqMmDs1TNC3pFXz2ig2Zu2+qaxNmBuvrlwfsEd2R/
        ++v7gUqioSyNON8NBClu+vY=
X-Google-Smtp-Source: AGRyM1tE5KjNy63uV9NLJZ2/VA5Qfw078BPa1/ILjFsm6sK9TeVmatKx+BUB/yhYcEVZttr1VH3W7Q==
X-Received: by 2002:a17:90b:3648:b0:1ef:7c45:62cb with SMTP id nh8-20020a17090b364800b001ef7c4562cbmr17888281pjb.132.1657822147964;
        Thu, 14 Jul 2022 11:09:07 -0700 (PDT)
Received: from bvanassche-linux.mtv.corp.google.com ([2620:15c:211:201:9fab:70d1:f0e7:922b])
        by smtp.gmail.com with ESMTPSA id m5-20020a170902db0500b0016bebb0cb96sm1781846plx.266.2022.07.14.11.09.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Jul 2022 11:09:07 -0700 (PDT)
From:   Bart Van Assche <bvanassche@acm.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Jaegeuk Kim <jaegeuk@kernel.org>,
        Bart Van Assche <bvanassche@acm.org>,
        Mike Christie <michael.christie@oracle.com>,
        Theodore Ts'o <tytso@mit.edu>
Subject: [PATCH v3 56/63] fs/jbd2: Fix the documentation of the jbd2_write_superblock() callers
Date:   Thu, 14 Jul 2022 11:07:22 -0700
Message-Id: <20220714180729.1065367-57-bvanassche@acm.org>
X-Mailer: git-send-email 2.37.0.170.g444d1eabd0-goog
In-Reply-To: <20220714180729.1065367-1-bvanassche@acm.org>
References: <20220714180729.1065367-1-bvanassche@acm.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Commit 2a222ca992c3 ("fs: have submit_bh users pass in op and flags
separately") renamed the jbd2_write_superblock() 'write_op' argument into
'write_flags'. Propagate this change to the jbd2_write_superblock()
callers. Additionally, change the type of 'write_flags' into blk_opf_t.

Cc: Mike Christie <michael.christie@oracle.com>
Cc: Theodore Ts'o <tytso@mit.edu>
Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
 fs/jbd2/journal.c           | 15 ++++++++-------
 include/linux/jbd2.h        |  2 +-
 include/trace/events/jbd2.h | 12 ++++++------
 3 files changed, 15 insertions(+), 14 deletions(-)

diff --git a/fs/jbd2/journal.c b/fs/jbd2/journal.c
index 07e6aaf7e213..2a1b9da7c3e3 100644
--- a/fs/jbd2/journal.c
+++ b/fs/jbd2/journal.c
@@ -1604,7 +1604,7 @@ static int journal_reset(journal_t *journal)
  * This function expects that the caller will have locked the journal
  * buffer head, and will return with it unlocked
  */
-static int jbd2_write_superblock(journal_t *journal, int write_flags)
+static int jbd2_write_superblock(journal_t *journal, blk_opf_t write_flags)
 {
 	struct buffer_head *bh = journal->j_sb_buffer;
 	journal_superblock_t *sb = journal->j_superblock;
@@ -1661,13 +1661,14 @@ static int jbd2_write_superblock(journal_t *journal, int write_flags)
  * @journal: The journal to update.
  * @tail_tid: TID of the new transaction at the tail of the log
  * @tail_block: The first block of the transaction at the tail of the log
- * @write_op: With which operation should we write the journal sb
+ * @write_flags: Flags for the journal sb write operation
  *
  * Update a journal's superblock information about log tail and write it to
  * disk, waiting for the IO to complete.
  */
 int jbd2_journal_update_sb_log_tail(journal_t *journal, tid_t tail_tid,
-				     unsigned long tail_block, int write_op)
+				    unsigned long tail_block,
+				    blk_opf_t write_flags)
 {
 	journal_superblock_t *sb = journal->j_superblock;
 	int ret;
@@ -1687,7 +1688,7 @@ int jbd2_journal_update_sb_log_tail(journal_t *journal, tid_t tail_tid,
 	sb->s_sequence = cpu_to_be32(tail_tid);
 	sb->s_start    = cpu_to_be32(tail_block);
 
-	ret = jbd2_write_superblock(journal, write_op);
+	ret = jbd2_write_superblock(journal, write_flags);
 	if (ret)
 		goto out;
 
@@ -1704,12 +1705,12 @@ int jbd2_journal_update_sb_log_tail(journal_t *journal, tid_t tail_tid,
 /**
  * jbd2_mark_journal_empty() - Mark on disk journal as empty.
  * @journal: The journal to update.
- * @write_op: With which operation should we write the journal sb
+ * @write_flags: Flags for the journal sb write operation
  *
  * Update a journal's dynamic superblock fields to show that journal is empty.
  * Write updated superblock to disk waiting for IO to complete.
  */
-static void jbd2_mark_journal_empty(journal_t *journal, int write_op)
+static void jbd2_mark_journal_empty(journal_t *journal, blk_opf_t write_flags)
 {
 	journal_superblock_t *sb = journal->j_superblock;
 	bool had_fast_commit = false;
@@ -1735,7 +1736,7 @@ static void jbd2_mark_journal_empty(journal_t *journal, int write_op)
 		had_fast_commit = true;
 	}
 
-	jbd2_write_superblock(journal, write_op);
+	jbd2_write_superblock(journal, write_flags);
 
 	if (had_fast_commit)
 		jbd2_set_feature_fast_commit(journal);
diff --git a/include/linux/jbd2.h b/include/linux/jbd2.h
index e79d6e0b14e8..dc1724131300 100644
--- a/include/linux/jbd2.h
+++ b/include/linux/jbd2.h
@@ -1557,7 +1557,7 @@ extern int	   jbd2_journal_wipe       (journal_t *, int);
 extern int	   jbd2_journal_skip_recovery	(journal_t *);
 extern void	   jbd2_journal_update_sb_errno(journal_t *);
 extern int	   jbd2_journal_update_sb_log_tail	(journal_t *, tid_t,
-				unsigned long, int);
+				unsigned long, blk_opf_t);
 extern void	   jbd2_journal_abort      (journal_t *, int);
 extern int	   jbd2_journal_errno      (journal_t *);
 extern void	   jbd2_journal_ack_err    (journal_t *);
diff --git a/include/trace/events/jbd2.h b/include/trace/events/jbd2.h
index a4dfe005983d..99f783c384bb 100644
--- a/include/trace/events/jbd2.h
+++ b/include/trace/events/jbd2.h
@@ -355,22 +355,22 @@ TRACE_EVENT(jbd2_update_log_tail,
 
 TRACE_EVENT(jbd2_write_superblock,
 
-	TP_PROTO(journal_t *journal, int write_op),
+	TP_PROTO(journal_t *journal, blk_opf_t write_flags),
 
-	TP_ARGS(journal, write_op),
+	TP_ARGS(journal, write_flags),
 
 	TP_STRUCT__entry(
 		__field(	dev_t,  dev			)
-		__field(	  int,  write_op		)
+		__field(    blk_opf_t,  write_flags		)
 	),
 
 	TP_fast_assign(
 		__entry->dev		= journal->j_fs_dev->bd_dev;
-		__entry->write_op	= write_op;
+		__entry->write_flags	= write_flags;
 	),
 
-	TP_printk("dev %d,%d write_op %x", MAJOR(__entry->dev),
-		  MINOR(__entry->dev), __entry->write_op)
+	TP_printk("dev %d,%d write_flags %x", MAJOR(__entry->dev),
+		  MINOR(__entry->dev), (__force u32)__entry->write_flags)
 );
 
 TRACE_EVENT(jbd2_lock_buffer_stall,

Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6BDDC43334
	for <linux-block@archiver.kernel.org>; Wed, 29 Jun 2022 23:33:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231949AbiF2Xdz (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 29 Jun 2022 19:33:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231836AbiF2Xdf (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 29 Jun 2022 19:33:35 -0400
Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D57D32677
        for <linux-block@vger.kernel.org>; Wed, 29 Jun 2022 16:33:22 -0700 (PDT)
Received: by mail-pj1-f54.google.com with SMTP id w19-20020a17090a8a1300b001ec79064d8dso1020899pjn.2
        for <linux-block@vger.kernel.org>; Wed, 29 Jun 2022 16:33:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=lA/30Smfupu5SCx6YsyFZ327zOL//hCZzKvIwyECENA=;
        b=mZWNQI7LK4uRj9+7pA4yATfIVR7JteESndT3w77tBqc3mHSfty77lpcibL7eWUIxrp
         vXBS95KJxDJg6VwEIDam5DK7keBzyO/+uZ2NDHFJHMLptDTM7LmVpy15H5otIPcC9gwG
         0b3GGvCwSdssSo5KczD+qsrWF2JhZ7a6hd+VEDyPDI5croHXzU0SPeFIdAT9AoDoZPJy
         h4ZhaLNLo7zzVZQvmMvKCrRWHXdRFwBiT1M7xQ3RKEDeUgSX1kCuY47nsw13aH7wPldy
         mhlqciuV3E/RdHKEloqot6s+kuMfsH1xHEdaY9fMAUty+VkXlwUjxih91UDSxxqdw/t3
         YfAw==
X-Gm-Message-State: AJIora8obih1mVLiZjO2xwNpHEOyPSiFR2++z14LNHAXp3X7p1BKToQe
        vPQ/LNF0AfC491JTcPe8YZs=
X-Google-Smtp-Source: AGRyM1swMpf0vRfduIXAGWWNXjr5+XApi5AeUyjZE2TXli0YdkKch+1cFk7n4gYhfkSQL52yftbaPw==
X-Received: by 2002:a17:90b:380d:b0:1ec:fc87:691b with SMTP id mq13-20020a17090b380d00b001ecfc87691bmr8548734pjb.48.1656545598561;
        Wed, 29 Jun 2022 16:33:18 -0700 (PDT)
Received: from bvanassche-linux.mtv.corp.google.com ([2620:15c:211:201:3841:49ce:cba5:1586])
        by smtp.gmail.com with ESMTPSA id b21-20020a17090a8c9500b001ec8d191db4sm2763687pjo.17.2022.06.29.16.33.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Jun 2022 16:33:17 -0700 (PDT)
From:   Bart Van Assche <bvanassche@acm.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Bart Van Assche <bvanassche@acm.org>,
        Mike Christie <michael.christie@oracle.com>,
        Theodore Ts'o <tytso@mit.edu>
Subject: [PATCH v2 56/63] fs/jbd2: Fix the documentation of the jbd2_write_superblock() callers
Date:   Wed, 29 Jun 2022 16:31:38 -0700
Message-Id: <20220629233145.2779494-57-bvanassche@acm.org>
X-Mailer: git-send-email 2.37.0.rc0.161.g10f37bed90-goog
In-Reply-To: <20220629233145.2779494-1-bvanassche@acm.org>
References: <20220629233145.2779494-1-bvanassche@acm.org>
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
index fd169a356da9..40c376f5d6bc 100644
--- a/fs/jbd2/journal.c
+++ b/fs/jbd2/journal.c
@@ -1602,7 +1602,7 @@ static int journal_reset(journal_t *journal)
  * This function expects that the caller will have locked the journal
  * buffer head, and will return with it unlocked
  */
-static int jbd2_write_superblock(journal_t *journal, int write_flags)
+static int jbd2_write_superblock(journal_t *journal, blk_opf_t write_flags)
 {
 	struct buffer_head *bh = journal->j_sb_buffer;
 	journal_superblock_t *sb = journal->j_superblock;
@@ -1659,13 +1659,14 @@ static int jbd2_write_superblock(journal_t *journal, int write_flags)
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
@@ -1685,7 +1686,7 @@ int jbd2_journal_update_sb_log_tail(journal_t *journal, tid_t tail_tid,
 	sb->s_sequence = cpu_to_be32(tail_tid);
 	sb->s_start    = cpu_to_be32(tail_block);
 
-	ret = jbd2_write_superblock(journal, write_op);
+	ret = jbd2_write_superblock(journal, write_flags);
 	if (ret)
 		goto out;
 
@@ -1702,12 +1703,12 @@ int jbd2_journal_update_sb_log_tail(journal_t *journal, tid_t tail_tid,
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
@@ -1733,7 +1734,7 @@ static void jbd2_mark_journal_empty(journal_t *journal, int write_op)
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

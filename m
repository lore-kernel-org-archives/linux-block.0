Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB926C433EF
	for <linux-block@archiver.kernel.org>; Thu, 23 Jun 2022 19:01:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229921AbiFWTBw (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 23 Jun 2022 15:01:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232166AbiFWTBi (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 23 Jun 2022 15:01:38 -0400
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65BE51B2
        for <linux-block@vger.kernel.org>; Thu, 23 Jun 2022 11:06:46 -0700 (PDT)
Received: by mail-pl1-f173.google.com with SMTP id k7so18835975plg.7
        for <linux-block@vger.kernel.org>; Thu, 23 Jun 2022 11:06:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=w33CDd6tc5/NO3OGDJVRMb5SGHoLyjsBZpnjenSoToE=;
        b=di6XLCPEexc0Yw3hw4w+qwxXNPN+GWtSYX0TA9fI3+eUN8eItU42U31vRA/xfJcRPk
         qXgrEoA+LiN5F9P8M0Dz7BNrediuxbjAlB56cGQocxRmZRzlvEjqO54935FttTNW/xnV
         9/q5aJWBI6gcojQBR1EJhw1bWY7huwyVegtx733V3neETZqc1nwUSBrTvOnOhMnQWDaP
         J2QlOF+t7BljAB/G+0+Jp6YXY3OWqySxgjegJTCY8IukXxmnOAUdhPiXinAmod9bc29q
         xV0DYo9sxkL3hfZAmnShP0m087kLanBPHTfqEarfp0M28vcs6jG1ywwGTzXRLegFEVon
         joEg==
X-Gm-Message-State: AJIora/K2QECVBJGi4i9VmKkbjPPTwFp64fPpGukjBNiUCeB+EqlEAII
        Vl24VvtgvtlHIf7xsLzcUw7/BSzbEkpWJA==
X-Google-Smtp-Source: AGRyM1ssnLQAm7f2+uq+UpEUl6i7CBqfUMeyxJ4IFR4iomaf/8R1iflwt4CL91mbIoHywci3C3r7Sg==
X-Received: by 2002:a17:90b:4acd:b0:1ed:55f:3ba3 with SMTP id mh13-20020a17090b4acd00b001ed055f3ba3mr5141031pjb.10.1656007605760;
        Thu, 23 Jun 2022 11:06:45 -0700 (PDT)
Received: from bvanassche-linux.mtv.corp.google.com ([2620:15c:211:201:70af:1dc5:d20:a563])
        by smtp.gmail.com with ESMTPSA id a18-20020a056a000c9200b0051c4ecb0e3dsm16019967pfv.193.2022.06.23.11.06.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Jun 2022 11:06:45 -0700 (PDT)
From:   Bart Van Assche <bvanassche@acm.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Bart Van Assche <bvanassche@acm.org>,
        Mike Christie <michael.christie@oracle.com>,
        Theodore Ts'o <tytso@mit.edu>
Subject: [PATCH 45/51] fs/jbd2: Fix the documentation of the jbd2_write_superblock() callers
Date:   Thu, 23 Jun 2022 11:05:22 -0700
Message-Id: <20220623180528.3595304-46-bvanassche@acm.org>
X-Mailer: git-send-email 2.37.0.rc0.161.g10f37bed90-goog
In-Reply-To: <20220623180528.3595304-1-bvanassche@acm.org>
References: <20220623180528.3595304-1-bvanassche@acm.org>
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
index c0cbeeaec2d1..b1be8450c50c 100644
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
index a4dfe005983d..91dae1f678fe 100644
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
+		__field(          u32,  write_flags		)
 	),
 
 	TP_fast_assign(
 		__entry->dev		= journal->j_fs_dev->bd_dev;
-		__entry->write_op	= write_op;
+		__entry->write_flags	= (__force u32)write_flags;
 	),
 
-	TP_printk("dev %d,%d write_op %x", MAJOR(__entry->dev),
-		  MINOR(__entry->dev), __entry->write_op)
+	TP_printk("dev %d,%d write_flags %x", MAJOR(__entry->dev),
+		  MINOR(__entry->dev), __entry->write_flags)
 );
 
 TRACE_EVENT(jbd2_lock_buffer_stall,

Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F12BC433E0
	for <linux-block@archiver.kernel.org>; Fri,  5 Feb 2021 03:52:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C952E64FBF
	for <linux-block@archiver.kernel.org>; Fri,  5 Feb 2021 03:52:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229879AbhBEDwC (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 4 Feb 2021 22:52:02 -0500
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:21792 "EHLO
        esa5.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229692AbhBEDwB (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 4 Feb 2021 22:52:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1612497121; x=1644033121;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=CoCeSBqxrvjFEAnqMxwpePjEOv1siGwSFbQArqybpNE=;
  b=nSq7NDWt/8WxZRsbJPvqdfHRrL7jVZJCSfq/8CHBta8WxskSL3FFwj1j
   Ia+jBgH0+D7tN2jC7EAAUgEnk6CVzndNVF7uUE4lDdDf0d8B8+JSj1Pnu
   FR+2w1ZgHUVckN8v1//BFTO33vXAs2s0FOu60EQxMrqpdF2yEjadn5TDv
   FiDnR+ayIk5xiy4jzawcUNBdwleW64KgulvP8EyY2WLguBoroquLMlh10
   Jxr86x7NiCFvC+3/N0XHVv5+i8VkPpUUiZyGVMJQX5RpA1J2djYxYQlBl
   kwSJeQnjhank9rGYICawNAyWtJkH7K9B6EGzfKk3ZfgsHvLPeXtXQEt9G
   g==;
IronPort-SDR: SCB7z/E0IeUGaCABUOJ/hYzn3nncZyO36JPQRFuVPtuCYZwyA1KMoP63GldHh086bbpdFRqdzE
 2FqkYNTPgu0owOfn4Y65mfvrOyn5ytmjn8eGvHv+mcWz7Cl0f18xBDFcswCLXIZcnFZq3qPKpg
 2l5dlKttFP6D9ZuC1wkZDxOKhsbK4gTSIGKHwjEs16W4tHnDP0Orf+ThDIQOpUOyfrgK0Ia6o+
 t1wNgNMGBV6QkwJpjxwhNTJrriNXD06TnpI/1mf2caQApWAVbHV1xxlQzkN+Zyburq0zFpl1er
 8xg=
X-IronPort-AV: E=Sophos;i="5.81,154,1610380800"; 
   d="scan'208";a="159196405"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 05 Feb 2021 11:50:56 +0800
IronPort-SDR: zehKQ2LWmMg5/mMYnJTjERQ4SGGBNF6+gKVAGsNxDfKqdevdEuYVXRz9SfY2NTltGu6hNJiz03
 hLIc4aT9GqxxlfNnW+pk+PkD60ov2BhJT+jWsOh8+axF4eSNB43p9SDNdtXaofTq90ZmwUHLO+
 utUFPnapFvaDQWmLntqt58Yd6UWUHuCJWzN90CBE6wO7rO12sCOL9dtf6UhKaqAFIpgnvPSgcG
 5qXMSc7wBgWZC/dvAkVeLWfidfE1y6NjXJ1pRAfOqYjQN+CyxI8jQabyt3mjQxbBUaH6YVkeb3
 lhnWodamcexfl+Kw39WFLsKY
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Feb 2021 19:32:58 -0800
IronPort-SDR: dOxLBjd2oIiT1au4dhVXcxFvzjsa3ifvpCnqaH4LiYnS1ik/9cCMxtuR0nrWHCjh/82lO4VxY2
 XtNseoFZ8Un+MgpWo7+WbRWoS5ao11VyAyvcuxncDwyImcTabwNGk8G78aTH5L/oDszzlVWY9g
 jc2szKDdzmm+l4Q6oRpf7StPplfgIZHjwJRnq80eQjT2/TStzQNNB4HPwEiYk3uU+ENXJAPuGl
 8BPUIy2Lzj5hTDBcPOrHBjGgZX0lLRlOlYlZ7viYyuZ3hLTUxeFPGHQEwlE+Z3wWHhj2r7GrKG
 7fo=
WDCIronportException: Internal
Received: from vm.labspan.wdc.com (HELO vm.sc.wdc.com) ([10.6.137.102])
  by uls-op-cesaip02.wdc.com with ESMTP; 04 Feb 2021 19:50:56 -0800
From:   Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
To:     linux-block@vger.kernel.org
Cc:     paolo.valente@linaro.org, axboe@kernel.dk, rostedt@goodmis.org,
        mingo@redhat.com, chaitanya.kulkarni@wdc.com,
        johannes.thumshirn@wdc.com, damien.lemoal@wdc.com,
        bvanassche@acm.org, dongli.zhang@oracle.com,
        akpm@linux-foundation.org, aravind.ramesh@wdc.com,
        joshi.k@samsung.com, niklas.cassel@wdc.com, hare@suse.de,
        colyli@suse.de, tj@kernel.org, rdunlap@infradead.org, jack@suse.cz,
        hch@lst.de
Subject: [PATCH V2 1/5] block: remove superfluous param in blk_fill_rwbs()
Date:   Thu,  4 Feb 2021 19:50:40 -0800
Message-Id: <20210205035044.5645-2-chaitanya.kulkarni@wdc.com>
X-Mailer: git-send-email 2.22.1
In-Reply-To: <20210205035044.5645-1-chaitanya.kulkarni@wdc.com>
References: <20210205035044.5645-1-chaitanya.kulkarni@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

The last parameter for the function blk_fill_rwbs() was added in
5782138e47 ("tracing/events: convert block trace points to
TRACE_EVENT()") in order to signal read request and use of that parameter
was replaced with using switch case REQ_OP_READ with
1b9a9ab78b0 ("blktrace: use op accessors"), but the parameter was never
removed.

Remove the unused parameter and adjust the respective call sites.

Fixes: 1b9a9ab78b0 ("blktrace: use op accessors")
Signed-off-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
Reviewed-by: Damien Le Moal <damien.lemoal@wdc.com>
Reviewed-by: Christoph Hellwig <hch@lst.de>
---
 include/linux/blktrace_api.h  |  2 +-
 include/trace/events/bcache.h | 10 +++++-----
 include/trace/events/block.h  | 16 ++++++++--------
 kernel/trace/blktrace.c       |  2 +-
 4 files changed, 15 insertions(+), 15 deletions(-)

diff --git a/include/linux/blktrace_api.h b/include/linux/blktrace_api.h
index 05556573b896..11484f1d19a1 100644
--- a/include/linux/blktrace_api.h
+++ b/include/linux/blktrace_api.h
@@ -119,7 +119,7 @@ struct compat_blk_user_trace_setup {
 
 #endif
 
-extern void blk_fill_rwbs(char *rwbs, unsigned int op, int bytes);
+extern void blk_fill_rwbs(char *rwbs, unsigned int op);
 
 static inline sector_t blk_rq_trace_sector(struct request *rq)
 {
diff --git a/include/trace/events/bcache.h b/include/trace/events/bcache.h
index e41c611d6d3b..899fdacf57b9 100644
--- a/include/trace/events/bcache.h
+++ b/include/trace/events/bcache.h
@@ -28,7 +28,7 @@ DECLARE_EVENT_CLASS(bcache_request,
 		__entry->sector		= bio->bi_iter.bi_sector;
 		__entry->orig_sector	= bio->bi_iter.bi_sector - 16;
 		__entry->nr_sector	= bio->bi_iter.bi_size >> 9;
-		blk_fill_rwbs(__entry->rwbs, bio->bi_opf, bio->bi_iter.bi_size);
+		blk_fill_rwbs(__entry->rwbs, bio->bi_opf);
 	),
 
 	TP_printk("%d,%d %s %llu + %u (from %d,%d @ %llu)",
@@ -102,7 +102,7 @@ DECLARE_EVENT_CLASS(bcache_bio,
 		__entry->dev		= bio_dev(bio);
 		__entry->sector		= bio->bi_iter.bi_sector;
 		__entry->nr_sector	= bio->bi_iter.bi_size >> 9;
-		blk_fill_rwbs(__entry->rwbs, bio->bi_opf, bio->bi_iter.bi_size);
+		blk_fill_rwbs(__entry->rwbs, bio->bi_opf);
 	),
 
 	TP_printk("%d,%d  %s %llu + %u",
@@ -137,7 +137,7 @@ TRACE_EVENT(bcache_read,
 		__entry->dev		= bio_dev(bio);
 		__entry->sector		= bio->bi_iter.bi_sector;
 		__entry->nr_sector	= bio->bi_iter.bi_size >> 9;
-		blk_fill_rwbs(__entry->rwbs, bio->bi_opf, bio->bi_iter.bi_size);
+		blk_fill_rwbs(__entry->rwbs, bio->bi_opf);
 		__entry->cache_hit = hit;
 		__entry->bypass = bypass;
 	),
@@ -168,7 +168,7 @@ TRACE_EVENT(bcache_write,
 		__entry->inode		= inode;
 		__entry->sector		= bio->bi_iter.bi_sector;
 		__entry->nr_sector	= bio->bi_iter.bi_size >> 9;
-		blk_fill_rwbs(__entry->rwbs, bio->bi_opf, bio->bi_iter.bi_size);
+		blk_fill_rwbs(__entry->rwbs, bio->bi_opf);
 		__entry->writeback = writeback;
 		__entry->bypass = bypass;
 	),
@@ -238,7 +238,7 @@ TRACE_EVENT(bcache_journal_write,
 		__entry->sector		= bio->bi_iter.bi_sector;
 		__entry->nr_sector	= bio->bi_iter.bi_size >> 9;
 		__entry->nr_keys	= keys;
-		blk_fill_rwbs(__entry->rwbs, bio->bi_opf, bio->bi_iter.bi_size);
+		blk_fill_rwbs(__entry->rwbs, bio->bi_opf);
 	),
 
 	TP_printk("%d,%d  %s %llu + %u keys %u",
diff --git a/include/trace/events/block.h b/include/trace/events/block.h
index 0d782663a005..879cba8bdfca 100644
--- a/include/trace/events/block.h
+++ b/include/trace/events/block.h
@@ -89,7 +89,7 @@ TRACE_EVENT(block_rq_requeue,
 		__entry->sector    = blk_rq_trace_sector(rq);
 		__entry->nr_sector = blk_rq_trace_nr_sectors(rq);
 
-		blk_fill_rwbs(__entry->rwbs, rq->cmd_flags, blk_rq_bytes(rq));
+		blk_fill_rwbs(__entry->rwbs, rq->cmd_flags);
 		__get_str(cmd)[0] = '\0';
 	),
 
@@ -133,7 +133,7 @@ TRACE_EVENT(block_rq_complete,
 		__entry->nr_sector = nr_bytes >> 9;
 		__entry->error     = error;
 
-		blk_fill_rwbs(__entry->rwbs, rq->cmd_flags, nr_bytes);
+		blk_fill_rwbs(__entry->rwbs, rq->cmd_flags);
 		__get_str(cmd)[0] = '\0';
 	),
 
@@ -166,7 +166,7 @@ DECLARE_EVENT_CLASS(block_rq,
 		__entry->nr_sector = blk_rq_trace_nr_sectors(rq);
 		__entry->bytes     = blk_rq_bytes(rq);
 
-		blk_fill_rwbs(__entry->rwbs, rq->cmd_flags, blk_rq_bytes(rq));
+		blk_fill_rwbs(__entry->rwbs, rq->cmd_flags);
 		__get_str(cmd)[0] = '\0';
 		memcpy(__entry->comm, current->comm, TASK_COMM_LEN);
 	),
@@ -249,7 +249,7 @@ TRACE_EVENT(block_bio_complete,
 		__entry->sector		= bio->bi_iter.bi_sector;
 		__entry->nr_sector	= bio_sectors(bio);
 		__entry->error		= blk_status_to_errno(bio->bi_status);
-		blk_fill_rwbs(__entry->rwbs, bio->bi_opf, bio->bi_iter.bi_size);
+		blk_fill_rwbs(__entry->rwbs, bio->bi_opf);
 	),
 
 	TP_printk("%d,%d %s %llu + %u [%d]",
@@ -276,7 +276,7 @@ DECLARE_EVENT_CLASS(block_bio,
 		__entry->dev		= bio_dev(bio);
 		__entry->sector		= bio->bi_iter.bi_sector;
 		__entry->nr_sector	= bio_sectors(bio);
-		blk_fill_rwbs(__entry->rwbs, bio->bi_opf, bio->bi_iter.bi_size);
+		blk_fill_rwbs(__entry->rwbs, bio->bi_opf);
 		memcpy(__entry->comm, current->comm, TASK_COMM_LEN);
 	),
 
@@ -433,7 +433,7 @@ TRACE_EVENT(block_split,
 		__entry->dev		= bio_dev(bio);
 		__entry->sector		= bio->bi_iter.bi_sector;
 		__entry->new_sector	= new_sector;
-		blk_fill_rwbs(__entry->rwbs, bio->bi_opf, bio->bi_iter.bi_size);
+		blk_fill_rwbs(__entry->rwbs, bio->bi_opf);
 		memcpy(__entry->comm, current->comm, TASK_COMM_LEN);
 	),
 
@@ -474,7 +474,7 @@ TRACE_EVENT(block_bio_remap,
 		__entry->nr_sector	= bio_sectors(bio);
 		__entry->old_dev	= dev;
 		__entry->old_sector	= from;
-		blk_fill_rwbs(__entry->rwbs, bio->bi_opf, bio->bi_iter.bi_size);
+		blk_fill_rwbs(__entry->rwbs, bio->bi_opf);
 	),
 
 	TP_printk("%d,%d %s %llu + %u <- (%d,%d) %llu",
@@ -518,7 +518,7 @@ TRACE_EVENT(block_rq_remap,
 		__entry->old_dev	= dev;
 		__entry->old_sector	= from;
 		__entry->nr_bios	= blk_rq_count_bios(rq);
-		blk_fill_rwbs(__entry->rwbs, rq->cmd_flags, blk_rq_bytes(rq));
+		blk_fill_rwbs(__entry->rwbs, rq->cmd_flags);
 	),
 
 	TP_printk("%d,%d %s %llu + %u <- (%d,%d) %llu %u",
diff --git a/kernel/trace/blktrace.c b/kernel/trace/blktrace.c
index 9e9ee4945043..8a2591c7aa41 100644
--- a/kernel/trace/blktrace.c
+++ b/kernel/trace/blktrace.c
@@ -1867,7 +1867,7 @@ void blk_trace_remove_sysfs(struct device *dev)
 
 #ifdef CONFIG_EVENT_TRACING
 
-void blk_fill_rwbs(char *rwbs, unsigned int op, int bytes)
+void blk_fill_rwbs(char *rwbs, unsigned int op)
 {
 	int i = 0;
 
-- 
2.22.1


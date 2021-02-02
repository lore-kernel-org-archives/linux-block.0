Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64C3AC433E0
	for <linux-block@archiver.kernel.org>; Tue,  2 Feb 2021 05:27:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 30E5664EDC
	for <linux-block@archiver.kernel.org>; Tue,  2 Feb 2021 05:27:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231443AbhBBF1H (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 2 Feb 2021 00:27:07 -0500
Received: from esa2.hgst.iphmx.com ([68.232.143.124]:41766 "EHLO
        esa2.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230168AbhBBF1G (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 2 Feb 2021 00:27:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1612244553; x=1643780553;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=JGFz/l9SNyabiClwCUzw4MbPVEOCBtgfVIZqtJS4V7c=;
  b=NRvCB8cxRHEkHWMxSdggrPT1hU5YLfI6x2ziEWNcIJ8w3+TzFSuw3ZdT
   AyLjYSCA8CtvgSXgMi0DdLDty026ROFPvFZlGd1YId/B5AwSX82idLmXa
   lI1x4BTFAOdZtu/TxW+ZE/9PXo4y1cssZFN3ib6IYPQipqZUPCPTYYYA4
   gCxj1bnTRz+81byOcjmJTBxJld/EAFrZeDOyDg6JiGdKgN0cL+TTyaqo1
   KfFiIC8XCoPtzfvbWgallBMLVpRzYYii8F//3kuRvZ9WdcdX8rO2QNPz0
   h+2z3vKRwg2ibxLE3hG4U6o0SF4d8o98pobxp/5nBkrO4Pb2KxeHVtSHd
   A==;
IronPort-SDR: RqTRx4fNhnXj++3+kyoHKB1vB6/lRAfT05Yw3DfOTcqyc4ZJrMaZ7LQfYe2sa9Ra77XeXGiUA9
 Sf15CLcegtKWhiezgOXm7z4MzZyjPC3LnvgEfdlNW7BYk1KKes3Xyd2itGn7gZiTVHs9MYILRU
 CD3hPOWy/IeHu6AfpcDlzOtkuaeBWGrPuR9Kd+VekZgAcrXABiC/7MEpqjxqsFsBctkFlVoaMk
 /jgRKz+uWQDrrYuhF7o8+ld6nfZ/6SLRmfhqSQMjQVSd2VyGnOclW/4j7o0gF6FSle0aHnqQrs
 J3Q=
X-IronPort-AV: E=Sophos;i="5.79,394,1602518400"; 
   d="scan'208";a="262961055"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 02 Feb 2021 13:40:53 +0800
IronPort-SDR: qNqveAhquyGHtCGwgUbL6a/5T6K164MmslKpCA0eyBC9DGzw2AAowo2r4zRF358FIE4a5IG6fG
 CEHBBi58YOeC5pd0l+iwqIwzDjzc/f0ePyU3N2xhoI8Z9KP2ZLEG0cGDWoADrHNAPwCPubCEVo
 ul8In8MQXtawa8rKy5858z5RToEHxOsIv5EheaztVJgvGepuEE8hK1zyUhtaALRcDdm0XgFXoZ
 hlABEDHb53Nnf/L6GxtGBGvoatqJAqqh2ucWtNekt4SF7OElh5AM9Th0N7VmOHPUghzuQ7Bqs+
 jliVdlO7SHwR1x2LZ8pW5soj
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Feb 2021 21:08:08 -0800
IronPort-SDR: dn3vYelDjbf8zLNjYMaNnDX5g7cf/G6pO0vdeUhnLZWpCAXseBjQXhUi7a8wmU0vXKRk37CWEp
 x+BXbU2aNbWReBipV/ebXqZUynDiiNpUDo8CLRw8A7yOmuwl3DuiAO5aaDad85iu3F+qmMJimC
 yfhLqjXiN7rU4riovmrnYR/ao00ehwDlemsSM+Bt7ufnxJqoZFLaE3CjtBoKnsIP40DyMtqWlM
 B3At0OI+skKCaR2zI9OuvTlKdCtuxpRL+nP/KxUVHx5uzcBJZibR1vdNlo+qhvh/C6DW+G4itD
 3JA=
WDCIronportException: Internal
Received: from vm.labspan.wdc.com (HELO vm.sc.wdc.com) ([10.6.137.102])
  by uls-op-cesaip02.wdc.com with ESMTP; 01 Feb 2021 21:25:59 -0800
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
Subject: [PATCH 1/7] block: remove superfluous param in blk_fill_rwbs()
Date:   Mon,  1 Feb 2021 21:25:30 -0800
Message-Id: <20210202052544.4108-2-chaitanya.kulkarni@wdc.com>
X-Mailer: git-send-email 2.22.1
In-Reply-To: <20210202052544.4108-1-chaitanya.kulkarni@wdc.com>
References: <20210202052544.4108-1-chaitanya.kulkarni@wdc.com>
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

Signed-off-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
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


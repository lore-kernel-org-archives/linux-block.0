Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE766C43381
	for <linux-block@archiver.kernel.org>; Mon, 22 Feb 2021 05:31:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C25DE64E61
	for <linux-block@archiver.kernel.org>; Mon, 22 Feb 2021 05:31:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229947AbhBVFbS (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 22 Feb 2021 00:31:18 -0500
Received: from esa1.hgst.iphmx.com ([68.232.141.245]:1875 "EHLO
        esa1.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229549AbhBVFbQ (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 22 Feb 2021 00:31:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1613971875; x=1645507875;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=CoCeSBqxrvjFEAnqMxwpePjEOv1siGwSFbQArqybpNE=;
  b=hdEAUR3OpyBA+uxBjvG2eNIFpa8Av03SjhCZ+I7FMSyRuuRn3N/5iIJ6
   Gm7HECxpcFCBNjkAOGJT5mSDLLETM9F6Mj3bKE0uzK562Eh34Iz3jvOPZ
   xFyvzSvvMKAehMG/2xMsMNPLRC61/hFZ8DuQLhP9WkYU0BgPLWiW0k0wp
   R8VxmnirEY5DeVSLO8uhmojlEycqKtUgkNThgSYfh1NimXerfbqzls6Je
   KWfge81iYaIh/qatYWsTBkeEVLuCNbgxVuqUpPP3hHmh8mJN/01UmrSL2
   Z5931nzuE3EKxmrQQ/PdI/TcIKWiHKGXKe9K4QLAQtoI5H/2swU3u4cdD
   Q==;
IronPort-SDR: B0sIkdbCypWLbvRC8nN0A0rOHvNNNDdEp/toFmicJp4rAdGCGT/8elsGR2qKopn1Jz9Av9ra02
 4R0hPcmRaO/xNItS6N1WJ3O6yrH16UgleYh1GeNT44+k3dvAsLGAjaNC/2L1vSjj5u8+91YduF
 5/vHgQYoZUfq5u1SQdGhH2jPv6QEofwWaEqCvYdscvXHECfp7I8XcXsvl68ZUYO0W42JNz14nG
 BTJJzBmtHR49/510ijYnly62foDR8kdKIS+zxhudT+/uoXwLoHDLqzKyzX7z3F8nVgG4VPDhsa
 3A4=
X-IronPort-AV: E=Sophos;i="5.81,196,1610380800"; 
   d="scan'208";a="271015605"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 22 Feb 2021 13:30:10 +0800
IronPort-SDR: Dimv7Ey8G4ED9Ta8Kw8nr4OlCLXc2ULO/2E4S3f4Mra5Qn1GEtAJaY6QWLpOl5a5T+kpioAB9y
 Xp4np/aoLb4//BT9FOcVbIgsGe7ngfuaf9cJN0B2TMqbtniOQsZwk1CY8PDLjZK2k3wpx2PV10
 SA76QmkICrCpDJHowNq92gBQltl10OCo9GnEi5rNko0NEeJjxrITMFmMbViOaHwTPeTjPPx6GC
 CI6Q+4VWiPFOns68zDI8OSrIMruEpEh8swO4MwryY3gJMPDZsoi6pIy55XnU5/OydGOl+gDwlD
 3Phg6qarF933eJP+EqfZgA3v
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Feb 2021 21:11:42 -0800
IronPort-SDR: 3sjLOTpyhVbK2TJa/phZLNlpxSpvwqoc++8PVTVBhaGUN0XgwKQpKfwN8yODRzflbDadmft6FX
 51tIp5JE0En5ox42yRazdJ/9X6PwU12GoTJGNA4hvkUxMhUvxPwRqqI0wRo8S22Uw/jyZ7tbwe
 lTubMsHh7bJyl0tsiQRwOjWQjxXbLeeg0k94WQCZavOUqTY1Y4PCuCzZ7epdA1FS4o3ceHFH/h
 Xhrb0D05fG9nA+penGvXwcFF9rJM26f5GWVTDZIZ1t2RWOG+1OkmUg6Hi7Qz8RVtMmKcFzACaq
 WnM=
WDCIronportException: Internal
Received: from vm.labspan.wdc.com (HELO vm.sc.wdc.com) ([10.6.137.102])
  by uls-op-cesaip01.wdc.com with ESMTP; 21 Feb 2021 21:30:10 -0800
From:   Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
To:     linux-block@vger.kernel.org
Cc:     paolo.valente@linaro.org, axboe@kernel.dk, rostedt@goodmis.org,
        mingo@redhat.com, chaitanya.kulkarni@wdc.com,
        johannes.thumshirn@wdc.com, damien.lemoal@wdc.com,
        bvanassche@acm.org, dongli.zhang@oracle.com,
        akpm@linux-foundation.org, hare@suse.de, colyli@suse.de,
        tj@kernel.org, rdunlap@infradead.org, jack@suse.cz, hch@lst.de
Subject: [PATCH V3 1/5] block: remove superfluous param in blk_fill_rwbs()
Date:   Sun, 21 Feb 2021 21:29:55 -0800
Message-Id: <20210222052959.23155-2-chaitanya.kulkarni@wdc.com>
X-Mailer: git-send-email 2.22.1.dirty
In-Reply-To: <20210222052959.23155-1-chaitanya.kulkarni@wdc.com>
References: <20210222052959.23155-1-chaitanya.kulkarni@wdc.com>
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


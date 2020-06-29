Return-Path: <SRS0=rGXo=AK=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DBEB8C433E0
	for <linux-block@archiver.kernel.org>; Mon, 29 Jun 2020 23:44:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B191020780
	for <linux-block@archiver.kernel.org>; Mon, 29 Jun 2020 23:44:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="n+raiAXE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726865AbgF2Xor (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 29 Jun 2020 19:44:47 -0400
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:41330 "EHLO
        esa4.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727008AbgF2Xoq (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 29 Jun 2020 19:44:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1593474285; x=1625010285;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=1BxDymziNGG1Dva2mVghHFYrWVwBmChnGv4xA8iUaxQ=;
  b=n+raiAXEZrfHQHk3f3bTCduxAfULCDmzm2yLBE9PdIm9gGWOX29u617m
   Uz6A0xN2xChFGq++1ZiAupFG5BeF+2LA/G73G1eVQ5zMnVU82UPU9WN0/
   H2WMhyreSMQ8PIBc3hVLiwJzh7rKaH7g9wdt/gl/XZiVbWO74JOwfr7vw
   RWzTm6Xe060srh56zgHTmap2cxD502oK7a64TVYkxucWG66AZ+lZ+Ip4Y
   0i2SXGiN42M9LCuXOzrHrxMJlhzN2wtypcoxn3NDlIB6ZVSEuoOmEe3Ag
   WzTnn44L8hoL97MCa17zNFt/HdHYKjfn59l0nz4xFJ3dyLenM8qmmjgWK
   w==;
IronPort-SDR: aN51CsZcKYXZkourCGX212DL9elAtrctYMr+lme3TdUbn0i1B+42t+ECeauw8J33W0br0MTs3P
 ZK2QO7TFBB5mlH+P7VMyPktZBJNKD+mG5B8v1zJtRP2EmJ4dNx8wRGryuXEorJdJKIRat6FWnO
 SHqzCAh6/NiEDm9Q/szAg93h5ciuRk048tj2OfsdwWOqa2IT5WFXDwh8saw4GKIZzCzHMi425p
 eONqJ3wNtfRnGb/weDcfWkA+K9qAlE+rDVHcJxFQb+Q2P43qNFSiRFlktVhyU9MyZl/1oiOESn
 u4E=
X-IronPort-AV: E=Sophos;i="5.75,296,1589212800"; 
   d="scan'208";a="141220125"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 30 Jun 2020 07:44:45 +0800
IronPort-SDR: wSjYGKqdieAUkB6FW14pV/7PzIO1rpK5rPdzjBIYUp7jD51WdLgGCCqBEf9qepwqNrHF5ttLQQ
 MdKMCay1rgwG8ciIxzqM/feG2ZNT8DGhU=
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jun 2020 16:33:38 -0700
IronPort-SDR: eJVPUTuujTN8U32pyHeiRa+NyV6u0EjMR7qOqnZBGn5achSWGJo2gq/hQVknIr/jytb05lKxT/
 bIdg4XHqyFag==
WDCIronportException: Internal
Received: from iouring.labspan.wdc.com (HELO iouring.sc.wdc.com) ([10.6.138.107])
  by uls-op-cesaip01.wdc.com with ESMTP; 29 Jun 2020 16:44:45 -0700
From:   Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
To:     linux-block@vger.kernel.org, dm-devel@redhat.com
Cc:     jack@suse.czi, rdunlap@infradead.org, sagi@grimberg.me,
        mingo@redhat.com, rostedt@goodmis.org, snitzer@redhat.com,
        agk@redhat.com, axboe@kernel.dk, paolo.valente@linaro.org,
        ming.lei@redhat.com, bvanassche@acm.org, fangguoju@gmail.com,
        colyli@suse.de, hch@lst.de,
        Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
Subject: [PATCH 09/11] block: remove unsed param in blk_fill_rwbs()
Date:   Mon, 29 Jun 2020 16:43:12 -0700
Message-Id: <20200629234314.10509-10-chaitanya.kulkarni@wdc.com>
X-Mailer: git-send-email 2.26.0
In-Reply-To: <20200629234314.10509-1-chaitanya.kulkarni@wdc.com>
References: <20200629234314.10509-1-chaitanya.kulkarni@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

The last parameter for the function blk_fill_rwbs() was added in
5782138e47 ("tracing/events: convert block trace points to
TRACE_EVENT()") in order to signal read request and use of that parameter
was replaced with using switch case REQ_OP_READ with
1b9a9ab78b0 ("blktrace: use op accessors"), but the parameter was never
removed.

This patch removes unused parameter which also allows us to merge existing
trace points in the following patch.

Signed-off-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
---
 include/linux/blktrace_api.h  |  2 +-
 include/trace/events/bcache.h | 10 +++++-----
 include/trace/events/block.h  | 19 +++++++++----------
 kernel/trace/blktrace.c       |  2 +-
 4 files changed, 16 insertions(+), 17 deletions(-)

diff --git a/include/linux/blktrace_api.h b/include/linux/blktrace_api.h
index 3b6ff5902edc..80123eebf005 100644
--- a/include/linux/blktrace_api.h
+++ b/include/linux/blktrace_api.h
@@ -120,7 +120,7 @@ struct compat_blk_user_trace_setup {
 
 #endif
 
-extern void blk_fill_rwbs(char *rwbs, unsigned int op, int bytes);
+extern void blk_fill_rwbs(char *rwbs, unsigned int op);
 
 static inline sector_t blk_rq_trace_sector(struct request *rq)
 {
diff --git a/include/trace/events/bcache.h b/include/trace/events/bcache.h
index 0bddea663b3b..41415637e92c 100644
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
index 6a74fb9f4dba..d191d2cd1070 100644
--- a/include/trace/events/block.h
+++ b/include/trace/events/block.h
@@ -89,7 +89,7 @@ TRACE_EVENT(block_rq_requeue,
 		__entry->sector    = blk_rq_trace_sector(rq);
 		__entry->nr_sector = blk_rq_trace_nr_sectors(rq);
 
-		blk_fill_rwbs(__entry->rwbs, rq->cmd_flags, blk_rq_bytes(rq));
+		blk_fill_rwbs(__entry->rwbs, rq->cmd_flags);
 		__get_str(cmd)[0] = '\0';
 	),
 
@@ -132,7 +132,7 @@ TRACE_EVENT(block_rq_complete,
 		__entry->nr_sector = nr_bytes >> 9;
 		__entry->error     = error;
 
-		blk_fill_rwbs(__entry->rwbs, rq->cmd_flags, nr_bytes);
+		blk_fill_rwbs(__entry->rwbs, rq->cmd_flags);
 		__get_str(cmd)[0] = '\0';
 	),
 
@@ -165,7 +165,7 @@ DECLARE_EVENT_CLASS(block_rq,
 		__entry->nr_sector = blk_rq_trace_nr_sectors(rq);
 		__entry->bytes     = blk_rq_bytes(rq);
 
-		blk_fill_rwbs(__entry->rwbs, rq->cmd_flags, blk_rq_bytes(rq));
+		blk_fill_rwbs(__entry->rwbs, rq->cmd_flags);
 		__get_str(cmd)[0] = '\0';
 		memcpy(__entry->comm, current->comm, TASK_COMM_LEN);
 	),
@@ -248,7 +248,7 @@ TRACE_EVENT(block_bio_complete,
 		__entry->sector		= bio->bi_iter.bi_sector;
 		__entry->nr_sector	= bio_sectors(bio);
 		__entry->error		= blk_status_to_errno(bio->bi_status);
-		blk_fill_rwbs(__entry->rwbs, bio->bi_opf, bio->bi_iter.bi_size);
+		blk_fill_rwbs(__entry->rwbs, bio->bi_opf);
 	),
 
 	TP_printk("%d,%d %s %llu + %u [%d]",
@@ -275,7 +275,7 @@ DECLARE_EVENT_CLASS(block_bio,
 		__entry->dev		= bio_dev(bio);
 		__entry->sector		= bio->bi_iter.bi_sector;
 		__entry->nr_sector	= bio_sectors(bio);
-		blk_fill_rwbs(__entry->rwbs, bio->bi_opf, bio->bi_iter.bi_size);
+		blk_fill_rwbs(__entry->rwbs, bio->bi_opf);
 		memcpy(__entry->comm, current->comm, TASK_COMM_LEN);
 	),
 
@@ -363,8 +363,7 @@ DECLARE_EVENT_CLASS(block_get_rq,
 		__entry->dev		= bio ? bio_dev(bio) : 0;
 		__entry->sector		= bio ? bio->bi_iter.bi_sector : 0;
 		__entry->nr_sector	= bio ? bio_sectors(bio) : 0;
-		blk_fill_rwbs(__entry->rwbs,
-			      bio ? bio->bi_opf : 0, __entry->nr_sector);
+		blk_fill_rwbs(__entry->rwbs, bio ? bio->bi_opf : 0);
 		memcpy(__entry->comm, current->comm, TASK_COMM_LEN);
         ),
 
@@ -492,7 +491,7 @@ TRACE_EVENT(block_split,
 		__entry->dev		= bio_dev(bio);
 		__entry->sector		= bio->bi_iter.bi_sector;
 		__entry->new_sector	= new_sector;
-		blk_fill_rwbs(__entry->rwbs, bio->bi_opf, bio->bi_iter.bi_size);
+		blk_fill_rwbs(__entry->rwbs, bio->bi_opf);
 		memcpy(__entry->comm, current->comm, TASK_COMM_LEN);
 	),
 
@@ -535,7 +534,7 @@ TRACE_EVENT(block_bio_remap,
 		__entry->nr_sector	= bio_sectors(bio);
 		__entry->old_dev	= dev;
 		__entry->old_sector	= from;
-		blk_fill_rwbs(__entry->rwbs, bio->bi_opf, bio->bi_iter.bi_size);
+		blk_fill_rwbs(__entry->rwbs, bio->bi_opf);
 	),
 
 	TP_printk("%d,%d %s %llu + %u <- (%d,%d) %llu",
@@ -581,7 +580,7 @@ TRACE_EVENT(block_rq_remap,
 		__entry->old_dev	= dev;
 		__entry->old_sector	= from;
 		__entry->nr_bios	= blk_rq_count_bios(rq);
-		blk_fill_rwbs(__entry->rwbs, rq->cmd_flags, blk_rq_bytes(rq));
+		blk_fill_rwbs(__entry->rwbs, rq->cmd_flags);
 	),
 
 	TP_printk("%d,%d %s %llu + %u <- (%d,%d) %llu %u",
diff --git a/kernel/trace/blktrace.c b/kernel/trace/blktrace.c
index bb864a50307f..62cb6197ce1f 100644
--- a/kernel/trace/blktrace.c
+++ b/kernel/trace/blktrace.c
@@ -1950,7 +1950,7 @@ void blk_trace_remove_sysfs(struct device *dev)
 
 #ifdef CONFIG_EVENT_TRACING
 
-void blk_fill_rwbs(char *rwbs, unsigned int op, int bytes)
+void blk_fill_rwbs(char *rwbs, unsigned int op)
 {
 	int i = 0;
 
-- 
2.26.0


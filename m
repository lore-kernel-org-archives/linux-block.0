Return-Path: <SRS0=8pZC=OW=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54C8DC67839
	for <linux-block@archiver.kernel.org>; Thu, 13 Dec 2018 14:56:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1B9D92086D
	for <linux-block@archiver.kernel.org>; Thu, 13 Dec 2018 14:56:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1B9D92086D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727551AbeLMO4P (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 13 Dec 2018 09:56:15 -0500
Received: from mx2.suse.de ([195.135.220.15]:51810 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728584AbeLMO4P (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Thu, 13 Dec 2018 09:56:15 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 9D003ADDD;
        Thu, 13 Dec 2018 14:56:13 +0000 (UTC)
From:   Coly Li <colyli@suse.de>
To:     linux-bcache@vger.kernel.org, axboe@kernel.dk
Cc:     linux-block@vger.kernel.org, Guoju Fang <fangguoju@gmail.com>,
        Coly Li <colyli@suse.de>
Subject: [PATCH 12/12] bcache: print number of keys in trace_bcache_journal_write
Date:   Thu, 13 Dec 2018 22:53:57 +0800
Message-Id: <20181213145357.38528-13-colyli@suse.de>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20181213145357.38528-1-colyli@suse.de>
References: <20181213145357.38528-1-colyli@suse.de>
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

From: Guoju Fang <fangguoju@gmail.com>

Sometimes flush journal may be very frequent, so it's useful to dump
number of keys every time write journal.

Signed-off-by: Guoju Fang <fangguoju@gmail.com>
Signed-off-by: Coly Li <colyli@suse.de>
---
 drivers/md/bcache/journal.c   |  2 +-
 include/trace/events/bcache.h | 27 ++++++++++++++++++++++++---
 2 files changed, 25 insertions(+), 4 deletions(-)

diff --git a/drivers/md/bcache/journal.c b/drivers/md/bcache/journal.c
index 522c7426f3a0..b2fd412715b1 100644
--- a/drivers/md/bcache/journal.c
+++ b/drivers/md/bcache/journal.c
@@ -663,7 +663,7 @@ static void journal_write_unlocked(struct closure *cl)
 				 REQ_SYNC|REQ_META|REQ_PREFLUSH|REQ_FUA);
 		bch_bio_map(bio, w->data);
 
-		trace_bcache_journal_write(bio);
+		trace_bcache_journal_write(bio, w->data->keys);
 		bio_list_add(&list, bio);
 
 		SET_PTR_OFFSET(k, i, PTR_OFFSET(k, i) + sectors);
diff --git a/include/trace/events/bcache.h b/include/trace/events/bcache.h
index 2cbd6e42ad83..e4526f85c19d 100644
--- a/include/trace/events/bcache.h
+++ b/include/trace/events/bcache.h
@@ -221,9 +221,30 @@ DEFINE_EVENT(cache_set, bcache_journal_entry_full,
 	TP_ARGS(c)
 );
 
-DEFINE_EVENT(bcache_bio, bcache_journal_write,
-	TP_PROTO(struct bio *bio),
-	TP_ARGS(bio)
+TRACE_EVENT(bcache_journal_write,
+	TP_PROTO(struct bio *bio, u32 keys),
+	TP_ARGS(bio, keys),
+
+	TP_STRUCT__entry(
+		__field(dev_t,		dev			)
+		__field(sector_t,	sector			)
+		__field(unsigned int,	nr_sector		)
+		__array(char,		rwbs,	6		)
+		__field(u32,		nr_keys			)
+	),
+
+	TP_fast_assign(
+		__entry->dev		= bio_dev(bio);
+		__entry->sector		= bio->bi_iter.bi_sector;
+		__entry->nr_sector	= bio->bi_iter.bi_size >> 9;
+		__entry->nr_keys	= keys;
+		blk_fill_rwbs(__entry->rwbs, bio->bi_opf, bio->bi_iter.bi_size);
+	),
+
+	TP_printk("%d,%d  %s %llu + %u keys %u",
+		  MAJOR(__entry->dev), MINOR(__entry->dev), __entry->rwbs,
+		  (unsigned long long)__entry->sector, __entry->nr_sector,
+		  __entry->nr_keys)
 );
 
 /* Btree */
-- 
2.16.4


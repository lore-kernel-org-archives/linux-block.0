Return-Path: <SRS0=rGXo=AK=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83886C433DF
	for <linux-block@archiver.kernel.org>; Mon, 29 Jun 2020 23:43:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6049C20780
	for <linux-block@archiver.kernel.org>; Mon, 29 Jun 2020 23:43:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="gbNO9hXT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726826AbgF2Xn5 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 29 Jun 2020 19:43:57 -0400
Received: from esa1.hgst.iphmx.com ([68.232.141.245]:59286 "EHLO
        esa1.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726865AbgF2Xn5 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 29 Jun 2020 19:43:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1593474236; x=1625010236;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=xs57aBIX/QG6FMReIDHBcUiSTqCFtsowWQTCYBYhykU=;
  b=gbNO9hXTRN4k9m1jyfEAMC5jiA2MEBuUke8HD9Klqs1UGj4R78e4k/x1
   6FpZyrCVWgZibgiSEu45ApEqa6AEkC5m3HhLTUyQpPE/XsqC3F4jey6db
   L1AT3XDy/6F+Vta6nIt53rRokrJmbgqvpDVsGDHdx8hwQn4V4gjF2s1VN
   TaIAt80gprfkZKId07LDiTsIWoOaKRXtbFlw8SK8/aeoBSUzBOJtHiDel
   UOUTZXWvDo5w3+pP4dqDp/Z3N3ZkChvpBNignp2pmjS1KyICr5Nm+mVFV
   IrJ/LdYtWh/59y5RWbXR7XgulYy4kjZthP77K++ehDkqqmV1Q1iUJSPG7
   Q==;
IronPort-SDR: 85do+UdFw05HLC6xkbMyWf9IeLh3+UfDU6G5Njn+hKkG5rme/5vdzVIz8/ShsuwbjMbQwpzVIg
 XW8XZfSIW7rdZ+lrn2RpDLMKu1IHcYHXUA4RVSSVx6q42sYk1XhAuoG9u17TGTGFfdlg4mGTyD
 tGAQXrB23non4FJlOPwO3balP540t7KkntQBhABZrb1PBwu4G/0JxEL7SkHMrdoWTDjhopu+iK
 HWuhphgz4ZLMfgK6KrwgVfNQ+OQQZDRr/vfuIbmj0WvAJmfDm6z9LPowGY+h+ekyDUMi3fbAdw
 rBU=
X-IronPort-AV: E=Sophos;i="5.75,296,1589212800"; 
   d="scan'208";a="250451441"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 30 Jun 2020 07:43:56 +0800
IronPort-SDR: cF+hzerHZGREkKCJgtPuIYfGpay3mDuEM6JjW9Z8PwhSZiKr5RbWGK/DMqlVVAzZg/yqQKjENr
 GX8uOLyAXQ7jxmVrcxewrYqPn4s4MA7dg=
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jun 2020 16:32:16 -0700
IronPort-SDR: 2TTYKV2UBhmVUliSx1iiNA0qEyTuvXyPEcykDKJ/0JtkuwHLf1c4l7haqfPhSdQFt2rCuSffO0
 J8bjRRwkx1QA==
WDCIronportException: Internal
Received: from iouring.labspan.wdc.com (HELO iouring.sc.wdc.com) ([10.6.138.107])
  by uls-op-cesaip01.wdc.com with ESMTP; 29 Jun 2020 16:43:56 -0700
From:   Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
To:     linux-block@vger.kernel.org, dm-devel@redhat.com
Cc:     jack@suse.czi, rdunlap@infradead.org, sagi@grimberg.me,
        mingo@redhat.com, rostedt@goodmis.org, snitzer@redhat.com,
        agk@redhat.com, axboe@kernel.dk, paolo.valente@linaro.org,
        ming.lei@redhat.com, bvanassche@acm.org, fangguoju@gmail.com,
        colyli@suse.de, hch@lst.de,
        Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
Subject: [PATCH 04/11] block: use block_bio event class for bio_bounce
Date:   Mon, 29 Jun 2020 16:43:07 -0700
Message-Id: <20200629234314.10509-5-chaitanya.kulkarni@wdc.com>
X-Mailer: git-send-email 2.26.0
In-Reply-To: <20200629234314.10509-1-chaitanya.kulkarni@wdc.com>
References: <20200629234314.10509-1-chaitanya.kulkarni@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Remove block_bio_bounce trace event which shares the code with block_bio.

Signed-off-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
---
 include/trace/events/block.h | 56 ++++++++++++------------------------
 1 file changed, 18 insertions(+), 38 deletions(-)

diff --git a/include/trace/events/block.h b/include/trace/events/block.h
index 5e9f46469f50..d7289576f1fd 100644
--- a/include/trace/events/block.h
+++ b/include/trace/events/block.h
@@ -221,44 +221,6 @@ DEFINE_EVENT(block_rq, block_rq_merge,
 	TP_ARGS(rq)
 );
 
-/**
- * block_bio_bounce - used bounce buffer when processing block operation
- * @bio: block operation
- *
- * A bounce buffer was used to handle the block operation @bio in queue.
- * This occurs when hardware limitations prevent a direct transfer of
- * data between the @bio data memory area and the IO device.  Use of a
- * bounce buffer requires extra copying of data and decreases
- * performance.
- */
-TRACE_EVENT(block_bio_bounce,
-
-	TP_PROTO(struct bio *bio),
-
-	TP_ARGS(bio),
-
-	TP_STRUCT__entry(
-		__field( dev_t,		dev			)
-		__field( sector_t,	sector			)
-		__field( unsigned int,	nr_sector		)
-		__array( char,		rwbs,	RWBS_LEN	)
-		__array( char,		comm,	TASK_COMM_LEN	)
-	),
-
-	TP_fast_assign(
-		__entry->dev		= bio_dev(bio);
-		__entry->sector		= bio->bi_iter.bi_sector;
-		__entry->nr_sector	= bio_sectors(bio);
-		blk_fill_rwbs(__entry->rwbs, bio->bi_opf, bio->bi_iter.bi_size);
-		memcpy(__entry->comm, current->comm, TASK_COMM_LEN);
-	),
-
-	TP_printk("%d,%d %s %llu + %u [%s]",
-		  MAJOR(__entry->dev), MINOR(__entry->dev), __entry->rwbs,
-		  (unsigned long long)__entry->sector,
-		  __entry->nr_sector, __entry->comm)
-);
-
 /**
  * block_bio_complete - completed all work on the block operation
  * @q: queue holding the block operation
@@ -351,6 +313,24 @@ DEFINE_EVENT(block_bio, block_bio_frontmerge,
 	TP_ARGS(bio)
 );
 
+/**
+ * block_bio_bounce - used bounce buffer when processing block operation
+ * @bio: block operation
+ *
+ * A bounce buffer was used to handle the block operation @bio in queue.
+ * This occurs when hardware limitations prevent a direct transfer of
+ * data between the @bio data memory area and the IO device.  Use of a
+ * bounce buffer requires extra copying of data and decreases
+ * performance.
+ */
+
+DEFINE_EVENT(block_bio, block_bio_bounce,
+
+	TP_PROTO(struct bio *bio),
+
+	TP_ARGS(bio)
+);
+
 /**
  * block_bio_queue - putting new block IO operation in queue
  * @bio: new block operation
-- 
2.26.0


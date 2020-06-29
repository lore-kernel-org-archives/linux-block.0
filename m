Return-Path: <SRS0=rGXo=AK=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D54CFC433DF
	for <linux-block@archiver.kernel.org>; Mon, 29 Jun 2020 23:44:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B394620780
	for <linux-block@archiver.kernel.org>; Mon, 29 Jun 2020 23:44:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="rNKfuhCz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727065AbgF2XoQ (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 29 Jun 2020 19:44:16 -0400
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:29224 "EHLO
        esa5.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726865AbgF2XoP (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 29 Jun 2020 19:44:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1593474255; x=1625010255;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=0TV88dsrPxDiMSQl2gPAupgdWEaQUiQ8JI8KTgMEfVo=;
  b=rNKfuhCz2AO7QWhPIoBQLOajtojO1tQIJHN2hyGOgAWe6zGSZm78WCJ1
   U2WGJb58QBy8TxPhadMSDDb1TwAJrJ1TZnsvIuPZrGpOizpotV5QIQP6m
   JvNfy3xo3ze/CMD2PP+ckFQRs9m5ZbaPxgVqfWpJqWRfld01b9tbJB42P
   KdbSAc55FHISH0AMTb1U2y60RoQWjuGbynZHrPS9YjZFBd0tzCdvSDk1E
   ED/A+mVEPrTqDbAyg+cVr3GBzCoAD7DmQimTJ2v4YK3NEU8ISCFzGEQyC
   gMjqZeuFj4UQl+0WMOzT1p1DAPhYETzQsQ2SkT4xab37mZIFhkD/A8GR0
   Q==;
IronPort-SDR: mXcSi05VFLRU3AVJA7Es12d6iqyOYICt32ksuS64QVZyjF9nRbYw214d3eZLaJGOyqCCdSGoOM
 75ewU8/CCtbAC0I5iZQlUwYie/BZSzkphil/lZTUEv4ghLqa2D+G3OTRgM6V6lTdje9FIvmr69
 v0nn/DPRYpBOyEtDpolRQyWgnWFr+eyzAf9hgGViAoGsfbVzlEH6VMdiAaPRe5HowuIpZYmyyt
 RgY38x11ShyuoCPBOh2dHVVhp2lVzhiXUFUZvqBmYMf2S4v4JTsEo74+fTIpC3cuXVWPFyIl2o
 8Ic=
X-IronPort-AV: E=Sophos;i="5.75,296,1589212800"; 
   d="scan'208";a="141431430"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 30 Jun 2020 07:44:15 +0800
IronPort-SDR: 1ZM4JW0RsdGniHFDWXhMKkGxaEEWvyWIU/zAaohh9M/CDb+SIZS9mhoiHHiBEqu92MRFj1NgSB
 Uoc+gt/Th1jJA51GvmyYAqQkTej3XHq6A=
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jun 2020 16:32:34 -0700
IronPort-SDR: QFmmXIwnVwMqHDqonKjxZOGDQQVIf2sH9oQwNx0KXycFd6uadSP94t6PxOe0NRoAWO/UJAx0RJ
 8ovtlsScHh/Q==
WDCIronportException: Internal
Received: from iouring.labspan.wdc.com (HELO iouring.sc.wdc.com) ([10.6.138.107])
  by uls-op-cesaip01.wdc.com with ESMTP; 29 Jun 2020 16:44:14 -0700
From:   Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
To:     linux-block@vger.kernel.org, dm-devel@redhat.com
Cc:     jack@suse.czi, rdunlap@infradead.org, sagi@grimberg.me,
        mingo@redhat.com, rostedt@goodmis.org, snitzer@redhat.com,
        agk@redhat.com, axboe@kernel.dk, paolo.valente@linaro.org,
        ming.lei@redhat.com, bvanassche@acm.org, fangguoju@gmail.com,
        colyli@suse.de, hch@lst.de,
        Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
Subject: [PATCH 06/11] block: remove extra param for trace_block_getrq()
Date:   Mon, 29 Jun 2020 16:43:09 -0700
Message-Id: <20200629234314.10509-7-chaitanya.kulkarni@wdc.com>
X-Mailer: git-send-email 2.26.0
In-Reply-To: <20200629234314.10509-1-chaitanya.kulkarni@wdc.com>
References: <20200629234314.10509-1-chaitanya.kulkarni@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Remove the extra parameter for trace_block_getrq() since we can derive
I/O direction from bio->bi_opf.

Signed-off-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
---
 block/blk-mq.c               |  2 +-
 include/trace/events/block.h | 14 ++++++--------
 kernel/trace/blktrace.c      | 13 ++++++-------
 3 files changed, 13 insertions(+), 16 deletions(-)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index dbb98b2bc868..d66bb299d4ae 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -2111,7 +2111,7 @@ blk_qc_t blk_mq_make_request(struct request_queue *q, struct bio *bio)
 		goto queue_exit;
 	}
 
-	trace_block_getrq(bio, bio->bi_opf);
+	trace_block_getrq(bio);
 
 	rq_qos_track(q, rq, bio);
 
diff --git a/include/trace/events/block.h b/include/trace/events/block.h
index d7289576f1fd..3d8923062fc4 100644
--- a/include/trace/events/block.h
+++ b/include/trace/events/block.h
@@ -347,9 +347,9 @@ DEFINE_EVENT(block_bio, block_bio_queue,
 
 DECLARE_EVENT_CLASS(block_get_rq,
 
-	TP_PROTO(struct bio *bio, int rw),
+	TP_PROTO(struct bio *bio),
 
-	TP_ARGS(bio, rw),
+	TP_ARGS(bio),
 
 	TP_STRUCT__entry(
 		__field( dev_t,		dev			)
@@ -377,22 +377,20 @@ DECLARE_EVENT_CLASS(block_get_rq,
 /**
  * block_getrq - get a free request entry in queue for block IO operations
  * @bio: pending block IO operation (can be %NULL)
- * @rw: low bit indicates a read (%0) or a write (%1)
  *
  * A request struct for queue has been allocated to handle the
  * block IO operation @bio.
  */
 DEFINE_EVENT(block_get_rq, block_getrq,
 
-	TP_PROTO(struct bio *bio, int rw),
+	TP_PROTO(struct bio *bio),
 
-	TP_ARGS(bio, rw)
+	TP_ARGS(bio)
 );
 
 /**
  * block_sleeprq - waiting to get a free request entry in queue for block IO operation
  * @bio: pending block IO operation (can be %NULL)
- * @rw: low bit indicates a read (%0) or a write (%1)
  *
  * In the case where a request struct cannot be provided for queue
  * the process needs to wait for an request struct to become
@@ -401,9 +399,9 @@ DEFINE_EVENT(block_get_rq, block_getrq,
  */
 DEFINE_EVENT(block_get_rq, block_sleeprq,
 
-	TP_PROTO(struct bio *bio, int rw),
+	TP_PROTO(struct bio *bio),
 
-	TP_ARGS(bio, rw)
+	TP_ARGS(bio)
 );
 
 /**
diff --git a/kernel/trace/blktrace.c b/kernel/trace/blktrace.c
index 7b72781a591d..1d36e6153ab8 100644
--- a/kernel/trace/blktrace.c
+++ b/kernel/trace/blktrace.c
@@ -949,8 +949,7 @@ static void blk_add_trace_bio_queue(void *ignore, struct bio *bio)
 	blk_add_trace_bio(bio, BLK_TA_QUEUE, 0);
 }
 
-static void blk_add_trace_getrq(void *ignore,
-				struct bio *bio, int rw)
+static void blk_add_trace_getrq(void *ignore, struct bio *bio)
 {
 	if (bio)
 		blk_add_trace_bio(bio, BLK_TA_GETRQ, 0);
@@ -960,14 +959,14 @@ static void blk_add_trace_getrq(void *ignore,
 		rcu_read_lock();
 		bt = rcu_dereference(bio_q(bio)->blk_trace);
 		if (bt)
-			__blk_add_trace(bt, 0, 0, rw, 0, BLK_TA_GETRQ, 0, 0,
-					NULL, 0);
+			__blk_add_trace(bt, 0, 0, bio->bi_opf, 0,
+					BLK_TA_GETRQ, 0, 0, NULL, 0);
 		rcu_read_unlock();
 	}
 }
 
 
-static void blk_add_trace_sleeprq(void *ignore, struct bio *bio, int rw)
+static void blk_add_trace_sleeprq(void *ignore, struct bio *bio)
 {
 	if (bio)
 		blk_add_trace_bio(bio, BLK_TA_SLEEPRQ, 0);
@@ -977,8 +976,8 @@ static void blk_add_trace_sleeprq(void *ignore, struct bio *bio, int rw)
 		rcu_read_lock();
 		bt = rcu_dereference(bio_q(bio)->blk_trace);
 		if (bt)
-			__blk_add_trace(bt, 0, 0, rw, 0, BLK_TA_SLEEPRQ,
-					0, 0, NULL, 0);
+			__blk_add_trace(bt, 0, 0, bio->bi_opf, 0,
+					BLK_TA_SLEEPRQ, 0, 0, NULL, 0);
 		rcu_read_unlock();
 	}
 }
-- 
2.26.0


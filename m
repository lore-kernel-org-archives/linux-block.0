Return-Path: <SRS0=rGXo=AK=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F697C433E0
	for <linux-block@archiver.kernel.org>; Mon, 29 Jun 2020 23:44:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7A2F820780
	for <linux-block@archiver.kernel.org>; Mon, 29 Jun 2020 23:44:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="hwDlQASi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727069AbgF2XoY (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 29 Jun 2020 19:44:24 -0400
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:29235 "EHLO
        esa5.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726865AbgF2XoY (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 29 Jun 2020 19:44:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1593474263; x=1625010263;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=tijSnB8jSt60tSYH9WyDHzSpzATYyWUOHH0kfxtZ+Tc=;
  b=hwDlQASiQBjRH7kpZM3CylG9ixqE8Kia+BMjdnhcesv3HqiG6RkSok53
   rqN0JTFO83gWqN/H8JkIwOj9WENWCrAlUjuoqqWvsn13caKdzE5ITCefE
   U/E5atoxm3tBnk5vw1K/NEgFoMwfyUqv3zvI7rt6dBHLzlRtzdPoamHYp
   CuFPBhlNqvpxi+vfCEiPMCHXano0SrjUdYDE7Q51DLm0a2VKTwdg+rz8C
   pXHcA33cA9olhEZ9aIqmMj3MNhfhCLCFKDOYJgsXokKXuVTcI3iufaG/q
   EdJXBxWwPXEH/lfDiOuKQDSfwJeqq6I1nN54dnKjsh+QH+VIvvt1XsCCd
   Q==;
IronPort-SDR: BOXzo4dYIODKPDbC/tH1uEj9evowgMSPAvh6Ftb3MdCtrVmGHqXq3R5Ye43c5vwbBA0fJ+A9gi
 OozYW57QBKuz28bi9ATg8KByetwPFB0nAIgaHGcsEoFaPTPgRU7ZqGEKi3AaZcgikvrXcG3phT
 GyKc4bvlP/9gUrA01jwsXC/VBnU5B9cD9KRb7NKoQCA5EeVbFN8s5h6n2BkiACslWEvjvgb3nW
 cfG0Hf8d0A0DVUPbfOslBg0rEPH+nVCw9pQHJwH8tRqXCz40R0/Jp2YC23WRmqKkWTF9VqBv7q
 uzU=
X-IronPort-AV: E=Sophos;i="5.75,296,1589212800"; 
   d="scan'208";a="141431439"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 30 Jun 2020 07:44:23 +0800
IronPort-SDR: LEMweQhxhEPySHkR+hWaMOqe9cHGpq96oUEcUwYoOet1kawzvkP17CBPBDi9V0Me43mvXNP6p1
 U0jU5H8br+4GxSD+uwqeqburI3mbory5c=
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jun 2020 16:32:43 -0700
IronPort-SDR: TMjCv1P8V1EeKz6bnWpEiZmnvuYzuTYBmaPtIh375x1fm74/Pz/7R5PydgzYumXw90ZHscENtH
 UmSWjd8gVN2A==
WDCIronportException: Internal
Received: from iouring.labspan.wdc.com (HELO iouring.sc.wdc.com) ([10.6.138.107])
  by uls-op-cesaip01.wdc.com with ESMTP; 29 Jun 2020 16:44:22 -0700
From:   Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
To:     linux-block@vger.kernel.org, dm-devel@redhat.com
Cc:     jack@suse.czi, rdunlap@infradead.org, sagi@grimberg.me,
        mingo@redhat.com, rostedt@goodmis.org, snitzer@redhat.com,
        agk@redhat.com, axboe@kernel.dk, paolo.valente@linaro.org,
        ming.lei@redhat.com, bvanassche@acm.org, fangguoju@gmail.com,
        colyli@suse.de, hch@lst.de,
        Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
Subject: [PATCH 07/11] block: get rid of blk_trace_request_get_cgid()
Date:   Mon, 29 Jun 2020 16:43:10 -0700
Message-Id: <20200629234314.10509-8-chaitanya.kulkarni@wdc.com>
X-Mailer: git-send-email 2.26.0
In-Reply-To: <20200629234314.10509-1-chaitanya.kulkarni@wdc.com>
References: <20200629234314.10509-1-chaitanya.kulkarni@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Now that we have done cleanup we can safely get rid of the
blk_trace_request_get_cgid() and replace it with
blk_trace_bio_get_cgid().

Signed-off-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
---
 kernel/trace/blktrace.c | 26 +++++++++-----------------
 1 file changed, 9 insertions(+), 17 deletions(-)

diff --git a/kernel/trace/blktrace.c b/kernel/trace/blktrace.c
index 1d36e6153ab8..bb864a50307f 100644
--- a/kernel/trace/blktrace.c
+++ b/kernel/trace/blktrace.c
@@ -804,15 +804,6 @@ u64 blk_trace_bio_get_cgid(struct request_queue *q, struct bio *bio)
 }
 #endif
 
-static u64
-blk_trace_request_get_cgid(struct request_queue *q, struct request *rq)
-{
-	if (!rq->bio)
-		return 0;
-	/* Use the first bio */
-	return blk_trace_bio_get_cgid(q, rq->bio);
-}
-
 /*
  * blktrace probes
  */
@@ -854,32 +845,32 @@ static void blk_add_trace_rq(struct request *rq, int error,
 static void blk_add_trace_rq_insert(void *ignore, struct request *rq)
 {
 	blk_add_trace_rq(rq, 0, blk_rq_bytes(rq), BLK_TA_INSERT,
-			 blk_trace_request_get_cgid(rq->q, rq));
+			 rq->bio ? blk_trace_bio_get_cgid(rq->q, rq->bio) : 0);
 }
 
 static void blk_add_trace_rq_issue(void *ignore, struct request *rq)
 {
 	blk_add_trace_rq(rq, 0, blk_rq_bytes(rq), BLK_TA_ISSUE,
-			 blk_trace_request_get_cgid(rq->q, rq));
+			 rq->bio ? blk_trace_bio_get_cgid(rq->q, rq->bio) : 0);
 }
 
 static void blk_add_trace_rq_merge(void *ignore, struct request *rq)
 {
 	blk_add_trace_rq(rq, 0, blk_rq_bytes(rq), BLK_TA_BACKMERGE,
-			 blk_trace_request_get_cgid(rq->q, rq));
+			 rq->bio ? blk_trace_bio_get_cgid(rq->q, rq->bio) : 0);
 }
 
 static void blk_add_trace_rq_requeue(void *ignore, struct request *rq)
 {
 	blk_add_trace_rq(rq, 0, blk_rq_bytes(rq), BLK_TA_REQUEUE,
-			 blk_trace_request_get_cgid(rq->q, rq));
+			 rq->bio ? blk_trace_bio_get_cgid(rq->q, rq->bio) : 0);
 }
 
 static void blk_add_trace_rq_complete(void *ignore, struct request *rq,
 			int error, unsigned int nr_bytes)
 {
 	blk_add_trace_rq(rq, error, nr_bytes, BLK_TA_COMPLETE,
-			 blk_trace_request_get_cgid(rq->q, rq));
+			 rq->bio ? blk_trace_bio_get_cgid(rq->q, rq->bio) : 0);
 }
 
 /**
@@ -1105,7 +1096,8 @@ static void blk_add_trace_rq_remap(void *ignore,
 
 	__blk_add_trace(bt, blk_rq_pos(rq), blk_rq_bytes(rq),
 			rq_data_dir(rq), 0, BLK_TA_REMAP, 0,
-			sizeof(r), &r, blk_trace_request_get_cgid(q, rq));
+			sizeof(r), &r,
+			rq->bio ? blk_trace_bio_get_cgid(q, rq->bio) : 0);
 	rcu_read_unlock();
 }
 
@@ -1134,8 +1126,8 @@ void blk_add_driver_data(struct request_queue *q,
 	}
 
 	__blk_add_trace(bt, blk_rq_trace_sector(rq), blk_rq_bytes(rq), 0, 0,
-				BLK_TA_DRV_DATA, 0, len, data,
-				blk_trace_request_get_cgid(q, rq));
+			BLK_TA_DRV_DATA, 0, len, data,
+			rq->bio ? blk_trace_bio_get_cgid(q, rq->bio) : 0);
 	rcu_read_unlock();
 }
 EXPORT_SYMBOL_GPL(blk_add_driver_data);
-- 
2.26.0


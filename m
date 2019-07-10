Return-Path: <SRS0=ACpf=VH=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B12CDC74A2B
	for <linux-block@archiver.kernel.org>; Wed, 10 Jul 2019 16:17:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 76687208E4
	for <linux-block@archiver.kernel.org>; Wed, 10 Jul 2019 16:17:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="SwmTIX0Z"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727974AbfGJQRO (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 10 Jul 2019 12:17:14 -0400
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:40537 "EHLO
        esa3.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727520AbfGJQRO (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 10 Jul 2019 12:17:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1562775434; x=1594311434;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=j0zDEuXSIQdovDOm8s3stqcFSu7ZVemsj2ZORHnJ3uE=;
  b=SwmTIX0ZIKm6y4f223owd0rMpQUCmIB+F4oy+IDZuGgXdRjPcGUCu/q9
   Jg61N4v7IhlTLuD7UbCAuVnLm/VMJpT7HjKkopgfkuoFXFpoyZh9qwf2R
   Sj6yNUd2maA/zUzXqzaMEQCge35WeHnUG9zYefyCMVnOtE7PjX6ACVhh+
   MzrppJF/HtAKQqHkc2Am5xaUvjtNuZIykBr6CG76DQFZuLTWbvYfPJsgJ
   YzFPXKeB3VDl0JuChXF/cNU9jYmrLP498mEJnZv70IVOCeyhkPfK/VfTf
   v4dIr9Jc0839YLptcYqkdSaYnqvrI/rVnFb5EIhybjXYi609bosFO1nml
   g==;
IronPort-SDR: hMsKYueJDGFlh2tHdpjtNLjoUOTTDJwDmt2wfms5009LfnQI4it4FPKRAK6MlTu0BwZuKVRzi/
 FaXrMWjY5LOne100q1m/mTg1ekJN5FOtaQFNdu3VvU4gFzXbXfbOm+sQWNUe0Nh3lyCrzXyd0m
 rAKF1R/WnPl26civ49IXj8jyhVyAa+EbiQKTElsHx4QH22evrAXpKvZHQ8/BdIBPTL7xjxFbIM
 uan34QtXY3/NW2rC1josLEAPKTGgdr+MZ/a4NiB4Ke2SypLjwlWFYIrb5ZlDqVnbu31fzZ3qNW
 sKc=
X-IronPort-AV: E=Sophos;i="5.63,475,1557158400"; 
   d="scan'208";a="117487008"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 10 Jul 2019 23:54:50 +0800
IronPort-SDR: H0wmKB2R25tjfZSAVHKFiKo++x17n+57aKlvFeBJ9w0WyRlW1PqFOPtAHlpLBqAvQ52Ide7zGC
 tP7P/o1hjonx/wAiY/MAvrc6VHIXQZmK3SG24D9uA1hhTzwmmGdvq1JCHl3nLeamo/8lCMw2qt
 ncdR3lQYGU1Wop7mOi4KJJOGsxOhnWhgTU2N67QcFkWEbLp0uoh7YpbdqjjEWtoxIvtcfk4atg
 v9xXt7GD5jAX1mY42eOH6oYmvMb7EXCzK1DCkYNtc00rGH+/DGnCdh8pxKRoePogLOtgHwfVN1
 41K2KdrQ2ZTFxsdBEeLlGWcH
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP; 10 Jul 2019 08:53:34 -0700
IronPort-SDR: f/1XsaRuw56HZKEbDZX6BNIer9/xRvg8LczqXdTiKJUQsXZRwo7/yrliMY389rdrWTo/EYcDPZ
 yOQ48krXPT3l1XV0quICZp6/i7p3Qn3TiGavlFMe4Oz+4HkCdxE7LYAULr1/hivJQkESxwqgRq
 2XJ7YV89m9wPZmOqo+EDvtHv6p5J1nDk8MZhFKwc5HOZ0cFU1sXpgUXncSe7Jxhgy1D/orbNb2
 MD8T+fsZW3s/8Nse2bx7cfxIsFJTTRMuaYKkk+h81nRbEjD048U7BWeBdKZewBMGejpKdNBtdq
 Vbw=
Received: from washi.fujisawa.hgst.com ([10.149.53.254])
  by uls-op-cesaip01.wdc.com with ESMTP; 10 Jul 2019 08:54:49 -0700
From:   Damien Le Moal <damien.lemoal@wdc.com>
To:     linux-block@vger.kernel.org, Jens Axboe <axboe@kernel.dk>
Cc:     Bart Van Assche <bvanassche@acm.org>
Subject: [PATCH V2] block: Disable write plugging for zoned block devices
Date:   Thu, 11 Jul 2019 00:54:47 +0900
Message-Id: <20190710155447.11112-1-damien.lemoal@wdc.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Simultaneously writing to a sequential zone of a zoned block device
from multiple contexts requires mutual exclusion for BIO issuing to
ensure that writes happen sequentially. However, even for a well
behaved user correctly implementing such synchronization, BIO plugging
may interfere and result in BIOs from the different contextx to be
reordered if plugging is done outside of the mutual exclusion section,
e.g. the plug was started by a function higher in the call chain than
the function issuing BIOs.

         Context A                     Context B

   | blk_start_plug()
   | ...
   | seq_write_zone()
     | mutex_lock(zone)
     | bio-0->bi_iter.bi_sector = zone->wp
     | zone->wp += bio_sectors(bio-0)
     | submit_bio(bio-0)
     | bio-1->bi_iter.bi_sector = zone->wp
     | zone->wp += bio_sectors(bio-1)
     | submit_bio(bio-1)
     | mutex_unlock(zone)
     | return
   | -----------------------> | seq_write_zone()
  				| mutex_lock(zone)
     				| bio-2->bi_iter.bi_sector = zone->wp
     				| zone->wp += bio_sectors(bio-2)
				| submit_bio(bio-2)
				| mutex_unlock(zone)
   | <------------------------- |
   | blk_finish_plug()

In the above example, despite the mutex synchronization ensuring the
correct BIO issuing order 0, 1, 2, context A BIOs 0 and 1 end up being
issued after BIO 2 of context B, when the plug is released with
blk_finish_plug().

While this problem can be addressed using the blk_flush_plug_list()
function (in the above example, the call must be inserted before the
zone mutex lock is released), a simple generic solution in the block
layer avoid this additional code in all zoned block device user code.
The simple generic solution implemented with this patch is to introduce
the internal helper function blk_mq_plug() to access the current
context plug on BIO submission. This helper returns the current plug
only if the target device is not a zoned block device or if the BIO to
be plugged is not a write operation. Otherwise, the caller context plug
is ignored and NULL returned, resulting is all writes to zoned block
device to never be plugged.

Signed-off-by: Damien Le Moal <damien.lemoal@wdc.com>
---
 block/blk-core.c |  2 +-
 block/blk-mq.c   |  2 +-
 block/blk-mq.h   | 10 ++++++++++
 3 files changed, 12 insertions(+), 2 deletions(-)

diff --git a/block/blk-core.c b/block/blk-core.c
index 8340f69670d8..3957ea6811c3 100644
--- a/block/blk-core.c
+++ b/block/blk-core.c
@@ -645,7 +645,7 @@ bool blk_attempt_plug_merge(struct request_queue *q, struct bio *bio,
 	struct request *rq;
 	struct list_head *plug_list;
 
-	plug = current->plug;
+	plug = blk_mq_plug(q, bio);
 	if (!plug)
 		return false;
 
diff --git a/block/blk-mq.c b/block/blk-mq.c
index ce0f5f4ede70..90be5bb6fa1b 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -1969,7 +1969,7 @@ static blk_qc_t blk_mq_make_request(struct request_queue *q, struct bio *bio)
 
 	cookie = request_to_qc_t(data.hctx, rq);
 
-	plug = current->plug;
+	plug = blk_mq_plug(q, bio);
 	if (unlikely(is_flush_fua)) {
 		blk_mq_put_ctx(data.ctx);
 		blk_mq_bio_to_request(rq, bio);
diff --git a/block/blk-mq.h b/block/blk-mq.h
index 633a5a77ee8b..c9195a2cd670 100644
--- a/block/blk-mq.h
+++ b/block/blk-mq.h
@@ -238,4 +238,14 @@ static inline void blk_mq_clear_mq_map(struct blk_mq_queue_map *qmap)
 		qmap->mq_map[cpu] = 0;
 }
 
+static inline struct blk_plug *blk_mq_plug(struct request_queue *q,
+					   struct bio *bio)
+{
+	if (!blk_queue_is_zoned(q) || !op_is_write(bio_op(bio)))
+		return current->plug;
+
+	/* Zoned block device write case: do not plug the BIO */
+	return NULL;
+}
+
 #endif
-- 
2.21.0


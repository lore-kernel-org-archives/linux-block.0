Return-Path: <SRS0=ruTu=VG=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB61CC606B0
	for <linux-block@archiver.kernel.org>; Tue,  9 Jul 2019 09:02:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 99E9E216C4
	for <linux-block@archiver.kernel.org>; Tue,  9 Jul 2019 09:02:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="d+PD7Ajk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725989AbfGIJCW (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 9 Jul 2019 05:02:22 -0400
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:20455 "EHLO
        esa4.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725985AbfGIJCV (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 9 Jul 2019 05:02:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1562662941; x=1594198941;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=QFFEhtTPlnJx7vpNBJ42wHRu1IlH/2nKJuOt87/gRUs=;
  b=d+PD7Ajk4tJzVAuRS4lAr8STXA7W63/oOhWE48JO7zvYJJ94JqAGspie
   ns8dSq3ELFmZWR0TqNPV+b1mpzs3m8JOeKL96ZDBRM+9uSf4kUMg+RTjy
   x/xp1PrcIxOocOtB6j48D24rE9GORfuCfpeEs1rBnljP+g4Z1ajXFEjQr
   UtfzwkPycj4wSWPUd61gbAVQyp/Ox+o2eZoLcAgUtb815pxNj9Uz3/NYl
   Y+yuYfVb+vm0mvrd/ouITk1w2MrTEG0ckeqJtiex2EKBvbwNeJTovqRZB
   Yk2b9bYN13u7B3u+AEeIvvDBS9pIOEjoe7pFZ5Vl9HW9jEy6fHIsnhcYY
   g==;
IronPort-SDR: ljwoKlEnYGBD9wE2AHdLb0Nxgw6FMgI25d+PjcPe/meWH6PdPKwwU0w6FZ+iT+JjZjpPlnhTIZ
 uAmZnoK458UiClTr9UU9uCeL0xeStR0kC0VQ5cmmmtNLylxyokJX47guhAoKXSepks9H7gN6eq
 nGpXXxkzUGoq3MpoR8epydp03JQQxPssr5F+O+RDUAT/KiKLTD6oCtBH1fDUuystk8uzGzw02J
 ak3K+9dB/gsztf1cz74lTr3bNvoVSbcmRZrMAZ6hiSHjcu8ApJ5nCkQKbWaR2LPQjs4ehnnK2M
 Jtg=
X-IronPort-AV: E=Sophos;i="5.63,470,1557158400"; 
   d="scan'208";a="112531838"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 09 Jul 2019 17:02:21 +0800
IronPort-SDR: F6bo6d1vubz1wnuOGTYcGIIQbU/w6E/KsnoBtGsv9ZGAF3FMzpRrvleXvV7HAlJLOPFvEBOoHs
 4QXpvDhVK638DHKAEzm/3eRRXDz8HOSKbBblaJq8xO/IoU9tzHj71JgcsWgMZPZ9q0XeZA8Fkf
 8D/nEzt5/pOkkv2x7U7xYiTKRBpVIJh/acLGv8RNZYPdog5BDTTRiNMFMuCIxRvGTVkDclTs2r
 zGgavR3fa6La3GBkhVCDWTL/PwqHH53ZR34n0Zsz/4eaBtBzuCsgCwdERicziWIuIEWM7uMI7V
 MCu+aMAlcnb9ofbNjKLN/s2w
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep02.wdc.com with ESMTP; 09 Jul 2019 02:01:08 -0700
IronPort-SDR: nmZHKQGjlsBvW0M+pTcKy9sbXw2iMlRAAxlbiKZ3RNjxuXOrRBxPyjqf3oWG9kDgO/NXzezC2s
 qNo22J4D2je1rVSRg1s0eJM+G7GJ11QcD9GrqL/MhpZZL2d82ai3Gf/zzSoyhIBKG9ZpYzQj4s
 Zjdy0Sf+YZjnyVCTt6EnKKMpH/WYJ3lchZZEzgoG/nLo4fMu79f3GgIjxePhtDuxC41kH7htj8
 ngjLd+sWwJQptToKTZesUV7qfvw8xZzWuxhAR99PsPidwBYN8x0d7JERzgpUqgJjpr57gNjuIN
 ayo=
Received: from washi.fujisawa.hgst.com ([10.149.53.254])
  by uls-op-cesaip01.wdc.com with ESMTP; 09 Jul 2019 02:02:20 -0700
From:   Damien Le Moal <damien.lemoal@wdc.com>
To:     linux-block@vger.kernel.org, Jens Axboe <axboe@kernel.dk>
Cc:     Christoph Hellwig <hch@lst.de>,
        Matias Bjorling <matias.bjorling@wdc.com>
Subject: [PATCH] block: Disable write plugging for zoned block devices
Date:   Tue,  9 Jul 2019 18:02:19 +0900
Message-Id: <20190709090219.8784-1-damien.lemoal@wdc.com>
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

      Context A                           Context B

   | blk_start_plug()
   | ...
   | seq_write_zone()
     | mutex_lock(zone)
     | submit_bio(bio-0)
     | submit_bio(bio-1)
     | mutex_unlock(zone)
     | return
   | ------------------------------> | seq_write_zone()
  				       | mutex_lock(zone)
				       | submit_bio(bio-2)
				       | mutex_unlock(zone)
   | <------------------------------ |
   | blk_finish_plug()

In the above example, despite the mutex synchronization resulting in the
correct BIO issuing order 0, 1, 2, context A BIOs 0 and 1 end up being
issued after BIO 2 when the plug is released with blk_finish_plug().

To fix this problem, introduce the internal helper function
blk_mq_plug() to access the current context plug, return the current
plug only if the target device is not a zoned block device or if the
BIO to be plugged not a write operation. Otherwise, ignore the plug and
return NULL, resulting is all writes to zoned block device to never be
plugged.

Signed-off-by: Damien Le Moal <damien.lemoal@wdc.com>
---
 block/blk-core.c |  2 +-
 block/blk-mq.c   |  2 +-
 block/blk-mq.h   | 12 ++++++++++++
 3 files changed, 14 insertions(+), 2 deletions(-)

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
index 633a5a77ee8b..d9b1e94b82a4 100644
--- a/block/blk-mq.h
+++ b/block/blk-mq.h
@@ -238,4 +238,16 @@ static inline void blk_mq_clear_mq_map(struct blk_mq_queue_map *qmap)
 		qmap->mq_map[cpu] = 0;
 }
 
+static inline struct blk_plug *blk_mq_plug(struct request_queue *q,
+					   struct bio *bio)
+{
+	struct blk_plug *plug = current->plug;
+
+	if (!blk_queue_is_zoned(q) || !op_is_write(bio_op(bio)))
+		return plug;
+
+	/* Zoned block device write case: do not plug the BIO */
+	return NULL;
+}
+
 #endif
-- 
2.21.0


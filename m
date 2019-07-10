Return-Path: <SRS0=ACpf=VH=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32DAAC74A21
	for <linux-block@archiver.kernel.org>; Wed, 10 Jul 2019 16:18:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EA5EA208E4
	for <linux-block@archiver.kernel.org>; Wed, 10 Jul 2019 16:18:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="mOeDQxfN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727528AbfGJQSg (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 10 Jul 2019 12:18:36 -0400
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:25698 "EHLO
        esa4.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727520AbfGJQSg (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 10 Jul 2019 12:18:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1562775516; x=1594311516;
  h=from:to:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=2GYmRz/cqU/GcOrb6cQ/fAYZVV1DBRix49T1KwGMTh8=;
  b=mOeDQxfNHpfakkyTzVW2vHXakJos0UESYHpBxIYXf2+X3zlP9fKn9DE7
   EUde9OGDrB1X7Baj1RlHBa7DUNJ+gZU/1QL20YDeQL1eTO/LN87krhV/8
   4BbH4CCEExKUsgF7ESCHUZJxUwKvuc/0hGM/u4V71VafAGSAlFPML+pzF
   yNopNSsRqd2b7vA8nh62bK4C4jWmc4wVnXB3/YMwPVpAFVMRa7CrDkusK
   6jT5MiPb/Z73c1T2cqysacx5UzlBw9iVPPRnincZIcgfTVgKEMdEeQIG5
   lVCCrFX3/cB/rWdU7dxfNurq5smSX9ql2mRSu7irtde7KD+Mtprll5/63
   A==;
IronPort-SDR: s/ZjOkFUYlLxFcoPcE4W67qVQxr5D026oHHwbzuCBH6ux5jgmhtoy5uABXip/msphlYZQ6NqIE
 FlNkVKPHImlht38BY3km/htC7T6vY31TcymLFHCmdPP7yaojMGxW4otsN5t4htpowDRDGdFpLV
 3k40v1fX+RiDYIOuML8dzFkabCIqTPPt8XoYC45pikq7L2SjFYTKuuhz8LCP9VofhDkeTY5W78
 I8CWsMUL/nWbv0wtQEcEIRB2C76kKGzQpGJZ58O/dfNT4NkRpYpZLHoUInLMAPlAFiNqc0TbVL
 4Z0=
X-IronPort-AV: E=Sophos;i="5.63,475,1557158400"; 
   d="scan'208";a="112681105"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 11 Jul 2019 00:18:33 +0800
IronPort-SDR: RNitutdDi6vX3eHm6bJnSAUeFNoHGmNlG9HuErXOiCozecvbvXdNIe4yJcBaMMQDzfVJGio2aD
 Efpwps+nIKgjH8qRyRnbNOCZt4OFNersonzpLsuKKEPW+Vd6gaXYuZzdwjxaHtkHLLBYxM7idr
 SVkz2/CduvwGoukn2g6pFFnQPPie+GsqnGyjYUnl8uVUjC2VrGnDIe197H04TkHs7Rvhe7u7g/
 H7oWYga7cVlBz0ALLMePt3lMo4nyyICStrxKm4JnFQCn1zM/5QfvjD0Qn97YhAPixBDX7wB3z5
 4MQCsz738zEB2IjF7mWLQBK+
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep02.wdc.com with ESMTP; 10 Jul 2019 09:17:14 -0700
IronPort-SDR: KUnJrVp/WXTiFGA9FL6vWMmEKl7HtIVbpALMQyrhWxJg37Yxb5sxfSUxbk4BFeGNVgGK/hjwrM
 fhQfbi/pvAlorWR0Dw6+b3KIp+wwmRdGr1neji6DFMCRwmIMCSEtIp6F1sF2d/y0hV6XOmYvs7
 HYMXn59izd2PFvSlsXkJLTZmCcKIaAAiRT+5W2YXYSjGimZkI7YkSz6MhVtiWel/0sqQZFsr7q
 H/oLKCpcvH6wHdAsJ2rAsiVFm3mhpn5h1x8ElY1XHhQ0HlkyriEOoof0ASDpF375V2n1Bf1Ni2
 Jr8=
Received: from washi.fujisawa.hgst.com ([10.149.53.254])
  by uls-op-cesaip01.wdc.com with ESMTP; 10 Jul 2019 09:18:32 -0700
From:   Damien Le Moal <damien.lemoal@wdc.com>
To:     linux-block@vger.kernel.org, Jens Axboe <axboe@kernel.dk>
Subject: [PATCH V3] block: Disable write plugging for zoned block devices
Date:   Thu, 11 Jul 2019 01:18:31 +0900
Message-Id: <20190710161831.25250-1-damien.lemoal@wdc.com>
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
 block/blk-mq.h   | 32 ++++++++++++++++++++++++++++++++
 3 files changed, 34 insertions(+), 2 deletions(-)

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
index 633a5a77ee8b..4a63c96188c5 100644
--- a/block/blk-mq.h
+++ b/block/blk-mq.h
@@ -238,4 +238,36 @@ static inline void blk_mq_clear_mq_map(struct blk_mq_queue_map *qmap)
 		qmap->mq_map[cpu] = 0;
 }
 
+/*
+ * blk_mq_plug() - Get caller context plug
+ * @q: request queue
+ * @bio : the bio being submitted by the caller context
+ *
+ * Plugging, by design, may delay the insertion of BIOs into the elevator in
+ * order to increase BIO merging opportunities. This however can cause BIO
+ * insertion order to change from the order in which submit_bio() is being
+ * executed in the case of multiple contexts concurrently issuing BIOs to a
+ * device, even if these context are synchronized to tightly control BIO issuing
+ * order. While this is not a problem with regular block devices, this ordering
+ * change can cause write BIO failures with zoned block devices as these
+ * require sequential write patterns to zones. Prevent this from happening by
+ * ignoring the plug state of a BIO issuing context if the target request queue
+ * is for a zoned block device and the BIO to plug is a write operation.
+ *
+ * Return current->plug if the bio can be plugged and NULL otherwise
+ */
+static inline struct blk_plug *blk_mq_plug(struct request_queue *q,
+					   struct bio *bio)
+{
+	/*
+	 * For regular block devices or read operations, use the context plug
+	 * which may be NULL if blk_start_plug() was not executed.
+	 */
+	if (!blk_queue_is_zoned(q) || !op_is_write(bio_op(bio)))
+		return current->plug;
+
+	/* Zoned block device write operation case: do not plug the BIO */
+	return NULL;
+}
+
 #endif
-- 
2.21.0


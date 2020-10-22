Return-Path: <SRS0=SOzO=D5=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3368BC55178
	for <linux-block@archiver.kernel.org>; Thu, 22 Oct 2020 01:03:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CA5402244C
	for <linux-block@archiver.kernel.org>; Thu, 22 Oct 2020 01:03:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="irGT1CRy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2894554AbgJVBDW (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 21 Oct 2020 21:03:22 -0400
Received: from esa6.hgst.iphmx.com ([216.71.154.45]:59966 "EHLO
        esa6.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2440469AbgJVBDW (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 21 Oct 2020 21:03:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1603328601; x=1634864601;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=ZjuoyMHl/0ocfowOMPnoFX7SM4xH6ht94j8DCRztaGo=;
  b=irGT1CRyNy11TFDohyCRY5q2niqjUFE3zf7IRpk9C3+b8vH076Zqyynd
   38MjTdTMvqtLQreJgiN9DtNlyMnHqAPGe1wjZoaoae0USAmBy+KOepGRo
   9luaM7F80mSM/7/lxtD1XBzEr8pcyFVd/RWGQRkVzE2K1tDeoWays2Y8G
   IWX3TUD9GkQskjkDavn7n3rssNXra96Hhvvh4atwoKlrADtRrdoki0ZXW
   ZX9fakxeT41fXjmgY+bOApa3C9hM94ro+z5bKSJ+XeKq8TES1mteKXlAC
   DecVopCx0e/DY9GLFSPXavaPMenHgcVhXv8abXvLnOfhVizOzkK8gPyUL
   w==;
IronPort-SDR: /llUuxA1XZxSC+AQfwwN7ZnHB3gMbV0nbiu+Q7Cv9TA6qIlFA0VpKnuFuAYpU0aBkps54o7tmI
 fEfzIzv0WnNHqt5ZQMYiUBht/CxhMqPZxMjWQ6Sg+nCBvWLgu0TlE4NqHkcqw8wHe9Om3Ro5kw
 t2yKAulIMqG7pbq3nK5a/ewu1a1RnLgBgxYpgG2sIKh5w0xjj/oS1kW32sZmSW4SxlGeu8/0Uz
 5z9Bf650btNS3bLx13WU5/gp39GdGiYEH+rsatrv5ICCPXa+EGzjsrzCNl9GT3p17eTi2Fc+lw
 9JY=
X-IronPort-AV: E=Sophos;i="5.77,402,1596470400"; 
   d="scan'208";a="151798028"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 22 Oct 2020 09:03:20 +0800
IronPort-SDR: G59NYVSisCYU+lZeI00huyuEVdYGE+avnJ9YD5zoLn+fmv3/0DNjRnsmVox1BQEVtEClC1tKHF
 Ji7LWJAN+iv5Sa4ZrGIYUIWBjSYTMVIGHMMRC9sL61cmkxWAlAZMRIFzfuP6FXx+vUxhJLh5Eb
 qzHGV/0cusdOmTOIGVCvEu5ZVNZ7n3GAfr8qZhTiY9hmKccFC2QxxtmdkaBJYS1mmlq6+Eyd80
 aqLwQbuyKueux3AXYz112CuSs+AqwpLZmsvd2Qi4hG+eV56A8w+GmzW//MwvKzY6R76pRo+TPn
 yA4ZFJVD+/TFT0V0+rLNEpkL
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Oct 2020 17:48:53 -0700
IronPort-SDR: tFvkaRu8x1mKxkoX4SXoM8AXOzEb5BaJcg/3a7oijkA4ynzu0K8QAYWv9/9B8jD9j6JyAI16os
 5DET0GzAGIAi3VE0NUF7KXw+PU88vagDlKzHGDoSrhCfQBAjVaiUAbRn/1GrQ/nOJnAV03moUx
 GMNuOooj9wuAxW+/XY97o7hBbdOWlkqAOLQJ2I2xEo1a9IQ6YEsVuIXSqf/ae4Cl9IW4RsUk1L
 PZSBP/SmWghO6lWVjfnIl1zo9m5092tlltDKqD32GzQIHLfNDCXDt/CPhYRYHCI6PR3bshdKYc
 USM=
WDCIronportException: Internal
Received: from vm.labspan.wdc.com (HELO vm.sc.wdc.com) ([10.6.137.102])
  by uls-op-cesaip02.wdc.com with ESMTP; 21 Oct 2020 18:03:21 -0700
From:   Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
To:     linux-block@vger.kernel.org, linux-nvme@lists.infradead.org
Cc:     hch@lst.de, sagi@grimberg.me, kbusch@kernel.org,
        logang@deltatee.com,
        Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
Subject: [PATCH V3 5/6] nvmet: use minimized version of blk_rq_append_bio
Date:   Wed, 21 Oct 2020 18:02:33 -0700
Message-Id: <20201022010234.8304-6-chaitanya.kulkarni@wdc.com>
X-Mailer: git-send-email 2.22.1
In-Reply-To: <20201022010234.8304-1-chaitanya.kulkarni@wdc.com>
References: <20201022010234.8304-1-chaitanya.kulkarni@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

The function blk_rq_append_bio() is a genereric API written for all
types driver (having bounce buffers) and different context (where
request is already having a bio i.e. rq->bio != NULL).

It does mainly three things: calculating the segments, bounce queue and
if req->bio == NULL call blk_rq_bio_prep() or handle low level merge()
case.

The NVMe PCIe and fabrics transports currently does not use queue
bounce mechanism. In order to find this for each request processing
in the passthru blk_rq_append_bio() does extra work in the fast path
for each request.

When I ran I/Os with different block sizes on the passthru controller
I found that we can reuse the req->sg_cnt instead of iterating over the
bvecs to find out nr_segs in blk_rq_append_bio(). This calculation in
blk_rq_append_bio() is a duplication of work given that we have the
value in req->sg_cnt. (correct me here if I'm wrong).

With NVMe passthru request based driver we allocate fresh request each
time, so every call to blk_rq_append_bio() rq->bio will be NULL i.e.
we don't really need the second condition in the blk_rq_append_bio()
and the resulting error condition in the caller of blk_rq_append_bio().

So for NVMeOF passthru driver recalculating the segments, bounce check
and ll_back_merge code is not needed such that we can get away with the
minimal version of the blk_rq_append_bio() which removes the error check
in the fast path along with extra variable in nvmet_passthru_map_sg().

This patch updates the nvmet_passthru_map_sg() such that it does only
appending the bio to the request in the context of the NVMeOF Passthru
driver. Following are perf numbers :-

With current implementation (blk_rq_append_bio()) :-
----------------------------------------------------
+    5.80%     0.02%  kworker/0:2-mm_  [nvmet]  [k] nvmet_passthru_execute_cmd
+    5.44%     0.01%  kworker/0:2-mm_  [nvmet]  [k] nvmet_passthru_execute_cmd
+    4.88%     0.00%  kworker/0:2-mm_  [nvmet]  [k] nvmet_passthru_execute_cmd
+    5.44%     0.01%  kworker/0:2-mm_  [nvmet]  [k] nvmet_passthru_execute_cmd
+    4.86%     0.01%  kworker/0:2-mm_  [nvmet]  [k] nvmet_passthru_execute_cmd
+    5.17%     0.00%  kworker/0:2-eve  [nvmet]  [k] nvmet_passthru_execute_cmd

With this patch using blk_rq_bio_prep() :-
----------------------------------------------------
+    3.14%     0.02%  kworker/0:2-eve  [nvmet]  [k] nvmet_passthru_execute_cmd
+    3.26%     0.01%  kworker/0:2-eve  [nvmet]  [k] nvmet_passthru_execute_cmd
+    5.37%     0.01%  kworker/0:2-mm_  [nvmet]  [k] nvmet_passthru_execute_cmd
+    5.18%     0.02%  kworker/0:2-eve  [nvmet]  [k] nvmet_passthru_execute_cmd
+    4.84%     0.02%  kworker/0:2-mm_  [nvmet]  [k] nvmet_passthru_execute_cmd
+    4.87%     0.01%  kworker/0:2-mm_  [nvmet]  [k] nvmet_passthru_execute_cmd

Signed-off-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
Reviewed-by: Logan Gunthorpe <logang@deltatee.com>
---
 drivers/nvme/target/passthru.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/drivers/nvme/target/passthru.c b/drivers/nvme/target/passthru.c
index e5b5657bcce2..496ffedb77dc 100644
--- a/drivers/nvme/target/passthru.c
+++ b/drivers/nvme/target/passthru.c
@@ -183,7 +183,7 @@ static int nvmet_passthru_map_sg(struct nvmet_req *req, struct request *rq)
 	int sg_cnt = req->sg_cnt;
 	struct scatterlist *sg;
 	struct bio *bio;
-	int i, ret;
+	int i;
 
 	bio = bio_alloc(GFP_KERNEL, min(sg_cnt, BIO_MAX_PAGES));
 	bio->bi_end_io = bio_put;
@@ -198,11 +198,7 @@ static int nvmet_passthru_map_sg(struct nvmet_req *req, struct request *rq)
 		sg_cnt--;
 	}
 
-	ret = blk_rq_append_bio(rq, &bio);
-	if (unlikely(ret)) {
-		bio_put(bio);
-		return ret;
-	}
+	blk_rq_bio_prep(rq, bio, req->sg_cnt);
 
 	return 0;
 }
-- 
2.22.1


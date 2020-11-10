Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 196FCC2D0A3
	for <linux-block@archiver.kernel.org>; Tue, 10 Nov 2020 02:24:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B872220789
	for <linux-block@archiver.kernel.org>; Tue, 10 Nov 2020 02:24:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="MjjVk3CU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730460AbgKJCYh (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 9 Nov 2020 21:24:37 -0500
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:31474 "EHLO
        esa4.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730151AbgKJCYg (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Mon, 9 Nov 2020 21:24:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1604975076; x=1636511076;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=/RfTDNkwgpWkWBDLqJjIjFnT/dbeT/R3kr2Wn8mjMuQ=;
  b=MjjVk3CUhFfxDtuGTizIW1qFQ8oCsvianONmNZIMcr2hdBO37e+wkrln
   Cpvt5bfZ8UCtEFtwFyoqPCWMGjgRjWbegoVk2qCjqo577m11FoZojv9FF
   ARcHOZpHH8dKpJArdSBdqNg0BP0x5U9vnZ1cFqIPlDPffIHZad6EWFkNX
   DS+8AJs3UeVSe2FduCeXeljcT9SIye01Tp14QocJzv28tFIsdSM9e+rJY
   Ovk96bXLznEDhVos9odfAFAlkY6DvH+cNHh9xnbbl8t2BPwh6nhA4SJrH
   t41AudeJ5bBUg80U2VEE3HI8ioZ/cPZQ4J6OS1XtSGb+PwLPJGnvoB33P
   Q==;
IronPort-SDR: oceGT7T+NiUzw1Qxc803Tw6whgBKbgU/noTMt+uxFGu58H+5CPC6GcqHWRJyqAN42hIVrjseKa
 LdLh4KPBLWELMikuXsobXjr+6LYieHTT6tIsUCiNv3JVEGYAXsNukHtm8ug+1lme5BI+5A4QwH
 H9U2f3cl+gzCgMR0arWAi1oe3KC4g6zG/2g5ULsYZa5JaDcp8TjUyRBGLhDGAInZc4REPS364u
 P+g9y2nKeX+JqcMFXS7W8sz40VI0tH0GRrX7FeRqUzdBvcO3cTOrB41na0HQ43QjAC41y4yec/
 RwE=
X-IronPort-AV: E=Sophos;i="5.77,465,1596470400"; 
   d="scan'208";a="152138853"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 10 Nov 2020 10:24:36 +0800
IronPort-SDR: Tf27/cLySCjj7MxZudF5o6lvO0yzBLnALc60qLbYUL7byxG9fKUFeRplvKpQhzCE/HV3L6k9xR
 vV9ULeDRKxcD6GzLCfEucrL7W8ttM9dgSRJU4NW7eDd5sy+V40Qa5Y15TuLQwMs6nKADikTRcg
 TXZ3IIxMI3GYAjp+DYdk7QOReCWtnT7tOrwXbyaPggYEhd00YEOjRQMOV4T36FUQLKE3H7krZn
 H3JlnlO545Zky7W19xYeUnObzZFZx9jtYn+DI6jXCHQVK/Nk4aCXImMf2q/ibO5Z65c1sDhy4w
 5VoPndgzxQmTTHir078BOiTZ
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Nov 2020 18:10:37 -0800
IronPort-SDR: fDganRMlCaQp3MSRVYAu8NWNLjqdHtujaw/NaGfjGAdpEVDU3gDumfmKd8N38DXOACk3t+iLy+
 ELUxRGG5cOedh6rH8wzXVq+NcDF8zy0y1/uUrl/pSF6OSqJEaX9LPsu8p89nrME4LSSuH+ee2c
 l97/rkz1j7rjRe9iQubX32xfgXXEovRQYlx7fQwULRbuvgi160JiDLuMriN7ZZvGiCAzpM8Lw3
 pRm5x96I+AlYVePekG6YOAPLtuiXJR2xNfhtrDD+A2SosNC4b55RZCx2tavOFhYVlyDS5TN44C
 6dk=
WDCIronportException: Internal
Received: from vm.labspan.wdc.com (HELO vm.sc.wdc.com) ([10.6.137.102])
  by uls-op-cesaip02.wdc.com with ESMTP; 09 Nov 2020 18:24:35 -0800
From:   Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
To:     linux-nvme@lists.infradead.org, linux-block@vger.kernel.org
Cc:     axboe@kernel.dk, kbusch@kernel.org, sagi@grimberg.me, hch@lst.de,
        Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>,
        Logan Gunthorpe <logang@deltatee.com>
Subject: [PATCH V4 4/6] block: move blk_rq_bio_prep() to linux/blk-mq.h
Date:   Mon,  9 Nov 2020 18:24:03 -0800
Message-Id: <20201110022405.6707-5-chaitanya.kulkarni@wdc.com>
X-Mailer: git-send-email 2.22.1
In-Reply-To: <20201110022405.6707-1-chaitanya.kulkarni@wdc.com>
References: <20201110022405.6707-1-chaitanya.kulkarni@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

This is a preparation patch to have minimal block layer request bio
append functionality in the context of the NVMeOF Passthru driver which
falls in the fast path and doesn't need calls from blk_rq_append_bio().

Signed-off-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
Reviewed-by: Logan Gunthorpe <logang@deltatee.com>
---
 block/blk.h            | 12 ------------
 include/linux/blk-mq.h | 12 ++++++++++++
 2 files changed, 12 insertions(+), 12 deletions(-)

diff --git a/block/blk.h b/block/blk.h
index dfab98465db9..e05507a8d1e3 100644
--- a/block/blk.h
+++ b/block/blk.h
@@ -91,18 +91,6 @@ static inline bool bvec_gap_to_prev(struct request_queue *q,
 	return __bvec_gap_to_prev(q, bprv, offset);
 }
 
-static inline void blk_rq_bio_prep(struct request *rq, struct bio *bio,
-		unsigned int nr_segs)
-{
-	rq->nr_phys_segments = nr_segs;
-	rq->__data_len = bio->bi_iter.bi_size;
-	rq->bio = rq->biotail = bio;
-	rq->ioprio = bio_prio(bio);
-
-	if (bio->bi_disk)
-		rq->rq_disk = bio->bi_disk;
-}
-
 #ifdef CONFIG_BLK_DEV_INTEGRITY
 void blk_flush_integrity(void);
 bool __bio_integrity_endio(struct bio *);
diff --git a/include/linux/blk-mq.h b/include/linux/blk-mq.h
index b23eeca4d677..d1d277073761 100644
--- a/include/linux/blk-mq.h
+++ b/include/linux/blk-mq.h
@@ -591,6 +591,18 @@ static inline void blk_mq_cleanup_rq(struct request *rq)
 		rq->q->mq_ops->cleanup_rq(rq);
 }
 
+static inline void blk_rq_bio_prep(struct request *rq, struct bio *bio,
+		unsigned int nr_segs)
+{
+	rq->nr_phys_segments = nr_segs;
+	rq->__data_len = bio->bi_iter.bi_size;
+	rq->bio = rq->biotail = bio;
+	rq->ioprio = bio_prio(bio);
+
+	if (bio->bi_disk)
+		rq->rq_disk = bio->bi_disk;
+}
+
 blk_qc_t blk_mq_submit_bio(struct bio *bio);
 
 #endif
-- 
2.22.1


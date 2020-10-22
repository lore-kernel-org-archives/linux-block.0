Return-Path: <SRS0=SOzO=D5=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A450C2D0A3
	for <linux-block@archiver.kernel.org>; Thu, 22 Oct 2020 01:03:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B52992244C
	for <linux-block@archiver.kernel.org>; Thu, 22 Oct 2020 01:03:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=permerror (0-bit key) header.d=wdc.com header.i=@wdc.com header.b="mfY8c4nV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2441063AbgJVBDO (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 21 Oct 2020 21:03:14 -0400
Received: from esa2.hgst.iphmx.com ([68.232.143.124]:28452 "EHLO
        esa2.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2440469AbgJVBDN (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 21 Oct 2020 21:03:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1603329098; x=1634865098;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=/RfTDNkwgpWkWBDLqJjIjFnT/dbeT/R3kr2Wn8mjMuQ=;
  b=mfY8c4nVJFbLYrKuR5JjjEmYLfoXjgmr03T6bcUSjPwmZvMiC7KaG7pZ
   eJWRmjYIl1tZnGBMNQTmUgGgl223C02TK1HT3CxJ763VWf3+FnjO7AdDK
   /so97oTq+HnYS9vJfJyG/jC0GiEpp3mqI1kHnDAqcC7ve/NcGaeqXvgZy
   Dpetzl00oJzZaX3UF4Xf/UHsHHmAtPwWRrp/yrogKF1K3psc3B1R76gfV
   vLRD1Y1LDifXOI6VVzSSYCsuipeBXl5CEiHkxqPqAUj4ztUzkhhRnKrnJ
   sne5CHdRkYjHtNiY9XrH63AkctAflKYU0L1nON27jkfulwF9O7QSTQUzQ
   Q==;
IronPort-SDR: 0JX9FqkuQHwf0LmadtJ5LP/ZeqTJL+D213zg/HSr2nk3kPR/rFcCsacCHu8rTIV5jAq8WfXGCr
 klYNtslMrQw8RWYEjT/Sv06xWkTi1AOXbKw/9Wkk66OL5nAAeqS2A1O8MfphMYhHK97KhGnKMw
 EcBn0A6Dda9G6bqwhtS8aI14PnDwcHT3V/Dj8eMPjzMeKMWBObU7ESPW0Ox1xftw3QE94pXuCX
 cNcaVy/gwWiKqmAPJqT9beYTzUroyvx9Y4omm+nkCEbnhi+1k28juCTu3aMAGJau2kzmu85Y43
 bTY=
X-IronPort-AV: E=Sophos;i="5.77,402,1596470400"; 
   d="scan'208";a="254069127"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 22 Oct 2020 09:11:38 +0800
IronPort-SDR: GTXmbWd+wiWIDu68zguGYopOewtwsxijIyh09jY20BGp9G89f7nRtoo2sDPdr8AjWNq4v1antA
 dREcHA0mqUJLNGAyR9sltiraDCu0of2sX7ytJtPQPi67yrmaZa2NFuzHxPIRAZ54tevygH2mHC
 XFi2IogXoea2BR0QW5udbh3MylBUwrdXZ0rPl44xhBLUEIOR3NOuhPyLWDwotzH5JO+5FHHGD5
 81mbNqKGQ63mwXtBzFgYyjZl4O7zpRJxVx80YS5Q++OiePW7heHcdVOONuo1ut8hfj6XQWEKb2
 WToeriBilMxc6xmBNHOMgz3z
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Oct 2020 17:49:37 -0700
IronPort-SDR: R3PBID0f94uoiQ6ju64A/GLZ0XL/NIYbC2b0dR2GUtfcspSUZDFR0ENg/IrW2Ne1/h5dyHGvf0
 7hl+sMUvNM4dxTMcOcFD5WyxfBT59aRnqRUtemncthgRfF42nLwrr9Il5y4fF0u84wdUdhXxxb
 HmNNBYlsaF9q7Lm8IITGcmV69bL6xuOotmIAEIE8fTfz2HPr8I9cgz89xMBn4dwQhCgJTg+/Qr
 Fuh7agPymWeQj/CviyKDo0c+XKra0++jIl+j5SLkoMd0ckvnoV7/+e0HpOT/ZPiwv7Yy336yK3
 /Ig=
WDCIronportException: Internal
Received: from vm.labspan.wdc.com (HELO vm.sc.wdc.com) ([10.6.137.102])
  by uls-op-cesaip02.wdc.com with ESMTP; 21 Oct 2020 18:03:13 -0700
From:   Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
To:     linux-block@vger.kernel.org, linux-nvme@lists.infradead.org
Cc:     hch@lst.de, sagi@grimberg.me, kbusch@kernel.org,
        logang@deltatee.com,
        Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
Subject: [PATCH V3 4/6] block: move blk_rq_bio_prep() to linux/blk-mq.h
Date:   Wed, 21 Oct 2020 18:02:32 -0700
Message-Id: <20201022010234.8304-5-chaitanya.kulkarni@wdc.com>
X-Mailer: git-send-email 2.22.1
In-Reply-To: <20201022010234.8304-1-chaitanya.kulkarni@wdc.com>
References: <20201022010234.8304-1-chaitanya.kulkarni@wdc.com>
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


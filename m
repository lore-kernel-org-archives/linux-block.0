Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82657C433E1
	for <linux-block@archiver.kernel.org>; Wed, 24 Mar 2021 15:48:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 505DA61A0F
	for <linux-block@archiver.kernel.org>; Wed, 24 Mar 2021 15:48:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236565AbhCXPrl (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 24 Mar 2021 11:47:41 -0400
Received: from esa1.hgst.iphmx.com ([68.232.141.245]:25442 "EHLO
        esa1.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236754AbhCXPrk (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 24 Mar 2021 11:47:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1616600860; x=1648136860;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=YhAeGvWqI6lZWCX5W99oeTpWVwYgezFTqgYyYJciD4I=;
  b=O3Wo184oSJTS4bu0fPZ8bIWm7Tz+dIRIMlsOzoFl0il3vXNWEaoxtD1C
   agzMITc+Y/AiyRhEkWubWNcu2rV2LCUG1igcvsW+yodWhMOY5zuBi0nPD
   xicXoWO4BN0ILEPNyNi4cKEhI0Cdvl30GR7P9v6mMm+DJ8PecYHHaqhqO
   WXi1uJNbxJxnwiRgRcB6UeUlIxxzTVLqeEVt5FpEmbWtcZYozmxrWPlBv
   6XSY7JeqHLQQbsbdJwSoih/tzjBBtI61Hy6z4DI4P2/eLy2LPgx6fxiWy
   nLHRlD5nMjMkVdQgv/U4g54gQHWYAqszZyoRYY666PTBHVc1q6tpenlPh
   Q==;
IronPort-SDR: X661I8syewMkzVkzTOsPx6hsDwEH2Js2XYaMnx20Un9U2QjDNoBPSbkobquV746sbWDhRAaLjT
 YekwfkgdPz+pRLoN/LWrorRv13nn/HECe7nF6RF3pZjocJMh0bd+mnHGBIslyubdwGIunKZ0NJ
 29rjkBP28j4nFhZt309tiTlDb3LC2Tix6PRV2T1f6iIMBzguHhlBDiAw39mkjpQ+zhk8ueiM9R
 KPsHKvcXv923YCtJnX6BdH1LO3W3c7l0EH9TSPNt1SOT1fplt6Z6joh2FNSvEBhN/XZjY9wD6Z
 +HY=
X-IronPort-AV: E=Sophos;i="5.81,275,1610380800"; 
   d="scan'208";a="273671250"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 24 Mar 2021 23:47:38 +0800
IronPort-SDR: C8NT5i3ObKGA5oNDpsp0FS+vEA4ItT30KfHZQMYa0uleHMjdzyKf243oD8GVgoipnDrY8aL5Cx
 AULfsF84vX4R9dsqO+E3REpdm0zRSE8qxhngcKlAi6uL29WYeb8GMbrHqd/DFw5H/ydvAZ4zv2
 sbO/ul29TfNL9nKnR0sbzLZ48ok43JjQ3+UFg3dFeNU3iigPaZbzZGHrEL49WrXLAC7q0X1JQa
 DiRFCUAEVOhKIQydtliFpEEY8IbA1SN1jkaKhZhTeqVQxvQxFThhRGtnMhrNhQy5RlOTofYY4c
 l2HkM/WP0eRb2vkk2X0P4anv
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Mar 2021 08:29:43 -0700
IronPort-SDR: SUEeMglN8kzThk8ldjg6FpRzJAeYeJHBtM+9frc4ixmiHavJxP5tM5s/nptxFHKKpPwk26Ob81
 I2OCs6aSc72B+Dqa4CnsID2OqyPMZkC9n4uXETOifeJA7nI8FjR8N5LnqCOWEulxZMU/h1Isu4
 79wh7ESWaYGbgJ/afFDUi4rxo4oodyv2UH0dC0sk5ICW44oEd3yEJxxof2D9wr4g46tx5QVSBw
 bMKMAkCZdWfKMh0mpg6Qz6a8F5PDdqjBZA+FzmjQHftvM8rSR0RW0JbEafuhN4mxedWOHhH22e
 zwM=
WDCIronportException: Internal
Received: from unknown (HELO redsun60.ssa.fujisawa.hgst.com) ([10.149.66.36])
  by uls-op-cesaip02.wdc.com with ESMTP; 24 Mar 2021 08:47:38 -0700
From:   Johannes Thumshirn <johannes.thumshirn@wdc.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org,
        Damien Le Moal <Damien.LeMoal@wdc.com>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        Naohiro Aota <naohiro.aota@wdc.com>,
        Christoph Hellwig <hch@lst.de>
Subject: [PATCH v2] block: support zone append bvecs
Date:   Thu, 25 Mar 2021 00:47:26 +0900
Message-Id: <10bd414d9326c90cd69029077db63b363854eee5.1616600835.git.johannes.thumshirn@wdc.com>
X-Mailer: git-send-email 2.30.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Christoph reported that we'll likely trigger the WARN_ON_ONCE() checking
that we're not submitting a bvec with REQ_OP_ZONE_APPEND in
bio_iov_iter_get_pages() some time ago using zoned btrfs, but I couldn't
reproduce it back then.

Now Naohiro was able to trigger the bug as well with xfstests generic/095
on a zoned btrfs.

There is nothing that prevents bvec submissions via REQ_OP_ZONE_APPEND if
the hardware's zone append limit is met.

Reported-by: Naohiro Aota <naohiro.aota@wdc.com>
Reported-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
---
 block/bio.c | 21 ++++++++++++++++++---
 1 file changed, 18 insertions(+), 3 deletions(-)

diff --git a/block/bio.c b/block/bio.c
index 26b7f721cda8..963d1d406b3a 100644
--- a/block/bio.c
+++ b/block/bio.c
@@ -949,7 +949,7 @@ void bio_release_pages(struct bio *bio, bool mark_dirty)
 }
 EXPORT_SYMBOL_GPL(bio_release_pages);
 
-static int bio_iov_bvec_set(struct bio *bio, struct iov_iter *iter)
+static void __bio_iov_bvec_set(struct bio *bio, struct iov_iter *iter)
 {
 	WARN_ON_ONCE(bio->bi_max_vecs);
 
@@ -959,11 +959,26 @@ static int bio_iov_bvec_set(struct bio *bio, struct iov_iter *iter)
 	bio->bi_iter.bi_size = iter->count;
 	bio_set_flag(bio, BIO_NO_PAGE_REF);
 	bio_set_flag(bio, BIO_CLONED);
+}
 
+static int bio_iov_bvec_set(struct bio *bio, struct iov_iter *iter)
+{
+	__bio_iov_bvec_set(bio, iter);
 	iov_iter_advance(iter, iter->count);
 	return 0;
 }
 
+static int bio_iov_bvec_set_append(struct bio *bio, struct iov_iter *iter)
+{
+	struct request_queue *q = bio->bi_bdev->bd_disk->queue;
+	struct iov_iter i = *iter;
+
+	iov_iter_truncate(&i, queue_max_zone_append_sectors(q) << 9);
+	__bio_iov_bvec_set(bio, &i);
+	iov_iter_advance(iter, i.count);
+	return 0;
+}
+
 #define PAGE_PTRS_PER_BVEC     (sizeof(struct bio_vec) / sizeof(struct page *))
 
 /**
@@ -1094,8 +1109,8 @@ int bio_iov_iter_get_pages(struct bio *bio, struct iov_iter *iter)
 	int ret = 0;
 
 	if (iov_iter_is_bvec(iter)) {
-		if (WARN_ON_ONCE(bio_op(bio) == REQ_OP_ZONE_APPEND))
-			return -EINVAL;
+		if (bio_op(bio) == REQ_OP_ZONE_APPEND)
+			return bio_iov_bvec_set_append(bio, iter);
 		return bio_iov_bvec_set(bio, iter);
 	}
 
-- 
2.30.0


Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88EA9C433F5
	for <linux-block@archiver.kernel.org>; Thu, 28 Oct 2021 11:24:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 700B661106
	for <linux-block@archiver.kernel.org>; Thu, 28 Oct 2021 11:24:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230183AbhJ1L1B (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 28 Oct 2021 07:27:01 -0400
Received: from mta-02.yadro.com ([89.207.88.252]:57628 "EHLO mta-01.yadro.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230059AbhJ1L1A (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Thu, 28 Oct 2021 07:27:00 -0400
Received: from localhost (unknown [127.0.0.1])
        by mta-01.yadro.com (Postfix) with ESMTP id 2978346154;
        Thu, 28 Oct 2021 11:24:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=yadro.com; h=
        content-type:content-type:content-transfer-encoding:mime-version
        :references:in-reply-to:x-mailer:message-id:date:date:subject
        :subject:from:from:received:received:received; s=mta-01; t=
        1635420271; x=1637234672; bh=YXHgbGA2lhrUJAZurjL9cY1iWV1Um0NwCFc
        4s9CDP2Q=; b=VNAvups4zh8tcDA22CsB6Px0v0e+p1fuT5OmgV5B53oH8EOOTB/
        r8GOL2xm7OyfSt26S+clgfqAFMbYrMBvgQWXvbNMnRvxMi47dsFmRsSpDKz0jzRP
        /36i8BrWe35OBOqwX3T8/sBIELuybBT7T2qjv6KwfHvBsPG0AzL6h8bU=
X-Virus-Scanned: amavisd-new at yadro.com
Received: from mta-01.yadro.com ([127.0.0.1])
        by localhost (mta-01.yadro.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id aTbt68cat-uT; Thu, 28 Oct 2021 14:24:31 +0300 (MSK)
Received: from T-EXCH-04.corp.yadro.com (t-exch-04.corp.yadro.com [172.17.100.104])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
        (No client certificate requested)
        by mta-01.yadro.com (Postfix) with ESMTPS id 3204D46184;
        Thu, 28 Oct 2021 14:24:31 +0300 (MSK)
Received: from localhost.localdomain (10.199.10.99) by
 T-EXCH-04.corp.yadro.com (172.17.100.104) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P384) id
 15.1.669.32; Thu, 28 Oct 2021 14:24:30 +0300
From:   "Alexander V. Buev" <a.buev@yadro.com>
To:     <linux-block@vger.kernel.org>
CC:     Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        Mikhail Malygin <m.malygin@yadro.com>, <linux@yadro.com>,
        "Alexander V. Buev" <a.buev@yadro.com>
Subject: [PATCH 3/3] block: fops: handle IOCB_USE_PI in direct IO
Date:   Thu, 28 Oct 2021 14:24:06 +0300
Message-ID: <20211028112406.101314-4-a.buev@yadro.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20211028112406.101314-1-a.buev@yadro.com>
References: <20211028112406.101314-1-a.buev@yadro.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.199.10.99]
X-ClientProxiedBy: T-EXCH-01.corp.yadro.com (172.17.10.101) To
 T-EXCH-04.corp.yadro.com (172.17.100.104)
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Check that the size of integrity data correspond to device integrity
profile and data size. Split integrity data to the different bio's
in case of to big orginal bio (together with normal data).
Correct offset/size checking at blkdev layer in read/write_iter
functions.

Signed-off-by: Alexander V. Buev <a.buev@yadro.com>
---
 block/fops.c | 71 ++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 71 insertions(+)

diff --git a/block/fops.c b/block/fops.c
index 1e970c247e0e..74040314f5f3 100644
--- a/block/fops.c
+++ b/block/fops.c
@@ -197,12 +197,39 @@ static ssize_t __blkdev_direct_IO(struct kiocb *iocb, struct iov_iter *iter,
 	struct blk_plug plug;
 	struct blkdev_dio *dio;
 	struct bio *bio;
+	struct iovec *pi_iov, _pi_iov;
 	bool is_poll = (iocb->ki_flags & IOCB_HIPRI) != 0;
 	bool is_read = (iov_iter_rw(iter) == READ), is_sync;
 	loff_t pos = iocb->ki_pos;
 	blk_qc_t qc = BLK_QC_T_NONE;
 	int ret = 0;
 
+	if (iocb->ki_flags & IOCB_USE_PI) {
+		struct blk_integrity *bi = blk_get_integrity(bdev->bd_disk);
+		unsigned int intervals;
+
+		/* Last iovec contains protection information. */
+		if (!iter->nr_segs)
+			return -EINVAL;
+
+		iter->nr_segs--;
+		pi_iov = (struct iovec *)(iter->iov + iter->nr_segs);
+
+		/* TODO: seems iter is in charge of this check ? */
+		if (pi_iov->iov_len > iter->count)
+			return -EINVAL;
+
+		iter->count -= pi_iov->iov_len;
+
+		intervals = bio_integrity_intervals(bi, iter->count >> 9);
+		if (unlikely(intervals * bi->tuple_size > pi_iov->iov_len)) {
+			pr_err("Integrity & data size mismatch data=%lu integrity=%u intervals=%u tupple=%u",
+				iter->count, (unsigned int)pi_iov->iov_len,
+				intervals, bi->tuple_size);
+				return -EINVAL;
+		}
+	}
+
 	if ((pos | iov_iter_alignment(iter)) &
 	    (bdev_logical_block_size(bdev) - 1))
 		return -EINVAL;
@@ -258,6 +285,17 @@ static ssize_t __blkdev_direct_IO(struct kiocb *iocb, struct iov_iter *iter,
 		dio->size += bio->bi_iter.bi_size;
 		pos += bio->bi_iter.bi_size;
 
+		/* in case we can't add all data to one bio */
+		/* we must split integrity too */
+
+		if (iocb->ki_flags & IOCB_USE_PI) {
+			struct blk_integrity *bi = bdev_get_integrity(bio->bi_bdev);
+
+			_pi_iov.iov_base =  pi_iov->iov_base;
+			_pi_iov.iov_base += bio_integrity_bytes(bi, (dio->size-bio->bi_iter.bi_size) >> 9);
+			_pi_iov.iov_len  = bio_integrity_bytes(bi, bio->bi_iter.bi_size >> 9);
+		}
+
 		nr_pages = bio_iov_vecs_to_alloc(iter, BIO_MAX_VECS);
 		if (!nr_pages) {
 			bool polled = false;
@@ -267,6 +305,16 @@ static ssize_t __blkdev_direct_IO(struct kiocb *iocb, struct iov_iter *iter,
 				polled = true;
 			}
 
+			/* Add protection information to bio */
+			if (iocb->ki_flags & IOCB_USE_PI) {
+				ret = bio_integrity_add_pi_iovec(bio, &_pi_iov);
+				if (ret) {
+					bio->bi_status = BLK_STS_IOERR;
+					bio_endio(bio);
+					break;
+				}
+			}
+
 			qc = submit_bio(bio);
 
 			if (polled)
@@ -288,6 +336,16 @@ static ssize_t __blkdev_direct_IO(struct kiocb *iocb, struct iov_iter *iter,
 			atomic_inc(&dio->ref);
 		}
 
+
+		if (iocb->ki_flags & IOCB_USE_PI) {
+			ret = bio_integrity_add_pi_iovec(bio, &_pi_iov);
+			if (ret) {
+				bio->bi_status = BLK_STS_IOERR;
+				bio_endio(bio);
+				break;
+			}
+		}
+
 		submit_bio(bio);
 		bio = bio_alloc(GFP_KERNEL, nr_pages);
 	}
@@ -509,6 +567,12 @@ static ssize_t blkdev_write_iter(struct kiocb *iocb, struct iov_iter *from)
 	if ((iocb->ki_flags & (IOCB_NOWAIT | IOCB_DIRECT)) == IOCB_NOWAIT)
 		return -EOPNOTSUPP;
 
+	if (iocb->ki_flags & IOCB_USE_PI) {
+		if (from->nr_segs < 2)
+			return -EINVAL;
+		size += from->iov[from->nr_segs-1].iov_len;
+	}
+
 	size -= iocb->ki_pos;
 	if (iov_iter_count(from) > size) {
 		shorted = iov_iter_count(from) - size;
@@ -537,6 +601,13 @@ static ssize_t blkdev_read_iter(struct kiocb *iocb, struct iov_iter *to)
 		return 0;
 
 	size -= pos;
+
+	if (iocb->ki_flags & IOCB_USE_PI) {
+		if (to->nr_segs < 2)
+			return -EINVAL;
+		size += to->iov[to->nr_segs-1].iov_len;
+	}
+
 	if (iov_iter_count(to) > size) {
 		shorted = iov_iter_count(to) - size;
 		iov_iter_truncate(to, size);
-- 
2.33.0


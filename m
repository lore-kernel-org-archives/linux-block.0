Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F3ADC433FE
	for <linux-block@archiver.kernel.org>; Sat, 23 Oct 2021 16:21:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 01D4E61073
	for <linux-block@archiver.kernel.org>; Sat, 23 Oct 2021 16:21:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230104AbhJWQYI (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sat, 23 Oct 2021 12:24:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229901AbhJWQYH (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sat, 23 Oct 2021 12:24:07 -0400
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23D7AC061714
        for <linux-block@vger.kernel.org>; Sat, 23 Oct 2021 09:21:48 -0700 (PDT)
Received: by mail-wr1-x436.google.com with SMTP id v17so2517211wrv.9
        for <linux-block@vger.kernel.org>; Sat, 23 Oct 2021 09:21:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=iECOiVFDdSc/w8PF/u9qtqfiQcqmaH9XDcaCDgobCk4=;
        b=ZHxZNgBebO+dDTnZtt+NsEuzIOhHFK3KIAYgH3seFJz9MpCWWTV4OmYNlSHwFxzxmv
         Xdwdk3ZnrHOGk75I1yuFWBRysAixsEBJANphvmS5ohmifdrmgYpMoGQBGV3kBgKE/SC9
         7ms38yTOTsthdCR+2Q6tDz49iXCPo1WIa20m4EouQX/aDwanvpovEXR1taa5TZjFFgUu
         RLRnU5uXZBKm+WrM+q85JKLxzoqLAP3UguarlgJSuqmkOdqQm1t62yFZbSmacicAJrMG
         d48f1YjkKyfKIx4igQEF/OH3/peBEjgEaX6qGpVd2OC8lPkWTu1Rh+oShjz1uC4Z6Qvb
         3A5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=iECOiVFDdSc/w8PF/u9qtqfiQcqmaH9XDcaCDgobCk4=;
        b=1unlA4vrQE737Q218aHoYz4XbpOxWy9/9ocGXkqgZkfjCgCZ5MD0jx/XT1/LLlM5EJ
         ot3yfy6/qy9Gw3Q+7zMs5jj4JThYYNQRJcxuYQ1/sc8yYcQFX0kb1hTheygMrOeW/CKF
         L9AGCw/QYIoYIrlkEdDOEunZHPO+vMtD9yBjpWjwr4o98S8IZ5Wqx46nRXbU4acDklky
         dsOWd13wT+42cdeTzVhu1Dnf0qgfLoJSpgHhaKdF+NoN613TlGIdysmRdlBJSmTRehYn
         uetXMN56xfz3QS+mgWDa2h562vu1kl4jrQ7ZJEIY+CH/1Lf3myDiTMS63LiXQ2pjn+Q6
         gXDg==
X-Gm-Message-State: AOAM532FMizIyAwU/AV1DIVmvatfbz1id6cM72Ze79bbzx3O7RPPgiQe
        cXCYw2RJXAu7D2qyidERHTnMxm4bcaQ=
X-Google-Smtp-Source: ABdhPJz8zKQQjdGq4YhNbU/nd38OL9B1KTuHdLZ7sJM4Hzmu1NDBak6bhZgcdVW9eGd3uc9ngxp6OQ==
X-Received: by 2002:adf:e306:: with SMTP id b6mr8688279wrj.244.1635006106497;
        Sat, 23 Oct 2021 09:21:46 -0700 (PDT)
Received: from 127.0.0.1localhost ([148.252.133.195])
        by smtp.gmail.com with ESMTPSA id c16sm2174799wrt.43.2021.10.23.09.21.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 23 Oct 2021 09:21:46 -0700 (PDT)
From:   Pavel Begunkov <asml.silence@gmail.com>
To:     linux-block@vger.kernel.org
Cc:     Jens Axboe <axboe@kernel.dk>,
        Christoph Hellwig <hch@infradead.org>,
        Pavel Begunkov <asml.silence@gmail.com>
Subject: [PATCH 1/5] block: add single bio async direct IO helper
Date:   Sat, 23 Oct 2021 17:21:32 +0100
Message-Id: <f0ae4109b7a6934adede490f84d188d53b97051b.1635006010.git.asml.silence@gmail.com>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <cover.1635006010.git.asml.silence@gmail.com>
References: <cover.1635006010.git.asml.silence@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

As with __blkdev_direct_IO_simple(), we can implement direct IO more
efficiently if there is only one bio. Add __blkdev_direct_IO_async() and
blkdev_bio_end_io_async(). This patch brings me from 4.45-4.5 MIOPS with
nullblk to 4.7+.

Signed-off-by: Pavel Begunkov <asml.silence@gmail.com>
---
 block/fops.c | 87 ++++++++++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 84 insertions(+), 3 deletions(-)

diff --git a/block/fops.c b/block/fops.c
index 396537598e3e..a7b328296912 100644
--- a/block/fops.c
+++ b/block/fops.c
@@ -305,6 +305,85 @@ static ssize_t __blkdev_direct_IO(struct kiocb *iocb, struct iov_iter *iter,
 	return ret;
 }
 
+static void blkdev_bio_end_io_async(struct bio *bio)
+{
+	struct blkdev_dio *dio = container_of(bio, struct blkdev_dio, bio);
+	struct kiocb *iocb = dio->iocb;
+	ssize_t ret;
+
+	if (likely(!bio->bi_status)) {
+		ret = dio->size;
+		iocb->ki_pos += ret;
+	} else {
+		ret = blk_status_to_errno(bio->bi_status);
+	}
+
+	iocb->ki_complete(iocb, ret, 0);
+
+	if (dio->flags & DIO_SHOULD_DIRTY) {
+		bio_check_pages_dirty(bio);
+	} else {
+		bio_release_pages(bio, false);
+		bio_put(bio);
+	}
+}
+
+static ssize_t __blkdev_direct_IO_async(struct kiocb *iocb,
+					struct iov_iter *iter,
+					unsigned int nr_pages)
+{
+	struct block_device *bdev = iocb->ki_filp->private_data;
+	struct blkdev_dio *dio;
+	struct bio *bio;
+	loff_t pos = iocb->ki_pos;
+	int ret = 0;
+
+	if ((pos | iov_iter_alignment(iter)) &
+	    (bdev_logical_block_size(bdev) - 1))
+		return -EINVAL;
+
+	bio = bio_alloc_kiocb(iocb, nr_pages, &blkdev_dio_pool);
+	dio = container_of(bio, struct blkdev_dio, bio);
+	dio->flags = 0;
+	dio->iocb = iocb;
+	bio_set_dev(bio, bdev);
+	bio->bi_iter.bi_sector = pos >> SECTOR_SHIFT;
+	bio->bi_write_hint = iocb->ki_hint;
+	bio->bi_end_io = blkdev_bio_end_io_async;
+	bio->bi_ioprio = iocb->ki_ioprio;
+
+	ret = bio_iov_iter_get_pages(bio, iter);
+	if (unlikely(ret)) {
+		bio->bi_status = BLK_STS_IOERR;
+		bio_endio(bio);
+		return ret;
+	}
+	dio->size = bio->bi_iter.bi_size;
+
+	if (iov_iter_rw(iter) == READ) {
+		bio->bi_opf = REQ_OP_READ;
+		if (iter_is_iovec(iter)) {
+			dio->flags |= DIO_SHOULD_DIRTY;
+			bio_set_pages_dirty(bio);
+		}
+	} else {
+		bio->bi_opf = dio_bio_write_op(iocb);
+		task_io_account_write(bio->bi_iter.bi_size);
+	}
+
+	if (iocb->ki_flags & IOCB_NOWAIT)
+		bio->bi_opf |= REQ_NOWAIT;
+
+	if (iocb->ki_flags & IOCB_HIPRI) {
+		bio_set_polled(bio, iocb);
+		submit_bio(bio);
+		WRITE_ONCE(iocb->private, bio);
+	} else {
+		submit_bio(bio);
+	}
+	return -EIOCBQUEUED;
+}
+
 static ssize_t blkdev_direct_IO(struct kiocb *iocb, struct iov_iter *iter)
 {
 	unsigned int nr_pages;
@@ -313,9 +392,11 @@ static ssize_t blkdev_direct_IO(struct kiocb *iocb, struct iov_iter *iter)
 		return 0;
 
 	nr_pages = bio_iov_vecs_to_alloc(iter, BIO_MAX_VECS + 1);
-	if (is_sync_kiocb(iocb) && nr_pages <= BIO_MAX_VECS)
-		return __blkdev_direct_IO_simple(iocb, iter, nr_pages);
-
+	if (likely(nr_pages <= BIO_MAX_VECS)) {
+		if (is_sync_kiocb(iocb))
+			return __blkdev_direct_IO_simple(iocb, iter, nr_pages);
+		return __blkdev_direct_IO_async(iocb, iter, nr_pages);
+	}
 	return __blkdev_direct_IO(iocb, iter, bio_max_segs(nr_pages));
 }
 
-- 
2.33.1


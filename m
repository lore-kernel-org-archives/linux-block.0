Return-Path: <SRS0=PKU6=PK=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05D43C43387
	for <linux-block@archiver.kernel.org>; Wed,  2 Jan 2019 17:55:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C01E7218DE
	for <linux-block@archiver.kernel.org>; Wed,  2 Jan 2019 17:55:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="y88m9lGY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726937AbfABRzl (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 2 Jan 2019 12:55:41 -0500
Received: from mail-io1-f67.google.com ([209.85.166.67]:39196 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726240AbfABRzk (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 2 Jan 2019 12:55:40 -0500
Received: by mail-io1-f67.google.com with SMTP id k7so25096502iob.6
        for <linux-block@vger.kernel.org>; Wed, 02 Jan 2019 09:55:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=to:cc:from:subject:message-id:date:user-agent:mime-version
         :content-language:content-transfer-encoding;
        bh=iN/CCl/uvW24O8idIOW4YlHr8fVFsek/JELJk4qX5Rc=;
        b=y88m9lGYlKwAfiImLZKAo9pxnLELILGToeDtyoxpQ/eo8MWEzGaMuUECbUV/lGerpc
         /Et1HjgK9V9VpPoNyKR1K5VavsuD9WB79Y9PVdDrEVXyriePs/X59/aMHcN31k1g19u5
         B726KqE4aQYI4y/X7vxpsFf6+d4vrWlJ/pX5jwHJW2wsG82M/w0p2kiiunz+8qUbX1fU
         wuFGHF0lgX//Sfhdacgyvdc6cI+n0mZhabQ9e1gedQ4MugiPHOJpUVHOdC0kWgz9TIND
         Ue8vJt5F/FC/3CjEwNjMEEiXeA5Bd0Eom2xojAi7en9A75BjHegF/RKTR9Esfg0rIwUi
         h22g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:cc:from:subject:message-id:date:user-agent
         :mime-version:content-language:content-transfer-encoding;
        bh=iN/CCl/uvW24O8idIOW4YlHr8fVFsek/JELJk4qX5Rc=;
        b=mVMQNUMLkPVckd+GNBwBOlxuc21foW/bVY1EuJ+dk6OJNUL2TyQN0OL1zYkCM0P1WJ
         Vo3gA945vuOzaOE3zvl7hPE2jaLa9mbsBtdLlAAdr0mRsBM+V1W6I77LR5WN4r+3R+iR
         oTzxzImEVM5tXk3g1P9PSyG/epCV94fZK+DE25bAfmd0wNNrFybbyi1h2DT6Dazqal+e
         YtRxWgRSpaKAhjVHdzuDxDTAAHVZIRA3cTVw13BOokseF78qfpefyg8nDwYWB54wGsr8
         KCMVn1FiLCTKgrl00wPwvSboHyGaOrONNZ5P1lToUPrj8nwm4X7TrD04Ma7/TKkoB6LA
         jadA==
X-Gm-Message-State: AJcUukd6geMmptAmQf0IXcSuT9QliL0bs/hA1kmZGeYg+It8uXlx2uzy
        JthV1ri2YsdiJV68Fn+DQMAmAzPxIXKy4A==
X-Google-Smtp-Source: ALg8bN6Y5532s3lpm+odHuOHRZGf22d0iTU0+ubWHgEYcBUBjDPjESodzEda1s5vp9fuvzCGs7i9fw==
X-Received: by 2002:a6b:39c6:: with SMTP id g189mr29300087ioa.255.1546451739671;
        Wed, 02 Jan 2019 09:55:39 -0800 (PST)
Received: from [192.168.1.56] ([216.160.245.98])
        by smtp.gmail.com with ESMTPSA id 70sm22175089ity.9.2019.01.02.09.55.37
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 02 Jan 2019 09:55:38 -0800 (PST)
To:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Cc:     Christoph Hellwig <hch@lst.de>,
        Linus Torvalds <torvalds@linux-foundation.org>
From:   Jens Axboe <axboe@kernel.dk>
Subject: block: only use __set_current_state() for polled IO
Message-ID: <181e0aa7-34a5-5445-70b2-45770a81659d@kernel.dk>
Date:   Wed, 2 Jan 2019 10:55:37 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

A previous commit deemed it safe to use __set_current_state() for IRQ
driven O_DIRECT, but that's isn't necessarily the case. Be safer and
only apply that optimization to polled IO, where we know the the task is
going to find the completions itself.

Fixes: 849a370016a5 ("block: avoid ordered task state change for polled IO")
Signed-off-by: Jens Axboe <axboe@kernel.dk>

---

diff --git a/fs/block_dev.c b/fs/block_dev.c
index e1886cc7048f..b5fba2922504 100644
--- a/fs/block_dev.c
+++ b/fs/block_dev.c
@@ -193,6 +193,7 @@ __blkdev_direct_IO_simple(struct kiocb *iocb, struct iov_iter *iter,
 	struct bio_vec inline_vecs[DIO_INLINE_BIO_VECS], *vecs, *bvec;
 	loff_t pos = iocb->ki_pos;
 	bool should_dirty = false;
+	bool is_poll;
 	struct bio bio;
 	ssize_t ret;
 	blk_qc_t qc;
@@ -232,18 +233,21 @@ __blkdev_direct_IO_simple(struct kiocb *iocb, struct iov_iter *iter,
 		bio.bi_opf = dio_bio_write_op(iocb);
 		task_io_account_write(ret);
 	}
-	if (iocb->ki_flags & IOCB_HIPRI)
+	is_poll = (iocb->ki_flags & IOCB_HIPRI) != 0;
+	if (is_poll)
 		bio.bi_opf |= REQ_HIPRI;
 
 	qc = submit_bio(&bio);
 	for (;;) {
-		__set_current_state(TASK_UNINTERRUPTIBLE);
+		if (is_poll)
+			__set_current_state(TASK_UNINTERRUPTIBLE);
+		else
+			set_current_state(TASK_UNINTERRUPTIBLE);
 
 		if (!READ_ONCE(bio.bi_private))
 			break;
 
-		if (!(iocb->ki_flags & IOCB_HIPRI) ||
-		    !blk_poll(bdev_get_queue(bdev), qc, true))
+		if (!is_poll || !blk_poll(bdev_get_queue(bdev), qc, true))
 			io_schedule();
 	}
 	__set_current_state(TASK_RUNNING);
@@ -426,13 +430,15 @@ __blkdev_direct_IO(struct kiocb *iocb, struct iov_iter *iter, int nr_pages)
 		return -EIOCBQUEUED;
 
 	for (;;) {
-		__set_current_state(TASK_UNINTERRUPTIBLE);
+		if (is_poll)
+			__set_current_state(TASK_UNINTERRUPTIBLE);
+		else
+			set_current_state(TASK_UNINTERRUPTIBLE);
 
 		if (!READ_ONCE(dio->waiter))
 			break;
 
-		if (!(iocb->ki_flags & IOCB_HIPRI) ||
-		    !blk_poll(bdev_get_queue(bdev), qc, true))
+		if (!is_poll || !blk_poll(bdev_get_queue(bdev), qc, true))
 			io_schedule();
 	}
 	__set_current_state(TASK_RUNNING);
diff --git a/fs/iomap.c b/fs/iomap.c
index 9a5bf1e8925b..30c5b7d9aca9 100644
--- a/fs/iomap.c
+++ b/fs/iomap.c
@@ -1790,6 +1790,7 @@ iomap_dio_rw(struct kiocb *iocb, struct iov_iter *iter,
 	size_t count = iov_iter_count(iter);
 	loff_t pos = iocb->ki_pos, start = pos;
 	loff_t end = iocb->ki_pos + count - 1, ret = 0;
+	bool is_poll = (iocb->ki_flags & IOCB_HIPRI) != 0;
 	unsigned int flags = IOMAP_DIRECT;
 	struct blk_plug plug;
 	struct iomap_dio *dio;
@@ -1908,13 +1909,15 @@ iomap_dio_rw(struct kiocb *iocb, struct iov_iter *iter,
 			return -EIOCBQUEUED;
 
 		for (;;) {
-			__set_current_state(TASK_UNINTERRUPTIBLE);
+			if (is_poll)
+				__set_current_state(TASK_UNINTERRUPTIBLE);
+			else
+				set_current_state(TASK_UNINTERRUPTIBLE);
 
 			if (!READ_ONCE(dio->submit.waiter))
 				break;
 
-			if (!(iocb->ki_flags & IOCB_HIPRI) ||
-			    !dio->submit.last_queue ||
+			if (!is_poll || !dio->submit.last_queue ||
 			    !blk_poll(dio->submit.last_queue,
 					 dio->submit.cookie, true))
 				io_schedule();

-- 
Jens Axboe


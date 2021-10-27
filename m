Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90D2EC433EF
	for <linux-block@archiver.kernel.org>; Wed, 27 Oct 2021 12:21:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6F9FE610A6
	for <linux-block@archiver.kernel.org>; Wed, 27 Oct 2021 12:21:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237238AbhJ0MYA (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 27 Oct 2021 08:24:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240313AbhJ0MYA (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 27 Oct 2021 08:24:00 -0400
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA757C061570
        for <linux-block@vger.kernel.org>; Wed, 27 Oct 2021 05:21:34 -0700 (PDT)
Received: by mail-wr1-x42e.google.com with SMTP id s14so925710wrb.3
        for <linux-block@vger.kernel.org>; Wed, 27 Oct 2021 05:21:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=UPnbATQy+wkyVbwyTCqUjjmvDxWAZyXRB8e8V3FSQR4=;
        b=Eq8gLHngtAEw27/j1DMrB9cPKubv6I0u542tGa9lv0LjMv56w+Njps4mG3yjtTlH77
         Skdcx9FKIDjv4ma1K8ys8xbv4So8V7mD8YpqEwxv0BkYOXw0GXQO9xHdhlJxwK1gMS9H
         ZkyV+KVOYYqft34WdKZecAeKb76+XkfFV55xjyXcE09xeZUaOzYBLeo9nIo04bdG9wzi
         vZMkq/EcapSDOhguK6bh0O4idrhNq7fEvjwSQcPw1ZjCIQgKv/pom8XzMd7QgqzYlAQV
         HHj5o6IfE/JhKsYQSVW8oKp/QZWMQyHGeanQsBh+5rRYO7e2NgTneUqU33ToSNtgaNJt
         cuOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=UPnbATQy+wkyVbwyTCqUjjmvDxWAZyXRB8e8V3FSQR4=;
        b=B+becj9ASj1WAMqJxia+GFLRmqVYCSSmv0XmNzcn6DG8GxWgdGYMOaGY8grqoYgxTZ
         YoMxVzz4UGNZUPv2lgInV4kj/Jlnaj7S/zjtsEdTu0cfP8lZxCU4iSkBI3qxX4R1Odwu
         CJU2M7r+SWH9vavo6M0X+e3pHG8nkgYyAnqiRtN6kEFQfLtCKLrCIP3xLnoygQoRJI78
         Jifoa3BtXlF86lM+oZe+2Yb1Hat7rRjUXUr8wylrNXZA+xq7MQpxmDv9bZtJgu5fQ8DQ
         B769icxPLEMXFF/S1mEsWgAIcxe/T+O8r4nj3051KfAWZrCASyEydRlM98Ir8lrNmphv
         L11w==
X-Gm-Message-State: AOAM532GWm1O79F+hDt6foe/Jqta/ddQQKnwkvaEGKCO52kJIhtVo0eA
        hWGOyprydggMeO/rSMNldWtmbGBccvU=
X-Google-Smtp-Source: ABdhPJysJdU2TgdkrcqPkhMRWpTne6odbsLAPe3mEJa+2ChzNVNV14tgGxKmUzxVaEPIJs7FwGNRHA==
X-Received: by 2002:adf:d4c9:: with SMTP id w9mr34368763wrk.372.1635337293127;
        Wed, 27 Oct 2021 05:21:33 -0700 (PDT)
Received: from 127.0.0.1localhost ([148.252.132.100])
        by smtp.gmail.com with ESMTPSA id d8sm22738807wrv.80.2021.10.27.05.21.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Oct 2021 05:21:32 -0700 (PDT)
From:   Pavel Begunkov <asml.silence@gmail.com>
To:     linux-block@vger.kernel.org
Cc:     Jens Axboe <axboe@kernel.dk>,
        Christoph Hellwig <hch@infradead.org>,
        Pavel Begunkov <asml.silence@gmail.com>
Subject: [PATCH v2 2/4] block: kill unused polling bits in __blkdev_direct_IO()
Date:   Wed, 27 Oct 2021 13:21:08 +0100
Message-Id: <b8c597a6b7ee612df394853bfd24726aee5b898e.1635337135.git.asml.silence@gmail.com>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <cover.1635337135.git.asml.silence@gmail.com>
References: <cover.1635337135.git.asml.silence@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

With addition of __blkdev_direct_IO_async(), __blkdev_direct_IO() now
serves only multio-bio I/O, which we don't poll. Now we can remove
anything related to I/O polling from it.

Signed-off-by: Pavel Begunkov <asml.silence@gmail.com>
---
 block/fops.c | 20 +++-----------------
 1 file changed, 3 insertions(+), 17 deletions(-)

diff --git a/block/fops.c b/block/fops.c
index 092e5079e827..983e993c9a4b 100644
--- a/block/fops.c
+++ b/block/fops.c
@@ -190,7 +190,6 @@ static ssize_t __blkdev_direct_IO(struct kiocb *iocb, struct iov_iter *iter,
 	struct blk_plug plug;
 	struct blkdev_dio *dio;
 	struct bio *bio;
-	bool do_poll = (iocb->ki_flags & IOCB_HIPRI);
 	bool is_read = (iov_iter_rw(iter) == READ), is_sync;
 	loff_t pos = iocb->ki_pos;
 	int ret = 0;
@@ -216,12 +215,7 @@ static ssize_t __blkdev_direct_IO(struct kiocb *iocb, struct iov_iter *iter,
 	if (is_read && iter_is_iovec(iter))
 		dio->flags |= DIO_SHOULD_DIRTY;
 
-	/*
-	 * Don't plug for HIPRI/polled IO, as those should go straight
-	 * to issue
-	 */
-	if (!(iocb->ki_flags & IOCB_HIPRI))
-		blk_start_plug(&plug);
+	blk_start_plug(&plug);
 
 	for (;;) {
 		bio_set_dev(bio, bdev);
@@ -254,11 +248,7 @@ static ssize_t __blkdev_direct_IO(struct kiocb *iocb, struct iov_iter *iter,
 
 		nr_pages = bio_iov_vecs_to_alloc(iter, BIO_MAX_VECS);
 		if (!nr_pages) {
-			if (do_poll)
-				bio_set_polled(bio, iocb);
 			submit_bio(bio);
-			if (do_poll)
-				WRITE_ONCE(iocb->private, bio);
 			break;
 		}
 		if (!(dio->flags & DIO_MULTI_BIO)) {
@@ -271,7 +261,6 @@ static ssize_t __blkdev_direct_IO(struct kiocb *iocb, struct iov_iter *iter,
 				bio_get(bio);
 			dio->flags |= DIO_MULTI_BIO;
 			atomic_set(&dio->ref, 2);
-			do_poll = false;
 		} else {
 			atomic_inc(&dio->ref);
 		}
@@ -280,8 +269,7 @@ static ssize_t __blkdev_direct_IO(struct kiocb *iocb, struct iov_iter *iter,
 		bio = bio_alloc(GFP_KERNEL, nr_pages);
 	}
 
-	if (!(iocb->ki_flags & IOCB_HIPRI))
-		blk_finish_plug(&plug);
+	blk_finish_plug(&plug);
 
 	if (!is_sync)
 		return -EIOCBQUEUED;
@@ -290,9 +278,7 @@ static ssize_t __blkdev_direct_IO(struct kiocb *iocb, struct iov_iter *iter,
 		set_current_state(TASK_UNINTERRUPTIBLE);
 		if (!READ_ONCE(dio->waiter))
 			break;
-
-		if (!do_poll || !bio_poll(bio, NULL, 0))
-			blk_io_schedule();
+		blk_io_schedule();
 	}
 	__set_current_state(TASK_RUNNING);
 
-- 
2.33.1


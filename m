Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66E20C433F5
	for <linux-block@archiver.kernel.org>; Thu, 14 Oct 2021 18:34:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 430B160F23
	for <linux-block@archiver.kernel.org>; Thu, 14 Oct 2021 18:34:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232356AbhJNShC (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 14 Oct 2021 14:37:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231531AbhJNShB (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 14 Oct 2021 14:37:01 -0400
Received: from mail-io1-xd33.google.com (mail-io1-xd33.google.com [IPv6:2607:f8b0:4864:20::d33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0063C061570
        for <linux-block@vger.kernel.org>; Thu, 14 Oct 2021 11:34:56 -0700 (PDT)
Received: by mail-io1-xd33.google.com with SMTP id b188so12399iof.8
        for <linux-block@vger.kernel.org>; Thu, 14 Oct 2021 11:34:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=to:from:subject:message-id:date:user-agent:mime-version
         :content-language:content-transfer-encoding;
        bh=7+0CBL04bPiDgYlzGNDciDY3kPD7aLNqzNGXoUK5U7Q=;
        b=XJvlefid1+zybJVlepZR2Tt7nlF+EO9XGg9nyPv5y8RSgzWnQJaI2h8+dqQiC8h9ue
         o0H/jLJGXvVnMLCmb1sE7aUfN/9onA85YY22+V2+jEwtbP/B2yVOz1sCXOs5dDBsK9lU
         rvKxmaazTbqpz3HD7atKfgeLAVs9ak5xNBL4v/x20zOk9K2P9ZcuWUI1XQVU4tAYrJnL
         fFgqvC4Ex8YEmnr5PC07CMwZ3QB78zamxLLlNw6WC/BdXpjyJp//oimRVfuscAUc4H18
         A3Zi94AxwvIldI0nggewAatNY0siqHFPx23g/qRdjhI014khc4mUjJN+QvgHHXD+3efv
         lZrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:to:from:subject:message-id:date:user-agent
         :mime-version:content-language:content-transfer-encoding;
        bh=7+0CBL04bPiDgYlzGNDciDY3kPD7aLNqzNGXoUK5U7Q=;
        b=0IvHVKEYtjEDP0W3aDmt2J0KCsHc1O/sdVtcQJVmcugGwV87wPzZOz9SH9DsO3+74d
         SPDTOJln9G6pJf/6uKXxJL+6DyswUJu6XdeBLsqRPPIOHpeJaGGC0E/7Ykl4z3wH/lMl
         TA+vjWl0K8iiOzdEm0t9xPMCV3XNeGT9ag7kg6AC0pt7Pi/jVXdBGlEy2W1m9dMgCMa2
         ZKjXEAlKUhkN7/GfOFJ8ZMkcl6m9cKWtL9LtcXDVhzsZTd+8WlSgGz3W9ClPIic7PY6t
         UI9hHNDVe0rq3fbzbueqsHNtbh4aV947x9KLUoHXxtqPBSgj+vpVM+HOVxrfBcTPOiAT
         p0qw==
X-Gm-Message-State: AOAM533SXJXfiEryvhSHv8tWqtUMYYgNHCqtmUAYFYDvAQyleSKu80S5
        3zw+xHUJh4rb5UBqqTARnj9JWyQPgYo3Xw==
X-Google-Smtp-Source: ABdhPJxBi/M8b0ECOlgGqhSdSE44vtT1U2uxeMVo1DTM3ho5lBngXJMLuf1Mvp21emdcZlrHJC3W+w==
X-Received: by 2002:a05:6638:10c4:: with SMTP id q4mr5288152jad.98.1634236495823;
        Thu, 14 Oct 2021 11:34:55 -0700 (PDT)
Received: from [192.168.1.30] ([207.135.234.126])
        by smtp.gmail.com with ESMTPSA id m25sm1571294iol.1.2021.10.14.11.34.55
        for <linux-block@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 14 Oct 2021 11:34:55 -0700 (PDT)
To:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
From:   Jens Axboe <axboe@kernel.dk>
Subject: [PATCH] block: use flags instead of bit fields for blkdev_dio
Message-ID: <4b427811-106d-53b2-bdfc-afd022282067@kernel.dk>
Date:   Thu, 14 Oct 2021 12:34:55 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

This generates a lot better code for me, and bumps performance from
7650K IOPS to 7750K IOPS. Looking at profiles for the run and running
perf diff, it confirms that we're now sending a lot less time there:

     6.38%     -2.80%  [kernel.vmlinux]  [k] blkdev_direct_IO

Taking it from the 2nd most cycle consumer to only the 9th most at
3.35% of the CPU time.

Signed-off-by: Jens Axboe <axboe@kernel.dk>

---

diff --git a/block/fops.c b/block/fops.c
index 89e1eae8f89a..2c43e493e37c 100644
--- a/block/fops.c
+++ b/block/fops.c
@@ -123,6 +123,12 @@ static ssize_t __blkdev_direct_IO_simple(struct kiocb *iocb,
 	return ret;
 }
 
+enum {
+	DIO_MULTI_BIO		= 1,
+	DIO_SHOULD_DIRTY	= 2,
+	DIO_IS_SYNC		= 4,
+};
+
 struct blkdev_dio {
 	union {
 		struct kiocb		*iocb;
@@ -130,9 +136,7 @@ struct blkdev_dio {
 	};
 	size_t			size;
 	atomic_t		ref;
-	bool			multi_bio : 1;
-	bool			should_dirty : 1;
-	bool			is_sync : 1;
+	unsigned int		flags;
 	struct bio		bio;
 };
 
@@ -141,13 +145,13 @@ static struct bio_set blkdev_dio_pool;
 static void blkdev_bio_end_io(struct bio *bio)
 {
 	struct blkdev_dio *dio = bio->bi_private;
-	bool should_dirty = dio->should_dirty;
+	bool should_dirty = dio->flags & DIO_SHOULD_DIRTY;
 
 	if (bio->bi_status && !dio->bio.bi_status)
 		dio->bio.bi_status = bio->bi_status;
 
-	if (!dio->multi_bio || atomic_dec_and_test(&dio->ref)) {
-		if (!dio->is_sync) {
+	if (!(dio->flags & DIO_MULTI_BIO) || atomic_dec_and_test(&dio->ref)) {
+		if (!(dio->flags & DIO_IS_SYNC)) {
 			struct kiocb *iocb = dio->iocb;
 			ssize_t ret;
 
@@ -161,7 +165,7 @@ static void blkdev_bio_end_io(struct bio *bio)
 			}
 
 			dio->iocb->ki_complete(iocb, ret, 0);
-			if (dio->multi_bio)
+			if (dio->flags & DIO_MULTI_BIO)
 				bio_put(&dio->bio);
 		} else {
 			struct task_struct *waiter = dio->waiter;
@@ -198,17 +202,19 @@ static ssize_t __blkdev_direct_IO(struct kiocb *iocb, struct iov_iter *iter,
 	bio = bio_alloc_kiocb(iocb, nr_pages, &blkdev_dio_pool);
 
 	dio = container_of(bio, struct blkdev_dio, bio);
-	dio->is_sync = is_sync = is_sync_kiocb(iocb);
-	if (dio->is_sync) {
+	is_sync = is_sync_kiocb(iocb);
+	if (is_sync) {
+		dio->flags = DIO_IS_SYNC;
 		dio->waiter = current;
 		bio_get(bio);
 	} else {
+		dio->flags = 0;
 		dio->iocb = iocb;
 	}
 
 	dio->size = 0;
-	dio->multi_bio = false;
-	dio->should_dirty = is_read && iter_is_iovec(iter);
+	if (is_read && iter_is_iovec(iter))
+		dio->flags |= DIO_SHOULD_DIRTY;
 
 	/*
 	 * Don't plug for HIPRI/polled IO, as those should go straight
@@ -234,7 +240,7 @@ static ssize_t __blkdev_direct_IO(struct kiocb *iocb, struct iov_iter *iter,
 
 		if (is_read) {
 			bio->bi_opf = REQ_OP_READ;
-			if (dio->should_dirty)
+			if (dio->flags & DIO_SHOULD_DIRTY)
 				bio_set_pages_dirty(bio);
 		} else {
 			bio->bi_opf = dio_bio_write_op(iocb);
@@ -255,7 +261,7 @@ static ssize_t __blkdev_direct_IO(struct kiocb *iocb, struct iov_iter *iter,
 				WRITE_ONCE(iocb->private, bio);
 			break;
 		}
-		if (!dio->multi_bio) {
+		if (!(dio->flags & DIO_MULTI_BIO)) {
 			/*
 			 * AIO needs an extra reference to ensure the dio
 			 * structure which is embedded into the first bio
@@ -263,7 +269,7 @@ static ssize_t __blkdev_direct_IO(struct kiocb *iocb, struct iov_iter *iter,
 			 */
 			if (!is_sync)
 				bio_get(bio);
-			dio->multi_bio = true;
+			dio->flags |= DIO_MULTI_BIO;
 			atomic_set(&dio->ref, 2);
 			do_poll = false;
 		} else {

-- 
Jens Axboe


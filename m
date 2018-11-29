Return-Path: <SRS0=Gm8i=OI=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2A1AC04EB9
	for <linux-block@archiver.kernel.org>; Thu, 29 Nov 2018 22:58:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9C3A220989
	for <linux-block@archiver.kernel.org>; Thu, 29 Nov 2018 22:58:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="g5KpVPL3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9C3A220989
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726425AbeK3KFg (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 30 Nov 2018 05:05:36 -0500
Received: from mail-it1-f194.google.com ([209.85.166.194]:38680 "EHLO
        mail-it1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726403AbeK3KFf (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 30 Nov 2018 05:05:35 -0500
Received: by mail-it1-f194.google.com with SMTP id h65so6440066ith.3
        for <linux-block@vger.kernel.org>; Thu, 29 Nov 2018 14:58:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:from:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=Bo1Spzz7ZnFVfgQSdpOjRkLR9kvErLiby+2BXZ7ab5w=;
        b=g5KpVPL3PVyx0rANZky/Iz+lBL7VArVr8ueey6+cT2/yg1HbLAKBb+N2uKLY9QEEvh
         3iOX0YacKhY+5kyNFZsJ9WXHWamreSwSM5R9SoysjJwTeKZ1sTj97EiOMZQrraWWFypx
         v7xpZY0fxyle20T0Zlgwy9gARVat78evWS7teLK/IohYrtWi1RKX3Q1aC/yoBWZ5BgGd
         8Ns6xrSdLtpM4Nw2bm38CKE25TkynR3bX4jJCAH8w22IYGBSHZR265dIc+HccJ4NKOHW
         wR2R2Csj0UHKoo2RlWlhiPYzU+Ejvp93DQC4i/QEd6+Q/ZqwDKzoXq/a5u/7tvKfY904
         PaWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Bo1Spzz7ZnFVfgQSdpOjRkLR9kvErLiby+2BXZ7ab5w=;
        b=tNFytIbHSmIsJP8p+h2BsxV9p8AJAAPDcOgEoEBQLFNJVxYnlzRqoBAVS27md3XYE1
         /N75Ou6PS1jhZ9sFTR5AKQVZxthVK0VRbW+WcwUpo5tl+YSLMzSkchar06O+L3rCO+A9
         gl491cvAwsPhYkLpNFIvKsYYxjEhWrY2zZlOdKIV9ZqsKyf9hDWVPEuTpdFC+GiEPIcN
         VWzuVVBRtlUZ/Fl/IGXngvoPZ+7lHg5VVnVDmIdwrgjj0X6FoFBUTTduX2VzoQC83STP
         lms67yiifF6EttBu8b0SEbjQRG/u9f3CwL89ncLmi6F+J5Fc/MeEsaZvvCXsJXriCcZh
         BXxg==
X-Gm-Message-State: AA+aEWYbqXTxRxn+H6OUgMDtjVlqrKuKNbCiSWCPvDLbggbnpP7ieB/K
        mw88u92DQsACh7F9ApNOc0JOMJf6PwQ=
X-Google-Smtp-Source: AFSGD/WVj8kEC0K7fo3KNJQbtFvAmpKr4QhxDC+oroLfkJAywQHye+fAbm5HzSnGxonxeUhfxFpQPg==
X-Received: by 2002:a24:f982:: with SMTP id l124mr3214894ith.59.1543532308802;
        Thu, 29 Nov 2018 14:58:28 -0800 (PST)
Received: from [192.168.1.56] ([216.160.245.98])
        by smtp.gmail.com with ESMTPSA id 70sm1749283ity.9.2018.11.29.14.58.27
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 29 Nov 2018 14:58:27 -0800 (PST)
Subject: Re: [PATCH] block: avoid extra bio reference for async O_DIRECT
From:   Jens Axboe <axboe@kernel.dk>
To:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Cc:     Christoph Hellwig <hch@lst.de>
References: <b890e540-fc63-13c1-bef0-1e6a39d1850e@kernel.dk>
Message-ID: <e834208c-bb4b-820a-28c9-918e92afa295@kernel.dk>
Date:   Thu, 29 Nov 2018 15:58:26 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <b890e540-fc63-13c1-bef0-1e6a39d1850e@kernel.dk>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 11/29/18 3:55 PM, Jens Axboe wrote:
> The bio referencing has a trick that doesn't do any actual atomic
> inc/dec on the reference count until we have to elevator to > 1. For the
> async IO O_DIRECT case, we can't use the simple DIO variants, so we use
> __blkdev_direct_IO(). It always grabs an extra reference to the bio
> after allocation, which means we then enter the slower path of actually
> having to do atomic_inc/dec on the count.
> 
> We don't need to do that for the async case, unless we end up going
> multi-bio, in which case we're already doing huge amounts of IO. For the
> smaller IO case (< BIO_MAX_PAGES), we can do without the extra ref.

I accidentally generated this against the aio-poll branch, here's a
version that is not.


diff --git a/fs/block_dev.c b/fs/block_dev.c
index d233a59ea364..5c0a224bf9cb 100644
--- a/fs/block_dev.c
+++ b/fs/block_dev.c
@@ -281,10 +281,25 @@ struct blkdev_dio {
 
 static struct bio_set blkdev_dio_pool;
 
+static void blkdev_bio_dirty_release(struct bio *bio, bool should_dirty)
+{
+	if (should_dirty) {
+		bio_check_pages_dirty(bio);
+	} else {
+		struct bio_vec *bvec;
+		int i;
+
+		bio_for_each_segment_all(bvec, bio, i)
+			put_page(bvec->bv_page);
+		bio_put(bio);
+	}
+}
+
 static void blkdev_bio_end_io(struct bio *bio)
 {
 	struct blkdev_dio *dio = bio->bi_private;
 	bool should_dirty = dio->should_dirty;
+	bool should_free = false;
 
 	if (dio->multi_bio && !atomic_dec_and_test(&dio->ref)) {
 		if (bio->bi_status && !dio->bio.bi_status)
@@ -302,25 +317,20 @@ static void blkdev_bio_end_io(struct bio *bio)
 			}
 
 			dio->iocb->ki_complete(iocb, ret, 0);
-			bio_put(&dio->bio);
 		} else {
 			struct task_struct *waiter = dio->waiter;
 
 			WRITE_ONCE(dio->waiter, NULL);
 			blk_wake_io_task(waiter);
 		}
+		/* last bio is done, now we can free the parent holding dio */
+		should_free = dio->multi_bio;
 	}
 
-	if (should_dirty) {
-		bio_check_pages_dirty(bio);
-	} else {
-		struct bio_vec *bvec;
-		int i;
-
-		bio_for_each_segment_all(bvec, bio, i)
-			put_page(bvec->bv_page);
-		bio_put(bio);
-	}
+	if (!dio->is_sync)
+		blkdev_bio_dirty_release(bio, should_dirty);
+	if (should_free)
+		bio_put(&dio->bio);
 }
 
 static ssize_t
@@ -343,14 +353,15 @@ __blkdev_direct_IO(struct kiocb *iocb, struct iov_iter *iter, int nr_pages)
 		return -EINVAL;
 
 	bio = bio_alloc_bioset(GFP_KERNEL, nr_pages, &blkdev_dio_pool);
-	bio_get(bio); /* extra ref for the completion handler */
 
 	dio = container_of(bio, struct blkdev_dio, bio);
 	dio->is_sync = is_sync = is_sync_kiocb(iocb);
-	if (dio->is_sync)
+	if (dio->is_sync) {
 		dio->waiter = current;
-	else
+		bio_get(bio);
+	} else {
 		dio->iocb = iocb;
+	}
 
 	dio->size = 0;
 	dio->multi_bio = false;
@@ -400,6 +411,13 @@ __blkdev_direct_IO(struct kiocb *iocb, struct iov_iter *iter, int nr_pages)
 		}
 
 		if (!dio->multi_bio) {
+			/*
+			 * async needs an extra reference if we are goign
+			 * multi-bio only, so we can ensure that 'dio'
+			 * sticks around.
+			 */
+			if (!is_sync)
+				bio_get(bio);
 			dio->multi_bio = true;
 			atomic_set(&dio->ref, 2);
 		} else {
@@ -433,6 +451,7 @@ __blkdev_direct_IO(struct kiocb *iocb, struct iov_iter *iter, int nr_pages)
 	if (likely(!ret))
 		ret = dio->size;
 
+	blkdev_bio_dirty_release(bio, dio->should_dirty);
 	bio_put(&dio->bio);
 	return ret;
 }

-- 
Jens Axboe


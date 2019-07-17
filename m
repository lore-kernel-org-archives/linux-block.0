Return-Path: <SRS0=ez2/=VO=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2EFFCC7618F
	for <linux-block@archiver.kernel.org>; Wed, 17 Jul 2019 15:04:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 080C32173E
	for <linux-block@archiver.kernel.org>; Wed, 17 Jul 2019 15:04:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="F+aBM8CR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727248AbfGQPEy (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 17 Jul 2019 11:04:54 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:44637 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726494AbfGQPEy (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 17 Jul 2019 11:04:54 -0400
Received: by mail-pl1-f194.google.com with SMTP id t14so12095737plr.11
        for <linux-block@vger.kernel.org>; Wed, 17 Jul 2019 08:04:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references:reply-to;
        bh=Ok9/AUUpbi3IWW6OM88kBc0ZPZ8Ssc+yI47F5Nl2TBM=;
        b=F+aBM8CRxKfViI0JWJh8m64Z/B5Fu+O+of6jq57USzfPNpagzaH4znxeYrGtPDdrPo
         jsZK5XE+t4+Dq8RFI3ljr3cykuLNXlOtj0T0qQa9M5DAn660rFEBZA4HMsMGsrAUPCI8
         2eauL5Pa/B2rixN/R51FUIPWD8vKEkW5AJTTXr1hHhVKJS29Bb+xbz0A97R/6GnFUyFB
         dZAohuvUDcVfC6hhPyinjU/NdqH6evLkcuOXi5XS1Ut/GqGcJibhgRoDqSSc7Gz02fPf
         6o1Yi67gi45gWKNNrKpmKRqM9SWSmUjwnGcelT+4sk46Omr/hRUZVtOUX38mOrRb5j9i
         EJAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:reply-to;
        bh=Ok9/AUUpbi3IWW6OM88kBc0ZPZ8Ssc+yI47F5Nl2TBM=;
        b=rzVgxkcgU56w3ozFeWyOL8aIT4ap3aL3hKzYLc25tbjcavnS1mXrGPFzRY0FdJJ5WH
         ATVfJyowS0lxqwu0x4VfNMXqBgrCqXVsFl/PoYRKoKDXo/cXkXHCaM/InzlYGrE7dooX
         1v/DDITaL0FecB6ANY2/KMCHi93uxesCy7D2ZfCxvrzaGjztPX/uOg+TlH00DyVh+5Pj
         v/PiiFr4aT1ie99CfixZ7YUTaxNIZGc+T4qSdjcWnbNh36Fi49NoTcJqb1dI9lDMrJDF
         sFeV1+OavhOj55gXWH8fzr2uZK0xcs41DTN7c6FXCmcZlwR27DdFY/Osn9Xgmwe81eLc
         gJIg==
X-Gm-Message-State: APjAAAWpHFE7xjJqnlfovTToLu5ZD4HPk+MlIQP7/y5ZywfI/edq/n85
        iARojqvQJUHdk4Yh3+6ig1yLZOCF0jk=
X-Google-Smtp-Source: APXvYqwK6E4Z3ID8bpy1RbOQ/PomZQkDXUjpDP2exBh5P6u+s2HsW72Y8G7sWB5SAyAOe54dFytRuQ==
X-Received: by 2002:a17:902:f095:: with SMTP id go21mr44487469plb.58.1563375892882;
        Wed, 17 Jul 2019 08:04:52 -0700 (PDT)
Received: from x1.localdomain (66.29.164.166.static.utbb.net. [66.29.164.166])
        by smtp.gmail.com with ESMTPSA id o35sm14112299pgm.29.2019.07.17.08.04.51
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Wed, 17 Jul 2019 08:04:52 -0700 (PDT)
From:   Jens Axboe <axboe@kernel.dk>
To:     linux-block@vger.kernel.org
Cc:     Filipp.Mikoian@acronis.com, Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 2/2] block: properly handle IOCB_NOWAIT for async O_DIRECT IO
Date:   Wed, 17 Jul 2019 09:04:45 -0600
Message-Id: <20190717150445.1131-3-axboe@kernel.dk>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190717150445.1131-1-axboe@kernel.dk>
References: <20190717150445.1131-1-axboe@kernel.dk>
Reply-To: "[RFC PATCHSET 0/2]"@vger.kernel.org, Fix@vger.kernel.org,
          O_DIRECT@vger.kernel.org, blocking@vger.kernel.org,
          with@vger.kernel.org, IOCB_NOWAIT@vger.kernel.org
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

A caller is supposed to pass in REQ_NOWAIT if we can't block for any
given operation, but O_DIRECT for block devices just ignore this. Hence
we'll block for various resource shortages on the block layer side,
like having to wait for requests.

Use the new REQ_NOWAIT_INLINE to ask for this error to be returned
inline, so we can handle it appropriately and return -EAGAIN to the
caller.

Signed-off-by: Jens Axboe <axboe@kernel.dk>
---
 fs/block_dev.c | 41 ++++++++++++++++++++++++++++++++++++++---
 1 file changed, 38 insertions(+), 3 deletions(-)

diff --git a/fs/block_dev.c b/fs/block_dev.c
index f00b569a9f89..7c4da2e2e5be 100644
--- a/fs/block_dev.c
+++ b/fs/block_dev.c
@@ -344,15 +344,24 @@ __blkdev_direct_IO(struct kiocb *iocb, struct iov_iter *iter, int nr_pages)
 	struct bio *bio;
 	bool is_poll = (iocb->ki_flags & IOCB_HIPRI) != 0;
 	bool is_read = (iov_iter_rw(iter) == READ), is_sync;
+	bool nowait = (iocb->ki_flags & IOCB_NOWAIT) != 0;
 	loff_t pos = iocb->ki_pos;
 	blk_qc_t qc = BLK_QC_T_NONE;
+	gfp_t gfp;
 	int ret = 0;
 
 	if ((pos | iov_iter_alignment(iter)) &
 	    (bdev_logical_block_size(bdev) - 1))
 		return -EINVAL;
 
-	bio = bio_alloc_bioset(GFP_KERNEL, nr_pages, &blkdev_dio_pool);
+	if (nowait)
+		gfp = GFP_NOWAIT;
+	else
+		gfp = GFP_KERNEL;
+
+	bio = bio_alloc_bioset(gfp, nr_pages, &blkdev_dio_pool);
+	if (!bio)
+		return -EAGAIN;
 
 	dio = container_of(bio, struct blkdev_dio, bio);
 	dio->is_sync = is_sync = is_sync_kiocb(iocb);
@@ -398,6 +407,14 @@ __blkdev_direct_IO(struct kiocb *iocb, struct iov_iter *iter, int nr_pages)
 			task_io_account_write(bio->bi_iter.bi_size);
 		}
 
+		/*
+		 * Tell underlying layer to not block for resource shortage.
+		 * And if we would have blocked, return error inline instead
+		 * of through the bio->bi_end_io() callback.
+		 */
+		if (nowait)
+			bio->bi_opf |= (REQ_NOWAIT | REQ_NOWAIT_INLINE);
+
 		dio->size += bio->bi_iter.bi_size;
 		pos += bio->bi_iter.bi_size;
 
@@ -411,6 +428,10 @@ __blkdev_direct_IO(struct kiocb *iocb, struct iov_iter *iter, int nr_pages)
 			}
 
 			qc = submit_bio(bio);
+			if (qc == BLK_QC_T_EAGAIN) {
+				ret = -EAGAIN;
+				goto err;
+			}
 
 			if (polled)
 				WRITE_ONCE(iocb->ki_cookie, qc);
@@ -431,8 +452,17 @@ __blkdev_direct_IO(struct kiocb *iocb, struct iov_iter *iter, int nr_pages)
 			atomic_inc(&dio->ref);
 		}
 
-		submit_bio(bio);
-		bio = bio_alloc(GFP_KERNEL, nr_pages);
+		qc = submit_bio(bio);
+		if (qc == BLK_QC_T_EAGAIN) {
+			ret = -EAGAIN;
+			goto err;
+		}
+
+		bio = bio_alloc(gfp, nr_pages);
+		if (!bio) {
+			ret = -EAGAIN;
+			goto err;
+		}
 	}
 
 	if (!is_poll)
@@ -452,6 +482,7 @@ __blkdev_direct_IO(struct kiocb *iocb, struct iov_iter *iter, int nr_pages)
 	}
 	__set_current_state(TASK_RUNNING);
 
+out:
 	if (!ret)
 		ret = blk_status_to_errno(dio->bio.bi_status);
 	if (likely(!ret))
@@ -459,6 +490,10 @@ __blkdev_direct_IO(struct kiocb *iocb, struct iov_iter *iter, int nr_pages)
 
 	bio_put(&dio->bio);
 	return ret;
+err:
+	if (!is_poll)
+		blk_finish_plug(&plug);
+	goto out;
 }
 
 static ssize_t
-- 
2.17.1


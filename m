Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 156D9C63797
	for <linux-block@archiver.kernel.org>; Mon, 16 Jan 2023 21:06:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231171AbjAPVG3 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 16 Jan 2023 16:06:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233498AbjAPVGN (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 16 Jan 2023 16:06:13 -0500
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8080320046
        for <linux-block@vger.kernel.org>; Mon, 16 Jan 2023 13:06:11 -0800 (PST)
Received: by mail-pj1-x1032.google.com with SMTP id q5so4084523pjh.1
        for <linux-block@vger.kernel.org>; Mon, 16 Jan 2023 13:06:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qR0FlWDHWG3b2zNpm7DdMz/mAASAlJKERqOsxjvwTsA=;
        b=Ue2TEHU/3MEiMEb3hHIP16VR8Jm0FjnjdI+A5VgqWgPoQd2SFiE8J8zJeprqgMFttU
         zCC17/PlnkzmfHVUeKv5PchYUckqFBNZCWr19hSRTkU2RSHs7rTwzk6pNMZjaQ5hkyP9
         7B2R2G/i2XJccPhSvFDDRoZWJtCiJ0SVbsoW8VDoZzuGSpW25r+GxVAgrCuXp3G5dGUr
         4p6HoYD0EyLiHvru5aDaVxySqZODglJuL5ENjUQLo5L4FAMTDNPolaKMGmWzfWc0Vxfb
         RZHxs+pGeq5qcm4OU3mNGGXkKOg5/ecGqSn0dbnFZcmVL/u7z2HI/enrRPU5ugzc8Idx
         i0tA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=qR0FlWDHWG3b2zNpm7DdMz/mAASAlJKERqOsxjvwTsA=;
        b=i4qUc11AdcYdPskxRDPCL87gohhueaIFwJ8NffBNlNVej8TvMXCA6LGVkOJoHWtSVx
         6Pw9IA8LnONfQ2f/M9Aj88YBr/jfqU6zx9TP70jSABDNf2CYjZdQCklXH2RIwNQ8tsd+
         Hp5IgysSbRy3kJ1xy4xGOeVM+rjy7QknpPHkgTm3zTqb6di4Ok/tmq1luO5FzVVlqiIE
         KdboYTOdQN928EfqA2rH7AY4zBjYyjjH3EKVcx/Q8NdPqjjMWvGMzghsa5iDNM0OP+38
         aXLkDAXVfIPsLB9YCf6/2jKlqcJW355qT8BDc7xSv9RGm2HZGyOSriX1sgfBINuLdOtf
         Mbrg==
X-Gm-Message-State: AFqh2krIecBR8EAjgCsXstnN3lfyA3z4ravE6xNf/oVkVJfNdxbJ8Nez
        am7U6q1ZEYry8PpN1aE1+iw+IgMm/9evJw9u
X-Google-Smtp-Source: AMrXdXstTDZ9NX7eF4GQJSJn+C0znkquthsg8pt8nkaiXKBXN/CCMQ6IVtHjXlhqmFnSLxPXX1fgfA==
X-Received: by 2002:a17:902:b591:b0:18f:a0de:6ac8 with SMTP id a17-20020a170902b59100b0018fa0de6ac8mr270955pls.2.1673903170754;
        Mon, 16 Jan 2023 13:06:10 -0800 (PST)
Received: from [192.168.1.136] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id j15-20020a170903028f00b00190c6518e30sm19775138plr.243.2023.01.16.13.06.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 16 Jan 2023 13:06:10 -0800 (PST)
Message-ID: <1ce71005-c81b-374d-5bcf-e3b7e7c48d0d@kernel.dk>
Date:   Mon, 16 Jan 2023 14:06:09 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Content-Language: en-US
To:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Cc:     Christoph Hellwig <hch@lst.de>,
        Michael Kelley <mikelley@microsoft.com>
From:   Jens Axboe <axboe@kernel.dk>
Subject: [PATCH v2] block: don't allow multiple bios for IOCB_NOWAIT issue
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

If we're doing a large IO request which needs to be split into multiple
bios for issue, then we can run into the same situation as the below
marked commit fixes - parts will complete just fine, one or more parts
will fail to allocate a request. This will result in a partially
completed read or write request, where the caller gets EAGAIN even though
parts of the IO completed just fine.

Do the same for large bios as we do for splits - fail a NOWAIT request
with EAGAIN. This isn't technically fixing an issue in the below marked
patch, but for stable purposes, we should have either none of them or
both.

This depends on: 613b14884b85 ("block: handle bio_split_to_limits() NULL return")

Cc: stable@vger.kernel.org # 5.15+
Fixes: 9cea62b2cbab ("block: don't allow splitting of a REQ_NOWAIT bio")
Link: https://github.com/axboe/liburing/issues/766
Reported-and-tested-by: Michael Kelley <mikelley@microsoft.com>
Signed-off-by: Jens Axboe <axboe@kernel.dk>

---

Since v1: catch this at submit time instead, since we can have various
valid cases where the number of single page segments will not take a
bio segment (page merging, huge pages).

diff --git a/block/fops.c b/block/fops.c
index 50d245e8c913..d2e6be4e3d1c 100644
--- a/block/fops.c
+++ b/block/fops.c
@@ -221,6 +221,24 @@ static ssize_t __blkdev_direct_IO(struct kiocb *iocb, struct iov_iter *iter,
 			bio_endio(bio);
 			break;
 		}
+		if (iocb->ki_flags & IOCB_NOWAIT) {
+			/*
+			 * This is nonblocking IO, and we need to allocate
+			 * another bio if we have data left to map. As we
+			 * cannot guarantee that one of the sub bios will not
+			 * fail getting issued FOR NOWAIT and as error results
+			 * are coalesced across all of them, be safe and ask for
+			 * a retry of this from blocking context.
+			 */
+			if (unlikely(iov_iter_count(iter))) {
+				bio_release_pages(bio, false);
+				bio_clear_flag(bio, BIO_REFFED);
+				bio_put(bio);
+				blk_finish_plug(&plug);
+				return -EAGAIN;
+			}
+			bio->bi_opf |= REQ_NOWAIT;
+		}
 
 		if (is_read) {
 			if (dio->flags & DIO_SHOULD_DIRTY)
@@ -228,9 +246,6 @@ static ssize_t __blkdev_direct_IO(struct kiocb *iocb, struct iov_iter *iter,
 		} else {
 			task_io_account_write(bio->bi_iter.bi_size);
 		}
-		if (iocb->ki_flags & IOCB_NOWAIT)
-			bio->bi_opf |= REQ_NOWAIT;
-
 		dio->size += bio->bi_iter.bi_size;
 		pos += bio->bi_iter.bi_size;
 
-- 
Jens Axboe


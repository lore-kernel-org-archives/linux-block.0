Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB079C636CC
	for <linux-block@archiver.kernel.org>; Wed, 15 Feb 2023 23:43:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229485AbjBOXnz (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 15 Feb 2023 18:43:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229759AbjBOXnz (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 15 Feb 2023 18:43:55 -0500
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3DE0543903
        for <linux-block@vger.kernel.org>; Wed, 15 Feb 2023 15:43:50 -0800 (PST)
Received: by mail-pj1-x1033.google.com with SMTP id d13-20020a17090ad3cd00b0023127b2d602so427831pjw.2
        for <linux-block@vger.kernel.org>; Wed, 15 Feb 2023 15:43:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:subject:from:to:content-language
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ntjg+XWicLKpFrNfLgRxee7JI9G+s3TPJTfMxpyeOaA=;
        b=tuobuT46FvWBEcfe5nA3TCEF8FiimfZIfGh7OF+choysYG4XQWhrdPxiPY+/a4Y28W
         45RMnukzVCRPAMF4BVsghm2Ep7HjROa/oLOtdWdV40HYKMdhplhWhFYU2wO3F/mVXDIQ
         0Uf5CaSh3f51PFwj0rAFZBkn0Hos/S47ABp8FbiKqMAJnUN9A9gTUSHsFcN03hHNJ4SX
         uOLWNDMNI3D+Ru6c/0OlRUMxriZG55Zh4wjxEd3GS1SHjGJlXj3JIOjvRfEC9Nti3aPj
         lkRQnuJwmYwRHdBneb6kAXdHTT98UER1UHu2BerApqRpEa7lgzKvIOCOZyao0udfRYXq
         NqWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:subject:from:to:content-language
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=ntjg+XWicLKpFrNfLgRxee7JI9G+s3TPJTfMxpyeOaA=;
        b=vdBvhOQu3raTVutp+xpWxsA1f0gkpXdgPJAOJLu1dCQhX7vD8Q0FBmlbYYXx2Hg5qB
         HlxOtpisMUznvVVgxsiRctqyxYepIA34AWuTMMaKj5ELQfSaVAGp6VUL2rTHV8mon5Ew
         KcSFvPq26tb0BF3hfGrWHT66JxhYNHyOZhu7mZPkccs33/y+mijFmMsmVbH6jOU+8Z7I
         Oc6ysSLa1WNs2U8S6vvT59M+0lkoYkrGyWXEm2yRPo/4bIDfB9S6Rfr0569hY1SusCJV
         13q/Fkr2z5WsJ4VGrCJ5XJ0z6OCawoFzNf90PZQM1ZlhEblPgC9za8QzDcEOhuimq/vU
         hJjw==
X-Gm-Message-State: AO0yUKWHn84DTiL9Q3M7x4LCRm0nru+ydHyaL7JzvAhHi7XvGYgJFodl
        UmLNzO1HQ+X+euzWIfQWIg/yMHpHnP912Yb6
X-Google-Smtp-Source: AK7set91uqVwPjHbNfGkCzHGg1/TwOWleDVDBhq1Rzj2nEuf6CMURqzGDpt++OZtbAppMNqcoUVf7g==
X-Received: by 2002:a17:90a:66c2:b0:233:e75b:37f6 with SMTP id z2-20020a17090a66c200b00233e75b37f6mr3685416pjl.4.1676504629060;
        Wed, 15 Feb 2023 15:43:49 -0800 (PST)
Received: from [192.168.1.136] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id y9-20020a63b509000000b004fb11a7f2d4sm11004251pge.57.2023.02.15.15.43.48
        for <linux-block@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 15 Feb 2023 15:43:48 -0800 (PST)
Message-ID: <776a5fa2-818c-de42-2ac3-a4588df218ca@kernel.dk>
Date:   Wed, 15 Feb 2023 16:43:47 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.2
Content-Language: en-US
To:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
From:   Jens Axboe <axboe@kernel.dk>
Subject: [PATCH] brd: mark as nowait compatible
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

By default, non-mq drivers do not support nowait. This causes io_uring
to use a slower path as the driver cannot be trust not to block. brd
can safely set the nowait flag, as worst case all it does is a NOIO
allocation.

For io_uring, this makes a substantial difference. Before:

submitter=0, tid=453, file=/dev/ram0, node=-1
polled=0, fixedbufs=1/0, register_files=1, buffered=0, QD=128
Engine=io_uring, sq_ring=128, cq_ring=128
IOPS=440.03K, BW=1718MiB/s, IOS/call=32/31
IOPS=428.96K, BW=1675MiB/s, IOS/call=32/32
IOPS=442.59K, BW=1728MiB/s, IOS/call=32/31
IOPS=419.65K, BW=1639MiB/s, IOS/call=32/32
IOPS=426.82K, BW=1667MiB/s, IOS/call=32/31

and after:

submitter=0, tid=354, file=/dev/ram0, node=-1
polled=0, fixedbufs=1/0, register_files=1, buffered=0, QD=128
Engine=io_uring, sq_ring=128, cq_ring=128
IOPS=3.37M, BW=13.15GiB/s, IOS/call=32/31
IOPS=3.45M, BW=13.46GiB/s, IOS/call=32/31
IOPS=3.43M, BW=13.42GiB/s, IOS/call=32/32
IOPS=3.43M, BW=13.39GiB/s, IOS/call=32/31
IOPS=3.43M, BW=13.38GiB/s, IOS/call=32/31

or about an 8x in difference.

Signed-off-by: Jens Axboe <axboe@kernel.dk>

---

diff --git a/drivers/block/brd.c b/drivers/block/brd.c
index 20acc4a1fd6d..82419e345777 100644
--- a/drivers/block/brd.c
+++ b/drivers/block/brd.c
@@ -412,6 +412,7 @@ static int brd_alloc(int i)
 	/* Tell the block layer that this is not a rotational device */
 	blk_queue_flag_set(QUEUE_FLAG_NONROT, disk->queue);
 	blk_queue_flag_clear(QUEUE_FLAG_ADD_RANDOM, disk->queue);
+	blk_queue_flag_set(QUEUE_FLAG_NOWAIT, disk->queue);
 	err = add_disk(disk);
 	if (err)
 		goto out_cleanup_disk;

-- 
Jens Axboe


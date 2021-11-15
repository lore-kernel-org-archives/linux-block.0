Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09D68C433F5
	for <linux-block@archiver.kernel.org>; Mon, 15 Nov 2021 22:13:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E036261A09
	for <linux-block@archiver.kernel.org>; Mon, 15 Nov 2021 22:13:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352751AbhKOWQT (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 15 Nov 2021 17:16:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349107AbhKOWNO (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 15 Nov 2021 17:13:14 -0500
Received: from mail-io1-xd34.google.com (mail-io1-xd34.google.com [IPv6:2607:f8b0:4864:20::d34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BBCF4C03E00D
        for <linux-block@vger.kernel.org>; Mon, 15 Nov 2021 13:35:11 -0800 (PST)
Received: by mail-io1-xd34.google.com with SMTP id z26so23261867iod.10
        for <linux-block@vger.kernel.org>; Mon, 15 Nov 2021 13:35:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=to:cc:from:subject:message-id:date:user-agent:mime-version
         :content-language:content-transfer-encoding;
        bh=7MkMKtJsQcpkY2Cn13FTwxWfttHiVbtcHkR2ClCya3Q=;
        b=l3xU3f6A07g/9kIpB4TMXuuiA90o8poCbJ5owP27lhARlH3BaULXRohx9XskjGUEnH
         h8Yw13GKS93kv9wWLeyBYWzGgjnWc9fd2TJB7jk2yvq5AQkdO3YuhIFUe6OmAnrFjk1K
         isArGWDMaHpsboiTtsdSCkqGRSzSErETrvh6N4fRWM94Mqmzcc2KGJO+qRDubVOFG3Z5
         kIeEUqcGnyIXW2mv0PXW2LC5/8xn3TF6+Pp3F5YXpQNCGuUh/JEf620Bpb4W9KAZq2cv
         ye4imA3LBYToawp73lLdDjtcYH6VnjaNwsG++7+nPNf9dsEaBfEEM6wPVh0zsRF3JB9h
         IuPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:to:cc:from:subject:message-id:date:user-agent
         :mime-version:content-language:content-transfer-encoding;
        bh=7MkMKtJsQcpkY2Cn13FTwxWfttHiVbtcHkR2ClCya3Q=;
        b=ucBBAHA1d49DJIHOv6eOQVCPCRGpbNDaIcNvyfkriI1yN5sok5sBa8MMfb8E0TUjUi
         PgoWlx0PArgy+6KnLGz0COOQWHhm7aa7AvIOJiuIMmT2yo+9G6eUhCL3vh6VJWYha5N2
         HbGDLT566kBHfeqFxIHomI3dS3pb834+PKY7ZBYax0u4XBSVKZLr/tCm61uZfo+Uz9+v
         cSdzfLwr5TU5ObvoGq48xX+W8FTB7gXSP8gIPUcEgiZW/qJeAsOq7v9moqjdr2oDn+yn
         LTDiV20VtfsjkAf8cQ/PAyUSSHOuBdUgNOrHhVx74z9pKbRllBE/GT2QRHVnXPckhWv7
         Yn2g==
X-Gm-Message-State: AOAM532J5IJbEY69Xc+r9PShQnA+QaLMU54L8Ogzi5ly0e1khLBsXqXy
        Zcd4GBf8o5FyF0afZrjjm4jkjs1m/pf2kij6
X-Google-Smtp-Source: ABdhPJz+ExZ/Blv46xkG5vBqQS4rc5rB5fXn+x1ULCiFPBgX3l6EePJmb+bqyB4fsRzWwLHh+Z0E8Q==
X-Received: by 2002:a05:6602:2d49:: with SMTP id d9mr1333869iow.11.1637012111079;
        Mon, 15 Nov 2021 13:35:11 -0800 (PST)
Received: from [192.168.1.116] ([66.219.217.159])
        by smtp.gmail.com with ESMTPSA id i3sm9068711ils.19.2021.11.15.13.35.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 15 Nov 2021 13:35:10 -0800 (PST)
To:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Cc:     Stephen Smith <stephenmsmith@blueyonder.co.uk>,
        Ming Lei <ming.lei@redhat.com>
From:   Jens Axboe <axboe@kernel.dk>
Subject: [PATCH] block: fix missing queue put in error path
Message-ID: <f39193ff-bc6b-53fa-dc05-3127012d70c5@kernel.dk>
Date:   Mon, 15 Nov 2021 14:35:09 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

If we fail the submission queue checks, we don't put the queue afterwards.
This can cause various issues like stalls on scheduler switch or failure
to remove the device, or like in the original bug report, timeout waiting
for the device on reboot/restart.

While in there, fix a few whitespace discrepancies in the surrounding
code.

Link: https://bugzilla.kernel.org/show_bug.cgi?id=215039
Fixes: b637108a4022 ("blk-mq: fix filesystem I/O request allocation")
Reported-and-tested-by: Stephen Smith <stephenmsmith@blueyonder.co.uk>
Signed-off-by: Jens Axboe <axboe@kernel.dk>

---

diff --git a/block/blk-mq.c b/block/blk-mq.c
index 3ab34c4f20da..5e1c9fd99353 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -2543,8 +2543,7 @@ static struct request *blk_mq_get_new_requests(struct request_queue *q,
 	return NULL;
 }
 
-static inline bool blk_mq_can_use_cached_rq(struct request *rq,
-		struct bio *bio)
+static inline bool blk_mq_can_use_cached_rq(struct request *rq, struct bio *bio)
 {
 	if (blk_mq_get_hctx_type(bio->bi_opf) != rq->mq_hctx->type)
 		return false;
@@ -2565,7 +2564,6 @@ static inline struct request *blk_mq_get_request(struct request_queue *q,
 	bool checked = false;
 
 	if (plug) {
-
 		rq = rq_list_peek(&plug->cached_rq);
 		if (rq && rq->q == q) {
 			if (unlikely(!submit_bio_checks(bio)))
@@ -2587,12 +2585,14 @@ static inline struct request *blk_mq_get_request(struct request_queue *q,
 fallback:
 	if (unlikely(bio_queue_enter(bio)))
 		return NULL;
-	if (!checked && !submit_bio_checks(bio))
-		return NULL;
+	if (unlikely(!checked && !submit_bio_checks(bio)))
+		goto out_put;
 	rq = blk_mq_get_new_requests(q, plug, bio, nsegs, same_queue_rq);
-	if (!rq)
-		blk_queue_exit(q);
-	return rq;
+	if (rq)
+		return rq;
+out_put:
+	blk_queue_exit(q);
+	return NULL;
 }
 
 /**

-- 
Jens Axboe


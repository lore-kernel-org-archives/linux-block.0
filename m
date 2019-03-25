Return-Path: <SRS0=AbZH=R4=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EFD3FC43381
	for <linux-block@archiver.kernel.org>; Mon, 25 Mar 2019 16:22:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BDF082083D
	for <linux-block@archiver.kernel.org>; Mon, 25 Mar 2019 16:22:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="lDl+tZIs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729278AbfCYQWy (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 25 Mar 2019 12:22:54 -0400
Received: from mail-io1-f68.google.com ([209.85.166.68]:36153 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726024AbfCYQWx (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 25 Mar 2019 12:22:53 -0400
Received: by mail-io1-f68.google.com with SMTP id f6so8152925iop.3
        for <linux-block@vger.kernel.org>; Mon, 25 Mar 2019 09:22:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=to:cc:from:subject:message-id:date:user-agent:mime-version
         :content-language:content-transfer-encoding;
        bh=PQiIDfSeExLN0W62UkHWbJVMzuNGqhCTfDjoX3zemfs=;
        b=lDl+tZIsCw0q+Ahs4bz6BDO72ysg+yY7D8elJu92RvYzclYhWffw1AwIdd1qzvxFUT
         Gu/1oEgB8D1SgHhPQI5WvhzoqHiMyRGv6bq9FHB0cFAtG4lcb9tVM/TjBdEsU6wV7gIr
         3K3WyM6NT0aD2kdLZtSRRNIdtu/hbx72vNCG5p6RrFzXnb37+/siwi6uq+8ew2ScE8ls
         QZ3RgAsi1Mdl/INcfUAefiNopeZf2O1w/1dqflrHU22/c5CM+8K6ANestcZhnU36/RAI
         h4OaNTP9iIIpWrb4ejkrBgXzmBPwjNvBPlUx7Q/+LEGnjc0kaHh8Bn3GTcwg3xsx9CWE
         ZrFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:cc:from:subject:message-id:date:user-agent
         :mime-version:content-language:content-transfer-encoding;
        bh=PQiIDfSeExLN0W62UkHWbJVMzuNGqhCTfDjoX3zemfs=;
        b=uEkQ9wUgqGcF1DIzQX6t8ViKHwsI6NP8XK4R68C5w918+nUkN4zXZ8arAm1triop8y
         0OaqihLfiODwsvKjxu4hnTkz1McTPLIzzYPmi7u336UWuNr9Sul1CjSwxb462AScokwT
         jIwKd84GYQAf5I5bZtk1oGR2aSbiXmlUx2HTBWjn3Z71NWaNZMh4uzOOHNqaaPrOY6vu
         z43qpXxHS96xWa8WOn5Eff+BoHvhKP7XD+t3Wdy2ShBH/BgttrLCXgwFSqi5bhLYxUvg
         IeIGQ4Pls20umr+AJsnwPKrmJoZJ+8OqP0ZeNYAdOdShZggb21dBaQlEQM9sEVepM2at
         W3pA==
X-Gm-Message-State: APjAAAXrtT1S3xcyqMTxHidQWE35xuYgGTYygp01Vonm1nW9RnNRQ8FA
        VfjwE50tPcZRrcQVMAgVPqTFHw==
X-Google-Smtp-Source: APXvYqz703h1m86oAOIDejjSlSD2Q4XkIpQKVwAI3vlPlhVYLQhmC0e52HEu1iSa/Uu1aE6a+dINDw==
X-Received: by 2002:a5e:8c07:: with SMTP id n7mr17774123ioj.301.1553530973033;
        Mon, 25 Mar 2019 09:22:53 -0700 (PDT)
Received: from [192.168.1.158] ([216.160.245.98])
        by smtp.gmail.com with ESMTPSA id a8sm6700557iol.35.2019.03.25.09.22.51
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 25 Mar 2019 09:22:51 -0700 (PDT)
To:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Cc:     Omar Sandoval <osandov@fb.com>
From:   Jens Axboe <axboe@kernel.dk>
Subject: [PATCH] blk-mq: fix sbitmap ws_active for shared tags
Message-ID: <c0d3f0c8-a5d7-19dd-7b7f-1d4f860c425b@kernel.dk>
Date:   Mon, 25 Mar 2019 10:22:50 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

We now wrap sbitmap waitqueues in an active counter, so we can avoid
iterating wakeups unless we have waiters there. This works as long as
everyone that's manipulating the waitqueues use the proper helpers. For
the tag wait case for shared tags, however, we add ourselves to the
waitqueue without incrementing/decrementing the ->ws_active count. This
means that wakeups can take a long time to happen.

Fix this by manually doing the inc/dec as needed for the wait queue
handling.

Fixes: 5d2ee7122c73 ("sbitmap: optimize wakeup check")
Signed-off-by: Jens Axboe <axboe@kernel.dk>

---

Got a bug report on raid5 on 4 USB-3 attached drives which is slow with
5.0, but works fine with the ->ws_active check bypassed. Waiting for
confirmation that this patch fixes it, but I think it will.

diff --git a/block/blk-mq.c b/block/blk-mq.c
index 28080b0235f0..3ff3d7b49969 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -1072,7 +1072,13 @@ static int blk_mq_dispatch_wake(wait_queue_entry_t *wait, unsigned mode,
 	hctx = container_of(wait, struct blk_mq_hw_ctx, dispatch_wait);
 
 	spin_lock(&hctx->dispatch_wait_lock);
-	list_del_init(&wait->entry);
+	if (!list_empty(&wait->entry)) {
+		struct sbitmap_queue *sbq;
+
+		list_del_init(&wait->entry);
+		sbq = &hctx->tags->bitmap_tags;
+		atomic_dec(&sbq->ws_active);
+	}
 	spin_unlock(&hctx->dispatch_wait_lock);
 
 	blk_mq_run_hw_queue(hctx, true);
@@ -1088,6 +1094,7 @@ static int blk_mq_dispatch_wake(wait_queue_entry_t *wait, unsigned mode,
 static bool blk_mq_mark_tag_wait(struct blk_mq_hw_ctx *hctx,
 				 struct request *rq)
 {
+	struct sbitmap_queue *sbq = &hctx->tags->bitmap_tags;
 	struct wait_queue_head *wq;
 	wait_queue_entry_t *wait;
 	bool ret;
@@ -1110,7 +1117,7 @@ static bool blk_mq_mark_tag_wait(struct blk_mq_hw_ctx *hctx,
 	if (!list_empty_careful(&wait->entry))
 		return false;
 
-	wq = &bt_wait_ptr(&hctx->tags->bitmap_tags, hctx)->wait;
+	wq = &bt_wait_ptr(sbq, hctx)->wait;
 
 	spin_lock_irq(&wq->lock);
 	spin_lock(&hctx->dispatch_wait_lock);
@@ -1120,6 +1127,7 @@ static bool blk_mq_mark_tag_wait(struct blk_mq_hw_ctx *hctx,
 		return false;
 	}
 
+	atomic_inc(&sbq->ws_active);
 	wait->flags &= ~WQ_FLAG_EXCLUSIVE;
 	__add_wait_queue(wq, wait);
 
@@ -1140,6 +1148,7 @@ static bool blk_mq_mark_tag_wait(struct blk_mq_hw_ctx *hctx,
 	 * someone else gets the wakeup.
 	 */
 	list_del_init(&wait->entry);
+	atomic_dec(&sbq->ws_active);
 	spin_unlock(&hctx->dispatch_wait_lock);
 	spin_unlock_irq(&wq->lock);
 

-- 
Jens Axboe


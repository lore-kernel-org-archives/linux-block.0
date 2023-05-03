Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8479DC77B75
	for <linux-block@archiver.kernel.org>; Wed,  3 May 2023 12:20:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229821AbjECMUf (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 3 May 2023 08:20:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229741AbjECMUe (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 3 May 2023 08:20:34 -0400
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 317F65B84
        for <linux-block@vger.kernel.org>; Wed,  3 May 2023 05:20:26 -0700 (PDT)
Received: by mail-wm1-x32e.google.com with SMTP id 5b1f17b1804b1-3f19afc4fbfso50879185e9.2
        for <linux-block@vger.kernel.org>; Wed, 03 May 2023 05:20:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linbit-com.20221208.gappssmtp.com; s=20221208; t=1683116424; x=1685708424;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=HbIHW3WFJjCSlSmcogKsdyCdUd7ycb8fmjWMREeXjCw=;
        b=zm+0MHgI8YyjZvCVYCL/QFDiqrw357GfINXK71fw/0AwoNi4xZmbOshugboG9853+R
         LMpLqMeF77seN4g464PWWTnF+Pe21tgYZATz/nt/9KKkzpyl2rlZmipc6OgV9ASGhvDJ
         9UIJksnpNv3xYoqBz7bRAX7b2nRZksmJJLNtcrJhDiYCAhkPHPizhl357QAQZHzj/Roh
         /MPx0MMrofRRHdaSC4SdgM/8KduspCsmE6ssnfei5qeida9JCHvt/V0zPwnpilvmDRFG
         yuK3ySJ9GX6+nL4tTbFSYkLcIeC9prqfDrkX43lQ/LVvxusEpEKRbEbGAZunCYsGJQzt
         2eZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683116424; x=1685708424;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HbIHW3WFJjCSlSmcogKsdyCdUd7ycb8fmjWMREeXjCw=;
        b=K48SUwFx7xaZk424PPYcvrGG+Rsnc7jvdNrW9+dxMvD6Qf24XO4x2ZBpvDvzrjaliN
         pCkdaP7kiFsKvskNP4MajHRzfnRpx4GVAoizSvwuggqK6G5KrLv3zcsCf5W3MbaOcIBE
         Mq8Qmz3HEivnOu3aPitDzT1LRn5m3eqA/UUcHdxY2RCl17onqqqsDcmFLxdyE/7ikNi7
         FTZzlY1icEqy6GddCRFpO1UkFDbVBEFI1u4efp46Gg4XhZDX29SKOVoM4WHsx8ioUjIn
         5oNZS/FbctWHvzR68RAzychuJUz3aayLoqLiKRsTANc27lYS2IFOsS418jiPqyOs68kB
         QPpQ==
X-Gm-Message-State: AC+VfDzMAZU+pDJcToWnrhB30bzqd4w/n2r/zKsXkpGzCRL1BD/3u+YN
        94Ab28Z3xjc8c5w0NFffMSHni+2FSIi2k8PKKdlnZQ==
X-Google-Smtp-Source: ACHHUZ4vVAbqI84nqD7SfKcPc/YM/bQUCMMrNM47k+DsevZb0DiO+zbCK2U2kzTlyFRPoxZOz/BdbA==
X-Received: by 2002:a7b:c047:0:b0:3f1:979f:a734 with SMTP id u7-20020a7bc047000000b003f1979fa734mr14560520wmc.11.1683116424668;
        Wed, 03 May 2023 05:20:24 -0700 (PDT)
Received: from localhost.localdomain (h082218028181.host.wavenet.at. [82.218.28.181])
        by smtp.gmail.com with ESMTPSA id q7-20020a1ce907000000b003f180d5b145sm1748027wmc.40.2023.05.03.05.20.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 May 2023 05:20:24 -0700 (PDT)
From:   =?UTF-8?q?Christoph=20B=C3=B6hmwalder?= 
        <christoph.boehmwalder@linbit.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     drbd-dev@lists.linbit.com, linux-kernel@vger.kernel.org,
        Lars Ellenberg <lars.ellenberg@linbit.com>,
        Philipp Reisner <philipp.reisner@linbit.com>,
        linux-block@vger.kernel.org,
        =?UTF-8?q?Christoph=20B=C3=B6hmwalder?= 
        <christoph.boehmwalder@linbit.com>,
        Christoph Hellwig <hch@infradead.org>, stable@vger.kernel.org,
        Thomas Voegtle <tv@lio96.de>
Subject: [PATCH] drbd: correctly submit flush bio on barrier
Date:   Wed,  3 May 2023 14:19:37 +0200
Message-Id: <20230503121937.17232-1-christoph.boehmwalder@linbit.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

When we receive a flush command (or "barrier" in DRBD), we currently use
a REQ_OP_FLUSH with the REQ_PREFLUSH flag set.

The correct way to submit a flush bio is by using a REQ_OP_WRITE without
any data, and set the REQ_PREFLUSH flag.

Since commit b4a6bb3a67aa ("block: add a sanity check for non-write
flush/fua bios"), this triggers a warning in the block layer, but this
has been broken for quite some time before that.

So use the correct set of flags to actually make the flush happen.

Cc: Christoph Hellwig <hch@infradead.org>
Cc: stable@vger.kernel.org
Fixes: f9ff0da56437 ("drbd: allow parallel flushes for multi-volume resources")
Reported-by: Thomas Voegtle <tv@lio96.de>
Signed-off-by: Christoph Böhmwalder <christoph.boehmwalder@linbit.com>
---
Previous, incorrect version of this patch:
https://lore.kernel.org/all/20230502092922.175857-1-christoph.boehmwalder@linbit.com/

 drivers/block/drbd/drbd_receiver.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/block/drbd/drbd_receiver.c b/drivers/block/drbd/drbd_receiver.c
index e54404c632e7..34b112752ab1 100644
--- a/drivers/block/drbd/drbd_receiver.c
+++ b/drivers/block/drbd/drbd_receiver.c
@@ -1283,7 +1283,7 @@ static void one_flush_endio(struct bio *bio)
 static void submit_one_flush(struct drbd_device *device, struct issue_flush_context *ctx)
 {
 	struct bio *bio = bio_alloc(device->ldev->backing_bdev, 0,
-				    REQ_OP_FLUSH | REQ_PREFLUSH, GFP_NOIO);
+				    REQ_OP_WRITE | REQ_PREFLUSH, GFP_NOIO);
 	struct one_flush_context *octx = kmalloc(sizeof(*octx), GFP_NOIO);
 
 	if (!octx) {
-- 
2.39.2


Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10DEDC77B7E
	for <linux-block@archiver.kernel.org>; Tue,  2 May 2023 09:29:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233412AbjEBJ3l (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 2 May 2023 05:29:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229863AbjEBJ3k (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 2 May 2023 05:29:40 -0400
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DBC4149FF
        for <linux-block@vger.kernel.org>; Tue,  2 May 2023 02:29:38 -0700 (PDT)
Received: by mail-wm1-x32c.google.com with SMTP id 5b1f17b1804b1-3f19afc4fbfso34654155e9.2
        for <linux-block@vger.kernel.org>; Tue, 02 May 2023 02:29:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linbit-com.20221208.gappssmtp.com; s=20221208; t=1683019777; x=1685611777;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=r+KWoq0ZrMb5+AWkT4Fb5UOL/QpDrPZJUKENZjHUHx8=;
        b=C2p+Yz00KsTo+nI4wF0SRGz2RcT7vAedjVPyzEzLIkLHIJRDmYu16UNqY6917P2lNs
         UjlYzDt1CXTFRoKCOsQLHemBW2QPi9eDfWGzUYmMwCnr4SjSYxo4hvCR923/ZNjz8S5d
         QJ7DPNil9kuPtPFpvGvWzSaj/u/69OHljxcXcLc9KP4UZ4kpyQqvAJMtWRPXu0VtYLGn
         nCS+0ygFwTmvszZzt6Ucz1FlKoaHAi6+X1I3azrRjKoYTzUVvtnmMWmNC+CjWoSjAZcJ
         2CofMomdKGhSLdr8iJLylMktriVqY+VM7yyt/A/6MohiBVbO/XBHzLq7RvVw39ec1ta5
         Uozg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683019777; x=1685611777;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=r+KWoq0ZrMb5+AWkT4Fb5UOL/QpDrPZJUKENZjHUHx8=;
        b=BHiCzJ+JVhZjcnXuQOR3ADtVYgwl1687LK3jC46uDWug8y46QS87k0bkeoq0Yj0e5D
         VbRorMaf//gJsZWtcsT8Jxss1xveoyD2NV2Wse8TS9RKdV6Eqk2JzJUUiyinXC1y3zHw
         Q4GqNHDAeeF2qDDmnmdL11lOoRjKcVTTYXk2VvvOQP0LEO5/2nRpi7K0IYgIiJpx2ZPk
         nqPsIH3x9qeg2fW6G64kyfv9hV45X1WGIGv3k6W/PykMr4nHH0zhu8zK9H9yA7F0kDKm
         kmd4dojdEbQzKKRa9TOCPOfnt/izIDBVhVGe0ogLuiJMYncMRwJjmqy7LDDdiSNpk5X4
         Am8Q==
X-Gm-Message-State: AC+VfDz5IlLfw2jAAEK8itTFQS1isdGXZx60X1eCmsgKxdqbvo9q9sCA
        a7UtEcvEDO8RKSFXonJsjNZ3qg==
X-Google-Smtp-Source: ACHHUZ7SuacCVSmCD9PvjtcPmUjV2mI9SUWTFnUsRGGmGxW/Nfhw+xvmfP0amNQIS8V/TJpEGEhyXA==
X-Received: by 2002:adf:f58a:0:b0:2f9:cee4:b7d with SMTP id f10-20020adff58a000000b002f9cee40b7dmr10637377wro.70.1683019777365;
        Tue, 02 May 2023 02:29:37 -0700 (PDT)
Received: from localhost.localdomain (h082218028181.host.wavenet.at. [82.218.28.181])
        by smtp.gmail.com with ESMTPSA id d14-20020a5d538e000000b002efac42ff35sm30481138wrv.37.2023.05.02.02.29.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 May 2023 02:29:36 -0700 (PDT)
From:   =?UTF-8?q?Christoph=20B=C3=B6hmwalder?= 
        <christoph.boehmwalder@linbit.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     drbd-dev@lists.linbit.com, linux-kernel@vger.kernel.org,
        Lars Ellenberg <lars.ellenberg@linbit.com>,
        Philipp Reisner <philipp.reisner@linbit.com>,
        linux-block@vger.kernel.org,
        =?UTF-8?q?Christoph=20B=C3=B6hmwalder?= 
        <christoph.boehmwalder@linbit.com>, Thomas Voegtle <tv@lio96.de>
Subject: [PATCH] drbd: do not set REQ_PREFLUSH when submitting barrier
Date:   Tue,  2 May 2023 11:29:22 +0200
Message-Id: <20230502092922.175857-1-christoph.boehmwalder@linbit.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

When we receive a flush command (or "barrier" in DRBD), we currently use
a REQ_OP_FLUSH with the REQ_PREFLUSH flag set.

REQ_OP_FLUSH is supposed to be an empty bio with the sole purpose of
flushing the disk. REQ_PREFLUSH is used for REQ_OP_WRITE bios to
additionally signal that a flush should be issued, so it is redundant
here.

Since commit b4a6bb3a67aa ("block: add a sanity check for non-write
flush/fua bios"), this triggers a warning in the block layer.
So remove the REQ_PREFLUSH flag when allocating the bio.

Fixes: f9ff0da56437 ("drbd: allow parallel flushes for multi-volume resources")
Reported-by: Thomas Voegtle <tv@lio96.de>
Signed-off-by: Christoph Böhmwalder <christoph.boehmwalder@linbit.com>
---
 drivers/block/drbd/drbd_receiver.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/block/drbd/drbd_receiver.c b/drivers/block/drbd/drbd_receiver.c
index e54404c632e7..f2479c29197a 100644
--- a/drivers/block/drbd/drbd_receiver.c
+++ b/drivers/block/drbd/drbd_receiver.c
@@ -1283,7 +1283,7 @@ static void one_flush_endio(struct bio *bio)
 static void submit_one_flush(struct drbd_device *device, struct issue_flush_context *ctx)
 {
 	struct bio *bio = bio_alloc(device->ldev->backing_bdev, 0,
-				    REQ_OP_FLUSH | REQ_PREFLUSH, GFP_NOIO);
+				    REQ_OP_FLUSH, GFP_NOIO);
 	struct one_flush_context *octx = kmalloc(sizeof(*octx), GFP_NOIO);
 
 	if (!octx) {
-- 
2.39.2


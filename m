Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1697C433EF
	for <linux-block@archiver.kernel.org>; Tue, 19 Oct 2021 21:24:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 99B4E61355
	for <linux-block@archiver.kernel.org>; Tue, 19 Oct 2021 21:24:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229521AbhJSV0t (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 19 Oct 2021 17:26:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229483AbhJSV0t (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 19 Oct 2021 17:26:49 -0400
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09DC4C06161C
        for <linux-block@vger.kernel.org>; Tue, 19 Oct 2021 14:24:36 -0700 (PDT)
Received: by mail-wm1-x32b.google.com with SMTP id z77-20020a1c7e50000000b0030db7b70b6bso5679703wmc.1
        for <linux-block@vger.kernel.org>; Tue, 19 Oct 2021 14:24:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=fKkwHTUtYVuEoE7mZDvi41g9g5mXV7xtQqtX4zIAEZI=;
        b=FAry/GyM2e0kOTlythIvfEzRGo5aBPHNRgviKt1Yq0XNem8hxmIQ8VI31HcPsdrX5L
         Cufw6u+VsIAdKQEsYy85tehnAi/kofU06V08AKEqFUIB83FXXF1f5gzoYuzm02+k0WWl
         5wiqJb/VAtVxnMcMNTk1NrcmMWfuBllbU65LT+VekelDzwAeGE8chXdW54Dk6muqCbwM
         7F5VOzE5OpBx1/ApfEKR84qfpTorw+8LyjZJOq96qYP7Snrjeu6TtgFF1IYhV8EnltPU
         BCipQgskPHuRnjETbJH1DX+Qg5ioen9xjTeSB3I0ih7FB6kHv7CsrrhLHS+Bm1q+cV0p
         9o+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=fKkwHTUtYVuEoE7mZDvi41g9g5mXV7xtQqtX4zIAEZI=;
        b=y8zdPhFojS1c9XLPba9+5Hk6/idS4Qo16+cX7DdEXlNXaOTjACe1waj+6YfogBXm2M
         ogsMAe9gIkBxwmtMay+kTcInGRwMHZDra2PlgprCO3Lv1dGRzYnv3Qjx0Wgw/yEIgihu
         zl9p10BElK+v2uoiwtS+U53whFXlQe5cVmXH1kYpyMbqLDYJVc/1GC5+nMPl/tnMGesf
         KEadpwhj8bYK/bcmJGRcgKeXu0wGkshQYtV7PG8Z0C75/x5pMhUAiSkYi7CIuvVEWeeq
         pY0Ox40qW5l64cuZSB69ye3u1KgYpRERmlx8meQUeAZSZk7xPXknQeQNCZPWGFrZA2TQ
         B0eg==
X-Gm-Message-State: AOAM532MSNd9ktVWR0O4yNWw3vSa0CgmiZKemefBY49DWjuyTI9qXTB4
        EyHF0NPgX+aiAYMXqvu/6PLvECfGz4KIAA==
X-Google-Smtp-Source: ABdhPJzviAd2Y25S1F7DtSVWZYvZmDsOz+2UX1aNvqQ7SOEMvGZ9+Ietqsv1UKsnYWLE6U4/ZsbDJQ==
X-Received: by 2002:a05:600c:1912:: with SMTP id j18mr4584513wmq.117.1634678674446;
        Tue, 19 Oct 2021 14:24:34 -0700 (PDT)
Received: from 127.0.0.1localhost ([185.69.145.194])
        by smtp.gmail.com with ESMTPSA id m14sm216020wms.25.2021.10.19.14.24.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Oct 2021 14:24:34 -0700 (PDT)
From:   Pavel Begunkov <asml.silence@gmail.com>
To:     linux-block@vger.kernel.org
Cc:     Jens Axboe <axboe@kernel.dk>,
        Pavel Begunkov <asml.silence@gmail.com>
Subject: [PATCH 02/16] block: convert leftovers to bdev_get_queue
Date:   Tue, 19 Oct 2021 22:24:11 +0100
Message-Id: <654f1cba1fe9c321cb87943ee33a21c7ea3d8e65.1634676157.git.asml.silence@gmail.com>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <cover.1634676157.git.asml.silence@gmail.com>
References: <cover.1634676157.git.asml.silence@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Convert bdev->bd_disk->queue to bdev_get_queue(), which is faster.
Apparently, there are a few such spots in block that got lost during
rebases.

Signed-off-by: Pavel Begunkov <asml.silence@gmail.com>
---
 block/blk-core.c  | 2 +-
 block/blk-merge.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/block/blk-core.c b/block/blk-core.c
index e6ad5b51d0c3..c1ba34777c6d 100644
--- a/block/blk-core.c
+++ b/block/blk-core.c
@@ -1080,7 +1080,7 @@ EXPORT_SYMBOL(submit_bio);
  */
 int bio_poll(struct bio *bio, struct io_comp_batch *iob, unsigned int flags)
 {
-	struct request_queue *q = bio->bi_bdev->bd_disk->queue;
+	struct request_queue *q = bdev_get_queue(bio->bi_bdev);
 	blk_qc_t cookie = READ_ONCE(bio->bi_cookie);
 	int ret;
 
diff --git a/block/blk-merge.c b/block/blk-merge.c
index 3e6fa449caff..df69f4bb7717 100644
--- a/block/blk-merge.c
+++ b/block/blk-merge.c
@@ -383,7 +383,7 @@ void __blk_queue_split(struct request_queue *q, struct bio **bio,
  */
 void blk_queue_split(struct bio **bio)
 {
-	struct request_queue *q = (*bio)->bi_bdev->bd_disk->queue;
+	struct request_queue *q = bdev_get_queue((*bio)->bi_bdev);
 	unsigned int nr_segs;
 
 	if (blk_may_split(q, *bio))
-- 
2.33.1


Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5978C433EF
	for <linux-block@archiver.kernel.org>; Thu, 14 Oct 2021 14:04:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BEA86610E7
	for <linux-block@archiver.kernel.org>; Thu, 14 Oct 2021 14:04:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231749AbhJNOGZ (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 14 Oct 2021 10:06:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231741AbhJNOGY (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 14 Oct 2021 10:06:24 -0400
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80EDEC061570;
        Thu, 14 Oct 2021 07:04:19 -0700 (PDT)
Received: by mail-wr1-x431.google.com with SMTP id r7so19904477wrc.10;
        Thu, 14 Oct 2021 07:04:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=xMDSwcqMD4khSm3c9+/YMjtoelEIVc6ZxCpty49UuyU=;
        b=AxiIhFD4IfhliDORTe+QwUkODFNn2c4w4V550YqOchrB0VvuDHq4bp0zfGMywng0VO
         ytcIbMhk8GkDfDfdQwIRSyzzxvs/ObiOtimP4+Nhwkd/+belDjXXtJVn33zsgoHrasX/
         Nz0orwzf1jtKSMbHS79S2KFMfa3kroOlD8QrWQrllyf93xpCglKxS1PAOe9/zYTIikaT
         jQVHE1P4NwY/VQjyi2MYmQ0vPkNYxjgRQkNgTu6PU2zhXeGviJ8aThj4LiuXVykD21Zt
         BRzc0t7prrH30pf4DHIkNTSN0gu2FNfQgn3QA1HEAIGprBPVNQU48SWZveBX1AwUqnYq
         ypZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=xMDSwcqMD4khSm3c9+/YMjtoelEIVc6ZxCpty49UuyU=;
        b=swYkyTIz3fYI4AUafWBnzpbUjExu5+VuYNlepbxz7UKcqcomHPm7OIDn4OIFXgBWwA
         xJVItsUKYIgt1YzyDy9EPajt0nLHFmB/R7JkDNhd893lJNgHAaOcjS/E/KynqL/8fhAW
         3eKopfaw6xrFkToBsxXkIV6DD2psNL4R7XDOVfbkPcq1VkNCtBasc1+xhqYZNWgHjvC1
         GPsnPjYHsK6l/mN3dOTerdfo+1QcOwySKMq0n/YKfPpkeXvMIFYCh0T09ijNlwhxEm4B
         jnCPJlmBYJNLDYbKj3oCVuKc9yYvYzb5vz1K4pzUc0lGVtATE2ZKvIAAshc5Fnc9+3Rt
         GYEg==
X-Gm-Message-State: AOAM532U9Stz7kdKj2sE9aFNyuLblSNd3FL7/G7PCYxozNFfeEQTVbKg
        lfSK/IZGUHL3c/dYjBoNMgg=
X-Google-Smtp-Source: ABdhPJzrkk7jigfMVG5/daAjnzuaUl/cNSCh7B7Dz7rLgE88dqX88O4ynmQFt7yV3Gbvcq2Omfy6jw==
X-Received: by 2002:a05:6000:1869:: with SMTP id d9mr6741492wri.161.1634220258116;
        Thu, 14 Oct 2021 07:04:18 -0700 (PDT)
Received: from localhost.localdomain ([185.69.145.214])
        by smtp.gmail.com with ESMTPSA id p8sm2273461wmg.15.2021.10.14.07.04.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Oct 2021 07:04:17 -0700 (PDT)
From:   Pavel Begunkov <asml.silence@gmail.com>
To:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Christoph Hellwig <hch@infradead.org>, asml.silence@gmail.com
Subject: [PATCH 2/5] block: use bdev_get_queue() in bdev.c
Date:   Thu, 14 Oct 2021 15:03:27 +0100
Message-Id: <a352936ce5d9ac719645b1e29b173d931ebcdc02.1634219547.git.asml.silence@gmail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <cover.1634219547.git.asml.silence@gmail.com>
References: <cover.1634219547.git.asml.silence@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Convert bdev->bd_disk->queue to bdev_get_queue(), it's uses a cached
queue pointer and so is fater.

Signed-off-by: Pavel Begunkov <asml.silence@gmail.com>
---
 block/bdev.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/block/bdev.c b/block/bdev.c
index 30ae5b5d5f91..384e5bf991d8 100644
--- a/block/bdev.c
+++ b/block/bdev.c
@@ -327,12 +327,12 @@ int bdev_read_page(struct block_device *bdev, sector_t sector,
 	if (!ops->rw_page || bdev_get_integrity(bdev))
 		return result;
 
-	result = blk_queue_enter(bdev->bd_disk->queue, 0);
+	result = blk_queue_enter(bdev_get_queue(bdev), 0);
 	if (result)
 		return result;
 	result = ops->rw_page(bdev, sector + get_start_sect(bdev), page,
 			      REQ_OP_READ);
-	blk_queue_exit(bdev->bd_disk->queue);
+	blk_queue_exit(bdev_get_queue(bdev));
 	return result;
 }
 
@@ -363,7 +363,7 @@ int bdev_write_page(struct block_device *bdev, sector_t sector,
 
 	if (!ops->rw_page || bdev_get_integrity(bdev))
 		return -EOPNOTSUPP;
-	result = blk_queue_enter(bdev->bd_disk->queue, 0);
+	result = blk_queue_enter(bdev_get_queue(bdev), 0);
 	if (result)
 		return result;
 
@@ -376,7 +376,7 @@ int bdev_write_page(struct block_device *bdev, sector_t sector,
 		clean_page_buffers(page);
 		unlock_page(page);
 	}
-	blk_queue_exit(bdev->bd_disk->queue);
+	blk_queue_exit(bdev_get_queue(bdev));
 	return result;
 }
 
-- 
2.33.0


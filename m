Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90006C433EF
	for <linux-block@archiver.kernel.org>; Mon, 25 Oct 2021 14:25:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6A51B60EE3
	for <linux-block@archiver.kernel.org>; Mon, 25 Oct 2021 14:25:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233512AbhJYO1z (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 25 Oct 2021 10:27:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233514AbhJYO1z (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 25 Oct 2021 10:27:55 -0400
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39CC2C061745
        for <linux-block@vger.kernel.org>; Mon, 25 Oct 2021 07:25:33 -0700 (PDT)
Received: by mail-pl1-x62d.google.com with SMTP id c4so4153884plg.13
        for <linux-block@vger.kernel.org>; Mon, 25 Oct 2021 07:25:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=av0r/rjVqFrB/l7qERXJM+4hS0XcNVLfoNKN5vMbJNg=;
        b=x+zZ0eT2uie+47FbGcJT8mHH+XjW/4Ds3sjIAGgjAuF2E93R6vyPWhEmp75duwvgDu
         b9f+IjX290S6wRBGAzLK2zKpz2gMrmZkB5Wuzx67N7Qra6cOdsjog7MAk8Kveq9jeDi1
         LDvOAXPjAE5GcIf6PJaWaviYiIDwnZsPxa2/x0ENnVH0C2DIpToPlsmUFg6zTjQeCkso
         UZjfP66tbd9MJ/aPd6ajIU8I9WaweWquuEhyWN3c3y59n3axDr9pXBsSZ8RrFbY+trpQ
         qqP5Xbky4kw+ORXJKs5EVwysoe7NULRJ28tlgijvLYWwwL+Z8HAJaAuZUopEXNhHiagW
         FXBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=av0r/rjVqFrB/l7qERXJM+4hS0XcNVLfoNKN5vMbJNg=;
        b=pIwt5ijVRiyc2xbKStvN37oUQBSattTCOVeEPCbnOw/jI50aV4X+uma3hYmwQNbYP7
         YtwxopQ8SxTmvaKDhqg3SiKuvg1Is75So9GW9ZYxul2CO1Oiiev344EiwBxetq5mQJ2b
         2ixy2uY/1afSxDgnxt8YAmLWoxdYWA4XXPHTmVd7Sym6SlmyL4aIQ5CdIZOLVSpS6fM4
         ySgFl7URCK5e/1lX6aM9RLpb5x/VBT95G2YOPTfWnFwvHe6G1aA1WmgcWc/Gs1mudbp0
         I5ALQeebVvkIZx/7Eo3d2sjdTG2nYcfKuL2I1YtY380FXkqVftaWzdDgvLU0WGIdD8tQ
         nVWw==
X-Gm-Message-State: AOAM533fOEE08ww8ppPKW6y6E7OE/jX4BrQEeJgFdJih3hjVeEedeZvu
        j6dEpRr3+cGyLiiVevOMKiShGMLI4uLz
X-Google-Smtp-Source: ABdhPJyhiVjNl7b9fz60gTx056u54hm+xBqxLbAE1GxLDhDkOva6CNRgvBIx+2Wgf5QcgiqLOfic2w==
X-Received: by 2002:a17:90b:2248:: with SMTP id hk8mr21042080pjb.102.1635171932763;
        Mon, 25 Oct 2021 07:25:32 -0700 (PDT)
Received: from localhost ([139.177.225.234])
        by smtp.gmail.com with ESMTPSA id c8sm17270047pgn.72.2021.10.25.07.25.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Oct 2021 07:25:31 -0700 (PDT)
From:   Xie Yongji <xieyongji@bytedance.com>
To:     axboe@kernel.dk, hch@lst.de, josef@toxicpanda.com, mst@redhat.com,
        jasowang@redhat.com, stefanha@redhat.com, kwolf@redhat.com
Cc:     linux-block@vger.kernel.org, nbd@other.debian.org,
        virtualization@lists.linux-foundation.org
Subject: [PATCH v2 3/4] loop: Use blk_validate_block_size() to validate block size
Date:   Mon, 25 Oct 2021 22:25:05 +0800
Message-Id: <20211025142506.167-4-xieyongji@bytedance.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211025142506.167-1-xieyongji@bytedance.com>
References: <20211025142506.167-1-xieyongji@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Remove loop_validate_block_size() and use the block layer helper
to validate block size.

Signed-off-by: Xie Yongji <xieyongji@bytedance.com>
---
 drivers/block/loop.c | 17 ++---------------
 1 file changed, 2 insertions(+), 15 deletions(-)

diff --git a/drivers/block/loop.c b/drivers/block/loop.c
index 7bf4686af774..dfc72a1f6500 100644
--- a/drivers/block/loop.c
+++ b/drivers/block/loop.c
@@ -273,19 +273,6 @@ static void __loop_update_dio(struct loop_device *lo, bool dio)
 }
 
 /**
- * loop_validate_block_size() - validates the passed in block size
- * @bsize: size to validate
- */
-static int
-loop_validate_block_size(unsigned short bsize)
-{
-	if (bsize < 512 || bsize > PAGE_SIZE || !is_power_of_2(bsize))
-		return -EINVAL;
-
-	return 0;
-}
-
-/**
  * loop_set_size() - sets device size and notifies userspace
  * @lo: struct loop_device to set the size for
  * @size: new size of the loop device
@@ -1236,7 +1223,7 @@ static int loop_configure(struct loop_device *lo, fmode_t mode,
 	}
 
 	if (config->block_size) {
-		error = loop_validate_block_size(config->block_size);
+		error = blk_validate_block_size(config->block_size);
 		if (error)
 			goto out_unlock;
 	}
@@ -1759,7 +1746,7 @@ static int loop_set_block_size(struct loop_device *lo, unsigned long arg)
 	if (lo->lo_state != Lo_bound)
 		return -ENXIO;
 
-	err = loop_validate_block_size(arg);
+	err = blk_validate_block_size(arg);
 	if (err)
 		return err;
 
-- 
2.11.0


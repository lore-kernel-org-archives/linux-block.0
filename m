Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55137C2B9F4
	for <linux-block@archiver.kernel.org>; Thu, 17 Jun 2021 05:10:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 223416128C
	for <linux-block@archiver.kernel.org>; Thu, 17 Jun 2021 05:10:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229565AbhFQFMb (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 17 Jun 2021 01:12:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229546AbhFQFMa (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 17 Jun 2021 01:12:30 -0400
Received: from mail-pg1-x534.google.com (mail-pg1-x534.google.com [IPv6:2607:f8b0:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A69FBC06175F
        for <linux-block@vger.kernel.org>; Wed, 16 Jun 2021 22:10:22 -0700 (PDT)
Received: by mail-pg1-x534.google.com with SMTP id m2so3945635pgk.7
        for <linux-block@vger.kernel.org>; Wed, 16 Jun 2021 22:10:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=QrB1LaHxmsUMEUbEmWqOGvCbkMD2WMAnWAOQwFIjDR8=;
        b=GMmlnXepyTLpaWDWNAFkKV1r5MQXomUdOXMlnkVB2r/1F2joQw7C96cD9RP1pOdt4X
         mkeFt19wbvKKq2XGbEZaSwzpfvmQeLxbju64lXjiFOBeAZbSqITRIc0hEJmXc+hm/MUl
         WD+RgWJPww8wJmgNak3yfSCjbF9F/9jy4XQHVlwMlMDi+Cb+c+NlPE2JA0MOXUPgSwcV
         rySQ1PYpkn1mGdjccrtZw82IAEbm0PCZKP8Z9D/h/7hXW+nq6PK+XyzX888FZomiC4+n
         k5JOhFHa3UZw0zi+NO61Nb+P2HxAy7X+9aFoeeTCw88v2w6eP8RHF0JwzeMvbyGCgQ+F
         AS1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=QrB1LaHxmsUMEUbEmWqOGvCbkMD2WMAnWAOQwFIjDR8=;
        b=EpAHeVpBZI3GfBWt2F6Tp9ylvjoi60cUmX4l0dnGXHz+CnC/AfbluaoytY8x22UGZM
         8CAuEhLVDQDl6BjNL4I1YqvtAdda3rEqaTnCkSqwACT3ZxSaefBEyFb0MJzQoBMT+M00
         2fh8X+jy8fRRwT7IMBlJbgkrw7Nr/kRpD8+de++ANGtG+EzMhZ6ZzIGEIloxgMQiXqjd
         9GmNQERO47EkCDbZGCMuSxOpAmiItBaRM4PX2/5Q70Iyah4LV1zEXE5Gu8GmYIPT+ORQ
         2HaOK51pCWna7CXJv78wvqKnUbyqLYAvhkznOfzb7AoQTQEUgbFRKDfebZ7tmXgOGnWf
         ieew==
X-Gm-Message-State: AOAM533UoVY4xO5cvhcYefXuyvuO8nUSdR+GnE9y2KPz0JlQ3CD5Nbsc
        NhTrTy/IjItee9QxMw/aLGYn
X-Google-Smtp-Source: ABdhPJzYbs81hm4LsNN9I0uXFaqOwQK9lzA7yhtoNT/J6tOdV36PA2V0NFOx6OkjvZyyKwNIOELzhQ==
X-Received: by 2002:a63:490a:: with SMTP id w10mr3268856pga.286.1623906622151;
        Wed, 16 Jun 2021 22:10:22 -0700 (PDT)
Received: from localhost ([61.120.150.78])
        by smtp.gmail.com with ESMTPSA id 11sm3652436pfh.182.2021.06.16.22.10.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Jun 2021 22:10:21 -0700 (PDT)
From:   Xie Yongji <xieyongji@bytedance.com>
To:     mst@redhat.com, jasowang@redhat.com, stefanha@redhat.com,
        axboe@kernel.dk
Cc:     virtualization@lists.linux-foundation.org,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3] virtio-blk: Add validation for block size in config space
Date:   Thu, 17 Jun 2021 13:10:04 +0800
Message-Id: <20210617051004.146-1-xieyongji@bytedance.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

This ensures that we will not use an invalid block size
in config space (might come from an untrusted device).

Signed-off-by: Xie Yongji <xieyongji@bytedance.com>
---
 drivers/block/virtio_blk.c | 29 +++++++++++++++++++++++------
 1 file changed, 23 insertions(+), 6 deletions(-)

diff --git a/drivers/block/virtio_blk.c b/drivers/block/virtio_blk.c
index b9fa3ef5b57c..bbdae989f1ea 100644
--- a/drivers/block/virtio_blk.c
+++ b/drivers/block/virtio_blk.c
@@ -696,6 +696,28 @@ static const struct blk_mq_ops virtio_mq_ops = {
 static unsigned int virtblk_queue_depth;
 module_param_named(queue_depth, virtblk_queue_depth, uint, 0444);
 
+static int virtblk_validate(struct virtio_device *vdev)
+{
+	u32 blk_size;
+
+	if (!vdev->config->get) {
+		dev_err(&vdev->dev, "%s failure: config access disabled\n",
+			__func__);
+		return -EINVAL;
+	}
+
+	if (!virtio_has_feature(vdev, VIRTIO_BLK_F_BLK_SIZE))
+		return 0;
+
+	blk_size = virtio_cread32(vdev,
+			offsetof(struct virtio_blk_config, blk_size));
+
+	if (blk_size < SECTOR_SIZE || blk_size > PAGE_SIZE)
+		__virtio_clear_bit(vdev, VIRTIO_BLK_F_BLK_SIZE);
+
+	return 0;
+}
+
 static int virtblk_probe(struct virtio_device *vdev)
 {
 	struct virtio_blk *vblk;
@@ -707,12 +729,6 @@ static int virtblk_probe(struct virtio_device *vdev)
 	u8 physical_block_exp, alignment_offset;
 	unsigned int queue_depth;
 
-	if (!vdev->config->get) {
-		dev_err(&vdev->dev, "%s failure: config access disabled\n",
-			__func__);
-		return -EINVAL;
-	}
-
 	err = ida_simple_get(&vd_index_ida, 0, minor_to_index(1 << MINORBITS),
 			     GFP_KERNEL);
 	if (err < 0)
@@ -994,6 +1010,7 @@ static struct virtio_driver virtio_blk = {
 	.driver.name			= KBUILD_MODNAME,
 	.driver.owner			= THIS_MODULE,
 	.id_table			= id_table,
+	.validate			= virtblk_validate,
 	.probe				= virtblk_probe,
 	.remove				= virtblk_remove,
 	.config_changed			= virtblk_config_changed,
-- 
2.11.0


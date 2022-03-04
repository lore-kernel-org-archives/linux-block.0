Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 933FBC433F5
	for <linux-block@archiver.kernel.org>; Fri,  4 Mar 2022 10:01:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239200AbiCDKCK (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 4 Mar 2022 05:02:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236543AbiCDKCI (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Fri, 4 Mar 2022 05:02:08 -0500
Received: from mail-pg1-x535.google.com (mail-pg1-x535.google.com [IPv6:2607:f8b0:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D858D19CCFA
        for <linux-block@vger.kernel.org>; Fri,  4 Mar 2022 02:01:20 -0800 (PST)
Received: by mail-pg1-x535.google.com with SMTP id w37so7101345pga.7
        for <linux-block@vger.kernel.org>; Fri, 04 Mar 2022 02:01:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=0uZuvt6hWY7FhWXwBOqHfs5cDRj/pveU7B/PnBb5g8k=;
        b=RzmiRvXPV6BAaKDgiQk686iZl9wds0zB5/v4fnDLwSdWlna3rpjGZw8e+qQY/aFIma
         tcUccbg0z7e7BSJJRr5K+jaUPQJ4S6qHZ/SjVSsxSMj8k1AhmE4wN92Uo3qSMNziT0Se
         VKd2CBpac1hypN+aOWK1UgO4GAorkYoUh2P+bN4csrYXAS8LnSaW8Ap5+yuxlAy+KDEC
         JWMl4DsNh+PV92sqqTadQrIMQRpFGQ5L+R3xEZBs5nq2FO9PmC+KLflchtDC43OQ9S2j
         CFWTaLueE3PUn/J0lPKLFjZr84cR5he+4mxYhGDDo+fsQoxk48tiUmJ/+tx1+hhfWFqw
         Jh+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=0uZuvt6hWY7FhWXwBOqHfs5cDRj/pveU7B/PnBb5g8k=;
        b=JPR4rA2Kxam98J0snDwbddwedhX/4zbpmgdiPFQtOwBHE3i8/cmrSds20U3L0Hj0/T
         ramjelNSjnRxETpih0+wqrSB2ThhILla4bVK+VHoMFg0W/yG1S51pVtPIz9+9rlFZKOB
         7wxc5erVWChM1q1gsVwPtlfsy7sqpY/U0STpB1xtnKY7mcteTtFJ6jscZ4QXeIBleiXo
         s4jxFLpJtPAAYKzN0AflqdL4NFkPmdsWPjkxTjyk6YeM7IK9fkn3Pr1uuRfAYlnJ8aYE
         BVYpXfAeNKBCz0DyIoCxycUaBgLYo7x+Zk7aAXfVQQKDd1HFF0f/SzS/s2cAjQD4xCO1
         ZUfA==
X-Gm-Message-State: AOAM531Ry7IRAsctGkAi25rk10RhUe/gZcZ/ljhxHpxQJGsOpNjXc4HE
        RrrS/+4Df0tthxRmEpvoowvh
X-Google-Smtp-Source: ABdhPJz9fNn7RLuzI4BBkfWc3bId4tN8ZJOa8tNi/4hnRHyrVfeF0Q32OlC6+6mar/EyaRffSYAMbg==
X-Received: by 2002:a63:83c6:0:b0:37c:97ad:be1e with SMTP id h189-20020a6383c6000000b0037c97adbe1emr1839532pge.82.1646388080367;
        Fri, 04 Mar 2022 02:01:20 -0800 (PST)
Received: from localhost ([139.177.225.237])
        by smtp.gmail.com with ESMTPSA id z14-20020aa7888e000000b004e5c2c0b9dcsm5450743pfe.30.2022.03.04.02.01.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Mar 2022 02:01:19 -0800 (PST)
From:   Xie Yongji <xieyongji@bytedance.com>
To:     mst@redhat.com, jasowang@redhat.com, axboe@kernel.dk,
        hch@infradead.org, mgurtovoy@nvidia.com
Cc:     virtualization@lists.linux-foundation.org,
        linux-block@vger.kernel.org
Subject: [PATCH v3 2/2] virtio-blk: Remove BUG_ON() in virtio_queue_rq()
Date:   Fri,  4 Mar 2022 18:00:58 +0800
Message-Id: <20220304100058.116-2-xieyongji@bytedance.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220304100058.116-1-xieyongji@bytedance.com>
References: <20220304100058.116-1-xieyongji@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Currently we have a BUG_ON() to make sure the number of sg
list does not exceed queue_max_segments() in virtio_queue_rq().
However, the block layer uses queue_max_discard_segments()
instead of queue_max_segments() to limit the sg list for
discard requests. So the BUG_ON() might be triggered if
virtio-blk device reports a larger value for max discard
segment than queue_max_segments(). To fix it, let's simply
remove the BUG_ON() which has become unnecessary after commit
02746e26c39e("virtio-blk: avoid preallocating big SGL for data").
And the unused vblk->sg_elems can also be removed together.

Fixes: 1f23816b8eb8 ("virtio_blk: add discard and write zeroes support")
Suggested-by: Christoph Hellwig <hch@infradead.org>
Signed-off-by: Xie Yongji <xieyongji@bytedance.com>
Reviewed-by: Max Gurtovoy <mgurtovoy@nvidia.com>
---
 drivers/block/virtio_blk.c | 12 ++----------
 1 file changed, 2 insertions(+), 10 deletions(-)

diff --git a/drivers/block/virtio_blk.c b/drivers/block/virtio_blk.c
index 7fc2c8b97077..8c415be86732 100644
--- a/drivers/block/virtio_blk.c
+++ b/drivers/block/virtio_blk.c
@@ -76,9 +76,6 @@ struct virtio_blk {
 	 */
 	refcount_t refs;
 
-	/* What host tells us, plus 2 for header & tailer. */
-	unsigned int sg_elems;
-
 	/* Ida index - used to track minor number allocations. */
 	int index;
 
@@ -322,8 +319,6 @@ static blk_status_t virtio_queue_rq(struct blk_mq_hw_ctx *hctx,
 	blk_status_t status;
 	int err;
 
-	BUG_ON(req->nr_phys_segments + 2 > vblk->sg_elems);
-
 	status = virtblk_setup_cmd(vblk->vdev, req, vbr);
 	if (unlikely(status))
 		return status;
@@ -783,8 +778,6 @@ static int virtblk_probe(struct virtio_device *vdev)
 	/* Prevent integer overflows and honor max vq size */
 	sg_elems = min_t(u32, sg_elems, VIRTIO_BLK_MAX_SG_ELEMS - 2);
 
-	/* We need extra sg elements at head and tail. */
-	sg_elems += 2;
 	vdev->priv = vblk = kmalloc(sizeof(*vblk), GFP_KERNEL);
 	if (!vblk) {
 		err = -ENOMEM;
@@ -796,7 +789,6 @@ static int virtblk_probe(struct virtio_device *vdev)
 	mutex_init(&vblk->vdev_mutex);
 
 	vblk->vdev = vdev;
-	vblk->sg_elems = sg_elems;
 
 	INIT_WORK(&vblk->config_work, virtblk_config_changed_work);
 
@@ -853,7 +845,7 @@ static int virtblk_probe(struct virtio_device *vdev)
 		set_disk_ro(vblk->disk, 1);
 
 	/* We can handle whatever the host told us to handle. */
-	blk_queue_max_segments(q, vblk->sg_elems-2);
+	blk_queue_max_segments(q, sg_elems);
 
 	/* No real sector limit. */
 	blk_queue_max_hw_sectors(q, -1U);
@@ -931,7 +923,7 @@ static int virtblk_probe(struct virtio_device *vdev)
 		 * handled it.
 		 */
 		if (!v)
-			v = sg_elems - 2;
+			v = sg_elems;
 		blk_queue_max_discard_segments(q,
 					       min(v, MAX_DISCARD_SEGMENTS));
 
-- 
2.20.1


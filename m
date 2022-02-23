Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E0C7C433F5
	for <linux-block@archiver.kernel.org>; Wed, 23 Feb 2022 13:36:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237787AbiBWNhY (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 23 Feb 2022 08:37:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231817AbiBWNhX (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 23 Feb 2022 08:37:23 -0500
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA43A369E1
        for <linux-block@vger.kernel.org>; Wed, 23 Feb 2022 05:36:55 -0800 (PST)
Received: by mail-pj1-x1029.google.com with SMTP id em10-20020a17090b014a00b001bc3071f921so2201213pjb.5
        for <linux-block@vger.kernel.org>; Wed, 23 Feb 2022 05:36:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=N9cHY4SifJQRPZGyqNzFAaMxdyKcHiU7tvyOh1en6H0=;
        b=UJiDBDcJyhYfAtRxkH4e/g0SGCcioXPblzBek5TXkQO5JhKcZgaA9ZD66eafxv7H1O
         v7ClLP7WcakqTKbRR2vewZDNHcx7f+THBx4tBUlntqunkjKZHAozZVxN+BYW4IRZhddI
         8SKnXgc+DrxlOAkLY9BpBBM8F+Dvf9MKmivTFFkFlrZ6MZ7VwWw1KtQcewrjcjh9wzOh
         1BVIQMn9FcODiPsTvcfiUyo/hdmf2RmJkJHJ4CW+p39+BIxhbBfMbkPzkzUMy1shNDA0
         NXDTQyP2WhwbTpFR8peDLGOorIg8nmt+quT9caZcI7hh3B1QccAY2k7AdM1x+Az30j8f
         RaCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=N9cHY4SifJQRPZGyqNzFAaMxdyKcHiU7tvyOh1en6H0=;
        b=KhoUndU8GkVlxuI0GlDARYurZs2TYH1f88NRlN/tg1XUUPR6DQp/wq1+5zc04z0b1B
         I+zSVwYcyyRch7lt8Qrrq+hzhLiUZRYA664gYlZiHv1COt7Ji79f2sXe6NRdslLtZTDh
         djam9arIRdAheGo6UHFqP56Wro7qqMsdDIOxdnrA9v/T2PnUN+2GnZf6D8U9ccru5JDU
         5BPG6nPlJSmVgrktoC+lMxCGIrKKAWOudlCxUdK50BFzRra1+vWA54EnD0EytBE6RFvB
         3WBPdZSYJYczAThma7sY2GG7VrBk3mNQHuIkrhTPiZEHaPooH7BuSJIWJu8HRgB/bV2J
         WHoQ==
X-Gm-Message-State: AOAM533zD9Z2QNOv4kQ3rMXyIMyDzVWSt9sjCr1EWcUS8vrofb28u93M
        lSDM92VL2tmf925bjn+eZxpA
X-Google-Smtp-Source: ABdhPJw+wPH2gByHLFqSSr47CT7uq33n0tImgzGg94Iwzm9FxJdX5AHXB7Ottaa62JyqEaiCI771tQ==
X-Received: by 2002:a17:902:7b81:b0:14f:1b7e:c83c with SMTP id w1-20020a1709027b8100b0014f1b7ec83cmr27873913pll.119.1645623415325;
        Wed, 23 Feb 2022 05:36:55 -0800 (PST)
Received: from localhost ([139.177.225.253])
        by smtp.gmail.com with ESMTPSA id p17sm21942412pfh.59.2022.02.23.05.36.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Feb 2022 05:36:54 -0800 (PST)
From:   Xie Yongji <xieyongji@bytedance.com>
To:     mst@redhat.com, jasowang@redhat.com, axboe@kernel.dk
Cc:     virtualization@lists.linux-foundation.org,
        linux-block@vger.kernel.org
Subject: [PATCH] virtio-blk: Check the max discard segment for discard request
Date:   Wed, 23 Feb 2022 21:36:27 +0800
Message-Id: <20220223133627.102-1-xieyongji@bytedance.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Currently we have a BUG_ON() to make sure the number of sg list
does not exceed queue_max_segments() in virtio_queue_rq().
However, the block layer uses queue_max_discard_segments()
instead of queue_max_segments() to limit the sg list for
discard requests. So the BUG_ON() might be triggered if
virtio-blk device reports a larger value for max discard
segment than queue_max_segments(). To fix it, this patch
checks the max discard segment for the discard request
in the BUG_ON() instead.

Fixes: 1f23816b8eb8 ("virtio_blk: add discard and write zeroes support")
Signed-off-by: Xie Yongji <xieyongji@bytedance.com>
---
 drivers/block/virtio_blk.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/drivers/block/virtio_blk.c b/drivers/block/virtio_blk.c
index c443cd64fc9b..a1f9045f848e 100644
--- a/drivers/block/virtio_blk.c
+++ b/drivers/block/virtio_blk.c
@@ -79,6 +79,9 @@ struct virtio_blk {
 	/* What host tells us, plus 2 for header & tailer. */
 	unsigned int sg_elems;
 
+	/* The max discard segment. */
+	unsigned int discard_sg_elems;
+
 	/* Ida index - used to track minor number allocations. */
 	int index;
 
@@ -321,8 +324,10 @@ static blk_status_t virtio_queue_rq(struct blk_mq_hw_ctx *hctx,
 	bool notify = false;
 	blk_status_t status;
 	int err;
+	u32 sg_elems = (req_op(req) == REQ_OP_DISCARD) ?
+				vblk->discard_sg_elems + 2 : vblk->sg_elems;
 
-	BUG_ON(req->nr_phys_segments + 2 > vblk->sg_elems);
+	BUG_ON(req->nr_phys_segments + 2 > sg_elems);
 
 	status = virtblk_setup_cmd(vblk->vdev, req, vbr);
 	if (unlikely(status))
@@ -925,9 +930,8 @@ static int virtblk_probe(struct virtio_device *vdev)
 
 		virtio_cread(vdev, struct virtio_blk_config, max_discard_seg,
 			     &v);
-		blk_queue_max_discard_segments(q,
-					       min_not_zero(v,
-							    MAX_DISCARD_SEGMENTS));
+		vblk->discard_sg_elems = min_not_zero(v, MAX_DISCARD_SEGMENTS);
+		blk_queue_max_discard_segments(q, vblk->discard_sg_elems);
 
 		blk_queue_flag_set(QUEUE_FLAG_DISCARD, q);
 	}
-- 
2.20.1


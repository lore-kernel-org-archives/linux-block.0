Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3256C433EF
	for <linux-block@archiver.kernel.org>; Mon, 28 Feb 2022 06:58:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233479AbiB1G66 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 28 Feb 2022 01:58:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232045AbiB1G65 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 28 Feb 2022 01:58:57 -0500
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C01E4B1C2
        for <linux-block@vger.kernel.org>; Sun, 27 Feb 2022 22:58:18 -0800 (PST)
Received: by mail-pf1-x42e.google.com with SMTP id p8so10248261pfh.8
        for <linux-block@vger.kernel.org>; Sun, 27 Feb 2022 22:58:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=AOsEG/swfZ0Z04TsLKSDtWYdPoi4YB2yxC4g1Jc0j3I=;
        b=w6SaC8XZyLCAyiCM7SPTWcG2QjBcT3JxtqPi1mF6kpsf7A/zU7XoBALsJLmHa5G3Wy
         vsYJ7X3gl7p6YpEFwPt7JLSNUlP3lameNMTbojJKPgqH1XhNGzxCjj1PbZZHiw6XBS73
         RHehVp9fZAThfw+HMASWjK/upM+E495Tm/UaBafiBAxW33jHQIPZBQvAgWPLnrbr5Hod
         C0xI8Hve1cLAnVbY3+ceFsaCXRmlkMt0Tu7Mu/VIayf68tO7pKett/Yc/sdWjC6aZF4k
         2xDy5k2CgwWbSW7KlgMJIFh2QBYV3Cz0wyOtgSklVN25mHnxWGNpPHM/J/VI9aAzxRqM
         sSZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=AOsEG/swfZ0Z04TsLKSDtWYdPoi4YB2yxC4g1Jc0j3I=;
        b=WxTs9MwYLjhPyMBl0P6zZElVMcmzQ/bkOXyNcdI3AYN1X08nkYxpI0QQFRrErss8o5
         k9Dl8fSILWbYD7IBrItk684u+JxYgudIA2abQPxBSsW9pBScKkvZXPr8usUXKGUQt/Dm
         ZF0Xv4JFfgoYliu6okHFGX170I30Thn4EiPpT3uETwRhKND+YSPVqMkgKMcJipNGYcb4
         8Pcpe0ASI7864XJPzLpp5IDvBCTPTAQOjGgxiYLr8AMAMv+xTxlgaKjhznEfwcOHHRoC
         2Bf7iuNiVQoPqdi4kBMp3su9xzUrZsVMbXrCQeHMggm25POn3m6tWRl8sr99idT7OKk5
         iqlw==
X-Gm-Message-State: AOAM532IOTP9GT1Ehq7VylwwFhNps5ck8g1dtJU8++RDbLi8OrIoR34n
        BNRVINwWFHquUKnBmJ2o6VqSc43fUDT9
X-Google-Smtp-Source: ABdhPJyJBZD/Qw7T1a/EtvByXy1Bq3rjOzU1OMKaFF281aDQFe4tTYQWFiS4BRMhqooQm1h8kOmUig==
X-Received: by 2002:a63:eb02:0:b0:370:41e4:6ae6 with SMTP id t2-20020a63eb02000000b0037041e46ae6mr16195969pgh.229.1646031497919;
        Sun, 27 Feb 2022 22:58:17 -0800 (PST)
Received: from localhost ([139.177.225.253])
        by smtp.gmail.com with ESMTPSA id p33-20020a056a000a2100b004dff55a7f08sm12118601pfh.21.2022.02.27.22.58.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 27 Feb 2022 22:58:17 -0800 (PST)
From:   Xie Yongji <xieyongji@bytedance.com>
To:     mst@redhat.com, jasowang@redhat.com, axboe@kernel.dk,
        hch@infradead.org
Cc:     virtualization@lists.linux-foundation.org,
        linux-block@vger.kernel.org
Subject: [PATCH v2] virtio-blk: Remove BUG_ON() in virtio_queue_rq()
Date:   Mon, 28 Feb 2022 14:57:20 +0800
Message-Id: <20220228065720.100-1-xieyongji@bytedance.com>
X-Mailer: git-send-email 2.25.1
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
---
 drivers/block/virtio_blk.c | 10 +---------
 1 file changed, 1 insertion(+), 9 deletions(-)

diff --git a/drivers/block/virtio_blk.c b/drivers/block/virtio_blk.c
index c443cd64fc9b..a43eb1813cec 100644
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
-- 
2.20.1


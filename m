Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2CF4C433EF
	for <linux-block@archiver.kernel.org>; Tue, 26 Oct 2021 14:44:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9B53F60F70
	for <linux-block@archiver.kernel.org>; Tue, 26 Oct 2021 14:44:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235176AbhJZOrC (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 26 Oct 2021 10:47:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234301AbhJZOrC (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 26 Oct 2021 10:47:02 -0400
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52B6DC061745
        for <linux-block@vger.kernel.org>; Tue, 26 Oct 2021 07:44:38 -0700 (PDT)
Received: by mail-pj1-x1033.google.com with SMTP id fv3so5113801pjb.3
        for <linux-block@vger.kernel.org>; Tue, 26 Oct 2021 07:44:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ly7k9CuyPcCQDb18QLtWsqzNg6+IbpjdsL/kryn3NgU=;
        b=WmjwgQu6+TO064uFSi79wF65OO1SboRZY8s6dhJKSzKclD/aGhQnzUa4UTTLiIl1X5
         uPhgRlGs5C2MOsBp39MdWFg8xht5zS77jLDFyB1NgeA/TJf4s6hjUKpxTP12SLgyl5h0
         SK4Eo/TbjHcqxYFfQpu8EQ3KcwFTjz6bA9Ygywn9MvkyY2eefetLo4SPbv+sSW9Cbrzp
         PrqxUedCkbE2lazOGBSmZx0LDWzYrCIFnV+7/tPbBJIZhQ57PWPd/+cjcjIev1Xj52Xn
         JVymIqVOHXG3QA/n/8F0IFflavWubesYz8yY/J0JrBGTokeCMYIjvtVFHt61xSCHA+qp
         F3CA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ly7k9CuyPcCQDb18QLtWsqzNg6+IbpjdsL/kryn3NgU=;
        b=ERIhfAH8mnjlPBwuzFVYesW4fIyq628o2ndKjJppd0Sjd/GAFbZl+w4DHIm6JKNyvr
         zJM9OGQ8nuTsPtwv6jVMdvlhfx6bjrgdWufccb0Ukxx9DrhPflvtLxIQC7jWLcF5+a8c
         sYUZrifC0ntmlCwD+x1fo1j0mQE9vd/5h3N0/GzFjMMl2Wb/cDoDwHyutREawLwiModU
         JqVHVLvaNm6j66C6xjQhMl7XAIFZG3JEnmnFoop5PukioUOogQkeJTHFfBDxUtWRweV8
         Pa29rpSxRxESbST1hmvChtpAVVkfWoHpXwLAAeKb2TisoGOEwDrrUrpEWjPo/c6vEg51
         xqVg==
X-Gm-Message-State: AOAM533Tswl4I1hFIi2wcOXkXWr9Zt46n+rfEfCXwSVQYgS0tUp5IMM0
        P6ouRQ59y7DJWptHyipC26tJ
X-Google-Smtp-Source: ABdhPJx4eVB58yN7jp+NWdqjvjbKiIEhH9j0mGRLGoM7kNZBiU5TOXPUCa7s1YYZcNDkVLBgoh7T4g==
X-Received: by 2002:a17:90a:bd0f:: with SMTP id y15mr20965938pjr.186.1635259477910;
        Tue, 26 Oct 2021 07:44:37 -0700 (PDT)
Received: from localhost ([139.177.225.237])
        by smtp.gmail.com with ESMTPSA id pc18sm1297676pjb.0.2021.10.26.07.44.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Oct 2021 07:44:36 -0700 (PDT)
From:   Xie Yongji <xieyongji@bytedance.com>
To:     axboe@kernel.dk, hch@lst.de, josef@toxicpanda.com, mst@redhat.com,
        jasowang@redhat.com, stefanha@redhat.com, kwolf@redhat.com
Cc:     linux-block@vger.kernel.org, nbd@other.debian.org,
        virtualization@lists.linux-foundation.org
Subject: [PATCH v3 4/4] virtio-blk: Use blk_validate_block_size() to validate block size
Date:   Tue, 26 Oct 2021 22:40:15 +0800
Message-Id: <20211026144015.188-5-xieyongji@bytedance.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211026144015.188-1-xieyongji@bytedance.com>
References: <20211026144015.188-1-xieyongji@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

The block layer can't support a block size larger than
page size yet. And a block size that's too small or
not a power of two won't work either. If a misconfigured
device presents an invalid block size in configuration space,
it will result in the kernel crash something like below:

[  506.154324] BUG: kernel NULL pointer dereference, address: 0000000000000008
[  506.160416] RIP: 0010:create_empty_buffers+0x24/0x100
[  506.174302] Call Trace:
[  506.174651]  create_page_buffers+0x4d/0x60
[  506.175207]  block_read_full_page+0x50/0x380
[  506.175798]  ? __mod_lruvec_page_state+0x60/0xa0
[  506.176412]  ? __add_to_page_cache_locked+0x1b2/0x390
[  506.177085]  ? blkdev_direct_IO+0x4a0/0x4a0
[  506.177644]  ? scan_shadow_nodes+0x30/0x30
[  506.178206]  ? lru_cache_add+0x42/0x60
[  506.178716]  do_read_cache_page+0x695/0x740
[  506.179278]  ? read_part_sector+0xe0/0xe0
[  506.179821]  read_part_sector+0x36/0xe0
[  506.180337]  adfspart_check_ICS+0x32/0x320
[  506.180890]  ? snprintf+0x45/0x70
[  506.181350]  ? read_part_sector+0xe0/0xe0
[  506.181906]  bdev_disk_changed+0x229/0x5c0
[  506.182483]  blkdev_get_whole+0x6d/0x90
[  506.183013]  blkdev_get_by_dev+0x122/0x2d0
[  506.183562]  device_add_disk+0x39e/0x3c0
[  506.184472]  virtblk_probe+0x3f8/0x79b [virtio_blk]
[  506.185461]  virtio_dev_probe+0x15e/0x1d0 [virtio]

So let's use a block layer helper to validate the block size.

Signed-off-by: Xie Yongji <xieyongji@bytedance.com>
---
 drivers/block/virtio_blk.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/drivers/block/virtio_blk.c b/drivers/block/virtio_blk.c
index 303caf2d17d0..fd086179f980 100644
--- a/drivers/block/virtio_blk.c
+++ b/drivers/block/virtio_blk.c
@@ -815,9 +815,17 @@ static int virtblk_probe(struct virtio_device *vdev)
 	err = virtio_cread_feature(vdev, VIRTIO_BLK_F_BLK_SIZE,
 				   struct virtio_blk_config, blk_size,
 				   &blk_size);
-	if (!err)
+	if (!err) {
+		err = blk_validate_block_size(blk_size);
+		if (err) {
+			dev_err(&vdev->dev,
+				"virtio_blk: invalid block size: 0x%x\n",
+				blk_size);
+			goto out_cleanup_disk;
+		}
+
 		blk_queue_logical_block_size(q, blk_size);
-	else
+	} else
 		blk_size = queue_logical_block_size(q);
 
 	/* Use topology information if available */
-- 
2.11.0


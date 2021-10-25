Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA6B7C433F5
	for <linux-block@archiver.kernel.org>; Mon, 25 Oct 2021 14:25:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B192460EBB
	for <linux-block@archiver.kernel.org>; Mon, 25 Oct 2021 14:25:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232487AbhJYO2A (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 25 Oct 2021 10:28:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233516AbhJYO17 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 25 Oct 2021 10:27:59 -0400
Received: from mail-pg1-x52f.google.com (mail-pg1-x52f.google.com [IPv6:2607:f8b0:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 986C0C061746
        for <linux-block@vger.kernel.org>; Mon, 25 Oct 2021 07:25:37 -0700 (PDT)
Received: by mail-pg1-x52f.google.com with SMTP id m21so11068633pgu.13
        for <linux-block@vger.kernel.org>; Mon, 25 Oct 2021 07:25:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=bVOS8C1PlcF3MnWX9/1MofpPJpttTq8LtZjRTzxXBls=;
        b=8XOvJUJcgGrqXhblePt2Grl13rd/eel4oYYwA77benHFSA3WNwrGOwico2c9Rej3VA
         jcFVkNdJTPEuGkRo/WDQFc5zr6odlJs+tHcoxOyeS7FC6R7nZ3bsIHvx32X6EliRYYhF
         GStdoXbR6bJb2sRn9nyYNn54V88qmLXKkkEdFvFkzPuBXCacFIiAmVvzcQBalVIYiJkd
         wV9hAp8GKSi2zouCDeoAyPfSpJTO6P+xHRVDYdnRBQh+PQuftzFPE0Q6uxtYjKiHHVoQ
         KoWgx5Uxm473Hofh/ew0xVUWVwh9TpNm/BiXlwf6Yh77qCNIW9nBrWvWuoLu65JX5c2F
         IIqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=bVOS8C1PlcF3MnWX9/1MofpPJpttTq8LtZjRTzxXBls=;
        b=vKso8s1wZ+71ZFi8f1gOd2+W3KfEkoMG0+K1PFD/9mZonPXbK8K7MnhI1eWeNPTxnY
         pHhdwPJblFi35NzxWuZlY1drDOgCGwLtK/CUDqy4nYO4ZvtlXdrkBnF+KGYuadY2YyO7
         +TZ7kEU+BAX8QR7+pRD9NIa9tJQdEVPmbaFr0SD93a34+8cUyZlpjohkrVIX/JfPmcKO
         l2IecIPOaVMGEcoNTQh2bpj67w2JAtdzokQvHposMM2k1ECZcQacFLQlllCMybywczTM
         /5m8npP4x7Xda15nPP6AEt49GDpIILMK/cheKqvSmzxA4te2F+yxBAAaVFTP93oVx6Sj
         9EIw==
X-Gm-Message-State: AOAM533rP06PyzPcsiNWP7WP6pFVA8qLsk3Be3/rl7iJQ2WmC24RINeT
        yHp3oa7SxNb+tCAW1yGyG+wjRuFmjtU/
X-Google-Smtp-Source: ABdhPJxZcNLBw1oMVDvUdDwq10GKr3rkb3bdkb9Emof9ZTPBsRE168CwtZquQqWL7Ha1dg0LNbrv0g==
X-Received: by 2002:a05:6a00:1901:b0:44b:e041:f07f with SMTP id y1-20020a056a00190100b0044be041f07fmr19162010pfi.52.1635171937101;
        Mon, 25 Oct 2021 07:25:37 -0700 (PDT)
Received: from localhost ([139.177.225.234])
        by smtp.gmail.com with ESMTPSA id lp9sm20678854pjb.35.2021.10.25.07.25.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Oct 2021 07:25:36 -0700 (PDT)
From:   Xie Yongji <xieyongji@bytedance.com>
To:     axboe@kernel.dk, hch@lst.de, josef@toxicpanda.com, mst@redhat.com,
        jasowang@redhat.com, stefanha@redhat.com, kwolf@redhat.com
Cc:     linux-block@vger.kernel.org, nbd@other.debian.org,
        virtualization@lists.linux-foundation.org
Subject: [PATCH v2 4/4] virtio-blk: Use blk_validate_block_size() to validate block size
Date:   Mon, 25 Oct 2021 22:25:06 +0800
Message-Id: <20211025142506.167-5-xieyongji@bytedance.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211025142506.167-1-xieyongji@bytedance.com>
References: <20211025142506.167-1-xieyongji@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

The block layer can't support the block size larger than
page size yet. If an untrusted device presents an invalid
block size in configuration space, it will result in the
kernel crash something like below:

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

So this patch tries to use the block layer helper to
validate the block size.

Signed-off-by: Xie Yongji <xieyongji@bytedance.com>
---
 drivers/block/virtio_blk.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/drivers/block/virtio_blk.c b/drivers/block/virtio_blk.c
index 303caf2d17d0..8b5833997f8e 100644
--- a/drivers/block/virtio_blk.c
+++ b/drivers/block/virtio_blk.c
@@ -815,9 +815,16 @@ static int virtblk_probe(struct virtio_device *vdev)
 	err = virtio_cread_feature(vdev, VIRTIO_BLK_F_BLK_SIZE,
 				   struct virtio_blk_config, blk_size,
 				   &blk_size);
-	if (!err)
+	if (!err) {
+		err = blk_validate_block_size(blk_size);
+		if (err) {
+			dev_err(&vdev->dev,
+				"get invalid block size: %u\n", blk_size);
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


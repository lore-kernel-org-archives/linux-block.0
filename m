Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98AEEC433EF
	for <linux-block@archiver.kernel.org>; Mon, 25 Oct 2021 09:47:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8321B603E7
	for <linux-block@archiver.kernel.org>; Mon, 25 Oct 2021 09:47:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232772AbhJYJti (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 25 Oct 2021 05:49:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232710AbhJYJtM (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 25 Oct 2021 05:49:12 -0400
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6ED10C061225
        for <linux-block@vger.kernel.org>; Mon, 25 Oct 2021 02:46:00 -0700 (PDT)
Received: by mail-pl1-x636.google.com with SMTP id e10so7524411plh.8
        for <linux-block@vger.kernel.org>; Mon, 25 Oct 2021 02:46:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=6FDAdTwuYYt8wCiGAtVPMlX4bNQlhLScXDbMVc1mVC8=;
        b=6RIpR4Rh5QPBpypEQz2ph6A+0pBreDp/sjeqKo2odId5TcnJGGNEHCD6t83jlNt50x
         O+Ugx8vFLSg8LGrDrcGitmD23jPkIAW8UfA+udTAzEyH7uGVSh9XP87QAQJTjSZ8+fp7
         xYZIth44AxIVE6WG0mvmLBwxuma25IcIHMcEvV89JlE4pZqAPMRiqcitBuMxSvkHqixY
         LlqYo2/vux74za0Pc6c6YMoiPbouNAbiObUUGmF7l7gbI3rkQd/S2HddoobZGRkki8zA
         3Zv6rVATTKhyVrtsfR9vGkg38MGaa8X3xOKdoCT7yVYxoE/JaDssVP4xepkmGXBFHrvB
         8YQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=6FDAdTwuYYt8wCiGAtVPMlX4bNQlhLScXDbMVc1mVC8=;
        b=X2JF5bYefa+ZmP/juXyR2dBfAP/DE3lfcnbaI8aQRXCNTREpgv4t/NCI7g+PYwF//B
         UcuVQ2wPN/fhqkk5RbVQfl/5trk7icOjQrqccQ7U2HqsFv7I7qpPnUxeMLTXB8/nbdwS
         NYFhT4THaAIQAJhOThJg8ZlsY+e9EiqhMmS3gNHrojp20NmTcPbF2tYzrboJjIAK+28I
         XVXfEubMFcAryPAORtga9qpnY1+51eZ+bcuiD38411WwY38Epl7U4MigHiuiQb/sZj8v
         VmTsToBeg90r9J8VhPcKKEU4MsXzyaN6a79hARrRkK+NNN34GoxwefrioalHDMIcXESM
         DWVQ==
X-Gm-Message-State: AOAM530UssidOHrAxMoh7Br+tMJ90Eae4RdELljOsoNt51Xl5WsQ2t/r
        wZ7qFMP0IhxGV8elGVTb2V5X
X-Google-Smtp-Source: ABdhPJwbVf/1Y2qaOAPyX8ExQHDle84/JcNY3WOwuGToBfYfkRq1/F9OU1B/0oaF65JIgg4Ut0SQcw==
X-Received: by 2002:a17:90a:600d:: with SMTP id y13mr19814481pji.84.1635155159975;
        Mon, 25 Oct 2021 02:45:59 -0700 (PDT)
Received: from localhost ([139.177.225.237])
        by smtp.gmail.com with ESMTPSA id pj12sm17500425pjb.19.2021.10.25.02.45.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Oct 2021 02:45:59 -0700 (PDT)
From:   Xie Yongji <xieyongji@bytedance.com>
To:     axboe@kernel.dk, hch@lst.de, josef@toxicpanda.com, mst@redhat.com,
        jasowang@redhat.com, stefanha@redhat.com, kwolf@redhat.com
Cc:     linux-block@vger.kernel.org, nbd@other.debian.org,
        virtualization@lists.linux-foundation.org
Subject: [PATCH 4/4] virtio-blk: Use blk_validate_block_size() to validate block size
Date:   Mon, 25 Oct 2021 17:43:06 +0800
Message-Id: <20211025094306.97-5-xieyongji@bytedance.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211025094306.97-1-xieyongji@bytedance.com>
References: <20211025094306.97-1-xieyongji@bytedance.com>
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
 drivers/block/virtio_blk.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/block/virtio_blk.c b/drivers/block/virtio_blk.c
index 303caf2d17d0..5bcacefe969e 100644
--- a/drivers/block/virtio_blk.c
+++ b/drivers/block/virtio_blk.c
@@ -815,9 +815,12 @@ static int virtblk_probe(struct virtio_device *vdev)
 	err = virtio_cread_feature(vdev, VIRTIO_BLK_F_BLK_SIZE,
 				   struct virtio_blk_config, blk_size,
 				   &blk_size);
-	if (!err)
+	if (!err) {
+		if (blk_validate_block_size(blk_size))
+			goto out_cleanup_disk;
+
 		blk_queue_logical_block_size(q, blk_size);
-	else
+	} else
 		blk_size = queue_logical_block_size(q);
 
 	/* Use topology information if available */
-- 
2.11.0


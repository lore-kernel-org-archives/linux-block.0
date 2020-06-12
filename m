Return-Path: <SRS0=gmaS=7Z=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97835C433DF
	for <linux-block@archiver.kernel.org>; Fri, 12 Jun 2020 07:20:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7B29A207F7
	for <linux-block@archiver.kernel.org>; Fri, 12 Jun 2020 07:20:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726339AbgFLHUM (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 12 Jun 2020 03:20:12 -0400
Received: from m17617.mail.qiye.163.com ([59.111.176.17]:50049 "EHLO
        m17617.mail.qiye.163.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726292AbgFLHUM (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 12 Jun 2020 03:20:12 -0400
X-Greylist: delayed 543 seconds by postgrey-1.27 at vger.kernel.org; Fri, 12 Jun 2020 03:20:11 EDT
Received: from vivo-HP-ProDesk-680-G4-PCI-MT.vivo.xyz (unknown [58.251.74.226])
        by m17617.mail.qiye.163.com (Hmail) with ESMTPA id 209C72618FF;
        Fri, 12 Jun 2020 15:11:06 +0800 (CST)
From:   Wang Qing <wangqing@vivo.com>
To:     "Michael S. Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Stefan Hajnoczi <stefanha@redhat.com>,
        Jens Axboe <axboe@kernel.dk>,
        virtualization@lists.linux-foundation.org,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Wang Qing <wangqing@vivo.com>
Subject: [PATCH] drivers\block: Use kobj_to_dev() API
Date:   Fri, 12 Jun 2020 15:10:56 +0800
Message-Id: <1591945856-14749-1-git-send-email-wangqing@vivo.com>
X-Mailer: git-send-email 2.7.4
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgYFAkeWUFZS1VLWVdZKFlBSE83V1ktWUFJV1kPCR
        oVCBIfWUFZS0oZQkNPGUJDSE5PVkpOQkpCT05DTU1OSk5VEwETFhoSFyQUDg9ZV1kWGg8SFR0UWU
        FZT0tIVUpKS0hKQ1VKS0tZBg++
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6MyI6PSo4EjgyLwtIFxk9TT9L
        FygwCg9VSlVKTkJKQk9OQ01MS0tNVTMWGhIXVQwaFRwKEhUcOw0SDRRVGBQWRVlXWRILWUFZTkNV
        SU5KVUxPVUlJTVlXWQgBWUFKQ0NNNwY+
X-HM-Tid: 0a72a75e2cb19375kuws209c72618ff
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Use kobj_to_dev() API instead of container_of().

Signed-off-by: Wang Qing <wangqing@vivo.com>
---
 drivers/block/virtio_blk.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)
 mode change 100644 => 100755 drivers/block/virtio_blk.c

diff --git a/drivers/block/virtio_blk.c b/drivers/block/virtio_blk.c
index 9d21bf0..c808405
--- a/drivers/block/virtio_blk.c
+++ b/drivers/block/virtio_blk.c
@@ -630,7 +630,7 @@ static struct attribute *virtblk_attrs[] = {
 static umode_t virtblk_attrs_are_visible(struct kobject *kobj,
 		struct attribute *a, int n)
 {
-	struct device *dev = container_of(kobj, struct device, kobj);
+	struct device *dev = kobj_to_dev(kobj);
 	struct gendisk *disk = dev_to_disk(dev);
 	struct virtio_blk *vblk = disk->private_data;
 	struct virtio_device *vdev = vblk->vdev;
-- 
2.7.4


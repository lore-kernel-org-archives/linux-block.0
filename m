Return-Path: <SRS0=PIBb=A2=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BCE76C433E1
	for <linux-block@archiver.kernel.org>; Wed, 15 Jul 2020 09:55:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9CD162064C
	for <linux-block@archiver.kernel.org>; Wed, 15 Jul 2020 09:55:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JME1/EPE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730929AbgGOJze (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 15 Jul 2020 05:55:34 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:58774 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725798AbgGOJze (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 15 Jul 2020 05:55:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1594806932;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=bgMe+PJv6EbNNW+M57oHn+BOmr98gpSCFa9M9x7OmkA=;
        b=JME1/EPEAn+n8K8raJ7zX7a3I3yw0ljinDAOowThUG0Ra4BFQLIJ+yJIbDdMuqqt54Sluk
        SAP0dU6L/NLU0LIk2fb0zonflUVsPrzB5OgY9ZVKS6GR0l6Qzd0MNpWaAFXixUFCAqEic1
        I87n78pgr80ocZJaDQ+gUbOWJNumEWU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-453-bKF6v7lJM_29bnIZfmmQqg-1; Wed, 15 Jul 2020 05:55:30 -0400
X-MC-Unique: bKF6v7lJM_29bnIZfmmQqg-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E05911083E83;
        Wed, 15 Jul 2020 09:55:28 +0000 (UTC)
Received: from starship.f32vm (unknown [10.35.206.178])
        by smtp.corp.redhat.com (Postfix) with ESMTP id C98EB710A0;
        Wed, 15 Jul 2020 09:55:19 +0000 (UTC)
From:   Maxim Levitsky <mlevitsk@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     Stefan Hajnoczi <stefanha@redhat.com>,
        linux-block@vger.kernel.org (open list:BLOCK LAYER),
        virtualization@lists.linux-foundation.org (open list:VIRTIO CORE AND
        NET DRIVERS), Paolo Bonzini <pbonzini@redhat.com>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>, Jens Axboe <axboe@kernel.dk>,
        Maxim Levitsky <mlevitsk@redhat.com>
Subject: [PATCH] virtio-blk: check host supplied logical block size
Date:   Wed, 15 Jul 2020 12:55:18 +0300
Message-Id: <20200715095518.3724-1-mlevitsk@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Linux kernel only supports logical block sizes which are power of two,
at least 512 bytes and no more that PAGE_SIZE.

Check this instead of crashing later on.

Note that there is no need to check physical block size since it is
only a hint, and virtio-blk already only supports power of two values.

Bugzilla link: https://bugzilla.redhat.com/show_bug.cgi?id=1664619

Signed-off-by: Maxim Levitsky <mlevitsk@redhat.com>
---
 drivers/block/virtio_blk.c | 20 ++++++++++++++++++--
 1 file changed, 18 insertions(+), 2 deletions(-)

diff --git a/drivers/block/virtio_blk.c b/drivers/block/virtio_blk.c
index 980df853ee497..36dda31cc4e96 100644
--- a/drivers/block/virtio_blk.c
+++ b/drivers/block/virtio_blk.c
@@ -681,6 +681,12 @@ static const struct blk_mq_ops virtio_mq_ops = {
 static unsigned int virtblk_queue_depth;
 module_param_named(queue_depth, virtblk_queue_depth, uint, 0444);
 
+
+static bool virtblk_valid_block_size(unsigned int blksize)
+{
+	return blksize >= 512 && blksize <= PAGE_SIZE && is_power_of_2(blksize);
+}
+
 static int virtblk_probe(struct virtio_device *vdev)
 {
 	struct virtio_blk *vblk;
@@ -809,9 +815,16 @@ static int virtblk_probe(struct virtio_device *vdev)
 	err = virtio_cread_feature(vdev, VIRTIO_BLK_F_BLK_SIZE,
 				   struct virtio_blk_config, blk_size,
 				   &blk_size);
-	if (!err)
+	if (!err) {
+		if (!virtblk_valid_block_size(blk_size)) {
+			dev_err(&vdev->dev,
+				"%s failure: unsupported logical block size %d\n",
+				__func__, blk_size);
+			err = -EINVAL;
+			goto out_cleanup_queue;
+		}
 		blk_queue_logical_block_size(q, blk_size);
-	else
+	} else
 		blk_size = queue_logical_block_size(q);
 
 	/* Use topology information if available */
@@ -872,6 +885,9 @@ static int virtblk_probe(struct virtio_device *vdev)
 	device_add_disk(&vdev->dev, vblk->disk, virtblk_attr_groups);
 	return 0;
 
+out_cleanup_queue:
+	blk_cleanup_queue(vblk->disk->queue);
+	vblk->disk->queue = NULL;
 out_free_tags:
 	blk_mq_free_tag_set(&vblk->tag_set);
 out_put_disk:
-- 
2.26.2


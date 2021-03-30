Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-26.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E512C433C1
	for <linux-block@archiver.kernel.org>; Tue, 30 Mar 2021 23:17:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DAC6D619D1
	for <linux-block@archiver.kernel.org>; Tue, 30 Mar 2021 23:16:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233046AbhC3XQX (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 30 Mar 2021 19:16:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233133AbhC3XQI (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 30 Mar 2021 19:16:08 -0400
Received: from mail-pj1-x1049.google.com (mail-pj1-x1049.google.com [IPv6:2607:f8b0:4864:20::1049])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4322C061762
        for <linux-block@vger.kernel.org>; Tue, 30 Mar 2021 16:16:07 -0700 (PDT)
Received: by mail-pj1-x1049.google.com with SMTP id gv10so40371pjb.3
        for <linux-block@vger.kernel.org>; Tue, 30 Mar 2021 16:16:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=0NQkAr5xUuyBWeb2zhIfxOf+Q+/q8yOlT371yO9KsBE=;
        b=D49BgR0Efo2giRGhHiKQHIQoOQDI6FBtWWTXLhas/Iw21fFFAIz2k5mo8V5I7/ARN+
         KM7nbiL5fnjGKs8zXXSWxdAr6oO+btPay2GwZ7u2qWZjSQM5dq9ryqXvU8W1WMIdbAWX
         /d769DmeW8FQjKjr/khi0Y8fXuVDFYoyS0CmMUvTiGfc4RBTGXel/t23SbQ/1EdvOaY4
         vXYAWEH+a2RJigf5v1dcsedTBlUXMHwNQoVGZu0ItTSUmGaxYl4xR9d1eCFDWLVrk5xK
         tnAUKvMsVsuC0dt5WxAnGqzeD6/lPuBBFxx/frlFuD7BOvNuJyMrXNqEYWothfuQFyM5
         IxvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=0NQkAr5xUuyBWeb2zhIfxOf+Q+/q8yOlT371yO9KsBE=;
        b=oZrXhiFGgit3tNvzAKkbVY3krSU/RCP7lyW6wdBE/5x6R6n5jyaJ0wFLOJaH2bO3+p
         5IJF5QlCKg8tSoiWHX1eJuUjQdJTa5JFHnYpYdkQaXLd1dij7in6UJBaMG9AIwt9ail2
         5cJ/wo5Vf5Z3xQAjJQ+Mf5KdQhgirn334htSVijrHpzsgc8TCUI06eWEeRtENR2LpVuE
         WMwlQ3Y6qC0dtEp/NxLFm65WuHK/Hs94KGJ8ErcCAEse6gRHPfEc4v6KhjY0YTtiiyoM
         kNPof2yWBw9ykUoH/lB3EZlaQtdjIGq0l8wIy9uBUXtYGQ1Au/07UtvbnzX3VcSOeKUv
         6+eQ==
X-Gm-Message-State: AOAM531WWNRiy84r2CeMHjkdurEdfkhvajGqKuJuaLk5mGIw3kE6xIAm
        P6gg4R+u1TIyw+7BNwpmpmpmgHg+vsByig==
X-Google-Smtp-Source: ABdhPJxAIZU1QeyFWMTxWweOYZcq2W4edeBZ/CU6/tS74T1Zt8XOvYu+Umy8xZL7COmuC45W0K/w+ag86Y2hYQ==
X-Received: from egcloud.c.googlers.com ([fda3:e722:ac3:10:24:72f4:c0a8:35b5])
 (user=egranata job=sendgmr) by 2002:a17:902:8303:b029:e6:4ef3:4f17 with SMTP
 id bd3-20020a1709028303b02900e64ef34f17mr400127plb.22.1617146167082; Tue, 30
 Mar 2021 16:16:07 -0700 (PDT)
Date:   Tue, 30 Mar 2021 23:16:02 +0000
Message-Id: <20210330231602.1223216-1-egranata@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.31.0.291.g576ba9dcdaf-goog
Subject: [PATCH] virtio_blk: Add support for lifetime feature
From:   Enrico Granata <egranata@google.com>
To:     mst@redhat.com, jasowang@redhat.com, pbonzini@redhat.com,
        stefanha@redhat.com, axboe@kernel.dk,
        virtualization@lists.linux-foundation.org,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     egranata@google.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

The VirtIO TC has adopted a new feature in virtio-blk enabling
discovery of lifetime information.

This commit adds support for the VIRTIO_BLK_T_LIFETIME command
to the virtio_blk driver, and adds two new attributes to the
sysfs entry for virtio_blk:
* pre_eol_info
* life_time

which are defined in the same manner as the files of the same name
for the eMMC driver, in line with the VirtIO specification.

Signed-off-by: Enrico Granata <egranata@google.com>
---
 drivers/block/virtio_blk.c      | 76 ++++++++++++++++++++++++++++++++-
 include/uapi/linux/virtio_blk.h | 11 +++++
 2 files changed, 86 insertions(+), 1 deletion(-)

diff --git a/drivers/block/virtio_blk.c b/drivers/block/virtio_blk.c
index b9fa3ef5b57c..1fc0ec000b4f 100644
--- a/drivers/block/virtio_blk.c
+++ b/drivers/block/virtio_blk.c
@@ -246,7 +246,7 @@ static blk_status_t virtio_queue_rq(struct blk_mq_hw_ctx *hctx,
 		unmap = !(req->cmd_flags & REQ_NOUNMAP);
 		break;
 	case REQ_OP_DRV_IN:
-		type = VIRTIO_BLK_T_GET_ID;
+		type = vbr->out_hdr.type;
 		break;
 	default:
 		WARN_ON_ONCE(1);
@@ -310,11 +310,14 @@ static int virtblk_get_id(struct gendisk *disk, char *id_str)
 	struct virtio_blk *vblk = disk->private_data;
 	struct request_queue *q = vblk->disk->queue;
 	struct request *req;
+	struct virtblk_req *vbreq;
 	int err;
 
 	req = blk_get_request(q, REQ_OP_DRV_IN, 0);
 	if (IS_ERR(req))
 		return PTR_ERR(req);
+	vbreq = blk_mq_rq_to_pdu(req);
+	vbreq->out_hdr.type = VIRTIO_BLK_T_GET_ID;
 
 	err = blk_rq_map_kern(q, req, id_str, VIRTIO_BLK_ID_BYTES, GFP_KERNEL);
 	if (err)
@@ -327,6 +330,34 @@ static int virtblk_get_id(struct gendisk *disk, char *id_str)
 	return err;
 }
 
+static int virtblk_get_lifetime(struct gendisk *disk, struct virtio_blk_lifetime *lifetime)
+{
+	struct virtio_blk *vblk = disk->private_data;
+	struct request_queue *q = vblk->disk->queue;
+	struct request *req;
+	struct virtblk_req *vbreq;
+	int err;
+
+	if (!virtio_has_feature(vblk->vdev, VIRTIO_BLK_F_LIFETIME))
+		return -EOPNOTSUPP;
+
+	req = blk_get_request(q, REQ_OP_DRV_IN, 0);
+	if (IS_ERR(req))
+		return PTR_ERR(req);
+	vbreq = blk_mq_rq_to_pdu(req);
+	vbreq->out_hdr.type = VIRTIO_BLK_T_GET_LIFETIME;
+
+	err = blk_rq_map_kern(q, req, lifetime, sizeof(*lifetime), GFP_KERNEL);
+	if (err)
+		goto out;
+
+	blk_execute_rq(vblk->disk, req, false);
+	err = blk_status_to_errno(virtblk_result(blk_mq_rq_to_pdu(req)));
+out:
+	blk_put_request(req);
+	return err;
+}
+
 static void virtblk_get(struct virtio_blk *vblk)
 {
 	refcount_inc(&vblk->refs);
@@ -435,6 +466,46 @@ static ssize_t serial_show(struct device *dev,
 
 static DEVICE_ATTR_RO(serial);
 
+static ssize_t pre_eol_info_show(struct device *dev,
+			   struct device_attribute *attr, char *buf)
+{
+	struct gendisk *disk = dev_to_disk(dev);
+	struct virtio_blk_lifetime lft;
+	int err;
+
+	/* sysfs gives us a PAGE_SIZE buffer */
+	BUILD_BUG_ON(sizeof(lft) >= PAGE_SIZE);
+
+	err = virtblk_get_lifetime(disk, &lft);
+	if (err)
+		return 0;
+
+	return sprintf(buf, "0x%02x\n", le16_to_cpu(lft.pre_eol_info));
+}
+
+static DEVICE_ATTR_RO(pre_eol_info);
+
+static ssize_t life_time_show(struct device *dev,
+			   struct device_attribute *attr, char *buf)
+{
+	struct gendisk *disk = dev_to_disk(dev);
+	struct virtio_blk_lifetime lft;
+	int err;
+
+	/* sysfs gives us a PAGE_SIZE buffer */
+	BUILD_BUG_ON(sizeof(lft) >= PAGE_SIZE);
+
+	err = virtblk_get_lifetime(disk, &lft);
+	if (err)
+		return 0;
+
+	return sprintf(buf, "0x%02x 0x%02x\n",
+			le16_to_cpu(lft.device_life_time_est_typ_a),
+			le16_to_cpu(lft.device_life_time_est_typ_b));
+}
+
+static DEVICE_ATTR_RO(life_time);
+
 /* The queue's logical block size must be set before calling this */
 static void virtblk_update_capacity(struct virtio_blk *vblk, bool resize)
 {
@@ -638,6 +709,8 @@ static DEVICE_ATTR_RW(cache_type);
 
 static struct attribute *virtblk_attrs[] = {
 	&dev_attr_serial.attr,
+	&dev_attr_pre_eol_info.attr,
+	&dev_attr_life_time.attr,
 	&dev_attr_cache_type.attr,
 	NULL,
 };
@@ -984,6 +1057,7 @@ static unsigned int features[] = {
 	VIRTIO_BLK_F_RO, VIRTIO_BLK_F_BLK_SIZE,
 	VIRTIO_BLK_F_FLUSH, VIRTIO_BLK_F_TOPOLOGY, VIRTIO_BLK_F_CONFIG_WCE,
 	VIRTIO_BLK_F_MQ, VIRTIO_BLK_F_DISCARD, VIRTIO_BLK_F_WRITE_ZEROES,
+	VIRTIO_BLK_F_LIFETIME,
 };
 
 static struct virtio_driver virtio_blk = {
diff --git a/include/uapi/linux/virtio_blk.h b/include/uapi/linux/virtio_blk.h
index d888f013d9ff..bbd3978b9d08 100644
--- a/include/uapi/linux/virtio_blk.h
+++ b/include/uapi/linux/virtio_blk.h
@@ -40,6 +40,7 @@
 #define VIRTIO_BLK_F_MQ		12	/* support more than one vq */
 #define VIRTIO_BLK_F_DISCARD	13	/* DISCARD is supported */
 #define VIRTIO_BLK_F_WRITE_ZEROES	14	/* WRITE ZEROES is supported */
+#define VIRTIO_BLK_F_LIFETIME	15 /* LIFETIME is supported */
 
 /* Legacy feature bits */
 #ifndef VIRTIO_BLK_NO_LEGACY
@@ -149,6 +150,9 @@ struct virtio_blk_config {
 /* Get device ID command */
 #define VIRTIO_BLK_T_GET_ID    8
 
+/* Get device lifetime command */
+#define VIRTIO_BLK_T_GET_LIFETIME 10
+
 /* Discard command */
 #define VIRTIO_BLK_T_DISCARD	11
 
@@ -196,6 +200,13 @@ struct virtio_scsi_inhdr {
 };
 #endif /* !VIRTIO_BLK_NO_LEGACY */
 
+/* Lifetime information for virtio_blk device */
+struct virtio_blk_lifetime {
+	__le16 pre_eol_info;
+	__le16 device_life_time_est_typ_a;
+	__le16 device_life_time_est_typ_b;
+};
+
 /* And this is the final byte of the write scatter-gather list. */
 #define VIRTIO_BLK_S_OK		0
 #define VIRTIO_BLK_S_IOERR	1
-- 
2.31.0.291.g576ba9dcdaf-goog


Return-Path: <SRS0=4wZT=BB=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1A9CC433E0
	for <linux-block@archiver.kernel.org>; Wed, 22 Jul 2020 10:27:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7C1EA20729
	for <linux-block@archiver.kernel.org>; Wed, 22 Jul 2020 10:27:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cloud.ionos.com header.i=@cloud.ionos.com header.b="c7FNY+Oh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730314AbgGVK1O (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 22 Jul 2020 06:27:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728599AbgGVK1O (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 22 Jul 2020 06:27:14 -0400
Received: from mail-ed1-x544.google.com (mail-ed1-x544.google.com [IPv6:2a00:1450:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 210E3C0619DC
        for <linux-block@vger.kernel.org>; Wed, 22 Jul 2020 03:27:14 -0700 (PDT)
Received: by mail-ed1-x544.google.com with SMTP id g20so1272896edm.4
        for <linux-block@vger.kernel.org>; Wed, 22 Jul 2020 03:27:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloud.ionos.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=nz67syZ3RiAjHSBtTKNKNlHBm1oAYFTmK/zvZgweu1w=;
        b=c7FNY+OhCpnVul5NEzh7cAs71kV5+R4rCEliiuNx3pe4HgxjTQze25BYPhgUyfbApx
         Uk8p8fGzEU2NhTK3Ik0RLVTQfM0XcTZ38iRmuu6MwLudJcvZzbH67HyosqiKGFkcWTNz
         aXhDVOzPoeQO3Fi7ET46aXeDRKDaQ3PDtH9hP9M2HlGtVysa/UL3Ul0fv8JGoEEc2J+l
         Z07lo21r2EZ09vfjITajjC61cxzDgIdKJzrCwDl80FWQw9nWyzHjXjEsmi1n9+hafVGy
         2ugNa5VqfkD1awJz/mhfuDppDv8aAIe3jOYO6z33pJHRMjTrbXNuQJTeYkBmcSdiO3XZ
         XvJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=nz67syZ3RiAjHSBtTKNKNlHBm1oAYFTmK/zvZgweu1w=;
        b=G/YUG7FN24pu6dLXOjRmafEX8Jr+S6aHbxxhhIQs8j71RwJAqm3hRXemYLLtZ+RjKj
         u/iyRwR8FgR+RncL4Yz2JI3TF+JeeDccHGygnmIsAGbyefrbm/ecZfkBwgw6JS2uwdLB
         EBuDrdd0+W7fR2gu4ON+j5CqcjCM+6MWJ/Dg4n2OeOaL5ErMw1+b2M3/a/ujG9IYt5n8
         4WhGUAfk7m5dK/8L7MVAeqNM0EswMbCTXlLxWwqr2/cV0KJAnUTm4xh5nbZl9+T65TLO
         gOxE/VkbxIGB/y2toGoTN6zXn/Q1F8xTT8QRtqqU/yH5tFGdJs0qj1/x4jiMcGkq9Mxh
         AGRw==
X-Gm-Message-State: AOAM533dxPLD3E+5+jzqoh7H7KXcmIBSp8tW3Xi85X/baytQ/QCjX6ON
        dFCzldbLQssLdy4kXL9e1UNmkg==
X-Google-Smtp-Source: ABdhPJzz5X4Dv8H3x5CuNmUIs9SK8f3lKFCs9j1sFTV93uEpIo3Zm8rYhjbrPUaqQFhfOiJCRI1Nfw==
X-Received: by 2002:aa7:d7d0:: with SMTP id e16mr30316418eds.10.1595413632755;
        Wed, 22 Jul 2020 03:27:12 -0700 (PDT)
Received: from ls00508.pb.local ([2001:1438:4010:2540:c136:467c:a322:7c9f])
        by smtp.gmail.com with ESMTPSA id w17sm18581044eju.42.2020.07.22.03.27.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Jul 2020 03:27:12 -0700 (PDT)
From:   Guoqing Jiang <guoqing.jiang@cloud.ionos.com>
To:     danil.kipnis@cloud.ionos.com, jinpu.wang@cloud.ionos.com,
        axboe@kernel.dk
Cc:     linux-block@vger.kernel.org,
        Guoqing Jiang <guoqing.jiang@cloud.ionos.com>
Subject: [PATCH 1/2] rnbd: remove rnbd_dev_submit_io
Date:   Wed, 22 Jul 2020 12:26:52 +0200
Message-Id: <20200722102653.19224-2-guoqing.jiang@cloud.ionos.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200722102653.19224-1-guoqing.jiang@cloud.ionos.com>
References: <20200722102653.19224-1-guoqing.jiang@cloud.ionos.com>
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

The function only has one caller, so let's open code it in process_rdma.
Another bonus is we can avoid push/pop stack, since we need to pass 8
arguments to rnbd_dev_submit_io.

Signed-off-by: Guoqing Jiang <guoqing.jiang@cloud.ionos.com>
---
 drivers/block/rnbd/rnbd-srv-dev.c | 36 +++----------------------------
 drivers/block/rnbd/rnbd-srv-dev.h | 19 +++++-----------
 drivers/block/rnbd/rnbd-srv.c     | 32 +++++++++++++++++++--------
 3 files changed, 31 insertions(+), 56 deletions(-)

diff --git a/drivers/block/rnbd/rnbd-srv-dev.c b/drivers/block/rnbd/rnbd-srv-dev.c
index 5eddfd29ab64..49c62b506c9b 100644
--- a/drivers/block/rnbd/rnbd-srv-dev.c
+++ b/drivers/block/rnbd/rnbd-srv-dev.c
@@ -45,7 +45,7 @@ void rnbd_dev_close(struct rnbd_dev *dev)
 	kfree(dev);
 }
 
-static void rnbd_dev_bi_end_io(struct bio *bio)
+void rnbd_dev_bi_end_io(struct bio *bio)
 {
 	struct rnbd_dev_blk_io *io = bio->bi_private;
 
@@ -63,8 +63,8 @@ static void rnbd_dev_bi_end_io(struct bio *bio)
  *	Map the kernel address into a bio suitable for io to a block
  *	device. Returns an error pointer in case of error.
  */
-static struct bio *rnbd_bio_map_kern(void *data, struct bio_set *bs,
-				     unsigned int len, gfp_t gfp_mask)
+struct bio *rnbd_bio_map_kern(void *data, struct bio_set *bs,
+			      unsigned int len, gfp_t gfp_mask)
 {
 	unsigned long kaddr = (unsigned long)data;
 	unsigned long end = (kaddr + len + PAGE_SIZE - 1) >> PAGE_SHIFT;
@@ -102,33 +102,3 @@ static struct bio *rnbd_bio_map_kern(void *data, struct bio_set *bs,
 	bio->bi_end_io = bio_put;
 	return bio;
 }
-
-int rnbd_dev_submit_io(struct rnbd_dev *dev, sector_t sector, void *data,
-		       size_t len, u32 bi_size, enum rnbd_io_flags flags,
-		       short prio, void *priv)
-{
-	struct rnbd_dev_blk_io *io;
-	struct bio *bio;
-
-	/* Generate bio with pages pointing to the rdma buffer */
-	bio = rnbd_bio_map_kern(data, dev->ibd_bio_set, len, GFP_KERNEL);
-	if (IS_ERR(bio))
-		return PTR_ERR(bio);
-
-	io = container_of(bio, struct rnbd_dev_blk_io, bio);
-
-	io->dev	= dev;
-	io->priv = priv;
-
-	bio->bi_end_io = rnbd_dev_bi_end_io;
-	bio->bi_private	= io;
-	bio->bi_opf = rnbd_to_bio_flags(flags);
-	bio->bi_iter.bi_sector = sector;
-	bio->bi_iter.bi_size = bi_size;
-	bio_set_prio(bio, prio);
-	bio_set_dev(bio, dev->bdev);
-
-	submit_bio(bio);
-
-	return 0;
-}
diff --git a/drivers/block/rnbd/rnbd-srv-dev.h b/drivers/block/rnbd/rnbd-srv-dev.h
index 0f65b09a270e..0eb23850afb9 100644
--- a/drivers/block/rnbd/rnbd-srv-dev.h
+++ b/drivers/block/rnbd/rnbd-srv-dev.h
@@ -41,6 +41,11 @@ void rnbd_dev_close(struct rnbd_dev *dev);
 
 void rnbd_endio(void *priv, int error);
 
+void rnbd_dev_bi_end_io(struct bio *bio);
+
+struct bio *rnbd_bio_map_kern(void *data, struct bio_set *bs,
+			      unsigned int len, gfp_t gfp_mask);
+
 static inline int rnbd_dev_get_max_segs(const struct rnbd_dev *dev)
 {
 	return queue_max_segments(bdev_get_queue(dev->bdev));
@@ -75,18 +80,4 @@ static inline int rnbd_dev_get_discard_alignment(const struct rnbd_dev *dev)
 	return bdev_get_queue(dev->bdev)->limits.discard_alignment;
 }
 
-/**
- * rnbd_dev_submit_io() - Submit an I/O to the disk
- * @dev:	device to that the I/O is submitted
- * @sector:	address to read/write data to
- * @data:	I/O data to write or buffer to read I/O date into
- * @len:	length of @data
- * @bi_size:	Amount of data that will be read/written
- * @prio:       IO priority
- * @priv:	private data passed to @io_fn
- */
-int rnbd_dev_submit_io(struct rnbd_dev *dev, sector_t sector, void *data,
-			size_t len, u32 bi_size, enum rnbd_io_flags flags,
-			short prio, void *priv);
-
 #endif /* RNBD_SRV_DEV_H */
diff --git a/drivers/block/rnbd/rnbd-srv.c b/drivers/block/rnbd/rnbd-srv.c
index 86e61523907b..0fb94843a495 100644
--- a/drivers/block/rnbd/rnbd-srv.c
+++ b/drivers/block/rnbd/rnbd-srv.c
@@ -124,6 +124,9 @@ static int process_rdma(struct rtrs_srv *sess,
 	struct rnbd_srv_sess_dev *sess_dev;
 	u32 dev_id;
 	int err;
+	struct rnbd_dev_blk_io *io;
+	struct bio *bio;
+	short prio;
 
 	priv = kmalloc(sizeof(*priv), GFP_KERNEL);
 	if (!priv)
@@ -142,18 +145,29 @@ static int process_rdma(struct rtrs_srv *sess,
 	priv->sess_dev = sess_dev;
 	priv->id = id;
 
-	err = rnbd_dev_submit_io(sess_dev->rnbd_dev, le64_to_cpu(msg->sector),
-				  data, datalen, le32_to_cpu(msg->bi_size),
-				  le32_to_cpu(msg->rw),
-				  srv_sess->ver < RNBD_PROTO_VER_MAJOR ||
-				  usrlen < sizeof(*msg) ?
-				  0 : le16_to_cpu(msg->prio), priv);
-	if (unlikely(err)) {
-		rnbd_srv_err(sess_dev, "Submitting I/O to device failed, err: %d\n",
-			      err);
+	/* Generate bio with pages pointing to the rdma buffer */
+	bio = rnbd_bio_map_kern(data, sess_dev->rnbd_dev->ibd_bio_set, datalen, GFP_KERNEL);
+	if (IS_ERR(bio)) {
+		rnbd_srv_err(sess_dev, "Failed to generate bio, err: %ld\n", PTR_ERR(bio));
 		goto sess_dev_put;
 	}
 
+	io = container_of(bio, struct rnbd_dev_blk_io, bio);
+	io->dev = sess_dev->rnbd_dev;
+	io->priv = priv;
+
+	bio->bi_end_io = rnbd_dev_bi_end_io;
+	bio->bi_private = io;
+	bio->bi_opf = rnbd_to_bio_flags(le32_to_cpu(msg->rw));
+	bio->bi_iter.bi_sector = le64_to_cpu(msg->sector);
+	bio->bi_iter.bi_size = le32_to_cpu(msg->bi_size);
+	prio = srv_sess->ver < RNBD_PROTO_VER_MAJOR ||
+	       usrlen < sizeof(*msg) ? 0 : le16_to_cpu(msg->prio);
+	bio_set_prio(bio, prio);
+	bio_set_dev(bio, sess_dev->rnbd_dev->bdev);
+
+	submit_bio(bio);
+
 	return 0;
 
 sess_dev_put:
-- 
2.17.1


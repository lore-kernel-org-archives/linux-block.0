Return-Path: <SRS0=0pY0=BJ=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5B43C433E0
	for <linux-block@archiver.kernel.org>; Thu, 30 Jul 2020 09:14:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 739DE2083B
	for <linux-block@archiver.kernel.org>; Thu, 30 Jul 2020 09:14:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cloud.ionos.com header.i=@cloud.ionos.com header.b="Mj1iL8wG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729092AbgG3JOJ (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 30 Jul 2020 05:14:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726819AbgG3JOI (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 30 Jul 2020 05:14:08 -0400
Received: from mail-ej1-x641.google.com (mail-ej1-x641.google.com [IPv6:2a00:1450:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC65FC0619D2
        for <linux-block@vger.kernel.org>; Thu, 30 Jul 2020 02:14:07 -0700 (PDT)
Received: by mail-ej1-x641.google.com with SMTP id kq25so14271888ejb.3
        for <linux-block@vger.kernel.org>; Thu, 30 Jul 2020 02:14:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloud.ionos.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=QSK5Dhqm3wONyt//Qcjvi2r8BBvTj07yWiPgkHfWvfs=;
        b=Mj1iL8wGEOnol5g9nuhFsd0afU4BI6iaGf+gK6cC65cmCTzXj1BbNjSDXYMgzuXZGQ
         9abq3V1pg/yLCFq830lO5aazIyedsktGGd+ZrF2sFdXH2zwTtCI+fnhQuyhhkUJLcYaW
         2MP8iTh0ugWroZ3pw6DZa8MrE9ICJXrtKZtg8rZCTq3TBfbEGk60VF3EH+X+p7Qj2eyr
         44Ix8cyB7X967AfW9y4yfiR/yXOwtKsJwwR5jJ/5X/Ur52OeBXKapA5QZOnQI5vtCGtX
         UWh1J/tLxJ7nwMKmGtDbE1SlQsVm2ZZVbLsnyle9dbjZVwXi3Zzvno5xzA0L76VIrLkC
         GpXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=QSK5Dhqm3wONyt//Qcjvi2r8BBvTj07yWiPgkHfWvfs=;
        b=fOCSFJEKuG2y0MEruXZM70OuEv/UDZzXG/UcvG7Hl+GFJ5lqbUQvvo1OfOWpqSUgx5
         Ys7VKmJ9mr9c+XbRZxp82LgHjPBwo/7vm47jYhCfkgl86rbxEH9daxLyakJo9Tmr4JV0
         3sOEZht9wJP7MvE03Cho0HuUFho+8OgTeO5krfLh4Ew093yj9LtWcJQLR9O2flcjJ6dK
         9+o5tHSUPjRFuDNRcIH2Zx5Qw8FyMSGblDd3QrXvnWZZjnL64fH1XqyEnedR0o1HDQRv
         oR6EGckJRu21X9C3BV6IYqoY7MU04NHz88AtQAIiAu6VjeBBVI7Owqzxhbg1+n4trlnZ
         /5rA==
X-Gm-Message-State: AOAM532A8avDAAKQMX4epP/6frpVfVzhrlR0I/pZuQPTnGKqNatRFUpr
        ohW4zGjoP0Ert/MQBuCVONRqdwOpcDSo3A==
X-Google-Smtp-Source: ABdhPJz+Bj3Ky2COF4ee98wkwk7revc6LpvRbS+0AxK9n37AgRXh0FtWKhaC7WPSAdazl291eePXsQ==
X-Received: by 2002:a17:906:7f0e:: with SMTP id d14mr1646406ejr.400.1596100446363;
        Thu, 30 Jul 2020 02:14:06 -0700 (PDT)
Received: from ls00508.pb.local ([2001:1438:4010:2540:b189:874e:eb6c:1105])
        by smtp.gmail.com with ESMTPSA id c7sm5002955ejr.77.2020.07.30.02.14.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Jul 2020 02:14:05 -0700 (PDT)
From:   Guoqing Jiang <guoqing.jiang@cloud.ionos.com>
To:     axboe@kernel.dk, danil.kipnis@cloud.ionos.com,
        jinpu.wang@cloud.ionos.com
Cc:     linux-block@vger.kernel.org,
        Guoqing Jiang <guoqing.jiang@cloud.ionos.com>
Subject: [PATCH V2 1/2] rnbd: remove rnbd_dev_submit_io
Date:   Thu, 30 Jul 2020 11:13:57 +0200
Message-Id: <20200730091358.9481-2-guoqing.jiang@cloud.ionos.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200730091358.9481-1-guoqing.jiang@cloud.ionos.com>
References: <20200730091358.9481-1-guoqing.jiang@cloud.ionos.com>
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

The function only has one caller, so let's open code it in process_rdma.
Another bonus is we can avoid push/pop stack, since we need to pass 8
arguments to rnbd_dev_submit_io.

Acked-by: Danil Kipnis <danil.kipnis@cloud.ionos.com>
Acked-by: Jack Wang <jinpu.wang@cloud.ionos.com>
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


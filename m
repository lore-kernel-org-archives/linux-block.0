Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23A7FC28D13
	for <linux-block@archiver.kernel.org>; Mon, 22 Aug 2022 06:17:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232367AbiHVGRz (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 22 Aug 2022 02:17:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229915AbiHVGRz (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 22 Aug 2022 02:17:55 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC7D627177
        for <linux-block@vger.kernel.org>; Sun, 21 Aug 2022 23:17:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=JzSZG+j0mwpX5hBBQfoksUzGk9JGSaK1cslQzLrRrYs=; b=ceQ7NX+xIiSMQ7rK7HYh6Huyyu
        cVQM6/vJZBAamXzSdMZxHSLo4sLZwlvPy7gYCs5Rq7WiQiKledzsr3+JwTLkeqCBXiTt6CyTxiaR+
        OhQ0AqEyXJf8h2zUw7mv/NSrMt59LXT6k9ADJdRVVzIgyVl/jqEXh0Duh814dN0niU3NTjueayVmD
        5ljZ8Xdhl8j/6HWeUkEVQbL+Lt9cbUkq9PhaJXZKcg/bcn5wI77NBArzDkVGVqcuJnM3RdCmEoCj2
        S6OWYzeJP+EoDleFJm50VBJvTWwm2ihRKuVIvCEB38V4O2vo+Q/Kc/g49IGta5mlnQWXwMBHSoPV+
        woSHotgg==;
Received: from [2001:4bb8:198:6528:7eb3:3a42:932d:eeba] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1oQ0ky-005MAV-8Q; Mon, 22 Aug 2022 06:17:52 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     "Md. Haris Iqbal" <haris.iqbal@ionos.com>,
        Jack Wang <jinpu.wang@ionos.com>, Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org
Subject: [PATCH 2/4] rnbd-srv: remove rnbd_endio
Date:   Mon, 22 Aug 2022 08:17:43 +0200
Message-Id: <20220822061745.152010-3-hch@lst.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220822061745.152010-1-hch@lst.de>
References: <20220822061745.152010-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Fold rnbd_endio into the only caller.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/block/rnbd/rnbd-srv-dev.h |  2 --
 drivers/block/rnbd/rnbd-srv.c     | 20 +++++++-------------
 2 files changed, 7 insertions(+), 15 deletions(-)

diff --git a/drivers/block/rnbd/rnbd-srv-dev.h b/drivers/block/rnbd/rnbd-srv-dev.h
index 8eeb3d607e7b5..328dc915832cd 100644
--- a/drivers/block/rnbd/rnbd-srv-dev.h
+++ b/drivers/block/rnbd/rnbd-srv-dev.h
@@ -29,6 +29,4 @@ struct rnbd_dev *rnbd_dev_open(const char *path, fmode_t flags);
  */
 void rnbd_dev_close(struct rnbd_dev *dev);
 
-void rnbd_endio(void *priv, int error);
-
 #endif /* RNBD_SRV_DEV_H */
diff --git a/drivers/block/rnbd/rnbd-srv.c b/drivers/block/rnbd/rnbd-srv.c
index db1fe73998703..8303de61e8094 100644
--- a/drivers/block/rnbd/rnbd-srv.c
+++ b/drivers/block/rnbd/rnbd-srv.c
@@ -85,18 +85,6 @@ static inline void rnbd_put_sess_dev(struct rnbd_srv_sess_dev *sess_dev)
 	kref_put(&sess_dev->kref, rnbd_sess_dev_release);
 }
 
-void rnbd_endio(void *priv, int error)
-{
-	struct rnbd_io_private *rnbd_priv = priv;
-	struct rnbd_srv_sess_dev *sess_dev = rnbd_priv->sess_dev;
-
-	rnbd_put_sess_dev(sess_dev);
-
-	rtrs_srv_resp_rdma(rnbd_priv->id, error);
-
-	kfree(priv);
-}
-
 static struct rnbd_srv_sess_dev *
 rnbd_get_sess_dev(int dev_id, struct rnbd_srv_session *srv_sess)
 {
@@ -117,7 +105,13 @@ rnbd_get_sess_dev(int dev_id, struct rnbd_srv_session *srv_sess)
 
 static void rnbd_dev_bi_end_io(struct bio *bio)
 {
-	rnbd_endio(bio->bi_private, blk_status_to_errno(bio->bi_status));
+	struct rnbd_io_private *rnbd_priv = bio->bi_private;
+	struct rnbd_srv_sess_dev *sess_dev = rnbd_priv->sess_dev;
+
+	rnbd_put_sess_dev(sess_dev);
+	rtrs_srv_resp_rdma(rnbd_priv->id, blk_status_to_errno(bio->bi_status));
+
+	kfree(rnbd_priv);
 	bio_put(bio);
 }
 
-- 
2.30.2


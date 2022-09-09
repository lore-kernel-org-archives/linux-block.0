Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD4A4ECAAD3
	for <linux-block@archiver.kernel.org>; Fri,  9 Sep 2022 13:15:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229810AbiIINP2 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 9 Sep 2022 09:15:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230208AbiIINP1 (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Fri, 9 Sep 2022 09:15:27 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44AE75AA2E
        for <linux-block@vger.kernel.org>; Fri,  9 Sep 2022 06:15:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=/n8R35+h/0m9rUOMrwkgDaPIiNqrQ+WMKBFLBcqMKJA=; b=MxkNbo2Y+p2/1I9E2kMR0glDu/
        u8wNy7opETzqyrypO84Qi/cA8h7JmNEAjc2QVfG4eUPjwyDSAikb2z5CLOUTS/q3iOncPn/2VeVIS
        zzU0TvoySweVnqsDiaqQktBAlQz70hr6h8stWm6LJG4ExI9o8hv8vVkug+v+UPi1Ef/KblANKhCVV
        bhML8M/9UACO/TlAlva5q/BYw6zRbIwZdsXg0baCLcVq5O4+NJ7tnxlyQk4C7Vtk88gF2d+ePefft
        DxSU0xuByyVOK1yD3swNhMTrA6+jumjQww+eDzIyREXNTtD6r7510+MEbEKiIjL87H7upCmh+tPR2
        U1sYzpsg==;
Received: from [2001:4bb8:198:38af:a077:6a38:dc23:be2c] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1oWdqu-00GGv7-KY; Fri, 09 Sep 2022 13:15:25 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     "Md. Haris Iqbal" <haris.iqbal@ionos.com>,
        Jack Wang <jinpu.wang@ionos.com>, Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Chaitanya Kulkarni <kch@nvidia.com>
Subject: [PATCH 3/4] rnbd-srv: remove rnbd_dev_{open,close}
Date:   Fri,  9 Sep 2022 15:15:08 +0200
Message-Id: <20220909131509.3263924-4-hch@lst.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220909131509.3263924-1-hch@lst.de>
References: <20220909131509.3263924-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

These can be trivially open coded in the callers.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Chaitanya Kulkarni <kch@nvidia.com>
Acked-by: Jack Wang <jinpu.wang@ionos.com>
---
 drivers/block/rnbd/Makefile       |  1 -
 drivers/block/rnbd/rnbd-srv-dev.c | 42 -------------------------------
 drivers/block/rnbd/rnbd-srv-dev.h | 12 ---------
 drivers/block/rnbd/rnbd-srv.c     | 25 ++++++++++++------
 4 files changed, 18 insertions(+), 62 deletions(-)
 delete mode 100644 drivers/block/rnbd/rnbd-srv-dev.c

diff --git a/drivers/block/rnbd/Makefile b/drivers/block/rnbd/Makefile
index 5fc05e6679503..40b31630822ce 100644
--- a/drivers/block/rnbd/Makefile
+++ b/drivers/block/rnbd/Makefile
@@ -10,7 +10,6 @@ CFLAGS_rnbd-srv-trace.o = -I$(src)
 
 rnbd-server-y := rnbd-common.o \
 		  rnbd-srv.o \
-		  rnbd-srv-dev.o \
 		  rnbd-srv-sysfs.o \
 		  rnbd-srv-trace.o
 
diff --git a/drivers/block/rnbd/rnbd-srv-dev.c b/drivers/block/rnbd/rnbd-srv-dev.c
deleted file mode 100644
index 38131fa5718d3..0000000000000
--- a/drivers/block/rnbd/rnbd-srv-dev.c
+++ /dev/null
@@ -1,42 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0-or-later
-/*
- * RDMA Network Block Driver
- *
- * Copyright (c) 2014 - 2018 ProfitBricks GmbH. All rights reserved.
- * Copyright (c) 2018 - 2019 1&1 IONOS Cloud GmbH. All rights reserved.
- * Copyright (c) 2019 - 2020 1&1 IONOS SE. All rights reserved.
- */
-#undef pr_fmt
-#define pr_fmt(fmt) KBUILD_MODNAME " L" __stringify(__LINE__) ": " fmt
-
-#include "rnbd-srv-dev.h"
-#include "rnbd-log.h"
-
-struct rnbd_dev *rnbd_dev_open(const char *path, fmode_t flags)
-{
-	struct rnbd_dev *dev;
-	int ret;
-
-	dev = kzalloc(sizeof(*dev), GFP_KERNEL);
-	if (!dev)
-		return ERR_PTR(-ENOMEM);
-
-	dev->bdev = blkdev_get_by_path(path, flags, THIS_MODULE);
-	ret = PTR_ERR_OR_ZERO(dev->bdev);
-	if (ret)
-		goto err;
-
-	dev->blk_open_flags = flags;
-
-	return dev;
-
-err:
-	kfree(dev);
-	return ERR_PTR(ret);
-}
-
-void rnbd_dev_close(struct rnbd_dev *dev)
-{
-	blkdev_put(dev->bdev, dev->blk_open_flags);
-	kfree(dev);
-}
diff --git a/drivers/block/rnbd/rnbd-srv-dev.h b/drivers/block/rnbd/rnbd-srv-dev.h
index 328dc915832cd..abaf77d68e5b9 100644
--- a/drivers/block/rnbd/rnbd-srv-dev.h
+++ b/drivers/block/rnbd/rnbd-srv-dev.h
@@ -17,16 +17,4 @@ struct rnbd_dev {
 	fmode_t			blk_open_flags;
 };
 
-/**
- * rnbd_dev_open() - Open a device
- * @path:	path to open
- * @flags:	open flags
- */
-struct rnbd_dev *rnbd_dev_open(const char *path, fmode_t flags);
-
-/**
- * rnbd_dev_close() - Close a device
- */
-void rnbd_dev_close(struct rnbd_dev *dev);
-
 #endif /* RNBD_SRV_DEV_H */
diff --git a/drivers/block/rnbd/rnbd-srv.c b/drivers/block/rnbd/rnbd-srv.c
index d487281a37f85..e9c8a722d9c5c 100644
--- a/drivers/block/rnbd/rnbd-srv.c
+++ b/drivers/block/rnbd/rnbd-srv.c
@@ -220,7 +220,9 @@ void rnbd_destroy_sess_dev(struct rnbd_srv_sess_dev *sess_dev, bool keep_id)
 	rnbd_put_sess_dev(sess_dev);
 	wait_for_completion(&dc); /* wait for inflights to drop to zero */
 
-	rnbd_dev_close(sess_dev->rnbd_dev);
+	blkdev_put(sess_dev->rnbd_dev->bdev,
+		   sess_dev->rnbd_dev->blk_open_flags);
+	kfree(sess_dev->rnbd_dev);
 	mutex_lock(&sess_dev->dev->lock);
 	list_del(&sess_dev->dev_list);
 	if (sess_dev->open_flags & FMODE_WRITE)
@@ -721,11 +723,19 @@ static int process_msg_open(struct rnbd_srv_session *srv_sess,
 		goto reject;
 	}
 
-	rnbd_dev = rnbd_dev_open(full_path, open_flags);
-	if (IS_ERR(rnbd_dev)) {
-		pr_err("Opening device '%s' on session %s failed, failed to open the block device, err: %ld\n",
-		       full_path, srv_sess->sessname, PTR_ERR(rnbd_dev));
-		ret = PTR_ERR(rnbd_dev);
+	rnbd_dev = kzalloc(sizeof(*rnbd_dev), GFP_KERNEL);
+	if (!rnbd_dev) {
+		ret = -ENOMEM;
+		goto free_path;
+	}
+
+	rnbd_dev->blk_open_flags = open_flags;
+	rnbd_dev->bdev = blkdev_get_by_path(full_path, open_flags, THIS_MODULE);
+	if (IS_ERR(rnbd_dev->bdev)) {
+		ret = PTR_ERR(rnbd_dev->bdev);
+		pr_err("Opening device '%s' on session %s failed, failed to open the block device, err: %d\n",
+		       full_path, srv_sess->sessname, ret);
+		kfree(rnbd_dev);
 		goto free_path;
 	}
 
@@ -797,7 +807,8 @@ static int process_msg_open(struct rnbd_srv_session *srv_sess,
 	}
 	rnbd_put_srv_dev(srv_dev);
 rnbd_dev_close:
-	rnbd_dev_close(rnbd_dev);
+	blkdev_put(rnbd_dev->bdev, rnbd_dev->blk_open_flags);
+	kfree(rnbd_dev);
 free_path:
 	kfree(full_path);
 reject:
-- 
2.30.2


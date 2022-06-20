Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62D53CCA479
	for <linux-block@archiver.kernel.org>; Mon, 20 Jun 2022 03:50:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230371AbiFTDuC (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sun, 19 Jun 2022 23:50:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237556AbiFTDt6 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sun, 19 Jun 2022 23:49:58 -0400
Received: from out0.migadu.com (out0.migadu.com [IPv6:2001:41d0:2:267::])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7CB4BC96
        for <linux-block@vger.kernel.org>; Sun, 19 Jun 2022 20:49:57 -0700 (PDT)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1655696996;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=8WXRkBUMxn4NvWb9R5LyFDK7DOJM/KrWEHZFKLLVzoU=;
        b=l9dnntr5ZtsM7NBIsUMICOe4G4E2lmgs6m34VpuLOGAiSKtG6WABV9PtY+obiGFjSQszjs
        G523qXhCOO77z7Wrv5w83NqeXDddMFDDnivMpJ6ZUHfX365tVs9eE7TyhQJ/vqgVvh2sjg
        qi9w3WXiyUx3fYyngzWWKc06ggb/nLk=
From:   Guoqing Jiang <guoqing.jiang@linux.dev>
To:     haris.iqbal@ionos.com, jinpu.wang@ionos.com, axboe@kernel.dk
Cc:     linux-block@vger.kernel.org
Subject: [RFC PATCH 1/6] rnbd-clt: open code send_msg_open in rnbd_clt_map_device
Date:   Mon, 20 Jun 2022 11:49:18 +0800
Message-Id: <20220620034923.35633-2-guoqing.jiang@linux.dev>
In-Reply-To: <20220620034923.35633-1-guoqing.jiang@linux.dev>
References: <20220620034923.35633-1-guoqing.jiang@linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Migadu-Auth-User: linux.dev
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Let's open code it in rnbd_clt_map_device, then we can use information
from rsp to setup gendisk and request_queue in next commits. After that,
we can remove some members (wc, fua and max_hw_sectors etc) from struct
rnbd_clt_dev.

Signed-off-by: Guoqing Jiang <guoqing.jiang@linux.dev>
---
 drivers/block/rnbd/rnbd-clt.c | 44 +++++++++++++++++++++++++++++++++--
 1 file changed, 42 insertions(+), 2 deletions(-)

diff --git a/drivers/block/rnbd/rnbd-clt.c b/drivers/block/rnbd/rnbd-clt.c
index 409c76b81aed..0396532da742 100644
--- a/drivers/block/rnbd/rnbd-clt.c
+++ b/drivers/block/rnbd/rnbd-clt.c
@@ -1562,7 +1562,14 @@ struct rnbd_clt_dev *rnbd_clt_map_device(const char *sessname,
 {
 	struct rnbd_clt_session *sess;
 	struct rnbd_clt_dev *dev;
-	int ret;
+	int ret, errno;
+	struct rnbd_msg_open_rsp *rsp;
+	struct rnbd_msg_open msg;
+	struct rnbd_iu *iu;
+	struct kvec vec = {
+		.iov_base = &msg,
+		.iov_len  = sizeof(msg)
+	};
 
 	if (exists_devpath(pathname, sessname))
 		return ERR_PTR(-EEXIST);
@@ -1582,13 +1589,46 @@ struct rnbd_clt_dev *rnbd_clt_map_device(const char *sessname,
 		ret = -EEXIST;
 		goto put_dev;
 	}
-	ret = send_msg_open(dev, RTRS_PERMIT_WAIT);
+
+	rsp = kzalloc(sizeof(*rsp), GFP_KERNEL);
+	if (!rsp) {
+		ret = -ENOMEM;
+		goto del_dev;
+	}
+
+	iu = rnbd_get_iu(sess, RTRS_ADMIN_CON, RTRS_PERMIT_WAIT);
+	if (!iu) {
+		ret = -ENOMEM;
+		kfree(rsp);
+		goto del_dev;
+	}
+	iu->buf = rsp;
+	iu->dev = dev;
+	sg_init_one(iu->sgt.sgl, rsp, sizeof(*rsp));
+
+	msg.hdr.type    = cpu_to_le16(RNBD_MSG_OPEN);
+	msg.access_mode = dev->access_mode;
+	strscpy(msg.dev_name, dev->pathname, sizeof(msg.dev_name));
+
+	WARN_ON(!rnbd_clt_get_dev(dev));
+	ret = send_usr_msg(sess->rtrs, READ, iu,
+			   &vec, sizeof(*rsp), iu->sgt.sgl, 1,
+			   msg_open_conf, &errno, RTRS_PERMIT_WAIT);
+	if (ret) {
+		rnbd_clt_put_dev(dev);
+		rnbd_put_iu(sess, iu);
+		kfree(rsp);
+	} else {
+		ret = errno;
+	}
+	rnbd_put_iu(sess, iu);
 	if (ret) {
 		rnbd_clt_err(dev,
 			      "map_device: failed, can't open remote device, err: %d\n",
 			      ret);
 		goto del_dev;
 	}
+
 	mutex_lock(&dev->lock);
 	pr_debug("Opened remote device: session=%s, path='%s'\n",
 		 sess->sessname, pathname);
-- 
2.34.1


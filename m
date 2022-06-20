Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC0B7CCA47F
	for <linux-block@archiver.kernel.org>; Mon, 20 Jun 2022 03:50:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236756AbiFTDuE (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sun, 19 Jun 2022 23:50:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235340AbiFTDuC (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sun, 19 Jun 2022 23:50:02 -0400
Received: from out0.migadu.com (out0.migadu.com [94.23.1.103])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E138F60D5
        for <linux-block@vger.kernel.org>; Sun, 19 Jun 2022 20:50:00 -0700 (PDT)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1655696999;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=RWmYnDrRLqVJTkQC7LBfd8tiq+Z9vJSw5aaDNNMl/ZI=;
        b=iLchuBbt8rsfHun+cbWGHkf+60PKMKaEOVgHXa4RtLPDKo3cTExAy6aGKaAWFXeNsQ90Dr
        vLdw2fd4ue0fCXx8otai+CU7+rv74CswYIhgOHBAg4Ani8eB3dg2QLgj9U5Ql1v3KhDh2P
        YSuHl1Ji4/4+K0mQvP3uBiN5US7DrFg=
From:   Guoqing Jiang <guoqing.jiang@linux.dev>
To:     haris.iqbal@ionos.com, jinpu.wang@ionos.com, axboe@kernel.dk
Cc:     linux-block@vger.kernel.org
Subject: [RFC PATCH 2/6] rnbd-clt: don't free rsp in msg_open_conf for map scenario
Date:   Mon, 20 Jun 2022 11:49:19 +0800
Message-Id: <20220620034923.35633-3-guoqing.jiang@linux.dev>
In-Reply-To: <20220620034923.35633-1-guoqing.jiang@linux.dev>
References: <20220620034923.35633-1-guoqing.jiang@linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Migadu-Auth-User: linux.dev
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

For map scenario, rsp is freed in two places:

1. msg_open_conf frees rsp if rtrs_clt_request returns 0.

2. Otherwise, rsp is freed by the call sites of rtrs_clt_request.

Now, We'd like to control full lifecycle of rsp in rnbd_clt_map_device,
with that, it is feasible to pass rsp to rnbd_client_setup_device in
next commit.

For 1, it is possible to free rsp from the caller of send_usr_msg
because of the synchronization of iu->comp.wait. And we put iu later
in rnbd_clt_map_device to ensure order of release rsp and iu.

Signed-off-by: Guoqing Jiang <guoqing.jiang@linux.dev>
---
 drivers/block/rnbd/rnbd-clt.c | 18 ++++++++++++++----
 1 file changed, 14 insertions(+), 4 deletions(-)

diff --git a/drivers/block/rnbd/rnbd-clt.c b/drivers/block/rnbd/rnbd-clt.c
index 0396532da742..6c4970878d23 100644
--- a/drivers/block/rnbd/rnbd-clt.c
+++ b/drivers/block/rnbd/rnbd-clt.c
@@ -507,6 +507,11 @@ static void msg_open_conf(struct work_struct *work)
 	struct rnbd_msg_open_rsp *rsp = iu->buf;
 	struct rnbd_clt_dev *dev = iu->dev;
 	int errno = iu->errno;
+	bool from_map = false;
+
+	/* INIT state is only triggered from rnbd_clt_map_device */
+	if (dev->dev_state == DEV_STATE_INIT)
+		from_map = true;
 
 	if (errno) {
 		rnbd_clt_err(dev,
@@ -523,7 +528,9 @@ static void msg_open_conf(struct work_struct *work)
 			send_msg_close(dev, device_id, RTRS_PERMIT_NOWAIT);
 		}
 	}
-	kfree(rsp);
+	/* We free rsp in rnbd_clt_map_device for map scenario */
+	if (!from_map)
+		kfree(rsp);
 	wake_up_iu_comp(iu, errno);
 	rnbd_put_iu(dev->sess, iu);
 	rnbd_clt_put_dev(dev);
@@ -1617,16 +1624,14 @@ struct rnbd_clt_dev *rnbd_clt_map_device(const char *sessname,
 	if (ret) {
 		rnbd_clt_put_dev(dev);
 		rnbd_put_iu(sess, iu);
-		kfree(rsp);
 	} else {
 		ret = errno;
 	}
-	rnbd_put_iu(sess, iu);
 	if (ret) {
 		rnbd_clt_err(dev,
 			      "map_device: failed, can't open remote device, err: %d\n",
 			      ret);
-		goto del_dev;
+		goto put_iu;
 	}
 
 	mutex_lock(&dev->lock);
@@ -1651,12 +1656,17 @@ struct rnbd_clt_dev *rnbd_clt_map_device(const char *sessname,
 		       dev->max_hw_sectors, dev->wc, dev->fua);
 
 	mutex_unlock(&dev->lock);
+	kfree(rsp);
+	rnbd_put_iu(sess, iu);
 	rnbd_clt_put_sess(sess);
 
 	return dev;
 
 send_close:
 	send_msg_close(dev, dev->device_id, RTRS_PERMIT_WAIT);
+put_iu:
+	kfree(rsp);
+	rnbd_put_iu(sess, iu);
 del_dev:
 	delete_dev(dev);
 put_dev:
-- 
2.34.1


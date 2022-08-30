Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46AE7ECAAA1
	for <linux-block@archiver.kernel.org>; Tue, 30 Aug 2022 12:39:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229530AbiH3Mj5 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 30 Aug 2022 08:39:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229773AbiH3Mjs (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 30 Aug 2022 08:39:48 -0400
Received: from out0.migadu.com (out0.migadu.com [94.23.1.103])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B91CB12F566
        for <linux-block@vger.kernel.org>; Tue, 30 Aug 2022 05:39:37 -0700 (PDT)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1661863175;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=1uABKaL7W78FC9Mz+iS0yPDmNTix2+XHt/nypCOiyDA=;
        b=EnpHq85q8fkHCruCSoxcBaO2kmABzivzjtDQVH00poTGy9O0zCa+OfA+SgcuJSP6sEH8fX
        +ZjNevDCZjcOGA4lJy8X73+9irUc8iTkKgyYko1VN2LSQd0oK1m94GjCiCZHP+TFVe5yT5
        DBByRvSBOoT+2TbLgjF+h1djygTTS2c=
From:   Guoqing Jiang <guoqing.jiang@linux.dev>
To:     haris.iqbal@ionos.com, jinpu.wang@ionos.com, axboe@kernel.dk
Cc:     linux-block@vger.kernel.org
Subject: [PATCH 2/3] rnbd-srv: make process_msg_close returns void
Date:   Tue, 30 Aug 2022 20:39:03 +0800
Message-Id: <20220830123904.26671-3-guoqing.jiang@linux.dev>
In-Reply-To: <20220830123904.26671-1-guoqing.jiang@linux.dev>
References: <20220830123904.26671-1-guoqing.jiang@linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Migadu-Auth-User: linux.dev
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Change the return type to void given it always returns 0.

Signed-off-by: Guoqing Jiang <guoqing.jiang@linux.dev>
---
process_msg_sess_info also returns 0, to avoid conflict with rdma tree,
will send it in next merge window.

 drivers/block/rnbd/rnbd-srv.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/block/rnbd/rnbd-srv.c b/drivers/block/rnbd/rnbd-srv.c
index 9182d45cb9be..026681a70c46 100644
--- a/drivers/block/rnbd/rnbd-srv.c
+++ b/drivers/block/rnbd/rnbd-srv.c
@@ -339,7 +339,7 @@ void rnbd_srv_sess_dev_force_close(struct rnbd_srv_sess_dev *sess_dev,
 	mutex_unlock(&sess->lock);
 }
 
-static int process_msg_close(struct rnbd_srv_session *srv_sess,
+static void process_msg_close(struct rnbd_srv_session *srv_sess,
 			     void *data, size_t datalen, const void *usr,
 			     size_t usrlen)
 {
@@ -351,13 +351,12 @@ static int process_msg_close(struct rnbd_srv_session *srv_sess,
 	sess_dev = rnbd_get_sess_dev(le32_to_cpu(close_msg->device_id),
 				      srv_sess);
 	if (IS_ERR(sess_dev))
-		return 0;
+		return;
 
 	rnbd_put_sess_dev(sess_dev);
 	mutex_lock(&srv_sess->lock);
 	rnbd_srv_destroy_dev_session_sysfs(sess_dev);
 	mutex_unlock(&srv_sess->lock);
-	return 0;
 }
 
 static int process_msg_open(struct rnbd_srv_session *srv_sess,
@@ -387,7 +386,7 @@ static int rnbd_srv_rdma_ev(void *priv,
 	case RNBD_MSG_IO:
 		return process_rdma(srv_sess, id, data, datalen, usr, usrlen);
 	case RNBD_MSG_CLOSE:
-		ret = process_msg_close(srv_sess, data, datalen, usr, usrlen);
+		process_msg_close(srv_sess, data, datalen, usr, usrlen);
 		break;
 	case RNBD_MSG_OPEN:
 		ret = process_msg_open(srv_sess, usr, usrlen, data, datalen);
-- 
2.34.1


Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8E7DC6FA83
	for <linux-block@archiver.kernel.org>; Fri,  2 Sep 2022 10:01:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235753AbiIBKBR (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 2 Sep 2022 06:01:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235786AbiIBKBO (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Fri, 2 Sep 2022 06:01:14 -0400
Received: from out0.migadu.com (out0.migadu.com [IPv6:2001:41d0:2:267::])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E55BC857E6
        for <linux-block@vger.kernel.org>; Fri,  2 Sep 2022 03:01:05 -0700 (PDT)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1662112864;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Ryc23aBP6jaM8QX0YaocyAt9qya4INPwIJEUNguUjMQ=;
        b=iCJOaaySpU+Ri/nvOy+m8L1+yuMlS+/lnv5RAuhE8FFIgN6thJaOm6sxwXM+gYZX7wMJeD
        ItJFHb85SD2OuaTwdqKXdVDsBNtnTHfA7TgWWoI5hYFySFS8lc0GGUBxtqMPzJA7lN6Sk1
        ba3SoCQs9/cZblpYr7tROolvz8zj0eE=
From:   Guoqing Jiang <guoqing.jiang@linux.dev>
To:     haris.iqbal@ionos.com, jinpu.wang@ionos.com, axboe@kernel.dk
Cc:     linux-block@vger.kernel.org
Subject: [PATCH V2 2/3] rnbd-srv: make process_msg_close returns void
Date:   Fri,  2 Sep 2022 18:00:54 +0800
Message-Id: <20220902100055.25724-3-guoqing.jiang@linux.dev>
In-Reply-To: <20220902100055.25724-1-guoqing.jiang@linux.dev>
References: <20220902100055.25724-1-guoqing.jiang@linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Migadu-Auth-User: linux.dev
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Change the return type to void given it always returns 0.

Signed-off-by: Guoqing Jiang <guoqing.jiang@linux.dev>
Reviewed-by: Chaitanya Kulkarni <kch@nvidia.com>
Acked-by: Md Haris Iqbal <haris.iqbal@ionos.com>
---
 drivers/block/rnbd/rnbd-srv.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/block/rnbd/rnbd-srv.c b/drivers/block/rnbd/rnbd-srv.c
index a229dd87c322..8d011652a15c 100644
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
2.31.1


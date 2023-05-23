Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF813C7EE26
	for <linux-block@archiver.kernel.org>; Tue, 23 May 2023 07:55:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235013AbjEWHzl (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 23 May 2023 03:55:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235830AbjEWHyl (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 23 May 2023 03:54:41 -0400
Received: from out-26.mta0.migadu.com (out-26.mta0.migadu.com [IPv6:2001:41d0:1004:224b::1a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BFB5EE58
        for <linux-block@vger.kernel.org>; Tue, 23 May 2023 00:54:21 -0700 (PDT)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1684828424;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ZtyhHhDeMl2j5sMHk2TsBPm6jleixtsEtDUypy+r+NY=;
        b=kArJwAxXky4x2dDZOkplmDtsdGgOJoJsTIVWmEddMKkDx4qnFuprFI9cGFneZpMiYAkwbY
        HSSz6elttFd7UPJGcLgDOnFmOLjDc/nM+KpoJeHHsMCksyvhBeGlZ2TpzQtlR7ygZNg0aj
        PlOeN3PPkh6vqyuqlyU9DbST1vQ9oI4=
From:   Guoqing Jiang <guoqing.jiang@linux.dev>
To:     haris.iqbal@ionos.com, jinpu.wang@ionos.com, axboe@kernel.dk
Cc:     linux-block@vger.kernel.org
Subject: [PATCH 05/10] block/rnbd-srv: defer the allocation of rnbd_io_private
Date:   Tue, 23 May 2023 15:53:26 +0800
Message-Id: <20230523075331.32250-6-guoqing.jiang@linux.dev>
In-Reply-To: <20230523075331.32250-1-guoqing.jiang@linux.dev>
References: <20230523075331.32250-1-guoqing.jiang@linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Only allocate priv after session is available.

Signed-off-by: Guoqing Jiang <guoqing.jiang@linux.dev>
---
 drivers/block/rnbd/rnbd-srv.c | 12 ++++--------
 1 file changed, 4 insertions(+), 8 deletions(-)

diff --git a/drivers/block/rnbd/rnbd-srv.c b/drivers/block/rnbd/rnbd-srv.c
index c4122e65b36a..b4c880759a52 100644
--- a/drivers/block/rnbd/rnbd-srv.c
+++ b/drivers/block/rnbd/rnbd-srv.c
@@ -128,20 +128,17 @@ static int process_rdma(struct rnbd_srv_session *srv_sess,
 
 	trace_process_rdma(srv_sess, msg, id, datalen, usrlen);
 
-	priv = kmalloc(sizeof(*priv), GFP_KERNEL);
-	if (!priv)
-		return -ENOMEM;
-
 	dev_id = le32_to_cpu(msg->device_id);
-
 	sess_dev = rnbd_get_sess_dev(dev_id, srv_sess);
 	if (IS_ERR(sess_dev)) {
 		pr_err_ratelimited("Got I/O request on session %s for unknown device id %d\n",
 				   srv_sess->sessname, dev_id);
-		err = -ENOTCONN;
-		goto err;
+		return -ENOTCONN;
 	}
 
+	priv = kmalloc(sizeof(*priv), GFP_KERNEL);
+	if (!priv)
+		return -ENOMEM;
 	priv->sess_dev = sess_dev;
 	priv->id = id;
 
@@ -169,7 +166,6 @@ static int process_rdma(struct rnbd_srv_session *srv_sess,
 bio_put:
 	bio_put(bio);
 	rnbd_put_sess_dev(sess_dev);
-err:
 	kfree(priv);
 	return err;
 }
-- 
2.35.3


Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9AD04C7EE23
	for <linux-block@archiver.kernel.org>; Wed, 24 May 2023 07:01:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239790AbjEXHBm (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 24 May 2023 03:01:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239810AbjEXHBO (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 24 May 2023 03:01:14 -0400
Received: from out-48.mta0.migadu.com (out-48.mta0.migadu.com [91.218.175.48])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67D26E59
        for <linux-block@vger.kernel.org>; Wed, 24 May 2023 00:00:58 -0700 (PDT)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1684911656;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=fWHmVOU3oHn4Tdxter2iT1Gx5Fgev0l+gU9h0TCwc8E=;
        b=wobEi8Um2aHyLeMhGvYK/RKgOHoe+nlSo28k/xTe43oGIwylWNq8+B85EJP8hJqPhbBf0Z
        BObbeiJKNvIfqLJQTHvRcGcVWSZTIM3kfuafbZOoC9UtrhdwmV+FGBu5TQtjH+Q/La+mML
        Q/k3o8zjDFCaoueQgX3gyQbr3taVfzk=
From:   Guoqing Jiang <guoqing.jiang@linux.dev>
To:     haris.iqbal@ionos.com, jinpu.wang@ionos.com, axboe@kernel.dk
Cc:     linux-block@vger.kernel.org
Subject: [PATCH V2 8/8] block/rnbd-srv: make process_msg_sess_info returns void
Date:   Wed, 24 May 2023 15:00:26 +0800
Message-Id: <20230524070026.2932-9-guoqing.jiang@linux.dev>
In-Reply-To: <20230524070026.2932-1-guoqing.jiang@linux.dev>
References: <20230524070026.2932-1-guoqing.jiang@linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Change the return type to void given it always returns 0.

Acked-by: Jack Wang <jinpu.wang@ionos.com>
Signed-off-by: Guoqing Jiang <guoqing.jiang@linux.dev>
---
 drivers/block/rnbd/rnbd-srv.c | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/drivers/block/rnbd/rnbd-srv.c b/drivers/block/rnbd/rnbd-srv.c
index cfb741815458..6aae067c7a60 100644
--- a/drivers/block/rnbd/rnbd-srv.c
+++ b/drivers/block/rnbd/rnbd-srv.c
@@ -356,7 +356,7 @@ static int process_msg_open(struct rnbd_srv_session *srv_sess,
 			    const void *msg, size_t len,
 			    void *data, size_t datalen);
 
-static int process_msg_sess_info(struct rnbd_srv_session *srv_sess,
+static void process_msg_sess_info(struct rnbd_srv_session *srv_sess,
 				 const void *msg, size_t len,
 				 void *data, size_t datalen);
 
@@ -384,8 +384,7 @@ static int rnbd_srv_rdma_ev(void *priv, struct rtrs_srv_op *id,
 		ret = process_msg_open(srv_sess, usr, usrlen, data, datalen);
 		break;
 	case RNBD_MSG_SESS_INFO:
-		ret = process_msg_sess_info(srv_sess, usr, usrlen, data,
-					    datalen);
+		process_msg_sess_info(srv_sess, usr, usrlen, data, datalen);
 		break;
 	default:
 		pr_warn("Received unexpected message type %d from session %s\n",
@@ -630,7 +629,7 @@ static char *rnbd_srv_get_full_path(struct rnbd_srv_session *srv_sess,
 	return full_path;
 }
 
-static int process_msg_sess_info(struct rnbd_srv_session *srv_sess,
+static void process_msg_sess_info(struct rnbd_srv_session *srv_sess,
 				 const void *msg, size_t len,
 				 void *data, size_t datalen)
 {
@@ -643,8 +642,6 @@ static int process_msg_sess_info(struct rnbd_srv_session *srv_sess,
 
 	rsp->hdr.type = cpu_to_le16(RNBD_MSG_SESS_INFO_RSP);
 	rsp->ver = srv_sess->ver;
-
-	return 0;
 }
 
 /**
-- 
2.35.3


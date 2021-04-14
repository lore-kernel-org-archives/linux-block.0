Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB588C43470
	for <linux-block@archiver.kernel.org>; Wed, 14 Apr 2021 12:24:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B18B1610E8
	for <linux-block@archiver.kernel.org>; Wed, 14 Apr 2021 12:24:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350870AbhDNMYr (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 14 Apr 2021 08:24:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350877AbhDNMYp (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 14 Apr 2021 08:24:45 -0400
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 789C1C06138E
        for <linux-block@vger.kernel.org>; Wed, 14 Apr 2021 05:24:23 -0700 (PDT)
Received: by mail-ej1-x630.google.com with SMTP id n2so31078600ejy.7
        for <linux-block@vger.kernel.org>; Wed, 14 Apr 2021 05:24:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=6Ol0LrZCvE5dH2E8oH5l2wl0+ueRQwWjooW1k9QXypo=;
        b=D8j0TX4LO1slQy8yf68ilIROsWmAIy3tYMUcAltXYQd4U0w709+PcxIaOB09iVeEer
         fyG4wUpda485v7iLQh8SenGz0wB8zlVJzJMcUi7rJ/6NncdHVRvpE4HZ38j+NMXxKQ7n
         NRi2cbIJFLCaQwym1xzRwk2/TKG88jTHRoqkorCRlj6d1TguM7MfAdV6JlkmXxgOME4o
         N3RW6wkI20AApCN8Xl0PglpSuIEmKecueIZ69b2nEUqLAR6BtUD68AtLjF/x3xC3re4g
         G6NmLItFeryG+LxwZ7f/C9/IkqiGtERtf2UyWrmfLZ8SE7EmmPBK9JCym20dkFTKFfQs
         /Jjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=6Ol0LrZCvE5dH2E8oH5l2wl0+ueRQwWjooW1k9QXypo=;
        b=F5lbfycS8Fh/Rn/gyigXwKt/0Yi7iCm0c/1y/BIa1EyOLt3I8fjxB3sj38jaS0WTPT
         ztoJrGRuGEovlLj+fycSZSLhdtOeKSuzBw9BAi3ExiNjQwOp61qt+YEOaCHvfp7alUua
         Jj9vy+rWWkeDhbYPxFYD2rL0yV6/ZGCx4iFpfeeDdo5zMMWCLCcuuL0nwgbKgg79xt9y
         2Teoclsf4tJcWyjXbVu1UZ8rx/Kooy2WeP/jEmsB1QDl2xER0LJKEnIuIaMMVMjtQc8G
         mb+Foo5ir7yqRuTHVsAEqyvWBNYx8KHAa+iu4wIJRbziJfucgKyIX4uDfeJFvx2QRSK7
         Yxig==
X-Gm-Message-State: AOAM5317lRc+/1ybvZA0RetVAPc+enVUMslIZKHZrCeKPm1GQO8XK+Ue
        LCbdqgbL6kyqqJV4U4Hul+q9J9rDDi2+Wfs7
X-Google-Smtp-Source: ABdhPJxgaR7S/g4KueLeviwX6GVRlVHjOz3/zP7eNW5DVbrFwWtxM6tcCOBIZ6VZbCiSwUvrn0Xalw==
X-Received: by 2002:a17:907:3fa2:: with SMTP id hr34mr22585050ejc.476.1618403062035;
        Wed, 14 Apr 2021 05:24:22 -0700 (PDT)
Received: from gkim-laptop.fkb.profitbricks.net (ip5f5aeee5.dynamic.kabel-deutschland.de. [95.90.238.229])
        by smtp.googlemail.com with ESMTPSA id y26sm6201306ejj.98.2021.04.14.05.24.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Apr 2021 05:24:21 -0700 (PDT)
From:   Gioh Kim <gi-oh.kim@ionos.com>
To:     linux-block@vger.kernel.org
Cc:     axboe@kernel.dk, hch@infradead.org, sagi@grimberg.me,
        bvanassche@acm.org, haris.iqbal@ionos.com, jinpu.wang@ionos.com,
        Gioh Kim <gi-oh.kim@cloud.ionos.com>,
        Leon Romanovsky <leonro@nvidia.com>,
        linux-rdma@vger.kernel.org,
        Aleksei Marov <aleksei.marov@ionos.com>,
        Gioh Kim <gi-oh.kim@ionos.com>,
        Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>,
        Jason Gunthorpe <jgg@nvidia.com>
Subject: [PATCHv4 for-next 15/19] block/rnbd-srv: Remove unused arguments of rnbd_srv_rdma_ev
Date:   Wed, 14 Apr 2021 14:23:58 +0200
Message-Id: <20210414122402.203388-16-gi-oh.kim@ionos.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210414122402.203388-1-gi-oh.kim@ionos.com>
References: <20210414122402.203388-1-gi-oh.kim@ionos.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

From: Gioh Kim <gi-oh.kim@cloud.ionos.com>

struct rtrs_srv is not used when handling rnbd_srv_rdma_ev messages, so
cleaned up
rdma_ev function pointer in rtrs_srv_ops also is changed.

Cc: Leon Romanovsky <leonro@nvidia.com>
Cc: linux-rdma@vger.kernel.org
Signed-off-by: Aleksei Marov <aleksei.marov@ionos.com>
Signed-off-by: Jack Wang <jinpu.wang@ionos.com>
Signed-off-by: Gioh Kim <gi-oh.kim@ionos.com>
Reviewed-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
Acked-by: Jason Gunthorpe <jgg@nvidia.com>
---
 drivers/block/rnbd/rnbd-srv.c          | 39 ++++++++++----------------
 drivers/infiniband/ulp/rtrs/rtrs-srv.c |  4 +--
 drivers/infiniband/ulp/rtrs/rtrs.h     |  3 +-
 3 files changed, 18 insertions(+), 28 deletions(-)

diff --git a/drivers/block/rnbd/rnbd-srv.c b/drivers/block/rnbd/rnbd-srv.c
index a9bb414f7442..abacd9ef10d6 100644
--- a/drivers/block/rnbd/rnbd-srv.c
+++ b/drivers/block/rnbd/rnbd-srv.c
@@ -114,8 +114,7 @@ rnbd_get_sess_dev(int dev_id, struct rnbd_srv_session *srv_sess)
 	return sess_dev;
 }
 
-static int process_rdma(struct rtrs_srv *sess,
-			struct rnbd_srv_session *srv_sess,
+static int process_rdma(struct rnbd_srv_session *srv_sess,
 			struct rtrs_srv_op *id, void *data, u32 datalen,
 			const void *usr, size_t usrlen)
 {
@@ -344,8 +343,7 @@ void rnbd_srv_sess_dev_force_close(struct rnbd_srv_sess_dev *sess_dev,
 	mutex_unlock(&sess->lock);
 }
 
-static int process_msg_close(struct rtrs_srv *rtrs,
-			     struct rnbd_srv_session *srv_sess,
+static int process_msg_close(struct rnbd_srv_session *srv_sess,
 			     void *data, size_t datalen, const void *usr,
 			     size_t usrlen)
 {
@@ -364,20 +362,18 @@ static int process_msg_close(struct rtrs_srv *rtrs,
 	return 0;
 }
 
-static int process_msg_open(struct rtrs_srv *rtrs,
-			    struct rnbd_srv_session *srv_sess,
+static int process_msg_open(struct rnbd_srv_session *srv_sess,
 			    const void *msg, size_t len,
 			    void *data, size_t datalen);
 
-static int process_msg_sess_info(struct rtrs_srv *rtrs,
-				 struct rnbd_srv_session *srv_sess,
+static int process_msg_sess_info(struct rnbd_srv_session *srv_sess,
 				 const void *msg, size_t len,
 				 void *data, size_t datalen);
 
-static int rnbd_srv_rdma_ev(struct rtrs_srv *rtrs, void *priv,
-			     struct rtrs_srv_op *id, int dir,
-			     void *data, size_t datalen, const void *usr,
-			     size_t usrlen)
+static int rnbd_srv_rdma_ev(void *priv,
+			    struct rtrs_srv_op *id, int dir,
+			    void *data, size_t datalen, const void *usr,
+			    size_t usrlen)
 {
 	struct rnbd_srv_session *srv_sess = priv;
 	const struct rnbd_msg_hdr *hdr = usr;
@@ -391,19 +387,16 @@ static int rnbd_srv_rdma_ev(struct rtrs_srv *rtrs, void *priv,
 
 	switch (type) {
 	case RNBD_MSG_IO:
-		return process_rdma(rtrs, srv_sess, id, data, datalen, usr,
-				    usrlen);
+		return process_rdma(srv_sess, id, data, datalen, usr, usrlen);
 	case RNBD_MSG_CLOSE:
-		ret = process_msg_close(rtrs, srv_sess, data, datalen,
-					usr, usrlen);
+		ret = process_msg_close(srv_sess, data, datalen, usr, usrlen);
 		break;
 	case RNBD_MSG_OPEN:
-		ret = process_msg_open(rtrs, srv_sess, usr, usrlen,
-				       data, datalen);
+		ret = process_msg_open(srv_sess, usr, usrlen, data, datalen);
 		break;
 	case RNBD_MSG_SESS_INFO:
-		ret = process_msg_sess_info(rtrs, srv_sess, usr, usrlen,
-					    data, datalen);
+		ret = process_msg_sess_info(srv_sess, usr, usrlen, data,
+					    datalen);
 		break;
 	default:
 		pr_warn("Received unexpected message type %d with dir %d from session %s\n",
@@ -656,8 +649,7 @@ static char *rnbd_srv_get_full_path(struct rnbd_srv_session *srv_sess,
 	return full_path;
 }
 
-static int process_msg_sess_info(struct rtrs_srv *rtrs,
-				 struct rnbd_srv_session *srv_sess,
+static int process_msg_sess_info(struct rnbd_srv_session *srv_sess,
 				 const void *msg, size_t len,
 				 void *data, size_t datalen)
 {
@@ -698,8 +690,7 @@ find_srv_sess_dev(struct rnbd_srv_session *srv_sess, const char *dev_name)
 	return NULL;
 }
 
-static int process_msg_open(struct rtrs_srv *rtrs,
-			    struct rnbd_srv_session *srv_sess,
+static int process_msg_open(struct rnbd_srv_session *srv_sess,
 			    const void *msg, size_t len,
 			    void *data, size_t datalen)
 {
diff --git a/drivers/infiniband/ulp/rtrs/rtrs-srv.c b/drivers/infiniband/ulp/rtrs/rtrs-srv.c
index d071809e3ed2..f7aa2a7e7442 100644
--- a/drivers/infiniband/ulp/rtrs/rtrs-srv.c
+++ b/drivers/infiniband/ulp/rtrs/rtrs-srv.c
@@ -998,7 +998,7 @@ static void process_read(struct rtrs_srv_con *con,
 	usr_len = le16_to_cpu(msg->usr_len);
 	data_len = off - usr_len;
 	data = page_address(srv->chunks[buf_id]);
-	ret = ctx->ops.rdma_ev(srv, srv->priv, id, READ, data, data_len,
+	ret = ctx->ops.rdma_ev(srv->priv, id, READ, data, data_len,
 			   data + data_len, usr_len);
 
 	if (unlikely(ret)) {
@@ -1051,7 +1051,7 @@ static void process_write(struct rtrs_srv_con *con,
 	usr_len = le16_to_cpu(req->usr_len);
 	data_len = off - usr_len;
 	data = page_address(srv->chunks[buf_id]);
-	ret = ctx->ops.rdma_ev(srv, srv->priv, id, WRITE, data, data_len,
+	ret = ctx->ops.rdma_ev(srv->priv, id, WRITE, data, data_len,
 			   data + data_len, usr_len);
 	if (unlikely(ret)) {
 		rtrs_err_rl(s,
diff --git a/drivers/infiniband/ulp/rtrs/rtrs.h b/drivers/infiniband/ulp/rtrs/rtrs.h
index f891fbe7abe6..b0f56ffeff88 100644
--- a/drivers/infiniband/ulp/rtrs/rtrs.h
+++ b/drivers/infiniband/ulp/rtrs/rtrs.h
@@ -139,7 +139,6 @@ struct rtrs_srv_ops {
 	 *			message for the data transfer will be sent to
 	 *			the client.
 
-	 *	@sess:		Session
 	 *	@priv:		Private data set by rtrs_srv_set_sess_priv()
 	 *	@id:		internal RTRS operation id
 	 *	@dir:		READ/WRITE
@@ -153,7 +152,7 @@ struct rtrs_srv_ops {
 	 *	@usr:		The extra user message sent by the client (%vec)
 	 *	@usrlen:	Size of the user message
 	 */
-	int (*rdma_ev)(struct rtrs_srv *sess, void *priv,
+	int (*rdma_ev)(void *priv,
 		       struct rtrs_srv_op *id, int dir,
 		       void *data, size_t datalen, const void *usr,
 		       size_t usrlen);
-- 
2.25.1


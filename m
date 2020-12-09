Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C09D9C4361B
	for <linux-block@archiver.kernel.org>; Wed,  9 Dec 2020 08:22:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 73D7723B87
	for <linux-block@archiver.kernel.org>; Wed,  9 Dec 2020 08:22:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725816AbgLIIWP (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 9 Dec 2020 03:22:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725936AbgLIIWP (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 9 Dec 2020 03:22:15 -0500
Received: from mail-ej1-x642.google.com (mail-ej1-x642.google.com [IPv6:2a00:1450:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47C46C0617A7
        for <linux-block@vger.kernel.org>; Wed,  9 Dec 2020 00:21:00 -0800 (PST)
Received: by mail-ej1-x642.google.com with SMTP id d17so825132ejy.9
        for <linux-block@vger.kernel.org>; Wed, 09 Dec 2020 00:21:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloud.ionos.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=gFGSiFO4+XIY4m2BFSEVedlYeaCeUpAVPL4LKBEVyCs=;
        b=AZybXq4lzpiTpD/2OxziM75tArl4j2SqHiNG1J/gksGJ1HM68jE39W0FRzGp3uixBb
         Tm1KNIDfYrDv1VBlKmC4b5Mq7gQA3PlY5aNdddWyWD2vxrjBvQHgPgsbzy6DzIOgKVPz
         5jps4N/d+3SS4wU/ToqZ7PNMqCa1+qGzhr2yA4vEmTFIV4IRF/1nmy3J4I0b0S/o7V4p
         A5c54weqGWlBanU1kFA7Aio1NeHb6bpl4eqhTJ7ZpY5PQvwQKKzWOxoIJcLPr6etBTrt
         +FXkzKVPcqdJVTgs2e0sirEzUwHadlkFwbJKiJB4COQhRZtFGN/BpghsyUSKc6UZ91tm
         vLbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=gFGSiFO4+XIY4m2BFSEVedlYeaCeUpAVPL4LKBEVyCs=;
        b=c/LmusUPkJTixOS7QOBa/3bQ1B1I9P7FXavQs4ALdT0etEhzOmPqES5FNTPCm8+/3Q
         WtpUOVU20HoX7ItQ2no8ycEKJQQqALkwK+hjzdWdUY+M2Xlfuh2oCUZZtpvZycsqhe7e
         in+gxx2sIr4OKHOxdAY96QRakdpeOCGVmK9Ih2j8N2D063KBhhGeg9CPXx8nlTZeTQbj
         OEb1xNmpEZA9SpK4tsTAgK0aOPqwAFWbnMRmc61UXLspmv1qEHdeSjUuOwRSV2UEt46E
         O/bgzXjvcW7l4lf5q84xaOSDQJAObkiTFriYV4fEqKRK9iypCjn2kkN+X3JWiPPzDHyD
         w5Og==
X-Gm-Message-State: AOAM530vOd89xew77R2IFTxewH3P8M2ydC9MxxYLTkUG6IfTf/gVH2dB
        29T9I4NqFq/KjrVftG9eecNT7C1J+QR/8g==
X-Google-Smtp-Source: ABdhPJx7sFKlEZWEjgZ1aX6LJaLfXMXiy7P4iT2FhP4Np2NQ258kHEjml0VcTnMuMElBs8BPXVsLeQ==
X-Received: by 2002:a17:906:fa88:: with SMTP id lt8mr1106751ejb.408.1607502058798;
        Wed, 09 Dec 2020 00:20:58 -0800 (PST)
Received: from jwang-Latitude-5491.fkb.profitbricks.net ([2001:16b8:49e0:2500:1d14:118d:b29c:98ec])
        by smtp.gmail.com with ESMTPSA id cf17sm823225edb.16.2020.12.09.00.20.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Dec 2020 00:20:58 -0800 (PST)
From:   Jack Wang <jinpu.wang@cloud.ionos.com>
To:     linux-block@vger.kernel.org
Cc:     axboe@kernel.dk, hch@infradead.org, sagi@grimberg.me,
        bvanassche@acm.org, danil.kipnis@cloud.ionos.com,
        Gioh Kim <gi-oh.kim@cloud.ionos.com>
Subject: [PATCH for-next 6/7] block/rnbd-clt: Dynamically allocate sglist for rnbd_iu
Date:   Wed,  9 Dec 2020 09:20:50 +0100
Message-Id: <20201209082051.12306-7-jinpu.wang@cloud.ionos.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201209082051.12306-1-jinpu.wang@cloud.ionos.com>
References: <20201209082051.12306-1-jinpu.wang@cloud.ionos.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

From: Gioh Kim <gi-oh.kim@cloud.ionos.com>

The BMAX_SEGMENT static array for scatterlist is embedded in
rnbd_iu structure to avoid memory allocation in hot IO path.
In many cases, we do need only several sg entries because many IOs
have only several segments.

This patch change rnbd_iu to check the number of segments in the request
and allocate sglist dynamically.

For io path, use sg_alloc_table_chained to allocate sg list faster.

First it makes two sg entries after pdu of request.
The sg_alloc_table_chained uses the pre-allocated sg entries
if the number of segments of the request is less than two.
So it reduces the number of memory allocation.

Signed-off-by: Gioh Kim <gi-oh.kim@cloud.ionos.com>
Signed-off-by: Jack Wang <jinpu.wang@cloud.ionos.com>
---
 drivers/block/rnbd/rnbd-clt.c | 58 +++++++++++++++++++----------------
 drivers/block/rnbd/rnbd-clt.h | 10 +++++-
 2 files changed, 41 insertions(+), 27 deletions(-)

diff --git a/drivers/block/rnbd/rnbd-clt.c b/drivers/block/rnbd/rnbd-clt.c
index fe8c738a1797..c37d94181ff4 100644
--- a/drivers/block/rnbd/rnbd-clt.c
+++ b/drivers/block/rnbd/rnbd-clt.c
@@ -384,6 +384,7 @@ static void rnbd_softirq_done_fn(struct request *rq)
 	struct rnbd_iu *iu;
 
 	iu = blk_mq_rq_to_pdu(rq);
+	sg_free_table_chained(&iu->sgt, RNBD_INLINE_SG_CNT);
 	rnbd_put_permit(sess, iu->permit);
 	blk_mq_end_request(rq, errno_to_blk_status(iu->errno));
 }
@@ -477,7 +478,7 @@ static int send_msg_close(struct rnbd_clt_dev *dev, u32 device_id, bool wait)
 	iu->buf = NULL;
 	iu->dev = dev;
 
-	sg_mark_end(&iu->sglist[0]);
+	sg_alloc_table(&iu->sgt, 1, GFP_KERNEL);
 
 	msg.hdr.type	= cpu_to_le16(RNBD_MSG_CLOSE);
 	msg.device_id	= cpu_to_le32(device_id);
@@ -492,6 +493,7 @@ static int send_msg_close(struct rnbd_clt_dev *dev, u32 device_id, bool wait)
 		err = errno;
 	}
 
+	sg_free_table(&iu->sgt);
 	rnbd_put_iu(sess, iu);
 	return err;
 }
@@ -564,7 +566,8 @@ static int send_msg_open(struct rnbd_clt_dev *dev, bool wait)
 	iu->buf = rsp;
 	iu->dev = dev;
 
-	sg_init_one(iu->sglist, rsp, sizeof(*rsp));
+	sg_alloc_table(&iu->sgt, 1, GFP_KERNEL);
+	sg_init_one(iu->sgt.sgl, rsp, sizeof(*rsp));
 
 	msg.hdr.type	= cpu_to_le16(RNBD_MSG_OPEN);
 	msg.access_mode	= dev->access_mode;
@@ -572,7 +575,7 @@ static int send_msg_open(struct rnbd_clt_dev *dev, bool wait)
 
 	WARN_ON(!rnbd_clt_get_dev(dev));
 	err = send_usr_msg(sess->rtrs, READ, iu,
-			   &vec, sizeof(*rsp), iu->sglist, 1,
+			   &vec, sizeof(*rsp), iu->sgt.sgl, 1,
 			   msg_open_conf, &errno, wait);
 	if (err) {
 		rnbd_clt_put_dev(dev);
@@ -582,6 +585,7 @@ static int send_msg_open(struct rnbd_clt_dev *dev, bool wait)
 		err = errno;
 	}
 
+	sg_free_table(&iu->sgt);
 	rnbd_put_iu(sess, iu);
 	return err;
 }
@@ -610,7 +614,8 @@ static int send_msg_sess_info(struct rnbd_clt_session *sess, bool wait)
 	iu->buf = rsp;
 	iu->sess = sess;
 
-	sg_init_one(iu->sglist, rsp, sizeof(*rsp));
+	sg_alloc_table(&iu->sgt, 1, GFP_KERNEL);
+	sg_init_one(iu->sgt.sgl, rsp, sizeof(*rsp));
 
 	msg.hdr.type = cpu_to_le16(RNBD_MSG_SESS_INFO);
 	msg.ver      = RNBD_PROTO_VER_MAJOR;
@@ -626,7 +631,7 @@ static int send_msg_sess_info(struct rnbd_clt_session *sess, bool wait)
 		goto put_iu;
 	}
 	err = send_usr_msg(sess->rtrs, READ, iu,
-			   &vec, sizeof(*rsp), iu->sglist, 1,
+			   &vec, sizeof(*rsp), iu->sgt.sgl, 1,
 			   msg_sess_info_conf, &errno, wait);
 	if (err) {
 		rnbd_clt_put_sess(sess);
@@ -636,7 +641,7 @@ static int send_msg_sess_info(struct rnbd_clt_session *sess, bool wait)
 	} else {
 		err = errno;
 	}
-
+	sg_free_table(&iu->sgt);
 	rnbd_put_iu(sess, iu);
 	return err;
 }
@@ -1016,11 +1021,10 @@ static int rnbd_client_xfer_request(struct rnbd_clt_dev *dev,
 	 * See queue limits.
 	 */
 	if (req_op(rq) != REQ_OP_DISCARD)
-		sg_cnt = blk_rq_map_sg(dev->queue, rq, iu->sglist);
+		sg_cnt = blk_rq_map_sg(dev->queue, rq, iu->sgt.sgl);
 
 	if (sg_cnt == 0)
-		/* Do not forget to mark the end */
-		sg_mark_end(&iu->sglist[0]);
+		sg_mark_end(&iu->sgt.sgl[0]);
 
 	msg.hdr.type	= cpu_to_le16(RNBD_MSG_IO);
 	msg.device_id	= cpu_to_le32(dev->device_id);
@@ -1029,13 +1033,13 @@ static int rnbd_client_xfer_request(struct rnbd_clt_dev *dev,
 		.iov_base = &msg,
 		.iov_len  = sizeof(msg)
 	};
-	size = rnbd_clt_get_sg_size(iu->sglist, sg_cnt);
+	size = rnbd_clt_get_sg_size(iu->sgt.sgl, sg_cnt);
 	req_ops = (struct rtrs_clt_req_ops) {
 		.priv = iu,
 		.conf_fn = msg_io_conf,
 	};
 	err = rtrs_clt_request(rq_data_dir(rq), &req_ops, rtrs, permit,
-			       &vec, 1, size, iu->sglist, sg_cnt);
+			       &vec, 1, size, iu->sgt.sgl, sg_cnt);
 	if (unlikely(err)) {
 		rnbd_clt_err_rl(dev, "RTRS failed to transfer IO, err: %d\n",
 				 err);
@@ -1122,6 +1126,7 @@ static blk_status_t rnbd_queue_rq(struct blk_mq_hw_ctx *hctx,
 	struct rnbd_clt_dev *dev = rq->rq_disk->private_data;
 	struct rnbd_iu *iu = blk_mq_rq_to_pdu(rq);
 	int err;
+	blk_status_t ret = BLK_STS_IOERR;
 
 	if (unlikely(dev->dev_state != DEV_STATE_MAPPED))
 		return BLK_STS_IOERR;
@@ -1133,32 +1138,33 @@ static blk_status_t rnbd_queue_rq(struct blk_mq_hw_ctx *hctx,
 		return BLK_STS_RESOURCE;
 	}
 
+	iu->sgt.sgl = iu->first_sgl;
+	err = sg_alloc_table_chained(&iu->sgt,
+				     /* Even-if the request has no segment,
+				      * sglist must have one entry at least */
+				     blk_rq_nr_phys_segments(rq) ? : 1,
+				     iu->sgt.sgl,
+				     RNBD_INLINE_SG_CNT);
+	if (err) {
+		rnbd_clt_err_rl(dev, "sg_alloc_table_chained ret=%d\n", err);
+		return BLK_STS_IOERR;
+	}
+
 	blk_mq_start_request(rq);
 	err = rnbd_client_xfer_request(dev, rq, iu);
 	if (likely(err == 0))
 		return BLK_STS_OK;
 	if (unlikely(err == -EAGAIN || err == -ENOMEM)) {
 		rnbd_clt_dev_kick_mq_queue(dev, hctx, 10/*ms*/);
-		rnbd_put_permit(dev->sess, iu->permit);
-		return BLK_STS_RESOURCE;
+		ret = BLK_STS_RESOURCE;
 	}
-
+	sg_free_table_chained(&iu->sgt, RNBD_INLINE_SG_CNT);
 	rnbd_put_permit(dev->sess, iu->permit);
-	return BLK_STS_IOERR;
-}
-
-static int rnbd_init_request(struct blk_mq_tag_set *set, struct request *rq,
-			      unsigned int hctx_idx, unsigned int numa_node)
-{
-	struct rnbd_iu *iu = blk_mq_rq_to_pdu(rq);
-
-	sg_init_table(iu->sglist, BMAX_SEGMENTS);
-	return 0;
+	return ret;
 }
 
 static struct blk_mq_ops rnbd_mq_ops = {
 	.queue_rq	= rnbd_queue_rq,
-	.init_request	= rnbd_init_request,
 	.complete	= rnbd_softirq_done_fn,
 };
 
@@ -1172,7 +1178,7 @@ static int setup_mq_tags(struct rnbd_clt_session *sess)
 	tag_set->numa_node		= NUMA_NO_NODE;
 	tag_set->flags		= BLK_MQ_F_SHOULD_MERGE |
 				  BLK_MQ_F_TAG_QUEUE_SHARED;
-	tag_set->cmd_size		= sizeof(struct rnbd_iu);
+	tag_set->cmd_size	= sizeof(struct rnbd_iu) + RNBD_RDMA_SGL_SIZE;
 	tag_set->nr_hw_queues	= num_online_cpus();
 
 	return blk_mq_alloc_tag_set(tag_set);
diff --git a/drivers/block/rnbd/rnbd-clt.h b/drivers/block/rnbd/rnbd-clt.h
index efd67ae286ca..44b116028ff6 100644
--- a/drivers/block/rnbd/rnbd-clt.h
+++ b/drivers/block/rnbd/rnbd-clt.h
@@ -44,6 +44,13 @@ struct rnbd_iu_comp {
 	int errno;
 };
 
+#ifdef CONFIG_ARCH_NO_SG_CHAIN
+#define RNBD_INLINE_SG_CNT 0
+#else
+#define RNBD_INLINE_SG_CNT 2
+#endif
+#define RNBD_RDMA_SGL_SIZE (sizeof(struct scatterlist) * RNBD_INLINE_SG_CNT)
+
 struct rnbd_iu {
 	union {
 		struct request *rq; /* for block io */
@@ -56,11 +63,12 @@ struct rnbd_iu {
 		/* use to send msg associated with a sess */
 		struct rnbd_clt_session *sess;
 	};
-	struct scatterlist	sglist[BMAX_SEGMENTS];
+	struct sg_table		sgt;
 	struct work_struct	work;
 	int			errno;
 	struct rnbd_iu_comp	comp;
 	atomic_t		refcount;
+	struct scatterlist	first_sgl[];
 };
 
 struct rnbd_cpu_qlist {
-- 
2.25.1


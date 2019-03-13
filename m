Return-Path: <SRS0=zSf2=RQ=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC26BC43381
	for <linux-block@archiver.kernel.org>; Wed, 13 Mar 2019 17:56:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BB84D20854
	for <linux-block@archiver.kernel.org>; Wed, 13 Mar 2019 17:56:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Gq/QY5ko"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726735AbfCMR4Q (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 13 Mar 2019 13:56:16 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:51044 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726733AbfCMR4Q (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 13 Mar 2019 13:56:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From
        :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=W6gO0MsACN0DMPZ3dMOBxtYdHTovSnY0YT8eNByP/mk=; b=Gq/QY5ko0UEyNRmOXNHz7abvo+
        5dwr/NN2tVEwq9a09QCT4G6ETmLg3E+q//SJg83ptPijHf/tHfuAtAHlh7kFQbOFLD+4wvzL3ADUB
        Req+yL6+2V5xeKiuf39MNizC+loPtbWHUxj9o5UR/U485w/xsn7tTksZ+dhfNfESrPfY4lMg5WulQ
        /tw2M3WLGxUHDRnwvSw14PW/y0fcQeJ0ThQOMN4J6VOV3gQPI20AViUBEwxr/7fHprqFDA+XtIvEO
        Coxff+E/7SfG+VOxX+Js5ih31ruv75oHuHJ8ooeNDqUAmlwHPI4Lrl4mBc5won+kNm1OwQGi5Pn44
        xKlHwt8g==;
Received: from 089144197017.atnat0006.highway.a1.net ([89.144.197.17] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1h486t-0002As-11; Wed, 13 Mar 2019 17:56:11 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Keith Busch <keith.busch@intel.com>,
        Sagi Grimberg <sagi@grimberg.me>,
        linux-nvme@lists.infradead.org, linux-block@vger.kernel.org,
        Steve Blightman <steve.blightman@oracle.com>,
        Oliver Smith-Denny <osmithde@cisco.com>
Subject: [PATCH 17/17] nvme-tcp: support C2HData with SUCCESS flag
Date:   Wed, 13 Mar 2019 18:55:10 +0100
Message-Id: <20190313175510.20725-18-hch@lst.de>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190313175510.20725-1-hch@lst.de>
References: <20190313175510.20725-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

From: Sagi Grimberg <sagi@grimberg.me>

A C2HData PDU with the SUCCESS flag set indicates that the I/O was
completed by the controller successfully and means that a subsequent
completion response capsule PDU will be ommitted.

If we see this flag, fisrt we check that LAST_PDU flag is set as well,
and then we complete the request when the data transfer (and data digest
verification if its on) is done.

While we're at it, reuse a bit of code with nvme_fail_request.

Reported-by: Steve Blightman <steve.blightman@oracle.com>
Suggested-by: Oliver Smith-Denny <osmithde@cisco.com>
Signed-off-by: Sagi Grimberg <sagi@grimberg.me>
Reviewed-by: Oliver Smith-Denny <osmithde@cisco.com>
Tested-by: Oliver Smith-Denny <osmithde@cisco.com>
Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/nvme/host/tcp.c | 32 ++++++++++++++++++++++++++++----
 1 file changed, 28 insertions(+), 4 deletions(-)

diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
index 208ee518af65..e7e08889865e 100644
--- a/drivers/nvme/host/tcp.c
+++ b/drivers/nvme/host/tcp.c
@@ -463,6 +463,15 @@ static int nvme_tcp_handle_c2h_data(struct nvme_tcp_queue *queue,
 
 	queue->data_remaining = le32_to_cpu(pdu->data_length);
 
+	if (pdu->hdr.flags & NVME_TCP_F_DATA_SUCCESS &&
+	    unlikely(!(pdu->hdr.flags & NVME_TCP_F_DATA_LAST))) {
+		dev_err(queue->ctrl->ctrl.device,
+			"queue %d tag %#x SUCCESS set but not last PDU\n",
+			nvme_tcp_queue_id(queue), rq->tag);
+		nvme_tcp_error_recovery(&queue->ctrl->ctrl);
+		return -EPROTO;
+	}
+
 	return 0;
 
 }
@@ -618,6 +627,14 @@ static int nvme_tcp_recv_pdu(struct nvme_tcp_queue *queue, struct sk_buff *skb,
 	return ret;
 }
 
+static inline void nvme_tcp_end_request(struct request *rq, __le16 status)
+{
+	union nvme_result res = {};
+
+	nvme_end_request(rq, cpu_to_le16(status << 1), res);
+}
+
+
 static int nvme_tcp_recv_data(struct nvme_tcp_queue *queue, struct sk_buff *skb,
 			      unsigned int *offset, size_t *len)
 {
@@ -685,6 +702,8 @@ static int nvme_tcp_recv_data(struct nvme_tcp_queue *queue, struct sk_buff *skb,
 			nvme_tcp_ddgst_final(queue->rcv_hash, &queue->exp_ddgst);
 			queue->ddgst_remaining = NVME_TCP_DIGEST_LENGTH;
 		} else {
+			if (pdu->hdr.flags & NVME_TCP_F_DATA_SUCCESS)
+				nvme_tcp_end_request(rq, NVME_SC_SUCCESS);
 			nvme_tcp_init_recv_ctx(queue);
 		}
 	}
@@ -695,6 +714,7 @@ static int nvme_tcp_recv_data(struct nvme_tcp_queue *queue, struct sk_buff *skb,
 static int nvme_tcp_recv_ddgst(struct nvme_tcp_queue *queue,
 		struct sk_buff *skb, unsigned int *offset, size_t *len)
 {
+	struct nvme_tcp_data_pdu *pdu = (void *)queue->pdu;
 	char *ddgst = (char *)&queue->recv_ddgst;
 	size_t recv_len = min_t(size_t, *len, queue->ddgst_remaining);
 	off_t off = NVME_TCP_DIGEST_LENGTH - queue->ddgst_remaining;
@@ -718,6 +738,13 @@ static int nvme_tcp_recv_ddgst(struct nvme_tcp_queue *queue,
 		return -EIO;
 	}
 
+	if (pdu->hdr.flags & NVME_TCP_F_DATA_SUCCESS) {
+		struct request *rq = blk_mq_tag_to_rq(nvme_tcp_tagset(queue),
+						pdu->command_id);
+
+		nvme_tcp_end_request(rq, NVME_SC_SUCCESS);
+	}
+
 	nvme_tcp_init_recv_ctx(queue);
 	return 0;
 }
@@ -815,10 +842,7 @@ static inline void nvme_tcp_done_send_req(struct nvme_tcp_queue *queue)
 
 static void nvme_tcp_fail_request(struct nvme_tcp_request *req)
 {
-	union nvme_result res = {};
-
-	nvme_end_request(blk_mq_rq_from_pdu(req),
-		cpu_to_le16(NVME_SC_DATA_XFER_ERROR), res);
+	nvme_tcp_end_request(blk_mq_rq_from_pdu(req), NVME_SC_DATA_XFER_ERROR);
 }
 
 static int nvme_tcp_try_send_data(struct nvme_tcp_request *req)
-- 
2.20.1


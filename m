Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB914C2D0A3
	for <linux-block@archiver.kernel.org>; Tue, 10 Nov 2020 02:24:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4E89C206F1
	for <linux-block@archiver.kernel.org>; Tue, 10 Nov 2020 02:24:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="ZgoRyK4Q"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729661AbgKJCYQ (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 9 Nov 2020 21:24:16 -0500
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:55022 "EHLO
        esa5.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727311AbgKJCYQ (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Mon, 9 Nov 2020 21:24:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1604975056; x=1636511056;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=ts7dWhWksChe+Ge9MmVR/giRlJQuhaWDRlUWiBwj91A=;
  b=ZgoRyK4QpMuW2rCoZC/0HzHJxcFZJaKjqzLT9/GQpz6nw/T3+b07W+Xb
   CsfwV4Z1OhtYn0DYHW/8zF3vFhhMRTk5PaDjRfNW+QM29zyUdvAuNh92H
   YXR2NXPGIzRfeqSpGA0EGDhR7aDEmnwfeechOggXW3VF1blkjE6E6pHev
   JSNHTmGrI0Og52hkL6klmQc+pxWL3/dd/Ij05NVF4e1x8L7fQSWtxKYGa
   JoWLcOb86AaBXpN26jcJ/ciJREUj+dM8B886WC4IjNIuPGnvfVog7JoND
   kmYmyeFx30ekI7lwHcfIuMukC3oJVDf6zGxPJtuG9TlmBZryMOD6QdqxH
   w==;
IronPort-SDR: 4qqUMnfNcmpCqmIQnn2HetZj716VB1xPYElVeqU0knIw+lBzrdp5n9MfWSrilZXiLxUJpjDi9m
 lxv21oLRi6VGZvjmt8mKLrbYLfqtzsvT76s1r4/m45SEQ+ubVzpLtVIwaFdXP5AhX3FWlVruqa
 zvW+wk89jz2xB3SciGF24097cXfet5b6SmUfygaorxHGeEH06By8rLfGlt4j022KK/g/bwhxgk
 WUCjw+A5fBMjngYObybbay0N1tZGHnXFE8RYP9TsgKDFrprQkhArfz8UgFBumPXKiPxULmhpPm
 ruE=
X-IronPort-AV: E=Sophos;i="5.77,465,1596470400"; 
   d="scan'208";a="152339802"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 10 Nov 2020 10:24:15 +0800
IronPort-SDR: Z9PH9Od83RTnnjHFKWQ3ta5PiyXks07i/ivHf1dWpRw8jgtil6L5AVEVVZhd3GkDe07piYxNou
 9GN07xZIOymdWe+eTGCYX0FXaKaakrnroSh8l5XmFYkAORNHdgmDpy5qnFxRa/PF6yRm7M//Kf
 AarQaSaNQvOe/pMdv+H0s3Vt+Ui7DqxL1oIGgxxtoRpXIr6g6jFkXEmgjhu7l9V+imR4UdF40t
 TQeDcKZZmGa+EQ6XITOpQes1rmb5MqIOPRoOBasqHT2G0QAX9qj5VcKITTgBwKtTJ50EKV+jXt
 N7nTzy1GorRSeIqaVmnLSDjW
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Nov 2020 18:10:17 -0800
IronPort-SDR: +vJOryP7guqQjvrSL95yyrjEW62tWwoNWTJk9KKDadTS704hqNHuh+28OpFp9gJun/WoEejMa6
 gYDMddWI7t0thd694WZyTxqUQYm6y80Q5U+BZRKvGiQNo8m1iAcA1VDnqic7j1S/B61RQHrTNp
 ZhhMi1TCHaLPChu6DFZhLC7g1TT/mJYqKz/cHOBDokXivGadJhQWNf4F1Vr9A2NojCnZvzyNGF
 ioQ0Q1D2lYGhHy9EAqdjNWT96IVWl3Qwl4s+OWrzZS9Q/PG+51606bbv7YPAcQ7zDyG2tsezvE
 +UY=
WDCIronportException: Internal
Received: from vm.labspan.wdc.com (HELO vm.sc.wdc.com) ([10.6.137.102])
  by uls-op-cesaip02.wdc.com with ESMTP; 09 Nov 2020 18:24:15 -0800
From:   Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
To:     linux-nvme@lists.infradead.org, linux-block@vger.kernel.org
Cc:     axboe@kernel.dk, kbusch@kernel.org, sagi@grimberg.me, hch@lst.de,
        Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>,
        Logan Gunthorpe <logang@deltatee.com>
Subject: [PATCH V4 1/6] nvme-core: add req init helpers
Date:   Mon,  9 Nov 2020 18:24:00 -0800
Message-Id: <20201110022405.6707-2-chaitanya.kulkarni@wdc.com>
X-Mailer: git-send-email 2.22.1
In-Reply-To: <20201110022405.6707-1-chaitanya.kulkarni@wdc.com>
References: <20201110022405.6707-1-chaitanya.kulkarni@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

This is a preparation patch which adds a helper that we use in the next
patch that splits the nvme_alloc_request() into
nvme_alloc_request_qid_any() and nvme_alloc_request_qid().

The new functions shares the code to initialize the allocated request
from NVMe cmd, initializing the REQ_OP_XXX from nvme command and setting
the default timeout after request allocation.

Signed-off-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
Reviewed-by: Logan Gunthorpe <logang@deltatee.com>
---
 drivers/nvme/host/core.c | 33 ++++++++++++++++++++++++---------
 1 file changed, 24 insertions(+), 9 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 98bea150e5dc..315ea958d1b7 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -518,10 +518,31 @@ static inline void nvme_clear_nvme_request(struct request *req)
 	}
 }
 
+static inline void nvme_init_req_from_cmd(struct request *req,
+		struct nvme_command *cmd)
+{
+	req->cmd_flags |= REQ_FAILFAST_DRIVER;
+	nvme_clear_nvme_request(req);
+	nvme_req(req)->cmd = cmd;
+}
+
+static inline unsigned int nvme_req_op(struct nvme_command *cmd)
+{
+	return nvme_is_write(cmd) ? REQ_OP_DRV_OUT : REQ_OP_DRV_IN;
+}
+
+static inline void nvme_init_req_default_timeout(struct request *req)
+{
+	if (req->q->queuedata)
+		req->timeout = NVME_IO_TIMEOUT;
+	else /* no queuedata implies admin queue */
+		req->timeout = NVME_ADMIN_TIMEOUT;
+}
+
 struct request *nvme_alloc_request(struct request_queue *q,
 		struct nvme_command *cmd, blk_mq_req_flags_t flags, int qid)
 {
-	unsigned op = nvme_is_write(cmd) ? REQ_OP_DRV_OUT : REQ_OP_DRV_IN;
+	unsigned op = nvme_req_op(cmd);
 	struct request *req;
 
 	if (qid == NVME_QID_ANY) {
@@ -533,14 +554,8 @@ struct request *nvme_alloc_request(struct request_queue *q,
 	if (IS_ERR(req))
 		return req;
 
-	if (req->q->queuedata)
-		req->timeout = NVME_IO_TIMEOUT;
-	else /* no queuedata implies admin queue */
-		req->timeout = NVME_ADMIN_TIMEOUT;
-
-	req->cmd_flags |= REQ_FAILFAST_DRIVER;
-	nvme_clear_nvme_request(req);
-	nvme_req(req)->cmd = cmd;
+	nvme_init_req_timeout(req);
+	nvme_init_req_from_cmd(req, cmd);
 
 	return req;
 }
-- 
2.22.1


Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6EDAEC433FE
	for <linux-block@archiver.kernel.org>; Wed, 17 Nov 2021 03:38:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5930063215
	for <linux-block@archiver.kernel.org>; Wed, 17 Nov 2021 03:38:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231200AbhKQDlL (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 16 Nov 2021 22:41:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231424AbhKQDlK (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 16 Nov 2021 22:41:10 -0500
Received: from mail-io1-xd31.google.com (mail-io1-xd31.google.com [IPv6:2607:f8b0:4864:20::d31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22458C061570
        for <linux-block@vger.kernel.org>; Tue, 16 Nov 2021 19:38:13 -0800 (PST)
Received: by mail-io1-xd31.google.com with SMTP id z26so1281230iod.10
        for <linux-block@vger.kernel.org>; Tue, 16 Nov 2021 19:38:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=8z9BXWgx/3pZLVd7wZo3C6gCk0NqzQCEacc8RWYt7RY=;
        b=YISAX82UiEU1N76h2yuk2lno5RsmzbtdFBdrvsOcWSo5pT+UKzlyRebIIBSoGeJOfS
         PvNy79cyUZjmd37Yz0lU6//h0FL0c7kCIRx7xTRXOWlvwPe2BNc7lLsj6aBMwGg0XB2m
         D7rEKnrlyuwDWVVjat5+0bLlrlN8JD2YyIXAg2s1TGK+kqcz/LwKefhaHah/TIj+YjRB
         dCZFPmDaJv1UQWcVpvhnuBc6fhFANnPX0FfeuB/91a79sONhrLEvYY06mbLGmBdZIy7t
         PyT1yGuUW+If4bJAtKi6fj2T7PQq7OxCkbMs9E7inHdFA25WfAXSRprUz3dEsc3dQZes
         9HZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=8z9BXWgx/3pZLVd7wZo3C6gCk0NqzQCEacc8RWYt7RY=;
        b=5tDuFUvlZosG4iOvlNJtW3epy2Y5EL70XvHBa2b1lINwvkzfMqwR3EK8yrQZn1kIGS
         RbnZ5uQDhmBurCR4Z6ZIEEt3cO6yln3+Ao3aRNu/lGxmeT7xkKp3eelHagEF11D+xJEH
         vWdjihM6x88UoPtHRXVgXdCAzsdq+BIYYL9lDmnFhBZMYY6wvXvNqECCgJ4CViHnGAco
         4r0VeWOPtrp20YLOiZb1HPeLxq+wk2Brci34W9CD9pUt82DQK2qn3b6ZcURR6Zmc4IKP
         NhNoVT1urOlkWvZUaG0crV/fLzySQaye/FKm+Kc19Whuhfo2tOuWCxyjUxGLq/DGTEgG
         /FbA==
X-Gm-Message-State: AOAM531Q7Rq7zb/FoTj+TdfYeBbUmmQTV1mfUZ+XnuJZBR1OvPhEx5Ed
        RVgh4Q4CxttudcLoQOu0AE8gc2dRoP8iZtwF
X-Google-Smtp-Source: ABdhPJyFi10QaKFMCVn53K4XwHu3hXqQt9qZ2LX8GcrygDbHG+3nlPpJ5YkbTVMgqwClgIPTADjPgA==
X-Received: by 2002:a05:6602:2a42:: with SMTP id k2mr8531850iov.132.1637120292384;
        Tue, 16 Nov 2021 19:38:12 -0800 (PST)
Received: from localhost.localdomain ([66.219.217.159])
        by smtp.gmail.com with ESMTPSA id l13sm12563693ios.49.2021.11.16.19.38.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Nov 2021 19:38:12 -0800 (PST)
From:   Jens Axboe <axboe@kernel.dk>
To:     linux-block@vger.kernel.org
Cc:     hch@infradead.org, Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 3/4] nvme: separate command prep and issue
Date:   Tue, 16 Nov 2021 20:38:06 -0700
Message-Id: <20211117033807.185715-4-axboe@kernel.dk>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20211117033807.185715-1-axboe@kernel.dk>
References: <20211117033807.185715-1-axboe@kernel.dk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Add a nvme_prep_rq() helper to setup a command, and nvme_queue_rq() is
adapted to use this helper.

Signed-off-by: Jens Axboe <axboe@kernel.dk>
---
 drivers/nvme/host/pci.c | 54 +++++++++++++++++++++++++----------------
 1 file changed, 33 insertions(+), 21 deletions(-)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index c33cd1177b37..d2b654fc3603 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -937,18 +937,10 @@ static blk_status_t nvme_map_metadata(struct nvme_dev *dev, struct request *req,
 	return BLK_STS_OK;
 }
 
-/*
- * NOTE: ns is NULL when called on the admin queue.
- */
-static blk_status_t nvme_queue_rq(struct blk_mq_hw_ctx *hctx,
-			 const struct blk_mq_queue_data *bd)
+static blk_status_t nvme_prep_rq(struct nvme_dev *dev, struct nvme_ns *ns,
+				 struct request *req, struct nvme_command *cmnd)
 {
-	struct nvme_ns *ns = hctx->queue->queuedata;
-	struct nvme_queue *nvmeq = hctx->driver_data;
-	struct nvme_dev *dev = nvmeq->dev;
-	struct request *req = bd->rq;
 	struct nvme_iod *iod = blk_mq_rq_to_pdu(req);
-	struct nvme_command *cmnd = &iod->cmd;
 	blk_status_t ret;
 
 	iod->aborted = false;
@@ -956,16 +948,6 @@ static blk_status_t nvme_queue_rq(struct blk_mq_hw_ctx *hctx,
 	iod->npages = -1;
 	iod->nents = 0;
 
-	/*
-	 * We should not need to do this, but we're still using this to
-	 * ensure we can drain requests on a dying queue.
-	 */
-	if (unlikely(!test_bit(NVMEQ_ENABLED, &nvmeq->flags)))
-		return BLK_STS_IOERR;
-
-	if (!nvme_check_ready(&dev->ctrl, req, true))
-		return nvme_fail_nonready_command(&dev->ctrl, req);
-
 	ret = nvme_setup_cmd(ns, req);
 	if (ret)
 		return ret;
@@ -983,7 +965,6 @@ static blk_status_t nvme_queue_rq(struct blk_mq_hw_ctx *hctx,
 	}
 
 	blk_mq_start_request(req);
-	nvme_submit_cmd(nvmeq, cmnd, bd->last);
 	return BLK_STS_OK;
 out_unmap_data:
 	nvme_unmap_data(dev, req);
@@ -992,6 +973,37 @@ static blk_status_t nvme_queue_rq(struct blk_mq_hw_ctx *hctx,
 	return ret;
 }
 
+/*
+ * NOTE: ns is NULL when called on the admin queue.
+ */
+static blk_status_t nvme_queue_rq(struct blk_mq_hw_ctx *hctx,
+			 const struct blk_mq_queue_data *bd)
+{
+	struct nvme_ns *ns = hctx->queue->queuedata;
+	struct nvme_queue *nvmeq = hctx->driver_data;
+	struct nvme_dev *dev = nvmeq->dev;
+	struct request *req = bd->rq;
+	struct nvme_iod *iod = blk_mq_rq_to_pdu(req);
+	blk_status_t ret;
+
+	/*
+	 * We should not need to do this, but we're still using this to
+	 * ensure we can drain requests on a dying queue.
+	 */
+	if (unlikely(!test_bit(NVMEQ_ENABLED, &nvmeq->flags)))
+		return BLK_STS_IOERR;
+
+	if (!nvme_check_ready(&dev->ctrl, req, true))
+		return nvme_fail_nonready_command(&dev->ctrl, req);
+
+	ret = nvme_prep_rq(dev, ns, req, &iod->cmd);
+	if (ret == BLK_STS_OK) {
+		nvme_submit_cmd(nvmeq, &iod->cmd, bd->last);
+		return BLK_STS_OK;
+	}
+	return ret;
+}
+
 static __always_inline void nvme_pci_unmap_rq(struct request *req)
 {
 	struct nvme_iod *iod = blk_mq_rq_to_pdu(req);
-- 
2.33.1


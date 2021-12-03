Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 524C5C433EF
	for <linux-block@archiver.kernel.org>; Fri,  3 Dec 2021 21:45:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1383269AbhLCVtV (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 3 Dec 2021 16:49:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236204AbhLCVtV (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Fri, 3 Dec 2021 16:49:21 -0500
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EFD59C061751
        for <linux-block@vger.kernel.org>; Fri,  3 Dec 2021 13:45:56 -0800 (PST)
Received: by mail-pf1-x430.google.com with SMTP id n85so4052672pfd.10
        for <linux-block@vger.kernel.org>; Fri, 03 Dec 2021 13:45:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=yxdkcGfQVk3YgliGR9Ok7AI5TvejdPpxVDGMXfDvDmw=;
        b=rbNOBEBv2NoUR31USK/AYDPLPOUhO+dsBIII1KaC+beReWqI2g8RNiuS4nLx+z6kmS
         9F77UtnxERF3U3astDqQcQLgUP4OK2rTUV5/7K5to7dNB7blAIYkxA+1JduHnbxNKuGH
         PUESMy20z1wiy6LO4zvbRppKOSwzQ4sm81w12VNHZxnyWsyxRFLD688vnsC8TCeTXUDy
         t7xuOBF3K8GwVOxkyQCF5xTk+H1nKjxrmXQK7G2pHpiEdhW4G5yXYKEETAhwl5kJeK7C
         TCgUh8mRX0vbiR94K+woA3p66USVWvpTglDYzpuJa5RUw/eUHISGUMuv0sbU0JfV0zqC
         7hFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=yxdkcGfQVk3YgliGR9Ok7AI5TvejdPpxVDGMXfDvDmw=;
        b=RUZP290d2QU3UF2QtO5aVBf0oioeWgUlRR24T6PLUQBlQpuVJitzSWkHuan1ZfaO9/
         wa1Eqr6+NzNlFi/BVCD+oEI+Dq5HjUN+qZn1XYZvma5ta280AkuI0Ax0Hn1RPI//uVY6
         IjhL04WVYBn8hGkXjKGUkskTkqxywvidmiDHMffs5cYtIxhYzFMlaf+81MksnpHkMqxd
         KxAtLPiMcIud+u5srZJ4wX/c9+ygec+lju/ZvKLdbX+oP5L6pbTELem+fmvaBXd6VLRd
         GJp8+YFWC3pvQuvM7oYKLMAZ71uuc6FhTvHx4re+VvBjVbfxdNZjLE8pAlojcJ0XOHgA
         5VMA==
X-Gm-Message-State: AOAM530iT6tPN/4kNRZypK2j0gVtTohQq4vjk/aha4yRhIESBzPYsMUJ
        rGpevEsSj/waEWeABkrsedPoHn5VIjkZHoy/
X-Google-Smtp-Source: ABdhPJzT1fEaPTjdNcvOwRImCv1vbb5q/LX7DIW1dRgqYVU2gef6EkgZ9O1T3hEp0DDkhe7umk71Sw==
X-Received: by 2002:a05:6a00:1705:b0:4a0:3492:16c with SMTP id h5-20020a056a00170500b004a03492016cmr21682439pfc.3.1638567956085;
        Fri, 03 Dec 2021 13:45:56 -0800 (PST)
Received: from localhost.localdomain ([66.219.217.159])
        by smtp.gmail.com with ESMTPSA id f4sm4436225pfj.61.2021.12.03.13.45.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Dec 2021 13:45:55 -0800 (PST)
From:   Jens Axboe <axboe@kernel.dk>
To:     linux-block@vger.kernel.org, linux-nvme@lists.infradead.org
Cc:     Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 3/4] nvme: separate command prep and issue
Date:   Fri,  3 Dec 2021 14:45:43 -0700
Message-Id: <20211203214544.343460-4-axboe@kernel.dk>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20211203214544.343460-1-axboe@kernel.dk>
References: <20211203214544.343460-1-axboe@kernel.dk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Add a nvme_prep_rq() helper to setup a command, and nvme_queue_rq() is
adapted to use this helper.

Signed-off-by: Jens Axboe <axboe@kernel.dk>
---
 drivers/nvme/host/pci.c | 57 ++++++++++++++++++++++++-----------------
 1 file changed, 33 insertions(+), 24 deletions(-)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index 09ea21f75439..6be6b1ab4285 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -918,52 +918,32 @@ static blk_status_t nvme_map_metadata(struct nvme_dev *dev, struct request *req,
 	return BLK_STS_OK;
 }
 
-/*
- * NOTE: ns is NULL when called on the admin queue.
- */
-static blk_status_t nvme_queue_rq(struct blk_mq_hw_ctx *hctx,
-			 const struct blk_mq_queue_data *bd)
+static blk_status_t nvme_prep_rq(struct nvme_dev *dev, struct request *req)
 {
-	struct nvme_ns *ns = hctx->queue->queuedata;
-	struct nvme_queue *nvmeq = hctx->driver_data;
-	struct nvme_dev *dev = nvmeq->dev;
-	struct request *req = bd->rq;
 	struct nvme_iod *iod = blk_mq_rq_to_pdu(req);
-	struct nvme_command *cmnd = &iod->cmd;
 	blk_status_t ret;
 
 	iod->aborted = 0;
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
-	ret = nvme_setup_cmd(ns, req);
+	ret = nvme_setup_cmd(req->q->queuedata, req);
 	if (ret)
 		return ret;
 
 	if (blk_rq_nr_phys_segments(req)) {
-		ret = nvme_map_data(dev, req, cmnd);
+		ret = nvme_map_data(dev, req, &iod->cmd);
 		if (ret)
 			goto out_free_cmd;
 	}
 
 	if (blk_integrity_rq(req)) {
-		ret = nvme_map_metadata(dev, req, cmnd);
+		ret = nvme_map_metadata(dev, req, &iod->cmd);
 		if (ret)
 			goto out_unmap_data;
 	}
 
 	blk_mq_start_request(req);
-	nvme_submit_cmd(nvmeq, cmnd, bd->last);
 	return BLK_STS_OK;
 out_unmap_data:
 	nvme_unmap_data(dev, req);
@@ -972,6 +952,35 @@ static blk_status_t nvme_queue_rq(struct blk_mq_hw_ctx *hctx,
 	return ret;
 }
 
+/*
+ * NOTE: ns is NULL when called on the admin queue.
+ */
+static blk_status_t nvme_queue_rq(struct blk_mq_hw_ctx *hctx,
+			 const struct blk_mq_queue_data *bd)
+{
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
+	if (unlikely(!nvme_check_ready(&dev->ctrl, req, true)))
+		return nvme_fail_nonready_command(&dev->ctrl, req);
+
+	ret = nvme_prep_rq(dev, req);
+	if (unlikely(ret))
+		return ret;
+	nvme_submit_cmd(nvmeq, &iod->cmd, bd->last);
+	return BLK_STS_OK;
+}
+
 static __always_inline void nvme_pci_unmap_rq(struct request *req)
 {
 	struct nvme_iod *iod = blk_mq_rq_to_pdu(req);
-- 
2.34.1


Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30E82C43334
	for <linux-block@archiver.kernel.org>; Mon, 27 Jun 2022 23:44:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235245AbiF0XoD (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 27 Jun 2022 19:44:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242290AbiF0XoC (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 27 Jun 2022 19:44:02 -0400
Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0739113D5C
        for <linux-block@vger.kernel.org>; Mon, 27 Jun 2022 16:44:02 -0700 (PDT)
Received: by mail-pj1-f49.google.com with SMTP id g10-20020a17090a708a00b001ea8aadd42bso10964059pjk.0
        for <linux-block@vger.kernel.org>; Mon, 27 Jun 2022 16:44:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ceApt9RGrSOfd7l9Wn70npr+5M+6N/tjqVvDqJkluDs=;
        b=lYv9zpEXJZqsxOpBG3kvC8rjK/iRwQeA711+ssCujjvMMaMAX2rIvndh0FOMgxTOr2
         4nda/VKoRxLBofP9TTDA/RIJAIrXtj3H3cFDiVAa+syfOmrLZPdGDJSHLAd4J3x05fu1
         uxXkDs3Ji4uP5xNhTvx7Ppmb/k6ecI4m7AVu9Sr9HR2qEXoCY+lNrXPSoaocDPZs28gJ
         fi3CyhaR60JApwbcQ9VXQHBeygFHnDILEa/EUFR0yN/iOWmykWctrExpslkUDBw1C+kd
         JkWUlX6nrI9N3De2h4dfBoDFR+mpkBUND1vYbez9ecCfRvsm9Bt07dldBtwJgD/QR/6C
         meWA==
X-Gm-Message-State: AJIora9xCq3bb4uBm7w3SR7bO9b62lkqd90B70p8/cH262/+mdEmpWIY
        vYGPfCNFeUxLfiHktFJXlCo=
X-Google-Smtp-Source: AGRyM1s+j4p08ihRgx9zgRgKfeC7DLJmopqOaEpDTvmQ72R58xJNoDPhTHDm33HfafeX8aoqhYJIPg==
X-Received: by 2002:a17:903:248:b0:168:cf03:eefe with SMTP id j8-20020a170903024800b00168cf03eefemr667420plh.124.1656373441478;
        Mon, 27 Jun 2022 16:44:01 -0700 (PDT)
Received: from bvanassche-linux.mtv.corp.google.com ([2620:15c:211:201:3879:b18f:db0d:205])
        by smtp.gmail.com with ESMTPSA id md6-20020a17090b23c600b001e305f5cd22sm7907456pjb.47.2022.06.27.16.44.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Jun 2022 16:44:00 -0700 (PDT)
From:   Bart Van Assche <bvanassche@acm.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Jaegeuk Kim <jaegeuk@kernel.org>,
        Bart Van Assche <bvanassche@acm.org>,
        Keith Busch <kbusch@kernel.org>,
        Sagi Grimberg <sagi@grimberg.me>,
        Chaitanya Kulkarni <kch@nvidia.com>
Subject: [PATCH v3 8/8] nvme: Enable pipelining of zoned writes
Date:   Mon, 27 Jun 2022 16:43:35 -0700
Message-Id: <20220627234335.1714393-9-bvanassche@acm.org>
X-Mailer: git-send-email 2.37.0.rc0.161.g10f37bed90-goog
In-Reply-To: <20220627234335.1714393-1-bvanassche@acm.org>
References: <20220627234335.1714393-1-bvanassche@acm.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Enabling pipelining for zoned writes. Increase the number of retries
for zoned writes to the maximum number of outstanding commands per hardware
queue.

Cc: Christoph Hellwig <hch@lst.de>
Cc: Keith Busch <kbusch@kernel.org>
Cc: Sagi Grimberg <sagi@grimberg.me>
Cc: Chaitanya Kulkarni <kch@nvidia.com>
Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
 drivers/nvme/host/core.c | 6 ++++++
 drivers/nvme/host/zns.c  | 2 ++
 2 files changed, 8 insertions(+)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index df9ac7fab9b8..3f71d3d82d5e 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -854,6 +854,12 @@ static inline blk_status_t nvme_setup_rw(struct nvme_ns *ns,
 	if (req->cmd_flags & REQ_RAHEAD)
 		dsmgmt |= NVME_RW_DSM_FREQ_PREFETCH;
 
+	if (blk_queue_pipeline_zoned_writes(req->q) &&
+	    blk_rq_is_seq_zone_write(req))
+		nvme_req(req)->max_retries =
+			min(0UL + type_max(typeof(nvme_req(req)->max_retries)),
+			    nvme_req(req)->max_retries + req->q->nr_requests);
+
 	cmnd->rw.opcode = op;
 	cmnd->rw.flags = 0;
 	cmnd->rw.nsid = cpu_to_le32(ns->head->ns_id);
diff --git a/drivers/nvme/host/zns.c b/drivers/nvme/host/zns.c
index 9f81beb4df4e..0b10db3b8d3a 100644
--- a/drivers/nvme/host/zns.c
+++ b/drivers/nvme/host/zns.c
@@ -54,6 +54,8 @@ int nvme_update_zone_info(struct nvme_ns *ns, unsigned lbaf)
 	struct nvme_id_ns_zns *id;
 	int status;
 
+	blk_queue_flag_set(QUEUE_FLAG_PIPELINE_ZONED_WRITES, ns->queue);
+
 	/* Driver requires zone append support */
 	if ((le32_to_cpu(log->iocs[nvme_cmd_zone_append]) &
 			NVME_CMD_EFFECTS_CSUPP)) {

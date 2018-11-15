Return-Path: <SRS0=/6aj=N2=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C031C04EBF
	for <linux-block@archiver.kernel.org>; Thu, 15 Nov 2018 19:51:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4E0BA2146D
	for <linux-block@archiver.kernel.org>; Thu, 15 Nov 2018 19:51:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="fPbbJdb5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4E0BA2146D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726007AbeKPGAz (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 16 Nov 2018 01:00:55 -0500
Received: from mail-pl1-f194.google.com ([209.85.214.194]:44896 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725869AbeKPGAz (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 16 Nov 2018 01:00:55 -0500
Received: by mail-pl1-f194.google.com with SMTP id s5-v6so9953079plq.11
        for <linux-block@vger.kernel.org>; Thu, 15 Nov 2018 11:51:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=0hpfobUzk41/y0GfZii9AW4JlRiFqpFtiDvsBHwkxOc=;
        b=fPbbJdb5dG26CtmSNiv9jIF/ybkn5kvrIbkQ7Hb3ywOwbBDLBW1w9ME7KkA066yZU8
         73cQUG/NaRLNBaF0gAvwE9+AOZtccInaU3yHFuWpmv3U7dL5G/zXg40KXOug1+NVmI4x
         vZipoW4XoypuWBAVDSUlVL49gXUnsifEYSvNKZDAnb2EVy8gEN3eoHSNdNrF93va81FU
         J4waZl9FjH+uh8rF4hUSyyXDsvGtzZfEMjhylmwSz4gSUx46RyFXF14zCUeoO2F7ItZb
         nJUYl0APvaLiX4zHPIyJziegBCt863QBb5NAg/SqxXLCzBb5rpJjALWqNh4r2kgmQLNe
         fccA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=0hpfobUzk41/y0GfZii9AW4JlRiFqpFtiDvsBHwkxOc=;
        b=JcWkUUpTy+AH/Oh0Fi4ciXNJqf/BcEFB1tg7XTnt3o30BqEyCd7it3jOOfscUu2vbL
         Sk6mRIKd55ScBMb9sJdksjTnjFP9KAe8FuW8Vg35BfDe9a1wkNH5CO7av3ozLUy5tBRA
         MLA0sdXKxaUPCb5tujKas38NoibX9f9IUX5XbVezEDqMKV2um2BilbcLvjXjEmqLOufN
         SM20uwYV2JRynlnMUM3XsctLf7fbP68910pWIXMAF8dWyHPX6oQIarqJ9y1EJI0kkflj
         qTdDza1qmHsd6gxGoDPnHcVMBYduopG+Bu7vuzD2AAq7Pfq/8u7jEAxnApaE6kRYO3W9
         7Xxg==
X-Gm-Message-State: AGRZ1gJYq8//OK2moKhoES7GPZhJ5YqgeGBQ3U1kcjMQf9t4y8zmmgAp
        gmatA1CKa+zM7/VcnrikyuCxOTQmwzo=
X-Google-Smtp-Source: AJdET5c+6kGIFk5Ui7lrL4XTmHob0BxE7zGNpFulsQkrBsnN6O0S3rjVdpaHUXtM+fgAwKLoRcEUZw==
X-Received: by 2002:a17:902:8210:: with SMTP id x16-v6mr7703705pln.129.1542311502562;
        Thu, 15 Nov 2018 11:51:42 -0800 (PST)
Received: from x1.localdomain ([2620:10d:c090:180::1:7813])
        by smtp.gmail.com with ESMTPSA id d68-v6sm30670766pfa.80.2018.11.15.11.51.41
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 15 Nov 2018 11:51:41 -0800 (PST)
From:   Jens Axboe <axboe@kernel.dk>
To:     linux-block@vger.kernel.org
Cc:     Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 01/11] nvme: provide optimized poll function for separate poll queues
Date:   Thu, 15 Nov 2018 12:51:25 -0700
Message-Id: <20181115195135.22812-2-axboe@kernel.dk>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181115195135.22812-1-axboe@kernel.dk>
References: <20181115195135.22812-1-axboe@kernel.dk>
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

If we have separate poll queues, we know that they aren't using
interrupts. Hence we don't need to disable interrupts around
finding completions.

Provide a separate set of blk_mq_ops for such devices.

Signed-off-by: Jens Axboe <axboe@kernel.dk>
---
 drivers/nvme/host/pci.c | 45 +++++++++++++++++++++++++++++++++--------
 1 file changed, 37 insertions(+), 8 deletions(-)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index ffbab5b01df4..fc7dd49f22fc 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -1082,6 +1082,23 @@ static int nvme_poll(struct blk_mq_hw_ctx *hctx, unsigned int tag)
 	return __nvme_poll(nvmeq, tag);
 }
 
+static int nvme_poll_noirq(struct blk_mq_hw_ctx *hctx, unsigned int tag)
+{
+	struct nvme_queue *nvmeq = hctx->driver_data;
+	u16 start, end;
+	bool found;
+
+	if (!nvme_cqe_pending(nvmeq))
+		return 0;
+
+	spin_lock(&nvmeq->cq_lock);
+	found = nvme_process_cq(nvmeq, &start, &end, tag);
+	spin_unlock(&nvmeq->cq_lock);
+
+	nvme_complete_cqes(nvmeq, start, end);
+	return found;
+}
+
 static void nvme_pci_submit_async_event(struct nvme_ctrl *ctrl)
 {
 	struct nvme_dev *dev = to_nvme_dev(ctrl);
@@ -1584,17 +1601,25 @@ static const struct blk_mq_ops nvme_mq_admin_ops = {
 	.timeout	= nvme_timeout,
 };
 
+#define NVME_SHARED_MQ_OPS					\
+	.queue_rq		= nvme_queue_rq,		\
+	.rq_flags_to_type	= nvme_rq_flags_to_type,	\
+	.complete		= nvme_pci_complete_rq,		\
+	.init_hctx		= nvme_init_hctx,		\
+	.init_request		= nvme_init_request,		\
+	.map_queues		= nvme_pci_map_queues,		\
+	.timeout		= nvme_timeout			\
+
 static const struct blk_mq_ops nvme_mq_ops = {
-	.queue_rq		= nvme_queue_rq,
-	.rq_flags_to_type	= nvme_rq_flags_to_type,
-	.complete		= nvme_pci_complete_rq,
-	.init_hctx		= nvme_init_hctx,
-	.init_request		= nvme_init_request,
-	.map_queues		= nvme_pci_map_queues,
-	.timeout		= nvme_timeout,
+	NVME_SHARED_MQ_OPS,
 	.poll			= nvme_poll,
 };
 
+static const struct blk_mq_ops nvme_mq_poll_noirq_ops = {
+	NVME_SHARED_MQ_OPS,
+	.poll			= nvme_poll_noirq,
+};
+
 static void nvme_dev_remove_admin(struct nvme_dev *dev)
 {
 	if (dev->ctrl.admin_q && !blk_queue_dying(dev->ctrl.admin_q)) {
@@ -2274,7 +2299,11 @@ static int nvme_dev_add(struct nvme_dev *dev)
 	int ret;
 
 	if (!dev->ctrl.tagset) {
-		dev->tagset.ops = &nvme_mq_ops;
+		if (!dev->io_queues[NVMEQ_TYPE_POLL])
+			dev->tagset.ops = &nvme_mq_ops;
+		else
+			dev->tagset.ops = &nvme_mq_poll_noirq_ops;
+
 		dev->tagset.nr_hw_queues = dev->online_queues - 1;
 		dev->tagset.nr_maps = NVMEQ_TYPE_NR;
 		dev->tagset.timeout = NVME_IO_TIMEOUT;
-- 
2.17.1


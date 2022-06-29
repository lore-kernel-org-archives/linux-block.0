Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E0D7C43334
	for <linux-block@archiver.kernel.org>; Wed, 29 Jun 2022 23:32:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231750AbiF2Xcx (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 29 Jun 2022 19:32:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231751AbiF2Xcw (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 29 Jun 2022 19:32:52 -0400
Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com [209.85.215.180])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3EC6EB01
        for <linux-block@vger.kernel.org>; Wed, 29 Jun 2022 16:32:51 -0700 (PDT)
Received: by mail-pg1-f180.google.com with SMTP id g4so9873413pgc.1
        for <linux-block@vger.kernel.org>; Wed, 29 Jun 2022 16:32:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=MsuDrlglTldATXN5yZHoI6n9Um+aaa9KCl2srCU7X2A=;
        b=40n5EbF8xhyG4yfT2oTNnpy0m2BmjRo8xp1M5WUpcj5meqvClDb+60VnQ5wsLjuq7I
         SJSNsxHivcHV+GnVnv8/Dh1Zz5/QR1CiHwgZ7aTJ+Pz+9Kbq7nTBGEEqGrY1K+7nYGuj
         TI6/LXM+BC8ECJ4iyr13kR9JbylhsYvyAoeoJSLX4M3n5WLvkXAHSQKLyliRu7GIcNF3
         l06Q40nSyUbiT2zAiQBnrcPqYs55KzMG+/XlyyxPmVKaKbRgzTgeUr+Fele50TQgPWkp
         Py0upDhFzP/1KnTogOAC2ybjGjiStqzEsQduhnhuO7DLKdC99FVUieMQgMQd/w1DXbUo
         5Kqw==
X-Gm-Message-State: AJIora/1xcKpw2/LGLBZO197tB9rYRKsGYin56EnoUDZTJ2a+MIA/sWX
        6nEeIvfn3fpuX0rG/1xE5GA=
X-Google-Smtp-Source: AGRyM1t8+jQwV9En26kXrojPRTLH/7ssSgrXKzji8tNUgMSJqqNSSUuWL2Gas8LPhKE7ssNZr59UVg==
X-Received: by 2002:a65:6d08:0:b0:3c6:8a08:3b9f with SMTP id bf8-20020a656d08000000b003c68a083b9fmr4922191pgb.147.1656545570580;
        Wed, 29 Jun 2022 16:32:50 -0700 (PDT)
Received: from bvanassche-linux.mtv.corp.google.com ([2620:15c:211:201:3841:49ce:cba5:1586])
        by smtp.gmail.com with ESMTPSA id b21-20020a17090a8c9500b001ec8d191db4sm2763687pjo.17.2022.06.29.16.32.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Jun 2022 16:32:49 -0700 (PDT)
From:   Bart Van Assche <bvanassche@acm.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Bart Van Assche <bvanassche@acm.org>,
        Keith Busch <kbusch@kernel.org>,
        Sagi Grimberg <sagi@grimberg.me>
Subject: [PATCH v2 37/63] nvme/host: Use the enum req_op and blk_opf_t types
Date:   Wed, 29 Jun 2022 16:31:19 -0700
Message-Id: <20220629233145.2779494-38-bvanassche@acm.org>
X-Mailer: git-send-email 2.37.0.rc0.161.g10f37bed90-goog
In-Reply-To: <20220629233145.2779494-1-bvanassche@acm.org>
References: <20220629233145.2779494-1-bvanassche@acm.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Improve static type checking by using the enum req_op type for variables
that represent a request operation and the new blk_opf_t type for
variables that represent request flags.

Cc: Christoph Hellwig <hch@lst.de>
Cc: Keith Busch <kbusch@kernel.org>
Reviewed-by: Sagi Grimberg <sagi@grimberg.me>
Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
 drivers/nvme/host/ioctl.c | 4 ++--
 drivers/nvme/host/nvme.h  | 2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/nvme/host/ioctl.c b/drivers/nvme/host/ioctl.c
index a2e89db1cd63..27614bee7380 100644
--- a/drivers/nvme/host/ioctl.c
+++ b/drivers/nvme/host/ioctl.c
@@ -68,7 +68,7 @@ static struct request *nvme_alloc_user_request(struct request_queue *q,
 		struct nvme_command *cmd, void __user *ubuffer,
 		unsigned bufflen, void __user *meta_buffer, unsigned meta_len,
 		u32 meta_seed, void **metap, unsigned timeout, bool vec,
-		unsigned int rq_flags, blk_mq_req_flags_t blk_flags)
+		blk_opf_t rq_flags, blk_mq_req_flags_t blk_flags)
 {
 	bool write = nvme_is_write(cmd);
 	struct nvme_ns *ns = q->queuedata;
@@ -407,7 +407,7 @@ static int nvme_uring_cmd_io(struct nvme_ctrl *ctrl, struct nvme_ns *ns,
 	struct nvme_uring_data d;
 	struct nvme_command c;
 	struct request *req;
-	unsigned int rq_flags = 0;
+	blk_opf_t rq_flags = 0;
 	blk_mq_req_flags_t blk_flags = 0;
 	void *meta = NULL;
 
diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
index 0da94b233fed..ac9753674d5d 100644
--- a/drivers/nvme/host/nvme.h
+++ b/drivers/nvme/host/nvme.h
@@ -733,7 +733,7 @@ void nvme_wait_freeze(struct nvme_ctrl *ctrl);
 int nvme_wait_freeze_timeout(struct nvme_ctrl *ctrl, long timeout);
 void nvme_start_freeze(struct nvme_ctrl *ctrl);
 
-static inline unsigned int nvme_req_op(struct nvme_command *cmd)
+static inline enum req_op nvme_req_op(struct nvme_command *cmd)
 {
 	return nvme_is_write(cmd) ? REQ_OP_DRV_OUT : REQ_OP_DRV_IN;
 }

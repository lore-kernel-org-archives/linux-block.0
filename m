Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5262EC43334
	for <linux-block@archiver.kernel.org>; Thu, 14 Jul 2022 18:08:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240490AbiGNSIq (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 14 Jul 2022 14:08:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240157AbiGNSIl (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 14 Jul 2022 14:08:41 -0400
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A259625D
        for <linux-block@vger.kernel.org>; Thu, 14 Jul 2022 11:08:37 -0700 (PDT)
Received: by mail-pf1-f177.google.com with SMTP id c3so1632649pfb.13
        for <linux-block@vger.kernel.org>; Thu, 14 Jul 2022 11:08:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=et+6DI1XNIN9zeCPd6kPaGWeoMf/UUtfYFmY+mfNbrs=;
        b=DoQr/eohg84YPM6/+zAgkOa3OD2kxGWqJpd4R7LnJIoyyB5KMXJmgIhgi8L/ViLzWO
         Yvo3R3PTBnN5LSwM+0HMbYlRFE6uEL4HBMCMalncBQ8nUxSGr/TQSfD9u2dpp7Y4SU73
         DuyN8nLyEM/4oYf+3a8I+xf4cdOM8TKKzihCG01xQrCMEUBs9DyDKu0xiLNWm9tCEDx6
         q+iWa/p9LxUexwUi13uUK09wfcYwPWRh9jaeQsI0NSa9tyDfXX/yclMolZ7xBfu59Z/u
         9f1DSOxqyhHNjP47Gc3smCcDrb6D2nMCSJ7P9wPI8xcM3YhG8M/hX2aSH35W2W8TGI93
         589g==
X-Gm-Message-State: AJIora95kRv4csScUi62Y5SUdx5uBC0T5IdmZpFbQWxkLkaJlZTNFmu5
        Fjsa8CraKlSgd/tKWa83Zms=
X-Google-Smtp-Source: AGRyM1tYqOdBtPyxZASxOpLLZoolhXgtfDo4ERvQat/KlACDjh12kzoM2WtyZcSPDL7cIl5ZdX3Xhg==
X-Received: by 2002:a63:91c3:0:b0:419:b004:a99b with SMTP id l186-20020a6391c3000000b00419b004a99bmr4460921pge.331.1657822116260;
        Thu, 14 Jul 2022 11:08:36 -0700 (PDT)
Received: from bvanassche-linux.mtv.corp.google.com ([2620:15c:211:201:9fab:70d1:f0e7:922b])
        by smtp.gmail.com with ESMTPSA id m5-20020a170902db0500b0016bebb0cb96sm1781846plx.266.2022.07.14.11.08.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Jul 2022 11:08:35 -0700 (PDT)
From:   Bart Van Assche <bvanassche@acm.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Jaegeuk Kim <jaegeuk@kernel.org>,
        Bart Van Assche <bvanassche@acm.org>,
        Sagi Grimberg <sagi@grimberg.me>,
        Keith Busch <kbusch@kernel.org>
Subject: [PATCH v3 37/63] nvme/host: Use the enum req_op and blk_opf_t types
Date:   Thu, 14 Jul 2022 11:07:03 -0700
Message-Id: <20220714180729.1065367-38-bvanassche@acm.org>
X-Mailer: git-send-email 2.37.0.170.g444d1eabd0-goog
In-Reply-To: <20220714180729.1065367-1-bvanassche@acm.org>
References: <20220714180729.1065367-1-bvanassche@acm.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Improve static type checking by using the enum req_op type for variables
that represent a request operation and the new blk_opf_t type for
variables that represent request flags.

Reviewed-by: Sagi Grimberg <sagi@grimberg.me>
Cc: Christoph Hellwig <hch@lst.de>
Cc: Keith Busch <kbusch@kernel.org>
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
index e4daa57f8bd5..f453e816426a 100644
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

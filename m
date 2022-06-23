Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4EA4FCCA480
	for <linux-block@archiver.kernel.org>; Thu, 23 Jun 2022 19:01:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230450AbiFWTBP (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 23 Jun 2022 15:01:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232012AbiFWTBD (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 23 Jun 2022 15:01:03 -0400
Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8DDA113B
        for <linux-block@vger.kernel.org>; Thu, 23 Jun 2022 11:06:17 -0700 (PDT)
Received: by mail-pj1-f44.google.com with SMTP id g10-20020a17090a708a00b001ea8aadd42bso397230pjk.0
        for <linux-block@vger.kernel.org>; Thu, 23 Jun 2022 11:06:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=nPiIisWhrYnmyGWGAYEgmzeS55+iM33aJpih0eJ3hLk=;
        b=Zmfzo5vlf6qx2MFwmN48sbYHjtyqxd3eVb/6r8PH2glKDE0okz1umK1gr7fa1pmNDq
         hn44F4AsuCQ6iBz203MO/afe+BtqROwHxpU6fHok/tuPZBrDNNnewopMeeRt5nM4HINe
         40yZK6L+yCe+N2bc+O5ovh1HV9Oa686e7ufFYy2hH6McAVagWUAd1YSG6zBlK8hkjY6j
         QgLXWOTY/HSVkexauy5TJjgkXIO3eznx0np9/fXOazbwMaZGSeojjO/kBR4pE2WoB46f
         XSF1LmzcbqNoz9x3RPneF2PYCTQG21qMThNlDFP0EZ4l0iFO4Q1b+8Zd22LNHoo169Pp
         byMg==
X-Gm-Message-State: AJIora+qizyfz5msC8v+XB4KneMB3Ao4qz1yVN5S7V0s7l8Co+Vi4gkf
        hC/9fo7WkFxpDFAecxdJf1M=
X-Google-Smtp-Source: AGRyM1tgc/AVS4LJH3As739nMsZIbl8TeefkCnXpkBgmcBmGPuiv2HczH9M94080nbP9pqec9JgImw==
X-Received: by 2002:a17:90a:2e02:b0:1ea:c661:7507 with SMTP id q2-20020a17090a2e0200b001eac6617507mr5235072pjd.133.1656007576914;
        Thu, 23 Jun 2022 11:06:16 -0700 (PDT)
Received: from bvanassche-linux.mtv.corp.google.com ([2620:15c:211:201:70af:1dc5:d20:a563])
        by smtp.gmail.com with ESMTPSA id a18-20020a056a000c9200b0051c4ecb0e3dsm16019967pfv.193.2022.06.23.11.06.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Jun 2022 11:06:16 -0700 (PDT)
From:   Bart Van Assche <bvanassche@acm.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Bart Van Assche <bvanassche@acm.org>,
        Keith Busch <kbusch@kernel.org>,
        Sagi Grimberg <sagi@grimberg.me>
Subject: [PATCH 27/51] nvme/host: Use the enum req_op and blk_opf_t types
Date:   Thu, 23 Jun 2022 11:05:04 -0700
Message-Id: <20220623180528.3595304-28-bvanassche@acm.org>
X-Mailer: git-send-email 2.37.0.rc0.161.g10f37bed90-goog
In-Reply-To: <20220623180528.3595304-1-bvanassche@acm.org>
References: <20220623180528.3595304-1-bvanassche@acm.org>
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
Cc: Sagi Grimberg <sagi@grimberg.me>
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

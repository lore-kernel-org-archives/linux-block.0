Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7926C433EF
	for <linux-block@archiver.kernel.org>; Thu, 23 Jun 2022 19:01:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231838AbiFWTBR (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 23 Jun 2022 15:01:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232020AbiFWTBF (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 23 Jun 2022 15:01:05 -0400
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09AFA10E64E
        for <linux-block@vger.kernel.org>; Thu, 23 Jun 2022 11:06:19 -0700 (PDT)
Received: by mail-pl1-f178.google.com with SMTP id c4so2629850plc.8
        for <linux-block@vger.kernel.org>; Thu, 23 Jun 2022 11:06:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=XJ/sGb3XCWvOZL3qB6wyTMEmWtH7m2nEWJDejHsFgow=;
        b=agLaak4HV2sp0t3t0d8Dvrlhh/zT5/XDpuI/DqKICs2u/Yk2xtwgppgBy6MUqpe/R5
         myLYNpocrmIRwmoNZJm5DXgushQVhxmuasBxZGyBSPJYworvCo67G9QzE20T3E44AS9h
         iv4vTmR8Bh5bK77j9jojB5BnTzv8wBuEiZ1f8GYYLpo0CJ7sZbYWwAiTY7glPB8VYv9E
         Lcu0wDyTQr3IfgQgZtZlhjdpU+DdXRD+/wIY0M7GVxONPvcLw5q0BVQTNg7rRxFtPVxF
         8GTI89zcIu6SnybSpv1RPiFsaxHm4mW03v5ByHa/9TEzM0HMLfNCkORITpxDeJk+BsQY
         Cfmg==
X-Gm-Message-State: AJIora/VLqYq/Qa+dTAwi9C2gvuEJckfxetOL3u2oii6gfBx5+KP+5l1
        MJKhrXeh7uTjG4sL1W34FqNvDUAIBpg=
X-Google-Smtp-Source: AGRyM1ucaitJsUNXBveRefrZ+IgyKLhnXp216Irm/sIZWm1Q2dykhFqe2w3rsNXVd/6bGC5rSy+zOQ==
X-Received: by 2002:a17:90b:3849:b0:1e8:7f47:5dcd with SMTP id nl9-20020a17090b384900b001e87f475dcdmr5136891pjb.61.1656007578668;
        Thu, 23 Jun 2022 11:06:18 -0700 (PDT)
Received: from bvanassche-linux.mtv.corp.google.com ([2620:15c:211:201:70af:1dc5:d20:a563])
        by smtp.gmail.com with ESMTPSA id a18-20020a056a000c9200b0051c4ecb0e3dsm16019967pfv.193.2022.06.23.11.06.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Jun 2022 11:06:17 -0700 (PDT)
From:   Bart Van Assche <bvanassche@acm.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Bart Van Assche <bvanassche@acm.org>,
        Sagi Grimberg <sagi@grimberg.me>,
        Chaitanya Kulkarni <kch@nvidia.com>
Subject: [PATCH 28/51] nvme/target: Use the new blk_opf_t type
Date:   Thu, 23 Jun 2022 11:05:05 -0700
Message-Id: <20220623180528.3595304-29-bvanassche@acm.org>
X-Mailer: git-send-email 2.37.0.rc0.161.g10f37bed90-goog
In-Reply-To: <20220623180528.3595304-1-bvanassche@acm.org>
References: <20220623180528.3595304-1-bvanassche@acm.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Improve static type checking by using the new blk_opf_t type for variables
that represent a request operation combined with request flags.

Cc: Christoph Hellwig <hch@lst.de>
Cc: Sagi Grimberg <sagi@grimberg.me>
Cc: Chaitanya Kulkarni <kch@nvidia.com>
Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
 drivers/nvme/target/io-cmd-bdev.c | 3 ++-
 drivers/nvme/target/zns.c         | 2 +-
 2 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/nvme/target/io-cmd-bdev.c b/drivers/nvme/target/io-cmd-bdev.c
index 27a72504d31c..306d97b3840f 100644
--- a/drivers/nvme/target/io-cmd-bdev.c
+++ b/drivers/nvme/target/io-cmd-bdev.c
@@ -246,7 +246,8 @@ static void nvmet_bdev_execute_rw(struct nvmet_req *req)
 	struct scatterlist *sg;
 	struct blk_plug plug;
 	sector_t sector;
-	int op, i, rc;
+	blk_opf_t op;
+	int i, rc;
 	struct sg_mapping_iter prot_miter;
 	unsigned int iter_flags;
 	unsigned int total_len = nvmet_rw_data_len(req) + req->metadata_len;
diff --git a/drivers/nvme/target/zns.c b/drivers/nvme/target/zns.c
index 62afb7936132..c5e315d57d60 100644
--- a/drivers/nvme/target/zns.c
+++ b/drivers/nvme/target/zns.c
@@ -525,7 +525,7 @@ static void nvmet_bdev_zone_append_bio_done(struct bio *bio)
 void nvmet_bdev_execute_zone_append(struct nvmet_req *req)
 {
 	sector_t sect = nvmet_lba_to_sect(req->ns, req->cmd->rw.slba);
-	const unsigned int op = REQ_OP_ZONE_APPEND | REQ_SYNC | REQ_IDLE;
+	const blk_opf_t op = REQ_OP_ZONE_APPEND | REQ_SYNC | REQ_IDLE;
 	u16 status = NVME_SC_SUCCESS;
 	unsigned int total_len = 0;
 	struct scatterlist *sg;

Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7D4DC43334
	for <linux-block@archiver.kernel.org>; Wed, 29 Jun 2022 23:32:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231766AbiF2Xc4 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 29 Jun 2022 19:32:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231758AbiF2Xcz (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 29 Jun 2022 19:32:55 -0400
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF1C326D1
        for <linux-block@vger.kernel.org>; Wed, 29 Jun 2022 16:32:52 -0700 (PDT)
Received: by mail-pl1-f178.google.com with SMTP id d5so15453300plo.12
        for <linux-block@vger.kernel.org>; Wed, 29 Jun 2022 16:32:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=9nB+b3sawa9+dXj5osXQwfjyPpgG1+PP1Zw9EPYTCuc=;
        b=dQB6DPcnJj+BTU/3FvO9yxYK0rwJDPvaIiwikrkZGdP4VF+JyKmpcM3ECqEuWsIy3B
         gAdBHDbIJ4uwF10iN0vAl9QP8VPsmHSjIdbu5c1IXtVohmgY9UFF4Oedbho4UH30bQff
         qADRw/JINUf9cvxCda4k9BBvHlsVANwVk58ZJmOhwyhney7HbKO0VEw20KHl1HTejArs
         dHIl/eQgUg97FCZaUi/69O7jT1B6/YOOnAkD+WGts4SyCTrOn7K7hIf9/pOyyUVFeNk6
         rHWGbmUpGYHkWI3tJ7Q5HicqlS5IuXMd+VUVx10MqVMFlGJCNwrqG/E6GLEybS+xxJ1u
         px8w==
X-Gm-Message-State: AJIora9z1GS8LssxqTZooMsH+g2uZeas+C6ziZyZk/vXFdyXQqRCPv+2
        rmL9vcoHS7CK7kHuSt8BF58=
X-Google-Smtp-Source: AGRyM1s6DftXL50fufzAVZTdgutWU89MvJ5W94x6TA7eIq1rBz+DQhIzDevzFjSMusobkOhyjn8rFA==
X-Received: by 2002:a17:903:2447:b0:16a:3b58:48dd with SMTP id l7-20020a170903244700b0016a3b5848ddmr13030824pls.120.1656545572076;
        Wed, 29 Jun 2022 16:32:52 -0700 (PDT)
Received: from bvanassche-linux.mtv.corp.google.com ([2620:15c:211:201:3841:49ce:cba5:1586])
        by smtp.gmail.com with ESMTPSA id b21-20020a17090a8c9500b001ec8d191db4sm2763687pjo.17.2022.06.29.16.32.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Jun 2022 16:32:51 -0700 (PDT)
From:   Bart Van Assche <bvanassche@acm.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Bart Van Assche <bvanassche@acm.org>,
        Sagi Grimberg <sagi@grimberg.me>,
        Chaitanya Kulkarni <kch@nvidia.com>
Subject: [PATCH v2 38/63] nvme/target: Use the new blk_opf_t type
Date:   Wed, 29 Jun 2022 16:31:20 -0700
Message-Id: <20220629233145.2779494-39-bvanassche@acm.org>
X-Mailer: git-send-email 2.37.0.rc0.161.g10f37bed90-goog
In-Reply-To: <20220629233145.2779494-1-bvanassche@acm.org>
References: <20220629233145.2779494-1-bvanassche@acm.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Improve static type checking by using the new blk_opf_t type for variables
that represent a request operation combined with request flags.

Cc: Christoph Hellwig <hch@lst.de>
Reviewed-by: Sagi Grimberg <sagi@grimberg.me>
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

Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7E03C001E0
	for <linux-block@archiver.kernel.org>; Wed, 19 Jul 2023 18:23:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229601AbjGSSXS (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 19 Jul 2023 14:23:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229525AbjGSSXR (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 19 Jul 2023 14:23:17 -0400
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4011B6
        for <linux-block@vger.kernel.org>; Wed, 19 Jul 2023 11:23:16 -0700 (PDT)
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-1bb1baf55f5so44507715ad.0
        for <linux-block@vger.kernel.org>; Wed, 19 Jul 2023 11:23:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689790996; x=1692382996;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QC6pt/SvGlEEBPsJW6GWFPvxw3EFvrXnyNrPZICgHZg=;
        b=XkqoYNn/fofwCnmoIo3CKbn04qc3tXgmFi9MAN6Ohjul6MP1d8IVUUEyDtyjeSsWUA
         GbxYPthK81qCiKNul7zkPOlCu1vNJ6sfNswww2+GpJzCaTSqNzXo+vtILudZrUc/y/uj
         gNLte4Plm+Ib0BwcW3dnd5rHsNhDxyrQZeabvSswcvhGHhN4UxxQHc5HSY2Cvg8OHBgS
         zeyeC3U57+Hmc9u382baK6T8Hsancrl+lK8df2aNT6osSr24SmHgVeKHRi+40xw0hBFH
         S8hy85IKWWP0M+Zs9gxaPRS29vNQV/E1r0lNQykdEj1TX1WnBggSmRC/bAVIHbJ+hwMJ
         kMEg==
X-Gm-Message-State: ABy/qLbmQAtW12magd7OmXXsN33HJ+v0LF+JqF2q8X/LRzOSAOUm0TpV
        o8I02NkcPShG1y+lGjX1ysk=
X-Google-Smtp-Source: APBJJlGrFo5pEATgnKVlxpj4un8c+3FKfrTdqmc7skgXyJRhauljCvmYYuzKu20YLwCWWyPr/Lef9w==
X-Received: by 2002:a17:902:6a8c:b0:1b8:90bd:d157 with SMTP id n12-20020a1709026a8c00b001b890bdd157mr19345582plk.26.1689790996075;
        Wed, 19 Jul 2023 11:23:16 -0700 (PDT)
Received: from bvanassche-linux.mtv.corp.google.com ([2620:15c:211:201:a2ab:183f:c76c:d30d])
        by smtp.gmail.com with ESMTPSA id l16-20020a170903245000b001bb33ee4057sm4316061pls.43.2023.07.19.11.23.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Jul 2023 11:23:15 -0700 (PDT)
From:   Bart Van Assche <bvanassche@acm.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        Bart Van Assche <bvanassche@acm.org>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>
Subject: [PATCH v2 2/3] scsi: Remove a blk_mq_run_hw_queues() call
Date:   Wed, 19 Jul 2023 11:22:41 -0700
Message-ID: <20230719182243.2810134-3-bvanassche@acm.org>
X-Mailer: git-send-email 2.41.0.255.g8b1d071c50-goog
In-Reply-To: <20230719182243.2810134-1-bvanassche@acm.org>
References: <20230719182243.2810134-1-bvanassche@acm.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

blk_mq_kick_requeue_list() calls blk_mq_run_hw_queues() asynchronously.
Leave out the direct blk_mq_run_hw_queues() call. This patch causes
scsi_run_queue() to call blk_mq_run_hw_queues() asynchronously instead
of synchronously. Since scsi_run_queue() is not called from the hot I/O
submission path, this patch does not affect the hot path.

Cc: Martin K. Petersen <martin.petersen@oracle.com>
Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
 drivers/scsi/scsi_lib.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/scsi/scsi_lib.c b/drivers/scsi/scsi_lib.c
index 414d29eef968..7043ca0f4da9 100644
--- a/drivers/scsi/scsi_lib.c
+++ b/drivers/scsi/scsi_lib.c
@@ -448,7 +448,6 @@ static void scsi_run_queue(struct request_queue *q)
 		scsi_starved_list_run(sdev->host);
 
 	blk_mq_kick_requeue_list(q);
-	blk_mq_run_hw_queues(q, false);
 }
 
 void scsi_requeue_run_queue(struct work_struct *work)

Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A97B7EB64DD
	for <linux-block@archiver.kernel.org>; Fri, 21 Jul 2023 17:27:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229666AbjGUR16 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 21 Jul 2023 13:27:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231436AbjGUR1r (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 21 Jul 2023 13:27:47 -0400
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6ECE2691
        for <linux-block@vger.kernel.org>; Fri, 21 Jul 2023 10:27:46 -0700 (PDT)
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-1b9c5e07c1bso15885465ad.2
        for <linux-block@vger.kernel.org>; Fri, 21 Jul 2023 10:27:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689960466; x=1690565266;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=h7dUGph6KIS4p9U3dJ8rki0dAWEfQbKjpTjsDAOxcZs=;
        b=BAxDgggvbWOUQkDin3kFreEjz15zd5NtSt6iKCf31Avo/dLl8AaHJUrURPbG5/tQkw
         UYW4xD1ZNsbYL/d+MpdRFI8ZfjRLhHyVYUh/p247udULTQC9sldlYzwEomEE3khx7NWf
         pjydKwJF3dM1Fil4lG4gj6u1Sak8d1tyKUjj/VTrZCuWWnvgKeuLIdscWNIOSRGYrs3i
         i/RWihd6zKOkYW7shOB0BZ5rBUsOm/zBQnhnmT6h6G6K2RpAfNzX6RXHajEcTIU+Fr4b
         bEvVwy6eJaJWuqJ/M3ho46ArJAutKBEaVNv+jMs70AWDU7cMLhop+BDOZDNRaZq/1snj
         nRyQ==
X-Gm-Message-State: ABy/qLY9fSRvU6YBmsuRaGHTqkOTj6rIywWutFCbWPSoyWrVomDzt2PG
        M07teQHzV/sOn/tAwzGI8b8=
X-Google-Smtp-Source: APBJJlGfZ15ECYmRE2pAKvtY8EImCZkSL3Em0sZQulPsQMzF1gtFpVYRpIqJO4y3DUC4KNG3K9OqLg==
X-Received: by 2002:a17:902:e844:b0:1b6:6e3a:77fb with SMTP id t4-20020a170902e84400b001b66e3a77fbmr3112423plg.2.1689960465977;
        Fri, 21 Jul 2023 10:27:45 -0700 (PDT)
Received: from bvanassche-linux.mtv.corp.google.com ([2620:15c:211:201:5043:9124:70cb:43f9])
        by smtp.gmail.com with ESMTPSA id jj13-20020a170903048d00b001b83db0bcf2sm3790961plb.141.2023.07.21.10.27.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Jul 2023 10:27:45 -0700 (PDT)
From:   Bart Van Assche <bvanassche@acm.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Bart Van Assche <bvanassche@acm.org>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>
Subject: [PATCH v3 1/3] scsi: Inline scsi_kick_queue()
Date:   Fri, 21 Jul 2023 10:27:28 -0700
Message-ID: <20230721172731.955724-2-bvanassche@acm.org>
X-Mailer: git-send-email 2.41.0.487.g6d72f3e995-goog
In-Reply-To: <20230721172731.955724-1-bvanassche@acm.org>
References: <20230721172731.955724-1-bvanassche@acm.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Inline scsi_kick_queue() to prepare for modifying the second argument
passed to blk_mq_run_hw_queues().

Reviewed-by: Christoph Hellwig <hch@lst.de>
Cc: Martin K. Petersen <martin.petersen@oracle.com>
Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
 drivers/scsi/scsi_lib.c | 9 ++-------
 1 file changed, 2 insertions(+), 7 deletions(-)

diff --git a/drivers/scsi/scsi_lib.c b/drivers/scsi/scsi_lib.c
index ad9afae49544..414d29eef968 100644
--- a/drivers/scsi/scsi_lib.c
+++ b/drivers/scsi/scsi_lib.c
@@ -300,11 +300,6 @@ void scsi_device_unbusy(struct scsi_device *sdev, struct scsi_cmnd *cmd)
 	cmd->budget_token = -1;
 }
 
-static void scsi_kick_queue(struct request_queue *q)
-{
-	blk_mq_run_hw_queues(q, false);
-}
-
 /*
  * Kick the queue of SCSI device @sdev if @sdev != current_sdev. Called with
  * interrupts disabled.
@@ -340,7 +335,7 @@ static void scsi_single_lun_run(struct scsi_device *current_sdev)
 	 * but in most cases, we will be first. Ideally, each LU on the
 	 * target would get some limited time or requests on the target.
 	 */
-	scsi_kick_queue(current_sdev->request_queue);
+	blk_mq_run_hw_queues(current_sdev->request_queue, false);
 
 	spin_lock_irqsave(shost->host_lock, flags);
 	if (!starget->starget_sdev_user)
@@ -427,7 +422,7 @@ static void scsi_starved_list_run(struct Scsi_Host *shost)
 			continue;
 		spin_unlock_irqrestore(shost->host_lock, flags);
 
-		scsi_kick_queue(slq);
+		blk_mq_run_hw_queues(slq, false);
 		blk_put_queue(slq);
 
 		spin_lock_irqsave(shost->host_lock, flags);

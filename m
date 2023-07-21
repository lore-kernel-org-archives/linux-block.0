Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4EA1CC41513
	for <linux-block@archiver.kernel.org>; Fri, 21 Jul 2023 17:28:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230010AbjGUR17 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 21 Jul 2023 13:27:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230183AbjGUR1s (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 21 Jul 2023 13:27:48 -0400
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE6BE2704
        for <linux-block@vger.kernel.org>; Fri, 21 Jul 2023 10:27:47 -0700 (PDT)
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-1b895a06484so14233045ad.1
        for <linux-block@vger.kernel.org>; Fri, 21 Jul 2023 10:27:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689960467; x=1690565267;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WC15ckhFBkJ7CZlx74UOu/T2oqkB0oXquV8n88SsWC4=;
        b=cl/Y+NLylyBZBkXAcBStQqdZlKvhesEHYenDYR+s1nL3j+v7eNCbyBmHs+dV3FKfVy
         l9EIwN86xY+dqDm0GOvRzVIzAGgEOFnw6WxXdPsqJo5XzdQ1xcff/PxF33ad3fsNAw5F
         pCJcY3LVJv0BV1u09PLMY9ZomXYBU2XB4hJlS9fUt25bE+JUfi16y+np5NQ4xqLF/z5U
         Rn5I/K1TSOZPXqn5msFOprR05Nk6b/aJWtEmGrZnCfm6wtDP2dKM7l/c6TXRwOC7U1dC
         8otthk+7aKacjdWrEHXSqe9KROaEB+r913C7T+jbf4BUeUHDD46TJQDxzdw/SThxmeDg
         dqxA==
X-Gm-Message-State: ABy/qLbEcqTdf7PhreSpyz3RJtwQaMJ3qxBVN41YmulU15XYnhL2lkxv
        SNx9RbfDWArgYLNfHzmLmaSYlLpmYz8=
X-Google-Smtp-Source: APBJJlGn40tC7i4awgQAqiSCyD7/p9QTpOEbDOfE9pOidIuGL9dBMVkc5zD3FQyMjrRqPUX5iSrwSA==
X-Received: by 2002:a17:902:7590:b0:1b8:a3a0:d9b3 with SMTP id j16-20020a170902759000b001b8a3a0d9b3mr1974779pll.47.1689960467162;
        Fri, 21 Jul 2023 10:27:47 -0700 (PDT)
Received: from bvanassche-linux.mtv.corp.google.com ([2620:15c:211:201:5043:9124:70cb:43f9])
        by smtp.gmail.com with ESMTPSA id jj13-20020a170903048d00b001b83db0bcf2sm3790961plb.141.2023.07.21.10.27.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Jul 2023 10:27:46 -0700 (PDT)
From:   Bart Van Assche <bvanassche@acm.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Bart Van Assche <bvanassche@acm.org>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>
Subject: [PATCH v3 2/3] scsi: Remove a blk_mq_run_hw_queues() call
Date:   Fri, 21 Jul 2023 10:27:29 -0700
Message-ID: <20230721172731.955724-3-bvanassche@acm.org>
X-Mailer: git-send-email 2.41.0.487.g6d72f3e995-goog
In-Reply-To: <20230721172731.955724-1-bvanassche@acm.org>
References: <20230721172731.955724-1-bvanassche@acm.org>
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

This patch prepares for allowing blk_mq_run_hw_queue() to sleep if
BLK_MQ_F_BLOCKING has been set. scsi_run_queue() may be called from
atomic context and must not sleep. Hence the removal of the
blk_mq_run_hw_queues(q, false) call. See also scsi_unblock_requests().

Cc: Martin K. Petersen <martin.petersen@oracle.com>
Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
 drivers/scsi/scsi_lib.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/scsi/scsi_lib.c b/drivers/scsi/scsi_lib.c
index 414d29eef968..d4c514ab9fe8 100644
--- a/drivers/scsi/scsi_lib.c
+++ b/drivers/scsi/scsi_lib.c
@@ -447,8 +447,8 @@ static void scsi_run_queue(struct request_queue *q)
 	if (!list_empty(&sdev->host->starved_list))
 		scsi_starved_list_run(sdev->host);
 
+	/* Note: blk_mq_kick_requeue_list() runs the queue asynchronously. */
 	blk_mq_kick_requeue_list(q);
-	blk_mq_run_hw_queues(q, false);
 }
 
 void scsi_requeue_run_queue(struct work_struct *work)

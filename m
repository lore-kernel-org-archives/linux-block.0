Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C76DCCA482
	for <linux-block@archiver.kernel.org>; Thu, 14 Jul 2022 18:09:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240080AbiGNSJ1 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 14 Jul 2022 14:09:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240543AbiGNSIt (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 14 Jul 2022 14:08:49 -0400
Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 195E8140F7
        for <linux-block@vger.kernel.org>; Thu, 14 Jul 2022 11:08:46 -0700 (PDT)
Received: by mail-pj1-f46.google.com with SMTP id g16-20020a17090a7d1000b001ea9f820449so9334980pjl.5
        for <linux-block@vger.kernel.org>; Thu, 14 Jul 2022 11:08:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=iMsNwL6MAx7Qg33ORfSfhyoTrxAtVgemUplu2c0lmlc=;
        b=Eq4U6psNBUiYwQ/MhVAgjNKq7XfiFcxEbBqPOVm7YNvUkSET8OOXhGSiq3tyDA5K5C
         r1NhHC+hmKdnh4KB8yP/Axt8JxoIY4Bb4EeE4No9NzUb6tVjXY81AjI6uSHuEXfwkbRh
         kQ4RyEvKAEguDHwmODEB+EQjAUvarwStLmlEiJicDuDzI2dTOKkXx6AqrzAcdH5uOyU/
         5ypNuSAljk3mLxAgTQxzbqSCn1snrVfkMIvH/dNlfJMcUAcNBdb94osC4F6hV7uxuruF
         PNuOYqciWXs3cA7IH5mxR7i057JlQyc88ok4SjHdTUd6I1Gy6zu7OpXT+lDFlicyiI8k
         iOMw==
X-Gm-Message-State: AJIora8Pc4bcwRTnwIjEKSswfj/PA9pUT2p2lhbMEwiXb4OrdNAF21pi
        7Yl5z9uNhnNC8P0Q1J1IN9A=
X-Google-Smtp-Source: AGRyM1tfvw/zJYH1FEOjl8tc5COV0pIdEGRPhIpkH6rfj50q8OwAmXlFFGycefLLbQfDFi/p3R1eAg==
X-Received: by 2002:a17:90b:3ec2:b0:1f0:3e9e:4f1d with SMTP id rm2-20020a17090b3ec200b001f03e9e4f1dmr11300492pjb.172.1657822125925;
        Thu, 14 Jul 2022 11:08:45 -0700 (PDT)
Received: from bvanassche-linux.mtv.corp.google.com ([2620:15c:211:201:9fab:70d1:f0e7:922b])
        by smtp.gmail.com with ESMTPSA id m5-20020a170902db0500b0016bebb0cb96sm1781846plx.266.2022.07.14.11.08.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Jul 2022 11:08:45 -0700 (PDT)
From:   Bart Van Assche <bvanassche@acm.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Jaegeuk Kim <jaegeuk@kernel.org>,
        Bart Van Assche <bvanassche@acm.org>,
        Avri Altman <avri.altman@wdc.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>
Subject: [PATCH v3 43/63] scsi/ufs: Rename a 'dir' argument into 'op'
Date:   Thu, 14 Jul 2022 11:07:09 -0700
Message-Id: <20220714180729.1065367-44-bvanassche@acm.org>
X-Mailer: git-send-email 2.37.0.170.g444d1eabd0-goog
In-Reply-To: <20220714180729.1065367-1-bvanassche@acm.org>
References: <20220714180729.1065367-1-bvanassche@acm.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Improve consistency of the kernel code by renaming a request operation
argument from 'dir' into 'op'.

Reviewed-by: Avri Altman <avri.altman@wdc.com>
Cc: Martin K. Petersen <martin.petersen@oracle.com>
Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
 drivers/ufs/core/ufshpb.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/ufs/core/ufshpb.c b/drivers/ufs/core/ufshpb.c
index 24f1ee82c215..a1a7a1175a5a 100644
--- a/drivers/ufs/core/ufshpb.c
+++ b/drivers/ufs/core/ufshpb.c
@@ -434,7 +434,7 @@ int ufshpb_prep(struct ufs_hba *hba, struct ufshcd_lrb *lrbp)
 }
 
 static struct ufshpb_req *ufshpb_get_req(struct ufshpb_lu *hpb, int rgn_idx,
-					 enum req_op dir, bool atomic)
+					 enum req_op op, bool atomic)
 {
 	struct ufshpb_req *rq;
 	struct request *req;
@@ -445,7 +445,7 @@ static struct ufshpb_req *ufshpb_get_req(struct ufshpb_lu *hpb, int rgn_idx,
 		return NULL;
 
 retry:
-	req = blk_mq_alloc_request(hpb->sdev_ufs_lu->request_queue, dir,
+	req = blk_mq_alloc_request(hpb->sdev_ufs_lu->request_queue, op,
 			      BLK_MQ_REQ_NOWAIT);
 
 	if (!atomic && (PTR_ERR(req) == -EWOULDBLOCK) && (--retries > 0)) {

Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03656C433EF
	for <linux-block@archiver.kernel.org>; Wed, 29 Jun 2022 23:33:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231778AbiF2XdL (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 29 Jun 2022 19:33:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231897AbiF2XdG (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 29 Jun 2022 19:33:06 -0400
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D532227FCC
        for <linux-block@vger.kernel.org>; Wed, 29 Jun 2022 16:33:00 -0700 (PDT)
Received: by mail-pl1-f172.google.com with SMTP id x20so9876353plx.6
        for <linux-block@vger.kernel.org>; Wed, 29 Jun 2022 16:33:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=MKe8TzsHwQs7VxLJm2h6A6Utj6EeaRjRrT+d5+/TuME=;
        b=s5yDfBPbyNj6Gi0NyR/EDNjQLQdpuKlgZ0SazDY21NKiTa0mzONYiMAcBVeMoW946P
         5FNp+YKnE+C0xixlBcHPO1HaokQg/QD9jyKrs1RG81f8HcQOZgPvzffA04E6ro9+TqFU
         T/Y8TMn7M3kky5M8cSQprDT7qikRxR1maaZquPUv90U1tgt2du/lJuZgrPGjBfW6ZH/D
         3yy7m75yTNvj78RkzROSvZ4EsRap4UecXfJAsiZo54b3D8Vw6r5woJ8jCjITcXiSo3RR
         f4IoIRacOb1UUVrNdBGSitwMJs+G3pv53gNnk37lEvwF5Rk6yLUEurX018jARZUOcYnJ
         kMow==
X-Gm-Message-State: AJIora9GAwV8/RfDN2DnDfYranDahFK1CRdHuNtpa1rszn5ylj/l/Gip
        Qk764H+f12yfHU6Bo+yphLw=
X-Google-Smtp-Source: AGRyM1t7BwuG9MdJpi/sB2MZ09bUy9S/nUyViOP4dswTKmdYQqOwvWm4QpnJn+tFyfV+Ip3Z1Udpag==
X-Received: by 2002:a17:902:b681:b0:16a:f81:6b02 with SMTP id c1-20020a170902b68100b0016a0f816b02mr12113975pls.28.1656545579578;
        Wed, 29 Jun 2022 16:32:59 -0700 (PDT)
Received: from bvanassche-linux.mtv.corp.google.com ([2620:15c:211:201:3841:49ce:cba5:1586])
        by smtp.gmail.com with ESMTPSA id b21-20020a17090a8c9500b001ec8d191db4sm2763687pjo.17.2022.06.29.16.32.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Jun 2022 16:32:58 -0700 (PDT)
From:   Bart Van Assche <bvanassche@acm.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Bart Van Assche <bvanassche@acm.org>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        Avri Altman <avri.altman@wdc.com>
Subject: [PATCH v2 43/63] scsi/ufs: Rename a 'dir' argument into 'op'
Date:   Wed, 29 Jun 2022 16:31:25 -0700
Message-Id: <20220629233145.2779494-44-bvanassche@acm.org>
X-Mailer: git-send-email 2.37.0.rc0.161.g10f37bed90-goog
In-Reply-To: <20220629233145.2779494-1-bvanassche@acm.org>
References: <20220629233145.2779494-1-bvanassche@acm.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Improve consistency of the kernel code by renaming a request operation
argument from 'dir' into 'op'.

Cc: Martin K. Petersen <martin.petersen@oracle.com>
Reviewed-by: Avri Altman <avri.altman@wdc.com>
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

Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B17B1C433EF
	for <linux-block@archiver.kernel.org>; Wed, 29 Jun 2022 23:32:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231765AbiF2Xc6 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 29 Jun 2022 19:32:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231758AbiF2Xc4 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 29 Jun 2022 19:32:56 -0400
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 416616546
        for <linux-block@vger.kernel.org>; Wed, 29 Jun 2022 16:32:54 -0700 (PDT)
Received: by mail-pl1-f180.google.com with SMTP id q18so15448262pld.13
        for <linux-block@vger.kernel.org>; Wed, 29 Jun 2022 16:32:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=raLzFJnnDpBxsTS2xItGqhYCI13O1cs7A1GrqbPoAQQ=;
        b=b8G29rFZRhjWqJGOX+sn2sR7f9ga5M5+qakwJGnWmfIRQFBOV1WMPTNeDHkDNQr5AB
         gpqKXMjp00XHhwIkjoJYJ6EhvxoZm+l0fjajScYIqMF460q8oS520NshNZzj5YC8XID2
         CY0Q6Nfez19Hqmd2LwJHUGa8CjnFAQ7X1eORXdAqt5Iz342bqu94kVKsUYnRWR7ZS58W
         Vd3tusi8KmeW1c+Sr+7ZLl1M3K6dayedGgu6KUzNXgPxTgWXUFQZVA+H/qQscLIvrhFm
         9GxkCJL0GiqvnaKxO+dfibKfzHBO64jYi1KklCl7wiC/kFTo0N4UJit/HVUQE/ri2jM5
         Ef2w==
X-Gm-Message-State: AJIora/eqxXqMtIaAseF2xWivYLFqB6mrGwX1IKIeBjBG0yE83AnyeUZ
        CswM8gNfR31dlqjiO8gSonnuDhXv3dk9Ng==
X-Google-Smtp-Source: AGRyM1tdJ7MZ+0U7fLAEIGeHtHwes/Dz3xh4AWf2bQMATGJpcR4/4SlmQzBGrELjvTaxBaZE6FLoKA==
X-Received: by 2002:a17:902:c2c7:b0:16a:3132:bc53 with SMTP id c7-20020a170902c2c700b0016a3132bc53mr11676860pla.90.1656545573565;
        Wed, 29 Jun 2022 16:32:53 -0700 (PDT)
Received: from bvanassche-linux.mtv.corp.google.com ([2620:15c:211:201:3841:49ce:cba5:1586])
        by smtp.gmail.com with ESMTPSA id b21-20020a17090a8c9500b001ec8d191db4sm2763687pjo.17.2022.06.29.16.32.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Jun 2022 16:32:52 -0700 (PDT)
From:   Bart Van Assche <bvanassche@acm.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Bart Van Assche <bvanassche@acm.org>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        Ming Lei <ming.lei@redhat.com>, Hannes Reinecke <hare@suse.de>,
        John Garry <john.garry@huawei.com>,
        Mike Christie <michael.christie@oracle.com>
Subject: [PATCH v2 39/63] scsi/core: Improve static type checking
Date:   Wed, 29 Jun 2022 16:31:21 -0700
Message-Id: <20220629233145.2779494-40-bvanassche@acm.org>
X-Mailer: git-send-email 2.37.0.rc0.161.g10f37bed90-goog
In-Reply-To: <20220629233145.2779494-1-bvanassche@acm.org>
References: <20220629233145.2779494-1-bvanassche@acm.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Improve static type checking by using the new blk_opf_t type for the
combination of a request operation and its flags.

Cc: Martin K. Petersen <martin.petersen@oracle.com>
Cc: Christoph Hellwig <hch@lst.de>
Cc: Ming Lei <ming.lei@redhat.com>
Cc: Hannes Reinecke <hare@suse.de>
Cc: John Garry <john.garry@huawei.com>
Cc: Mike Christie <michael.christie@oracle.com>
Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
 drivers/scsi/scsi_lib.c  | 6 +++---
 include/scsi/scsi_cmnd.h | 4 ++--
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/scsi/scsi_lib.c b/drivers/scsi/scsi_lib.c
index cdf0056582d5..126997e464cb 100644
--- a/drivers/scsi/scsi_lib.c
+++ b/drivers/scsi/scsi_lib.c
@@ -1125,12 +1125,12 @@ static void scsi_initialize_rq(struct request *rq)
 	cmd->retries = 0;
 }
 
-struct request *scsi_alloc_request(struct request_queue *q,
-		unsigned int op, blk_mq_req_flags_t flags)
+struct request *scsi_alloc_request(struct request_queue *q, blk_opf_t opf,
+				   blk_mq_req_flags_t flags)
 {
 	struct request *rq;
 
-	rq = blk_mq_alloc_request(q, op, flags);
+	rq = blk_mq_alloc_request(q, opf, flags);
 	if (!IS_ERR(rq))
 		scsi_initialize_rq(rq);
 	return rq;
diff --git a/include/scsi/scsi_cmnd.h b/include/scsi/scsi_cmnd.h
index 1e80e70dfa92..bac55decf900 100644
--- a/include/scsi/scsi_cmnd.h
+++ b/include/scsi/scsi_cmnd.h
@@ -386,7 +386,7 @@ static inline unsigned scsi_transfer_length(struct scsi_cmnd *scmd)
 extern void scsi_build_sense(struct scsi_cmnd *scmd, int desc,
 			     u8 key, u8 asc, u8 ascq);
 
-struct request *scsi_alloc_request(struct request_queue *q,
-		unsigned int op, blk_mq_req_flags_t flags);
+struct request *scsi_alloc_request(struct request_queue *q, blk_opf_t opf,
+				   blk_mq_req_flags_t flags);
 
 #endif /* _SCSI_SCSI_CMND_H */

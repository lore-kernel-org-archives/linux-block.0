Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2EF5C43334
	for <linux-block@archiver.kernel.org>; Thu, 14 Jul 2022 18:09:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238899AbiGNSJ0 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 14 Jul 2022 14:09:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240531AbiGNSIq (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 14 Jul 2022 14:08:46 -0400
Received: from mail-pg1-f170.google.com (mail-pg1-f170.google.com [209.85.215.170])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3A4713F1E
        for <linux-block@vger.kernel.org>; Thu, 14 Jul 2022 11:08:40 -0700 (PDT)
Received: by mail-pg1-f170.google.com with SMTP id f65so2252341pgc.12
        for <linux-block@vger.kernel.org>; Thu, 14 Jul 2022 11:08:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=/8HmMdT01uYlg7ovQVKiyFPcxy/5hQW6E3q1Vu/w9Pg=;
        b=skRQcGkiAqLXCPmSBeLwgt/R2GtvwBFObD2FcHq9a8EqA1fCw4Q30fm9AP/blO8vxK
         1ZiC3MHhVSdwsqUX+KC7o5hVNE/p4E1iol2lkLZdQ2cGmf8zNdMQciLwCGKXBC6G4dKs
         Cc4IC2UlYtLNpHjSqkb4UUJADTtv9lqdB2PjOShcNGdneaXOiGBOq1er24NR/aGk2M1I
         ylLIWTi1x2k6knvy+ZrqjouIf+vU5UwbUDv3gs7S4gUt9Mkw3XvZreyyuvRFTnTw3PYD
         JoMvr2v9ApnQRteU93aSeemJx0zFj5EnOeGd8iRCoYzDPiteBjHhwc+XwgO9s/ClffLn
         raEQ==
X-Gm-Message-State: AJIora/LMUb/PvAQTb8sghMklEIMQ+nDxOoNwyAM2EOTg3eJJ2Xzkn8/
        QBSkdGo92oVm6J2xbpbI5Ts=
X-Google-Smtp-Source: AGRyM1taX5ljzDRB0x33xTXQyJNdX/ztUZtVVPNVmfDqSKNj7OdycgEk8+Vtyf3znhFIM211QKqNpw==
X-Received: by 2002:a62:e817:0:b0:52a:b9fa:9a54 with SMTP id c23-20020a62e817000000b0052ab9fa9a54mr9595504pfi.61.1657822119600;
        Thu, 14 Jul 2022 11:08:39 -0700 (PDT)
Received: from bvanassche-linux.mtv.corp.google.com ([2620:15c:211:201:9fab:70d1:f0e7:922b])
        by smtp.gmail.com with ESMTPSA id m5-20020a170902db0500b0016bebb0cb96sm1781846plx.266.2022.07.14.11.08.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Jul 2022 11:08:38 -0700 (PDT)
From:   Bart Van Assche <bvanassche@acm.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Jaegeuk Kim <jaegeuk@kernel.org>,
        Bart Van Assche <bvanassche@acm.org>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        Ming Lei <ming.lei@redhat.com>, Hannes Reinecke <hare@suse.de>,
        John Garry <john.garry@huawei.com>,
        Mike Christie <michael.christie@oracle.com>
Subject: [PATCH v3 39/63] scsi/core: Improve static type checking
Date:   Thu, 14 Jul 2022 11:07:05 -0700
Message-Id: <20220714180729.1065367-40-bvanassche@acm.org>
X-Mailer: git-send-email 2.37.0.170.g444d1eabd0-goog
In-Reply-To: <20220714180729.1065367-1-bvanassche@acm.org>
References: <20220714180729.1065367-1-bvanassche@acm.org>
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
index 1b3ca5c16c3d..06ec4705caf9 100644
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

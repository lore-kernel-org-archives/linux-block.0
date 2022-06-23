Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 315A1C43334
	for <linux-block@archiver.kernel.org>; Thu, 23 Jun 2022 19:01:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231781AbiFWTBT (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 23 Jun 2022 15:01:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231779AbiFWTBG (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 23 Jun 2022 15:01:06 -0400
Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D15F310E654
        for <linux-block@vger.kernel.org>; Thu, 23 Jun 2022 11:06:20 -0700 (PDT)
Received: by mail-pj1-f45.google.com with SMTP id d14so334155pjs.3
        for <linux-block@vger.kernel.org>; Thu, 23 Jun 2022 11:06:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=gN4bfvORSKJmj2cEmic3OBJkZeLF1uahbAz0Y3BxY0k=;
        b=6X+NpM/8g09nxbRpdcQ3s1p5JA7BZR1jx0+rXwmwWwun7SYWe7XBnlutWciTdPPqe4
         ywImYovF7lcvDej4kHH0sqthfikwtj2wVCyn09od4TNQQk3b7fUanJE9Kth1ZQjwnc14
         nez7comHROpqay8UB7Mt+qOkFNeFRm672lHVHHK5ezLKKZMLp2YcqQieGQd5UVaWNXn2
         g9h8ERs6ZYKhe5/Bg3+DNVu1Rgic66MwUBt8k77mDAnYXLNJlDN7HCduNbUS6DB1USpb
         r7tL3OrUoBzD5p/lPNVbGAMZZU9qRduYS9zvJlbbgNNTTX/B8431PjWPDwZyw5XRX2nZ
         gL2A==
X-Gm-Message-State: AJIora+v2YY+Fil41/1bESVDhtW3aTuGznXvGuSkXaNnam1cnHXBrxZu
        8mdJ0nSQZinPmUt588MEh87F/WW7U4E=
X-Google-Smtp-Source: AGRyM1utKMN1cClDIJr8Cf+Mreb0Nix0XVrNePm9gMTuakD3IEx0Dim9C9hXx+UaKUKHQAOS4QMkUQ==
X-Received: by 2002:a17:902:d292:b0:16a:2a8d:616e with SMTP id t18-20020a170902d29200b0016a2a8d616emr19379555plc.5.1656007580236;
        Thu, 23 Jun 2022 11:06:20 -0700 (PDT)
Received: from bvanassche-linux.mtv.corp.google.com ([2620:15c:211:201:70af:1dc5:d20:a563])
        by smtp.gmail.com with ESMTPSA id a18-20020a056a000c9200b0051c4ecb0e3dsm16019967pfv.193.2022.06.23.11.06.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Jun 2022 11:06:19 -0700 (PDT)
From:   Bart Van Assche <bvanassche@acm.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Bart Van Assche <bvanassche@acm.org>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        John Garry <john.garry@huawei.com>,
        Mike Christie <michael.christie@oracle.com>
Subject: [PATCH 29/51] scsi/core: Improve static type checking
Date:   Thu, 23 Jun 2022 11:05:06 -0700
Message-Id: <20220623180528.3595304-30-bvanassche@acm.org>
X-Mailer: git-send-email 2.37.0.rc0.161.g10f37bed90-goog
In-Reply-To: <20220623180528.3595304-1-bvanassche@acm.org>
References: <20220623180528.3595304-1-bvanassche@acm.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Improve static type checking by using enum req_op where appropriate.

Cc: Martin K. Petersen <martin.petersen@oracle.com>
Cc: John Garry <john.garry@huawei.com>
Cc: Mike Christie <michael.christie@oracle.com>
Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
 drivers/scsi/scsi_lib.c  | 4 ++--
 include/scsi/scsi_cmnd.h | 2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/scsi/scsi_lib.c b/drivers/scsi/scsi_lib.c
index 6ffc9e4258a8..6b6a7a4b0950 100644
--- a/drivers/scsi/scsi_lib.c
+++ b/drivers/scsi/scsi_lib.c
@@ -1125,8 +1125,8 @@ static void scsi_initialize_rq(struct request *rq)
 	cmd->retries = 0;
 }
 
-struct request *scsi_alloc_request(struct request_queue *q,
-		unsigned int op, blk_mq_req_flags_t flags)
+struct request *scsi_alloc_request(struct request_queue *q, enum req_op op,
+				   blk_mq_req_flags_t flags)
 {
 	struct request *rq;
 
diff --git a/include/scsi/scsi_cmnd.h b/include/scsi/scsi_cmnd.h
index 1e80e70dfa92..6df0af7dd508 100644
--- a/include/scsi/scsi_cmnd.h
+++ b/include/scsi/scsi_cmnd.h
@@ -387,6 +387,6 @@ extern void scsi_build_sense(struct scsi_cmnd *scmd, int desc,
 			     u8 key, u8 asc, u8 ascq);
 
 struct request *scsi_alloc_request(struct request_queue *q,
-		unsigned int op, blk_mq_req_flags_t flags);
+		enum req_op op, blk_mq_req_flags_t flags);
 
 #endif /* _SCSI_SCSI_CMND_H */

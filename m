Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4AB5AC5479D
	for <linux-block@archiver.kernel.org>; Mon,  9 Jan 2023 23:28:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237888AbjAIX2J (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 9 Jan 2023 18:28:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237930AbjAIX2A (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Mon, 9 Jan 2023 18:28:00 -0500
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91439B49B
        for <linux-block@vger.kernel.org>; Mon,  9 Jan 2023 15:27:59 -0800 (PST)
Received: by mail-pl1-f181.google.com with SMTP id c6so11319595pls.4
        for <linux-block@vger.kernel.org>; Mon, 09 Jan 2023 15:27:59 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lChsis0Vn/H82l7R/PRp89geNpa9iV9NWjl6ZB1IdXU=;
        b=NgE1PDgjhouIArIm2OxUI94htfFmgvQT2qSzU+nCMuzYrp6RRj4eNdX56BW+TXYrcI
         N3hb4+lspb8uyJ+KSCMrLz+SpyH4Zo3Tkyhf96VCpZhBIeSXLC39bK9fc+54CrjiZj3L
         f5VU0guuvroZyxei8DOB/MBianDBVMem98Lnq+6qz8HC6mKGiD+ReOFY19Zk2udXtROB
         wREQNDzVYBCW5RlUOqnoHWdOu1xObmfGg0meWivsGFmP5O4eqlIVcJqQfKqcmTnzju2Y
         QjY7invZfH5pqikFYCI8gGsR9OF2XB0RhmtHnd1ASbBSyUG/UmBDv5bKAFv4qtWU9Wqd
         QpEQ==
X-Gm-Message-State: AFqh2krInZ2GneIHHCihHUU/+iRD6xuvlNtSTLlV6X8SJq4342VJ4Xee
        knLLSjt/DgcePhzt9UJuo2g=
X-Google-Smtp-Source: AMrXdXuv63l6RxGaiOeSyBDN9RNxr4Le+OezyhJ1yKbMtUKA8nC4WWYlm90NbAhnkNWtgYN2aY+9wA==
X-Received: by 2002:a05:6a20:1e56:b0:af:98cd:9d82 with SMTP id cy22-20020a056a201e5600b000af98cd9d82mr64456446pzb.26.1673306879000;
        Mon, 09 Jan 2023 15:27:59 -0800 (PST)
Received: from bvanassche-linux.mtv.corp.google.com ([2620:15c:211:201:9f06:14dd:484f:e55c])
        by smtp.gmail.com with ESMTPSA id s2-20020a625e02000000b0057ef155103asm5032244pfb.155.2023.01.09.15.27.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Jan 2023 15:27:58 -0800 (PST)
From:   Bart Van Assche <bvanassche@acm.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Jaegeuk Kim <jaegeuk@kernel.org>,
        Avri Altman <avri.altman@wdc.com>,
        Bart Van Assche <bvanassche@acm.org>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>
Subject: [PATCH 7/8] scsi: Retry unaligned zoned writes
Date:   Mon,  9 Jan 2023 15:27:37 -0800
Message-Id: <20230109232738.169886-8-bvanassche@acm.org>
X-Mailer: git-send-email 2.39.0.314.g84b9a713c41-goog
In-Reply-To: <20230109232738.169886-1-bvanassche@acm.org>
References: <20230109232738.169886-1-bvanassche@acm.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

From ZBC-2: "The device server terminates with CHECK CONDITION status, with
the sense key set to ILLEGAL REQUEST, and the additional sense code set to
UNALIGNED WRITE COMMAND a write command, other than an entire medium write
same command, that specifies: a) the starting LBA in a sequential write
required zone set to a value that is not equal to the write pointer for that
sequential write required zone; or b) an ending LBA that is not equal to the
last logical block within a physical block (see SBC-5)."

I am not aware of any other conditions that may trigger the UNALIGNED
WRITE COMMAND response.

Retry unaligned writes in preparation of removing zone locking.

Increase the number of retries for write commands sent to a sequential
zone to the maximum number of outstanding commands.

Cc: Martin K. Petersen <martin.petersen@oracle.com>
Cc: Damien Le Moal <damien.lemoal@opensource.wdc.com>
Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
 drivers/scsi/scsi_error.c | 7 +++++++
 drivers/scsi/sd.c         | 3 +++
 2 files changed, 10 insertions(+)

diff --git a/drivers/scsi/scsi_error.c b/drivers/scsi/scsi_error.c
index a7960ad2d386..e17f36b0b18a 100644
--- a/drivers/scsi/scsi_error.c
+++ b/drivers/scsi/scsi_error.c
@@ -676,6 +676,13 @@ enum scsi_disposition scsi_check_sense(struct scsi_cmnd *scmd)
 		fallthrough;
 
 	case ILLEGAL_REQUEST:
+		/*
+		 * Unaligned write command. Retry immediately if pipelining
+		 * zoned writes has been enabled.
+		 */
+		if (sshdr.asc == 0x21 && sshdr.ascq == 0x04 &&
+		    blk_queue_pipeline_zoned_writes(sdev->request_queue))
+			return NEEDS_RETRY;
 		if (sshdr.asc == 0x20 || /* Invalid command operation code */
 		    sshdr.asc == 0x21 || /* Logical block address out of range */
 		    sshdr.asc == 0x22 || /* Invalid function */
diff --git a/drivers/scsi/sd.c b/drivers/scsi/sd.c
index 47dafe6b8a66..cd90b54a6597 100644
--- a/drivers/scsi/sd.c
+++ b/drivers/scsi/sd.c
@@ -1207,6 +1207,9 @@ static blk_status_t sd_setup_read_write_cmnd(struct scsi_cmnd *cmd)
 	cmd->transfersize = sdp->sector_size;
 	cmd->underflow = nr_blocks << 9;
 	cmd->allowed = sdkp->max_retries;
+	if (blk_queue_pipeline_zoned_writes(rq->q) &&
+	    blk_rq_is_seq_zone_write(rq))
+		cmd->allowed += rq->q->nr_requests;
 	cmd->sdb.length = nr_blocks * sdp->sector_size;
 
 	SCSI_LOG_HLQUEUE(1,

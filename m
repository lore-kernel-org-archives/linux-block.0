Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F980C433EF
	for <linux-block@archiver.kernel.org>; Tue, 14 Jun 2022 17:49:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344946AbiFNRt5 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 14 Jun 2022 13:49:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234360AbiFNRt4 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 14 Jun 2022 13:49:56 -0400
Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B1F133A1B
        for <linux-block@vger.kernel.org>; Tue, 14 Jun 2022 10:49:55 -0700 (PDT)
Received: by mail-pj1-f50.google.com with SMTP id e24so9138695pjt.0
        for <linux-block@vger.kernel.org>; Tue, 14 Jun 2022 10:49:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=SYzmx4aDCTgJa9MP4oberz0oDimso3r0GrB2E1nSOXA=;
        b=sbVth/N9szdynaOj9G1aAUAlD6c8mjRpX8baYRElUjBmXYRE72daG+Oe8OFKQf192m
         k3rcM3K5u1utrMM51ajjl+qT659xCVi2imPLs/udVchwE3ELZFBrEKOP8yAc2rvXFlk7
         macNCkrUHE8ivD50iWE5t1hZEzRy62FM4YgXdZY7AgnIl9MD8a7JMQgFpcb2c596xFFT
         hgYshO+14ML2WtLVJf3RcZYK1DYFSpYTKfJ9RDOdO4twcWqVGQiFPJu7In2nM8zi85ng
         imQ1L5oL9gv2P2HOtubvTfxHr5+3N+9nK3I1Z8nJj+AYtcN8nHZXfsgTp1bv9HFxyeze
         fZMA==
X-Gm-Message-State: AJIora8vl/0VLoHJV382v4ojeZa1fpBpmLBHw0ivh7DZX/LDAjOHoz9M
        CWPfoempO7xqSTq40nLyEpo=
X-Google-Smtp-Source: AGRyM1sN23Ihj8RkiY8KZu/XsX+dmoV6bQtfPhmJ/JEOUhvErLGHTUxyP6ztsUYPBfk26zgv4inIww==
X-Received: by 2002:a17:90b:4c0c:b0:1ea:87ef:546a with SMTP id na12-20020a17090b4c0c00b001ea87ef546amr5695074pjb.209.1655228994852;
        Tue, 14 Jun 2022 10:49:54 -0700 (PDT)
Received: from bvanassche-linux.mtv.corp.google.com ([2620:15c:211:201:ab60:e1ea:e2eb:c1b6])
        by smtp.gmail.com with ESMTPSA id gd3-20020a17090b0fc300b001e2da6766ecsm9866922pjb.31.2022.06.14.10.49.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jun 2022 10:49:54 -0700 (PDT)
From:   Bart Van Assche <bvanassche@acm.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Damien Le Moal <damien.lemoal@wdc.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        Khazhy Kumykov <khazhy@google.com>,
        Jaegeuk Kim <jaegeuk@kernel.org>,
        Bart Van Assche <bvanassche@acm.org>
Subject: [PATCH 2/5] scsi: Retry unaligned zoned writes
Date:   Tue, 14 Jun 2022 10:49:40 -0700
Message-Id: <20220614174943.611369-3-bvanassche@acm.org>
X-Mailer: git-send-email 2.36.1.476.g0c4daa206d-goog
In-Reply-To: <20220614174943.611369-1-bvanassche@acm.org>
References: <20220614174943.611369-1-bvanassche@acm.org>
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
Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
 drivers/scsi/scsi_error.c | 6 ++++++
 drivers/scsi/sd.c         | 2 ++
 2 files changed, 8 insertions(+)

diff --git a/drivers/scsi/scsi_error.c b/drivers/scsi/scsi_error.c
index 49ef864df581..8e22d4ba22a3 100644
--- a/drivers/scsi/scsi_error.c
+++ b/drivers/scsi/scsi_error.c
@@ -674,6 +674,12 @@ enum scsi_disposition scsi_check_sense(struct scsi_cmnd *scmd)
 		fallthrough;
 
 	case ILLEGAL_REQUEST:
+		/*
+		 * Unaligned write command. Retry immediately to handle
+		 * out-of-order zoned writes.
+		 */
+		if (sshdr.asc == 0x21 && sshdr.ascq == 0x04)
+			return NEEDS_RETRY;
 		if (sshdr.asc == 0x20 || /* Invalid command operation code */
 		    sshdr.asc == 0x21 || /* Logical block address out of range */
 		    sshdr.asc == 0x22 || /* Invalid function */
diff --git a/drivers/scsi/sd.c b/drivers/scsi/sd.c
index a1a2ac09066f..8d68bd20723e 100644
--- a/drivers/scsi/sd.c
+++ b/drivers/scsi/sd.c
@@ -1202,6 +1202,8 @@ static blk_status_t sd_setup_read_write_cmnd(struct scsi_cmnd *cmd)
 	cmd->transfersize = sdp->sector_size;
 	cmd->underflow = nr_blocks << 9;
 	cmd->allowed = sdkp->max_retries;
+	if (blk_rq_is_seq_write(rq))
+		cmd->allowed += rq->q->nr_hw_queues * rq->q->nr_requests;
 	cmd->sdb.length = nr_blocks * sdp->sector_size;
 
 	SCSI_LOG_HLQUEUE(1,

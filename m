Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11544EB64DA
	for <linux-block@archiver.kernel.org>; Mon, 10 Jul 2023 18:02:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229451AbjGJSCv (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 10 Jul 2023 14:02:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230449AbjGJSCu (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 10 Jul 2023 14:02:50 -0400
Received: from mail-pg1-f174.google.com (mail-pg1-f174.google.com [209.85.215.174])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D079187
        for <linux-block@vger.kernel.org>; Mon, 10 Jul 2023 11:02:43 -0700 (PDT)
Received: by mail-pg1-f174.google.com with SMTP id 41be03b00d2f7-5577905ef38so1649612a12.0
        for <linux-block@vger.kernel.org>; Mon, 10 Jul 2023 11:02:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689012163; x=1691604163;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=30RAgPQwNyyrt3ts6ShvyJIOlHzYMZrPsYCI8GiZL+o=;
        b=FAsHz9IU/l5phT6p41s6PJO4pNX9iwiDqjZatCXFIqo4xlKNlVJIvkFOI33EAB7p3M
         zbVW3EjJKWYl1FNEhn1pZYNyZgFT45XXdTSqblC16uswLlPvd09gNE0fjTDqXEpP00Fi
         yaGkjuGaOKmxqv+n3LEtgZJ/+IgNAxOfWPeuSPVZ/0pjWSKVoND27WwwmIU6pKLbLx7/
         fBJOVF1OSLOmvEgGQXXR0/2y6CGMYJgS0YMZSvhHauvJ+1ThYwqrWbLkfvxDRkdaQ6x7
         n5/ldFFqyt2GRZFBoirYnkJd13pQH4Gl3iChFweT/xsxgvW1IXLQRuls1OxxEmzrXvSM
         KCmg==
X-Gm-Message-State: ABy/qLZPacMWEnARMwQobM4W/1HYT6L3pXH7MMSfXo9xAfWqtxN9mvnn
        23CbbM88WlFOrPvhb7zMc60=
X-Google-Smtp-Source: APBJJlE0rKWBZClYfL0ZVb3jHnm1knsh50ptu+Lv/MY3RPgFzdQPZ8kHMIuPGEI/jR4EPZarlca1Xw==
X-Received: by 2002:a17:90b:1998:b0:263:a37:fcc3 with SMTP id mv24-20020a17090b199800b002630a37fcc3mr10295283pjb.5.1689012162632;
        Mon, 10 Jul 2023 11:02:42 -0700 (PDT)
Received: from bvanassche-linux.mtv.corp.google.com ([2620:15c:211:201:e582:53b1:a691:ab70])
        by smtp.gmail.com with ESMTPSA id gt4-20020a17090af2c400b00263f446d432sm6531846pjb.43.2023.07.10.11.02.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Jul 2023 11:02:42 -0700 (PDT)
From:   Bart Van Assche <bvanassche@acm.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Bart Van Assche <bvanassche@acm.org>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>
Subject: [PATCH v2 4/5] scsi: Retry unaligned zoned writes
Date:   Mon, 10 Jul 2023 11:01:41 -0700
Message-ID: <20230710180210.1582299-5-bvanassche@acm.org>
X-Mailer: git-send-email 2.41.0.255.g8b1d071c50-goog
In-Reply-To: <20230710180210.1582299-1-bvanassche@acm.org>
References: <20230710180210.1582299-1-bvanassche@acm.org>
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

Send commands that failed with an unaligned write error to the SCSI error
handler. Let the SCSI error handler sort SCSI commands per LBA before
resubmitting these.

Increase the number of retries for write commands sent to a sequential
zone to the maximum number of outstanding commands.

Cc: Martin K. Petersen <martin.petersen@oracle.com>
Cc: Damien Le Moal <damien.lemoal@opensource.wdc.com>
Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
 drivers/scsi/scsi_error.c | 37 +++++++++++++++++++++++++++++++++++++
 drivers/scsi/scsi_lib.c   |  1 +
 drivers/scsi/sd.c         |  3 +++
 include/scsi/scsi.h       |  1 +
 4 files changed, 42 insertions(+)

diff --git a/drivers/scsi/scsi_error.c b/drivers/scsi/scsi_error.c
index 3ec8bfd4090f..a6d562f3a085 100644
--- a/drivers/scsi/scsi_error.c
+++ b/drivers/scsi/scsi_error.c
@@ -27,6 +27,7 @@
 #include <linux/blkdev.h>
 #include <linux/delay.h>
 #include <linux/jiffies.h>
+#include <linux/list_sort.h>
 
 #include <scsi/scsi.h>
 #include <scsi/scsi_cmnd.h>
@@ -681,6 +682,17 @@ enum scsi_disposition scsi_check_sense(struct scsi_cmnd *scmd)
 		fallthrough;
 
 	case ILLEGAL_REQUEST:
+		/*
+		 * Unaligned write command. This indicates that zoned writes
+		 * have been received by the device in the wrong order. If zoned
+		 * write pipelining is enabled, retry after all pending commands
+		 * have completed.
+		 */
+		if (sshdr.asc == 0x21 && sshdr.ascq == 0x04 &&
+		    blk_queue_pipeline_zoned_writes(sdev->request_queue) &&
+		    !scsi_noretry_cmd(scmd) && scsi_cmd_retry_allowed(scmd))
+			return NEEDS_DELAYED_RETRY;
+
 		if (sshdr.asc == 0x20 || /* Invalid command operation code */
 		    sshdr.asc == 0x21 || /* Logical block address out of range */
 		    sshdr.asc == 0x22 || /* Invalid function */
@@ -2177,6 +2189,25 @@ void scsi_eh_flush_done_q(struct list_head *done_q)
 }
 EXPORT_SYMBOL(scsi_eh_flush_done_q);
 
+/*
+ * Returns a negative value if @_a has a lower LBA than @_b, zero if
+ * both have the same LBA and a positive value otherwise.
+ */
+static int scsi_cmp_lba(void *priv, const struct list_head *_a,
+			const struct list_head *_b)
+{
+	struct scsi_cmnd *a = list_entry(_a, typeof(*a), eh_entry);
+	struct scsi_cmnd *b = list_entry(_b, typeof(*b), eh_entry);
+	const sector_t pos_a = blk_rq_pos(scsi_cmd_to_rq(a));
+	const sector_t pos_b = blk_rq_pos(scsi_cmd_to_rq(b));
+
+	if (pos_a < pos_b)
+		return -1;
+	if (pos_a > pos_b)
+		return 1;
+	return 0;
+}
+
 /**
  * scsi_unjam_host - Attempt to fix a host which has a cmd that failed.
  * @shost:	Host to unjam.
@@ -2212,6 +2243,12 @@ static void scsi_unjam_host(struct Scsi_Host *shost)
 
 	SCSI_LOG_ERROR_RECOVERY(1, scsi_eh_prt_fail_stats(shost, &eh_work_q));
 
+	/*
+	 * Sort pending SCSI commands in LBA order. This is important if write
+	 * pipelining is enabled for a zoned SCSI device.
+	 */
+	list_sort(NULL, &eh_work_q, scsi_cmp_lba);
+
 	if (!scsi_eh_get_sense(&eh_work_q, &eh_done_q))
 		scsi_eh_ready_devs(shost, &eh_work_q, &eh_done_q);
 
diff --git a/drivers/scsi/scsi_lib.c b/drivers/scsi/scsi_lib.c
index 0226c9279cef..a6cfdc4bfbf1 100644
--- a/drivers/scsi/scsi_lib.c
+++ b/drivers/scsi/scsi_lib.c
@@ -1445,6 +1445,7 @@ static void scsi_complete(struct request *rq)
 	case ADD_TO_MLQUEUE:
 		scsi_queue_insert(cmd, SCSI_MLQUEUE_DEVICE_BUSY);
 		break;
+	case NEEDS_DELAYED_RETRY:
 	default:
 		scsi_eh_scmd_add(cmd);
 		break;
diff --git a/drivers/scsi/sd.c b/drivers/scsi/sd.c
index ab216976dbdc..6cf7495c6b56 100644
--- a/drivers/scsi/sd.c
+++ b/drivers/scsi/sd.c
@@ -1206,6 +1206,9 @@ static blk_status_t sd_setup_read_write_cmnd(struct scsi_cmnd *cmd)
 	cmd->transfersize = sdp->sector_size;
 	cmd->underflow = nr_blocks << 9;
 	cmd->allowed = sdkp->max_retries;
+	if (blk_queue_pipeline_zoned_writes(rq->q) &&
+	    blk_rq_is_seq_zoned_write(rq))
+		cmd->allowed += rq->q->nr_requests;
 	cmd->sdb.length = nr_blocks * sdp->sector_size;
 
 	SCSI_LOG_HLQUEUE(1,
diff --git a/include/scsi/scsi.h b/include/scsi/scsi.h
index ec093594ba53..6600db046227 100644
--- a/include/scsi/scsi.h
+++ b/include/scsi/scsi.h
@@ -93,6 +93,7 @@ static inline int scsi_status_is_check_condition(int status)
  * Internal return values.
  */
 enum scsi_disposition {
+	NEEDS_DELAYED_RETRY	= 0x2000,
 	NEEDS_RETRY		= 0x2001,
 	SUCCESS			= 0x2002,
 	FAILED			= 0x2003,

Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7F6FC001DF
	for <linux-block@archiver.kernel.org>; Mon, 31 Jul 2023 22:15:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229932AbjGaWPa (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 31 Jul 2023 18:15:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229935AbjGaWP3 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 31 Jul 2023 18:15:29 -0400
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59326B2
        for <linux-block@vger.kernel.org>; Mon, 31 Jul 2023 15:15:26 -0700 (PDT)
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-686daaa5f1fso3508920b3a.3
        for <linux-block@vger.kernel.org>; Mon, 31 Jul 2023 15:15:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690841726; x=1691446526;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lxaQKdPofwgep3jGtj8wOmuCBCk05Widn0Lpq/npZrQ=;
        b=Oibo/Gr5JAMaxXjVhSBdUtW7j9tuOCo7KdWu+sOGgsDIEygI4NGVcfJpEydct62VLf
         rgG/N7hNSs1LSdJvf7qn7RZ6BNfKdcXnaHhEQBQsDJHha/XPJtXcUngN7N1C/hfB/O6x
         QkUBqbuKCD7bKMZcxWsgWIj8oOeGSdTaqTESPdaVj9PtxQxD1lnUAaHERv9WSqRlTcUs
         RSwjKLuOXjqIF8//nIB0tFJJxluhXtuuh9gW6hUe4WVhTdhKGr/SrxZHcnubDkZEK3Nk
         NprFKHlRddkwQlZErLPZ9QSZzgahyIpP2CL2kRgTF/vp9NLVw9lNLx3cBXDHxsGMnGp2
         4WaA==
X-Gm-Message-State: ABy/qLapagT+kADnMCs/BeCsFRjiC5ozfQZWzxI12NEzRsGJTXLNUFiE
        LebiJUNYpCy+xVsM0O3oRq0=
X-Google-Smtp-Source: APBJJlH58SLPtzD6H7lhBW0c7wlc0yKff+UukzoNdZIaEvpQbc/rebK7YQo48H0SpvNUgpzZXx0X0w==
X-Received: by 2002:a05:6a21:4887:b0:13b:7776:ceed with SMTP id av7-20020a056a21488700b0013b7776ceedmr10947631pzc.26.1690841725759;
        Mon, 31 Jul 2023 15:15:25 -0700 (PDT)
Received: from bvanassche-linux.mtv.corp.google.com ([2620:15c:211:201:9346:70e3:158a:281c])
        by smtp.gmail.com with ESMTPSA id jn13-20020a170903050d00b001b895a18472sm9000888plb.117.2023.07.31.15.15.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Jul 2023 15:15:25 -0700 (PDT)
From:   Bart Van Assche <bvanassche@acm.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        Bart Van Assche <bvanassche@acm.org>,
        Damien Le Moal <dlemoal@kernel.org>,
        Ming Lei <ming.lei@redhat.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>
Subject: [PATCH v5 3/7] scsi: core: Retry unaligned zoned writes
Date:   Mon, 31 Jul 2023 15:14:39 -0700
Message-ID: <20230731221458.437440-4-bvanassche@acm.org>
X-Mailer: git-send-email 2.41.0.585.gd2178a4bd4-goog
In-Reply-To: <20230731221458.437440-1-bvanassche@acm.org>
References: <20230731221458.437440-1-bvanassche@acm.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

If zoned writes (REQ_OP_WRITE) for a sequential write required zone have
a starting LBA that differs from the write pointer, e.g. because zoned
writes have been reordered, then the storage device will respond with an
UNALIGNED WRITE COMMAND error. Send commands that failed with an
unaligned write error to the SCSI error handler if zone write locking is
disabled. Let the SCSI error handler sort SCSI commands per LBA before
resubmitting these.

If zone write locking is disabled, increase the number of retries for
write commands sent to a sequential zone to the maximum number of
outstanding commands because in the worst case the number of times
reordered zoned writes have to be retried is (number of outstanding
writes per sequential zone) - 1.

Cc: Martin K. Petersen <martin.petersen@oracle.com>
Cc: Christoph Hellwig <hch@lst.de>
Cc: Damien Le Moal <dlemoal@kernel.org>
Cc: Ming Lei <ming.lei@redhat.com>
Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
 drivers/scsi/scsi_error.c | 37 +++++++++++++++++++++++++++++++++++++
 drivers/scsi/scsi_lib.c   |  1 +
 drivers/scsi/sd.c         |  3 +++
 include/scsi/scsi.h       |  1 +
 4 files changed, 42 insertions(+)

diff --git a/drivers/scsi/scsi_error.c b/drivers/scsi/scsi_error.c
index c67cdcdc3ba8..24a4e49215af 100644
--- a/drivers/scsi/scsi_error.c
+++ b/drivers/scsi/scsi_error.c
@@ -27,6 +27,7 @@
 #include <linux/blkdev.h>
 #include <linux/delay.h>
 #include <linux/jiffies.h>
+#include <linux/list_sort.h>
 
 #include <scsi/scsi.h>
 #include <scsi/scsi_cmnd.h>
@@ -698,6 +699,16 @@ enum scsi_disposition scsi_check_sense(struct scsi_cmnd *scmd)
 		fallthrough;
 
 	case ILLEGAL_REQUEST:
+		/*
+		 * Unaligned write command. This indicates that zoned writes
+		 * have been received by the device in the wrong order. If zone
+		 * write locking is disabled, retry after all pending commands
+		 * have completed.
+		 */
+		if (sshdr.asc == 0x21 && sshdr.ascq == 0x04 &&
+		    blk_queue_no_zone_write_lock(scsi_cmd_to_rq(scmd)->q))
+			return NEEDS_DELAYED_RETRY;
+
 		if (sshdr.asc == 0x20 || /* Invalid command operation code */
 		    sshdr.asc == 0x21 || /* Logical block address out of range */
 		    sshdr.asc == 0x22 || /* Invalid function */
@@ -2186,6 +2197,25 @@ void scsi_eh_ready_devs(struct Scsi_Host *shost,
 }
 EXPORT_SYMBOL_GPL(scsi_eh_ready_devs);
 
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
  * scsi_eh_flush_done_q - finish processed commands or retry them.
  * @done_q:	list_head of processed commands.
@@ -2194,6 +2224,13 @@ void scsi_eh_flush_done_q(struct list_head *done_q)
 {
 	struct scsi_cmnd *scmd, *next;
 
+	/*
+	 * Sort pending SCSI commands in LBA order. This is important if one of
+	 * the SCSI devices associated with @shost is a zoned block device for
+	 * which zone write locking is disabled.
+	 */
+	list_sort(NULL, done_q, scsi_cmp_lba);
+
 	list_for_each_entry_safe(scmd, next, done_q, eh_entry) {
 		list_del_init(&scmd->eh_entry);
 		if (scsi_device_online(scmd->device) &&
diff --git a/drivers/scsi/scsi_lib.c b/drivers/scsi/scsi_lib.c
index 59176946ab56..69da8aee13df 100644
--- a/drivers/scsi/scsi_lib.c
+++ b/drivers/scsi/scsi_lib.c
@@ -1443,6 +1443,7 @@ static void scsi_complete(struct request *rq)
 	case ADD_TO_MLQUEUE:
 		scsi_queue_insert(cmd, SCSI_MLQUEUE_DEVICE_BUSY);
 		break;
+	case NEEDS_DELAYED_RETRY:
 	default:
 		scsi_eh_scmd_add(cmd);
 		break;
diff --git a/drivers/scsi/sd.c b/drivers/scsi/sd.c
index 68b12afa0721..27b9ebe05b90 100644
--- a/drivers/scsi/sd.c
+++ b/drivers/scsi/sd.c
@@ -1235,6 +1235,9 @@ static blk_status_t sd_setup_read_write_cmnd(struct scsi_cmnd *cmd)
 	cmd->transfersize = sdp->sector_size;
 	cmd->underflow = nr_blocks << 9;
 	cmd->allowed = sdkp->max_retries;
+	if (blk_queue_no_zone_write_lock(rq->q) &&
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

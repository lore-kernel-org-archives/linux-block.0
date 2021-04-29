Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AEE84C433ED
	for <linux-block@archiver.kernel.org>; Thu, 29 Apr 2021 15:50:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7A14E61453
	for <linux-block@archiver.kernel.org>; Thu, 29 Apr 2021 15:50:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232004AbhD2Pvg (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 29 Apr 2021 11:51:36 -0400
Received: from mx2.suse.de ([195.135.220.15]:53568 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232989AbhD2Pvf (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Thu, 29 Apr 2021 11:51:35 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1619711448; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=QthqhpRCdGjT2Wu5KVF+VXunJ+2olGrAtwBcVmP2wio=;
        b=hVNq3u4i+C+bGeQEQMo5Sb4DeUfzyaLhZrC9gGB2I67kFcLsZIA2y8XimrL2Bsqp/4LsHB
        J1zT6M1uQxYzjKRQ17kJ39T4veDNnEWsgX/br5InB6ijkPgqnAjqPKuL6p8m8Epzv17L3E
        42nl9e9z9i4Z0HdY5HWAh+V2BsvSjP4=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 162BCAFB1;
        Thu, 29 Apr 2021 15:50:48 +0000 (UTC)
From:   mwilck@suse.com
To:     Mike Snitzer <snitzer@redhat.com>,
        Alasdair G Kergon <agk@redhat.com>, dm-devel@redhat.com,
        Hannes Reinecke <hare@suse.de>
Cc:     Daniel Wagner <dwagner@suse.de>, linux-block@vger.kernel.org,
        Paolo Bonzini <pbonzini@redhat.com>,
        Christoph Hellwig <hch@lst.de>,
        Benjamin Marzinski <bmarzins@redhat.com>,
        Martin Wilck <mwilck@suse.com>
Subject: [RFC PATCH v2 1/2] scsi: convert scsi_result_to_blk_status() to inline
Date:   Thu, 29 Apr 2021 17:50:23 +0200
Message-Id: <20210429155024.4947-2-mwilck@suse.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210429155024.4947-1-mwilck@suse.com>
References: <20210429155024.4947-1-mwilck@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

From: Martin Wilck <mwilck@suse.com>

This makes it possible to use scsi_result_to_blk_status() from
code that shouldn't depend on scsi_mod (e.g. device mapper).

Also, create variants of set_host_byte() etc. that don't expect
a struct scsi_cmnd *, but just a pointer to the result to be
modified/fixed.

Signed-off-by: Martin Wilck <mwilck@suse.com>
---
 drivers/scsi/scsi_lib.c  | 40 -------------------
 include/scsi/scsi_cmnd.h | 83 ++++++++++++++++++++++++++++++++++++++--
 2 files changed, 79 insertions(+), 44 deletions(-)

diff --git a/drivers/scsi/scsi_lib.c b/drivers/scsi/scsi_lib.c
index d7c0d5a5f263..e423184f2bba 100644
--- a/drivers/scsi/scsi_lib.c
+++ b/drivers/scsi/scsi_lib.c
@@ -610,46 +610,6 @@ static bool scsi_end_request(struct request *req, blk_status_t error,
 	return false;
 }
 
-/**
- * scsi_result_to_blk_status - translate a SCSI result code into blk_status_t
- * @cmd:	SCSI command
- * @result:	scsi error code
- *
- * Translate a SCSI result code into a blk_status_t value. May reset the host
- * byte of @cmd->result.
- */
-static blk_status_t scsi_result_to_blk_status(struct scsi_cmnd *cmd, int result)
-{
-	switch (host_byte(result)) {
-	case DID_OK:
-		/*
-		 * Also check the other bytes than the status byte in result
-		 * to handle the case when a SCSI LLD sets result to
-		 * DRIVER_SENSE << 24 without setting SAM_STAT_CHECK_CONDITION.
-		 */
-		if (scsi_status_is_good(result) && (result & ~0xff) == 0)
-			return BLK_STS_OK;
-		return BLK_STS_IOERR;
-	case DID_TRANSPORT_FAILFAST:
-	case DID_TRANSPORT_MARGINAL:
-		return BLK_STS_TRANSPORT;
-	case DID_TARGET_FAILURE:
-		set_host_byte(cmd, DID_OK);
-		return BLK_STS_TARGET;
-	case DID_NEXUS_FAILURE:
-		set_host_byte(cmd, DID_OK);
-		return BLK_STS_NEXUS;
-	case DID_ALLOC_FAILURE:
-		set_host_byte(cmd, DID_OK);
-		return BLK_STS_NOSPC;
-	case DID_MEDIUM_ERROR:
-		set_host_byte(cmd, DID_OK);
-		return BLK_STS_MEDIUM;
-	default:
-		return BLK_STS_IOERR;
-	}
-}
-
 /* Helper for scsi_io_completion() when "reprep" action required. */
 static void scsi_io_completion_reprep(struct scsi_cmnd *cmd,
 				      struct request_queue *q)
diff --git a/include/scsi/scsi_cmnd.h b/include/scsi/scsi_cmnd.h
index 83f7e520be48..ba1e69d3bed9 100644
--- a/include/scsi/scsi_cmnd.h
+++ b/include/scsi/scsi_cmnd.h
@@ -311,24 +311,44 @@ static inline struct scsi_data_buffer *scsi_prot(struct scsi_cmnd *cmd)
 #define scsi_for_each_prot_sg(cmd, sg, nseg, __i)		\
 	for_each_sg(scsi_prot_sglist(cmd), sg, nseg, __i)
 
+static inline void __set_status_byte(int *result, char status)
+{
+	*result = (*result & 0xffffff00) | status;
+}
+
 static inline void set_status_byte(struct scsi_cmnd *cmd, char status)
 {
-	cmd->result = (cmd->result & 0xffffff00) | status;
+	__set_status_byte(&cmd->result, status);
+}
+
+static inline void __set_msg_byte(int *result, char status)
+{
+	*result = (*result & 0xffff00ff) | (status << 8);
 }
 
 static inline void set_msg_byte(struct scsi_cmnd *cmd, char status)
 {
-	cmd->result = (cmd->result & 0xffff00ff) | (status << 8);
+	__set_msg_byte(&cmd->result, status);
+}
+
+static inline void __set_host_byte(int *result, char status)
+{
+	*result = (*result & 0xff00ffff) | (status << 16);
 }
 
 static inline void set_host_byte(struct scsi_cmnd *cmd, char status)
 {
-	cmd->result = (cmd->result & 0xff00ffff) | (status << 16);
+	__set_host_byte(&cmd->result, status);
+}
+
+static inline void __set_driver_byte(int *result, char status)
+{
+	*result = (*result & 0x00ffffff) | (status << 24);
 }
 
 static inline void set_driver_byte(struct scsi_cmnd *cmd, char status)
 {
-	cmd->result = (cmd->result & 0x00ffffff) | (status << 24);
+	__set_driver_byte(&cmd->result, status);
 }
 
 static inline unsigned scsi_transfer_length(struct scsi_cmnd *scmd)
@@ -342,4 +362,59 @@ static inline unsigned scsi_transfer_length(struct scsi_cmnd *scmd)
 	return xfer_len;
 }
 
+/**
+ * scsi_result_to_blk_status - translate a SCSI result code into blk_status_t
+ * @result:	scsi error code
+ * @cmd_result: pointer to scsi cmnd result code to be possibly changed
+ *
+ * Translate a SCSI result code into a blk_status_t value. May reset the host
+ * byte of @cmd_result.
+ */
+static inline blk_status_t __scsi_result_to_blk_status(int *cmd_result, int result)
+{
+	switch (host_byte(result)) {
+	case DID_OK:
+		/*
+		 * Also check the other bytes than the status byte in result
+		 * to handle the case when a SCSI LLD sets result to
+		 * DRIVER_SENSE << 24 without setting SAM_STAT_CHECK_CONDITION.
+		 */
+		if (scsi_status_is_good(result) && (result & ~0xff) == 0)
+			return BLK_STS_OK;
+		return BLK_STS_IOERR;
+	case DID_TRANSPORT_FAILFAST:
+	case DID_TRANSPORT_MARGINAL:
+		return BLK_STS_TRANSPORT;
+	case DID_TARGET_FAILURE:
+		__set_host_byte(cmd_result, DID_OK);
+		return BLK_STS_TARGET;
+	case DID_NEXUS_FAILURE:
+		__set_host_byte(cmd_result, DID_OK);
+		return BLK_STS_NEXUS;
+	case DID_ALLOC_FAILURE:
+		__set_host_byte(cmd_result, DID_OK);
+		return BLK_STS_NOSPC;
+	case DID_MEDIUM_ERROR:
+		__set_host_byte(cmd_result, DID_OK);
+		return BLK_STS_MEDIUM;
+	default:
+		return BLK_STS_IOERR;
+	}
+}
+
+/**
+ * scsi_result_to_blk_status - translate a SCSI result code into blk_status_t
+ * @cmd:	SCSI command
+ * @result:	scsi error code
+ *
+ * Translate a SCSI result code into a blk_status_t value. May reset the host
+ * byte of @cmd->result.
+ */
+static inline blk_status_t scsi_result_to_blk_status(struct scsi_cmnd *cmd,
+						     int result)
+{
+	return __scsi_result_to_blk_status(&cmd->result, result);
+}
+
+
 #endif /* _SCSI_SCSI_CMND_H */
-- 
2.31.1


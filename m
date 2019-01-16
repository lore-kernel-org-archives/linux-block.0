Return-Path: <SRS0=7Bp6=PY=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2553C43387
	for <linux-block@archiver.kernel.org>; Wed, 16 Jan 2019 15:57:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C0B6620657
	for <linux-block@archiver.kernel.org>; Wed, 16 Jan 2019 15:57:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404700AbfAPP5I (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 16 Jan 2019 10:57:08 -0500
Received: from smtp.infotech.no ([82.134.31.41]:43595 "EHLO smtp.infotech.no"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726720AbfAPP5H (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Wed, 16 Jan 2019 10:57:07 -0500
Received: from localhost (localhost [127.0.0.1])
        by smtp.infotech.no (Postfix) with ESMTP id B4F4720418D;
        Wed, 16 Jan 2019 16:57:05 +0100 (CET)
X-Virus-Scanned: by amavisd-new-2.6.6 (20110518) (Debian) at infotech.no
Received: from smtp.infotech.no ([127.0.0.1])
        by localhost (smtp.infotech.no [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id ktSoCOqE1P7m; Wed, 16 Jan 2019 16:57:04 +0100 (CET)
Received: from xtwo70.bingwo.ca (host-192.252-161-233.dyn.295.ca [192.252.161.233])
        by smtp.infotech.no (Postfix) with ESMTPA id 212F520417F;
        Wed, 16 Jan 2019 16:57:02 +0100 (CET)
From:   Douglas Gilbert <dgilbert@interlog.com>
To:     hch@infradead.org, linux-scsi@vger.kernel.org,
        linux-block@vger.kernel.org
Cc:     martin.petersen@oracle.com, jejb@linux.vnet.ibm.com
Subject: [PATCH fix] scsi_lib: make sure scsi_request.sense valid
Date:   Wed, 16 Jan 2019 10:57:00 -0500
Message-Id: <20190116155700.28967-1-dgilbert@interlog.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

The block layer assumes scsi_request:sense is always a valid
pointer. This is set up once in scsi_mq_init_request() and the
containing scsi_cmnd object is used often, being re-initialized
by scsi_init_command(). That works unless some code re-purposes
part of the scsi_cmnd object for something else. And that is
what bidi handling does in scsi_mq_prep_fn(). The result is an
oops at some later time when the partly overwritten object is
re-used. The overwrite is from d285203cf647d but 'git blame'
does not show removed code, so that commit may not be the
culprit.

Signed-off-by: Douglas Gilbert <dgilbert@interlog.com>
---

This was found while injecting errors (thus generating sense data)
into a sequence of bidi commands. At some later time the block
layer blew up with a scsi_request::sense NULL dereference in
sg_rq_end_io(). Without testing I'm confident the bsg driver,
the osd ULD and exofs are exposed to this bug.

 drivers/scsi/scsi_lib.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/scsi/scsi_lib.c b/drivers/scsi/scsi_lib.c
index b13cc9288ba0..71259bd4040a 100644
--- a/drivers/scsi/scsi_lib.c
+++ b/drivers/scsi/scsi_lib.c
@@ -1175,6 +1175,7 @@ void scsi_init_command(struct scsi_device *dev, struct scsi_cmnd *cmd)
 
 	cmd->device = dev;
 	cmd->sense_buffer = buf;
+	cmd->req.sense = buf;
 	cmd->prot_sdb = prot;
 	cmd->flags = flags;
 	INIT_DELAYED_WORK(&cmd->abort_work, scmd_eh_abort_handler);
-- 
2.17.1


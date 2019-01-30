Return-Path: <SRS0=rtTj=QG=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EAA8EC282D7
	for <linux-block@archiver.kernel.org>; Wed, 30 Jan 2019 09:44:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C5C6420882
	for <linux-block@archiver.kernel.org>; Wed, 30 Jan 2019 09:44:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727433AbfA3Job (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 30 Jan 2019 04:44:31 -0500
Received: from mx2.suse.de ([195.135.220.15]:45406 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726427AbfA3Joa (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Wed, 30 Jan 2019 04:44:30 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id D006EACC6;
        Wed, 30 Jan 2019 09:44:29 +0000 (UTC)
From:   Hannes Reinecke <hare@suse.de>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Hannes Reinecke <hare@suse.de>,
        Hannes Reinecke <hare@suse.com>
Subject: [PATCH] bsg: allocate response buffer if requested
Date:   Wed, 30 Jan 2019 10:44:24 +0100
Message-Id: <20190130094424.94255-1-hare@suse.de>
X-Mailer: git-send-email 2.16.4
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

The 'response' buffer from bsg is mapped onto the SCSI sense buffer,
however after commit 82ed4db499b8 we need to allocate them ourselves
as the bsg queue is _not_ a SCSI queue, and hence the sense buffer
won't be allocated from the scsi stack.

Fixes: 82ed4db499b8 ("block: split scsi_request out of struct request")

Signed-off-by: Hannes Reinecke <hare@suse.com>
---
 block/bsg.c | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/block/bsg.c b/block/bsg.c
index 50e5f8f666f2..7554901096c8 100644
--- a/block/bsg.c
+++ b/block/bsg.c
@@ -81,6 +81,13 @@ static int bsg_scsi_fill_hdr(struct request *rq, struct sg_io_v4 *hdr,
 			return -ENOMEM;
 	}
 
+	if (hdr->response) {
+		sreq->sense = kzalloc(hdr->max_response_len, GFP_KERNEL);
+		if (!sreq->sense)
+			return -ENOMEM;
+	} else
+		sreq->sense = NULL;
+
 	if (copy_from_user(sreq->cmd, uptr64(hdr->request), sreq->cmd_len))
 		return -EFAULT;
 	if (blk_verify_command(sreq->cmd, mode))
@@ -128,7 +135,10 @@ static int bsg_scsi_complete_rq(struct request *rq, struct sg_io_v4 *hdr)
 
 static void bsg_scsi_free_rq(struct request *rq)
 {
-	scsi_req_free_cmd(scsi_req(rq));
+	struct scsi_request *sreq = scsi_req(rq);
+
+	kfree(sreq->sense);
+	scsi_req_free_cmd(sreq);
 }
 
 static const struct bsg_ops bsg_scsi_ops = {
-- 
2.16.4


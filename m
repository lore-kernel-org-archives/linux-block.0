Return-Path: <SRS0=D8nw=PQ=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02556C43387
	for <linux-block@archiver.kernel.org>; Tue,  8 Jan 2019 21:57:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CCDC02146F
	for <linux-block@archiver.kernel.org>; Tue,  8 Jan 2019 21:57:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729218AbfAHV5g (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 8 Jan 2019 16:57:36 -0500
Received: from mx1.redhat.com ([209.132.183.28]:56912 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728552AbfAHV5g (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Tue, 8 Jan 2019 16:57:36 -0500
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id B100F369CD;
        Tue,  8 Jan 2019 21:57:35 +0000 (UTC)
Received: from segfault.boston.devel.redhat.com (segfault.boston.devel.redhat.com [10.19.60.26])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 30A1160C45;
        Tue,  8 Jan 2019 21:57:35 +0000 (UTC)
From:   Jeff Moyer <jmoyer@redhat.com>
To:     axboe@kernel.dk
Cc:     "Darrick J. Wong" <darrick.wong@oracle.com>,
        linux-block@vger.kernel.org
Subject: [patch] block: clarify documentation for blk_{start|finish}_plug
X-PGP-KeyID: 1F78E1B4
X-PGP-CertKey: F6FE 280D 8293 F72C 65FD  5A58 1FF8 A7CA 1F78 E1B4
Date:   Tue, 08 Jan 2019 16:57:34 -0500
Message-ID: <x49a7ka7qy9.fsf@segfault.boston.devel.redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.30]); Tue, 08 Jan 2019 21:57:35 +0000 (UTC)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

There was some confusion about what these functions did.  Make it clear
that this is a hint for upper layers to pass to the block layer, and
that it does not guarantee that I/O will not be submitted between a
start and finish plug.

Reported-by: "Darrick J. Wong" <darrick.wong@oracle.com>
Signed-off-by: Jeff Moyer <jmoyer@redhat.com>

diff --git a/block/blk-core.c b/block/blk-core.c
index c78042975737..f2732f106a2e 100644
--- a/block/blk-core.c
+++ b/block/blk-core.c
@@ -1683,6 +1683,15 @@ EXPORT_SYMBOL(kblockd_mod_delayed_work_on);
  * @plug:	The &struct blk_plug that needs to be initialized
  *
  * Description:
+ *   blk_start_plug() indicates to the block layer an intent by the caller
+ *   to submit multiple I/O requests in a batch.  The block layer may use
+ *   this hint to defer submitting I/Os from the caller until blk_finish_plug()
+ *   is called.  However, the block layer may choose to submit requests
+ *   before a call to blk_finish_plug() if the number of queued I/Os
+ *   exceeds %BLK_MAX_REQUEST_COUNT, or if the size of the I/O is larger than
+ *   %BLK_PLUG_FLUSH_SIZE.  The queued I/Os may also be submitted early if
+ *   the task schedules (see below).
+ *
  *   Tracking blk_plug inside the task_struct will help with auto-flushing the
  *   pending I/O should the task end up blocking between blk_start_plug() and
  *   blk_finish_plug(). This is important from a performance perspective, but
@@ -1765,6 +1774,16 @@ void blk_flush_plug_list(struct blk_plug *plug, bool from_schedule)
 		blk_mq_flush_plug_list(plug, from_schedule);
 }
 
+/**
+ * blk_finish_plug - mark the end of a batch of submitted I/O
+ * @plug:	The &struct blk_plug passed to blk_start_plug()
+ *
+ * Description:
+ * Indicate that a batch of I/O submissions is complete.  This function
+ * must be paired with an initial call to blk_start_plug().  The intent
+ * is to allow the block layer to optimize I/O submission.  See the
+ * documentation for blk_start_plug() for more information.
+ */
 void blk_finish_plug(struct blk_plug *plug)
 {
 	if (plug != current->plug)

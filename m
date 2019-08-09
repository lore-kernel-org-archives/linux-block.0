Return-Path: <SRS0=j1eM=WF=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F326C433FF
	for <linux-block@archiver.kernel.org>; Fri,  9 Aug 2019 21:26:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 079C920844
	for <linux-block@archiver.kernel.org>; Fri,  9 Aug 2019 21:26:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728104AbfHIV00 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 9 Aug 2019 17:26:26 -0400
Received: from mx1.redhat.com ([209.132.183.28]:34468 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728041AbfHIV00 (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Fri, 9 Aug 2019 17:26:26 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 0461C308FBAC;
        Fri,  9 Aug 2019 21:26:26 +0000 (UTC)
Received: from rh2.redhat.com (ovpn-125-29.rdu2.redhat.com [10.10.125.29])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 673FA60872;
        Fri,  9 Aug 2019 21:26:25 +0000 (UTC)
From:   Mike Christie <mchristi@redhat.com>
To:     josef@toxicpanda.com, linux-block@vger.kernel.org
Cc:     Mike Christie <mchristi@redhat.com>
Subject: [PATCH 4/4] nbd: fix zero cmd timeout handling
Date:   Fri,  9 Aug 2019 16:26:10 -0500
Message-Id: <20190809212610.19412-5-mchristi@redhat.com>
In-Reply-To: <20190809212610.19412-1-mchristi@redhat.com>
References: <20190809212610.19412-1-mchristi@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.43]); Fri, 09 Aug 2019 21:26:26 +0000 (UTC)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

This fixes a regression added in 4.9 with commit:

commit 0eadf37afc2500e1162c9040ec26a705b9af8d47
Author: Josef Bacik <jbacik@fb.com>
Date:   Thu Sep 8 12:33:40 2016 -0700

    nbd: allow block mq to deal with timeouts

where before the patch userspace would set the timeout to 0 to disable
it. With the above patch, a zero timeout tells the block layer to use
the default value of 30 seconds. For setups where commands can take a
long time or experience transient issues like network disruptions this
then results in IO errors being sent to the application.

To fix this, the patch still uses the common block layer timeout
framework, but if zero is set, nbd just logs a message and then resets
the timer when it expires.

Josef,

I did not cc stable, but I think we want to port the patches to some
releases. We originally hit this with users using the longterm kernels
with ceph. The patch does not apply anywhere cleanly with older ones
like 4.9, so I was not sure how we wanted to handle it.

Signed-off-by: Mike Christie <mchristi@redhat.com>
---
 drivers/block/nbd.c | 26 ++++++++++++++++++++++----
 1 file changed, 22 insertions(+), 4 deletions(-)

diff --git a/drivers/block/nbd.c b/drivers/block/nbd.c
index 93294000ce55..8459adce713a 100644
--- a/drivers/block/nbd.c
+++ b/drivers/block/nbd.c
@@ -120,6 +120,7 @@ struct nbd_cmd {
 	struct mutex lock;
 	int index;
 	int cookie;
+	int retries;
 	blk_status_t status;
 	unsigned long flags;
 	u32 cmd_cookie;
@@ -405,10 +406,25 @@ static enum blk_eh_timer_return nbd_xmit_timeout(struct request *req,
 			nbd_config_put(nbd);
 			return BLK_EH_DONE;
 		}
-	} else {
-		dev_err_ratelimited(nbd_to_dev(nbd),
-				    "Connection timed out\n");
 	}
+
+	if (!nbd->tag_set.timeout) {
+		/*
+		 * Userspace sets timeout=0 to disable socket disconnection,
+		 * so just warn and reset the timer.
+		 */
+		cmd->retries++;
+		dev_info(nbd_to_dev(nbd), "Possible stuck request %p: control (%s@%llu,%uB). Runtime %u seconds\n",
+			req, nbdcmd_to_ascii(req_to_nbd_cmd_type(req)),
+			(unsigned long long)blk_rq_pos(req) << 9,
+			blk_rq_bytes(req), (req->timeout / HZ) * cmd->retries);
+
+		mutex_unlock(&cmd->lock);
+		nbd_config_put(nbd);
+		return BLK_EH_RESET_TIMER;
+	}
+
+	dev_err_ratelimited(nbd_to_dev(nbd), "Connection timed out\n");
 	set_bit(NBD_TIMEDOUT, &config->runtime_flags);
 	cmd->status = BLK_STS_IOERR;
 	mutex_unlock(&cmd->lock);
@@ -527,6 +543,7 @@ static int nbd_send_cmd(struct nbd_device *nbd, struct nbd_cmd *cmd, int index)
 	}
 	cmd->index = index;
 	cmd->cookie = nsock->cookie;
+	cmd->retries = 0;
 	request.type = htonl(type | nbd_cmd_flags);
 	if (type != NBD_CMD_FLUSH) {
 		request.from = cpu_to_be64((u64)blk_rq_pos(req) << 9);
@@ -1253,7 +1270,8 @@ static bool nbd_is_valid_blksize(unsigned long blksize)
 static void nbd_set_cmd_timeout(struct nbd_device *nbd, u64 timeout)
 {
 	nbd->tag_set.timeout = timeout * HZ;
-	blk_queue_rq_timeout(nbd->disk->queue, timeout * HZ);
+	if (timeout)
+		blk_queue_rq_timeout(nbd->disk->queue, timeout * HZ);
 }
 
 /* Must be called with config_lock held */
-- 
2.20.1


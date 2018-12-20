Return-Path: <SRS0=9Hvz=O5=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E650C43387
	for <linux-block@archiver.kernel.org>; Thu, 20 Dec 2018 16:34:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3852E21773
	for <linux-block@archiver.kernel.org>; Thu, 20 Dec 2018 16:34:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728528AbeLTQei (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 20 Dec 2018 11:34:38 -0500
Received: from mail09.linbit.com ([212.69.161.110]:50091 "EHLO
        mail09.linbit.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725781AbeLTQei (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 20 Dec 2018 11:34:38 -0500
Received: from soda.linbit (212-186-191-219.static.upcbusiness.at [212.186.191.219])
        by mail09.linbit.com (LINBIT Mail Daemon) with ESMTP id EF3901045C30;
        Thu, 20 Dec 2018 17:23:47 +0100 (CET)
From:   Lars Ellenberg <lars.ellenberg@linbit.com>
To:     Jens Axboe <axboe@kernel.dk>, linux-kernel@vger.kernel.org,
        linux-block@vger.kernel.org
Cc:     drbd-dev@lists.linbit.com
Subject: [PATCH 09/17] drbd: fix comment typos
Date:   Thu, 20 Dec 2018 17:23:36 +0100
Message-Id: <20181220162344.8430-10-lars.ellenberg@linbit.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181220162344.8430-1-lars.ellenberg@linbit.com>
References: <20181220162344.8430-1-lars.ellenberg@linbit.com>
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Signed-off-by: Lars Ellenberg <lars.ellenberg@linbit.com>
---
 drivers/block/drbd/drbd_receiver.c | 2 +-
 drivers/block/drbd/drbd_state.c    | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/block/drbd/drbd_receiver.c b/drivers/block/drbd/drbd_receiver.c
index 76d74b2122d6..3a0fe357b68b 100644
--- a/drivers/block/drbd/drbd_receiver.c
+++ b/drivers/block/drbd/drbd_receiver.c
@@ -4428,7 +4428,7 @@ static int receive_state(struct drbd_connection *connection, struct packet_info
 		       (peer_state.disk == D_NEGOTIATING ||
 			os.disk == D_NEGOTIATING));
 		/* if we have both been inconsistent, and the peer has been
-		 * forced to be UpToDate with --overwrite-data */
+		 * forced to be UpToDate with --force */
 		cr |= test_bit(CONSIDER_RESYNC, &device->flags);
 		/* if we had been plain connected, and the admin requested to
 		 * start a sync by "invalidate" or "invalidate-remote" */
diff --git a/drivers/block/drbd/drbd_state.c b/drivers/block/drbd/drbd_state.c
index 18d53fe60d1d..883155657273 100644
--- a/drivers/block/drbd/drbd_state.c
+++ b/drivers/block/drbd/drbd_state.c
@@ -1124,7 +1124,7 @@ static union drbd_state sanitize_state(struct drbd_device *device, union drbd_st
 			ns.pdsk = D_UP_TO_DATE;
 	}
 
-	/* Implications of the connection stat on the disk states */
+	/* Implications of the connection state on the disk states */
 	disk_min = D_DISKLESS;
 	disk_max = D_UP_TO_DATE;
 	pdsk_min = D_INCONSISTENT;
-- 
2.17.1


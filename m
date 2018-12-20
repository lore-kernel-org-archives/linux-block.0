Return-Path: <SRS0=9Hvz=O5=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57794C43612
	for <linux-block@archiver.kernel.org>; Thu, 20 Dec 2018 16:35:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 28FEB218DA
	for <linux-block@archiver.kernel.org>; Thu, 20 Dec 2018 16:35:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727387AbeLTQes (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 20 Dec 2018 11:34:48 -0500
Received: from mail09.linbit.com ([212.69.161.110]:50103 "EHLO
        mail09.linbit.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730443AbeLTQek (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 20 Dec 2018 11:34:40 -0500
Received: from soda.linbit (212-186-191-219.static.upcbusiness.at [212.186.191.219])
        by mail09.linbit.com (LINBIT Mail Daemon) with ESMTP id 2F1061045C23;
        Thu, 20 Dec 2018 17:23:47 +0100 (CET)
From:   Lars Ellenberg <lars.ellenberg@linbit.com>
To:     Jens Axboe <axboe@kernel.dk>, linux-kernel@vger.kernel.org,
        linux-block@vger.kernel.org
Cc:     drbd-dev@lists.linbit.com
Subject: [PATCH 07/17] drbd: attach on connected diskless peer must not shrink a consistent device
Date:   Thu, 20 Dec 2018 17:23:34 +0100
Message-Id: <20181220162344.8430-8-lars.ellenberg@linbit.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181220162344.8430-1-lars.ellenberg@linbit.com>
References: <20181220162344.8430-1-lars.ellenberg@linbit.com>
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

If we would reject a new handshake, if the peer had attached first,
and then connected, we should force disconnect if the peer first connects,
and only then attaches.

Signed-off-by: Lars Ellenberg <lars.ellenberg@linbit.com>
---
 drivers/block/drbd/drbd_receiver.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/drivers/block/drbd/drbd_receiver.c b/drivers/block/drbd/drbd_receiver.c
index 0a9f3c65f70a..85e3d846a23a 100644
--- a/drivers/block/drbd/drbd_receiver.c
+++ b/drivers/block/drbd/drbd_receiver.c
@@ -4014,12 +4014,13 @@ static int receive_sizes(struct drbd_connection *connection, struct packet_info
 		if (device->state.conn == C_WF_REPORT_PARAMS)
 			p_usize = min_not_zero(my_usize, p_usize);
 
-		/* Never shrink a device with usable data during connect.
-		   But allow online shrinking if we are connected. */
+		/* Never shrink a device with usable data during connect,
+		 * or "attach" on the peer.
+		 * But allow online shrinking if we are connected. */
 		new_size = drbd_new_dev_size(device, device->ldev, p_usize, 0);
 		if (new_size < cur_size &&
 		    device->state.disk >= D_OUTDATED &&
-		    device->state.conn < C_CONNECTED) {
+		    (device->state.conn < C_CONNECTED || device->state.pdsk == D_DISKLESS)) {
 			drbd_err(device, "The peer's disk size is too small! (%llu < %llu sectors)\n",
 					(unsigned long long)new_size, (unsigned long long)cur_size);
 			conn_request_state(peer_device->connection, NS(conn, C_DISCONNECTING), CS_HARD);
@@ -4047,8 +4048,8 @@ static int receive_sizes(struct drbd_connection *connection, struct packet_info
 			synchronize_rcu();
 			kfree(old_disk_conf);
 
-			drbd_info(device, "Peer sets u_size to %lu sectors\n",
-				 (unsigned long)my_usize);
+			drbd_info(device, "Peer sets u_size to %lu sectors (old: %lu)\n",
+				 (unsigned long)p_usize, (unsigned long)my_usize);
 		}
 
 		put_ldev(device);
-- 
2.17.1


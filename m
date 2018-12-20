Return-Path: <SRS0=9Hvz=O5=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C4E9C43387
	for <linux-block@archiver.kernel.org>; Thu, 20 Dec 2018 16:35:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 07061218C3
	for <linux-block@archiver.kernel.org>; Thu, 20 Dec 2018 16:34:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733218AbeLTQet (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 20 Dec 2018 11:34:49 -0500
Received: from mail09.linbit.com ([212.69.161.110]:50101 "EHLO
        mail09.linbit.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730121AbeLTQek (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 20 Dec 2018 11:34:40 -0500
Received: from soda.linbit (212-186-191-219.static.upcbusiness.at [212.186.191.219])
        by mail09.linbit.com (LINBIT Mail Daemon) with ESMTP id 14AA2103B4D2;
        Thu, 20 Dec 2018 17:23:46 +0100 (CET)
From:   Lars Ellenberg <lars.ellenberg@linbit.com>
To:     Jens Axboe <axboe@kernel.dk>, linux-kernel@vger.kernel.org,
        linux-block@vger.kernel.org
Cc:     drbd-dev@lists.linbit.com
Subject: [PATCH 04/17] drbd: ignore "all zero" peer volume sizes in handshake
Date:   Thu, 20 Dec 2018 17:23:31 +0100
Message-Id: <20181220162344.8430-5-lars.ellenberg@linbit.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181220162344.8430-1-lars.ellenberg@linbit.com>
References: <20181220162344.8430-1-lars.ellenberg@linbit.com>
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

During handshake, if we are diskless ourselves, we used to accept any size
presented by the peer.

Which could be zero if that peer was just brought up and connected
to us without having a disk attached first, in which case both
peers would just "flip" their volume sizes.

Now, even a diskless node will ignore "zero" sizes
presented by a diskless peer.

Also a currently Diskless Primary will refuse to shrink during handshake:
it may be frozen, and waiting for a "suitable" local disk or peer to
re-appear (on-no-data-accessible suspend-io). If the peer is smaller
than what we used to be, it is not suitable.

The logic for a diskless node during handshake is now supposed to be:
believe the peer, if
 - I don't have a current size myself
 - we agree on the size anyways
 - I do have a current size, am Secondary, and he has the only disk
 - I do have a current size, am Primary, and he has the only disk,
   which is larger than my current size

Signed-off-by: Lars Ellenberg <lars.ellenberg@linbit.com>
---
 drivers/block/drbd/drbd_receiver.c | 33 +++++++++++++++++++++++++++---
 1 file changed, 30 insertions(+), 3 deletions(-)

diff --git a/drivers/block/drbd/drbd_receiver.c b/drivers/block/drbd/drbd_receiver.c
index 1b9822f264d2..fbf30fe45862 100644
--- a/drivers/block/drbd/drbd_receiver.c
+++ b/drivers/block/drbd/drbd_receiver.c
@@ -3981,6 +3981,7 @@ static int receive_sizes(struct drbd_connection *connection, struct packet_info
 	struct o_qlim *o = (connection->agreed_features & DRBD_FF_WSAME) ? p->qlim : NULL;
 	enum determine_dev_size dd = DS_UNCHANGED;
 	sector_t p_size, p_usize, p_csize, my_usize;
+	sector_t new_size, cur_size;
 	int ldsc = 0; /* local disk size changed */
 	enum dds_flags ddsf;
 
@@ -3988,6 +3989,7 @@ static int receive_sizes(struct drbd_connection *connection, struct packet_info
 	if (!peer_device)
 		return config_unknown_volume(connection, pi);
 	device = peer_device->device;
+	cur_size = drbd_get_capacity(device->this_bdev);
 
 	p_size = be64_to_cpu(p->d_size);
 	p_usize = be64_to_cpu(p->u_size);
@@ -3998,7 +4000,6 @@ static int receive_sizes(struct drbd_connection *connection, struct packet_info
 	device->p_size = p_size;
 
 	if (get_ldev(device)) {
-		sector_t new_size, cur_size;
 		rcu_read_lock();
 		my_usize = rcu_dereference(device->ldev->disk_conf)->disk_size;
 		rcu_read_unlock();
@@ -4016,7 +4017,6 @@ static int receive_sizes(struct drbd_connection *connection, struct packet_info
 		/* Never shrink a device with usable data during connect.
 		   But allow online shrinking if we are connected. */
 		new_size = drbd_new_dev_size(device, device->ldev, p_usize, 0);
-		cur_size = drbd_get_capacity(device->this_bdev);
 		if (new_size < cur_size &&
 		    device->state.disk >= D_OUTDATED &&
 		    device->state.conn < C_CONNECTED) {
@@ -4081,9 +4081,36 @@ static int receive_sizes(struct drbd_connection *connection, struct packet_info
 		 *
 		 * However, if he sends a zero current size,
 		 * take his (user-capped or) backing disk size anyways.
+		 *
+		 * Unless of course he does not have a disk himself.
+		 * In which case we ignore this completely.
 		 */
+		sector_t new_size = p_csize ?: p_usize ?: p_size;
 		drbd_reconsider_queue_parameters(device, NULL, o);
-		drbd_set_my_capacity(device, p_csize ?: p_usize ?: p_size);
+		if (new_size == 0) {
+			/* Ignore, peer does not know nothing. */
+		} else if (new_size == cur_size) {
+			/* nothing to do */
+		} else if (cur_size != 0 && p_size == 0) {
+			drbd_warn(device, "Ignored diskless peer device size (peer:%llu != me:%llu sectors)!\n",
+					(unsigned long long)new_size, (unsigned long long)cur_size);
+		} else if (new_size < cur_size && device->state.role == R_PRIMARY) {
+			drbd_err(device, "The peer's device size is too small! (%llu < %llu sectors); demote me first!\n",
+					(unsigned long long)new_size, (unsigned long long)cur_size);
+			conn_request_state(peer_device->connection, NS(conn, C_DISCONNECTING), CS_HARD);
+			return -EIO;
+		} else {
+			/* I believe the peer, if
+			 *  - I don't have a current size myself
+			 *  - we agree on the size anyways
+			 *  - I do have a current size, am Secondary,
+			 *    and he has the only disk
+			 *  - I do have a current size, am Primary,
+			 *    and he has the only disk,
+			 *    which is larger than my current size
+			 */
+			drbd_set_my_capacity(device, new_size);
+		}
 	}
 
 	if (get_ldev(device)) {
-- 
2.17.1


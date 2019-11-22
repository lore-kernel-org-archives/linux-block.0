Return-Path: <SRS0=+obT=ZO=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97AF9C432C3
	for <linux-block@archiver.kernel.org>; Fri, 22 Nov 2019 06:24:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5B6C620637
	for <linux-block@archiver.kernel.org>; Fri, 22 Nov 2019 06:24:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1574403847;
	bh=cE1PO+QmHaBe5myBtegunEdnraOxCVMCTh1gItlg7xs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=CbFgyUCOvzniINCgdpr8Bkvix/hCxrAkyMUHzBPgKzk78kBBUMQuHSc+9vPs37zdS
	 M3Ga+CCvHIHSyvRWZyy+OQJl3qedLqJ7xf1wMvLM0A5lCqqTGgTXfobXQ2SRrH7Y7X
	 L9zNJ8dzgmHoMZUyp+FOcgHGb08SUkaVqbF8g5dA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728182AbfKVFvd (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 22 Nov 2019 00:51:33 -0500
Received: from mail.kernel.org ([198.145.29.99]:56724 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726802AbfKVFvd (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Fri, 22 Nov 2019 00:51:33 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AE3F72073F;
        Fri, 22 Nov 2019 05:51:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1574401892;
        bh=cE1PO+QmHaBe5myBtegunEdnraOxCVMCTh1gItlg7xs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=zrtEukCoZN2xenMkX+M23pqmlskHC53quzMHKoT5agdE5Xrk4XKwElfB7NUZoD+ml
         YcSU74J/zEEjzjuxTP3DEicp4RAMy8kH+OET7/sDzXSqGED14gXbquEBHr0hOnLVAd
         uLHkY2UdgFzaqa1AilfvqZoiFJGqZv5hf9Gc5cB8=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Lars Ellenberg <lars.ellenberg@linbit.com>,
        Jens Axboe <axboe@kernel.dk>, Sasha Levin <sashal@kernel.org>,
        drbd-dev@lists.linbit.com, linux-block@vger.kernel.org
Subject: [PATCH AUTOSEL 4.19 125/219] drbd: ignore "all zero" peer volume sizes in handshake
Date:   Fri, 22 Nov 2019 00:47:37 -0500
Message-Id: <20191122054911.1750-118-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191122054911.1750-1-sashal@kernel.org>
References: <20191122054911.1750-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

From: Lars Ellenberg <lars.ellenberg@linbit.com>

[ Upstream commit 94c43a13b8d6e3e0dd77b3536b5e04a84936b762 ]

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
Signed-off-by: Jens Axboe <axboe@kernel.dk>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/block/drbd/drbd_receiver.c | 33 +++++++++++++++++++++++++++---
 1 file changed, 30 insertions(+), 3 deletions(-)

diff --git a/drivers/block/drbd/drbd_receiver.c b/drivers/block/drbd/drbd_receiver.c
index 3cdadf75c82da..c9e8d61dea248 100644
--- a/drivers/block/drbd/drbd_receiver.c
+++ b/drivers/block/drbd/drbd_receiver.c
@@ -3980,6 +3980,7 @@ static int receive_sizes(struct drbd_connection *connection, struct packet_info
 	struct o_qlim *o = (connection->agreed_features & DRBD_FF_WSAME) ? p->qlim : NULL;
 	enum determine_dev_size dd = DS_UNCHANGED;
 	sector_t p_size, p_usize, p_csize, my_usize;
+	sector_t new_size, cur_size;
 	int ldsc = 0; /* local disk size changed */
 	enum dds_flags ddsf;
 
@@ -3987,6 +3988,7 @@ static int receive_sizes(struct drbd_connection *connection, struct packet_info
 	if (!peer_device)
 		return config_unknown_volume(connection, pi);
 	device = peer_device->device;
+	cur_size = drbd_get_capacity(device->this_bdev);
 
 	p_size = be64_to_cpu(p->d_size);
 	p_usize = be64_to_cpu(p->u_size);
@@ -3997,7 +3999,6 @@ static int receive_sizes(struct drbd_connection *connection, struct packet_info
 	device->p_size = p_size;
 
 	if (get_ldev(device)) {
-		sector_t new_size, cur_size;
 		rcu_read_lock();
 		my_usize = rcu_dereference(device->ldev->disk_conf)->disk_size;
 		rcu_read_unlock();
@@ -4015,7 +4016,6 @@ static int receive_sizes(struct drbd_connection *connection, struct packet_info
 		/* Never shrink a device with usable data during connect.
 		   But allow online shrinking if we are connected. */
 		new_size = drbd_new_dev_size(device, device->ldev, p_usize, 0);
-		cur_size = drbd_get_capacity(device->this_bdev);
 		if (new_size < cur_size &&
 		    device->state.disk >= D_OUTDATED &&
 		    device->state.conn < C_CONNECTED) {
@@ -4080,9 +4080,36 @@ static int receive_sizes(struct drbd_connection *connection, struct packet_info
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
2.20.1


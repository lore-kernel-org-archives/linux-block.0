Return-Path: <SRS0=9Hvz=O5=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0AF45C43387
	for <linux-block@archiver.kernel.org>; Thu, 20 Dec 2018 16:35:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D6E9621773
	for <linux-block@archiver.kernel.org>; Thu, 20 Dec 2018 16:35:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733292AbeLTQfE (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 20 Dec 2018 11:35:04 -0500
Received: from mail09.linbit.com ([212.69.161.110]:50094 "EHLO
        mail09.linbit.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725372AbeLTQei (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 20 Dec 2018 11:34:38 -0500
Received: from soda.linbit (212-186-191-219.static.upcbusiness.at [212.186.191.219])
        by mail09.linbit.com (LINBIT Mail Daemon) with ESMTP id 8C3C21045C26;
        Thu, 20 Dec 2018 17:23:47 +0100 (CET)
From:   Lars Ellenberg <lars.ellenberg@linbit.com>
To:     Jens Axboe <axboe@kernel.dk>, linux-kernel@vger.kernel.org,
        linux-block@vger.kernel.org
Cc:     drbd-dev@lists.linbit.com
Subject: [PATCH 08/17] drbd: reject attach of unsuitable uuids even if connected
Date:   Thu, 20 Dec 2018 17:23:35 +0100
Message-Id: <20181220162344.8430-9-lars.ellenberg@linbit.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181220162344.8430-1-lars.ellenberg@linbit.com>
References: <20181220162344.8430-1-lars.ellenberg@linbit.com>
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Multiple failure scenario:
a) all good
   Connected Primary/Secondary UpToDate/UpToDate
b) lose disk on Primary,
   Connected Primary/Secondary Diskless/UpToDate
c) continue to write to the device,
   changes only make it to the Secondary storage.
d) lose disk on Secondary,
   Connected Primary/Secondary Diskless/Diskless
e) now try to re-attach on Primary

This would have succeeded before, even though that is clearly the
wrong data set to attach to (missing the modifications from c).
Because we only compared our "effective" and the "to-be-attached"
data generation uuid tags if (device->state.conn < C_CONNECTED).

Fix: change that constraint to (device->state.pdsk != D_UP_TO_DATE)
compare the uuids, and reject the attach.

This patch also tries to improve the reverse scenario:
first lose Secondary, then Primary disk,
then try to attach the disk on Secondary.

Before this patch, the attach on the Secondary succeeds, but since commit
drbd: disconnect, if the wrong UUIDs are attached on a connected peer
the Primary will notice unsuitable data, and drop the connection hard.

Though unfortunately at a point in time during the handshake where
we cannot easily abort the attach on the peer without more
refactoring of the handshake.

We now reject any attach to "unsuitable" uuids,
as long as we can see a Primary role,
unless we already have access to "good" data.

Signed-off-by: Lars Ellenberg <lars.ellenberg@linbit.com>
---
 drivers/block/drbd/drbd_nl.c       |  6 +++---
 drivers/block/drbd/drbd_receiver.c | 19 +++++++++++++++++++
 2 files changed, 22 insertions(+), 3 deletions(-)

diff --git a/drivers/block/drbd/drbd_nl.c b/drivers/block/drbd/drbd_nl.c
index e4774f720de5..4b934e543e2d 100644
--- a/drivers/block/drbd/drbd_nl.c
+++ b/drivers/block/drbd/drbd_nl.c
@@ -1960,9 +1960,9 @@ int drbd_adm_attach(struct sk_buff *skb, struct genl_info *info)
 		}
 	}
 
-	if (device->state.conn < C_CONNECTED &&
-	    device->state.role == R_PRIMARY && device->ed_uuid &&
-	    (device->ed_uuid & ~((u64)1)) != (nbc->md.uuid[UI_CURRENT] & ~((u64)1))) {
+	if (device->state.pdsk != D_UP_TO_DATE && device->ed_uuid &&
+	    (device->state.role == R_PRIMARY || device->state.peer == R_PRIMARY) &&
+            (device->ed_uuid & ~((u64)1)) != (nbc->md.uuid[UI_CURRENT] & ~((u64)1))) {
 		drbd_err(device, "Can only attach to data with current UUID=%016llX\n",
 		    (unsigned long long)device->ed_uuid);
 		retcode = ERR_DATA_NOT_CURRENT;
diff --git a/drivers/block/drbd/drbd_receiver.c b/drivers/block/drbd/drbd_receiver.c
index 85e3d846a23a..76d74b2122d6 100644
--- a/drivers/block/drbd/drbd_receiver.c
+++ b/drivers/block/drbd/drbd_receiver.c
@@ -4397,6 +4397,25 @@ static int receive_state(struct drbd_connection *connection, struct packet_info
 	if (peer_state.conn == C_AHEAD)
 		ns.conn = C_BEHIND;
 
+	/* TODO:
+	 * if (primary and diskless and peer uuid != effective uuid)
+	 *     abort attach on peer;
+	 *
+	 * If this node does not have good data, was already connected, but
+	 * the peer did a late attach only now, trying to "negotiate" with me,
+	 * AND I am currently Primary, possibly frozen, with some specific
+	 * "effective" uuid, this should never be reached, really, because
+	 * we first send the uuids, then the current state.
+	 *
+	 * In this scenario, we already dropped the connection hard
+	 * when we received the unsuitable uuids (receive_uuids().
+	 *
+	 * Should we want to change this, that is: not drop the connection in
+	 * receive_uuids() already, then we would need to add a branch here
+	 * that aborts the attach of "unsuitable uuids" on the peer in case
+	 * this node is currently Diskless Primary.
+	 */
+
 	if (device->p_uuid && peer_state.disk >= D_NEGOTIATING &&
 	    get_ldev_if_state(device, D_NEGOTIATING)) {
 		int cr; /* consider resync */
-- 
2.17.1


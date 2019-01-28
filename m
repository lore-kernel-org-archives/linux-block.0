Return-Path: <SRS0=89dG=QE=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35C6CC282CF
	for <linux-block@archiver.kernel.org>; Mon, 28 Jan 2019 16:57:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F189320844
	for <linux-block@archiver.kernel.org>; Mon, 28 Jan 2019 16:57:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548694646;
	bh=b+vHH5G6XRFGxHIJtle+zM8EJeG3KKHrhK0J9SjbFzk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=LOfvmekDi5Q5A2glUWHtt3Yfe6bbpMGPbZRKIRmn1N4jJ9QE0slZMR+xfztS48tKK
	 HIm18z3dD7+06H46mkZ7boAl4DQt1zrVGqnZdqibW3bEvVZlRhvF6gvqb8+e52+rL4
	 AzcUiyHyXPcvcKuBwT6Z1u9UHShB2kqSd9DJbVIY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387784AbfA1Q5H (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 28 Jan 2019 11:57:07 -0500
Received: from mail.kernel.org ([198.145.29.99]:51408 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732468AbfA1QRX (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Mon, 28 Jan 2019 11:17:23 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4D14D20879;
        Mon, 28 Jan 2019 16:17:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548692242;
        bh=b+vHH5G6XRFGxHIJtle+zM8EJeG3KKHrhK0J9SjbFzk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=zhj4M/r34K8x4n3w+cuIlgYzZ1Dg9xAoYwI3w9hlklCVTkMeeLYeNNPJAUHt10D1l
         wHcGXb1ksLzuSYgsWl4VkM7A0xfnvqCluAuT7iapsyniLoJMCqS59ac5Dv+3JcTOCW
         9oCwNjoBXDMDQ2yXJkMrRx6o76VpShxYjz1p8PXc=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Lars Ellenberg <lars.ellenberg@linbit.com>,
        Jens Axboe <axboe@kernel.dk>, Sasha Levin <sashal@kernel.org>,
        drbd-dev@lists.linbit.com, linux-block@vger.kernel.org
Subject: [PATCH AUTOSEL 4.14 124/170] drbd: disconnect, if the wrong UUIDs are attached on a connected peer
Date:   Mon, 28 Jan 2019 11:11:14 -0500
Message-Id: <20190128161200.55107-124-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190128161200.55107-1-sashal@kernel.org>
References: <20190128161200.55107-1-sashal@kernel.org>
MIME-Version: 1.0
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

From: Lars Ellenberg <lars.ellenberg@linbit.com>

[ Upstream commit b17b59602b6dcf8f97a7dc7bc489a48388d7063a ]

With "on-no-data-accessible suspend-io", DRBD requires the next attach
or connect to be to the very same data generation uuid tag it lost last.

If we first lost connection to the peer,
then later lost connection to our own disk,
we would usually refuse to re-connect to the peer,
because it presents the wrong data set.

However, if the peer first connects without a disk,
and then attached its disk, we accepted that same wrong data set,
which would be "unexpected" by any user of that DRBD
and cause "undefined results" (read: very likely data corruption).

The fix is to forcefully disconnect as soon as we notice that the peer
attached to the "wrong" dataset.

Signed-off-by: Lars Ellenberg <lars.ellenberg@linbit.com>
Signed-off-by: Jens Axboe <axboe@kernel.dk>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/block/drbd/drbd_receiver.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/block/drbd/drbd_receiver.c b/drivers/block/drbd/drbd_receiver.c
index 143c5a666e25..1aad373da50e 100644
--- a/drivers/block/drbd/drbd_receiver.c
+++ b/drivers/block/drbd/drbd_receiver.c
@@ -4139,7 +4139,7 @@ static int receive_uuids(struct drbd_connection *connection, struct packet_info
 	kfree(device->p_uuid);
 	device->p_uuid = p_uuid;
 
-	if (device->state.conn < C_CONNECTED &&
+	if ((device->state.conn < C_CONNECTED || device->state.pdsk == D_DISKLESS) &&
 	    device->state.disk < D_INCONSISTENT &&
 	    device->state.role == R_PRIMARY &&
 	    (device->ed_uuid & ~((u64)1)) != (p_uuid[UI_CURRENT] & ~((u64)1))) {
-- 
2.19.1


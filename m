Return-Path: <SRS0=89dG=QE=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E25C1C282C8
	for <linux-block@archiver.kernel.org>; Mon, 28 Jan 2019 16:35:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AAFD12084A
	for <linux-block@archiver.kernel.org>; Mon, 28 Jan 2019 16:35:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548693350;
	bh=K+53OXBqfmYLglGWY/EjWaPSMW4nyKFKD7SDVtC97vY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=xLarpGfh5Thx/AMkfvydw6DpfJxucd+edUsEybpRjq7EOkOoeOkuXvwfZ3jY/cGgU
	 keMPK7tvnB/3jcPmM+frnALmP1qgVhJlng8Zj65GNaVXvuYNaujLX/l8rNfvi5oseo
	 FQ/bqhDSjX/yKncxUetPP1ZlK12jvJUZF6vb5iok=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388351AbfA1Qfo (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 28 Jan 2019 11:35:44 -0500
Received: from mail.kernel.org ([198.145.29.99]:34440 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389958AbfA1QZe (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Mon, 28 Jan 2019 11:25:34 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 101722084A;
        Mon, 28 Jan 2019 16:25:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548692733;
        bh=K+53OXBqfmYLglGWY/EjWaPSMW4nyKFKD7SDVtC97vY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=AuBF/5fe5SiRkSaD9pPkoyBYLEwf+SCjZ1KnEx1y82j8AZ71BjNdooqM71qmY2aSL
         LGaYniLo+OXS3LxOPaRh3V+95gxL/nWizMR++X4F+iSRy4a+pT30tkY4GW4rd3fmQw
         SYPAwIVSNz8dMu2Ond1CLepRQrFvIDg2gjHMolwU=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Lars Ellenberg <lars.ellenberg@linbit.com>,
        Jens Axboe <axboe@kernel.dk>, Sasha Levin <sashal@kernel.org>,
        drbd-dev@lists.linbit.com, linux-block@vger.kernel.org
Subject: [PATCH AUTOSEL 4.4 54/80] drbd: disconnect, if the wrong UUIDs are attached on a connected peer
Date:   Mon, 28 Jan 2019 11:23:35 -0500
Message-Id: <20190128162401.58841-54-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190128162401.58841-1-sashal@kernel.org>
References: <20190128162401.58841-1-sashal@kernel.org>
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
index 2fedab9349f6..b1ee358edd3b 100644
--- a/drivers/block/drbd/drbd_receiver.c
+++ b/drivers/block/drbd/drbd_receiver.c
@@ -3890,7 +3890,7 @@ static int receive_uuids(struct drbd_connection *connection, struct packet_info
 	kfree(device->p_uuid);
 	device->p_uuid = p_uuid;
 
-	if (device->state.conn < C_CONNECTED &&
+	if ((device->state.conn < C_CONNECTED || device->state.pdsk == D_DISKLESS) &&
 	    device->state.disk < D_INCONSISTENT &&
 	    device->state.role == R_PRIMARY &&
 	    (device->ed_uuid & ~((u64)1)) != (p_uuid[UI_CURRENT] & ~((u64)1))) {
-- 
2.19.1


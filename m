Return-Path: <SRS0=89dG=QE=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4EE7DC282CD
	for <linux-block@archiver.kernel.org>; Mon, 28 Jan 2019 16:26:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1FD4D2171F
	for <linux-block@archiver.kernel.org>; Mon, 28 Jan 2019 16:26:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548692782;
	bh=yKsmlZx/Z4GFK26nt0bFCgk8J8ErEy32WhXyNwX7F30=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=akRsYKsFdA4Wp1FsOWDD9K2PFJVMHsy7IJr+gRxhXo0s9cV1ctwMQ+73JkeVze+Li
	 VIhFCUS7bUuXhalkjU8bgdSBM9zO7x0HhgtBXRIA5JXIKTZ5iNN5qTMJVr/Jt92f7O
	 F6Ap+Czq+cGjpaqecjdIwEl29WwUw4LRRft5Y9CI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389678AbfA1Q0V (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 28 Jan 2019 11:26:21 -0500
Received: from mail.kernel.org ([198.145.29.99]:35478 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390135AbfA1Q0R (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Mon, 28 Jan 2019 11:26:17 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4F9CC2171F;
        Mon, 28 Jan 2019 16:26:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548692776;
        bh=yKsmlZx/Z4GFK26nt0bFCgk8J8ErEy32WhXyNwX7F30=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=D+NskYGXkEgOdvVnqrJSrJgvv4K1HbHzJYn+dx+yrj+NHimMyYRnGP8ba9qDw9Tk4
         P+y3BJ7e/ICnwGlHe4EzaDU87oTIPil6X3e0SgwSenEBfl+pHPC8hFnd4d94ba6GaJ
         blZ2T0qcW3+jQN90mBi7DTy5m+demfDPeX4N5vKA=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Finn Thain <fthain@telegraphics.com.au>,
        linuxppc-dev@lists.ozlabs.org, Jens Axboe <axboe@kernel.dk>,
        Sasha Levin <sashal@kernel.org>, linux-block@vger.kernel.org
Subject: [PATCH AUTOSEL 4.4 76/80] block/swim3: Fix -EBUSY error when re-opening device after unmount
Date:   Mon, 28 Jan 2019 11:23:57 -0500
Message-Id: <20190128162401.58841-76-sashal@kernel.org>
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

From: Finn Thain <fthain@telegraphics.com.au>

[ Upstream commit 296dcc40f2f2e402facf7cd26cf3f2c8f4b17d47 ]

When the block device is opened with FMODE_EXCL, ref_count is set to -1.
This value doesn't get reset when the device is closed which means the
device cannot be opened again. Fix this by checking for refcount <= 0
in the release method.

Reported-and-tested-by: Stan Johnson <userm57@yahoo.com>
Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Cc: linuxppc-dev@lists.ozlabs.org
Signed-off-by: Finn Thain <fthain@telegraphics.com.au>
Signed-off-by: Jens Axboe <axboe@kernel.dk>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/block/swim3.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/block/swim3.c b/drivers/block/swim3.c
index c264f2d284a7..2e0a9e2531cb 100644
--- a/drivers/block/swim3.c
+++ b/drivers/block/swim3.c
@@ -1027,7 +1027,11 @@ static void floppy_release(struct gendisk *disk, fmode_t mode)
 	struct swim3 __iomem *sw = fs->swim3;
 
 	mutex_lock(&swim3_mutex);
-	if (fs->ref_count > 0 && --fs->ref_count == 0) {
+	if (fs->ref_count > 0)
+		--fs->ref_count;
+	else if (fs->ref_count == -1)
+		fs->ref_count = 0;
+	if (fs->ref_count == 0) {
 		swim3_action(fs, MOTOR_OFF);
 		out_8(&sw->control_bic, 0xff);
 		swim3_select(fs, RELAX);
-- 
2.19.1


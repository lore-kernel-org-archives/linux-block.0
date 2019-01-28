Return-Path: <SRS0=89dG=QE=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 294ECC282C8
	for <linux-block@archiver.kernel.org>; Mon, 28 Jan 2019 16:51:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E31522173C
	for <linux-block@archiver.kernel.org>; Mon, 28 Jan 2019 16:51:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548694318;
	bh=P1BA1bYN0nDZMCHBMMGUpPGUaSDWBxc1mw/30eS3Yxk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=ySg/0uexRQse2fwgv0VhY+Ib7vnVwzaOS6ew644GiS/Xmj5E5Tr+vBIOPbRv25vls
	 rl88PH9NvsBw1ilCV06nK4g56vWi0skdzuE+wPvME/tdhBjCYRkUHLtXlCrb4/3Hp1
	 PnzSlMi5gKeTHCKMeoNdrKa36DKrFNZqd0+k3u0c=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388555AbfA1QTJ (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 28 Jan 2019 11:19:09 -0500
Received: from mail.kernel.org ([198.145.29.99]:53570 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387835AbfA1QTI (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Mon, 28 Jan 2019 11:19:08 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 71F442084A;
        Mon, 28 Jan 2019 16:19:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548692348;
        bh=P1BA1bYN0nDZMCHBMMGUpPGUaSDWBxc1mw/30eS3Yxk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=x3kfbzF4ILI6EGwlld9J4NMyxGTZ1d1rVmPAMILXCJkVKCFozGubxxQRLGIaKRp3G
         YvMUjE8eLMCzZlklqFBRcYZZijxjoPtzkwUBBl40v0Nj+MQR0MwR2vwu852A52ZgHY
         4rSTkvObtC/eK2Aa8wfAAaiGUnwCWuBtaGZDIyEE=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Finn Thain <fthain@telegraphics.com.au>,
        linuxppc-dev@lists.ozlabs.org, Jens Axboe <axboe@kernel.dk>,
        Sasha Levin <sashal@kernel.org>, linux-block@vger.kernel.org
Subject: [PATCH AUTOSEL 4.14 159/170] block/swim3: Fix -EBUSY error when re-opening device after unmount
Date:   Mon, 28 Jan 2019 11:11:49 -0500
Message-Id: <20190128161200.55107-159-sashal@kernel.org>
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
index 0d7527c6825a..2f7acdb830c3 100644
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


Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39D0BC43217
	for <linux-block@archiver.kernel.org>; Tue, 12 Apr 2022 00:51:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244556AbiDLAxz (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 11 Apr 2022 20:53:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345007AbiDLAxg (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 11 Apr 2022 20:53:36 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37A7931909;
        Mon, 11 Apr 2022 17:48:42 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A287A617D9;
        Tue, 12 Apr 2022 00:48:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 17A72C385AC;
        Tue, 12 Apr 2022 00:48:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1649724521;
        bh=/5HPItxFIZfMlhG76iLXGwbpMNMv5fQZGhvnKRZ1lhg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=QvcUks5JKFsJmZaJwCgW2+lID6d81g4I0Vp28u+MeFEUbuX2Pl90xEmWKkHcOdrQL
         bHitt0g0aWdEn85VMRPHkwP0Kii9v4XHS3r6J0RtZ6kRFy/FNr0OVpSVMbpuJ0Yd9R
         /H6Y7GUc6jvUaDxcKcXafkRwSG8XOD5ILekmcyI2uUMVgx7CkOPO65wNxzfvt16yYP
         LTvxgU3bUHtv05cIYk+ja5QvMZzPT2BaNqg/tJFXV5QHC0JBYKtYLyi8jWs060IEh1
         dMYwQhaRppSUdSh/ERiUA0sekmJuRJUbPOTt+weAuqdWxbWDZwovzSj3kakRFhjHcw
         jrf6LY2vrMDVg==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     =?UTF-8?q?Christoph=20B=C3=B6hmwalder?= <christoph@boehmwalder.at>,
        =?UTF-8?q?Christoph=20B=C3=B6hmwalder?= 
        <christoph.boehmwalder@linbit.com>, Jens Axboe <axboe@kernel.dk>,
        Sasha Levin <sashal@kernel.org>, philipp.reisner@linbit.com,
        lars.ellenberg@linbit.com, drbd-dev@lists.linbit.com,
        linux-block@vger.kernel.org
Subject: [PATCH AUTOSEL 5.15 32/41] drbd: set QUEUE_FLAG_STABLE_WRITES
Date:   Mon, 11 Apr 2022 20:46:44 -0400
Message-Id: <20220412004656.350101-32-sashal@kernel.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220412004656.350101-1-sashal@kernel.org>
References: <20220412004656.350101-1-sashal@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

From: Christoph Böhmwalder <christoph@boehmwalder.at>

[ Upstream commit 286901941fd18a52b2138fddbbf589ad3639eb00 ]

We want our pages not to change while they are being written.

Signed-off-by: Christoph Böhmwalder <christoph.boehmwalder@linbit.com>
Signed-off-by: Jens Axboe <axboe@kernel.dk>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/block/drbd/drbd_main.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/block/drbd/drbd_main.c b/drivers/block/drbd/drbd_main.c
index 55234a558e98..548e0dd53528 100644
--- a/drivers/block/drbd/drbd_main.c
+++ b/drivers/block/drbd/drbd_main.c
@@ -2737,6 +2737,7 @@ enum drbd_ret_code drbd_create_device(struct drbd_config_context *adm_ctx, unsig
 	sprintf(disk->disk_name, "drbd%d", minor);
 	disk->private_data = device;
 
+	blk_queue_flag_set(QUEUE_FLAG_STABLE_WRITES, disk->queue);
 	blk_queue_write_cache(disk->queue, true, true);
 	/* Setting the max_hw_sectors to an odd value of 8kibyte here
 	   This triggers a max_bio_size message upon first attach or connect */
-- 
2.35.1


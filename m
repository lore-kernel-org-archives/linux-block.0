Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9493EC433EF
	for <linux-block@archiver.kernel.org>; Tue, 12 Apr 2022 00:47:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238924AbiDLAuJ (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 11 Apr 2022 20:50:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242780AbiDLAtm (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 11 Apr 2022 20:49:42 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3CC431353;
        Mon, 11 Apr 2022 17:46:28 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 439B2B819BF;
        Tue, 12 Apr 2022 00:46:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C04D2C385AA;
        Tue, 12 Apr 2022 00:46:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1649724386;
        bh=2e0jq/evzzp72OOQns/pI1E227qzHF0St3k76GBwMvg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=diBWR08gLRo3tpu5vlz4bv/ks6khcjYmBZPtJLoWiM8siZQdJYCcpTKoTQtU16/XP
         tGMlhs+J3nIG4bW1VeNn4jKefav5mLQInOZJ2DH7qp/zJsm6aOszmfpU5hyCr9ecqk
         zgVwoBTlfKDGKarZfqemPf2xOknaxy/mBCVcTF21097c3NHL5CKtJP7oE/hHvZ3LNB
         8LxO43OIcJAy1S2mH4Ua4ZfvJJyWIB8gQXduy/1oxN4kRrgUBGOukwTW9P4deuclAF
         MxW9TsH8QSpi4UoSVpLNdjDLRpBusFwHXjIzKD1zFqWjUTPWk6I/YbFoljbI1w3yNW
         hyiK/qI4u0WGg==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     =?UTF-8?q?Christoph=20B=C3=B6hmwalder?= <christoph@boehmwalder.at>,
        =?UTF-8?q?Christoph=20B=C3=B6hmwalder?= 
        <christoph.boehmwalder@linbit.com>, Jens Axboe <axboe@kernel.dk>,
        Sasha Levin <sashal@kernel.org>, philipp.reisner@linbit.com,
        lars.ellenberg@linbit.com, drbd-dev@lists.linbit.com,
        linux-block@vger.kernel.org
Subject: [PATCH AUTOSEL 5.17 39/49] drbd: set QUEUE_FLAG_STABLE_WRITES
Date:   Mon, 11 Apr 2022 20:43:57 -0400
Message-Id: <20220412004411.349427-39-sashal@kernel.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220412004411.349427-1-sashal@kernel.org>
References: <20220412004411.349427-1-sashal@kernel.org>
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
index 6f450816c4fa..b971e126624e 100644
--- a/drivers/block/drbd/drbd_main.c
+++ b/drivers/block/drbd/drbd_main.c
@@ -2739,6 +2739,7 @@ enum drbd_ret_code drbd_create_device(struct drbd_config_context *adm_ctx, unsig
 	sprintf(disk->disk_name, "drbd%d", minor);
 	disk->private_data = device;
 
+	blk_queue_flag_set(QUEUE_FLAG_STABLE_WRITES, disk->queue);
 	blk_queue_write_cache(disk->queue, true, true);
 	/* Setting the max_hw_sectors to an odd value of 8kibyte here
 	   This triggers a max_bio_size message upon first attach or connect */
-- 
2.35.1


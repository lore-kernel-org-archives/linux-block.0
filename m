Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D1B1C61DA4
	for <linux-block@archiver.kernel.org>; Fri, 24 Feb 2023 02:13:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229735AbjBXCNU (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 23 Feb 2023 21:13:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229670AbjBXCNT (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 23 Feb 2023 21:13:19 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D43944BF
        for <linux-block@vger.kernel.org>; Thu, 23 Feb 2023 18:13:09 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id D5245B81BC5
        for <linux-block@vger.kernel.org>; Fri, 24 Feb 2023 02:13:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5B741C433D2;
        Fri, 24 Feb 2023 02:13:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1677204786;
        bh=qGoYP20O9saJ3einB7QzEr3C54c5dcnleXGfLllaVrU=;
        h=From:To:Cc:Subject:Date:From;
        b=SBPio0wExy/6wYZjTyWsnwSgdKqEfQiDd0iF4YPb4zrXRa0HQ0Vmi8UYBgEwn2WzT
         +Ssz9iVsErkQR+HYOWXAL5Grfnnzh4GW7tC//Qbb03mpbUVpwWNtD30LibIkcuvRKC
         IBSv6M7qvPAD5k4l4WjL5WyCUZ9omsboblPusdY+/f+UL76fmcJN3wY68aGcvOyNSf
         Wq6VQnxvumZ/w/C3LG13abgja+iyf+/tggVCPo3MnZeJL/9jscruZ9TVOrXGa9oh3P
         JUomA65xvKT07MxbQnJC9TKTKIzi39zphqzGWXSduJytw8nsxbXRt36fof95ab5lMa
         AX2B2WJmwuR4A==
From:   Jakub Kicinski <kuba@kernel.org>
To:     josef@toxicpanda.com, axboe@kernel.dk
Cc:     linux-block@vger.kernel.org, nbd@other.debian.org,
        Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH -next 1/2] nbd: allow genl access outside init_net
Date:   Thu, 23 Feb 2023 18:13:00 -0800
Message-Id: <20230224021301.1630703-1-kuba@kernel.org>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

NBD doesn't have much to do with networking, allow users outside
init_net to access the family.

Reviewed-by: Josef Bacik <josef@toxicpanda.com>
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
 drivers/block/nbd.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/block/nbd.c b/drivers/block/nbd.c
index 592cfa8b765a..53e4bb754fd9 100644
--- a/drivers/block/nbd.c
+++ b/drivers/block/nbd.c
@@ -2325,6 +2325,7 @@ static struct genl_family nbd_genl_family __ro_after_init = {
 	.n_small_ops	= ARRAY_SIZE(nbd_connect_genl_ops),
 	.resv_start_op	= NBD_CMD_STATUS + 1,
 	.maxattr	= NBD_ATTR_MAX,
+	.netnsok	= 1,
 	.policy = nbd_attr_policy,
 	.mcgrps		= nbd_mcast_grps,
 	.n_mcgrps	= ARRAY_SIZE(nbd_mcast_grps),
-- 
2.39.2


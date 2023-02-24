Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F0E3C64ED6
	for <linux-block@archiver.kernel.org>; Fri, 24 Feb 2023 02:13:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229525AbjBXCNT (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 23 Feb 2023 21:13:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229731AbjBXCNT (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 23 Feb 2023 21:13:19 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63ECC76B0
        for <linux-block@vger.kernel.org>; Thu, 23 Feb 2023 18:13:08 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0882D617F5
        for <linux-block@vger.kernel.org>; Fri, 24 Feb 2023 02:13:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C75EDC4339C;
        Fri, 24 Feb 2023 02:13:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1677204787;
        bh=T8YO7qXXdDcbhXt6SJCPTF2VjXN2yI62KcTq2wDk2q4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=MASLMNP1qw4o4usT4FsOvqS8IfjZwYxD2sVnCWyULhwL6qFYaipczV1x+yWUmH3b3
         3R6Cq/yI95y9JdiY6TeHl9IH/JAnSncmZP0xJRlr1hoA6Zb7z8fsUGa6PE56PeOHxL
         qVBW1+IerHmI56vlvfFFsVYvYqsNdWohDtYzeeQzCqomziIzQTS4ZDrpJ9O3iurt1S
         Aw/GiL6bu8+WHcv2DhIkZA5DyRrP/2G/OxRmrazNGUdQG251WxvZkBNBRmlkL+HEKW
         NoXnfvVZLaRIYKZ3lWoM/NP6JtVpxtWrgtyWkTRX4iJV+FQ4CW1EYRzRhb31bCAS9v
         vjJuHUMM5rcUA==
From:   Jakub Kicinski <kuba@kernel.org>
To:     josef@toxicpanda.com, axboe@kernel.dk
Cc:     linux-block@vger.kernel.org, nbd@other.debian.org,
        Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH -next 2/2] nbd: use the structured req attr check
Date:   Thu, 23 Feb 2023 18:13:01 -0800
Message-Id: <20230224021301.1630703-2-kuba@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230224021301.1630703-1-kuba@kernel.org>
References: <20230224021301.1630703-1-kuba@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Use the macro for checking presence of required attributes.
It has the advantage of reporting to the user which attr
was missing in a machine-readable format (extack).

Reviewed-by: Josef Bacik <josef@toxicpanda.com>
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
 drivers/block/nbd.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/block/nbd.c b/drivers/block/nbd.c
index 53e4bb754fd9..c0b1611b9665 100644
--- a/drivers/block/nbd.c
+++ b/drivers/block/nbd.c
@@ -1934,11 +1934,11 @@ static int nbd_genl_connect(struct sk_buff *skb, struct genl_info *info)
 			return -EINVAL;
 		}
 	}
-	if (!info->attrs[NBD_ATTR_SOCKETS]) {
+	if (GENL_REQ_ATTR_CHECK(info, NBD_ATTR_SOCKETS)) {
 		pr_err("must specify at least one socket\n");
 		return -EINVAL;
 	}
-	if (!info->attrs[NBD_ATTR_SIZE_BYTES]) {
+	if (GENL_REQ_ATTR_CHECK(info, NBD_ATTR_SIZE_BYTES)) {
 		pr_err("must specify a size in bytes for the device\n");
 		return -EINVAL;
 	}
@@ -2123,7 +2123,7 @@ static int nbd_genl_disconnect(struct sk_buff *skb, struct genl_info *info)
 	if (!netlink_capable(skb, CAP_SYS_ADMIN))
 		return -EPERM;
 
-	if (!info->attrs[NBD_ATTR_INDEX]) {
+	if (GENL_REQ_ATTR_CHECK(info, NBD_ATTR_INDEX)) {
 		pr_err("must specify an index to disconnect\n");
 		return -EINVAL;
 	}
@@ -2161,7 +2161,7 @@ static int nbd_genl_reconfigure(struct sk_buff *skb, struct genl_info *info)
 	if (!netlink_capable(skb, CAP_SYS_ADMIN))
 		return -EPERM;
 
-	if (!info->attrs[NBD_ATTR_INDEX]) {
+	if (GENL_REQ_ATTR_CHECK(info, NBD_ATTR_INDEX)) {
 		pr_err("must specify a device to reconfigure\n");
 		return -EINVAL;
 	}
-- 
2.39.2


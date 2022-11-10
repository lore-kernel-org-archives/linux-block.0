Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26CA2C433FE
	for <linux-block@archiver.kernel.org>; Thu, 10 Nov 2022 05:25:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231899AbiKJFY6 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 10 Nov 2022 00:24:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229484AbiKJFY5 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 10 Nov 2022 00:24:57 -0500
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BFE06275FC;
        Wed,  9 Nov 2022 21:24:55 -0800 (PST)
From:   =?UTF-8?q?Thomas=20Wei=C3=9Fschuh?= <linux@weissschuh.net>
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=weissschuh.net;
        s=mail; t=1668057892;
        bh=SIhRYzH//kwaIhdzxST5+Pe24phe7wR7IiS7fLDVIpw=;
        h=From:To:Cc:Subject:Date:From;
        b=EeFpj9ulPKz3ANUzNLdzFGp0I0wnfEyPM0MMNAaFFz/+nWhods7DWc9sKzj8tPZCI
         2+j4VswE9Abb621YrWji9yDudR+qwgbNRDdM/ZL2k8Hg+cdrUZnz15yODHCmkbtHQs
         AH3ueKjuGAVWaMaexKLAnNhPeprXY9QeN9yWLz4I=
To:     Josef Bacik <josef@toxicpanda.com>, Jens Axboe <axboe@kernel.dk>,
        linux-block@vger.kernel.org, nbd@other.debian.org
Cc:     =?UTF-8?q?Thomas=20Wei=C3=9Fschuh?= <linux@weissschuh.net>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] nbd: automatically load module on genl access
Date:   Thu, 10 Nov 2022 06:24:38 +0100
Message-Id: <20221110052438.2188-1-linux@weissschuh.net>
X-Mailer: git-send-email 2.38.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=ed25519-sha256; t=1668057875; l=727; i=linux@weissschuh.net; s=20211113; h=from:subject; bh=SIhRYzH//kwaIhdzxST5+Pe24phe7wR7IiS7fLDVIpw=; b=TamtngLw5uGYaOiLQpg88P6iUzWfM1ZrfLyQNTSb9ffqCXcn6aghwLYi7eM0GXA0YO6yiR2sr1Hs UqDN2rPwBKx/saBBKi9xXSwr5k8/LNpPVAGDlsq5M6JV4imnTuxh
X-Developer-Key: i=linux@weissschuh.net; a=ed25519; pk=9LP6KM4vD/8CwHW7nouRBhWLyQLcK1MkP6aTZbzUlj4=
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Instead of forcing the user to manually load the module do it
automatically.

Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
---
 drivers/block/nbd.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/block/nbd.c b/drivers/block/nbd.c
index 5cffd96ef2d7..1c38a7ea9531 100644
--- a/drivers/block/nbd.c
+++ b/drivers/block/nbd.c
@@ -2328,6 +2328,7 @@ static struct genl_family nbd_genl_family __ro_after_init = {
 	.mcgrps		= nbd_mcast_grps,
 	.n_mcgrps	= ARRAY_SIZE(nbd_mcast_grps),
 };
+MODULE_ALIAS_GENL_FAMILY(NBD_GENL_FAMILY_NAME);
 
 static int populate_nbd_status(struct nbd_device *nbd, struct sk_buff *reply)
 {

base-commit: f67dd6ce0723ad013395f20a3f79d8a437d3f455
-- 
2.38.1


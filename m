Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F37A4C77B7F
	for <linux-block@archiver.kernel.org>; Sat, 20 May 2023 18:25:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232148AbjETSZV (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sat, 20 May 2023 14:25:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232277AbjETSYy (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sat, 20 May 2023 14:24:54 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01B0E102;
        Sat, 20 May 2023 11:24:20 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 769CF60F93;
        Sat, 20 May 2023 18:23:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 17A2EC433EF;
        Sat, 20 May 2023 18:23:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684606988;
        bh=GvfVLh0xslhqQZCC5ZbYUdLOhnZzzutdUD+WkBUB9h4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=D5LK6BDju9zyxWgrTr0BB4fbRu77qbC5Iilz1qYbdLv9V8gxKLF1PbjuqSb5pzr31
         x6FTdTClZvVEtbF2GIV65Var9oFrSIx6bjQvEsZNgxsFgXFbwdFzkx0QOUUssDUCiZ
         N12wukSckf7ofAeHLfy/XiWb2fbXrOvjBbn7GqR/TuHxWNtNh5rQtNuBTa+kdv8Iqq
         cce4OR8C+LYZbUcGgL4rZuYbznZ1fiLl4xqflC94ZrORLB+WzgXe2irzZvS0UJI+OI
         6WUQHYUGy/LAln4pU9eX9E7qqVmKxsSZZ4yRFA2EUhRodgNuHKD/FAkaFPU1rRLHWO
         rtBJHZGt+Akwg==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Ivan Orlov <ivan.orlov0322@gmail.com>,
        Jens Axboe <axboe@kernel.dk>, Sasha Levin <sashal@kernel.org>,
        josef@toxicpanda.com, linux-block@vger.kernel.org,
        nbd@other.debian.org
Subject: [PATCH AUTOSEL 5.15 10/11] nbd: Fix debugfs_create_dir error checking
Date:   Sat, 20 May 2023 14:22:13 -0400
Message-Id: <20230520182215.845131-10-sashal@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230520182215.845131-1-sashal@kernel.org>
References: <20230520182215.845131-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

From: Ivan Orlov <ivan.orlov0322@gmail.com>

[ Upstream commit 4913cfcf014c95f0437db2df1734472fd3e15098 ]

The debugfs_create_dir function returns ERR_PTR in case of error, and the
only correct way to check if an error occurred is 'IS_ERR' inline function.
This patch will replace the null-comparison with IS_ERR.

Signed-off-by: Ivan Orlov <ivan.orlov0322@gmail.com>
Link: https://lore.kernel.org/r/20230512130533.98709-1-ivan.orlov0322@gmail.com
Signed-off-by: Jens Axboe <axboe@kernel.dk>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/block/nbd.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/block/nbd.c b/drivers/block/nbd.c
index ade8b839e4458..2a78530fed088 100644
--- a/drivers/block/nbd.c
+++ b/drivers/block/nbd.c
@@ -1599,7 +1599,7 @@ static int nbd_dev_dbg_init(struct nbd_device *nbd)
 		return -EIO;
 
 	dir = debugfs_create_dir(nbd_name(nbd), nbd_dbg_dir);
-	if (!dir) {
+	if (IS_ERR(dir)) {
 		dev_err(nbd_to_dev(nbd), "Failed to create debugfs dir for '%s'\n",
 			nbd_name(nbd));
 		return -EIO;
@@ -1625,7 +1625,7 @@ static int nbd_dbg_init(void)
 	struct dentry *dbg_dir;
 
 	dbg_dir = debugfs_create_dir("nbd", NULL);
-	if (!dbg_dir)
+	if (IS_ERR(dbg_dir))
 		return -EIO;
 
 	nbd_dbg_dir = dbg_dir;
-- 
2.39.2


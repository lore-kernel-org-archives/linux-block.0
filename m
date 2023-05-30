Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F428C7EE31
	for <linux-block@archiver.kernel.org>; Tue, 30 May 2023 17:10:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232806AbjE3RKG (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 30 May 2023 13:10:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231252AbjE3RKD (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 30 May 2023 13:10:03 -0400
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9954C5;
        Tue, 30 May 2023 10:10:01 -0700 (PDT)
From:   =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
        s=mail; t=1685466599;
        bh=TDcsEObqDEqUFLkaZxdwkd+rbgOVyl6Oeik3NcBOSJo=;
        h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
        b=NVp1GAsc19XCcuvXfWwL4+XSe4WPk8xkDet4rXnspI2mkeaOZAay9LskXQsImgW9B
         urF5EHovX1hXysn8AKuGSu1/c0qbYigqKProQ1FTA46qk/fDx0Ds+W3NeB7JqWp8N9
         Kof9jDuAgN0sShbMQVKkj66ZjH4ACbqmPXtODpbA=
Date:   Tue, 30 May 2023 19:09:58 +0200
Subject: [PATCH v3 2/4] block: constify struct part_type part_type
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20230419-const-partition-v3-2-4e14e48be367@weissschuh.net>
References: <20230419-const-partition-v3-0-4e14e48be367@weissschuh.net>
In-Reply-To: <20230419-const-partition-v3-0-4e14e48be367@weissschuh.net>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1685466599; l=1107;
 i=linux@weissschuh.net; s=20221212; h=from:subject:message-id;
 bh=TDcsEObqDEqUFLkaZxdwkd+rbgOVyl6Oeik3NcBOSJo=;
 b=oSjURq96HBDYpKY4JnJWySWXwkVKz7vIQEklCwkAZjytNGPBfRim/ebjLzos8T71z3svTYHrU
 fTq8h33Ac+BCFjyMYG6aylqqquIJCwO14CHEv7SYZ/gpPTmN2B2dxUJ
X-Developer-Key: i=linux@weissschuh.net; a=ed25519;
 pk=KcycQgFPX2wGR5azS7RhpBqedglOZVgRPfdFSPB1LNw=
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

The struct is never modified so it can be const.

Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
---
 block/partitions/core.c | 2 +-
 include/linux/blkdev.h  | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/block/partitions/core.c b/block/partitions/core.c
index 650603dbe557..2bc21063edef 100644
--- a/block/partitions/core.c
+++ b/block/partitions/core.c
@@ -256,7 +256,7 @@ static int part_uevent(const struct device *dev, struct kobj_uevent_env *env)
 	return 0;
 }
 
-struct device_type part_type = {
+const struct device_type part_type = {
 	.name		= "partition",
 	.groups		= part_attr_groups,
 	.release	= part_release,
diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index b2ac587e3402..d89c2da14698 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -41,7 +41,7 @@ struct blk_stat_callback;
 struct blk_crypto_profile;
 
 extern const struct device_type disk_type;
-extern struct device_type part_type;
+extern const struct device_type part_type;
 extern struct class block_class;
 
 /*

-- 
2.40.1


Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7165C77B75
	for <linux-block@archiver.kernel.org>; Wed, 19 Apr 2023 13:23:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233383AbjDSNXW (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 19 Apr 2023 09:23:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232538AbjDSNXV (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 19 Apr 2023 09:23:21 -0400
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BAAB09D;
        Wed, 19 Apr 2023 06:22:57 -0700 (PDT)
From:   =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
        s=mail; t=1681910575;
        bh=/NP/SzJYqje2B6An2X0zaHYKDmfg6cIoTAC4LTa0nsU=;
        h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
        b=DjC6xogZ8vdoAuknx8BDGfPaRnykrz9xcRbgVW7nzGMeqQ50VZGDA3DvVCHBfD/nJ
         WqAt4yvnq17RtZOl7UY/0OluKSeGw6C655enulLswcs2Yn+oyuMF1qiUjhWQQeNQuT
         zoZMF/ERau7yAZyzo+ehmaJXuufOS5qB5EcTPvn8=
Date:   Wed, 19 Apr 2023 15:22:54 +0200
Subject: [PATCH v2 2/4] block: constify struct part_type part_type
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20230419-const-partition-v2-2-817b58f85cd1@weissschuh.net>
References: <20230419-const-partition-v2-0-817b58f85cd1@weissschuh.net>
In-Reply-To: <20230419-const-partition-v2-0-817b58f85cd1@weissschuh.net>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1681910574; l=1158;
 i=linux@weissschuh.net; s=20221212; h=from:subject:message-id;
 bh=/NP/SzJYqje2B6An2X0zaHYKDmfg6cIoTAC4LTa0nsU=;
 b=RVEwfL+7+5QpTdEBliTOBBgh4In8m9UisuGjkigMRMGT226hZAkSI0rhApMZVMjiPiKT2DD/r
 M3GggOalo1+DiojreFTyVLjtR78spWyBhje4gDEmoB2zUBnRPehI5jC
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
index 890072ae5c7c..43bde8118a78 100644
--- a/block/partitions/core.c
+++ b/block/partitions/core.c
@@ -264,7 +264,7 @@ static int part_uevent(const struct device *dev, struct kobj_uevent_env *env)
 	return 0;
 }
 
-struct device_type part_type = {
+const struct device_type part_type = {
 	.name		= "partition",
 	.groups		= part_attr_groups,
 	.release	= part_release,
diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index 941304f17492..de783481ec71 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -41,7 +41,7 @@ struct blk_stat_callback;
 struct blk_crypto_profile;
 
 extern const struct device_type disk_type;
-extern struct device_type part_type;
+extern const struct device_type part_type;
 extern struct class block_class;
 
 /* Must be consistent with blk_mq_poll_stats_bkt() */

-- 
2.40.0


Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C40D3C77B7F
	for <linux-block@archiver.kernel.org>; Wed, 19 Apr 2023 13:23:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233460AbjDSNXY (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 19 Apr 2023 09:23:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233285AbjDSNXW (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 19 Apr 2023 09:23:22 -0400
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ABF871544B;
        Wed, 19 Apr 2023 06:22:57 -0700 (PDT)
From:   =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
        s=mail; t=1681910575;
        bh=8DxUrecEQXlbonVWV4Ctfw1+JpOz8+kV4zNOKiNZtnI=;
        h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
        b=EuPD8BRIlvKUCLVjp7Upw3ZZO5pD4ibHJE9vtrc4epUR2LZaoLh9ECIH+2n32WZ4m
         cjxNEGlufps3Mm6d4lT5ibxTd1/9caMUNAT0U/0V9ZjKhemjWY9rC8g/1NDoV+ZNNy
         /9K9OkyjZ35rAPk5FiE7xu0MlAS46KPL/txh+XUg=
Date:   Wed, 19 Apr 2023 15:22:56 +0200
Subject: [PATCH v2 4/4] block: constify the whole_disk device_attribute
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20230419-const-partition-v2-4-817b58f85cd1@weissschuh.net>
References: <20230419-const-partition-v2-0-817b58f85cd1@weissschuh.net>
In-Reply-To: <20230419-const-partition-v2-0-817b58f85cd1@weissschuh.net>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1681910574; l=692;
 i=linux@weissschuh.net; s=20221212; h=from:subject:message-id;
 bh=8DxUrecEQXlbonVWV4Ctfw1+JpOz8+kV4zNOKiNZtnI=;
 b=W8wtHEqlEeRjokNrSDbMW0sWD5kabWuQvCIsJIndbub7dUQ4ew9L9Tn1wyDt7ehZLINwcbk5q
 EJhucksR1XXAklmW8BR7VVTUdQzMu/jEbFgwm4/erFLRVkb9Mop3OdE
X-Developer-Key: i=linux@weissschuh.net; a=ed25519;
 pk=KcycQgFPX2wGR5azS7RhpBqedglOZVgRPfdFSPB1LNw=
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

The struct is never modified so it can be const.

Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
---
 block/partitions/core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/block/partitions/core.c b/block/partitions/core.c
index cb37ac71868e..302ac06708e6 100644
--- a/block/partitions/core.c
+++ b/block/partitions/core.c
@@ -296,7 +296,7 @@ static ssize_t whole_disk_show(struct device *dev,
 {
 	return 0;
 }
-static DEVICE_ATTR(whole_disk, 0444, whole_disk_show, NULL);
+static const DEVICE_ATTR(whole_disk, 0444, whole_disk_show, NULL);
 
 /*
  * Must be called either with open_mutex held, before a disk can be opened or

-- 
2.40.0


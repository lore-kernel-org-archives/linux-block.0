Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1F28ECAAA1
	for <linux-block@archiver.kernel.org>; Fri,  9 Sep 2022 19:48:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231722AbiIITs2 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 9 Sep 2022 15:48:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232037AbiIITsC (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Fri, 9 Sep 2022 15:48:02 -0400
Received: from m12-11.163.com (m12-11.163.com [220.181.12.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 325235F4A;
        Fri,  9 Sep 2022 12:46:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=FVEfS
        rk5J5IIRdUuiB6oe+nFzivav0mW+6GBZvPewIs=; b=IU/HTleg6WQ42T4HZYEnu
        rWbzkHdKM4f5US520C+BY3bs5IiQqJU5tcplpDa+12ayk1axg8Hrw7EDC5PK01Q7
        VrOT8mBYstXM9O0cgwm2P8WtZQ454dDhaNGrCwdiB9mu68viavmiOqxDJD/Mugln
        dRj0TWkVaeH6p+gs6KfUcQ=
Received: from f00160-VMware-Virtual-Platform.localdomain (unknown [1.203.67.201])
        by smtp7 (Coremail) with SMTP id C8CowABXQQzrlxtj40tnEg--.50296S4;
        Sat, 10 Sep 2022 03:46:01 +0800 (CST)
From:   Jingyu Wang <jingyuwang_vip@163.com>
To:     axboe@kernel.dk
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jingyu Wang <jingyuwang_vip@163.com>
Subject: [PATCH] block: remove unneeded "default n" options
Date:   Sat, 10 Sep 2022 03:45:45 +0800
Message-Id: <20220909194545.85603-1-jingyuwang_vip@163.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: C8CowABXQQzrlxtj40tnEg--.50296S4
X-Coremail-Antispam: 1Uf129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7v73
        VFW2AGmfu7bjvjm3AaLaJ3UbIYCTnIWIevJa73UjIFyTuYvjTRN9NsUUUUU
X-Originating-IP: [1.203.67.201]
X-CM-SenderInfo: 5mlqw5xxzd0whbyl1qqrwthudrp/1tbishl3F1UMWVTLewAAsv
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Remove "default n" options. If the "default" line is removed, it
defaults to 'n'.

Signed-off-by: Jingyu Wang <jingyuwang_vip@163.com>
---
 block/Kconfig | 1 -
 1 file changed, 1 deletion(-)

diff --git a/block/Kconfig b/block/Kconfig
index d4fdd606d138..d9dd24697967 100644
--- a/block/Kconfig
+++ b/block/Kconfig
@@ -50,7 +50,6 @@ config BLK_ICQ
 
 config BLK_USE_PIN_USER_PAGES_FOR_DIO
 	bool "DEVELOPERS ONLY: Enable pin_user_pages() for Direct IO" if EXPERT
-	default n
 
 	help
 	  For Direct IO code, retain the pages via calls to

base-commit: 5957ac6635a1a12d4aa2661bbf04d3085a73372a
-- 
2.34.1


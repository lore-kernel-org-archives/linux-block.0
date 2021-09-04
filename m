Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 124BDC433FE
	for <linux-block@archiver.kernel.org>; Sat,  4 Sep 2021 01:35:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EE4C9610E8
	for <linux-block@archiver.kernel.org>; Sat,  4 Sep 2021 01:35:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350895AbhIDBgn (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 3 Sep 2021 21:36:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350771AbhIDBgk (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Fri, 3 Sep 2021 21:36:40 -0400
Received: from bombadil.infradead.org (unknown [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 104F9C0613C1;
        Fri,  3 Sep 2021 18:35:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
        Reply-To:Content-Type:Content-ID:Content-Description;
        bh=Uv9uzZRZiSomd0grs8gpdrysc8mwEPeeq1yOKtuyNSs=; b=tIAdt3WSbkxOdy+ZBYLPq8U2J3
        UF6JKXyNMSINNB505WQzs+B0tYd2wqv8lLZfP4f+PwGG5NvOlY/wx9sxSbRe1Wwu5sFiPt3cGw8wh
        vG+QtTDPZJec2cQAqf1Dy2u9KYy9NmlKX3It1dYmehSxqKJPT3RQAry0KpRp7Td8MT8zLRRU6FUXo
        bJ7GSEBuebFbxwm75+eiplLOBtFO6nR1GuyfH+JeVUgyhPl4uXhX1m1/HWtoqXpSkhcr11BCKw9Wi
        YmyW7BcJD++nbO0SVjWtnlbGqDongnYotIQyf3um3GKc4KifqAw/rTjwiPoh45/JMB6jQQDg1xbS9
        1jE1wcbA==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mMKan-00DLb8-BU; Sat, 04 Sep 2021 01:35:37 +0000
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     axboe@kernel.dk, efremov@linux.com, hch@lst.de
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        Luis Chamberlain <mcgrof@kernel.org>
Subject: [PATCH 04/14] floppy: fix calling platform_device_unregister() on invalid drives
Date:   Fri,  3 Sep 2021 18:35:26 -0700
Message-Id: <20210904013536.3181237-5-mcgrof@kernel.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210904013536.3181237-1-mcgrof@kernel.org>
References: <20210904013536.3181237-1-mcgrof@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Luis Chamberlain <mcgrof@infradead.org>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

platform_device_unregister() should only be called when
a respective platform_device_register() is called. However
the floppy driver currently allows failures when registring
a drive and a bail out could easily cause an invalid call
to platform_device_unregister() where it was not intended.

Fix this by adding a bool to keep track of when the platform
device was registered for a drive.

This does not fix any known panic / bug. This issue was found
through code inspection while preparing the driver to use the
up and coming support for device_add_disk() error handling.
From what I can tell from code inspection, chances of this
ever happening should be insanely small, perhaps OOM.

Signed-off-by: Luis Chamberlain <mcgrof@kernel.org>
---
 drivers/block/floppy.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/block/floppy.c b/drivers/block/floppy.c
index 9538146e520e..3592a6277d0b 100644
--- a/drivers/block/floppy.c
+++ b/drivers/block/floppy.c
@@ -4478,6 +4478,7 @@ static const struct blk_mq_ops floppy_mq_ops = {
 };
 
 static struct platform_device floppy_device[N_DRIVE];
+static bool registered[N_DRIVE];
 
 static bool floppy_available(int drive)
 {
@@ -4693,6 +4694,8 @@ static int __init do_floppy_init(void)
 		if (err)
 			goto out_remove_drives;
 
+		registered[drive] = true;
+
 		device_add_disk(&floppy_device[drive].dev, disks[drive][0],
 				NULL);
 	}
@@ -4703,7 +4706,8 @@ static int __init do_floppy_init(void)
 	while (drive--) {
 		if (floppy_available(drive)) {
 			del_gendisk(disks[drive][0]);
-			platform_device_unregister(&floppy_device[drive]);
+			if (registered[drive])
+				platform_device_unregister(&floppy_device[drive]);
 		}
 	}
 out_release_dma:
@@ -4946,7 +4950,8 @@ static void __exit floppy_module_exit(void)
 				if (disks[drive][i])
 					del_gendisk(disks[drive][i]);
 			}
-			platform_device_unregister(&floppy_device[drive]);
+			if (registered[drive])
+				platform_device_unregister(&floppy_device[drive]);
 		}
 		for (i = 0; i < ARRAY_SIZE(floppy_type); i++) {
 			if (disks[drive][i])
-- 
2.30.2


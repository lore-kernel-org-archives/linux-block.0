Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8567C432BE
	for <linux-block@archiver.kernel.org>; Fri, 27 Aug 2021 16:33:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C1BF960F25
	for <linux-block@archiver.kernel.org>; Fri, 27 Aug 2021 16:33:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231318AbhH0Qe0 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 27 Aug 2021 12:34:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229675AbhH0Qe0 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 27 Aug 2021 12:34:26 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 845A1C061757
        for <linux-block@vger.kernel.org>; Fri, 27 Aug 2021 09:33:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
        Content-Description:In-Reply-To:References;
        bh=1URcjbbjZ3swUwmmZMnRIG3GA8SEb0BVjblaSkTy8To=; b=I5x1pXmJ15yOM92n5fWyoW60Uw
        Pi5/CFojG04bDP8pAP2rXu+8KL89NP6aNh2Hov7ePk6jO3gl5KYELrMm4xg9LEGKq7dMCe+eIqeKM
        bn9cPKublFHSnfQpcR99CN0JF0cYeRvMqG9D3JTvU93k7FhqwOD3oNnNvuPtbUUzEMBddwvDb4hje
        VpzJeS6hUUHWkdyG0XYNPcaP/KuYxPTCqfni6Cw5KO9zXCbF7/p8HrWdwMS834+E1QWzc7RpQYLef
        OcLF3dlQx8fAfISktvE0USg6g3wCqZyqiHS7gK5iCzXTxc5racpvAHY66CvsTxKvWOwReLLYGXSgH
        jkedjM7Q==;
Received: from [2001:4bb8:193:fd10:3bcd:92e:c61e:4ad5] (helo=localhost)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mJemh-00EkkT-LD; Fri, 27 Aug 2021 16:33:11 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     axboe@kernel.dk
Cc:     linux-block@vger.kernel.org
Subject: [PATCH for-5.14] cryptoloop: add a deprecation warning
Date:   Fri, 27 Aug 2021 18:32:50 +0200
Message-Id: <20210827163250.255325-1-hch@lst.de>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Support for cryptoloop has been officially marked broken and deprecated
in favor of dm-crypt (which supports the same broken algorithms if
needed) in Linux 2.6.4 (released in March 2004), and support for it has
been entirely removed from losetup in util-linux 2.23 (released in April
2013).  Add a warning and a deprecation schedule.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/block/Kconfig      | 4 ++--
 drivers/block/cryptoloop.c | 2 ++
 2 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/block/Kconfig b/drivers/block/Kconfig
index 63056cfd4b62c..fbb3a558139fc 100644
--- a/drivers/block/Kconfig
+++ b/drivers/block/Kconfig
@@ -213,7 +213,7 @@ config BLK_DEV_LOOP_MIN_COUNT
 	  dynamically allocated with the /dev/loop-control interface.
 
 config BLK_DEV_CRYPTOLOOP
-	tristate "Cryptoloop Support"
+	tristate "Cryptoloop Support (DEPRECATED)"
 	select CRYPTO
 	select CRYPTO_CBC
 	depends on BLK_DEV_LOOP
@@ -225,7 +225,7 @@ config BLK_DEV_CRYPTOLOOP
 	  WARNING: This device is not safe for journaled file systems like
 	  ext3 or Reiserfs. Please use the Device Mapper crypto module
 	  instead, which can be configured to be on-disk compatible with the
-	  cryptoloop device.
+	  cryptoloop device.  cryptoloop support will be removed in Linux 5.16.
 
 source "drivers/block/drbd/Kconfig"
 
diff --git a/drivers/block/cryptoloop.c b/drivers/block/cryptoloop.c
index 3cabc335ae744..f0a91faa43a89 100644
--- a/drivers/block/cryptoloop.c
+++ b/drivers/block/cryptoloop.c
@@ -189,6 +189,8 @@ init_cryptoloop(void)
 
 	if (rc)
 		printk(KERN_ERR "cryptoloop: loop_register_transfer failed\n");
+	else
+		pr_warn("the cryptoloop driver has been deprecated and will be removed in in Linux 5.16\n");
 	return rc;
 }
 
-- 
2.30.2


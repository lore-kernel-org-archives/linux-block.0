Return-Path: <SRS0=8pZC=OW=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89447C67839
	for <linux-block@archiver.kernel.org>; Thu, 13 Dec 2018 14:55:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 523522086D
	for <linux-block@archiver.kernel.org>; Thu, 13 Dec 2018 14:55:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 523522086D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728947AbeLMOzy (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 13 Dec 2018 09:55:54 -0500
Received: from mx2.suse.de ([195.135.220.15]:51716 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729129AbeLMOzx (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Thu, 13 Dec 2018 09:55:53 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id DF89EADDD;
        Thu, 13 Dec 2018 14:55:51 +0000 (UTC)
From:   Coly Li <colyli@suse.de>
To:     linux-bcache@vger.kernel.org, axboe@kernel.dk
Cc:     linux-block@vger.kernel.org, Coly Li <colyli@suse.de>
Subject: [PATCH 09/12] bcache: add MODULE_DESCRIPTION information
Date:   Thu, 13 Dec 2018 22:53:54 +0800
Message-Id: <20181213145357.38528-10-colyli@suse.de>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20181213145357.38528-1-colyli@suse.de>
References: <20181213145357.38528-1-colyli@suse.de>
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

This patch moves MODULE_AUTHOR and MODULE_LICENSE to end of super.c, and
add MODULE_DESCRIPTION("Bcache: a Linux block layer cache").

This is preparation for adding module parameters.

Signed-off-by: Coly Li <colyli@suse.de>
---
 drivers/md/bcache/super.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/md/bcache/super.c b/drivers/md/bcache/super.c
index 5b59d44656c0..61d3b63fa617 100644
--- a/drivers/md/bcache/super.c
+++ b/drivers/md/bcache/super.c
@@ -25,9 +25,6 @@
 #include <linux/reboot.h>
 #include <linux/sysfs.h>
 
-MODULE_LICENSE("GPL");
-MODULE_AUTHOR("Kent Overstreet <kent.overstreet@gmail.com>");
-
 static const char bcache_magic[] = {
 	0xc6, 0x85, 0x73, 0xf6, 0x4e, 0x1a, 0x45, 0xca,
 	0x82, 0x65, 0xf5, 0x7f, 0x48, 0xba, 0x6d, 0x81
@@ -2469,3 +2466,7 @@ static int __init bcache_init(void)
 
 module_exit(bcache_exit);
 module_init(bcache_init);
+
+MODULE_DESCRIPTION("Bcache: a Linux block layer cache");
+MODULE_AUTHOR("Kent Overstreet <kent.overstreet@gmail.com>");
+MODULE_LICENSE("GPL");
-- 
2.16.4


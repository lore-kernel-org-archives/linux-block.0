Return-Path: <SRS0=mBf9=44=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF86FC10F25
	for <linux-block@archiver.kernel.org>; Wed, 11 Mar 2020 07:13:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C2BDB21655
	for <linux-block@archiver.kernel.org>; Wed, 11 Mar 2020 07:13:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726198AbgCKHNC (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 11 Mar 2020 03:13:02 -0400
Received: from mx2.suse.de ([195.135.220.15]:35372 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726160AbgCKHNC (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Wed, 11 Mar 2020 03:13:02 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 9BA79AF6D;
        Wed, 11 Mar 2020 07:13:00 +0000 (UTC)
From:   Takashi Iwai <tiwai@suse.de>
To:     Justin Sanders <justin@coraid.com>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org
Subject: [PATCH] block: aoe: Use scnprintf() for avoiding potential buffer overflow
Date:   Wed, 11 Mar 2020 08:12:58 +0100
Message-Id: <20200311071258.4284-1-tiwai@suse.de>
X-Mailer: git-send-email 2.16.4
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Since snprintf() returns the would-be-output size instead of the
actual output size, the succeeding calls may go beyond the given
buffer limit.  Fix it by replacing with scnprintf().

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 drivers/block/aoe/aoeblk.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/block/aoe/aoeblk.c b/drivers/block/aoe/aoeblk.c
index 7b32fb673375..a27804d71e12 100644
--- a/drivers/block/aoe/aoeblk.c
+++ b/drivers/block/aoe/aoeblk.c
@@ -87,9 +87,9 @@ static ssize_t aoedisk_show_netif(struct device *dev,
 	if (*nd == NULL)
 		return snprintf(page, PAGE_SIZE, "none\n");
 	for (p = page; nd < ne; nd++)
-		p += snprintf(p, PAGE_SIZE - (p-page), "%s%s",
+		p += scnprintf(p, PAGE_SIZE - (p-page), "%s%s",
 			p == page ? "" : ",", (*nd)->name);
-	p += snprintf(p, PAGE_SIZE - (p-page), "\n");
+	p += scnprintf(p, PAGE_SIZE - (p-page), "\n");
 	return p-page;
 }
 /* firmware version */
-- 
2.16.4


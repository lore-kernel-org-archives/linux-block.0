Return-Path: <SRS0=vHgh=AF=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43C77C433E0
	for <linux-block@archiver.kernel.org>; Wed, 24 Jun 2020 08:49:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 272BF20B80
	for <linux-block@archiver.kernel.org>; Wed, 24 Jun 2020 08:49:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389141AbgFXItb (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 24 Jun 2020 04:49:31 -0400
Received: from cmccmta3.chinamobile.com ([221.176.66.81]:5596 "EHLO
        cmccmta3.chinamobile.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388830AbgFXItZ (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 24 Jun 2020 04:49:25 -0400
Received: from spf.mail.chinamobile.com (unknown[172.16.121.1]) by rmmx-syy-dmz-app12-12012 (RichMail) with SMTP id 2eec5ef31384808-51d08; Wed, 24 Jun 2020 16:49:08 +0800 (CST)
X-RM-TRANSID: 2eec5ef31384808-51d08
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG: 00000000
Received: from localhost.localdomain (unknown[223.105.0.242])
        by rmsmtp-syy-appsvr01-12001 (RichMail) with SMTP id 2ee15ef31383538-2ae1e;
        Wed, 24 Jun 2020 16:49:08 +0800 (CST)
X-RM-TRANSID: 2ee15ef31383538-2ae1e
From:   Ding Xiang <dingxiang@cmss.chinamobile.com>
To:     axboe@kernel.dk
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] loop: fix passing zero to 'PTR_ERR' warning
Date:   Wed, 24 Jun 2020 16:48:42 +0800
Message-Id: <1592988522-4350-1-git-send-email-dingxiang@cmss.chinamobile.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Fix a static code checker warning:
    drivers/block/loop.c:798 loop_attr_backing_file_show()
    warn: passing zero to 'PTR_ERR'

Signed-off-by: Ding Xiang <dingxiang@cmss.chinamobile.com>
---
 drivers/block/loop.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/block/loop.c b/drivers/block/loop.c
index 475e1a7..bcada87 100644
--- a/drivers/block/loop.c
+++ b/drivers/block/loop.c
@@ -795,7 +795,7 @@ static ssize_t loop_attr_backing_file_show(struct loop_device *lo, char *buf)
 	spin_unlock_irq(&lo->lo_lock);
 
 	if (IS_ERR_OR_NULL(p))
-		ret = PTR_ERR(p);
+		ret = PTR_ERR_OR_ZERO(p);
 	else {
 		ret = strlen(p);
 		memmove(buf, p, ret);
-- 
2.7.4




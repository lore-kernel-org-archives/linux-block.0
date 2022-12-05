Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 899E2C4321E
	for <linux-block@archiver.kernel.org>; Mon,  5 Dec 2022 11:30:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229753AbiLELab (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 5 Dec 2022 06:30:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230246AbiLELaa (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Mon, 5 Dec 2022 06:30:30 -0500
Received: from mxhk.zte.com.cn (mxhk.zte.com.cn [63.216.63.40])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C0FB10569;
        Mon,  5 Dec 2022 03:30:28 -0800 (PST)
Received: from mse-fl2.zte.com.cn (unknown [10.5.228.133])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mxhk.zte.com.cn (FangMail) with ESMTPS id 4NQhDf72jfz8R040;
        Mon,  5 Dec 2022 19:30:26 +0800 (CST)
Received: from szxlzmapp02.zte.com.cn ([10.5.231.79])
        by mse-fl2.zte.com.cn with SMTP id 2B5BUMBd072078;
        Mon, 5 Dec 2022 19:30:22 +0800 (+08)
        (envelope-from yang.yang29@zte.com.cn)
Received: from mapi (szxlzmapp02[null])
        by mapi (Zmail) with MAPI id mid14;
        Mon, 5 Dec 2022 19:30:25 +0800 (CST)
Date:   Mon, 5 Dec 2022 19:30:25 +0800 (CST)
X-Zmail-TransId: 2b04638dd651ffffffffb0f9510b
X-Mailer: Zmail v1.0
Message-ID: <202212051930256039214@zte.com.cn>
Mime-Version: 1.0
From:   <yang.yang29@zte.com.cn>
To:     <justin@coraid.com>
Cc:     <axboe@kernel.dk>, <linux-block@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <xu.panda@zte.com.cn>,
        <yang.yang29@zte.com.cn>
Subject: =?UTF-8?B?W1BBVENIIGxpbnV4LW5leHRdIGFvZTogdXNlIHN0cnNjcHkoKSB0byBpbnN0ZWFkIG9mIHN0cm5jcHkoKQ==?=
Content-Type: text/plain;
        charset="UTF-8"
X-MAIL: mse-fl2.zte.com.cn 2B5BUMBd072078
X-Fangmail-Gw-Spam-Type: 0
X-FangMail-Miltered: at cgslv5.04-192.168.250.137.novalocal with ID 638DD652.000 by FangMail milter!
X-FangMail-Envelope: 1670239827/4NQhDf72jfz8R040/638DD652.000/10.5.228.133/[10.5.228.133]/mse-fl2.zte.com.cn/<yang.yang29@zte.com.cn>
X-Fangmail-Anti-Spam-Filtered: true
X-Fangmail-MID-QID: 638DD652.000/4NQhDf72jfz8R040
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

From: Xu Panda <xu.panda@zte.com.cn>

The implementation of strscpy() is more robust and safer.
That's now the recommended way to copy NUL terminated strings.

Signed-off-by: Xu Panda <xu.panda@zte.com.cn>
Signed-off-by: Yang Yang <yang.yang29@zte.com>
---
 drivers/block/aoe/aoenet.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/block/aoe/aoenet.c b/drivers/block/aoe/aoenet.c
index 63773a90581d..c51ea95bc2ce 100644
--- a/drivers/block/aoe/aoenet.c
+++ b/drivers/block/aoe/aoenet.c
@@ -39,8 +39,7 @@ static struct ktstate kts;
 #ifndef MODULE
 static int __init aoe_iflist_setup(char *str)
 {
-	strncpy(aoe_iflist, str, IFLISTSZ);
-	aoe_iflist[IFLISTSZ - 1] = '\0';
+	strscpy(aoe_iflist, str, IFLISTSZ);
 	return 1;
 }

-- 
2.15.2

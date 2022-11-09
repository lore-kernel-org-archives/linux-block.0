Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78374C4332F
	for <linux-block@archiver.kernel.org>; Wed,  9 Nov 2022 13:40:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230072AbiKINkZ (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 9 Nov 2022 08:40:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229995AbiKINkY (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 9 Nov 2022 08:40:24 -0500
X-Greylist: delayed 435 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 09 Nov 2022 05:40:23 PST
Received: from mxct.zte.com.cn (mxct.zte.com.cn [58.251.27.85])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C82A2E6A3
        for <linux-block@vger.kernel.org>; Wed,  9 Nov 2022 05:40:23 -0800 (PST)
Received: from mxde.zte.com.cn (unknown [10.35.20.165])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mxct.zte.com.cn (FangMail) with ESMTPS id 4N6mBB1DHHz1Dyc
        for <linux-block@vger.kernel.org>; Wed,  9 Nov 2022 21:33:06 +0800 (CST)
Received: from mxus.zte.com.cn (unknown [10.207.168.8])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mxde.zte.com.cn (FangMail) with ESMTPS id 4N6mB63qfwz5TCG0
        for <linux-block@vger.kernel.org>; Wed,  9 Nov 2022 21:33:02 +0800 (CST)
Received: from mxhk.zte.com.cn (unknown [192.168.250.137])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mxus.zte.com.cn (FangMail) with ESMTPS id 4N6mB34p7PzdmXX7
        for <linux-block@vger.kernel.org>; Wed,  9 Nov 2022 21:32:59 +0800 (CST)
Received: from mse-fl2.zte.com.cn (unknown [10.5.228.133])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mxhk.zte.com.cn (FangMail) with ESMTPS id 4N6m9z25qSz8QrkZ;
        Wed,  9 Nov 2022 21:32:55 +0800 (CST)
Received: from szxlzmapp01.zte.com.cn ([10.5.231.85])
        by mse-fl2.zte.com.cn with SMTP id 2A9DWnZt099946;
        Wed, 9 Nov 2022 21:32:49 +0800 (+08)
        (envelope-from yang.yang29@zte.com.cn)
Received: from mapi (szxlzmapp03[null])
        by mapi (Zmail) with MAPI id mid14;
        Wed, 9 Nov 2022 21:32:53 +0800 (CST)
Date:   Wed, 9 Nov 2022 21:32:53 +0800 (CST)
X-Zmail-TransId: 2b05636bac05ffffffff8eb2a033
X-Mailer: Zmail v1.0
Message-ID: <202211092132530746481@zte.com.cn>
Mime-Version: 1.0
From:   <yang.yang29@zte.com.cn>
To:     <axboe@kernel.dk>
Cc:     <linux-block@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <xu.panda@zte.com.cn>, <yang.yang29@zte.com.cn>
Subject: =?UTF-8?B?W1BBVENIIGxpbnV4LW5leHRdIGJsb2NrOiB1c2Ugc3Ryc2NweSgpIGlzIG1vcmUgcm9idXN0IGFuZCBzYWZlcg==?=
Content-Type: text/plain;
        charset="UTF-8"
X-MAIL: mse-fl2.zte.com.cn 2A9DWnZt099946
X-Fangmail-Gw-Spam-Type: 0
X-FangMail-Miltered: at cgslv5.04-192.168.251.14.novalocal with ID 636BAC11.000 by FangMail milter!
X-FangMail-Envelope: 1668000786/4N6mBB1DHHz1Dyc/636BAC11.000/10.35.20.165/[10.35.20.165]/mxde.zte.com.cn/<yang.yang29@zte.com.cn>
X-Fangmail-Anti-Spam-Filtered: true
X-Fangmail-MID-QID: 636BAC11.000/4N6mBB1DHHz1Dyc
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

From: Xu Panda <xu.panda@zte.com.cn>

The implementation of strscpy() is more robust and safer.
That's now the recommended way to copy NUL terminated strings.

Reported-by: Zeal Robot <zealci@zte.com.cn>
Signed-off-by: Xu Panda <xu.panda@zte.com.cn>
Signed-off-by: Yang Yang <yang.yang29@zte.com>
---
 block/elevator.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/block/elevator.c b/block/elevator.c
index a5bdc3b1e7e5..0885b66c3868 100644
--- a/block/elevator.c
+++ b/block/elevator.c
@@ -749,7 +749,7 @@ ssize_t elv_iosched_store(struct request_queue *q, const char *buf,
 	if (!elv_support_iosched(q))
 		return count;

-	strlcpy(elevator_name, buf, sizeof(elevator_name));
+	strscpy(elevator_name, buf, sizeof(elevator_name));
 	ret = elevator_change(q, strstrip(elevator_name));
 	if (!ret)
 		return count;
-- 
2.15.2

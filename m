Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5DF72ECAAD4
	for <linux-block@archiver.kernel.org>; Wed, 31 Aug 2022 15:52:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231784AbiHaPwe (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 31 Aug 2022 11:52:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229547AbiHaPwd (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 31 Aug 2022 11:52:33 -0400
Received: from smtpbg.qq.com (bg4.exmail.qq.com [43.154.221.58])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C55AAA3D36
        for <linux-block@vger.kernel.org>; Wed, 31 Aug 2022 08:52:28 -0700 (PDT)
X-QQ-mid: bizesmtp74t1661961142tdlpgpme
Received: from localhost.localdomain ( [182.148.13.26])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Wed, 31 Aug 2022 23:52:17 +0800 (CST)
X-QQ-SSF: 01000000002000B0C000B00A0000000
X-QQ-FEAT: fs34Pe/+C2RlUBgjEo7luOwwSkKiAMk93nlvfLjuxUSLiIhgnJxSQYBw2jsQz
        7IMtjRKq1MfbgUiMCgwWgERTivz1lS9cfaiPu06c2Ze1Gtl0/r1sPL2XN0A/GcI+J4fJG+l
        Vns6/cdr4OXCryW4XMpUBMF8kxTPJxrlY9leoTOtpOQ/zf9Trvoocy0nSsJgnFDNjBu8ih4
        qjybyeZTBu5e/JwJuiHV26S9/BCw8VUkbxFBnKb5bINz0bJe3y01PuraPF6wxkqqrteCSHD
        KFJEv8dSXuTZBMlFDJEv/vykGodULdP6QVp4zeaUxUwsTuwyQRXKaLHNX56s1gvOTl1akg1
        bcrrQWdcwmRySC+8okSVVdQUxkIQG77riVOW1gTOo6plUtBYEJm0oOhnvOAsJP3hPEJRWcY
X-QQ-GoodBg: 0
From:   Shaomin Deng <dengshaomin@cdjrlc.com>
To:     axboe@kernel.dk, linux-block@vger.kernel.org
Cc:     Shaomin Deng <dengshaomin@cdjrlc.com>
Subject: [PATCH] block: Fix double word in comments
Date:   Wed, 31 Aug 2022 11:52:16 -0400
Message-Id: <20220831155216.2552-1-dengshaomin@cdjrlc.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:cdjrlc.com:qybglogicsvr:qybglogicsvr4
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Fix the double word "is is" in comments.

Signed-off-by: Shaomin Deng <dengshaomin@cdjrlc.com>
---
 drivers/block/mtip32xx/mtip32xx.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/block/mtip32xx/mtip32xx.c b/drivers/block/mtip32xx/mtip32xx.c
index 562725d222a7..82a4812e74e3 100644
--- a/drivers/block/mtip32xx/mtip32xx.c
+++ b/drivers/block/mtip32xx/mtip32xx.c
@@ -2487,7 +2487,7 @@ static int mtip_service_thread(void *data)
 
 		/*
 		 * the condition is to check neither an internal command is
-		 * is in progress nor error handling is active
+		 * in progress nor error handling is active
 		 */
 		wait_event_interruptible(port->svc_wait, (port->flags) &&
 			(port->flags & MTIP_PF_SVC_THD_WORK));
-- 
2.35.1


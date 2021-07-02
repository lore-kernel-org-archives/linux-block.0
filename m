Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AED26C11F6A
	for <linux-block@archiver.kernel.org>; Fri,  2 Jul 2021 11:11:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 97979613F9
	for <linux-block@archiver.kernel.org>; Fri,  2 Jul 2021 11:11:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231474AbhGBLOX (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 2 Jul 2021 07:14:23 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:58442 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230424AbhGBLOX (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Fri, 2 Jul 2021 07:14:23 -0400
Received: from 1.general.cking.uk.vpn ([10.172.193.212] helo=localhost)
        by youngberry.canonical.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.93)
        (envelope-from <colin.king@canonical.com>)
        id 1lzH5J-0002z5-UC; Fri, 02 Jul 2021 11:11:50 +0000
From:   Colin King <colin.king@canonical.com>
To:     tim@cyberelk.net, Jens Axboe <axboe@kernel.dk>,
        linux-block@vger.kernel.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] paride: remove redudant space character check
Date:   Fri,  2 Jul 2021 12:11:49 +0100
Message-Id: <20210702111149.15517-1-colin.king@canonical.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

The check for variable l being a space character is always false, l can
never be a space character. The check is redundant and can be removed.

Addresses-Coverity: ("Logically dead code")
Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 drivers/block/paride/pg.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/block/paride/pg.c b/drivers/block/paride/pg.c
index 3b5882bfb736..2f7aa8521395 100644
--- a/drivers/block/paride/pg.c
+++ b/drivers/block/paride/pg.c
@@ -429,8 +429,6 @@ static void xs(char *buf, char *targ, int len)
 		if (c != ' ' && c != l)
 			l = *targ++ = c;
 	}
-	if (l == ' ')
-		targ--;
 	*targ = '\0';
 }
 
-- 
2.31.1


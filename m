Return-Path: <SRS0=CgA1=3M=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1CD00C32771
	for <linux-block@archiver.kernel.org>; Thu, 23 Jan 2020 00:29:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E437E24673
	for <linux-block@archiver.kernel.org>; Thu, 23 Jan 2020 00:29:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725989AbgAWA3Y (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 22 Jan 2020 19:29:24 -0500
Received: from youngberry.canonical.com ([91.189.89.112]:52560 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725911AbgAWA3Y (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 22 Jan 2020 19:29:24 -0500
Received: from [82.43.126.140] (helo=localhost)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <colin.king@canonical.com>)
        id 1iuQN8-0004aM-9o; Thu, 23 Jan 2020 00:29:22 +0000
From:   Colin King <colin.king@canonical.com>
To:     Richard Russon <ldm@flatcap.org>, Jens Axboe <axboe@kernel.dk>,
        linux-ntfs-dev@lists.sourceforge.net, linux-block@vger.kernel.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] partitions/ldm: fix spelling mistake "to" -> "too"
Date:   Thu, 23 Jan 2020 00:29:21 +0000
Message-Id: <20200123002921.2832716-1-colin.king@canonical.com>
X-Mailer: git-send-email 2.24.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

There is a spelling mistake in a ldm_error message. Fix it.

Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 block/partitions/ldm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/block/partitions/ldm.c b/block/partitions/ldm.c
index fe5d970e2e60..a2d97ee1908c 100644
--- a/block/partitions/ldm.c
+++ b/block/partitions/ldm.c
@@ -1233,7 +1233,7 @@ static bool ldm_frag_add (const u8 *data, int size, struct list_head *frags)
 	BUG_ON (!data || !frags);
 
 	if (size < 2 * VBLK_SIZE_HEAD) {
-		ldm_error("Value of size is to small.");
+		ldm_error("Value of size is too small.");
 		return false;
 	}
 
-- 
2.24.0


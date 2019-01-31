Return-Path: <SRS0=cAVD=QH=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B206C169C4
	for <linux-block@archiver.kernel.org>; Thu, 31 Jan 2019 09:26:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 04FBE20B1F
	for <linux-block@archiver.kernel.org>; Thu, 31 Jan 2019 09:26:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726376AbfAaJ0S (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 31 Jan 2019 04:26:18 -0500
Received: from mout.gmx.net ([212.227.15.15]:46809 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726172AbfAaJ0S (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Thu, 31 Jan 2019 04:26:18 -0500
Received: from localhost.localdomain ([218.18.229.179]) by mail.gmx.com
 (mrgmx002 [212.227.17.184]) with ESMTPSA (Nemesis) id
 0M5cMq-1h4RXL3Ca8-00xdwO; Thu, 31 Jan 2019 10:26:16 +0100
From:   Chengguang Xu <cgxu519@gmx.com>
To:     axboe@kernel.dk
Cc:     linux-block@vger.kernel.org, Chengguang Xu <cgxu519@gmx.com>
Subject: [PATCH] block: use strncmp() instead of strcmp() for comparing device name
Date:   Thu, 31 Jan 2019 17:25:20 +0800
Message-Id: <20190131092520.20273-1-cgxu519@gmx.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:G8ttzLjmO3SCtS24IEt2XWvQNxGj2BnNgA4RmZlbTmIkRcf1TiT
 76gSL5N7NFkcKpaLVfuFLkYSDwGc+gE848lOQVUF1HhD2lPAdsLiVciTguzuAtsxZIOypGS
 XgdGekxMjT+Op6uTbtv0s1GXJejDtLxVSQ62kTE37C50jgFyI+oOIZ3IZrAMk0NpjJgaWLU
 9rPMxfR3piKWEDAYR8VlQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:FPrPgWQGITY=:CnrogaNsxa80N5MY5YSwi7
 DrRCkg6zEqwOxCI6F6UrLra3Y4vsC99ClnWOEY5oAI9yemNXixuehn+AjJ72hmXfmGB6Z7Ae5
 vTXD5x4BmTvNp5bMdQKA3PbdroQ4nZsKCnhpt5ICLDHLcgl14GT1QO5WEsmi4kFlu6dzC+m9p
 JrqvwF+0O4POWgf9+jEKxn/DRj60uQZIL1kmjD1jfQ13i7Q2FU7fCNGenJtRih+NJwgKNv3yo
 mQSVJQmljzJCQ6L3lziSkC34xzpcH4NZXoGNBSxsqVOQzxeW0ua+K68aOPN0U2BlXVSTN2SyU
 7SH88haQK6ij2l5tHUOOYQ70kSUR1nmQACaXHWD1wp4p0VOJbp95vgveiuNRVOHEgEHOYJuXB
 At5h6xE0x5Y0CpO/AMMM9ESXKDBw3YnhbzDnH0yJ4Pv3UvHt0AiueH08Utt3DHUCKrjy6Cepc
 JwdRdoMILQMYeDWqV5/yvLG1V96J+9iLi8YmacsWLDhvHlauiFhsQl49NvN8586h6x2j7s7XM
 nqJZ70gWTYiH7Wfc8tBs1Uux2qvQL+1WIjlBywXJ0dAOsZzNPjLjlQ3J961zND7D19D2aQHWJ
 g+O+t4jCg54qk6RmVLeUtBulKsYgzgs/INpgFd3hc0z9bUgygf0ZJB5Rkxy7Rs+orWy8APeBD
 mYjRJiW/s3X0fAvoZtiLp/E6n4u1MOBFzqGebpzYjhhrIN0egdGe6mRC6cT1EKVS2w+g2iqfe
 FGwEI9d132Es37U8N5NCAu2hAGFQJUppJppNbq4BtWtiwp2EjrUxwXAuHgYA5CnKPATLOr0Wy
 1oYDpNo7bSo04e7XfO3mtqkB3IdRKAB1793exeP9+r+zBzjvNWFGpw323QDpj7YGVT+0AKWxo
 Zb6wP3b0l0jOhOAMIYorDq6jtUO2Bx5HACE20qwuBCjdGH/0OjELzqLP5QcWY2
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

We use strlcpy() to copy device name in register_blkdev(),
so if the device name is longer enough(accurately longer
than 15 bytes), the copied name is truncated to 15 bytes.
In this case, it's better to use strncmp() to compare device
name instead of strcmp() in unregister_blkdev(), so that
we can recognize the device name correctly.

Signed-off-by: Chengguang Xu <cgxu519@gmx.com>
---
 block/genhd.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/block/genhd.c b/block/genhd.c
index 1dd8fd6613b8..efc532ae9de9 100644
--- a/block/genhd.c
+++ b/block/genhd.c
@@ -424,7 +424,7 @@ void unregister_blkdev(unsigned int major, const char *name)
 	for (n = &major_names[index]; *n; n = &(*n)->next)
 		if ((*n)->major == major)
 			break;
-	if (!*n || strcmp((*n)->name, name)) {
+	if (!*n || strncmp((*n)->name, name, strlen((*n)->name))) {
 		WARN_ON(1);
 	} else {
 		p = *n;
-- 
2.20.1


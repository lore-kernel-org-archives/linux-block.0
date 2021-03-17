Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E46EEC433DB
	for <linux-block@archiver.kernel.org>; Wed, 17 Mar 2021 08:23:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A51E664F96
	for <linux-block@archiver.kernel.org>; Wed, 17 Mar 2021 08:23:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229549AbhCQIWk (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 17 Mar 2021 04:22:40 -0400
Received: from m12-16.163.com ([220.181.12.16]:54444 "EHLO m12-16.163.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229460AbhCQIW0 (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Wed, 17 Mar 2021 04:22:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=eK5zF
        7NTvK+Ftb2YqiJ3PTwgKdQ0IC75uTirVy/TqT8=; b=b4Af10IASKThc3UMWsQBb
        lJeevCcKjUvKDBfY5Ot2E+PA0wbE0xVQEIm35OCMETUg5qHxw8+WaVlXT9EWq5sr
        7YASRgLFPkI0e9lJ4oR6TAmRlTk6YsPxDLKt2bFMsO1Pi2e2GwV2/C+Y0KSJdWCp
        pRfi4YIONqrYKGhiEXm/6g=
Received: from COOL-20201210PM.ccdomain.com (unknown [218.94.48.178])
        by smtp12 (Coremail) with SMTP id EMCowADHzsb+u1FgUConhA--.24732S2;
        Wed, 17 Mar 2021 16:21:22 +0800 (CST)
From:   zuoqilin1@163.com
To:     josef@toxicpanda.com, axboe@kernel.dk
Cc:     linux-block@vger.kernel.org, nbd@other.debian.org,
        linux-kernel@vger.kernel.org, zuoqilin <zuoqilin@yulong.com>
Subject: [PATCH] drivers/block: Fix typo and remove duplicate word
Date:   Wed, 17 Mar 2021 16:21:28 +0800
Message-Id: <20210317082128.1193-1-zuoqilin1@163.com>
X-Mailer: git-send-email 2.28.0.windows.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: EMCowADHzsb+u1FgUConhA--.24732S2
X-Coremail-Antispam: 1Uf129KBjvdXoWruFy5AF18ZFWxCr1fZw43ZFb_yoW3Gwb_Ar
        1j9w48XrWrC3s7Cr1IgrsxXr9Y9r4UZFnYyFyIgFZrXrW7WF9xAw1Dur4Ikw1qg3WUWF9r
        u34UKrWUAr18JjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUvcSsGvfC2KfnxnUUI43ZEXa7IUnY-e5UUUUU==
X-Originating-IP: [218.94.48.178]
X-CM-SenderInfo: 52xr1xpolqiqqrwthudrp/xtbBRQJYiVPAKjWEIAAAs+
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

From: zuoqilin <zuoqilin@yulong.com>

Change 'untill' to 'until'.

remove duplicate word 'the'.

Signed-off-by: zuoqilin <zuoqilin@yulong.com>
---
 drivers/block/nbd.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/block/nbd.c b/drivers/block/nbd.c
index 4ff71b5..8e63efc 100644
--- a/drivers/block/nbd.c
+++ b/drivers/block/nbd.c
@@ -1846,7 +1846,7 @@ static int nbd_genl_connect(struct sk_buff *skb, struct genl_info *info)
 		nbd->destroy_complete = &destroy_complete;
 		mutex_unlock(&nbd_index_mutex);
 
-		/* Wait untill the the nbd stuff is totally destroyed */
+		/* Wait until the nbd stuff is totally destroyed */
 		wait_for_completion(&destroy_complete);
 		goto again;
 	}
-- 
1.9.1



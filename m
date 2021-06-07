Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1DB69C47082
	for <linux-block@archiver.kernel.org>; Mon,  7 Jun 2021 16:10:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F32CA61208
	for <linux-block@archiver.kernel.org>; Mon,  7 Jun 2021 16:10:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230361AbhFGQLy (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 7 Jun 2021 12:11:54 -0400
Received: from mail-lj1-f172.google.com ([209.85.208.172]:39502 "EHLO
        mail-lj1-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230220AbhFGQLy (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Mon, 7 Jun 2021 12:11:54 -0400
Received: by mail-lj1-f172.google.com with SMTP id c11so22987447ljd.6;
        Mon, 07 Jun 2021 09:09:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id;
        bh=MYkqiK7m+ECOse6aKTh/fCSqnKb+04pUb9T9G4LvlIg=;
        b=JMFabLq3Atd4NY8eWNboP2Eisic136L+v57USfJnEXoIk0YUccnQ4vkiNoGY7NLbYL
         cpz1TwU2nCakrgh+PQJ/zmSzm53oe+TAoJlHh8bRL85Gc3wPBEteXbmSG3SkAyj22Swm
         LSgpRxrNCXx0eiHdkUaMIHHhC+OhlL9IIT/Acgr5XA0C56a6AYH7JkP5ZCNVlu5CRWOL
         Zx6QltCN8pP8iZvSMwKGVyeysF7+Tgj1WONJxJJM+NaLWhVd/XcBk5cBNOZsuZsZlJQw
         jwQWj6Hpd7dddmliE1KumlO1s9wsbfwLZoDP3l/nthY2wwDRqzF5Mpj5uvIUZrfAQbCs
         hqVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id;
        bh=MYkqiK7m+ECOse6aKTh/fCSqnKb+04pUb9T9G4LvlIg=;
        b=Wf38StiNIiI22fi5CXDjPztXK24g7TF+jxPalF6jjNqqVDhZbcptyfbIEC0d85BF5K
         Ji1B8sn7sGaD952/iBy/EXRRGreRCrRqcsscnpsLRS4fjimSXsgx8KLcSkEUqfghj171
         f6kKKn2P+Lk07oklYky+DMOPwHFZXaZ0KoI6wy4k7jh90EYE02jX0fBsHsqiAXEZLbFS
         ALSF+fbloxvG2bxUOyHWe1SIqYefV+72eRjCmX/Q7jxoaiDid+4svTn8Brpo1lyp8Mht
         IIGUKgKbGtl+OwuoH1rJ+lnQqizILye/5D3Bvww08/X9/Huyq/y6eRWpqR5JTjXAxu2Y
         hSUg==
X-Gm-Message-State: AOAM532Rs07UvV+M6w5J72j3lluVTi3XHS0mp7KjlKUdfltICb5Vsh/q
        pNPbFnWDupxjjYF3t2VGiDc=
X-Google-Smtp-Source: ABdhPJyAAx/akxlrC8sMLSO0CIkPp4Kd6A78ZxJ5+8gGMYLi/5CnGoU4P9dVApRFdU5FCJ7D+fL9tA==
X-Received: by 2002:a2e:530e:: with SMTP id h14mr15325335ljb.454.1623082126712;
        Mon, 07 Jun 2021 09:08:46 -0700 (PDT)
Received: from localhost.localdomain ([51.15.119.249])
        by smtp.gmail.com with ESMTPSA id q2sm1462576ljj.7.2021.06.07.09.08.42
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 07 Jun 2021 09:08:46 -0700 (PDT)
From:   yongw.pur@gmail.com
To:     minchan@kernel.org, ngupta@vflare.org, senozhatsky@chromium.org,
        axboe@kernel.dk, linux-kernel@vger.kernel.org,
        linux-block@vger.kernel.org, wang.yong12@zte.com.cn
Subject: [PATCH] zram: zcomp_strm remove ambiguous description
Date:   Mon,  7 Jun 2021 09:08:20 -0700
Message-Id: <1623082100-22086-1-git-send-email-yongw.pur@gmail.com>
X-Mailer: git-send-email 2.7.4
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

From: wangyong <wang.yong12@zte.com.cn>

buffer element in the structure is only used for compression.
buffer element is not used in decompression.
So "/* compression/decompression buffer */" is a little ambiguous.

buffer is used in the following two places:
1.__zram_bvec_write: src = zstrm->buffer
2.zcomp_compress: crypto_comp_compress(zstrm->tfm,
                        src, PAGE_SIZE,
                        zstrm->buffer, dst_len);

Signed-off-by: wangyong <wang.yong12@zte.com.cn>
---
 drivers/block/zram/zcomp.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/block/zram/zcomp.h b/drivers/block/zram/zcomp.h
index 40f6420..0aac4b2 100644
--- a/drivers/block/zram/zcomp.h
+++ b/drivers/block/zram/zcomp.h
@@ -10,7 +10,7 @@
 struct zcomp_strm {
 	/* The members ->buffer and ->tfm are protected by ->lock. */
 	local_lock_t lock;
-	/* compression/decompression buffer */
+	/* compression buffer */
 	void *buffer;
 	struct crypto_comp *tfm;
 };
-- 
2.7.4


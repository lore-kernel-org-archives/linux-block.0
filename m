Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F730C43334
	for <linux-block@archiver.kernel.org>; Tue, 12 Jul 2022 15:27:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232182AbiGLP1z (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 12 Jul 2022 11:27:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229829AbiGLP1x (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 12 Jul 2022 11:27:53 -0400
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3CBFCBC25;
        Tue, 12 Jul 2022 08:27:53 -0700 (PDT)
Received: by mail-ej1-x629.google.com with SMTP id ss3so8920145ejc.11;
        Tue, 12 Jul 2022 08:27:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=DgrpeUlEg7dspJm0u/Xa9mdZFkQ0wTFNU4ocm1l1BOA=;
        b=k7cv85FzcOc5t49cOOmfHFuJOLh2saADD2PdsnMZGEXYbOAC5YzCr5qZ00zipRE346
         mmELpdeP6OVRqXO7sgxYtIT12jjh0g/ccm61y2PTo8FGTWpUmp4DKnRrb2EiLkL8tL2E
         DiDYDGGGXf6bVa5wKzoM/Z6lmBkSTotUELzV+Dj4iGCWOAiuxMnvWEprh731Q9qM9O5p
         fP49p28XbPHH868sMHRlCMhGXfSM4pnbo/9aWtCtD7W2MnXbAcfoXdtwlzVcUUdbDp5D
         nUu3BOC7B4BeEzoH8Sq4rUteot59NXe7cR/hR8qgwX1M7qcHx8FLcE16ozle0UMXXZvt
         OSnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=DgrpeUlEg7dspJm0u/Xa9mdZFkQ0wTFNU4ocm1l1BOA=;
        b=ylEOgCBUpYjc1uSgpniHIIFmMyuQy6duBoLGhYicXcceS7sSBJYrLkhT4P6eKXTtTA
         FENN2tv2SXCs7hyiPUwuKMtUYPOBTdXMFtoUuIWB3lQ+xl/vIcVxitu5vqtqhJ1H8w5u
         2YA6qu+zwbwPedjRalBI1ZYRrLtKDCic6VCwpGsZNbCC7BJx1WvjUY0tqhyB1e34jeg8
         p9HOlgy2sP6wjUGkHaIWjkTU46Dom3RLATRw6PbaEspgEwV7yddbYY7ANBm6J1g+bSsx
         osaFCdMfNkb73bmogPYOWbRko8HWY9MevUuK/yXY4nEqHsx5OE0Nh0azpm4Yetgq3o5d
         Zn8A==
X-Gm-Message-State: AJIora8QRiTrTtOG0NnR4rd18hjKFx7QPs8PCnDefNcxVnjPmwxVZ4cH
        E3gpOHSd98pIyu6XuY/kbbp7uWINkfg=
X-Google-Smtp-Source: AGRyM1vUtFVhV4+kPGrdeDT4LK7IBeZdd8UAgg6ZbrNcnulYaM1rX/AF7tFce9aCgtmRFhNpGhjK8w==
X-Received: by 2002:a17:907:3e15:b0:72b:879a:eec7 with SMTP id hp21-20020a1709073e1500b0072b879aeec7mr2193711ejc.136.1657639671490;
        Tue, 12 Jul 2022 08:27:51 -0700 (PDT)
Received: from localhost.localdomain ([46.248.82.114])
        by smtp.gmail.com with ESMTPSA id c1-20020a17090618a100b0072b4e4cd346sm2701487ejf.188.2022.07.12.08.27.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Jul 2022 08:27:51 -0700 (PDT)
From:   Uros Bizjak <ubizjak@gmail.com>
To:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Uros Bizjak <ubizjak@gmail.com>, Jens Axboe <axboe@kernel.dk>
Subject: [PATCH v2] block: Use try_cmpxchg in update_io_ticks
Date:   Tue, 12 Jul 2022 17:27:41 +0200
Message-Id: <20220712152741.7324-1-ubizjak@gmail.com>
X-Mailer: git-send-email 2.35.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Use try_cmpxchg instead of cmpxchg (*ptr, old, new) == old in
update_io_ticks. x86 CMPXCHG instruction returns success in ZF flag,
so this change saves a compare after cmpxchg (and related
move instruction in front of cmpxchg).

No functional change intended.

Signed-off-by: Uros Bizjak <ubizjak@gmail.com>
Cc: Jens Axboe <axboe@kernel.dk>
---
v2: Split patch from the original big patch
---
 block/blk-core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/block/blk-core.c b/block/blk-core.c
index 27fb1357ad4b..628b965356db 100644
--- a/block/blk-core.c
+++ b/block/blk-core.c
@@ -987,7 +987,7 @@ void update_io_ticks(struct block_device *part, unsigned long now, bool end)
 again:
 	stamp = READ_ONCE(part->bd_stamp);
 	if (unlikely(time_after(now, stamp))) {
-		if (likely(cmpxchg(&part->bd_stamp, stamp, now) == stamp))
+		if (likely(try_cmpxchg(&part->bd_stamp, &stamp, now)))
 			__part_stat_add(part, io_ticks, end ? now - stamp : 1);
 	}
 	if (part->bd_partno) {
-- 
2.35.3


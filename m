Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72EF5C678D4
	for <linux-block@archiver.kernel.org>; Thu,  2 Mar 2023 14:43:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229790AbjCBOnn (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 2 Mar 2023 09:43:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229492AbjCBOnm (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 2 Mar 2023 09:43:42 -0500
Received: from mail-lj1-x231.google.com (mail-lj1-x231.google.com [IPv6:2a00:1450:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C1B038037
        for <linux-block@vger.kernel.org>; Thu,  2 Mar 2023 06:43:39 -0800 (PST)
Received: by mail-lj1-x231.google.com with SMTP id z5so17840597ljc.8
        for <linux-block@vger.kernel.org>; Thu, 02 Mar 2023 06:43:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=+NuIrQyu9sctpk8pQFgxNkYy00s89JzuKjWNu0rz86k=;
        b=SXXi6eB+umI9ANFEoFGqSrifMaE0poWztgSMyQ22TTInkNboO5fBzmLJu8AVy9bLju
         M6kRnEzSFF0tIKScNEJKtwGknd9HA8jIlBSeNTpA9OQ0f9rWBw0Ac3o87OdBq5qpWH6L
         Hp9grmmptCV5jVYnuggL0wtHznofM7v2nu7ZWEw049NOOS9E5JjcztTeVp7gPUE4C+L7
         W9KHKjq1tugzlmCOetH33O/q2pd/nVAr1GvLh4ynoV7NG6AHClJbXB+UVxoFI1aYc4Cl
         LGS6rl1Q9iruf4NB+fghiDV8qU5Rqb4VK4VKXOSyITorbvahOUZuOjakf6L33nu6LEu7
         yeHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+NuIrQyu9sctpk8pQFgxNkYy00s89JzuKjWNu0rz86k=;
        b=E6e/ESEmbMa0juDDdWEWwQwN3uX5OveYIU95K1JFd2v5MlGf7oi6x6/HQihtwJ6Mrr
         UnlWfggDVyK5YrP6nNSl6IPb5Q5qNrhWGlZVTNEBJKZGcmWEhpeIoj12lwOxhGm0sWbn
         yg55AUdjVS/5ZX/ZZsstaiEYjpHiXhzsxPa2dIThDLHNUH4kn0mQEF0W6WDPIW5qa8wl
         DPfdK8Mgu0Qo8u40u56eahfawLm9DD5ffHu8VjinSZI2BV2TE2d6j1oVPiRykPpdJ+1T
         rC4elVJgkBEvv6uCJTSLY4NdX3kXjtyS3oo6RIH6rnU+XF0Vg6c7JQzO7NZNZzVgzyWe
         GbMg==
X-Gm-Message-State: AO0yUKUMvMV3GC2IjRla5aGaI32bxFAfQoOt6qjyii6wprlTn4vE3dWP
        j1NPnZC+uF63blDs00k2xMrKDQ==
X-Google-Smtp-Source: AK7set9G/UyUxQKn0i1rnrYbqkFSeGhuf1tIk4E+t5lr32TMrrq16Jkgq8TWOo69tqns9sf6xocjZA==
X-Received: by 2002:a2e:b98c:0:b0:295:a446:cd08 with SMTP id p12-20020a2eb98c000000b00295a446cd08mr2838122ljp.6.1677768217230;
        Thu, 02 Mar 2023 06:43:37 -0800 (PST)
Received: from uffe-XPS13.. (h-94-254-63-18.NA.cust.bahnhof.se. [94.254.63.18])
        by smtp.gmail.com with ESMTPSA id n15-20020a2e86cf000000b0029597ebacd0sm2070791ljj.64.2023.03.02.06.43.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Mar 2023 06:43:36 -0800 (PST)
From:   Ulf Hansson <ulf.hansson@linaro.org>
To:     linux-mmc@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>,
        Jens Axboe <axboe@kernel.dk>
Cc:     Wenchao Chen <wenchao.chen666@gmail.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Avri Altman <avri.altman@wdc.com>,
        Christian Lohle <cloehle@hyperstone.com>,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [RFC PATCH] mmc: core: Disable REQ_FUA if the eMMC supports an internal cache
Date:   Thu,  2 Mar 2023 15:43:30 +0100
Message-Id: <20230302144330.274947-1-ulf.hansson@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

REQ_FUA is in general supported for eMMC cards, which translates into so
called "reliable writes". To support these write operations, the CMD23
(MMC_CAP_CMD23), needs to be supported by the mmc host too, which is common
but not always the case.

For some eMMC devices, it has been reported that reliable writes are quite
costly, leading to performance degradations.

In a way to improve the situation, let's avoid announcing REQ_FUA support
if the eMMC supports an internal cache, as that allows us to rely solely on
flush-requests (REQ_OP_FLUSH) instead, which seems to be a lot cheaper.
Note that, those mmc hosts that lacks CMD23 support are already using this
type of configuration, whatever that could mean.

Reported-by: Wenchao Chen <wenchao.chen666@gmail.com>
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---

Note that, I haven't been able to test this patch myself, but are relying on
Wenchao and others to help out. Sharing some performance number before and
after the patch, would be nice.

Moreover, what is not clear to me (hence the RFC), is whether relying solely on
flush requests are sufficient and as such if it's a good idea after all.
Comments are highly appreciated in this regards.

Kind regards
Ulf Hansson

---
 drivers/mmc/core/block.c | 15 ++++++++++-----
 1 file changed, 10 insertions(+), 5 deletions(-)

diff --git a/drivers/mmc/core/block.c b/drivers/mmc/core/block.c
index 672ab90c4b2d..2a49531bf023 100644
--- a/drivers/mmc/core/block.c
+++ b/drivers/mmc/core/block.c
@@ -2490,15 +2490,20 @@ static struct mmc_blk_data *mmc_blk_alloc_req(struct mmc_card *card,
 			md->flags |= MMC_BLK_CMD23;
 	}
 
-	if (md->flags & MMC_BLK_CMD23 &&
-	    ((card->ext_csd.rel_param & EXT_CSD_WR_REL_PARAM_EN) ||
-	     card->ext_csd.rel_sectors)) {
+	/*
+	 * REQ_FUA is supported through eMMC reliable writes, which has been
+	 * reported to be quite costly for some eMMCs. Therefore, let's rely
+	 * on flush requests (REQ_OP_FLUSH), if an internal cache is supported.
+	 */
+	if (mmc_cache_enabled(card->host)) {
+		cache_enabled  = true;
+	} else if (md->flags & MMC_BLK_CMD23 &&
+		  (card->ext_csd.rel_param & EXT_CSD_WR_REL_PARAM_EN ||
+		   card->ext_csd.rel_sectors)) {
 		md->flags |= MMC_BLK_REL_WR;
 		fua_enabled = true;
 		cache_enabled = true;
 	}
-	if (mmc_cache_enabled(card->host))
-		cache_enabled  = true;
 
 	blk_queue_write_cache(md->queue.queue, cache_enabled, fua_enabled);
 
-- 
2.34.1


Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53D32C4332F
	for <linux-block@archiver.kernel.org>; Wed,  2 Nov 2022 12:40:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230388AbiKBMkO (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 2 Nov 2022 08:40:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230395AbiKBMkN (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 2 Nov 2022 08:40:13 -0400
Received: from mail-pg1-x52a.google.com (mail-pg1-x52a.google.com [IPv6:2607:f8b0:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2B5B29C91;
        Wed,  2 Nov 2022 05:40:12 -0700 (PDT)
Received: by mail-pg1-x52a.google.com with SMTP id v3so1183430pgh.4;
        Wed, 02 Nov 2022 05:40:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iW88jGgcd8miZh9len9gFIPIDgHa/+wXKZJwZCVeRuM=;
        b=ExliLNWM8833uTSn3Iu6fujG7/iOfccABTOCt2AEe247j443amawJXh+Xx7pyL3KsY
         VPWaxX8NxWIdI2MSJwVYuv9b70dZnIA3lZYtYTYH0QaDWpTx8SIHa/ghkH3+gbNc1twN
         Mpq5JxeOnhAUEKXgu+UXbvcgQ7rrJylURkGoWxlE9wZs/Jpi+h8Qmyw7CXu//Fl5u44p
         GCxt7oHqL2N81IL7p8QOF+0icEBrthabDI0rfyOAGObQZKgGyff+2WH9k8QyPtFdItOc
         1ovf7Y6cpqRjvAVSv87LAP9MdYyoKusKbh3sz8L2Dnbq49meRhLFZISNcO4Q0ZeTKj8V
         e4Ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iW88jGgcd8miZh9len9gFIPIDgHa/+wXKZJwZCVeRuM=;
        b=MoP2468dQBNnLVjSy6liWC0Sfao+ZC7u+eY3ZXjMT3CWrkxdsmMKtmo3LLRHXE7aQp
         VduJl3JTraVb+uRj1Q+p8l2TTvlSTY6Ubv3uinYpr+HDzTaYALvYE7rEKxF+CoZiVc0d
         7EjvmvoGYW7/Hpk6QBzjA38gkNxmJSD0sss2QexPS/r0i7t+Maag7ygQPtELU9Oa4QeT
         Xtg78deZpfz9KyzQWFjZwpL/rb79qY00U6kn6XVA5xE2JfcGga+vfMO7InqcNxlX3Q35
         vQqXFaHUEUumojwo47knf+YHuUrtc1eGDbCnf1O1SLJyMhArc1qHAaqiTeLxQE9YkFsF
         jVWw==
X-Gm-Message-State: ACrzQf1KeoNDQu94aDyjqrRDDkOzX8EAd37i1ZRDHMz6r0klRysVDYTV
        pmiDPwEBy3M2Ro+xpAqR+iE=
X-Google-Smtp-Source: AMsMyM6fD3HjuK76WyqWIIdJLo6fTR9y9MLBvXLcsnGTiuYT3SzPQ1MVPJ3giy4fUdRVPmUbac0/Hw==
X-Received: by 2002:a05:6a00:2409:b0:54e:a3ad:d32d with SMTP id z9-20020a056a00240900b0054ea3add32dmr24822988pfh.70.1667392812356;
        Wed, 02 Nov 2022 05:40:12 -0700 (PDT)
Received: from Zbook.localdomain ([129.227.152.6])
        by smtp.gmail.com with ESMTPSA id f19-20020aa79693000000b0056c003f9169sm8339360pfk.196.2022.11.02.05.40.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Nov 2022 05:40:11 -0700 (PDT)
From:   Yuwei Guan <ssawgyw@gmail.com>
X-Google-Original-From: Yuwei Guan <Yuwei.Guan@zeekrlife.com>
To:     paolo.valente@linaro.org, axboe@kernel.dk
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        Yuwei.Guan@zeekrlife.com
Subject: [PATCH 1/5] block, bfq: remove unnecessary value print
Date:   Wed,  2 Nov 2022 20:39:52 +0800
Message-Id: <20221102123956.230-2-Yuwei.Guan@zeekrlife.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221102123956.230-1-Yuwei.Guan@zeekrlife.com>
References: <20221102123956.230-1-Yuwei.Guan@zeekrlife.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

"peak_rate_samples" is 0 alway when do first dispatch from last reset,
so no need to print it's value.

Signed-off-by: Yuwei Guan <Yuwei.Guan@zeekrlife.com>
---
 block/bfq-iosched.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/block/bfq-iosched.c b/block/bfq-iosched.c
index 7ea427817f7f..7a15b2689cb8 100644
--- a/block/bfq-iosched.c
+++ b/block/bfq-iosched.c
@@ -3573,8 +3573,7 @@ static void bfq_update_peak_rate(struct bfq_data *bfqd, struct request *rq)
 	u64 now_ns = ktime_get_ns();
 
 	if (bfqd->peak_rate_samples == 0) { /* first dispatch */
-		bfq_log(bfqd, "update_peak_rate: goto reset, samples %d",
-			bfqd->peak_rate_samples);
+		bfq_log(bfqd, "update_peak_rate: goto reset");
 		bfq_reset_rate_computation(bfqd, rq);
 		goto update_last_values; /* will add one sample */
 	}
-- 
2.34.1


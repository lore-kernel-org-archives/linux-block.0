Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CBCE1C47094
	for <linux-block@archiver.kernel.org>; Thu, 10 Jun 2021 07:23:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B736C613C9
	for <linux-block@archiver.kernel.org>; Thu, 10 Jun 2021 07:23:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229910AbhFJHZB (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 10 Jun 2021 03:25:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229845AbhFJHY7 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 10 Jun 2021 03:24:59 -0400
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D83D2C06175F;
        Thu, 10 Jun 2021 00:22:47 -0700 (PDT)
Received: by mail-pj1-x1036.google.com with SMTP id g6-20020a17090adac6b029015d1a9a6f1aso4992207pjx.1;
        Thu, 10 Jun 2021 00:22:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=kfQ3tysIoxsatHCHD/2ZhyT8LCxPccS8PgExkIm8Ohw=;
        b=YuNTH/WPBz0RcBqYDcg7MOg05TkYxAeFC6uTvZHLnQtsB55wVeI8iXMoqkeXqd0jqT
         B22YepKsHMZTVdraNru3SOZB07/IGW9adclkEo5jbL9CNYZ+NoQtboc1bVbMbz1kl3Js
         IuLlTdDFaSqX8/jsprCpa2MFa2OSutCArAoX3qUfgltlQzprcifXA7T+k7hLyDtBgzLg
         IrT00i3xPovMloatCmVkom5MssMYdP0BdrHEtpNxh4VXimzOQcQfz47qMZGgKFhqMmz8
         tDMo7JubsQpRvkHVctK9b/FNwfn/5ojmEspcIJ1wFBMwtgg8sb4B+615ouEspBUGYbyS
         1dqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=kfQ3tysIoxsatHCHD/2ZhyT8LCxPccS8PgExkIm8Ohw=;
        b=PUGfGTrZkvU73KYIPciDB/3fQrh2a7W4proVbn+jOGMoWLUojI56ArR21PJTfm1Xo8
         SatpMNBPn9cDpRMmjMfm/tSBOybRt+oc/wx2h+Ub2NEXAliz4qBKohMOepESCEBFyhFA
         KXIPcDsGzwPqp4z6MHvly0C6hqbGIPepKmeAYp+4orSCzVITkhS2J2IUgL4EDOls/9mZ
         8zHGe52PH7R4mQP6KbAoBli+sqUs6HD7lFaEroq0TqZQHSvWzxsXZ2o2cAa/p1a0SGVt
         l0SNc9scl/ldOtOUFviVr7DqK7M+XCp4XzyI0Sud6BqzlaaZyWepHzNsWXPJ1eEVulwM
         /a0w==
X-Gm-Message-State: AOAM5303M6Hx/8aYFdUNESWCxehLsilHCifaJoGIzLK3w3J//7Di5r09
        fP4mZQf5jTWyba2CiibbaEY=
X-Google-Smtp-Source: ABdhPJzmtp4vb1n3UQjfUtiT5FOILGB2PveaNJ4ICvMaNmjRI5PSbEWClY2dhEYcTllc/SARGzVgTA==
X-Received: by 2002:a17:90a:ee84:: with SMTP id i4mr2033827pjz.34.1623309767559;
        Thu, 10 Jun 2021 00:22:47 -0700 (PDT)
Received: from VM-0-3-centos.localdomain ([101.32.213.191])
        by smtp.gmail.com with ESMTPSA id u24sm1591310pfm.200.2021.06.10.00.22.46
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 10 Jun 2021 00:22:47 -0700 (PDT)
From:   brookxu <brookxu.cn@gmail.com>
To:     paolo.valente@linaro.org, axboe@kernel.dk
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [RESEND PATCH 6/8] bfq: optimize the calculation of bfq_weight_to_ioprio()
Date:   Thu, 10 Jun 2021 15:22:35 +0800
Message-ID: <d824bd955851ea5cb5af54b6b901045f058207b2.1618916839.git.brookxu@tencent.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1ce935f1bb10e0c7ecea7b79b826ff4cfc89acf0.1618916839.git.brookxu@tencent.com>
References: <1ce935f1bb10e0c7ecea7b79b826ff4cfc89acf0.1618916839.git.brookxu@tencent.com>
In-Reply-To: <cover.1618916839.git.brookxu@tencent.com>
References: <cover.1618916839.git.brookxu@tencent.com>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org
Message-ID: <20210610072235.TcwN2nMpCtTpp1wh34mviKP_xpVox8LxGUMaTbTzJxQ@z>

From: Chunguang Xu <brookxu@tencent.com>

The value range of ioprio is [0, 7], but the result of
bfq_weight_to_ioprio() may exceed this range, so simple
optimization is required.

Signed-off-by: Chunguang Xu <brookxu@tencent.com>
---
 block/bfq-wf2q.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/block/bfq-wf2q.c b/block/bfq-wf2q.c
index 619ed21..ea5b90d 100644
--- a/block/bfq-wf2q.c
+++ b/block/bfq-wf2q.c
@@ -527,8 +527,9 @@ unsigned short bfq_ioprio_to_weight(int ioprio)
  */
 static unsigned short bfq_weight_to_ioprio(int weight)
 {
-	return max_t(int, 0,
-		     IOPRIO_BE_NR * BFQ_WEIGHT_CONVERSION_COEFF - weight);
+	int ioprio = IOPRIO_BE_NR  - weight / BFQ_WEIGHT_CONVERSION_COEFF;
+
+	return ioprio < 0 ? 0 : min_t(int, ioprio, IOPRIO_BE_NR - 1);
 }
 
 static void bfq_get_entity(struct bfq_entity *entity)
-- 
1.8.3.1


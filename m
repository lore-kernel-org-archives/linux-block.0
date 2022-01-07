Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 468B9C433EF
	for <linux-block@archiver.kernel.org>; Fri,  7 Jan 2022 07:00:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233413AbiAGHAM (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 7 Jan 2022 02:00:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232115AbiAGHAM (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Fri, 7 Jan 2022 02:00:12 -0500
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11061C061245
        for <linux-block@vger.kernel.org>; Thu,  6 Jan 2022 23:00:12 -0800 (PST)
Received: by mail-pj1-x1031.google.com with SMTP id ie13so4473788pjb.1
        for <linux-block@vger.kernel.org>; Thu, 06 Jan 2022 23:00:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id;
        bh=BgynVL/gzf+HxcEgfo712iBAiRzchXf8WR1GfTyVwNQ=;
        b=KioNUxoknTJRU3pT2pSl1C9okn7chN/IpTNWJXG5FSeMbQg5RNki6JeJ10ulnGsbVN
         4M9La1CmUZouY2+afrg5+QwNcRLVG/nUiNBWFf+oJ6QUBPw4ETNpEH6expSR2vepHYph
         k10k30u/yBlc4x3sIKYOCq4tbjap2/JDnj6NN80sFr4q+Rf36iKdyPXOnsF2960MP+eU
         ApNSz/cjsHqE5Ki3qeEn3xrHT5KALikNw9UEidPt1mer9mBEnRQQs/sYEbRTchGVDgwN
         7lYJBAdsoygJ/rxVzHiXHKj0MQsHQX4asN6YY/QHRNik8Iym/g2EPW9dwEAACVISt81h
         NdxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=BgynVL/gzf+HxcEgfo712iBAiRzchXf8WR1GfTyVwNQ=;
        b=gL+BT5PHk1MYpYw8K2HOSbrENlOjikFxeX94VfuFAXAqZcIvB7s/CbOdWsYOJwKIaJ
         aqZi1npC9/TYqUj5ofyyJ7DN7kKUtu2BIfu3Nho/R8xo4x1mhWpdBrWH+B62z/qFXG+R
         9kaJztezkcIN6PGAK/1lh1GUMNHRkZgUCwLaB1HkoINdct7b2RcUfg4F9dE9IxhyvTUl
         QL5hTbLzA79RWfHG3o91wgR94cJzb2GJ6HxZ6r1p0kgCDOldqkE92RzoyCeiKdKkUkPf
         f8qK4Ix7GAmJzS30mzp4rXnHr/Swuaxz0XFKMnwAfMh4Tyd4T3P2MGAF0GhPI+rf6hUi
         aOsQ==
X-Gm-Message-State: AOAM531atgG7M6AAab/NYped1M9OmbajUB7VNdQ81OFwjMu4X8H5c9qf
        Ie4xNLE/rzb7xn7l/g/EXOg=
X-Google-Smtp-Source: ABdhPJxtOFO6tzPUig5O3kokrr7RA1jrRqc5jJSY/OdnA0+3PWV7guBzFo3/+bSFLDrnbNAVTj9x/A==
X-Received: by 2002:a17:90a:f0d2:: with SMTP id fa18mr14226868pjb.208.1641538811614;
        Thu, 06 Jan 2022 23:00:11 -0800 (PST)
Received: from localhost.localdomain ([111.194.45.133])
        by smtp.gmail.com with ESMTPSA id n13sm4355642pfa.197.2022.01.06.23.00.10
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 06 Jan 2022 23:00:11 -0800 (PST)
From:   gaoyahu19@gmail.com
To:     paolo.valente@linaro.org, axboe@kernel.dk
Cc:     linux-block@vger.kernel.org, Yahu Gao <gaoyahu19@gmail.com>
Subject: [PATCH] block/bfq_wf2q: correct weight to ioprio
Date:   Fri,  7 Jan 2022 14:58:59 +0800
Message-Id: <20220107065859.25689-1-gaoyahu19@gmail.com>
X-Mailer: git-send-email 2.15.0
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

From: Yahu Gao <gaoyahu19@gmail.com>

The return value is ioprio * BFQ_WEIGHT_CONVERSION_COEFF or 0.
What we want is ioprio or 0.
Correct this by changing the calculation.

Signed-off-by: Yahu Gao <gaoyahu19@gmail.com>

diff --git a/block/bfq-wf2q.c b/block/bfq-wf2q.c
index b74cc0da118e..709b901de3ca 100644
--- a/block/bfq-wf2q.c
+++ b/block/bfq-wf2q.c
@@ -519,7 +519,7 @@ unsigned short bfq_ioprio_to_weight(int ioprio)
 static unsigned short bfq_weight_to_ioprio(int weight)
 {
 	return max_t(int, 0,
-		     IOPRIO_NR_LEVELS * BFQ_WEIGHT_CONVERSION_COEFF - weight);
+		     IOPRIO_NR_LEVELS - weight / BFQ_WEIGHT_CONVERSION_COEFF);
 }
 
 static void bfq_get_entity(struct bfq_entity *entity)
-- 
2.15.0


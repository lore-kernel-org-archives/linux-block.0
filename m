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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9DB2DC433DB
	for <linux-block@archiver.kernel.org>; Fri, 19 Mar 2021 20:27:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 55AFB61949
	for <linux-block@archiver.kernel.org>; Fri, 19 Mar 2021 20:27:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230386AbhCSU03 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 19 Mar 2021 16:26:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230235AbhCSU0Y (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 19 Mar 2021 16:26:24 -0400
Received: from mail-qt1-x82c.google.com (mail-qt1-x82c.google.com [IPv6:2607:f8b0:4864:20::82c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04B60C06175F;
        Fri, 19 Mar 2021 13:26:17 -0700 (PDT)
Received: by mail-qt1-x82c.google.com with SMTP id l13so7767789qtu.9;
        Fri, 19 Mar 2021 13:26:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=2t928gsrhu4D3shTJrBb6jz+eBADEYnd7nVvRsAo5E4=;
        b=ZaBgrO6PQv5DsjN4MXXmh1ctQYQquyv4Ta8pLUQ7vGNpALvTZhm+zomKoyfv/ixyqp
         WyvAojp7UXg/aa7/XFDEAMgu1gGCf89bnIPlqjZV/QApZD/aipUgUpkPhWSG9VruU6AQ
         xNsLRFpJXgdOy7xk84Xol7+TXJ2fyEgFiGaJIybacXAXugbZO1cR3NjFHpIwsQv/1b0K
         yZKIRNWmd2H6JKvCk9ZlAkUv60EKyhTZTg9PfEWc6uvDg5u4p2FxLqpSSsMhswbK8Wg9
         67Dsx4hRA+RI+9cYCvzUK9YmasTYwTQvh+8zKheFRB9TvFyvYZQdeX8CcyCebdZgAdtT
         Dn5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=2t928gsrhu4D3shTJrBb6jz+eBADEYnd7nVvRsAo5E4=;
        b=eadYFzzY2jI0A4dmWaWO0Flbc2Plncl3ggoket7tm+iK/AhxA6yklqVQN5PdybwZxy
         Z7u15XpuQXZ8Cb+weoiZ+pHMBdDyhHOvDMVnNiEDoHpMcxJ7alliyklQtZm90qfmNwpc
         cihSvZAqPWDCG38FDWPJx5Fn93kkzY0jeBDPIoOVY4PmiF0osiacMo4weTd4sJqqNpR1
         Mq7uIU9kxoqQ14tj3ev4AdZP/IT14jrlh5CyaubqqaLSedCuzlSuvHTLWQJh/tBzSAgT
         xsMY1V4hPKbeg4L5ydQCmaLDNGynDIAvEsQJTEAOctH8+kVuiNYxjYVuRCuwos/BFo2i
         1yFg==
X-Gm-Message-State: AOAM530T2aY43e7jv58wuj8nfXPqYc185SIiQ9pwRZ+VxDbVkrnSQfdk
        1qRB5KFJJd1OhxnlXhpJETNnfPJ1KKPSFdmC
X-Google-Smtp-Source: ABdhPJwTUlHucRZaQzryTHuXxp7H+/xppx37gFNYPGH7doHyJTjcZB+S7JRk2VuLrERv8OHRO2rflg==
X-Received: by 2002:aed:2f81:: with SMTP id m1mr386777qtd.319.1616185576273;
        Fri, 19 Mar 2021 13:26:16 -0700 (PDT)
Received: from localhost.localdomain ([37.19.198.27])
        by smtp.gmail.com with ESMTPSA id i9sm5368156qko.69.2021.03.19.13.26.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Mar 2021 13:26:15 -0700 (PDT)
From:   Bhaskar Chowdhury <unixbhaskar@gmail.com>
To:     axboe@kernel.dk, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     rdunlap@infradead.org, Bhaskar Chowdhury <unixbhaskar@gmail.com>
Subject: [PATCH V3] blk-mq: Trivial typo fix and sentence construction for better readability
Date:   Sat, 20 Mar 2021 01:53:59 +0530
Message-Id: <20210319202359.8893-1-unixbhaskar@gmail.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org


A typo fix and sentence reconstruction for better readability.

Signed-off-by: Bhaskar Chowdhury <unixbhaskar@gmail.com>
---
  Changes from V2:
  Thanks, Randy and Tom for the suggestion,mould it.
  Missed the subject line prefix of pattern,so added back

 block/blk-mq-tag.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/block/blk-mq-tag.c b/block/blk-mq-tag.c
index 9c92053e704d..9da426d20f12 100644
--- a/block/blk-mq-tag.c
+++ b/block/blk-mq-tag.c
@@ -373,8 +373,8 @@ static bool blk_mq_tagset_count_completed_rqs(struct request *rq,
 }

 /**
- * blk_mq_tagset_wait_completed_request - wait until all completed req's
- * complete funtion is run
+ * blk_mq_tagset_wait_completed_request - wait until all the req's
+ * functions completed their run
  * @tagset:	Tag set to drain completed request
  *
  * Note: This function has to be run after all IO queues are shutdown
--
2.26.2


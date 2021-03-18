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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94C7AC433E0
	for <linux-block@archiver.kernel.org>; Thu, 18 Mar 2021 11:15:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4C8C264F04
	for <linux-block@archiver.kernel.org>; Thu, 18 Mar 2021 11:15:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230015AbhCRLO3 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 18 Mar 2021 07:14:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230014AbhCRLOS (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 18 Mar 2021 07:14:18 -0400
Received: from mail-qv1-xf2b.google.com (mail-qv1-xf2b.google.com [IPv6:2607:f8b0:4864:20::f2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3322EC06174A;
        Thu, 18 Mar 2021 04:14:18 -0700 (PDT)
Received: by mail-qv1-xf2b.google.com with SMTP id d10so2945622qve.7;
        Thu, 18 Mar 2021 04:14:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=F6DaVzEITLMEzFxuhcyQKoZc4IE509gWxa28djz/r0s=;
        b=OuWgqOabvJBMmoipUuAMrvUAtq0zBfKO1ZR/j3fxnpZC4ShFdTcY4hx/pwTUbTsllf
         s8UDuj5VpPOKRCHjNXFXV6swaCN7ghtKMEyurvey6fLB+8P5lD6OpU+axVMHimpl+39+
         mrQN7/GRU9pkSrYqNKZgtVVJFvzTqdHpXIBqW3y5kljy4I3AayWxP1TZu+qw2EewyNfH
         2juWmvp6WDh956Ktxk0rsTJaE/cf5X6wNQFbJ9G044Gifl6Y5BtRmHsw4vDusWYwm8dZ
         2skRDLHAccRyr5Hc5UyirWWB4CXbr8cNTVtZKvoF+5X046VXq6YKMolrrjeT4/lNspU9
         zq3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=F6DaVzEITLMEzFxuhcyQKoZc4IE509gWxa28djz/r0s=;
        b=pemASy4kSPTCEBXAhSAJWO0EBKp0SRDkqNM3mCw6aO03mq3pwF5BFKcurVhwfIhBtt
         9IddvLYOfgle2txWPGyGEerP6zhcr1NfsXzVGSfdV69RKkEC7Rhp93OQkOzsdSN1AWx3
         TqLAA8R0/OjKMv/g6smfOoUlzmrgTm2Ky2Gd9N3DTzLlJBXWNKeN3z1/5Qhbss/Dofpc
         EnApPNFr2A+X9YPVfhYhXNMROLLD4Ltoo4cKQTL9inV932BZpNVw/mwEeaduPtFG704E
         8QnSsoiOdNpoMWqq8tmnde4BFoQaIvqw13mqkXOVMkcNy6PQjIpsX1U+QLdXhOzn5sjX
         Zm1g==
X-Gm-Message-State: AOAM530C70BUIAZnUKCb69VVqiKzZUHtpOdrDd9JQz7wGC/DP6uOhe1g
        2htLLnaKLkAIGf2WV1Zk4edtPSQ/Hm0Rt5ay
X-Google-Smtp-Source: ABdhPJz8gZJ1VQEWGDtxwlOJoO1jtjPDHeAqnXuxjTqADBFZc2JMy56AF1hHd2p0qt4ym4ep2oKriQ==
X-Received: by 2002:a05:6214:13b3:: with SMTP id h19mr3753851qvz.31.1616066057425;
        Thu, 18 Mar 2021 04:14:17 -0700 (PDT)
Received: from localhost.localdomain ([156.146.54.246])
        by smtp.gmail.com with ESMTPSA id x10sm1111327qtw.17.2021.03.18.04.14.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Mar 2021 04:14:16 -0700 (PDT)
From:   Bhaskar Chowdhury <unixbhaskar@gmail.com>
To:     axboe@kernel.dk, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     rdunlap@infradead.org, Bhaskar Chowdhury <unixbhaskar@gmail.com>
Subject: [PATCH]  block: Fix a typo
Date:   Thu, 18 Mar 2021 16:42:04 +0530
Message-Id: <20210318111204.20873-1-unixbhaskar@gmail.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

s/trival/trivial/

Signed-off-by: Bhaskar Chowdhury <unixbhaskar@gmail.com>
---
 block/blk-merge.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/block/blk-merge.c b/block/blk-merge.c
index ffb4aa0ea68b..ba112cffd49f 100644
--- a/block/blk-merge.c
+++ b/block/blk-merge.c
@@ -283,7 +283,7 @@ static struct bio *blk_bio_segment_split(struct request_queue *q,
 	/*
 	 * Bio splitting may cause subtle trouble such as hang when doing sync
 	 * iopoll in direct IO routine. Given performance gain of iopoll for
-	 * big IO can be trival, disable iopoll when split needed.
+	 * big IO can be trivial, disable iopoll when split needed.
 	 */
 	bio->bi_opf &= ~REQ_HIPRI;

--
2.26.2


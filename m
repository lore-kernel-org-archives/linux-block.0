Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA39BC433E0
	for <linux-block@archiver.kernel.org>; Sun, 14 Feb 2021 10:32:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 80EA064E52
	for <linux-block@archiver.kernel.org>; Sun, 14 Feb 2021 10:32:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229637AbhBNKcF (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sun, 14 Feb 2021 05:32:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229575AbhBNKcE (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sun, 14 Feb 2021 05:32:04 -0500
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21AD6C061756
        for <linux-block@vger.kernel.org>; Sun, 14 Feb 2021 02:31:23 -0800 (PST)
Received: by mail-ed1-x536.google.com with SMTP id df22so4889682edb.1
        for <linux-block@vger.kernel.org>; Sun, 14 Feb 2021 02:31:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lightnvm-io.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=r6lfNCFf4uKnnzJN/1ss3nfQ+Q8FtVs4F7Dj+Ua2rTA=;
        b=WDW2Keoae3cOc4k4eLbq/veMFVTgA1wVt5pvVxq/WJTjG7kuPIdvUSQdPBTulud5U9
         fM1VdNUvplD8WMBVS77jAhEk3qNsU+ZR6701r8YEZgK43bk56Ct+1SfLkQGQMWCev9LD
         qaYA8zdxj+CrJn+48B5UJCGfpMlCFCSJL724y0nHedfmcFGGzmsAV8+8hFlo4S+R73pa
         4OMMzrDVszyKjyMg0CuRjH7RG9Asv1ZRcct4ZuVrAMGGcVjtW+Zxl0fHI90EL5Nmtvx/
         na/VrGRILiy8RSobhmV0syIN5RNhpHITUe0lvhLVH7pOVNvPpkMVRKxsqUD4XC0D8KcB
         L16Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=r6lfNCFf4uKnnzJN/1ss3nfQ+Q8FtVs4F7Dj+Ua2rTA=;
        b=hDvF6OqZknVWByjNo0ZmSR8VZH8hdrHXmrvVE0IpfNqdGRPDr8uFTe6zJ03qcZuoXw
         ma3enymozcJvSkEFX15zqYTcNr2Li5fwkP5ZO3mb30t699JinUNJlNe2hxZtQFY5uD3w
         4xLt6Qpje493RffrURspoPgbpMHpbwj5DCn1ZMVHSm4fMH2FAUClQTPTGuXv/aRWHSqd
         f4csyCSw+qC8aqT7Af4eHKcE5Wf78h4A7Zi4mjtr3dsYlSecgQiwpbIgDpR6weJ9eZMv
         ujRuLLVqe6qaZUYRKqorwjumBBKvXEHzCn1DQyx20rxmhyCMfEzf8eNlUZU/3GLzLnl2
         HmTw==
X-Gm-Message-State: AOAM530eKKHHT3sDuQkmCWiudq1FlSs2M87e7JziYyGgLj1G0cWTbBCG
        JvRUeyHxDMZLykG8taZ3S5QCVA==
X-Google-Smtp-Source: ABdhPJyE3Lt+s4+Drdb++31omBVZy7TDEq+TkdOJw7dKZKXxsHM7DzH6hoGU6FEWfMJOA6+o8a+YhA==
X-Received: by 2002:a05:6402:26d5:: with SMTP id x21mr11055285edd.50.1613298681879;
        Sun, 14 Feb 2021 02:31:21 -0800 (PST)
Received: from dellx1.cphwdc ([87.116.37.42])
        by smtp.googlemail.com with ESMTPSA id c18sm8180512edu.20.2021.02.14.02.31.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 14 Feb 2021 02:31:21 -0800 (PST)
From:   "=?UTF-8?q?Matias=20Bj=C3=B8rling?=" <mb@lightnvm.io>
X-Google-Original-From: =?UTF-8?q?Matias=20Bj=C3=B8rling?= <matias.bjorling@wdc.com>
To:     axboe@kernel.dk, m@bjorling.me
Cc:     linux-block@vger.kernel.org, Tian Tao <tiantao6@hisilicon.com>,
        =?UTF-8?q?Matias=20Bj=C3=B8rling?= <matias.bjorling@wdc.com>
Subject: [PATCH 1/2] lightnvm: fix unnecessary NULL check warnings
Date:   Sun, 14 Feb 2021 10:31:02 +0000
Message-Id: <20210214103103.122312-2-matias.bjorling@wdc.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210214103103.122312-1-matias.bjorling@wdc.com>
References: <20210214103103.122312-1-matias.bjorling@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

From: Tian Tao <tiantao6@hisilicon.com>

Remove NULL checks before vfree() to fix these warnings:
./drivers/lightnvm/pblk-gc.c:27:2-7: WARNING: NULL check before some
freeing functions is not needed.

Signed-off-by: Tian Tao <tiantao6@hisilicon.com>
Signed-off-by: Matias Bjørling <matias.bjorling@wdc.com>
---
 drivers/lightnvm/pblk-gc.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/lightnvm/pblk-gc.c b/drivers/lightnvm/pblk-gc.c
index 2581eebcfc41..b31658be35a7 100644
--- a/drivers/lightnvm/pblk-gc.c
+++ b/drivers/lightnvm/pblk-gc.c
@@ -23,8 +23,7 @@
 
 static void pblk_gc_free_gc_rq(struct pblk_gc_rq *gc_rq)
 {
-	if (gc_rq->data)
-		vfree(gc_rq->data);
+	vfree(gc_rq->data);
 	kfree(gc_rq);
 }
 
-- 
2.25.1


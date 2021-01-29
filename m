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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 043C7C433DB
	for <linux-block@archiver.kernel.org>; Fri, 29 Jan 2021 05:02:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BBAE564DFF
	for <linux-block@archiver.kernel.org>; Fri, 29 Jan 2021 05:02:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229463AbhA2FCm (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 29 Jan 2021 00:02:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229461AbhA2FCl (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 29 Jan 2021 00:02:41 -0500
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45E9EC061573;
        Thu, 28 Jan 2021 21:02:01 -0800 (PST)
Received: by mail-ej1-x62a.google.com with SMTP id r12so11135181ejb.9;
        Thu, 28 Jan 2021 21:02:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=cWhDKyAXxdtoRhlimIC6AARbTEG5Y6B4xyJpzTlH1ic=;
        b=TqydaINHVDf61oMmpXJSGXqjdWA9unjIvfQkItjpW465EUUD6dSHM7dg7Zyciw1wlS
         xsoTGJWllfARh5RUWsq/rBMc56JTdf0rt7Q38k5GkB+8eDrTScy/UbX5dMEmPcXY4Sgw
         Hnk9RJW9JrY9Pqh9OIqo96XaJUp4TbvbRQDr+utjOHUhGph5QRhlyjnaFby2ese3c2sv
         DZfTCOAzQ0FuTzWBy//AeHqiO+CNDh9BzzHvd3F0eNojjOb1/zyEB1CxEl9QvXukaTLu
         5HTLWB484YPQCgwQ21MINJ3t4fx3NwyL16o1I5VB2j8oJC4ftoTB9ed01e42tZdWUn5c
         zs2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=cWhDKyAXxdtoRhlimIC6AARbTEG5Y6B4xyJpzTlH1ic=;
        b=GZoKDBy9ueGo/B2ARGuK//BoKv67kwyLuvJhK591X+LEIaWxn+BcCGId18M6FKi3t4
         JY94rPePLpkXta9s4yg0LG+zuGbBbyJ7448wdMgX3mTtKTW2z5+94e2UxtTuOIc4GFQW
         euIjWRJAFCQMYXCuIICQNqI5bcQQcN+xOTUPxlOH03sxqyDen7xzi/tGSL1GJhWAWKD5
         4/f/a3jsqRNz9YkMO2PSWU14MaAiEa8U/sI31vdcKDUDTOSFxVD8RfjNVLXxDvaBxLaS
         nlUYPdNaha4EPsD/oZLHzSFj3jWu08QLMCAE0xvy57TvykqSE67Kj2wdOQXbXR74whLb
         euhA==
X-Gm-Message-State: AOAM532b1PvEB57m6ihgY7n8dZQ+GdEvxky2Sr0MscudSPGPwNFHDSTd
        URuQ9U2f90hmi8/U1DDkr5tXEMJ4Zl5oNQ==
X-Google-Smtp-Source: ABdhPJwJ8mJoTHv6rdOAn7+9M7PYDpttdAHFO/GraR9+bM46OM8B+c11D7Aia9OEcAY0zYN30ZHc+A==
X-Received: by 2002:a17:906:1958:: with SMTP id b24mr2767865eje.263.1611896520056;
        Thu, 28 Jan 2021 21:02:00 -0800 (PST)
Received: from felia.fritz.box ([2001:16b8:2d91:2600:859e:aee:ff42:2cc6])
        by smtp.gmail.com with ESMTPSA id lv13sm3240171ejb.55.2021.01.28.21.01.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Jan 2021 21:01:59 -0800 (PST)
From:   Lukas Bulwahn <lukas.bulwahn@gmail.com>
To:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org
Cc:     Guoqing Jiang <guoqing.jiang@cloud.ionos.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        linux-doc@vger.kernel.org, kernel-janitors@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>
Subject: [PATCH] block: drop removed argument from kernel-doc of blk_execute_rq()
Date:   Fri, 29 Jan 2021 06:01:51 +0100
Message-Id: <20210129050151.26926-1-lukas.bulwahn@gmail.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Commit 684da7628d93 ("block: remove unnecessary argument from
blk_execute_rq") changes the signature of blk_execute_rq(), but misses
to adjust its kernel-doc.

Hence, make htmldocs warns on ./block/blk-exec.c:78:

  warning: Excess function parameter 'q' description in 'blk_execute_rq'

Drop removed argument from kernel-doc of blk_execute_rq() as well.

Signed-off-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>
---
Jens, please pick this minor fix on your block-next tree.

 block/blk-exec.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/block/blk-exec.c b/block/blk-exec.c
index 0ab873f10133..beae70a0e5e5 100644
--- a/block/blk-exec.c
+++ b/block/blk-exec.c
@@ -65,7 +65,6 @@ EXPORT_SYMBOL_GPL(blk_execute_rq_nowait);
 
 /**
  * blk_execute_rq - insert a request into queue for execution
- * @q:		queue to insert the request in
  * @bd_disk:	matching gendisk
  * @rq:		request to insert
  * @at_head:    insert request at head or tail of queue
-- 
2.17.1


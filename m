Return-Path: <SRS0=7dNq=DE=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 335DFC4346E
	for <linux-block@archiver.kernel.org>; Sun, 27 Sep 2020 18:47:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E2A7723A03
	for <linux-block@archiver.kernel.org>; Sun, 27 Sep 2020 18:47:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dvHA3FJN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726267AbgI0Sr0 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sun, 27 Sep 2020 14:47:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726255AbgI0Sr0 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sun, 27 Sep 2020 14:47:26 -0400
Received: from mail-lf1-x144.google.com (mail-lf1-x144.google.com [IPv6:2a00:1450:4864:20::144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A679C0613CE;
        Sun, 27 Sep 2020 11:47:25 -0700 (PDT)
Received: by mail-lf1-x144.google.com with SMTP id x69so8548459lff.3;
        Sun, 27 Sep 2020 11:47:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=LP71qDRCjw1+kUcURu5EaEK4+50jk6zp/n5AmbGr3Q8=;
        b=dvHA3FJNbkh8Cr+I3bCCNw6onGNYIOEGlDxd4/r7pcEgKzqVjGEj3JoEWTi2ZACEpB
         NW7vSaCsyYxkkisg7ZgijdfBVmo+5Hs4QVIT0KhMZWJQPuFNYYjzPiaApzwcJXdiprBL
         ezRv5kLkfESxJzIZ9HwNfsXL2k3bk5VlN8N3bbBzyYqYEiBP/52qrSOslLBFeJeUuxtH
         4MAXJGNyjpW6aj2FpZtQ2L9tmPMd6B8cvbpfOJZ5vlvDkeNDiTCGLZ0T+dIEZRPr7rQU
         1zZqKVsum0DClT72uxLJr80iWxG47yhA8JBvrtOZZzJpDHEq7h2Y5VY4e9CPc2LBz6EA
         thWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=LP71qDRCjw1+kUcURu5EaEK4+50jk6zp/n5AmbGr3Q8=;
        b=UKbA72kEl8ucw+ujBTaLU+2U2JAmnd8NSQPNaMndEqN2eVmpFUsPVjOtcPO9y3njpY
         EJ3VJLxRUNvyKm/l6QBoiGGLQ7gQlSRaK+FtocaZGC0y+VbH8kyX+HOGC9/57efqiQ5r
         xdh2iytfPQ4cJydRaPA9dRPwJxEQb1UzspcTllrd1X+q7eNpGal2dWNxI/fpSuZTOjZn
         6ZnElVZHcOncT7YC3GlbM6ctjwjeeF59Nzv/SFydvy5wvK1F7F5N5NswK6hOb1vN35bj
         h8EMAk7ui8M481SACCBd3fdnp64szft7JtWSYe2i6OYm6Mun6ISIkvwwytKEP9rE5XOj
         I6yw==
X-Gm-Message-State: AOAM533HTYwFBAu3emGBXDm49JPrnnes7zYDs/bNMb7A5sBnOhCYUpOK
        d2v9aWb6TiE9LSNKHmum8nRagedmPOcKEA==
X-Google-Smtp-Source: ABdhPJwG4V3hlamlPu3RdBjtxJvqFyZQ2zKY+VpIqyLeigXUADbby3rNEendbhGDSnVdt6y/o6cPjw==
X-Received: by 2002:ac2:4301:: with SMTP id l1mr2543070lfh.389.1601232443861;
        Sun, 27 Sep 2020 11:47:23 -0700 (PDT)
Received: from localhost.localdomain (h-82-196-111-59.NA.cust.bahnhof.se. [82.196.111.59])
        by smtp.gmail.com with ESMTPSA id r28sm2739928ljn.76.2020.09.27.11.47.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 27 Sep 2020 11:47:23 -0700 (PDT)
From:   Rikard Falkeborn <rikard.falkeborn@gmail.com>
To:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Danil Kipnis <danil.kipnis@cloud.ionos.com>,
        Jack Wang <jinpu.wang@cloud.ionos.com>,
        Jens Axboe <axboe@kernel.dk>,
        Rikard Falkeborn <rikard.falkeborn@gmail.com>
Subject: [PATCH] block/rnbd: client: Constify rnbd_mq_ops
Date:   Sun, 27 Sep 2020 20:47:15 +0200
Message-Id: <20200927184715.8961-1-rikard.falkeborn@gmail.com>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

The only usage of rnbd_mq_ops is to assign its address to the ops field
in the blk_mq_tag_set struct, which is a const pointer. Make it const to
allow the compiler to put it in read-only memory.

Signed-off-by: Rikard Falkeborn <rikard.falkeborn@gmail.com>
---
 drivers/block/rnbd/rnbd-clt.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/block/rnbd/rnbd-clt.c b/drivers/block/rnbd/rnbd-clt.c
index d7a69741c0f6..264258ac807a 100644
--- a/drivers/block/rnbd/rnbd-clt.c
+++ b/drivers/block/rnbd/rnbd-clt.c
@@ -1159,7 +1159,7 @@ static int rnbd_init_request(struct blk_mq_tag_set *set, struct request *rq,
 	return 0;
 }
 
-static struct blk_mq_ops rnbd_mq_ops = {
+static const struct blk_mq_ops rnbd_mq_ops = {
 	.queue_rq	= rnbd_queue_rq,
 	.init_request	= rnbd_init_request,
 	.complete	= rnbd_softirq_done_fn,
-- 
2.28.0


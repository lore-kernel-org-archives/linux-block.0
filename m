Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3AD58C433E1
	for <linux-block@archiver.kernel.org>; Thu, 25 Mar 2021 15:30:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F265461A1D
	for <linux-block@archiver.kernel.org>; Thu, 25 Mar 2021 15:30:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229574AbhCYP3y (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 25 Mar 2021 11:29:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230095AbhCYP3x (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 25 Mar 2021 11:29:53 -0400
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB9CDC06174A
        for <linux-block@vger.kernel.org>; Thu, 25 Mar 2021 08:29:52 -0700 (PDT)
Received: by mail-ej1-x62c.google.com with SMTP id b7so3620869ejv.1
        for <linux-block@vger.kernel.org>; Thu, 25 Mar 2021 08:29:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ddO9eelXvjBp3hvrJGg17PhlxijRjIk5UjXMC0YYOFM=;
        b=Pa9ex8dAKrJoTVTEyM3ijCEHJwfIBW6K/nDfgk8sDx1X2Df4JJxXzlOGfuckbkeuKM
         nh0E5aQYpLuy0L7Wur+8MKwsjOqELaoCJnX6w6BsIwR1U8no3XUI5qDNRk5IKVXlcgqs
         inC4NMv1yqzQtFbsTJoaUA0w0bIYhRlSXAY8VCOasQujPCORC/UpNgoXKea8lYuHi/Vy
         tKUwx9o5268ufcpeuVIDKiul13YQCoLQrtv2f1BiOE6hG+jlpkNJfa2GYUlUz+TD9YrT
         iEiQTGB9sfCUzczSnKY0953VoOTm+Xv2+3/SRYr2UdtCPoagsl1RyF2PfgBO1v4RYlzl
         LBKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ddO9eelXvjBp3hvrJGg17PhlxijRjIk5UjXMC0YYOFM=;
        b=OZ3oYvPEFgE57EhOmOAdatA+6nEd3JarZ6TWJVVW+XCmF6tTdfuuxFM3Bt3RVOVEgZ
         aXFcRiSdBGIzb2zZK56ncoSDmFGRJ47LwIJOzmIJU8QGR86Ez6M1lUiCqsnCRjBXA2rc
         FfZN1i+sesJjfM9DsPs4nTcTiVKb1iVdrRrP5TawMivlyn/RfosbRZzuSVHo7COq2enx
         p5+YZmZnhRhewrGgP8yv7Dqguh3bvv/TIL6X/mApMeSNGhGp1MKPiWF0UhMkEhpahlXs
         sYs1ateeCljvRNXaqlDydwkt3tqOkWCIZPOwFfHXALChL7QCfCrfJyDtKEItFGRuzCI9
         ghFg==
X-Gm-Message-State: AOAM533p/r7N+zfJOcMlM6UX3H1qhVxg9Zo9B+kJhE/u/owHe3I9gRT9
        K7ems1aHIrKz2SdAvetsuq7ghl14xFpMww==
X-Google-Smtp-Source: ABdhPJwJBKA9oaWvFFIyYq7D2OqUTfcq0bagEhe1J3Amggk0EYZHYs6PyUZk2JjwaLvf+RqtEj+XXQ==
X-Received: by 2002:a17:906:414e:: with SMTP id l14mr9680388ejk.406.1616686191267;
        Thu, 25 Mar 2021 08:29:51 -0700 (PDT)
Received: from gkim-laptop.fkb.profitbricks.net (ip5f5aeee5.dynamic.kabel-deutschland.de. [95.90.238.229])
        by smtp.googlemail.com with ESMTPSA id b18sm2574837ejb.77.2021.03.25.08.29.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Mar 2021 08:29:51 -0700 (PDT)
From:   Gioh Kim <gi-oh.kim@ionos.com>
To:     linux-block@vger.kernel.org
Cc:     axboe@kernel.dk, hch@infradead.org, sagi@grimberg.me,
        bvanassche@acm.org, haris.iqbal@ionos.com, jinpu.wang@ionos.com,
        Danil Kipnis <danil.kipnis@cloud.ionos.com>,
        Md Haris Iqbal <haris.iqbal@cloud.ionos.com>,
        Jack Wang <jinpu.wang@cloud.ionos.com>
Subject: [PATCH for-rc 01/24] MAINTAINERS: Change maintainer for rnbd module
Date:   Thu, 25 Mar 2021 16:28:48 +0100
Message-Id: <20210325152911.1213627-2-gi-oh.kim@ionos.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210325152911.1213627-1-gi-oh.kim@ionos.com>
References: <20210325152911.1213627-1-gi-oh.kim@ionos.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

From: Danil Kipnis <danil.kipnis@cloud.ionos.com>

Danil steps down, Haris will take over.
Also update email address to ionos.com, the old
cloud.ionos.com will still work for some time.

Signed-off-by: Danil Kipnis <danil.kipnis@cloud.ionos.com>
Acked-by: Md Haris Iqbal <haris.iqbal@cloud.ionos.com>
Signed-off-by: Jack Wang <jinpu.wang@cloud.ionos.com>
---
 MAINTAINERS | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index bf947775390c..723ba354dce6 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -15358,8 +15358,8 @@ N:	riscv
 K:	riscv
 
 RNBD BLOCK DRIVERS
-M:	Danil Kipnis <danil.kipnis@cloud.ionos.com>
-M:	Jack Wang <jinpu.wang@cloud.ionos.com>
+M:	Md. Haris Iqbal <haris.iqbal@ionos.com>
+M:	Jack Wang <jinpu.wang@ionos.com>
 L:	linux-block@vger.kernel.org
 S:	Maintained
 F:	drivers/block/rnbd/
-- 
2.25.1


Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE358C433E0
	for <linux-block@archiver.kernel.org>; Sat, 13 Mar 2021 10:49:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8CB4B64F1C
	for <linux-block@archiver.kernel.org>; Sat, 13 Mar 2021 10:49:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232331AbhCMKsp (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sat, 13 Mar 2021 05:48:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233329AbhCMKsl (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sat, 13 Mar 2021 05:48:41 -0500
Received: from mail-pj1-x1044.google.com (mail-pj1-x1044.google.com [IPv6:2607:f8b0:4864:20::1044])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7CFFCC061574;
        Sat, 13 Mar 2021 02:48:41 -0800 (PST)
Received: by mail-pj1-x1044.google.com with SMTP id q2-20020a17090a2e02b02900bee668844dso11964789pjd.3;
        Sat, 13 Mar 2021 02:48:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=YBe+fxd1qk1cqrj0z4ooO6w48KEsql8AIgpL+9vfl+o=;
        b=Ybzj9nceLWHJ3ckwGyv0MG2caaH3HNW9834KJ1BBb67qCu3S9aT3QUPeaF4/1GtmbK
         n9E69gPxlDOO5hTIKtvRsoRK4xlkaUn3lD9dtTaasIEqSdtwP1LsETJE+wrBzmYL+r/R
         b4PLQcmKgsqGVzFn/U9aDIOHnAydllAkOcYJIG5J7nAqNs03kaECi/Ub6zia86/Ud7T+
         NHLz3Esjp+Tuq2CaC4BNRbqnlu9welW79J1K7YBUq0aJokHUlvLEsuRksmSwwvveCJ/j
         YxEXsf88L3SJb7WxJ954XZTQfmimwCbfr6LFrSMyVhc5g/g9Ihal647neImIaPzS+LqR
         tf7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=YBe+fxd1qk1cqrj0z4ooO6w48KEsql8AIgpL+9vfl+o=;
        b=mYWrpQJFPgQOUp2GDyoF97ePzdih0fBDZk+14wcOXMvvdRArx9pTQjfye05yUOtSX6
         0WXzDjSg3kA+zteXL6OEmOZcOONw/2nv8GwVrgxg6Fzwnjux1V8ctXTG0TkVVmTFniEe
         YofT73d0Wou6XsNpcpOhbGIwaZQZvY/KgNcX7Ec+y5GXmcAYadKZ0VPpC4vugPabOY9u
         arkkvxLHSzYC02m37ObPA1n8gjWPCvF1IHWpo8zPCEwNLNhIVPw6gCwYG+4gEgyd9KfP
         /X1KnHb3PoShtz+rSubZHY4Otsvkm1qGucjSvE8YWTiY9YuvR7lrxSR4VJrF5KdEleMt
         uNOQ==
X-Gm-Message-State: AOAM530P5+Eg4ZjyC52mid606oaOe1Xg0v2sjcCjFlWQss8obnqmKaIu
        lDG3mYkqrq7ktX94zLIG1cc=
X-Google-Smtp-Source: ABdhPJy4Gs3B4wNR4/Pd1aHnryEfQ9M+YBhKlk87cYTDmC+U3oHHGvDGygcinXxIE1qKUBXMkbXiRg==
X-Received: by 2002:a17:90a:174c:: with SMTP id 12mr3054214pjm.40.1615632521065;
        Sat, 13 Mar 2021 02:48:41 -0800 (PST)
Received: from localhost.localdomain ([178.236.46.205])
        by smtp.gmail.com with ESMTPSA id u2sm7975793pfn.79.2021.03.13.02.48.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 13 Mar 2021 02:48:40 -0800 (PST)
From:   menglong8.dong@gmail.com
X-Google-Original-From: zhang.yunkai@zte.com.cn
To:     mb@lightnvm.io
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        Zhang Yunkai <zhang.yunkai@zte.com.cn>
Subject: [PATCH] lightnvm: remove duplicate include in lightnvm.h
Date:   Sat, 13 Mar 2021 02:48:35 -0800
Message-Id: <20210313104835.365458-1-zhang.yunkai@zte.com.cn>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

From: Zhang Yunkai <zhang.yunkai@zte.com.cn>

'linux/blkdev.h' and 'uapi/linux/lightnvm.h' included in 'lightnvm.h'
is duplicated.It is also included in the 5th and 7th line.

Signed-off-by: Zhang Yunkai <zhang.yunkai@zte.com.cn>
---
 include/linux/lightnvm.h | 2 --
 1 file changed, 2 deletions(-)

diff --git a/include/linux/lightnvm.h b/include/linux/lightnvm.h
index 1db223710b28..0908abda9c1b 100644
--- a/include/linux/lightnvm.h
+++ b/include/linux/lightnvm.h
@@ -112,10 +112,8 @@ struct nvm_dev_ops {
 
 #ifdef CONFIG_NVM
 
-#include <linux/blkdev.h>
 #include <linux/file.h>
 #include <linux/dmapool.h>
-#include <uapi/linux/lightnvm.h>
 
 enum {
 	/* HW Responsibilities */
-- 
2.25.1


Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB90BC43460
	for <linux-block@archiver.kernel.org>; Tue, 13 Apr 2021 10:53:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CDB1C613B7
	for <linux-block@archiver.kernel.org>; Tue, 13 Apr 2021 10:53:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237553AbhDMKxa (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 13 Apr 2021 06:53:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237637AbhDMKx3 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 13 Apr 2021 06:53:29 -0400
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21EAEC061574
        for <linux-block@vger.kernel.org>; Tue, 13 Apr 2021 03:53:10 -0700 (PDT)
Received: by mail-ej1-x629.google.com with SMTP id mh2so3613000ejb.8
        for <linux-block@vger.kernel.org>; Tue, 13 Apr 2021 03:53:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lightnvm-io.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=vK+P6yZH8yZzrPNQ8OJQLkBIHcLK9frC/HeCWw+8mU0=;
        b=NCxWM1hNqK8I07R6oQdD6Om79rQI23rMT5Jw7n5er8CWflLYHJwPqhsnB8AcTaYCn8
         xbEy4bZRGX7zHGOiWjwHettp7FtRvZaS6ADflg1ay3Tqoiy1aX9AO0XA/1AnxBdnbVpT
         fgf/Z6P3/1baYQuXwUuqy3z1tM3C64Zep8BoV+e9JcV1I/vMtGKvX1eBPhbB+kVJ6mES
         QByLY7iuOQTeaSX9Ya20/fFyilnErZc/NxGrWHPTz7Cila+ozLHY70jNduiNFsbo8xQl
         m11r38UIEpAPjOMCAs02nFyvXP+gHnCgUFR/wy6vNNJ2gkpLIsF+nxflxx6lVUQBcwgk
         cEeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=vK+P6yZH8yZzrPNQ8OJQLkBIHcLK9frC/HeCWw+8mU0=;
        b=apnIyi2OWwqb5cFKFs/gOQnkkdNqRkcSb9T+Pu4PJ0azmhFUHDsFvGRepUWCTW/EZN
         Kr4Htcl6+Ky+UE4cbfAcUEfY/V0wHd2WVS8AIdMs15AfRiVj8DjKlHlkgFAiRjz6+IqR
         fqnq9jjpi4XPMw/U3upi3ppOQkQoaaZxntpTa7RmKTQH9aGooLXMYW3sPs4lQBE2XVt3
         l7YlXrEhHh+21OsYBonb/zpNBg3QPqHajt/tC67Ud6PQxy4chKuW0dF8poDXiYQDs8PE
         DjdVx5i8x+INsZNnEVaZ9utsvJd0GO/IVUcoZWz1xbrLAzwKGaN1VWK4uFXzPGYERB51
         Bwxw==
X-Gm-Message-State: AOAM533gRzNnh7cUd7JzJs8cPBiQ5IpeATEEtlS37vhunzkc+2nMKTlq
        YQyR97i5R2L+Ljp15QEaSnxWK6/tyrbGAIE82sY=
X-Google-Smtp-Source: ABdhPJyP435AIAsxqu0uKtzjWghzeVKumsnDacoPQZ6iJplx5UicHXfAfn/L9g2ukcrFetjpTc00Ow==
X-Received: by 2002:a17:906:7c4:: with SMTP id m4mr32198019ejc.63.1618311188930;
        Tue, 13 Apr 2021 03:53:08 -0700 (PDT)
Received: from dellx1.cphwdc ([87.116.37.42])
        by smtp.googlemail.com with ESMTPSA id m5sm9140064edi.52.2021.04.13.03.53.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Apr 2021 03:53:08 -0700 (PDT)
From:   "=?UTF-8?q?Matias=20Bj=C3=B8rling?=" <mb@lightnvm.io>
X-Google-Original-From: =?UTF-8?q?Matias=20Bj=C3=B8rling?= <matias.bjorling@wdc.com>
To:     axboe@kernel.dk
Cc:     linux-block@vger.kernel.org, Tian Tao <tiantao6@hisilicon.com>,
        =?UTF-8?q?Matias=20Bj=C3=B8rling?= <matias.bjorling@wdc.com>
Subject: [PATCH 2/4] lightnvm: return the correct return value
Date:   Tue, 13 Apr 2021 10:52:55 +0000
Message-Id: <20210413105257.159260-3-matias.bjorling@wdc.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210413105257.159260-1-matias.bjorling@wdc.com>
References: <20210413105257.159260-1-matias.bjorling@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

From: Tian Tao <tiantao6@hisilicon.com>

When memdup_user returns an error, memdup_user has two different return
values, use PTR_ERR to get the correct return value.

Signed-off-by: Tian Tao <tiantao6@hisilicon.com>
Signed-off-by: Matias Bjørling <matias.bjorling@wdc.com>
---
 drivers/lightnvm/core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/lightnvm/core.c b/drivers/lightnvm/core.c
index 28ddcaa5358b..42774beeba94 100644
--- a/drivers/lightnvm/core.c
+++ b/drivers/lightnvm/core.c
@@ -1257,7 +1257,7 @@ static long nvm_ioctl_info(struct file *file, void __user *arg)
 
 	info = memdup_user(arg, sizeof(struct nvm_ioctl_info));
 	if (IS_ERR(info))
-		return -EFAULT;
+		return PTR_ERR(info);
 
 	info->version[0] = NVM_VERSION_MAJOR;
 	info->version[1] = NVM_VERSION_MINOR;
-- 
2.25.1


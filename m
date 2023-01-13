Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96EC8C678D9
	for <linux-block@archiver.kernel.org>; Fri, 13 Jan 2023 12:45:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241563AbjAMMpP (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 13 Jan 2023 07:45:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241992AbjAMMoR (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 13 Jan 2023 07:44:17 -0500
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B0731BC8A
        for <linux-block@vger.kernel.org>; Fri, 13 Jan 2023 04:36:29 -0800 (PST)
Received: by mail-ej1-x635.google.com with SMTP id tz12so52018669ejc.9
        for <linux-block@vger.kernel.org>; Fri, 13 Jan 2023 04:36:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linbit-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=N1ZPBPraqcCSXLcbBqEiTH4593Z8hkjnTNKrVJO6nsc=;
        b=H1cWTLNMFyabZxRRgStGWeUzanvjp0Bj18ZcRAus/5m28S6QpN3yI1JV+uWc+YzPfU
         IyhyKcRkDRynH5pTc8H99VKS4vSpQywBAL8oVCIkkl6miPByqCFRIWYcxiCArTI5FwM+
         zVEZ40O4VzfAFqpdDexxjWxp6DOvibzhkqNhNqnamU3SWC/y7bIh2q0RWNBzeDEeyYPl
         S9N91Mv8T9e5MO9p88rokudwIsO/OJrHscaNspDv743X4ILM+GEEOAuf25tVuu0pMqL3
         eddMnTZdYDp42Lp4tYh3lLDK9SUdWuoN6Nfc4rRnAhnAeD8bux39C7jc8O+618+2W0Uw
         YTRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=N1ZPBPraqcCSXLcbBqEiTH4593Z8hkjnTNKrVJO6nsc=;
        b=SYU5nSncOZsM6M9XQVDHWCHmz6hVFrEz4+r1x1W+no3a73UoYY0lJ2Ky7n+EEyR9Yc
         g/4uNRWLy5niBziU2IkXV4jC32rDir+UL3MOZe9ak5beq9PbZtzVBjKAsEp7ARIcMCki
         ujqdwn0257PR+U70z62SWlIBsbfFrmpvTwpxl3M3neLqnbjK48BQ3SHtwCAhF2xknQGp
         34wIqqbyrftqj7ohnXT/RvOCXAX9VB00LNOmlTIXGDamS3rLWD4Y+9UNoaUfg10lHsOs
         CQ0tK9tJaFu22PVId2I0cqJ5pP/l4aNlh9IfndQnhLL9C6LyZSPT7AI3mrdOojFgRK1H
         XWKg==
X-Gm-Message-State: AFqh2kqVw72Q8QPWHmDnN/wh2/kJSgbQWE6QOsI366zZHIt/NwujD3K3
        aaArpZTeHN+383Y6J0QRGbhqfQ==
X-Google-Smtp-Source: AMrXdXtMtHzH0ab2fylDfJ3FwmJBMxwWgMb80CrapVMEh3PCsXJ3VEY9ljT7Bfa44WICBObQntdf+w==
X-Received: by 2002:a17:906:838b:b0:851:97ca:7fc9 with SMTP id p11-20020a170906838b00b0085197ca7fc9mr14761111ejx.40.1673613347524;
        Fri, 13 Jan 2023 04:35:47 -0800 (PST)
Received: from localhost.localdomain (h082218028181.host.wavenet.at. [82.218.28.181])
        by smtp.gmail.com with ESMTPSA id 17-20020a170906329100b007c0bb571da5sm8402496ejw.41.2023.01.13.04.35.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Jan 2023 04:35:47 -0800 (PST)
From:   =?UTF-8?q?Christoph=20B=C3=B6hmwalder?= 
        <christoph.boehmwalder@linbit.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     drbd-dev@lists.linbit.com, linux-kernel@vger.kernel.org,
        Lars Ellenberg <lars.ellenberg@linbit.com>,
        Philipp Reisner <philipp.reisner@linbit.com>,
        linux-block@vger.kernel.org,
        =?UTF-8?q?Christoph=20B=C3=B6hmwalder?= 
        <christoph.boehmwalder@linbit.com>,
        Joel Colledge <joel.colledge@linbit.com>
Subject: [PATCH 6/8] MAINTAINERS: add drbd headers
Date:   Fri, 13 Jan 2023 13:35:36 +0100
Message-Id: <20230113123538.144276-7-christoph.boehmwalder@linbit.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20230113123538.144276-1-christoph.boehmwalder@linbit.com>
References: <20230113123538.144276-1-christoph.boehmwalder@linbit.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Signed-off-by: Christoph Böhmwalder <christoph.boehmwalder@linbit.com>
Reviewed-by: Joel Colledge <joel.colledge@linbit.com>
---
 MAINTAINERS | 1 +
 1 file changed, 1 insertion(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 595d59eec7ea..83b6f3a97cf6 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -6349,6 +6349,7 @@ T:	git git://git.linbit.com/linux-drbd.git
 T:	git git://git.linbit.com/drbd-8.4.git
 F:	Documentation/admin-guide/blockdev/
 F:	drivers/block/drbd/
+F:	include/linux/drbd*
 F:	lib/lru_cache.c
 
 DRIVER COMPONENT FRAMEWORK
-- 
2.38.1


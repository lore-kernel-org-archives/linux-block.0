Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C6EFC636D3
	for <linux-block@archiver.kernel.org>; Tue, 31 Jan 2023 08:53:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230487AbjAaIxa (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 31 Jan 2023 03:53:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232040AbjAaIxE (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 31 Jan 2023 03:53:04 -0500
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD2624DCC6
        for <linux-block@vger.kernel.org>; Tue, 31 Jan 2023 00:48:59 -0800 (PST)
Received: by mail-ej1-x629.google.com with SMTP id ud5so39484642ejc.4
        for <linux-block@vger.kernel.org>; Tue, 31 Jan 2023 00:48:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=nd+tvsg6KSMv6B38RTUcGd8BtF6CnxphvFmUhBr+9WU=;
        b=DV1vJvBc1hy/6sAM6A9EzefNCcFntCGkBYlFjKgSLcpujlWeaYt0BzcMg+5rSMizux
         rkLbf+CuG6oHUcW9/twxK99E1T8yQDTOm2PDr2n2JfJwIff1u0187qV8O0GqYGqLlZc2
         JGvF9ZLUUoUWYzcsR+pfa8JlOxm7JxnuhS235+VVfuy45xh0suWWGqYYDykpq+bbj6to
         bfwEl0BDHQMkt4oZs8Ek40j/Sm+gPnwBwEmMstwHtaOURt38v1faA8C+GsEe8L3Kjq32
         sgql8dqCM5Ug/aGmlOVixDZI5VuBjelf9wqjLh4Jai6iapXm9R4LUaH4y7duPgJJNxdw
         vH0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nd+tvsg6KSMv6B38RTUcGd8BtF6CnxphvFmUhBr+9WU=;
        b=zbQBwQUJFaF48s4p/uhuqFdtgdjiVbGUEBPVBwAXi5NxnJtDrJJ/071Rxj24bOBNii
         oUlr+zS2ob1U/m+1ApN09rcZrwukkBZJ2c8nW6aKSJImA1ZdG0cqJfi3s+s0EovjcZxJ
         AlfJqt1sabZ7nnXl3JISxFeqFw61aH6OK026dU9zJBYlC+kfHniKnYgQ6zCgruDekRUQ
         zvExFGYU1MycBMhzAMaPzSjX6je1nIfrtCkRs7XQiRHag/7O9awOf/kDjt7SPsxxGkzt
         BTIM1G8WEr+Yysja5GKnuPnfIXNtjFOP6hXKM79u3CAaYaQjaGSa/h3Vhn9py/xqEAH4
         1yKQ==
X-Gm-Message-State: AO0yUKUxO8RJ/lS51OLHNIQ5px0PlOZ2lfsNhsGv0yZ/Pa+NbpoTs4xt
        Za/RvYfxkRFjvuXnRlrj7TZKWQ==
X-Google-Smtp-Source: AK7set+ngSsS5aD4/eUOsFdaykj7m0Rjf7jzCJ+pvGpkfTIUtkUsXPUC5onQhSXoLhG5xcGp/dyDFw==
X-Received: by 2002:a17:906:31cd:b0:878:4d11:f868 with SMTP id f13-20020a17090631cd00b008784d11f868mr2587405ejf.2.1675154865483;
        Tue, 31 Jan 2023 00:47:45 -0800 (PST)
Received: from fedora.. ([85.235.10.72])
        by smtp.gmail.com with ESMTPSA id h23-20020a17090619d700b00871ac327db6sm3282850ejd.45.2023.01.31.00.47.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 Jan 2023 00:47:44 -0800 (PST)
From:   Linus Walleij <linus.walleij@linaro.org>
To:     linux-mmc@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        linux-block@vger.kernel.org,
        Paolo Valente <paolo.valente@linaro.org>
Subject: [PATCH] mmc: core: Imply IOSCHED_BFQ
Date:   Tue, 31 Jan 2023 09:47:42 +0100
Message-Id: <20230131084742.1038135-1-linus.walleij@linaro.org>
X-Mailer: git-send-email 2.39.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

If we enable the MMC/SD block layer, use Kconfig to imply the BFQ
I/O scheduler.

As all MMC/SD devices are single-queue, this is the scheduler that
users want so let's be helpful and make sure it gets
default-selected into a manual kernel configuration. It will still
need to be enabled at runtime (usually with udev scripts).

Cc: linux-block@vger.kernel.org
Cc: Paolo Valente <paolo.valente@linaro.org>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 drivers/mmc/core/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/mmc/core/Kconfig b/drivers/mmc/core/Kconfig
index 6f25c34e4fec..52fe9d7c21cc 100644
--- a/drivers/mmc/core/Kconfig
+++ b/drivers/mmc/core/Kconfig
@@ -37,6 +37,7 @@ config PWRSEQ_SIMPLE
 config MMC_BLOCK
 	tristate "MMC block device driver"
 	depends on BLOCK
+	imply IOSCHED_BFQ
 	default y
 	help
 	  Say Y here to enable the MMC block device driver support.
-- 
2.34.1


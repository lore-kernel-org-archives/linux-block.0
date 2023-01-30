Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86CF1C54EAA
	for <linux-block@archiver.kernel.org>; Mon, 30 Jan 2023 12:13:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236700AbjA3MNw (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 30 Jan 2023 07:13:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236326AbjA3MNi (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 30 Jan 2023 07:13:38 -0500
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E07EB93C2
        for <linux-block@vger.kernel.org>; Mon, 30 Jan 2023 04:12:55 -0800 (PST)
Received: by mail-ed1-x529.google.com with SMTP id m8so1503388edd.10
        for <linux-block@vger.kernel.org>; Mon, 30 Jan 2023 04:12:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=fsypYKaGRF+jJzYTBvdHGCa2eKmDzFXH8HWwIO/XXww=;
        b=Zd+HCvUeLb0uufTNY7QD32aA6Xlaqh2+63lss+TEJ8P+o+Cc1R4nP4tuwSxRXd5a+J
         J5KfYmty6aZW8HT95P9ND/UjdNVNfQ5e10QexuuF3eGCMRQjZtXSIUxM2BexYG/OWsYy
         fPEgICBqbUx/YVUMkfV7Tc7RHA7drcFLCDoDGDENmrySPWFAiIVOgxMzL51r5LfaoryW
         9eB2trET3AtOL+YKb/YZ3geqZDvl8ZQ80WaCPr2urs0oa8Vu1dIIfPhdxH86+UXuMmzN
         LZCSiNW9FBtAMWMgMqoZrGBz03SDnXEMqMkuScFG3sy5ka1ubCgdSRETDCjThhzxD1uq
         VESA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fsypYKaGRF+jJzYTBvdHGCa2eKmDzFXH8HWwIO/XXww=;
        b=cey07DP5UcOsOKpSTqhoHk+BYsQgKwkarbbdM1iYpjN4X+jyF+1blx9hiQUB+q7AUU
         Lce5bWoIY6JNfGQUJ/xHAzsxH8KIX3CKqGxHO0/ahpyIz23aDTdezWh+MmD+CQwVOjm1
         TcK+2Pd7G1kGhCBdpie11fPzP/scm0FhOiiHnl4ybDQ+D5u4xdf88eknmCzU9zX1Jo4X
         hSiX5QFcUmp90+E0MwKoAzmYHpQ2i5e4q58f3p6M1HSxfO8PR9W8YgB02A6thQ29sBVF
         5YQ4kKlmYjkem8r0uzTWjjDQF611pyB+/0YxLNt80iXwFENh5gawl7ImI9AxcqM4PAKP
         mp7g==
X-Gm-Message-State: AFqh2kpoxekc/7nIlOxkNzbbBMSDmfHbLXlz8Ehp1VwEqT2FcOyyEhJ5
        tIMYkdmw1XySlUoNjmAopB5XMw==
X-Google-Smtp-Source: AMrXdXstzBqpjcYLIuri+fSWHmV0RZtWThMjtd4dxKCsOjuWHYEyS+lDQ9ZLf2bl1nhAysRSN9Q3uA==
X-Received: by 2002:a05:6402:548f:b0:49c:1fe4:9efc with SMTP id fg15-20020a056402548f00b0049c1fe49efcmr53143801edb.40.1675080766511;
        Mon, 30 Jan 2023 04:12:46 -0800 (PST)
Received: from uffe-XPS13.. (h-94-254-63-18.NA.cust.bahnhof.se. [94.254.63.18])
        by smtp.gmail.com with ESMTPSA id ee36-20020a056402292400b004a21c9facd5sm4215283edb.67.2023.01.30.04.12.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Jan 2023 04:12:45 -0800 (PST)
From:   Ulf Hansson <ulf.hansson@linaro.org>
To:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org
Cc:     Paolo Valente <paolo.valente@linaro.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-kernel@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>
Subject: [PATCH] block: Default to use cgroup support for BFQ
Date:   Mon, 30 Jan 2023 13:12:40 +0100
Message-Id: <20230130121240.159456-1-ulf.hansson@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Assuming that both Kconfig options, BLK_CGROUP and IOSCHED_BFQ are set, we
most likely want cgroup support for BFQ too (BFQ_GROUP_IOSCHED), so let's
make it default y.

Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---
 block/Kconfig.iosched | 1 +
 1 file changed, 1 insertion(+)

diff --git a/block/Kconfig.iosched b/block/Kconfig.iosched
index 615516146086..27f11320b8d1 100644
--- a/block/Kconfig.iosched
+++ b/block/Kconfig.iosched
@@ -30,6 +30,7 @@ config IOSCHED_BFQ
 config BFQ_GROUP_IOSCHED
        bool "BFQ hierarchical scheduling support"
        depends on IOSCHED_BFQ && BLK_CGROUP
+       default y
        select BLK_CGROUP_RWSTAT
 	help
 
-- 
2.34.1


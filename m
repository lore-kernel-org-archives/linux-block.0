Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D415BC433ED
	for <linux-block@archiver.kernel.org>; Thu,  6 May 2021 14:58:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 987CB610FA
	for <linux-block@archiver.kernel.org>; Thu,  6 May 2021 14:58:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234952AbhEFO7g (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 6 May 2021 10:59:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234940AbhEFO7g (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 6 May 2021 10:59:36 -0400
Received: from mail-lj1-x22d.google.com (mail-lj1-x22d.google.com [IPv6:2a00:1450:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0FE7C061761
        for <linux-block@vger.kernel.org>; Thu,  6 May 2021 07:58:37 -0700 (PDT)
Received: by mail-lj1-x22d.google.com with SMTP id w15so7421020ljo.10
        for <linux-block@vger.kernel.org>; Thu, 06 May 2021 07:58:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=pJwR0jpCnsf9y/FTF427NMZV9yLVm+aDyiKh9n5GVw8=;
        b=ckf5P4FnVIgnAHqJq6sdLjCngYSbfUg9saTg+UiXj9SlkI/WGnQwAHvP73bcuenuLn
         L7egDnA2Bpz69apbjpLOE9r6EvVccEOT1FRPTuv6dRbIkAe3xO+6Qxn4jdiaEjQKInIJ
         BQLQlDiQyEAN5jFMAZ7L2W1G+ko0d7WyDTHA2pQnoBvLhq0Ij6AfAApkFBDbicUmsAC2
         W+X2caWQmRzlxeeDNdFVtIzN23PKzcZnUnc4ohOaw9A2s8xGoLzaqQPZKqP4ZRHzLEfG
         j87mbrJYImqP1sc8y03BhRUTRTVhzmPdK81KPskIoRSyU5dfmt7eJfJWnrld24OYkG4D
         Msag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=pJwR0jpCnsf9y/FTF427NMZV9yLVm+aDyiKh9n5GVw8=;
        b=olc6gDTa//HfE7KiziPULSMyJIEtbknwxoa561JLYZTPliotPHJC9akFcewGvg1jvA
         z1B4h1vHtsAyKdTre/A1KWNgzm0RKQAnzEZEVzFK2hkRmO1/Y68B7iRb4mRTj0XGC927
         QUbE5xnbU5V6dqmo5bltvtLiz5A5/OqbDVMpzpGqoyg/gr90EszjPspljv5lY28D22qa
         UNUq4Dgh/h1Jw4Y9V2jiIWIP2HECq2PtQezlaKdLFg87A9vGZn/8ioHBRFslnendl9lK
         /yte5pmFimYFkoHFI2Soue25wY0T8KS3Vs4marlJP4DwSsbx6eyW5T7qi2n6pRI+SZNK
         Fazw==
X-Gm-Message-State: AOAM531XRbpsPhnSLE9bl365ZpyLmuAoyeI4vrHS/cfg2E1kmSzgXvlC
        +hDz8VCnZAvHLtYeu69h2RCpJA==
X-Google-Smtp-Source: ABdhPJzv7VVM6GvFLywf+ZD+Zrrlqtw+C+gVfu7nh8M9qTE51onRSgb9pssQA/ZXXGrDIZCqFFfsKg==
X-Received: by 2002:a2e:a0ca:: with SMTP id f10mr3882282ljm.66.1620313116244;
        Thu, 06 May 2021 07:58:36 -0700 (PDT)
Received: from localhost.localdomain (h-155-4-129-146.NA.cust.bahnhof.se. [155.4.129.146])
        by smtp.gmail.com with ESMTPSA id g24sm968774ljl.44.2021.05.06.07.58.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 May 2021 07:58:35 -0700 (PDT)
From:   Ulf Hansson <ulf.hansson@linaro.org>
To:     linux-mmc@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>,
        Adrian Hunter <adrian.hunter@intel.com>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Shawn Lin <shawn.lin@rock-chips.com>,
        Avri Altman <avri.altman@wdc.com>,
        Masami Hiramatsu <masami.hiramatsu@linaro.org>,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 0/2] mmc: core: Implement support for cache ctrl for SD cards
Date:   Thu,  6 May 2021 16:58:27 +0200
Message-Id: <20210506145829.198823-1-ulf.hansson@linaro.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

In the SD spec v6.x the SD function extension registers for performance
enhancements were introduced. As a part of this an optional internal cache on
the SD card can be used to improve performance.

To let the SD card use the cache, the host needs to enable it and take care of
flushing of the cache. This series implement support for this.

Note that, there are no HW updates needed for the host to support this feature.
This has been tested on 64GB Sandisk Extreme PRO UHS-I A2 card.

The series is based upon another recently posted series [1] that added support
for poweroff notification.

Tests and reviews are of course greatly appreciated!

Kind regards
Ulf Hansson

[1]
https://patchwork.kernel.org/project/linux-mmc/list/?series=476933

Ulf Hansson (2):
  mmc: core: Move eMMC cache flushing to a new bus_ops callback
  mmc: core: Add support for cache ctrl for SD cards

 drivers/mmc/core/block.c   |  2 +-
 drivers/mmc/core/core.h    |  9 ++++
 drivers/mmc/core/mmc.c     | 25 +++++++++-
 drivers/mmc/core/mmc_ops.c | 22 +--------
 drivers/mmc/core/mmc_ops.h |  2 +-
 drivers/mmc/core/sd.c      | 98 ++++++++++++++++++++++++++++++++++++++
 include/linux/mmc/card.h   |  1 +
 7 files changed, 134 insertions(+), 25 deletions(-)

-- 
2.25.1


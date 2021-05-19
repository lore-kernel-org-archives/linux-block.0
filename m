Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CDE69C433ED
	for <linux-block@archiver.kernel.org>; Wed, 19 May 2021 08:56:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A630160C3F
	for <linux-block@archiver.kernel.org>; Wed, 19 May 2021 08:56:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238923AbhESI5s (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 19 May 2021 04:57:48 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:51165 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234781AbhESI5s (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 19 May 2021 04:57:48 -0400
Received: from mail-ed1-f69.google.com ([209.85.208.69])
        by youngberry.canonical.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.93)
        (envelope-from <juerg.haefliger@canonical.com>)
        id 1ljI0C-00042S-4f
        for linux-block@vger.kernel.org; Wed, 19 May 2021 08:56:28 +0000
Received: by mail-ed1-f69.google.com with SMTP id u6-20020aa7d0c60000b029038d7337e633so1122634edo.4
        for <linux-block@vger.kernel.org>; Wed, 19 May 2021 01:56:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=1OkZMVyIQ2WOlWNtNqHDsNx22TsqpoXEJAz21DvSQeI=;
        b=NzPKwVIpTHUSZsLafYrHOxU//orV4listmTetGpjqmaQoOaAZTCYNFN/OGmsqIfIxz
         adk7S5/ctOl3jPUjMHX5rGHwAcRE8qbt7VQo3QprjwQYlKHrUNEbbs0Xvuusazcd9R7f
         6VTf3nQvg+hSL/o7J4HKckJBuMLVYkueOyv8fLAEHloKYlxp7vYFjDc4TCaMSawyo4Yn
         MTIX3nGoLEAToRTtWdaEFA5x7ZIHu1wqB/JBCdq4E7qN82Z2ZBba9xRiY/1pc5rFmXkS
         VZ386PvdKJxmz6/+9dzyT6IArQhHlpagbuucUOxgVB3VdEheSBwbXRl/qOUjaFAsr1sC
         bxCA==
X-Gm-Message-State: AOAM533k3ZHS/xaj00YPHmix2vv0oMiuevJbX1ZPlOjRMw+ubFwwLJ33
        fS81jYOJX9u91OyafYMxZRh2pYX/Ly9AdBnLwYQDRZTNbsZKL8Qo12Ip/nHbiJkCBIK7YNshfow
        NFuOY/6rM1cGcAQow6yci9sT5s42y8UViV/9mrwlB
X-Received: by 2002:a05:6402:54e:: with SMTP id i14mr13083494edx.289.1621414587904;
        Wed, 19 May 2021 01:56:27 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxzeYj2vl0hXB1PffsjwF3w9SjOcnrL7e5EIu40SnqdTjjE0LlWM8FyO34chxeBRqF6tY1VHw==
X-Received: by 2002:a05:6402:54e:: with SMTP id i14mr13083486edx.289.1621414587762;
        Wed, 19 May 2021 01:56:27 -0700 (PDT)
Received: from gollum.fritz.box ([194.191.244.86])
        by smtp.gmail.com with ESMTPSA id l28sm1364816edc.29.2021.05.19.01.56.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 May 2021 01:56:27 -0700 (PDT)
From:   Juerg Haefliger <juerg.haefliger@canonical.com>
X-Google-Original-From: Juerg Haefliger <juergh@canonical.com>
To:     Christoph Hellwig <hch@infradead.org>,
        Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Juerg Haefliger <juergh@canonical.com>
Subject: [PATCH v2 0/3] block: Cleanup Kconfigs
Date:   Wed, 19 May 2021 10:56:12 +0200
Message-Id: <20210519085615.12101-1-juergh@canonical.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Move BLK_CGROUP from init/Kconfig to block/Kconfig per Christoph Hellwig's
request and cleanup various whitespace issues:
  - Replace multi spaces with a tab
  - Make the help text indentation 1 tab + 2 spaces

v2:
  - Move BLK_CGROUP from init/ to block/.
  - Cleanup the other block Kconfig files.

v1: https://lore.kernel.org/lkml/20210516145731.61253-1-juergh@canonical.com/

Juerg Haefliger (3):
  init/Kconfig: Move BLK_CGROUP to block/Kconfig
  block/Kconfig: Whitespace and indentation cleanups
  block/Kconfig.iosched: Whitespace and indentation cleanups

 block/Kconfig         | 155 ++++++++++++++++++++++++------------------
 block/Kconfig.iosched |  27 ++++----
 init/Kconfig          |  22 ------
 3 files changed, 102 insertions(+), 102 deletions(-)

-- 
2.27.0


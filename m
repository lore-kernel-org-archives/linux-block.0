Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-20.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B451DC433E0
	for <linux-block@archiver.kernel.org>; Sat, 16 Jan 2021 18:13:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 79EB92255F
	for <linux-block@archiver.kernel.org>; Sat, 16 Jan 2021 18:13:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727925AbhAPSNr (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sat, 16 Jan 2021 13:13:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727857AbhAPSNq (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sat, 16 Jan 2021 13:13:46 -0500
Received: from mail-pg1-x52f.google.com (mail-pg1-x52f.google.com [IPv6:2607:f8b0:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67455C061573
        for <linux-block@vger.kernel.org>; Sat, 16 Jan 2021 10:13:06 -0800 (PST)
Received: by mail-pg1-x52f.google.com with SMTP id 15so8230299pgx.7
        for <linux-block@vger.kernel.org>; Sat, 16 Jan 2021 10:13:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=to:cc:from:subject:message-id:date:user-agent:mime-version
         :content-language:content-transfer-encoding;
        bh=Eq+zx9MxmPa4AKIZDZ3v9xIKvQgbky5+QsDMHEM7b+U=;
        b=Jh6ka+go++ldfRaOgt5xAtWh3H3SuMw8e+rU8IqizKcZaL3q3OViTiwK393gHxXT0K
         adlu84wNjGi9It6PfmmtfqOHP6Jnl7FaI+UUX1j74S51EpoSucatRe1w6TF2JgW9M2Lu
         GV08y84AdaaDFUh6uGxZqD3Yyyd0K6ZCUSW2X85Cbt8nO8VlovZOik4AajXMo7EYnYzK
         erUKL7NT9CrQRbuQ+KDOOdGvl4X0Fhh2eIXcwKMaJPEgxqFFATsxLe3UDTVbWglmYXnq
         bkZQYuXE+rt55ax3Fd9YsVo4ZKGIXeYQXFmEEm4PLiwjIAqI4H7SkrRMY5mwhO8jTXGH
         Dy8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:cc:from:subject:message-id:date:user-agent
         :mime-version:content-language:content-transfer-encoding;
        bh=Eq+zx9MxmPa4AKIZDZ3v9xIKvQgbky5+QsDMHEM7b+U=;
        b=tdw0dODf1mpaWjOpQnoVaV3Vxy9E/5AzQsqN6FJAbRGgm4fPGpxdFtBsOSkeV1qtoh
         EkZ/WgrAWlIGBpAqDT+6ojwMPIQlQKB+fyOcCsSIfRUCVZbjUwTiiQgUKlrdgh1zepI7
         Q/eKbanbS97kLb9Qz+3zOmV4/XuHMb5EwlCpj2sTfKEgzA0NFwkns15fNvOz9uXRg666
         +ajGIbWv8xw/BpzD9FEHuySXBEyBwDdPZsqczbmHSLLC1W3oLFZTv93M50gy7aXT77fX
         Ex58HFpthLvD7jX4Hp+q5digeEnQ8/D6EvskJeYuoEBBlZAOEUqnq5fbXKUig56WWydR
         q2EA==
X-Gm-Message-State: AOAM531+aGKqTQxaBYNHuUr+QZ8xLvQd81gWWxY8FQGdtiCjKS6yAmZl
        CEtgTFhO5h3oz678qjD0WubFeIr/XI+Z3w==
X-Google-Smtp-Source: ABdhPJyPmuSsY3E/zLpumiAH98/3075zWaA2NMWRLwbEA7NsKPZvtkzFCB1gjlsf6sLlc3HwMTYFMg==
X-Received: by 2002:a65:4785:: with SMTP id e5mr18889557pgs.0.1610820785659;
        Sat, 16 Jan 2021 10:13:05 -0800 (PST)
Received: from [192.168.4.41] (cpe-72-132-29-68.dc.res.rr.com. [72.132.29.68])
        by smtp.gmail.com with ESMTPSA id x6sm11679378pfq.57.2021.01.16.10.13.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 16 Jan 2021 10:13:05 -0800 (PST)
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
From:   Jens Axboe <axboe@kernel.dk>
Subject: [GIT PULL] Block fixes for 5.11-rc4
Message-ID: <95bd6ed5-4851-bd56-f528-d6aebe55bfba@kernel.dk>
Date:   Sat, 16 Jan 2021 11:13:03 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi Linus,

Just an nvme pull request via Christoph:

- don't initialize hwmon for discover controllers (Sagi Grimberg)
- fix iov_iter handling in nvme-tcp (Sagi Grimberg)
- fix a preempt warning in nvme-tcp (Sagi Grimberg)
- fix a possible NULL pointer dereference in nvme (Israel Rukshin)

Please pull!


The following changes since commit 5342fd4255021ef0c4ce7be52eea1c4ebda11c63:

  bcache: set bcache device into read-only mode for BCH_FEATURE_INCOMPAT_OBSO_LARGE_BUCKET (2021-01-09 09:21:03 -0700)

are available in the Git repository at:

  git://git.kernel.dk/linux-block.git tags/block-5.11-2021-01-16

for you to fetch changes up to b4f664252f51e119e9403ef84b6e9ff36d119510:

  Merge tag 'nvme-5.11-2021-01-14' of git://git.infradead.org/nvme into block-5.11 (2021-01-14 15:17:33 -0700)

----------------------------------------------------------------
block-5.11-2021-01-16

----------------------------------------------------------------
Israel Rukshin (1):
      nvmet-rdma: Fix NULL deref when setting pi_enable and traddr INADDR_ANY

Jens Axboe (1):
      Merge tag 'nvme-5.11-2021-01-14' of git://git.infradead.org/nvme into block-5.11

Sagi Grimberg (3):
      nvme-tcp: Fix warning with CONFIG_DEBUG_PREEMPT
      nvme-tcp: fix possible data corruption with bio merges
      nvme: don't intialize hwmon for discovery controllers

 drivers/nvme/host/core.c   | 11 ++++++++---
 drivers/nvme/host/tcp.c    |  4 ++--
 drivers/nvme/target/rdma.c | 16 ++++++++--------
 3 files changed, 18 insertions(+), 13 deletions(-)

-- 
Jens Axboe


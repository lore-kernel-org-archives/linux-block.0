Return-Path: <SRS0=yWSg=4X=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3DC31C3F2D2
	for <linux-block@archiver.kernel.org>; Fri,  6 Mar 2020 02:13:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 13586208C3
	for <linux-block@archiver.kernel.org>; Fri,  6 Mar 2020 02:13:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FVA0lJJ/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726271AbgCFCNA (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 5 Mar 2020 21:13:00 -0500
Received: from mail-lj1-f194.google.com ([209.85.208.194]:35032 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726243AbgCFCNA (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 5 Mar 2020 21:13:00 -0500
Received: by mail-lj1-f194.google.com with SMTP id a12so536375ljj.2;
        Thu, 05 Mar 2020 18:12:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ilcZWM8ZZGGzsQ121o7bnqr5ZHvlnSG+PwQOyk4WfUQ=;
        b=FVA0lJJ/UVF87q0yNXAwBPx7jptqSU9gtmbRoB5DMSCQJxG95cN8UOHHOFYIrq+Hsa
         z+X21Kzc/TtOQ873XNcm+O2OiGL0zIs06DHI5QHhmNcjdleNedFV6ShzXQXlSP8VCFOL
         5CsiXHwdRoLu9OyR/jOyx0qr91JzZdzk6iOhBO78Wit9khoT5CuSttz6gpvRuhplCVsW
         KWG+V5fXhr+FTiDbRh+9fyIQJdR9n8J2Z+OF41+djKK/vW/0JH3jJuVhZrTgJmkatBBM
         LCNtN1s2b7bihRe/3railPiE/SSjtvcanGL6mTup07OsHuS8MglrykTNjASoFNTZFWaw
         6wUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ilcZWM8ZZGGzsQ121o7bnqr5ZHvlnSG+PwQOyk4WfUQ=;
        b=cvz8Lq/On2ybym2zML9hLejc1GD5lE4Dyh1+QRW5l/QZdUxc2m45IPjwIBe6uth7HR
         5AvUi4cVRlJ33dkjugrMC75UTZZIxCplOXX5clysAPgeOn4TA7GusvCI5qZidjxwUzua
         mY+hTFcTCcuu5Nfys+ar/YnRGkbu0mIOHTkfaw+9f3kHt7G6zaxi2uFHJ3FvNt7miAgU
         ElnMfpN6Yh9S0oIman5a+tkTJLECyg5AaKi4IVcO9e7hxMJS8FNIAeQGHJd2tUayPzJE
         5lSooNF/nhScyk7JyPsfPZkqrTuOoAtIIWjNkZdxV/nX6s7wMM/zOw4PTGjm7FrkGbn4
         VQWw==
X-Gm-Message-State: ANhLgQ1CMJgJwJJHrjW1OHrvecxSYUN7VMq6v84UhEusizXi+4ObEzyP
        Ba7LYHCq5uDc9/2Om4+a2xY=
X-Google-Smtp-Source: ADFU+vv89YsCSaHQES0hVkhZSZpx4D34syPpnu8JAalG97eto293yF2eAhv2e8yyVsHVRwybCLMlnQ==
X-Received: by 2002:a2e:8597:: with SMTP id b23mr601458lji.181.1583460778246;
        Thu, 05 Mar 2020 18:12:58 -0800 (PST)
Received: from localhost.localdomain (94-29-39-224.dynamic.spd-mgts.ru. [94.29.39.224])
        by smtp.gmail.com with ESMTPSA id l11sm10592772lfg.87.2020.03.05.18.12.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Mar 2020 18:12:57 -0800 (PST)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Jens Axboe <axboe@kernel.dk>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        =?UTF-8?q?Micha=C5=82=20Miros=C5=82aw?= <mirq-linux@rere.qmqm.pl>,
        David Heidelberg <david@ixit.cz>,
        Peter Geis <pgwipeout@gmail.com>,
        Stephen Warren <swarren@wwwdotorg.org>,
        Nicolas Chauvet <kwizart@gmail.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Billy Laws <blaws05@gmail.com>
Cc:     linux-tegra@vger.kernel.org, linux-block@vger.kernel.org,
        Andrey Danin <danindrey@mail.ru>,
        Gilles Grandou <gilles@grandou.net>,
        Ryan Grachek <ryan@edited.us>, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/8] Introduce NVIDIA Tegra Partition Tablex
Date:   Fri,  6 Mar 2020 05:12:12 +0300
Message-Id: <20200306021220.22097-1-digetx@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Some NVIDIA Tegra devices have GPT entry at a wrong location and others may
even not have it at all. So either a custom workaround for GPT parsing or
TegraPT support is needed for those devices if we want to support them in
upstream kernel. The former solution was already rejected [1], let's try
the latter.

[1] https://patchwork.ozlabs.org/patch/1240809/

Big thanks to everyone who helped with figuring out the TegraPT format!

Changelog:

v2: - Addressed v1 review comments from Stephen Warren by using BIT for
      locating BCT position in IRAM.

    - Added more validations to the TegraPT parser: partition type is
      verified, eMMC instance ID is verified.

    - TegraPT parser now doesn't touch any devices other than eMMC.

    - EKS (encrypted keys) partition is blacklisted now.

    - Implemented eMMC boot partitions scanning. These new patches are
      added in a result:

        mmc: block: Add mmc_bdev_to_part_type() helper
        mmc: block: Add mmc_bdev_to_area_type() helper
        mmc: block: Add MMC_QUIRK_RESCAN_MAIN_BLKDEV
        mmc: block: Enable partition-table scanning for boot partitions
        partitions/tegra: Implement eMMC boot partitions scanning

Dmitry Osipenko (8):
  mmc: core: Add raw_boot_mult field to mmc_ext_csd
  mmc: block: Add mmc_bdev_to_card() helper
  partitions: Introduce NVIDIA Tegra Partition Table
  mmc: block: Add mmc_bdev_to_part_type() helper
  mmc: block: Add mmc_bdev_to_area_type() helper
  mmc: block: Add MMC_QUIRK_RESCAN_MAIN_BLKDEV
  mmc: block: Enable partition-table scanning for boot partitions
  partitions/tegra: Implement eMMC boot partitions scanning

 arch/arm/mach-tegra/tegra.c   |  54 +++
 block/partitions/Kconfig      |   9 +
 block/partitions/Makefile     |   1 +
 block/partitions/check.c      |   4 +
 block/partitions/tegra.c      | 608 ++++++++++++++++++++++++++++++++++
 block/partitions/tegra.h      |  83 +++++
 drivers/mmc/core/block.c      |  85 ++++-
 drivers/mmc/core/mmc.c        |   2 +
 include/linux/mmc/blkdev.h    |  15 +
 include/linux/mmc/card.h      |   2 +
 include/soc/tegra/bootdata.h  |  46 +++
 include/soc/tegra/common.h    |   9 +
 include/soc/tegra/partition.h |  18 +
 13 files changed, 934 insertions(+), 2 deletions(-)
 create mode 100644 block/partitions/tegra.c
 create mode 100644 block/partitions/tegra.h
 create mode 100644 include/linux/mmc/blkdev.h
 create mode 100644 include/soc/tegra/bootdata.h
 create mode 100644 include/soc/tegra/partition.h

-- 
2.25.1


Return-Path: <SRS0=J0qc=5I=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA4EFC3F2CD
	for <linux-block@archiver.kernel.org>; Mon, 23 Mar 2020 16:36:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AC93620658
	for <linux-block@archiver.kernel.org>; Mon, 23 Mar 2020 16:36:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VnyrvGVC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727510AbgCWQfg (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 23 Mar 2020 12:35:36 -0400
Received: from mail-lf1-f65.google.com ([209.85.167.65]:39575 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727277AbgCWQfg (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 23 Mar 2020 12:35:36 -0400
Received: by mail-lf1-f65.google.com with SMTP id j15so10759089lfk.6;
        Mon, 23 Mar 2020 09:35:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=OG7ev3PfnRwui1aOSA4eOfAjJpP9r8Vxr1u3lQi47PA=;
        b=VnyrvGVCK5HBB3jPYwNU2sp2uglOy3BPe4WA6HwqPJWfakC2ZclHqAy4w1bsnse6KE
         OtHsutWPwXiQzLODen4ZpopPyZuSKEDAuFNQszGb8wKYISEs2DgMSp3cym8k5YNbVQjS
         fJwvrTyHPZbkmHd1b74q1J6kVoZnIcPaT3t02vkY3EUPGInaYWzIpmD2DflTh726kO5P
         BKxKZG8d3KBaJivo4N5PuIOsRPH1oD17bb+gkOcccaXUoGIm/vkEswQaIM/D+jX6ytcE
         e/nHXXsvRWnavXabARJ5Ssr2tepiMythXGDoUJ/EeX6hup5IaFOcMjypFhldv8uQ0LZc
         UfZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=OG7ev3PfnRwui1aOSA4eOfAjJpP9r8Vxr1u3lQi47PA=;
        b=kihCm9pIxsEDziZdLvuybwwlnHrHO8T5GGusUtTV+4yE2mdW1D+EPy6FZDSuWYmJTj
         isOxEGAF6UTPdTTz938U0bhl1e8zYhMUnLNH4Bxra6jzi4QRi8nsQeEGXWPtg6XemCTK
         NUOxB8id/DcVmjGtXXwRwvPWu7mE8dBu+aNWqJ8n/40Zdp/RjJnPR5w6vUOOa/stdgeR
         ks8/48Tcnca/0ln8F0YaCgCRSYC41GYqE3RELNm23YZphtD1kxcy03oMYaB2bXh5rJtW
         +QFi2xSZRUj6PwtG5IJcxHB3/I0FpSJhDYvJY9q/BpFtoWx3OOoirQshbnCpfIUfadMi
         eW0g==
X-Gm-Message-State: ANhLgQ2WTtWjOiRj9CBKK/NJIIEodeXJYoyRClw112VPEJ6o2Xy8X2b1
        GssAB9P+gVnmJ0T2iMPbIU4=
X-Google-Smtp-Source: ADFU+vtbJVUjxa13f27OLIshGqKLgoAj1VcGGKuWwdroxICf9Xx82puzL6/OOjSvH+ZJkuFp+a1CCg==
X-Received: by 2002:a19:6746:: with SMTP id e6mr13508388lfj.43.1584981333245;
        Mon, 23 Mar 2020 09:35:33 -0700 (PDT)
Received: from localhost.localdomain (94-29-39-224.dynamic.spd-mgts.ru. [94.29.39.224])
        by smtp.gmail.com with ESMTPSA id m14sm4820017lfo.25.2020.03.23.09.35.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Mar 2020 09:35:32 -0700 (PDT)
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
Subject: [PATCH v3 00/10] Introduce NVIDIA Tegra Partition Table
Date:   Mon, 23 Mar 2020 19:34:21 +0300
Message-Id: <20200323163431.7678-1-digetx@gmail.com>
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

v3: - Fixed "BUG: KASAN: slab-out-of-bounds in tegra_partition". Thanks to
      Peter Geis for noticing the problem.

    - The MMC boot partitions scanning is now opt-in. See this patch:

        mmc: block: Support partition-table scanning on boot partitions

    - The found MMC boot partitions won't be assigned to the MMC boot
      block device ever due to the new GENHD_FL_PART_SCAN_ONCE flag.

      This makes us to ensure that the old behavior of the MMC core is
      preserved for a non-Tegra MMC-block users.

    New patches in v3:

        block: Introduce GENHD_FL_PART_SCAN_ONCE
        mmc: sdhci-tegra: Enable boot partitions scanning on Tegra20 and Tegra30

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

Dmitry Osipenko (10):
  mmc: core: Add raw_boot_mult field to mmc_ext_csd
  mmc: block: Add mmc_bdev_to_card() helper
  partitions: Introduce NVIDIA Tegra Partition Table
  block: Introduce GENHD_FL_PART_SCAN_ONCE
  mmc: block: Add mmc_bdev_to_part_type() helper
  mmc: block: Add mmc_bdev_to_area_type() helper
  mmc: block: Add MMC_QUIRK_RESCAN_MAIN_BLKDEV
  mmc: block: Support partition-table scanning on boot partitions
  mmc: sdhci-tegra: Enable boot partitions scanning on Tegra20 and
    Tegra30
  partitions/tegra: Implement eMMC boot partitions scanning

 arch/arm/mach-tegra/tegra.c    |  54 +++
 block/genhd.c                  |   2 +-
 block/partition-generic.c      |  13 +-
 block/partitions/Kconfig       |  10 +
 block/partitions/Makefile      |   1 +
 block/partitions/check.c       |   4 +
 block/partitions/tegra.c       | 612 +++++++++++++++++++++++++++++++++
 block/partitions/tegra.h       |   8 +
 drivers/mmc/core/block.c       | 104 ++++++
 drivers/mmc/core/mmc.c         |   2 +
 drivers/mmc/host/sdhci-tegra.c |  10 +-
 include/linux/genhd.h          |  12 +
 include/linux/mmc/blkdev.h     |  15 +
 include/linux/mmc/card.h       |   2 +
 include/linux/mmc/host.h       |   2 +
 include/soc/tegra/bootdata.h   |  46 +++
 include/soc/tegra/common.h     |   9 +
 include/soc/tegra/partition.h  |  91 +++++
 18 files changed, 993 insertions(+), 4 deletions(-)
 create mode 100644 block/partitions/tegra.c
 create mode 100644 block/partitions/tegra.h
 create mode 100644 include/linux/mmc/blkdev.h
 create mode 100644 include/soc/tegra/bootdata.h
 create mode 100644 include/soc/tegra/partition.h

-- 
2.25.1


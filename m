Return-Path: <SRS0=9TSA=4M=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E4E9C34056
	for <linux-block@archiver.kernel.org>; Mon, 24 Feb 2020 23:22:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 372A322464
	for <linux-block@archiver.kernel.org>; Mon, 24 Feb 2020 23:22:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LBIgL2R1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728581AbgBXXWN (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 24 Feb 2020 18:22:13 -0500
Received: from mail-lj1-f196.google.com ([209.85.208.196]:34447 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728269AbgBXXWN (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 24 Feb 2020 18:22:13 -0500
Received: by mail-lj1-f196.google.com with SMTP id x7so12010378ljc.1;
        Mon, 24 Feb 2020 15:22:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=zapvrSfkAB3Uioa0nez7vq8hKDYWAUjvXWTGHeYzWos=;
        b=LBIgL2R1SmP7LAGLEx/TpjHkceKP+P5sl9nZPJ1hyTlDFlMVMehRZ6uaqa+TmbNivl
         faAZ7A4q4sjwQCEyeZ9hJ/CvLphRdl5um0VN8X5bgUKsyc9F/ObUKhLmiWf5Q4tDJKzA
         bDfgQmQtHNWU7CkdR2DYcddL8JvY18DthXp4V0ZjlqGewVd6CTgko6T9FVyF2K4aWs4L
         xUOwjQnG7Dk8f8UNVz+n+d6LjH4R+kLPxipZum7HQwCjUAQIoHq+pp7+lByDPDinoxXv
         ggEw+ESzTgAwIDbRlh2KpoQ+/avsXQ1LWmGn0C0+m2uT4LdPgEGuIUXtYpM+tGQ27rwi
         Kd7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=zapvrSfkAB3Uioa0nez7vq8hKDYWAUjvXWTGHeYzWos=;
        b=POx4EAh/Ir1mibZFKohq8D55HPE0RABKqYXRzFYOD+qGwZLFPITuh+wMFP1cHR/wDF
         WWADpCscaaXCThw/xGXMWoYXt9/KHeqgGcXavW7QJk92MJk8iqLaGfSsp24QGhcQ/3/I
         zw4mvXt7uWOW3pLfW7TTBc/XvlfSUPqH+0wxP+ee9nwykykWVKF5J1Trhapqo+DG7HFf
         06BOO/kpmaVv8LC2l+J7hpQ140BUACOkASUO5X+DDryUNhmwsMx9mVF+0s/RRQg1xph8
         DDjx4A06+1LiESzyTmNcWUpj/s2kNKQJuRwqPW2V8c4tvUBQNAXIq2WzQ7xQQV6VcapV
         HosQ==
X-Gm-Message-State: APjAAAXhtVutycekfAHiEAEXNah/rdMz8WWtegOG7ru4DTgAdhRU/mlG
        AsTCLpl4OHBGfnS46q/sM48=
X-Google-Smtp-Source: APXvYqy2AwxPlR5v2q81yED52jU8uKleIyr/LgSvP0EERemjAGpVSBC7rLykQwNndyW1YfTzcJkBnQ==
X-Received: by 2002:a2e:9d11:: with SMTP id t17mr32664047lji.169.1582586530637;
        Mon, 24 Feb 2020 15:22:10 -0800 (PST)
Received: from localhost.localdomain (79-139-233-37.dynamic.spd-mgts.ru. [79.139.233.37])
        by smtp.gmail.com with ESMTPSA id r10sm8154071ljk.9.2020.02.24.15.22.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Feb 2020 15:22:10 -0800 (PST)
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
Subject: [PATCH v1 0/3] Introduce NVIDIA Tegra Partition Table
Date:   Tue, 25 Feb 2020 02:18:38 +0300
Message-Id: <20200224231841.26550-1-digetx@gmail.com>
X-Mailer: git-send-email 2.24.0
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

Dmitry Osipenko (3):
  mmc: core: Add raw_boot_mult field to mmc_ext_csd
  mmc: block: Add mmc_bdev_to_card() helper
  partitions: Introduce NVIDIA Tegra Partition Table

 arch/arm/mach-tegra/tegra.c         |  35 +++
 block/partitions/Kconfig            |   8 +
 block/partitions/Makefile           |   1 +
 block/partitions/check.c            |   4 +
 block/partitions/tegra.c            | 373 ++++++++++++++++++++++++++++
 block/partitions/tegra.h            |  71 ++++++
 drivers/mmc/core/block.c            |  14 ++
 drivers/mmc/core/mmc.c              |   2 +
 include/linux/mmc/card.h            |   4 +
 include/soc/tegra/bct.h             |  42 ++++
 include/soc/tegra/common.h          |   9 +
 include/soc/tegra/partition_table.h |  18 ++
 12 files changed, 581 insertions(+)
 create mode 100644 block/partitions/tegra.c
 create mode 100644 block/partitions/tegra.h
 create mode 100644 include/soc/tegra/bct.h
 create mode 100644 include/soc/tegra/partition_table.h

-- 
2.24.0


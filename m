Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C10E0EB64D9
	for <linux-block@archiver.kernel.org>; Thu,  6 Jul 2023 13:09:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232482AbjGFNJk (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 6 Jul 2023 09:09:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232355AbjGFNJj (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 6 Jul 2023 09:09:39 -0400
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D68B1986
        for <linux-block@vger.kernel.org>; Thu,  6 Jul 2023 06:09:33 -0700 (PDT)
Received: by mail-wr1-x430.google.com with SMTP id ffacd0b85a97d-314417861b9so621963f8f.0
        for <linux-block@vger.kernel.org>; Thu, 06 Jul 2023 06:09:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=metaspace-dk.20221208.gappssmtp.com; s=20221208; t=1688648971; x=1691240971;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=6xf2zy9SLFZ9iN7Byux23bJEd9Lpq3RyBZGcMhtVspI=;
        b=A1l8N/Kl/5JB8PT6EXxWNq08Ew57NvY/IB0KVzGw33iF1PGvIEiZzLxCiG1R3jWo71
         Jh2uA27EGPOmNr1qTYH0ZCSPMIBPZQgFoGB13tfkxBkqnvjhFgm3H3mOcBLNLMQm5bdO
         sVZttMSzj3dsm4Hi+KRuSlTnCs9zMAilj6pJB41o73wv7ASyaWW1OMw35RulmOGwjU4P
         1snaBssfsiAh8x7/QWHvf60JCwfEe6QgWBqCZgdWBM5doMYfQ0/nYPq7WPkrVT+dQpnP
         uxJz/CXuz9bGVOI/uO4thS6rsnjTHDkhMGQFX5v2nI2V/Zsrqlx0JlQUOQrg0UgP00Jh
         h6kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688648971; x=1691240971;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6xf2zy9SLFZ9iN7Byux23bJEd9Lpq3RyBZGcMhtVspI=;
        b=DDAom2R31M1UoURWfcrIqN5jpe4Yg6HTlwx+CfSR9VkLFN+SCu2QzrH56cHGTDH+6r
         /TyxuSIR/9EmdoWpN9RYVJlGtCkLH0N0h5n9rYKOZYi8KyKXpQ+quQGuKWBtS9h6/HNg
         RvYYgcmLYU3YqMSBWiTgdky+hFvEmegCfPrSbyv2SzBiaFcQ+rjG5XPg5EMX75vf1lNh
         6PXS1ocN0mJIs5ALBWCX9fWXvZreKKTgRt2d58lGgCGsYetKkJmR7OtGkgzylk6y3U/b
         J1qNtCrqoIh404f3+tzBekGcZfjULDd6+nFHgidwtKBO87OsXKfccM0cXJ211dG2cOXK
         obaQ==
X-Gm-Message-State: ABy/qLa95NTqH/MTMind7oDn78mZKmnyKv8McE+eCjqMIZsydEZyw3+9
        zSSBDyY6m+qN0qGYmPp9DpbhkQ==
X-Google-Smtp-Source: APBJJlHFgAU9ZgB8BrMX9Bye4k/B27nilJOegkdXO+yaYaUsfw/lDwwtxfeNVAGFParvh2UJ3j7oAA==
X-Received: by 2002:a05:6000:1950:b0:314:a3f:9c17 with SMTP id e16-20020a056000195000b003140a3f9c17mr1480517wry.42.1688648971227;
        Thu, 06 Jul 2023 06:09:31 -0700 (PDT)
Received: from localhost ([147.161.155.79])
        by smtp.gmail.com with ESMTPSA id j7-20020a5d6187000000b00301a351a8d6sm1824687wru.84.2023.07.06.06.09.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Jul 2023 06:09:30 -0700 (PDT)
From:   Andreas Hindborg <nmi@metaspace.dk>
To:     Ming Lei <ming.lei@redhat.com>
Cc:     linux-kernel@vger.kernel.org (open list),
        linux-block@vger.kernel.org (open list:BLOCK LAYER),
        Andreas Hindborg <a.hindborg@samsung.com>,
        Minwoo Im <minwoo.im.dev@gmail.com>,
        Matias Bjorling <Matias.Bjorling@wdc.com>,
        gost.dev@samsung.com, Jens Axboe <axboe@kernel.dk>,
        Aravind Ramesh <Aravind.Ramesh@wdc.com>,
        Johannes Thumshirn <jth@kernel.org>,
        Hans Holmberg <Hans.Holmberg@wdc.com>,
        Christoph Hellwig <hch@infradead.org>,
        Damien Le Moal <dlemoal@kernel.org>
Subject: [PATCH v6 0/3] ublk: enable zoned storage support
Date:   Thu,  6 Jul 2023 15:09:27 +0200
Message-ID: <20230706130930.64283-1-nmi@metaspace.dk>
X-Mailer: git-send-email 2.41.0
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

From: Andreas Hindborg <a.hindborg@samsung.com>

Hi All,

This patch set adds zoned storage support to `ublk`. The first two patches do
some house cleaning in preparation for the last patch. The last patch adds
support for report_zones and the following operations:

 - REQ_OP_ZONE_OPEN
 - REQ_OP_ZONE_CLOSE
 - REQ_OP_ZONE_FINISH
 - REQ_OP_ZONE_RESET
 - REQ_OP_ZONE_APPEND

A user space component based on ubdsrv is available for testing [1] with the
"loop" target.

Read/write and zone operations are tested with zenfs [2].

The zone append path is tested with fio -> zonefs -> ublk -> null_blk.

The implementation of zone append requires ublk user copy feature, and therefore
the series is based on branch for-next (6afa337a3789) of [3].

Changes for v6:
 - Style fixes
 - Document __ULK_IO_OP_DRV_*
 - Remove "depends on BLK_DEV_UBLK && BLK_DEV_ZONED" from kconfig
 - Rework `get_nr_zones()`
 - Merge `ublk_disk_set_zoned()` and `ublk_dev_param_zoned_apply()`
 - Fix an exit condition bug in `ublk_report_zones()`
 - Only call `ublk_set_nr_zones()` if device is zoned
 - Change a config gate from BLK_DEV_ZONED to BLK_DEV_UBLK_ZONED
 - Simplify `ublk_alloc_report_buffer()`
 - Simplify `ublk_revalidate_disk_zones()`
 - Remove redundant parameter check from `ublk_dev_param_zoned_apply()`
 - Remove redundant zone size check from `ublk_set_nr_zones()`
 - Remove `ublk_zoned_commit_completion()` and open code instead
 - Do not add an extra translation unit (v5 added an extra C file)

[1] https://github.com/metaspace/ubdsrv/tree/1ac32cf841b07259cf8b075a5c0006803eeb3981
[2] https://github.com/westerndigitalcorporation/zenfs
[3] https://git.kernel.dk/linux.git

Andreas Hindborg (3):
  ublk: add opcode offsets for DRV_IN/DRV_OUT
  ublk: add helper to check if device supports user copy
  ublk: enable zoned storage support

 drivers/block/Kconfig         |   4 +
 drivers/block/ublk_drv.c      | 348 ++++++++++++++++++++++++++++++++--
 include/uapi/linux/ublk_cmd.h |  48 ++++-
 3 files changed, 383 insertions(+), 17 deletions(-)


base-commit: 3261ea42710e9665c9151006049411bd23b5411f
-- 
2.41.0


Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 107E5C0015E
	for <linux-block@archiver.kernel.org>; Wed, 28 Jun 2023 19:07:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231708AbjF1THL (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 28 Jun 2023 15:07:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232108AbjF1TG6 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 28 Jun 2023 15:06:58 -0400
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE4751BD4
        for <linux-block@vger.kernel.org>; Wed, 28 Jun 2023 12:06:53 -0700 (PDT)
Received: by mail-ej1-x632.google.com with SMTP id a640c23a62f3a-9891c73e0fbso42885566b.1
        for <linux-block@vger.kernel.org>; Wed, 28 Jun 2023 12:06:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=metaspace-dk.20221208.gappssmtp.com; s=20221208; t=1687979212; x=1690571212;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=tHp3wJL5M2L2G+YbB2Q2IPPSaeVG/zhpefUOIq4q2Os=;
        b=jDgSFPLYEQZXyfEfZwepmlvYqaf7ynGTJ/aFKkuF+COAMkmY5RIkoCJE95ml123D3X
         UqZWhOf4hphOdA7/m4fHFsFpUS/J/mSoH8ZBxH2RGgl53vhshBiaN7SuwAJRhfooVX/x
         WWNrTdXp1DqTl6AAr/hWDTEdkXv0ytzmp7ANidt/mJIlX4pEENnkZvzAmnA/QqEvu4gP
         uQoECeyhbrWd471Vo0z5ntYEPpMAkwabOLZz59o1I2Lu6FhlbxyEdnZDSCsOO7G1Z1O3
         FJ78dss+Xv1TrnD1mS8ISDOVB0TVcdv79MsmZPK0uFbMqe5mr3Xycd13426VHGsDgq2D
         Uq7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687979212; x=1690571212;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tHp3wJL5M2L2G+YbB2Q2IPPSaeVG/zhpefUOIq4q2Os=;
        b=kB1YIjdUNsuqFkBXYGeNecSUQrboRChu0Mqj5YkFcM8X7Wdxf73lHBrQ2ErN5Bz/Y9
         AsLEoDoF4NB1T4IrS0wvWCdx+MEWRTYxgw6MHl9mcGeXDe5UOsA/xxUCt4bE0ROt6fK0
         sBKzb7nv/pnK5Cb7TbZkZ7kfEnhq2KDksZmE95uHhg+59c4WGkLiM/hrcqTrHvPGD1D0
         HEgEzwIFPMIqAF/HixBtZrrRhIxcksrGiFaQUHMV2wQyrHSKbqUEq104XK6YsfqHfH+u
         yafPG0X4mlqGYu6bmUO3iBmTrJMlVtyesxL4JUbEoqKIe4Lo/e7cGK4bHE6DocgbY//V
         AaFA==
X-Gm-Message-State: AC+VfDzxFrKHGXPqNuZS33pbBxObeB8oBF51pDYHT+rGDgr8B875Jjyj
        02XMAIl315Y26U0U594Fui02+fRUCgZzAexBIlo=
X-Google-Smtp-Source: ACHHUZ7DXPXOc7rcX2RdtEk+UOMmjqKmTj+kwlNVuFuW4fXpjyLiii3gpj23e1r4UYEmXLFngtcUmA==
X-Received: by 2002:a17:907:60d5:b0:98d:f2c9:a1eb with SMTP id hv21-20020a17090760d500b0098df2c9a1ebmr2479087ejc.24.1687979212156;
        Wed, 28 Jun 2023 12:06:52 -0700 (PDT)
Received: from localhost ([79.142.230.34])
        by smtp.gmail.com with ESMTPSA id r16-20020aa7da10000000b0051d2968b26asm5072022eds.77.2023.06.28.12.06.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Jun 2023 12:06:51 -0700 (PDT)
From:   Andreas Hindborg <nmi@metaspace.dk>
To:     Ming Lei <ming.lei@redhat.com>
Cc:     Hans Holmberg <Hans.Holmberg@wdc.com>,
        Aravind Ramesh <Aravind.Ramesh@wdc.com>,
        Jens Axboe <axboe@kernel.dk>,
        linux-block@vger.kernel.org (open list:BLOCK LAYER),
        Christoph Hellwig <hch@infradead.org>,
        Matias Bjorling <Matias.Bjorling@wdc.com>,
        Andreas Hindborg <a.hindborg@samsung.com>,
        linux-kernel@vger.kernel.org (open list),
        Damien Le Moal <dlemoal@kernel.org>, gost.dev@samsung.com,
        Minwoo Im <minwoo.im.dev@gmail.com>
Subject: [PATCH v4 0/4] ublk: add zoned storage support
Date:   Wed, 28 Jun 2023 21:06:45 +0200
Message-ID: <20230628190649.11233-1-nmi@metaspace.dk>
X-Mailer: git-send-email 2.41.0
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

From: Andreas Hindborg <a.hindborg@samsung.com>

Hi All,

This patch set adds zoned storage support to `ublk`. The first two patches does
some house cleaning in preparation for the last two patches. The third patch
adds support for report_zones and the following operations:

 - REQ_OP_ZONE_OPEN
 - REQ_OP_ZONE_CLOSE
 - REQ_OP_ZONE_FINISH
 - REQ_OP_ZONE_RES

The last patch adds support for REQ_OP_ZONE_APPEND.

v3 [2] -> v4 changes:
 - Split up v3 patches
 - Add zone append support
 - Change order of variables in `ublk_report_zones`

Read/write and zone operations are tested with zenfs [3].

The zone append path is tested with fio -> zonefs -> ublk -> null_blk.

The implementation of zone append requires ublk user copy feature, and therefore
the series is based on branch for-next (6afa337a3789) of [4].

[1] https://github.com/metaspace/ubdsrv/commit/7de0d901c329fde7dc5a2e998952dd88bf5e668b
[2] https://lore.kernel.org/linux-block/20230316145539.300523-1-nmi@metaspace.dk/
[3] https://github.com/westerndigitalcorporation/zenfs
[4] https://git.kernel.dk/linux.git

Andreas Hindborg (4):
  ublk: change ublk IO command defines to enum
  ublk: move types to shared header file
  ublk: enable zoned storage support
  ublk: add zone append

 MAINTAINERS                    |   2 +
 drivers/block/Kconfig          |   4 +
 drivers/block/Makefile         |   4 +-
 drivers/block/ublk_drv-zoned.c | 155 +++++++++++++++++++++++++++++++++
 drivers/block/ublk_drv.c       | 150 +++++++++++++++++++------------
 drivers/block/ublk_drv.h       |  71 +++++++++++++++
 include/uapi/linux/ublk_cmd.h  |  38 ++++++--
 7 files changed, 363 insertions(+), 61 deletions(-)
 create mode 100644 drivers/block/ublk_drv-zoned.c
 create mode 100644 drivers/block/ublk_drv.h


base-commit: 3261ea42710e9665c9151006049411bd23b5411f
-- 
2.41.0


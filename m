Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB5E9FA373E
	for <linux-block@archiver.kernel.org>; Tue, 25 Oct 2022 19:18:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229781AbiJYTS1 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 25 Oct 2022 15:18:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232946AbiJYTSJ (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 25 Oct 2022 15:18:09 -0400
Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA622B7F61
        for <linux-block@vger.kernel.org>; Tue, 25 Oct 2022 12:18:04 -0700 (PDT)
Received: by mail-pj1-f46.google.com with SMTP id v4-20020a17090a088400b00212cb0ed97eso12774929pjc.5
        for <linux-block@vger.kernel.org>; Tue, 25 Oct 2022 12:18:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=EL1JYK0bUZJ89c8yrk5wkceIUOrhcWNtklo42o1wjCk=;
        b=6FaL3GAhptBiQaa0VsqvgXI/80lbsatuYeN/mnCN+Ca2wLSnuSYmgsHara39kcuZBm
         siLsH+dmEad1H6pbf+dZ7N85aQAenUYGPSiRv/rCR/eY2GY7RrlMP70/+uIp1ttj70VU
         dKFjCBuLBJKzjBwaJYqLvadXURrwaFYdHPlc4JhhYmeZln6IAs0h+AK+bqco+4VRmUCF
         X452RCi2/IdE20y57H7j08KfTrXSpRTagYU0elCm9XDt2bUzs6Z7dhD74BQ3+ntMfJi3
         66iN9PUeZBjBsD4O11KCMKfecPMT3irPBt0oAghtird2m48DVAKKoM2n5mVoP041qiV3
         ZvXw==
X-Gm-Message-State: ACrzQf3+LkRDJ1JkxsIUXcL2Ru8GvbcHgX4AicYxWDvBBH0ZiIbktTs6
        EA0AsuSNLKVcqDAwwidW+UiutehSiAU=
X-Google-Smtp-Source: AMsMyM4AGnHD8y1dDeIG5gl6uXdFYsZ6bVU/97c0jtuSPDHHfGaaCHAFygdsOX77p4UFDdOS1qJExw==
X-Received: by 2002:a17:902:ef95:b0:186:8376:2084 with SMTP id iz21-20020a170902ef9500b0018683762084mr21455132plb.48.1666725484039;
        Tue, 25 Oct 2022 12:18:04 -0700 (PDT)
Received: from bvanassche-linux.mtv.corp.google.com ([2620:15c:211:201:58c7:bc96:4597:61cd])
        by smtp.gmail.com with ESMTPSA id b23-20020a170902d89700b00186a8beec78sm1540737plz.52.2022.10.25.12.18.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Oct 2022 12:18:03 -0700 (PDT)
From:   Bart Van Assche <bvanassche@acm.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Bart Van Assche <bvanassche@acm.org>
Subject: [PATCH 0/3] Block layer cleanup patches
Date:   Tue, 25 Oct 2022 12:17:52 -0700
Message-Id: <20221025191755.1711437-1-bvanassche@acm.org>
X-Mailer: git-send-email 2.38.0.135.g90850a2211-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi Jens,

There are two cleanup patches in this series and one small performance
improvement patch. Please consider these patches for the next merge window.

Changes compared to v1:
- Extracted these patches from a larger patch series.
- Added Mings' Reviewed-by.

Bart Van Assche (3):
  block: Remove request.write_hint
  block: Constify most queue limits pointers
  block: Micro-optimize get_max_segment_size()

 block/blk-map.c        |  2 +-
 block/blk-merge.c      | 44 ++++++++++++++++++++++++++----------------
 block/blk-settings.c   |  6 +++---
 block/blk.h            | 11 ++++++-----
 include/linux/blk-mq.h |  1 -
 5 files changed, 37 insertions(+), 27 deletions(-)


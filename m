Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4220CE7B10
	for <linux-block@archiver.kernel.org>; Thu, 28 Sep 2023 09:39:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231796AbjI1Jjb (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 28 Sep 2023 05:39:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231891AbjI1JjT (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 28 Sep 2023 05:39:19 -0400
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00742180
        for <linux-block@vger.kernel.org>; Thu, 28 Sep 2023 02:38:59 -0700 (PDT)
Received: by mail-wm1-x32e.google.com with SMTP id 5b1f17b1804b1-40535597f01so128189545e9.3
        for <linux-block@vger.kernel.org>; Thu, 28 Sep 2023 02:38:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linbit-com.20230601.gappssmtp.com; s=20230601; t=1695893938; x=1696498738; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=9DgaQdL1mkt6AjgMQAIJbcwnwZB2QgHQP1PAcp2gZrY=;
        b=Al2ZTuBpmCd0Jaq48qpIzRb37H2hz0AxyMzIATjaa8+jqb2oxsi+JfGdSTPsLE4BTJ
         e1kDXgjQXCPS9WzHBu2d33MkbqBZTtp2Gmp52lOGPk9tCfd3mUsguqZXBlwqI5MIvdca
         FATkG1y2lixypu+HHlzF07oFOOqy/ObrZKeF/L0BuHMYf0dwQr62gpCeDFp927LrSQsE
         7vLIn8yKBkWztoiUV2Ccj7qNYCnwvjkAPGViTFw9opuhujcE5flwmZg9Znp5p2utFO6P
         2wnAKLOdSgK4uph2NHtwb3ZixYUT/dt11oJkiyPsxMRUz77UWH/ykTzP34jAif81q/FB
         EfvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695893938; x=1696498738;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9DgaQdL1mkt6AjgMQAIJbcwnwZB2QgHQP1PAcp2gZrY=;
        b=BMdVvglAKfXlG67db8E+4xdabqITf0VfPACRa74b2VTeC6zZqzJXxQk3jP6AwFVzlq
         Zvz8kVsUjXd59oTmyLWHIDpOXPXQ0Tbar1AVVsfsIKEdDBLd70L1D+ypoYbygPvR0fMD
         6NDO825cfOxM2Qj5ka7j4o69cuwFvTTuuMlXMIeIaJpC+aAIuYZvK8HZq3jsEglJuMrJ
         tp8x8go41TSWRrr6dNWVS3o54kOYXYzO70k2O9vgoQurRSRk6OcspZLLxqohNi0K+xQc
         U3ZixeCP4Su99hvkXpTYUClHG7khB8NoZJH8pHU5mr1YFe9tnXKVEEz2ogkb1ozbmeS8
         YmvQ==
X-Gm-Message-State: AOJu0YycWF0bML+dBgDIhDsl70h4PztecF2G7e+jSvEwxN5SOY3X1kSE
        XM2xIv7TqguTaxFfkR70D87Mhg==
X-Google-Smtp-Source: AGHT+IFoFu//qWf+2YKVQsH9YQI2JLonYDwjIcCmCaPKPhTJZjW9JQmcHydqb1bvOIeqR+dHCuqbtQ==
X-Received: by 2002:adf:e78d:0:b0:317:ef76:b778 with SMTP id n13-20020adfe78d000000b00317ef76b778mr801971wrm.63.1695893938243;
        Thu, 28 Sep 2023 02:38:58 -0700 (PDT)
Received: from localhost.localdomain (213-225-13-130.nat.highway.a1.net. [213.225.13.130])
        by smtp.gmail.com with ESMTPSA id f4-20020a5d50c4000000b0031fa870d4b3sm18931449wrt.60.2023.09.28.02.38.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Sep 2023 02:38:57 -0700 (PDT)
From:   =?UTF-8?q?Christoph=20B=C3=B6hmwalder?= 
        <christoph.boehmwalder@linbit.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Philipp Reisner <philipp.reisner@linbit.com>,
        Lars Ellenberg <lars@linbit.com>, drbd-dev@lists.linbit.com,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        Christoph Hellwig <hch@lst.de>,
        Joel Colledge <joel.colledge@linbit.com>,
        =?UTF-8?q?Christoph=20B=C3=B6hmwalder?= 
        <christoph.boehmwalder@linbit.com>
Subject: [PATCH 0/5] drbd: rename worker to sender
Date:   Thu, 28 Sep 2023 11:38:47 +0200
Message-ID: <20230928093852.676786-1-christoph.boehmwalder@linbit.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Some more refactoring commits from out-of-tree drbd.
Intended for 6.7.

Christoph Böhmwalder (5):
  drbd: Rename per-connection "worker" thread to "sender"
  drbd: Add new per-resource "worker" thread
  drbd: Move connection independent work from "sender" to "worker"
  drbd: Keep connection threads running while connection is up only
  drbd: Get rid of conn_reconfig_start() and conn_reconfig_done()

 drivers/block/drbd/Makefile                   |  2 +-
 drivers/block/drbd/drbd_int.h                 | 12 ++--
 drivers/block/drbd/drbd_main.c                | 21 +++---
 drivers/block/drbd/drbd_nl.c                  | 48 +++-----------
 drivers/block/drbd/drbd_receiver.c            |  2 +-
 drivers/block/drbd/drbd_req.c                 |  7 +-
 .../drbd/{drbd_worker.c => drbd_sender.c}     | 64 ++++++++++++++++---
 drivers/block/drbd/drbd_state.c               | 31 ++-------
 drivers/block/drbd/drbd_state.h               |  1 -
 9 files changed, 95 insertions(+), 93 deletions(-)
 rename drivers/block/drbd/{drbd_worker.c => drbd_sender.c} (97%)


base-commit: aa511ff8218b3fb328181fbaac48aa5e9c5c6d93
-- 
2.41.0


Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8B3CC4332F
	for <linux-block@archiver.kernel.org>; Tue, 22 Nov 2022 13:43:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229481AbiKVNnN (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 22 Nov 2022 08:43:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232384AbiKVNnM (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 22 Nov 2022 08:43:12 -0500
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B08E127FE5
        for <linux-block@vger.kernel.org>; Tue, 22 Nov 2022 05:43:10 -0800 (PST)
Received: by mail-wr1-x42c.google.com with SMTP id d1so12656953wrs.12
        for <linux-block@vger.kernel.org>; Tue, 22 Nov 2022 05:43:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linbit-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=aKWA+AP/j4No4bfih7dsLGLYEDSONTbhMU2EZnn42zY=;
        b=yXqcBlksNnAzv0JPWlfp4srNfOhY8LdfdyUH6IMUrCMEgBmllXo1rkX45wgp8bEyPn
         o8ZDOeQQWwfFcchSgMN2v/yoREFBb5mk5cZKlSvgr9G2bHzEJPK2C2Shly8AlYNQzPIZ
         tGFZxm+Hr6bZzvic10oX82/fbGRTgUiLr8j2zz9tOxRkl+n/T2TVumlxlbXW9IcDT9+y
         m/Q7WWyJlkk6fpEHUeJUH6ixlNsCx8eCN2LaSbFmUnW455OcLSLiBSLit2flL0IzhgUr
         jZfeYc2AmokRQ6JFxZWYiu46OczuCtDIIQ9DWeS7ZZET2H8ZVybDb4vdLbQjiHa9jNKY
         Pciw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=aKWA+AP/j4No4bfih7dsLGLYEDSONTbhMU2EZnn42zY=;
        b=pnUkikUHi2nAWJlIIQmdmv2zLkI4aIL+WKaKhQNUcmCqyv6TAg5r4sdrmRSN2hsfpa
         nEVERcE2GPkZbwAwJa4nBwUcSaDQtl2PcP/DRdTYMHdLQiQEa8wPoLl1XJFNIhtyNFbu
         +a5ATMwRakk06j3WBQ9RTak6lSnVVQVCNJWt28uWNAqaxbqgf3UZeAgzpnBN07jinMfo
         75vq9FFIP1144x9w2cOempJPmK60+UeAzFmXCdUsftzNBILmlPRRlXP8KK61N/7a7KBg
         BStRgTNioPXN8tWRPKbqjO/mN05I4oFiXlUYkZcedWf8IgP9rBFu17ONN7fbMIB93j37
         Y+pQ==
X-Gm-Message-State: ANoB5pl3hTy55M9YehASEJ2PHseAenh8wRAlZVudpYD8w6EACj+BQOZY
        dM0YH61Tk+RJkQaw+o9nLjnWgg==
X-Google-Smtp-Source: AA0mqf4wL76N4ZHZjvU2VZRB4kqJFOiavA4tPlcNIaqg/Z8JbxDOHK1GZZE8Q6cTqcXM4fihVgKIeQ==
X-Received: by 2002:a05:6000:1148:b0:236:71cd:1a71 with SMTP id d8-20020a056000114800b0023671cd1a71mr14335072wrx.712.1669124589239;
        Tue, 22 Nov 2022 05:43:09 -0800 (PST)
Received: from localhost.localdomain (h082218028181.host.wavenet.at. [82.218.28.181])
        by smtp.gmail.com with ESMTPSA id p6-20020a1c5446000000b003b47e75b401sm21437729wmi.37.2022.11.22.05.43.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Nov 2022 05:43:08 -0800 (PST)
From:   =?UTF-8?q?Christoph=20B=C3=B6hmwalder?= 
        <christoph.boehmwalder@linbit.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     drbd-dev@lists.linbit.com, linux-kernel@vger.kernel.org,
        Lars Ellenberg <lars.ellenberg@linbit.com>,
        Philipp Reisner <philipp.reisner@linbit.com>,
        linux-block@vger.kernel.org,
        =?UTF-8?q?Christoph=20B=C3=B6hmwalder?= 
        <christoph.boehmwalder@linbit.com>
Subject: [PATCH 0/4] lru_cache improvements, DRBD license identifiers
Date:   Tue, 22 Nov 2022 14:42:57 +0100
Message-Id: <20221122134301.69258-1-christoph.boehmwalder@linbit.com>
X-Mailer: git-send-email 2.38.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Here are some improvements to the lru_cache; mostly just cleanups that
we missed to send upstream over the years.

The last patch makes the SPDX license headers in DRBD consistent so
that they all represent GPL 2.0.

Christoph Böhmwalder (2):
  lru_cache: remove compiled out code
  drbd: use consistent license

Joel Colledge (1):
  lru_cache: remove unused lc_private, lc_set, lc_index_of

Lars Ellenberg (1):
  lru_cache: use atomic operations when accessing lc->flags, always

 drivers/block/drbd/Kconfig             |  2 +-
 drivers/block/drbd/Makefile            |  2 +-
 drivers/block/drbd/drbd_actlog.c       |  2 +-
 drivers/block/drbd/drbd_bitmap.c       |  2 +-
 drivers/block/drbd/drbd_debugfs.c      |  2 +-
 drivers/block/drbd/drbd_debugfs.h      |  2 +-
 drivers/block/drbd/drbd_int.h          |  2 +-
 drivers/block/drbd/drbd_interval.c     |  2 +-
 drivers/block/drbd/drbd_interval.h     |  2 +-
 drivers/block/drbd/drbd_main.c         |  2 +-
 drivers/block/drbd/drbd_nl.c           |  2 +-
 drivers/block/drbd/drbd_nla.c          |  2 +-
 drivers/block/drbd/drbd_nla.h          |  2 +-
 drivers/block/drbd/drbd_proc.c         |  2 +-
 drivers/block/drbd/drbd_protocol.h     |  2 +-
 drivers/block/drbd/drbd_receiver.c     |  2 +-
 drivers/block/drbd/drbd_req.c          |  2 +-
 drivers/block/drbd/drbd_req.h          |  2 +-
 drivers/block/drbd/drbd_state.c        |  2 +-
 drivers/block/drbd/drbd_state.h        |  2 +-
 drivers/block/drbd/drbd_state_change.h |  2 +-
 drivers/block/drbd/drbd_strings.c      |  2 +-
 drivers/block/drbd/drbd_strings.h      |  2 +-
 drivers/block/drbd/drbd_vli.h          |  2 +-
 drivers/block/drbd/drbd_worker.c       |  2 +-
 include/linux/lru_cache.h              |  3 --
 lib/lru_cache.c                        | 59 +-------------------------
 27 files changed, 27 insertions(+), 85 deletions(-)

-- 
2.38.1


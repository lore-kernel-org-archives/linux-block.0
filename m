Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA61FC47088
	for <linux-block@archiver.kernel.org>; Thu,  1 Dec 2022 11:05:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231276AbiLALFk (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 1 Dec 2022 06:05:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230503AbiLALEa (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 1 Dec 2022 06:04:30 -0500
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F7967616B
        for <linux-block@vger.kernel.org>; Thu,  1 Dec 2022 03:04:28 -0800 (PST)
Received: by mail-ej1-x629.google.com with SMTP id vv4so3345727ejc.2
        for <linux-block@vger.kernel.org>; Thu, 01 Dec 2022 03:04:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linbit-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=bCSFONotMGlT5jcNSWA3wEw//+37lRPpQvu379eQdb4=;
        b=mky/H4kqev/SBa6soq1k+oMgOaV2tJ6fff0Qn4zByh6t4++4mdmoeRtyyf3dT0AGXh
         8qcdBXx/eU+yX2ubXovz++PON5OelriwP9No7rBn8afMyyq4glmQiIX/S4k8FEotVKNa
         tm5Ta4VNNWwL2Di8riPg+0yKi3AJntfpfgWvpOprnbKahJ/NZpIqhIm20ggN6r0EuxmC
         c0uM8xGx2bd7ZsNkzMYTihZTjhxs6FHLbzuzIFza+54tb64iXc/1ks7O2IfHtQ6zedtz
         bjZcNpxzIuMAiGBZ/+cNhUThlzgMlYueD6SJic/P2fmG9VN7zurkQCVwTEoN4AZ87+gY
         SvGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bCSFONotMGlT5jcNSWA3wEw//+37lRPpQvu379eQdb4=;
        b=Ehs5FEL6/plmFzlWRJ3BHtM17/vXV7JXf2I3txyQddih2oVw7gpbHOyLm4OLDybxXx
         4gpe0z9KWubq8V8WT2BzgwMpXO3cb5zIfgSh5Ls2GZMynDIl5nCB6DRFTF9wCGXT0mdZ
         hAgIT+AaM/4jGtP4aTCnFQiBiteF7swDQRVHYT7Ms8PSuybe1dQLOdwUc8uXW613y6QI
         asJjx2XvtTUpz5g3g4q1jBToCAiQkdhA6JQBcTRiWc6523tQkhfkvsM3Evmsy672Sx5z
         z1ziPZLEhZGTqIrpSYNLTgdkxNUGzL/Dj22y+urEYrUIDUUhFIDdsTPl624ryby6NshT
         KOEA==
X-Gm-Message-State: ANoB5pl/4HZM+sKYb6DfGuT8c6Rr0ubfcuWY0FnEe/auV9SKGOtg7low
        8BrBI3IX12bbQtEenLHud19y9yfi2QsR4Q==
X-Google-Smtp-Source: AA0mqf5D3lvSWXlbNVxaPnrYe5tMWRFbul2ScpxDzKf3ljJWGch6rkuPwy1XuKM1ffPLdoJA/bIXmA==
X-Received: by 2002:a17:906:a198:b0:7b4:bc42:3b44 with SMTP id s24-20020a170906a19800b007b4bc423b44mr48503029ejy.101.1669892666946;
        Thu, 01 Dec 2022 03:04:26 -0800 (PST)
Received: from localhost.localdomain (h082218028181.host.wavenet.at. [82.218.28.181])
        by smtp.gmail.com with ESMTPSA id f26-20020a056402161a00b00463a83ce063sm1576424edv.96.2022.12.01.03.04.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Dec 2022 03:04:26 -0800 (PST)
From:   =?UTF-8?q?Christoph=20B=C3=B6hmwalder?= 
        <christoph.boehmwalder@linbit.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     drbd-dev@lists.linbit.com, linux-kernel@vger.kernel.org,
        Lars Ellenberg <lars.ellenberg@linbit.com>,
        Philipp Reisner <philipp.reisner@linbit.com>,
        linux-block@vger.kernel.org,
        =?UTF-8?q?Christoph=20B=C3=B6hmwalder?= 
        <christoph.boehmwalder@linbit.com>
Subject: [PATCH 0/5] Backported DRBD printk/debug improvements
Date:   Thu,  1 Dec 2022 12:03:45 +0100
Message-Id: <20221201110349.1282687-1-christoph.boehmwalder@linbit.com>
X-Mailer: git-send-email 2.38.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Some changes to DRBD's logging infrastructure, backported from the
out-of-tree module.

Since the two code bases have diverged so much, it is tough to preserve
authorship information without "putting words into someone's mouth". So
I ended up using Originally-from tags to try and encode the original
authors of these patches.

Christoph Böhmwalder (5):
  drbd: unify how failed assertions are logged
  drbd: split polymorph printk to its own file
  drbd: introduce dynamic debug
  drbd: introduce drbd_ratelimit()
  drbd: add context parameter to expect() macro

 drivers/block/drbd/drbd_actlog.c           |   6 +-
 drivers/block/drbd/drbd_bitmap.c           |  60 ++++-----
 drivers/block/drbd/drbd_int.h              |  68 +---------
 drivers/block/drbd/drbd_main.c             |  10 +-
 drivers/block/drbd/drbd_nl.c               |   2 +-
 drivers/block/drbd/drbd_polymorph_printk.h | 141 +++++++++++++++++++++
 drivers/block/drbd/drbd_receiver.c         |  16 +--
 drivers/block/drbd/drbd_req.c              |   6 +-
 drivers/block/drbd/drbd_worker.c           |  12 +-
 9 files changed, 199 insertions(+), 122 deletions(-)
 create mode 100644 drivers/block/drbd/drbd_polymorph_printk.h


base-commit: b4c0482bfe89cd6c4f030314c86aae35642c44a5
-- 
2.38.1


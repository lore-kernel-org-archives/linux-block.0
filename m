Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D82FC433DB
	for <linux-block@archiver.kernel.org>; Fri,  8 Jan 2021 14:37:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4E99723884
	for <linux-block@archiver.kernel.org>; Fri,  8 Jan 2021 14:37:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726793AbhAHOhR (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 8 Jan 2021 09:37:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726205AbhAHOhR (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Fri, 8 Jan 2021 09:37:17 -0500
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23FB2C061380
        for <linux-block@vger.kernel.org>; Fri,  8 Jan 2021 06:36:37 -0800 (PST)
Received: by mail-ej1-x62c.google.com with SMTP id jx16so14736306ejb.10
        for <linux-block@vger.kernel.org>; Fri, 08 Jan 2021 06:36:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloud.ionos.com; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Pm5G4UBbUn7FHgxTeTGPmWEr3MDt1F2aF2bmh1nL7OI=;
        b=T41crgfe3Qvqr6AOGx5qcKCy7u5T0H235xNgMvGMJ5nEbtNHzXC/SnfOof2t+G7qb+
         GreTu2+zrV8u/w1QiMLDoGq5sjLDy0v0rPhiglgC0j+ZLD+uwP/BPc6XQIheNQggmxyZ
         90SF/K407akeytGVmX6jEClRGtXbyhVZS2pvG2A4ZiLjecyEoTbN2IIwXx4h7h5T/Dk7
         WFQqfHnKaLjWa0JA6zikj67ZuWBuVJpKe+dqhMMpVf5kugrK8jGtK4ahxwCxb1sta+KD
         q3OOhEfJy1em1UmM8p431oxopku75l/g4n3qTj+HqGAnKJySt1yvKiICYGQAhe290qY4
         XaIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Pm5G4UBbUn7FHgxTeTGPmWEr3MDt1F2aF2bmh1nL7OI=;
        b=qBreczCuSuxS0TfCFhrLSV0DgmpiPoEi0/Nno2k8CAHx4qOBMUooO3jmrXGh8Ssr9v
         tYUXlE/VydBc8btYXd7TyLxGiojcayHDOhEWVwxN8ifDbR2qbq66TJSc84r1XPImwCVl
         idIun+Q+IFdQInzpMI91m3nzbtmeQKSQv6HODAmy56obul6OL4x4coVNNP4pxe2xnobX
         Km7537daI1RAa1gm/Nb83bmgeUtk8KhHBl2ng3ipv1iPxE8k/DVx87xKJ9genAm5KAFo
         I8Ds6+xdrdT88fHw86nbR+H7l7h7nm7GH/sPkOvq6b1K62jI0qVQ/PKyMr8dzO9X5awV
         bhmQ==
X-Gm-Message-State: AOAM533IdFqQ0gTsor6ZA5rnwhAMH3CUkEzuuXiKTqvFinywmzutcPrh
        pNvu8YfLexnRRIJqVtpwZDvnvJGGxn8YQQ==
X-Google-Smtp-Source: ABdhPJw9LFbwjkUPBWS0iDCebpeda+vH/7rEpJZspVx3MfF1lNSjDdFjWIfKWB9AAI31ZueZAB6dTw==
X-Received: by 2002:a17:906:4c55:: with SMTP id d21mr2861816ejw.116.1610116595669;
        Fri, 08 Jan 2021 06:36:35 -0800 (PST)
Received: from jwang-Latitude-5491.fkb.profitbricks.net ([2001:16b8:4906:c200:31ac:50df:cd1f:f7fc])
        by smtp.gmail.com with ESMTPSA id e25sm3858698edq.24.2021.01.08.06.36.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Jan 2021 06:36:35 -0800 (PST)
From:   Jack Wang <jinpu.wang@cloud.ionos.com>
To:     linux-block@vger.kernel.org
Cc:     axboe@kernel.dk, hch@infradead.org, sagi@grimberg.me,
        bvanassche@acm.org, danil.kipnis@cloud.ionos.com
Subject: [PATCH for-rc 0/5] some bugfix for rnbd
Date:   Fri,  8 Jan 2021 15:36:29 +0100
Message-Id: <20210108143634.175394-1-jinpu.wang@cloud.ionos.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi Jens,

Please consider to inlcude follow bugfix for rc:
- fix one compile error reported by ltp (me)
- fix UAF for sg table (guoqing)
- fix UAF in rnbd_srv_sess_dev_force_close (me)
- fix module unload race with close callback. (me)
- credit for Swapnil's contribution (swapnil).

Thanks!
Jack


Guoqing Jiang (1):
  block/rnbd-clt: Fix sg table use after free

Jack Wang (3):
  block/rnbd: Select SG_POOL for RNBD_CLIENT
  block/rnbd-srv: Fix use after free in rnbd_srv_sess_dev_force_close
  block/rnbd-clt: avoid module unload race with close confirmation

Swapnil Ingle (1):
  block/rnbd: Adding name to the Contributors List

 drivers/block/rnbd/Kconfig    |  1 +
 drivers/block/rnbd/README     |  1 +
 drivers/block/rnbd/rnbd-clt.c | 18 +++++++++---------
 drivers/block/rnbd/rnbd-srv.c |  8 +++++---
 4 files changed, 16 insertions(+), 12 deletions(-)

-- 
2.25.1


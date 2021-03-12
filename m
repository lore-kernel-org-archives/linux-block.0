Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CDDF4C4332E
	for <linux-block@archiver.kernel.org>; Fri, 12 Mar 2021 10:56:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AE98265017
	for <linux-block@archiver.kernel.org>; Fri, 12 Mar 2021 10:56:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233641AbhCLKz5 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 12 Mar 2021 05:55:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233653AbhCLKzg (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 12 Mar 2021 05:55:36 -0500
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0456C061761
        for <linux-block@vger.kernel.org>; Fri, 12 Mar 2021 02:55:35 -0800 (PST)
Received: by mail-wm1-x32b.google.com with SMTP id m20-20020a7bcb940000b029010cab7e5a9fso15505425wmi.3
        for <linux-block@vger.kernel.org>; Fri, 12 Mar 2021 02:55:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=U8krqYE8Ef8qnGsiAipJzGQpaVm5t8lDtkhTxaSOQf8=;
        b=yo+0Pv1vGiiRr+BRTMkp3T9EiYl7WyqiXEjQPicDPEauSFiYyR62sktJewMDa8dedY
         TtEdyo/qjJQ2oVaYRSQ7M53MZM7dmCSqleG5phx9kfrPM/3iQZKaUrptoZGtnKshKPhT
         k8vBK+orZOsk37DTLhw4a5zMwn0ZRe0W0KpUJE4c2vUJnFGNzRTKNOrfj7BUVsMiySCS
         KpG8zUZke0l4urksnmr+8FXqKdvK/LQQp9twKzZeG5Anzi66F3YJXeBbnAbLfyEs9Mdm
         33HdF8a5+NO+J+PGn7XcVBn02oWNoEAEpdVHkH2yt2jK9lzPK6A0zywtAJ78xDs41uwS
         Okkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=U8krqYE8Ef8qnGsiAipJzGQpaVm5t8lDtkhTxaSOQf8=;
        b=h9k8CStWM/oF4YEgTbHY944qGQvfdmMLG0AG1CqvgNpum1i1dYRv0qEK2ULGjb6S1Q
         6G9wW2oYDz3EHfSsXFCLO3uiymqqDaXRoywjNd4kCWsZiljdo5d8xeCRvdP2zluC50PD
         b17mColBzLIVZAmVUBSMfsv6piQuZCyhs1ldsMSH3Dc/3Vm78++71qF3HTtDlfSZ06LZ
         fnveWERM2SmAzYPbo4ixVi1v/scvcNzeqryEbXy06y8YYwAAV4w92UVFv5riaIF/1gev
         7aBTOMJG/kBzewBtnjFlHKgeX5zJABh03q8I/Ycn9FEvJQm0jgMzbLsktMY54HkKbp6/
         JqzA==
X-Gm-Message-State: AOAM531gDB4MiJv1Bx0LfzfJR2oSoWcsqVPTxRXmr3pZUx+FOY2TfkF9
        vMvp9RrOTFUXUhNLJ7whYZ/v6A==
X-Google-Smtp-Source: ABdhPJwGy2yiZng+8p42AiTsODzcXCoCU2A55jsurjv+Rkg7hZ8K/NGYGP3VtK/HkA0LP08aOZ4tBg==
X-Received: by 2002:a1c:7e16:: with SMTP id z22mr12397544wmc.74.1615546534304;
        Fri, 12 Mar 2021 02:55:34 -0800 (PST)
Received: from dell.default ([91.110.221.204])
        by smtp.gmail.com with ESMTPSA id q15sm7264962wrr.58.2021.03.12.02.55.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Mar 2021 02:55:33 -0800 (PST)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        drbd-dev@lists.linbit.com, Jens Axboe <axboe@kernel.dk>,
        Joshua Morris <josh.h.morris@us.ibm.com>,
        Juergen Gross <jgross@suse.com>,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        Lars Ellenberg <lars.ellenberg@linbit.com>,
        linux-block@vger.kernel.org,
        Philip Kelleher <pjk1939@linux.ibm.com>,
        Philipp Reisner <philipp.reisner@linbit.com>,
        =?UTF-8?q?Roger=20Pau=20Monn=C3=A9?= <roger.pau@citrix.com>,
        Stefano Stabellini <sstabellini@kernel.org>,
        xen-devel@lists.xenproject.org
Subject: [PATCH 00/11] Rid W=1 warnings from Block
Date:   Fri, 12 Mar 2021 10:55:19 +0000
Message-Id: <20210312105530.2219008-1-lee.jones@linaro.org>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

This set is part of a larger effort attempting to clean-up W=1
kernel builds, which are currently overwhelmingly riddled with
niggly little warnings.

Lee Jones (11):
  block: rsxx: core: Remove superfluous const qualifier
  block: drbd: drbd_interval: Demote some kernel-doc abuses and fix
    another header
  block: mtip32xx: mtip32xx: Mark debugging variable 'start' as
    __maybe_unused
  block: drbd: drbd_state: Fix some function documentation issues
  block: drbd: drbd_receiver: Demote non-conformant kernel-doc headers
  block: drbd: drbd_main: Remove duplicate field initialisation
  block: drbd: drbd_nl: Make conversion to 'enum drbd_ret_code' explicit
  block: drbd: drbd_main: Fix a bunch of function documentation
    discrepancies
  block: drbd: drbd_receiver: Demote less than half complete kernel-doc
    header
  block: xen-blkfront: Demote kernel-doc abuses
  block: drbd: drbd_nl: Demote half-complete kernel-doc headers

 drivers/block/drbd/drbd_interval.c |  8 +++++---
 drivers/block/drbd/drbd_main.c     | 30 +++++++++++++++---------------
 drivers/block/drbd/drbd_nl.c       | 17 ++++++++++-------
 drivers/block/drbd/drbd_receiver.c | 26 ++++++++++++--------------
 drivers/block/drbd/drbd_state.c    |  7 ++++---
 drivers/block/mtip32xx/mtip32xx.c  |  2 +-
 drivers/block/rsxx/core.c          |  2 +-
 drivers/block/xen-blkfront.c       |  6 +++---
 8 files changed, 51 insertions(+), 47 deletions(-)

Cc: Boris Ostrovsky <boris.ostrovsky@oracle.com>
Cc: drbd-dev@lists.linbit.com
Cc: Jens Axboe <axboe@kernel.dk>
Cc: Joshua Morris <josh.h.morris@us.ibm.com>
Cc: Juergen Gross <jgross@suse.com>
Cc: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
Cc: Lars Ellenberg <lars.ellenberg@linbit.com>
Cc: linux-block@vger.kernel.org
Cc: Philip Kelleher <pjk1939@linux.ibm.com>
Cc: Philipp Reisner <philipp.reisner@linbit.com>
Cc: "Roger Pau Monné" <roger.pau@citrix.com>
Cc: Stefano Stabellini <sstabellini@kernel.org>
Cc: xen-devel@lists.xenproject.org
-- 
2.27.0


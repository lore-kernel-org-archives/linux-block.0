Return-Path: <SRS0=Z/Mq=AG=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B382C433DF
	for <linux-block@archiver.kernel.org>; Thu, 25 Jun 2020 12:22:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 53C9F20707
	for <linux-block@archiver.kernel.org>; Thu, 25 Jun 2020 12:22:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=javigon-com.20150623.gappssmtp.com header.i=@javigon-com.20150623.gappssmtp.com header.b="m1E1SI7r"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404518AbgFYMWQ (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 25 Jun 2020 08:22:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404343AbgFYMWQ (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 25 Jun 2020 08:22:16 -0400
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA7EDC061573
        for <linux-block@vger.kernel.org>; Thu, 25 Jun 2020 05:22:15 -0700 (PDT)
Received: by mail-wr1-x442.google.com with SMTP id r12so5577977wrj.13
        for <linux-block@vger.kernel.org>; Thu, 25 Jun 2020 05:22:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=javigon-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=8c99i5kWRH0gixiwS76ATmLU2DFdFXCBI5Yt4Kd+2ic=;
        b=m1E1SI7rOXU1elJos5jwy58AkSTR2KRnV4QroC873xhs2NEsEhnE40nVwqUD8kea5F
         qjZi8Lqk4IwuJCYPngFAZMepwNc1V4xt6Ex7KEGwi4Wm8j8eWK1CnZAtanHv67+SUfsO
         OizSMPEGfP7NLlfn6WjCgOCTFvUqUrrCTBAnFfVIaGMPvHLrMYtxBkj6DZcMzvZANaS6
         T+vYJtzVIYHr8vT0KvYkEZhgEXyMLToerKImY+vdwUPteJA9FS7xNBarY4ckiXksbR6u
         JGt8I/U0IthGLzw5MI6i7KU+UCesocXo1RrLSkB/ToGWLp18wV9PLdcIWgMbzBvrQ2zg
         iH/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=8c99i5kWRH0gixiwS76ATmLU2DFdFXCBI5Yt4Kd+2ic=;
        b=Ys2Nj9T09AHSneM1QriW2rmNNpqI46hWgp2WR38GvE40VG64nvD/5NguNINTQPkNOo
         DLIQRiFveJvmQZWoKJmMpTARFQYQZrDw/NsAsMIjyliatGdp6UzyENKo+1JWivQ1alA/
         qNPxwskSmCKkz7ikwCo53CUXrxEeIAlT2mLRGysDS+Uv1xHPPxGFDdIYxEWposyaNR0/
         y69SIxyQ68JAeavFeEMzzAe2LaokDFY9mUXzACIVYYlfivIhQO7dOYx0YsOzIuk0gNJP
         ubJY65uOwo19Cb6mcK5hjR3P5skulYDW9sFJ6bdY2Tx4IPYEACfSoGplapNn7yeO206q
         as8A==
X-Gm-Message-State: AOAM531gqCtum/aWKerdbotnpmkRGEITUMqVIdUDZwY0TRXlOEw3KMQI
        xiPUaRW5EEeEOg9D6wU+VFCH2A==
X-Google-Smtp-Source: ABdhPJzkrMmz/kWb0Lg21iTqV4aU2Af1dmQ9dZ5s4hEkWzU8VLAKD2ZUqnL4hTTRaiMhZVhQAK0+zA==
X-Received: by 2002:a5d:4283:: with SMTP id k3mr30422914wrq.322.1593087734535;
        Thu, 25 Jun 2020 05:22:14 -0700 (PDT)
Received: from localhost.localdomain ([194.62.217.57])
        by smtp.gmail.com with ESMTPSA id f186sm11934307wmf.29.2020.06.25.05.22.13
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 25 Jun 2020 05:22:13 -0700 (PDT)
From:   =?UTF-8?q?Javier=20Gonz=C3=A1lez?= <javier@javigon.com>
To:     linux-nvme@lists.infradead.org
Cc:     linux-block@vger.kernel.org, hch@lst.de, kbusch@kernel.org,
        sagi@grimberg.me, axboe@kernel.dk,
        =?UTF-8?q?Javier=20Gonz=C3=A1lez?= <javier.gonz@samsung.com>
Subject: [PATCH 0/6] ZNS: Extra features for current patches
Date:   Thu, 25 Jun 2020 14:21:46 +0200
Message-Id: <20200625122152.17359-1-javier@javigon.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

From: Javier González <javier.gonz@samsung.com>

This patchset extends zoned device functionality on top of the existing
v3 ZNS patchset that Keith sent last week.

Patches 1-5 are zoned block interface and IOCTL additions to expose ZNS
values to user-space. One major change is the addition of a new zone
management IOCTL that allows to extend zone management commands with
flags. I recall a conversation in the mailing list from early this year
where a similar approach was proposed by Matias, but never made it
upstream. We extended the IOCTL here to align with the comments in that
thread. Here, we are happy to get sign-offs by anyone that contributed
to the thread - just comment here or on the patch.

Patch 6 is nvme-only and adds an extra check to the ZNS report code to
ensure consistency on the zone count.

The patches apply on top of Jens' block-5.8 + Keith's V3 ZNS patches.

Thanks,
Javier

Javier González (6):
  block: introduce IOCTL for zone mgmt
  block: add support for selecting all zones
  block: add support for zone offline transition
  block: introduce IOCTL to report dev properties
  block: add zone attr. to zone mgmt IOCTL struct
  nvme: Add consistency check for zone count

 block/blk-core.c              |   2 +
 block/blk-zoned.c             | 108 +++++++++++++++++++++++++++++++++-
 block/ioctl.c                 |   4 ++
 drivers/nvme/host/core.c      |   5 ++
 drivers/nvme/host/nvme.h      |  11 ++++
 drivers/nvme/host/zns.c       |  69 ++++++++++++++++++++++
 include/linux/blk_types.h     |   6 +-
 include/linux/blkdev.h        |  19 +++++-
 include/uapi/linux/blkzoned.h |  69 +++++++++++++++++++++-
 9 files changed, 289 insertions(+), 4 deletions(-)

-- 
2.17.1


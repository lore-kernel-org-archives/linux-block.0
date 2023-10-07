Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 275F6E9413D
	for <linux-block@archiver.kernel.org>; Sat,  7 Oct 2023 01:28:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233822AbjJGB21 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 6 Oct 2023 21:28:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234010AbjJGB20 (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Fri, 6 Oct 2023 21:28:26 -0400
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9CAD6C6
        for <linux-block@vger.kernel.org>; Fri,  6 Oct 2023 18:28:24 -0700 (PDT)
Received: by mail-pl1-x631.google.com with SMTP id d9443c01a7336-1c364fb8a4cso23154645ad.1
        for <linux-block@vger.kernel.org>; Fri, 06 Oct 2023 18:28:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1696642104; x=1697246904; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=sPAOchZ3lviZQWz7F/yVzJ/5u6K9fS7pELXL8VtCc9c=;
        b=BB+jwWHPZKoC+SFdcT4TIJ0MVh4GMwMAeh9vXdKr0exaDqj/uLEU5WfLtt/OytF56U
         cmIKL4nzncZ4Mlz/UWnu+96fR2gV33xPR1GhH+sCjipxEcrhIB2Qc1rkM505dMLdOif3
         90XFavyzJ35MiqABFI9ylzog9/FqQvDspR9GI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696642104; x=1697246904;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=sPAOchZ3lviZQWz7F/yVzJ/5u6K9fS7pELXL8VtCc9c=;
        b=vUhubHyk8Vqei9nrfOjvgTg4jb2sO6QQjvcwEm/xS/1xYaFKLd1ot/NvAloP5/VF+n
         JCOMnGlfDfX2u9+IxqNbWnNhaB3tqbMK+0NnvyAh1a6zgOD2hFhcUjzs6983lCgEEPkz
         S0gXmFjHYaLrS9PT3GYB2WCU1oZLdC9BuGHDtr7A68EkDJBcPxPzinpPIiDZ/cBxyb6G
         E/fBDJ4NhO+kmc9U/nXWDuRNbVhkAcz5/UkUwLm+8CvrndCcBhFaM/92r6aoBtSUPqHk
         FdTkCZSR8jZHMIxJwC/kj6r2nbEYwnAaEgbLQ9VUK0my9a2qwQTQRKjOdZkB9Gxj9TC5
         ZY4w==
X-Gm-Message-State: AOJu0Ywrflbb03Iz9QZPYLwc+E0pJU6yIbLUjlc4K4lP8Aqh+sdkH3FK
        pl0/uNoFEVkRccdHhXA5+tu33A==
X-Google-Smtp-Source: AGHT+IF35TNd+fTvsxdLu9WMjvVSs/iB8sRAO30572Xwc92tYnfHc95l4aq5f8nH5De0gpWJSaCjww==
X-Received: by 2002:a17:903:228f:b0:1c7:66a4:27ba with SMTP id b15-20020a170903228f00b001c766a427bamr11470478plh.48.1696642104031;
        Fri, 06 Oct 2023 18:28:24 -0700 (PDT)
Received: from localhost ([2620:15c:9d:2:138c:8976:eb4a:a91c])
        by smtp.gmail.com with UTF8SMTPSA id q13-20020a170902dacd00b001b8b2a6c4a4sm4575373plx.172.2023.10.06.18.28.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 06 Oct 2023 18:28:23 -0700 (PDT)
From:   Sarthak Kukreti <sarthakkukreti@chromium.org>
To:     dm-devel@redhat.com, linux-block@vger.kernel.org,
        linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Cc:     Jens Axboe <axboe@kernel.dk>, Alasdair Kergon <agk@redhat.com>,
        Mike Snitzer <snitzer@kernel.org>,
        Christoph Hellwig <hch@infradead.org>,
        Brian Foster <bfoster@redhat.com>,
        Theodore Ts'o <tytso@mit.edu>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        Bart Van Assche <bvanassche@google.com>,
        "Darrick J. Wong" <djwong@kernel.org>,
        Dave Chinner <david@fromorbit.com>,
        Sarthak Kukreti <sarthakkukreti@chromium.org>
Subject: [PATCH v8 0/5] Introduce provisioning primitives
Date:   Fri,  6 Oct 2023 18:28:12 -0700
Message-ID: <20231007012817.3052558-1-sarthakkukreti@chromium.org>
X-Mailer: git-send-email 2.42.0.609.gbb76f46606-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi,

This patch series is version 8 of the patch series to introduce
block-level provisioning mechanism (original [1]), which is useful for provisioning
space across thinly provisioned storage architectures (loop devices
backed by sparse files, dm-thin devices, virtio-blk). This series has
minimal changes over v7[2].

This patch series is rebased from the linux-dm/dm-6.5-provision-support [1] on to
(cac405a3bfa2 Merge tag 'for-6.6-rc3-tag'). In addition, there's an
additional patch to allow passing through an unshare intent via REQ_OP_PROVISION
(suggested by Darrick in [4]).

[1] Original: https://lore.kernel.org/lkml/20220915164826.1396245-1-sarthakkukreti@google.com/
[2] v7 (last series): https://lore.kernel.org/linux-fsdevel/20230518223326.18744-1-sarthakkukreti@chromium.org/
[3] linux-dm/dm-6.5-provision-suppport tree:
https://git.kernel.org/pub/scm/linux/kernel/git/device-mapper/linux-dm.git/log/?h=dm-6.5-provision-support
(with the last two WIP patches for dm-thinpool dropped as per discussion with
maintainers).
[4] https://lore.kernel.org/linux-fsdevel/20230522163710.GA11607@frogsfrogsfrogs/

Changes from v7:
- Drop dm-thinpool (will be independently developed with snapshot
  support) and dm-snapshot (will not be supported) from the series.
- (By snitzer@kernel.org) Fixes for block device provision limits.
- (Suggested by djwong@kernel.org) Add mechanism to pass unshare intent
  via REQ_OP_PROVISION

Sarthak Kukreti (5):
  block: Don't invalidate pagecache for invalid falloc modes
  block: Introduce provisioning primitives
  loop: Add support for provision requests
  dm: Add block provisioning support
  block: Pass unshare intent via REQ_OP_PROVISION

 block/blk-core.c              |  5 +++
 block/blk-lib.c               | 55 ++++++++++++++++++++++++++++++++
 block/blk-merge.c             | 18 +++++++++++
 block/blk-settings.c          | 19 +++++++++++
 block/blk-sysfs.c             |  9 ++++++
 block/bounce.c                |  1 +
 block/fops.c                  | 33 ++++++++++++++++----
 drivers/block/loop.c          | 59 ++++++++++++++++++++++++++++++++---
 drivers/md/dm-crypt.c         |  4 ++-
 drivers/md/dm-linear.c        |  1 +
 drivers/md/dm-table.c         | 23 ++++++++++++++
 drivers/md/dm.c               |  7 +++++
 include/linux/bio.h           |  6 ++--
 include/linux/blk_types.h     |  8 ++++-
 include/linux/blkdev.h        | 17 ++++++++++
 include/linux/device-mapper.h | 17 ++++++++++
 16 files changed, 268 insertions(+), 14 deletions(-)

-- 
2.42.0.609.gbb76f46606-goog


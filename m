Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-21.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CAA4FC433DB
	for <linux-block@archiver.kernel.org>; Thu, 14 Jan 2021 15:48:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A249923B2F
	for <linux-block@archiver.kernel.org>; Thu, 14 Jan 2021 15:48:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729270AbhANPsO (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 14 Jan 2021 10:48:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727838AbhANPsN (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 14 Jan 2021 10:48:13 -0500
Received: from mail-qt1-x84a.google.com (mail-qt1-x84a.google.com [IPv6:2607:f8b0:4864:20::84a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44C59C061786
        for <linux-block@vger.kernel.org>; Thu, 14 Jan 2021 07:47:30 -0800 (PST)
Received: by mail-qt1-x84a.google.com with SMTP id f7so4802754qtj.7
        for <linux-block@vger.kernel.org>; Thu, 14 Jan 2021 07:47:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:message-id:mime-version:subject:from:to:cc;
        bh=5NXNDqe7MXvdpWengIx084J62Z/5uct6QHv9WnTOiC0=;
        b=fnU41QL8FjTlIvZ8h+YEIbZKB+Nre70DwIV91u8LX0xhz1KG45DAdnXR6A1wl/k6eS
         mNZFRO2xCsXOEpNxLsFKezWHo0EUD8YjR29PWAGIa7HgnQen/VHAWZupQg0/Rj7iTzEf
         GMMN897tn9ESsmbk2MqirPHOoDknXuZQ6ONGgRXKMHtbhjFigkIrGmnYJWauGvnJjSzb
         5r7xM/WBQLigdamL3lXQUghCUEQ9svnjaSd+4F3Q9Jsw7sUCWTkJ8eTcfphQ9rGsTtlc
         eBSKYNr/Tg4V4b2yGjWKkpipqXCBDUwfAk2iu34fM+v4rbNbKy6kf7QwNl056JwqPJrV
         F0mQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:message-id:mime-version:subject:from
         :to:cc;
        bh=5NXNDqe7MXvdpWengIx084J62Z/5uct6QHv9WnTOiC0=;
        b=GxA97JZ0r0hklgNx9oUfUDOyzmg222haqBeNAmDO7EKxhAAkc14aPUwHnWqrqbcs05
         0PX/lwsw0yEvYnT1BnqUbk5nxT4wvlz9pzy2KLm0F15mojfw6TKlVU4+k4tTlL8qQHUW
         rUEb/afOhGKuUJeR/A7MbYZFv0Sysu7JllQBtVs0PHjThib6KfMMO8HJl59UT4UGlS6c
         cuZ95EF2y+l6rftlpvl+QDN3rwVuzD7JYdqmz+Bhym69VTx7qpnLYpQlurOq/61vlUH7
         5GuZu1LKHVcxZk/FhMrZYVgYu4fjfSvnMtT56gDBY1KqaP+l+BUP5FVx/rlbJuqshVHq
         mxjA==
X-Gm-Message-State: AOAM530/zchG669Pz4T7fxHewRK1A+/pGWtbNc8iJRAizyOCwSqE7MqY
        uGGFQ93Br6G2vrVIdi13IFkGHwgur28vJ3Qur3t75jse+pebGaAAODIZsKtSKvxcAW+u4twQbNa
        Mcy3VN84UuzMX6+YOhc0ObRd+3omnjgqLL4niyg1jwUhN0cykkOKiUldjYzcgTbVd4/ra
X-Google-Smtp-Source: ABdhPJxRsntOinMf1hVV94w7xh8qCNTQKApwrYpQO71UiuHimvMvtGNvATUjTAF5OC5kP4zwq2QjS+dZ7Nc=
Sender: "satyat via sendgmr" <satyat@satyaprateek.c.googlers.com>
X-Received: from satyaprateek.c.googlers.com ([fda3:e722:ac3:10:24:72f4:c0a8:1092])
 (user=satyat job=sendgmr) by 2002:a25:57c1:: with SMTP id l184mr10581932ybb.382.1610639249256;
 Thu, 14 Jan 2021 07:47:29 -0800 (PST)
Date:   Thu, 14 Jan 2021 15:47:16 +0000
Message-Id: <20210114154723.2495814-1-satyat@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.30.0.284.gd98b1dd5eaa7-goog
Subject: [PATCH 0/7] ensure bios aren't split in middle of crypto data unit
From:   Satya Tangirala <satyat@google.com>
To:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Jens Axboe <axboe@kernel.dk>, Eric Biggers <ebiggers@google.com>,
        Satya Tangirala <satyat@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

When a bio has an encryption context, its size must be aligned to its
crypto data unit size. A bio must not be split in the middle of a data
unit. Currently, bios are split at logical block boundaries, but a crypto
data unit size might be larger than the logical block size - e.g. a machine
could be using fscrypt (which uses 4K crypto data units) with an eMMC block
device with inline encryption hardware that has a logical block size of
512 bytes. So we need to support cases where the data unit size is larger
than the logical block size.

Patch 1 allows blk_bio_segment_split() in blk-merge.c to fail and return an
error code. This functionality is used by later patches in this series.
Patch 1 also updates all callers to handle/propagate any returned error.

Patch 2 introduces blk_crypto_bio_sectors_alignment() which returns the
required alignment for the number of sectors in any bio.

Patches 3, 4 and 5 update bounce.c, blk-crypto-fallback.c and blk-merge.c
respectively to respect blk_crypto_bio_sectors_alignment() when calling
bio_split(), so that any split bio's size has the required alignment.
Patch 5 (the patch updating blk-merge.c) updates blk_bio_segment_split() by
rounding down the number of sectors to the required alignment (aligned
sectors) just before the call to bio_split(). It may be the case that due
to the other restrictions on aligned sectors by blk_bio_segment_split(),
aligned sectors ends up being rounded down to 0. An error is returned in
that case, using the functionality introduced in Patch 1.

Since all callers to bio_split() should have been updated by the previous
patches, Patch 6 adds a WARN_ON() to bio_split() when sectors isn't aligned
to blk_crypto_bio_sectors_alignment().

As a result of the simplistic rounding down in Patch 5, it might also be
the case that nsegs in blk_bio_segment_split() is overestimated. Patch 7
calculates nsegs accurately, while being a lot more complicated than Patch
5. If the accuracy isn't really necessary, Patch 7 can be dropped
completely.

This patch series was tested by running android xfstests on the SDM630
chipset (which has eMMC inline encryption hardware with logical block size
512 bytes) with test_dummy_encryption with and without the 'inlinecrypt'
mount option.

Satya Tangirala (7):
  block: make blk_bio_segment_split() able to fail and return error
  block: blk-crypto: Introduce blk_crypto_bio_sectors_alignment()
  block: respect blk_crypto_bio_sectors_alignment() in bounce.c
  block: respect blk_crypto_bio_sectors_alignment() in
    blk-crypto-fallback
  block: respect blk_crypto_bio_sectors_alignment() in blk-merge
  block: add WARN() in bio_split() for sector alignment
  block: compute nsegs more accurately in blk_bio_segment_split()

 block/bio.c                   |   1 +
 block/blk-crypto-fallback.c   |   2 +
 block/blk-crypto-internal.h   |  18 +++++
 block/blk-merge.c             | 132 +++++++++++++++++++++++++++-------
 block/blk-mq.c                |   5 +-
 block/blk.h                   |   2 +-
 block/bounce.c                |   3 +
 drivers/block/drbd/drbd_req.c |   5 +-
 drivers/block/pktcdvd.c       |   3 +-
 drivers/block/ps3vram.c       |   5 +-
 drivers/block/rsxx/dev.c      |   3 +-
 drivers/block/umem.c          |   5 +-
 drivers/lightnvm/pblk-init.c  |  13 +++-
 drivers/md/dm.c               |   8 ++-
 drivers/md/md.c               |   5 +-
 drivers/nvme/host/multipath.c |   5 +-
 drivers/s390/block/dcssblk.c  |   3 +-
 drivers/s390/block/xpram.c    |   3 +-
 include/linux/blkdev.h        |   2 +-
 19 files changed, 182 insertions(+), 41 deletions(-)

-- 
2.30.0.284.gd98b1dd5eaa7-goog


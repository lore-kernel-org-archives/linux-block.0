Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8447BC07E9C
	for <linux-block@archiver.kernel.org>; Wed,  7 Jul 2021 05:29:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5EA1D61CB9
	for <linux-block@archiver.kernel.org>; Wed,  7 Jul 2021 05:29:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230240AbhGGFcd (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 7 Jul 2021 01:32:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230139AbhGGFcd (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 7 Jul 2021 01:32:33 -0400
Received: from mail-ot1-x336.google.com (mail-ot1-x336.google.com [IPv6:2607:f8b0:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DDAAFC061574;
        Tue,  6 Jul 2021 22:29:52 -0700 (PDT)
Received: by mail-ot1-x336.google.com with SMTP id 7-20020a9d0d070000b0290439abcef697so1169270oti.2;
        Tue, 06 Jul 2021 22:29:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ZSlcJZUOIqUIbhFmGgrUfWTTjY7XqvjzmGDuI9MNlKE=;
        b=h3qC31+Yfn7olTyHFFDun8KcMcvQguy/NK0hLexPuWvRkc2H8FYQ5LudRRVPGt48+z
         J5MiA4bqndUP8cYOtk35I2EyC4ZpvPuXRmJiPjK7GJzPmjHKgdJnL/0gCWVxvMs3PI36
         Ml8DllHiQ57SbxGW53/8FYk05jQE6tJ9cz6eBHXstdOecXM2Z6rozIhjkvW9albEqTyz
         hLHuflRF7xsnfbAzjxkGjBMPxOH+sT4FrhQSpiSthqZyda1bOWd/MW0nQzXGEG6iaU1Z
         4m9R8w/r+XHNvQ+WDXYZMGc3Irexj6BjOPqxdLSGg1uLgYQvSCpIoKbDKU1IXxPVFNXF
         z26g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ZSlcJZUOIqUIbhFmGgrUfWTTjY7XqvjzmGDuI9MNlKE=;
        b=XicHcgLyDAesgxKHx8tO7m3f3rwYz7LbEjQcThs1/U5u+w1yGEcAj2aDEJeLWvv8Ct
         Ot8xx84nL5c/QX/nRycmKuJJ9hULmszk0mQudeWZlBHkyoojhJHXZpjpUE5BRAN85LNb
         EX326aAwiipYPqgjrh9ejSk8b7EC9j1mwggsckilnirr92JYjGf9fKhJyTZePN8Ku8m9
         kFrBF+Ug5lcyMnuXO2qbighZVK0u35L/RYeckAgMa3V4XIjILRYgZkxYCxDresFpe/LR
         CnEI6ihESLZnzd0o/i/ltzQS1t4rytffW1ZQHacVl03TBbnVJzuFVWg7NcDn0UvWFXgd
         vn+Q==
X-Gm-Message-State: AOAM5318Fu4S7Hciha13a2comAE9vM1thCxKniivGk8O+X575gWkdIWK
        Em4bqUaDaUxn3UDOiOOrOOE9OQ88VH0=
X-Google-Smtp-Source: ABdhPJx2BvlaG273SYSSCEzWhEaRBaAfvt7BO4gxPwH42+4hXbZ//Uk0lROFCh+5MfiZ9Kju/Ru3vg==
X-Received: by 2002:a9d:19a9:: with SMTP id k38mr5757252otk.346.1625635792059;
        Tue, 06 Jul 2021 22:29:52 -0700 (PDT)
Received: from fractal.attlocal.net ([2600:1700:1151:2380:3ec5:124:b596:7a55])
        by smtp.googlemail.com with ESMTPSA id l11sm3284843oou.0.2021.07.06.22.29.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Jul 2021 22:29:51 -0700 (PDT)
From:   Satya Tangirala <satyaprateek2357@gmail.com>
To:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Jens Axboe <axboe@kernel.dk>, Eric Biggers <ebiggers@google.com>,
        Satya Tangirala <satyaprateek2357@gmail.com>
Subject: [PATCH v4 0/9] ensure bios aren't split in middle of crypto data unit
Date:   Tue,  6 Jul 2021 22:29:34 -0700
Message-Id: <20210707052943.3960-1-satyaprateek2357@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

When a bio has an encryption context, its size must be aligned to its
crypto data unit size. A bio must not be split in the middle of a data
unit. Currently, bios are split at logical block boundaries, but a crypto
data unit size might be larger than the logical block size - e.g. a machine
could be using fscrypt (which uses 4K crypto data units) with an eMMC block
device with inline encryption hardware that has a logical block size of 512
bytes.

Right now, the only user of blk-crypto is fscrypt (on ext4 and f2fs), which
(currently) only submits bios where the size of each segment is a multiple
of data_unit_size.  That happens to avoid most of the cases where bios
could be split in the middle of a data unit.  However, when support for
direct I/O on encrypted files is added, or when support for filesystem
metadata encryption is added, it will be possible for bios to have segment
lengths that are multiples of the logical block size, but not multiples of
the crypto data unit size.  So the block layer needs to start handling this
case appropriately.

So we need to support cases where the data unit size is larger than
the logical block size.

Patch 1 introduces blk_ksm_is_empty() that checks whether a keyslot manager
advertises a non-zero number of crypto capabilities. This function helps
clean up code a little.

Patches 2 and 3 introduce blk_crypto_bio_sectors_alignment() and
bio_required_sector_alignment() respectively. The former returns the
required sector alignment due to any crypto requirements the bio has.  The
latter returns the required sector alignment due to any reason.  The number
of sectors in any bio (and in particular, the number of sectors passed to
bio_split) *must* be aligned to the value returned by the latter function
(which, of course, calls the former function to decide what to return).

Patch 4 introduces restrictions on the data unit sizes advertised by a
keyslot manager. These restrictions come about due to the request_queue's
queue_limits, and are required to ensure that blk_bio_segment_split() can
always split a bio so that it has a limited number of sectors and segments,
and that the number of sectors it has is non-zero and aligned to
bio_required_sector_alignment().

Patches 5, 6 and 7 handle the error code from blk_ksm_register() in all
callers.  This return code was previously ignored by all callers because
the function could only fail if the request_queue had integrity support,
which the callers ensured would not be the case. But the patches in this
series add more cases where this function might fail, so it's better to
just handle the return code properly in all the callers.

Patch 8 updates get_max_io_size() and blk_bio_segment_split() to respect
bio_required_sector_alignment(). get_max_io_size() always returns a
value that is aligned to bio_required_sector_alignment(), and together
with Patch 4, this is enough to ensure that if the bio is split, it is
split at a crypto data unit size boundary.

Since all callers to bio_split() should have been updated by the previous
patches, Patch 9 adds a WARN_ON() to bio_split() when sectors isn't aligned
to bio_required_sector_alignment() (the one exception is bounce.c which is
legacy code and won't interact with inline encryption).

This patch series was tested by running android xfstests on the SDM630
chipset (which has eMMC inline encryption hardware with logical block size
512 bytes) with test_dummy_encryption with and without the 'inlinecrypt'
mount option.

Changes v3 => v4
 - Addressed comments and incorporated fixes from Eric
 - Patch 4 in v3 has been removed (Eric points out it isn't required
   without some of the changes in the device mapper patchset at
   https://lore.kernel.org/linux-block/20210604210908.2105870-1-satyat@google.com/
  so I'll add this patch to that series instead.

Satya Tangirala (9):
  block: introduce blk_ksm_is_empty()
  block: blk-crypto: introduce blk_crypto_bio_sectors_alignment()
  block: introduce bio_required_sector_alignment()
  block: keyslot-manager: introduce
    blk_ksm_restrict_dus_to_queue_limits()
  ufshcd: handle error from blk_ksm_register()
  mmc: handle error from blk_ksm_register()
  dm: handle error from blk_ksm_register()
  blk-merge: Ensure bios aren't split in middle of a crypto data unit
  block: add WARN_ON_ONCE() to bio_split() for sector alignment

 block/bio.c                      |   1 +
 block/blk-crypto-internal.h      |  17 +++++
 block/blk-merge.c                |  49 ++++++++-----
 block/blk.h                      |  17 +++++
 block/keyslot-manager.c          | 120 +++++++++++++++++++++++++++++++
 drivers/md/dm-table.c            |  28 +++++---
 drivers/mmc/core/crypto.c        |  13 +++-
 drivers/scsi/ufs/ufshcd-crypto.c |  13 +++-
 include/linux/keyslot-manager.h  |   2 +
 9 files changed, 227 insertions(+), 33 deletions(-)

-- 
2.25.1


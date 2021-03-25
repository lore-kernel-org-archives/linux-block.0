Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-21.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1019C433DB
	for <linux-block@archiver.kernel.org>; Thu, 25 Mar 2021 21:28:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9EC0A61A1E
	for <linux-block@archiver.kernel.org>; Thu, 25 Mar 2021 21:28:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230368AbhCYV1d (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 25 Mar 2021 17:27:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230486AbhCYV1J (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 25 Mar 2021 17:27:09 -0400
Received: from mail-pf1-x449.google.com (mail-pf1-x449.google.com [IPv6:2607:f8b0:4864:20::449])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC2B2C06175F
        for <linux-block@vger.kernel.org>; Thu, 25 Mar 2021 14:27:09 -0700 (PDT)
Received: by mail-pf1-x449.google.com with SMTP id n8so4308052pfd.23
        for <linux-block@vger.kernel.org>; Thu, 25 Mar 2021 14:27:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=21qVlvr5peFvEf1+kaZXijmo9eLYopmNiAMIRU+IQSU=;
        b=GRhBZT1JTJvobC+p+0Anv5OTUgBGC/Sp08xbmz3YObM+CBDFl94tJdBcgn5qB4/jBq
         kO7aF7kKI5e5P5vFypnuQBlByDN3GdjDdm+JlQ1DHEDMn21YBunNQjbq4gkF8sf4xfjs
         7L8+vUWX1n9b1bU7e8DIId0+tc9VRcXfVx7bpmVa+JBsb0Bz6lsb75F+TDG4qgf+j8CW
         f0gAmaQ+qzvCtIgkN6AZMm23e/1rIXX1yLyzlMVKiw7kCOrZnwM1K94CIvaF13l+MUGF
         cgRxCUOK0H3agnlIOuXfZ1YXCRL7maCicOe1rICIB1RL94GDsAzXl+d8NYv0HIII08nn
         JY/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=21qVlvr5peFvEf1+kaZXijmo9eLYopmNiAMIRU+IQSU=;
        b=j6VNJ2PHjjY9X6HYvoeggoMAwmzK80n2Z3tjazs4lPYH3fV2vssLcZHh0Ep2PsB430
         bdOucfgSF/K3gre3rvrSkh/mW6NEf8po4Zu+rrRQJFMLeWbR/6iugZ66f+pEQCZxfNcH
         QzO8FJEZ8KjCZSqFxKtoQRksun3qncuZrsqGwIBEflBNgBEkSIR94vZk96Jk4DYEX13j
         s5w+7xaluM7lFdRETA+a1AxkzwGs5T3c62oAkhznkSJcTdXX87I0NsfQJq6l2qug1+ET
         3lD6VphK17g4VbHtHM0IFAvdNAjHuTChFsFQaLEIq6CT10dhg8Q9vLANNPXgJ0cXLWVV
         2O4Q==
X-Gm-Message-State: AOAM531rfxeyWkFVjwRvx3GvXBvd2t3vf5J33stT6JW9OEc/it+dqiAO
        Di/aHhMfMN+WYcADfn6IwWtAau3g10sFfYBoAhxlB3K8o7apa06oQfgf29u6o3uTkcivq7BKgSO
        jGCdmFYYe0WgtAu71nDy92T/LCt27R2mR8q/3JNayGgZPkELxyzR9Y0oiOkT7QtLEzrV+
X-Google-Smtp-Source: ABdhPJxgGzVXMCAkl0rmpdRfIlqIY4x8Nil8WC1pM7aCoCSF+2oUA+vEmUQpdAA6FVHBqEo8uhItPOtrdrY=
X-Received: from satyaprateek.c.googlers.com ([fda3:e722:ac3:10:24:72f4:c0a8:1092])
 (user=satyat job=sendgmr) by 2002:a62:2742:0:b029:222:b711:3324 with SMTP id
 n63-20020a6227420000b0290222b7113324mr2110692pfn.7.1616707629111; Thu, 25 Mar
 2021 14:27:09 -0700 (PDT)
Date:   Thu, 25 Mar 2021 21:26:01 +0000
Message-Id: <20210325212609.492188-1-satyat@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.31.0.291.g576ba9dcdaf-goog
Subject: [PATCH v2 0/8] ensure bios aren't split in middle of crypto data unit
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
device with inline encryption hardware that has a logical block size of 512
bytes. So we need to support cases where the data unit size is larger than
the logical block size.

Patch 1 introduces blk_ksm_is_empty() that checks whether a keyslot manager
advertises a non-zero number of crypto capabilities. This function helps
clean up code a little.

Patch 2 handles the error code from blk_ksm_register() in all callers.
This return code was previously ignored by all callers because the function
could only fail if the request_queue had integrity support, which the
callers ensured would not be the case. But the later patches in this series
will add more cases where this function might fail, so it's better to just
handle the return code properly in all the callers.

Patch 3 and 4 introduce blk_crypto_bio_sectors_alignment() and
bio_required_sector_alignment() respectively. The former returns the
required sector alignment due to any crypto requirements the bio has.  The
latter returns the required sector alignment due to any reason.  The number
of sectors in any bio (and in particular, the number of sectors passed to
bio_split) *must* be aligned to the value returned by the latter function
(which, of course, calls the former function to decide what to return).

Patch 5 updates blk-crypto-fallback.c to respect
bio_required_sector_alignment() when calling bio_split(), so that any split
bio's size has the required alignment.

Patch 6 introduces restrictions on the data unit sizes advertised by a
keyslot manager. These restrictions come about due to the request_queue's
queue_limits, and are required to ensure that blk_bio_segment_split() can
always split a bio so that it has a limited number of sectors and segments,
and that the number of sectors it has is non-zero and aligned to
bio_required_sector_alignment().

Patch 7 updates get_max_io_size() and blk_bio_segment_split() to respect
bio_required_sector_alignment(). get_max_io_size() always returns a
value that is aligned to bio_required_sector_alignment(), and together
with Patch 6, this is enough to ensure that if the bio is split, it is
split at a crypto data unit size boundary.

Since all callers to bio_split() should have been updated by the previous
patches, Patch 8 adds a WARN_ON() to bio_split() when sectors isn't aligned
to bio_required_sector_alignment() (the one exception is bounce.c which is
legacy code and won't interact with inline encryption).

This patch series was tested by running android xfstests on the SDM630
chipset (which has eMMC inline encryption hardware with logical block size
512 bytes) with test_dummy_encryption with and without the 'inlinecrypt'
mount option.

Satya Tangirala (8):
  block: introduce blk_ksm_is_empty()
  dm,mmc,ufshcd: handle error from blk_ksm_register()
  block: blk-crypto: introduce blk_crypto_bio_sectors_alignment()
  block: introduce bio_required_sector_alignment()
  block: respect bio_required_sector_alignment() in blk-crypto-fallback
  block: keyslot-manager: introduce
    blk_ksm_restrict_dus_to_queue_limits()
  blk-merge: Ensure bios aren't split in middle of a crypto data unit
  block: add WARN() in bio_split() for sector alignment

 block/bio.c                      |  1 +
 block/blk-crypto-fallback.c      |  3 ++
 block/blk-crypto-internal.h      | 18 ++++++++
 block/blk-merge.c                | 49 ++++++++++++++--------
 block/blk.h                      | 12 ++++++
 block/keyslot-manager.c          | 72 ++++++++++++++++++++++++++++++++
 drivers/md/dm-table.c            | 14 ++-----
 drivers/mmc/core/crypto.c        |  6 ++-
 drivers/scsi/ufs/ufshcd-crypto.c |  6 ++-
 include/linux/keyslot-manager.h  |  2 +
 10 files changed, 150 insertions(+), 33 deletions(-)

-- 
2.31.0.291.g576ba9dcdaf-goog


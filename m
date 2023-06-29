Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 087FDEB64D9
	for <linux-block@archiver.kernel.org>; Thu, 29 Jun 2023 20:54:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229873AbjF2Uye (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 29 Jun 2023 16:54:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232111AbjF2UxN (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 29 Jun 2023 16:53:13 -0400
Received: from mail-qk1-f179.google.com (mail-qk1-f179.google.com [209.85.222.179])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85BDA3A8F
        for <linux-block@vger.kernel.org>; Thu, 29 Jun 2023 13:52:22 -0700 (PDT)
Received: by mail-qk1-f179.google.com with SMTP id af79cd13be357-76243a787a7so104947085a.2
        for <linux-block@vger.kernel.org>; Thu, 29 Jun 2023 13:52:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688071941; x=1690663941;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7d9FeE6aTXB8fD9aXlVOD/C2mJ6jYgFumLfL05JyPP0=;
        b=JnyEtyV/V1We9duhJGA8yXtQOsR0uYI3g+qf1neNGqbNUuRUqEb3Nub0SG4X6eKF+x
         WLgYXiGZXFqyzH2yo56LcciAVGSE0XvVY/LT5PW8cUg67ZBq7vZERMgGcd5qYDKdy4bx
         qHJ6ujZtm41UcmhDC5YKzTvqBsWSalZGpbiFtPqB9ZDgoB4CpY0+yhhrTlI8gMrl3SoT
         ctmgdGwL5R/gVc1xKkgVRaAdZ0DTebrias2wW/T9Px0vr1o61h2lZU/+zkBi+L5R4F2e
         P0YsAhuuRfBm7GLQtAgN3wZl9BTQiNtLEtE/0CKRLu/0WjBDCl8cUeVil8izBtivJl00
         PZ/g==
X-Gm-Message-State: ABy/qLYNZgaj8EhmgkrQ8Qbl7+4ld8jQJ1jxt5MP0wpSIwMHLgaJtsUG
        bWiN0sJPB6vU+NVUOSmczer1
X-Google-Smtp-Source: APBJJlG0rEu2m/z+yAI2XZTQcS505crnEykvGdraPZcoAo7WoA1gxmfc8Yftx51iNuoQsE7uh/NqAA==
X-Received: by 2002:a05:620a:294b:b0:765:6584:b033 with SMTP id n11-20020a05620a294b00b007656584b033mr449955qkp.50.1688071941611;
        Thu, 29 Jun 2023 13:52:21 -0700 (PDT)
Received: from localhost (pool-68-160-166-30.bstnma.fios.verizon.net. [68.160.166.30])
        by smtp.gmail.com with ESMTPSA id h22-20020a05620a13f600b00766f9df4a95sm4119085qkl.112.2023.06.29.13.52.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Jun 2023 13:52:21 -0700 (PDT)
Date:   Thu, 29 Jun 2023 16:52:20 -0400
From:   Mike Snitzer <snitzer@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     dm-devel@redhat.com, linux-block@vger.kernel.org,
        Alasdair G Kergon <agk@redhat.com>,
        Benjamin Marzinski <bmarzins@redhat.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        Demi Marie Obenour <demi@invisiblethingslab.com>,
        Li Lingfeng <lilingfeng3@huawei.com>,
        Li Nan <linan122@huawei.com>,
        Mike Snitzer <snitzer@kernel.org>,
        Mikulas Patocka <mpatocka@redhat.com>,
        Russell Harmon <eatnumber1@gmail.com>
Subject: [git pull] device mapper changes for 6.5
Message-ID: <ZJ3vBCypvTQ7w9pN@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi Linus,

This pull is based on an earlier subset of changes that you already
pulled in for 6.5 via the block tree.

The following changes since commit 245165658e1c9f95c0fecfe02b9b1ebd30a1198a:

  blk-mq: fix NULL dereference on q->elevator in blk_mq_elv_switch_none (2023-06-16 10:12:25 -0600)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/device-mapper/linux-dm.git tags/for-6.5/dm-changes

for you to fetch changes up to e2c789cab60a493a72b42cb53eb5fbf96d5f1ae3:

  dm: get rid of GFP_NOIO workarounds for __vmalloc and kvmalloc (2023-06-27 16:06:54 -0400)

Please pull, thanks.
Mike

----------------------------------------------------------------
- Update DM crypt to allocate compound pages if possible.

- Fix DM crypt target's crypt_ctr_cipher_new return value on invalid
  AEAD cipher.

- Fix DM flakey testing target's write bio corruption feature to
  corrupt the data of a cloned bio instead of the original.

- Add random_read_corrupt and random_write_corrupt features to DM
  flakey target.

- Fix ABBA deadlock in DM thin metadata by resetting associated bufio
  client rather than destroying and recreating it.

- A couple other small DM thinp cleanups.

- Update DM core to support disabling block core IO stats accounting
  and optimize away code that isn't needed if stats are disabled.

- Other small DM core cleanups.

- Improve DM integrity target to not require so much memory on 32 bit
  systems. Also only allocate the recalculate buffer as needed (and
  increasingly reduce its size on allocation failure).

- Update DM integrity to use %*ph for printing hexdump of a small
  buffer. Also update DM integrity documentation.

- Various DM core ioctl interface hardening.  Now more careful about
  alignment of structures and processing of input passed to the kernel
  from userspace. Also disallow the creation of DM devices named
  "control", "." or ".."

- Eliminate GFP_NOIO workarounds for __vmalloc and kvmalloc in DM
  core's ioctl and bufio code.
-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEJfWUX4UqZ4x1O2wixSPxCi2dA1oFAmScyjAACgkQxSPxCi2d
A1pilwgAucNIAB6uN4ke4WZrMVxSFntUkqDTkCs2Ycw+W4Tf1Mtrj/4WeBzFdJaA
oZMK04LUGaFFXn+halsCDzB354yT9C7V/KfXW8pCM1c9BRz4e8272i2HSN4WwD5n
BU4gVaOV5BwxynfF3Z5siRraad1AwmdoRGGsqzVRESAKaObXU//1tnO42UhxRVhn
nzFqhIm0xRcLAd8xIBlMsZQGIloicdDP9wZdWzTEDspQiwR2dFRmH9bUF8OmsS+h
KwhtDty7aZO+4gJ1ccBImijzQCmbAo7dmFhDfoLXaA5Jt6UwTXMeBHm4aUPMnvQe
NVXoRZJodDemwM642Q/Tx1SpsX6QmA==
=4R7u
-----END PGP SIGNATURE-----

----------------------------------------------------------------
Andy Shevchenko (1):
      dm integrity: Use %*ph for printing hexdump of a small buffer

Christophe JAILLET (1):
      dm zone: Use the bitmap API to allocate bitmaps

Demi Marie Obenour (6):
      dm ioctl: Check dm_target_spec is sufficiently aligned
      dm ioctl: Avoid pointer arithmetic overflow
      dm ioctl: structs and parameter strings must not overlap
      dm ioctl: Avoid double-fetch of version
      dm ioctl: Refuse to create device named "control"
      dm ioctl: Refuse to create device named "." or ".."

Li Lingfeng (1):
      dm thin metadata: Fix ABBA deadlock by resetting dm_bufio_client

Li Nan (1):
      dm: support turning off block-core's io stats accounting

Mike Snitzer (6):
      dm thin: remove return code variable in pool_map
      dm thin: update .io_hints methods to not require handling discards last
      dm: avoid needless dm_io access if all IO accounting is disabled
      dm: skip dm-stats work in alloc_io() unless needed
      dm: remove stale/redundant dm_internal_{suspend,resume} prototypes in dm.h
      dm thin: disable discards for thin-pool if no_discard_passdown

Mikulas Patocka (8):
      dm crypt: allocate compound pages if possible
      dm flakey: clone pages on write bio before corrupting them
      dm flakey: introduce random_read_corrupt and random_write_corrupt options
      dm crypt: fix crypt_ctr_cipher_new return value on invalid AEAD cipher
      dm integrity: reduce vmalloc space footprint on 32-bit architectures
      dm integrity: only allocate recalculate buffer when needed
      dm integrity: scale down the recalculate buffer if memory allocation fails
      dm: get rid of GFP_NOIO workarounds for __vmalloc and kvmalloc

Russell Harmon (4):
      Documentation: dm-integrity: Fix minor grammatical error.
      Documentation: dm-integrity: Document the meaning of "buffer".
      Documentation: dm-integrity: Document default values.
      Documentation: dm-integrity: Document an example of how the tunables relate.

 .../admin-guide/device-mapper/dm-flakey.rst        |  10 +
 .../admin-guide/device-mapper/dm-integrity.rst     |  43 +++--
 drivers/md/dm-bufio.c                              |  24 +--
 drivers/md/dm-core.h                               |   3 +-
 drivers/md/dm-crypt.c                              |  51 +++--
 drivers/md/dm-flakey.c                             | 210 ++++++++++++++++++---
 drivers/md/dm-integrity.c                          |  85 ++++-----
 drivers/md/dm-ioctl.c                              |  98 +++++++---
 drivers/md/dm-thin-metadata.c                      |  58 +++---
 drivers/md/dm-thin.c                               |  41 ++--
 drivers/md/dm-zone.c                               |  15 +-
 drivers/md/dm.c                                    |  58 +++---
 drivers/md/dm.h                                    |   3 -
 drivers/md/persistent-data/dm-block-manager.c      |   6 +
 drivers/md/persistent-data/dm-block-manager.h      |   1 +
 drivers/md/persistent-data/dm-space-map.h          |   3 +-
 .../md/persistent-data/dm-transaction-manager.c    |   3 +
 include/linux/dm-bufio.h                           |   2 +
 18 files changed, 478 insertions(+), 236 deletions(-)

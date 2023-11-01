Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B7EDC4167B
	for <linux-block@archiver.kernel.org>; Wed,  1 Nov 2023 16:20:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233227AbjKAQU0 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 1 Nov 2023 12:20:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231233AbjKAQUZ (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 1 Nov 2023 12:20:25 -0400
Received: from mail-qv1-f53.google.com (mail-qv1-f53.google.com [209.85.219.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41CD3F7
        for <linux-block@vger.kernel.org>; Wed,  1 Nov 2023 09:19:37 -0700 (PDT)
Received: by mail-qv1-f53.google.com with SMTP id 6a1803df08f44-66d0c777bf0so47073646d6.3
        for <linux-block@vger.kernel.org>; Wed, 01 Nov 2023 09:19:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698855576; x=1699460376;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=PQtTpppYeU9AiypuUG+j2PUMePFfB94rnMKwVfmVaMc=;
        b=PAEY2ky98dKlGvLgszGaIUhw76aAtl0onizKGuiNnLs4nxa6zo9reVml6bCbI+Y5iU
         1D3KdlTnFxtXVsJ/SQxt4k8ZdnIljX9wQTnhPIP5Qba3k2SIw2iEoeL961d4J1MftMwE
         JPFQMA7JsiYKGpktGAvX9Bh344kKrArm7wgIFfPaf1U/J9sm8qNJQ1DYUxM/7/PuKlJt
         VEYWu6Q0HkUHfoup2wpRTLHGQCOF6H8Jk4ZgzmUEzDxUDSb2BlyXyYWO2dy0sCj4uAYS
         9OXr7TjSRdEywKjhzzPRyFIru+80Fv3Rh3dp4iN91tZN8xMX6QpObKWMrqX26FX6qZz7
         Iu8w==
X-Gm-Message-State: AOJu0Yxcev62UVk8eQANhaWRmL7RQf2JMdmNAV8JBNr+D/VYfOLJGUPw
        VVp+qLPMWLnuD/AZ+2OKJ475
X-Google-Smtp-Source: AGHT+IHqr9/GGjbi2gSbzfcHIoxu0l/hcaUpr0DYzQPsXWnTrsUr+fnlf4uomSKcSePYC1EN9IIkQQ==
X-Received: by 2002:ad4:596d:0:b0:655:d82d:2fd0 with SMTP id eq13-20020ad4596d000000b00655d82d2fd0mr15069845qvb.21.1698855576378;
        Wed, 01 Nov 2023 09:19:36 -0700 (PDT)
Received: from localhost (pool-68-160-141-91.bstnma.fios.verizon.net. [68.160.141.91])
        by smtp.gmail.com with ESMTPSA id lg18-20020a056214549200b0065cfec43097sm1601112qvb.39.2023.11.01.09.19.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Nov 2023 09:19:36 -0700 (PDT)
Date:   Wed, 1 Nov 2023 12:19:34 -0400
From:   Mike Snitzer <snitzer@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     dm-devel@lists.linux.dev, linux-block@vger.kernel.org,
        Alasdair G Kergon <agk@redhat.com>,
        Mikulas Patocka <mpatocka@redhat.com>,
        Benjamin Marzinski <bmarzins@redhat.com>,
        Christian Loehle <christian.loehle@arm.com>,
        Damien Le Moal <dlemoal@kernel.org>,
        Eric Biggers <ebiggers@google.com>,
        Justin Stitt <justinstitt@google.com>
Subject: [git pull] device mapper changes for 6.7
Message-ID: <ZUJ6lh4bDU/KqKBc@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi Linus,

The following changes since commit 3da5d2de92387a8322965c7fb1365f7cae690e5a:

  MAINTAINERS: update the dm-devel mailing list (2023-10-06 19:05:57 -0400)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/device-mapper/linux-dm.git tags/for-6.7/dm-changes

for you to fetch changes up to 9793c269da6cd339757de6ba5b2c8681b54c99af:

  dm crypt: account large pages in cc->n_allocated_pages (2023-10-31 14:25:06 -0400)

Please pull, thanks.
Mike

----------------------------------------------------------------
- Update DM core to directly call the map function for both the linear
  and stripe targets; which are provided by DM core.

- Various updates to use new safer string functions.

- Update DM core to respect REQ_NOWAIT flag in normal bios so that
  memory allocations are always attempted with GFP_NOWAIT.

- Add Mikulas Patocka to MAINTAINERS as a DM maintainer!

- Improve DM delay target's handling of short delays (< 50ms) by using
  a kthread to check expiration of IOs rather than timers and a wq.

- Update the DM error target so that it works with zoned storage. This
  helps xfstests to provide proper IO error handling coverage when
  testing a filesystem with native zoned storage support.

- Update both DM crypt and integrity targets to improve performance by
  using crypto_shash_digest() rather than init+update+final sequence.

- Fix DM crypt target by backfilling missing memory allocation
  accounting for compound pages.
-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEJfWUX4UqZ4x1O2wixSPxCi2dA1oFAmVCeG8ACgkQxSPxCi2d
A1oXAAgAnT0mb1psEwDhKiJG26bUeJDJHIaNTPPw4UpCvKEWU7lTxzJUmthnwLZI
D+JnkrenAfGppdsFkHh1ogTBz8r60aeBTY31SUoCUVS/clwHxRstLCkSE2655an3
WNgrGItta5BRtcgTMxU7bmqVOD4Xyw704L7BK5CM4zKBQuXJtkegylALhdXvYSjs
mvHWoPczFW6Rv79CkF0uTkon7Ji041BvKVjbp+fYQf9Pul5d6S1v4Jrvlo2EqblU
6OM75OosNgziQhdw7faVOgFCVkQfLkEeYsJ47dBOjpC3+sbyKENbC4r+ZmkCZGyI
uJERswpmAkW7pp+Ab6sqG582DXvPvA==
=PPwQ
-----END PGP SIGNATURE-----

----------------------------------------------------------------
Christian Loehle (1):
      dm delay: for short delays, use kthread instead of timers and wq

Damien Le Moal (1):
      dm error: Add support for zoned block devices

Eric Biggers (2):
      dm crypt: use crypto_shash_digest() in crypt_iv_tcw_whitening()
      dm integrity: use crypto_shash_digest() in sb_mac()

Justin Stitt (4):
      dm cache metadata: replace deprecated strncpy with strscpy
      dm crypt: replace open-coded kmemdup_nul
      dm ioctl: replace deprecated strncpy with strscpy_pad
      dm log userspace: replace deprecated strncpy with strscpy

Mike Snitzer (3):
      dm: enhance alloc_multiple_bios() to be more versatile
      dm: respect REQ_NOWAIT flag in normal bios issued to DM
      MAINTAINERS: add Mikulas Patocka as a DM maintainer

Mikulas Patocka (3):
      dm: shortcut the calls to linear_map and stripe_map
      dm: make __send_duplicate_bios return unsigned int
      dm crypt: account large pages in cc->n_allocated_pages

 MAINTAINERS                        |   1 +
 drivers/md/dm-cache-metadata.c     |   6 +-
 drivers/md/dm-crypt.c              |  26 ++++----
 drivers/md/dm-delay.c              | 103 ++++++++++++++++++++++++++-----
 drivers/md/dm-integrity.c          |  30 +++------
 drivers/md/dm-ioctl.c              |   4 +-
 drivers/md/dm-linear.c             |   2 +-
 drivers/md/dm-log-userspace-base.c |   2 +-
 drivers/md/dm-stripe.c             |   2 +-
 drivers/md/dm-table.c              |  23 ++++++-
 drivers/md/dm-target.c             | 106 +++++++++++++++++++++++++++++++-
 drivers/md/dm.c                    | 121 ++++++++++++++++++++++---------------
 drivers/md/dm.h                    |   2 +
 13 files changed, 321 insertions(+), 107 deletions(-)

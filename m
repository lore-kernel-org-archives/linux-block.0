Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7659BC4332F
	for <linux-block@archiver.kernel.org>; Mon, 12 Dec 2022 22:37:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233792AbiLLWhP (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 12 Dec 2022 17:37:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233804AbiLLWhN (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 12 Dec 2022 17:37:13 -0500
Received: from mail-vs1-f47.google.com (mail-vs1-f47.google.com [209.85.217.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5CEC03886
        for <linux-block@vger.kernel.org>; Mon, 12 Dec 2022 14:36:16 -0800 (PST)
Received: by mail-vs1-f47.google.com with SMTP id a66so4324401vsa.6
        for <linux-block@vger.kernel.org>; Mon, 12 Dec 2022 14:36:16 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nWhMF1CTesM4BHybNTgKV7lM/70y3OMyFAmvejIEjS4=;
        b=cvWrxBqMwzx3JG82ehBUWltUZP58J8mY7TstMI8LtMcdzO1A63s3EWjJcAWLJWyvZ5
         hO8Er1DeN2Bt3QkzsJ+U7Ev8w5XWbHXJXX5u0WhHXjboynAnXGCIzS4P9o+fIiVyV0Bh
         TgPGwVcZojVzjq+s/x44wGUXDNbT1jdbpISHW5gJ+p14v6t1nrDcv+fq2REV9AuzGcEH
         PzO1TmpyBmGfuZBQ5e9EOZ+6YWexeqeQjlwV1ZZCFXocDvTZiKKSyKuHtohmDcakaxwp
         vp88oxvgU0k91vO+QRJk+5q7SmZCLwvouPniiLrOD8oCI4cwBDF7sKAjwsol478vSM7H
         sNKA==
X-Gm-Message-State: ANoB5pnQGLtdN2LddIn7pUMjtNuWvH9jj3p7o/qHH/HkdceB+jXP4sq/
        fZgmEdQeYELQt4bWwYIQPFSe5eilXOcR1qA=
X-Google-Smtp-Source: AA0mqf7m4mzBWV2azX1Bll5cjClij3B+qoQDpbNtARWC+17pZx8HuSAsuUyrhipDelLAGzJyv19RVw==
X-Received: by 2002:a05:6102:22cf:b0:3b0:f33b:38a5 with SMTP id a15-20020a05610222cf00b003b0f33b38a5mr6450670vsh.13.1670884575404;
        Mon, 12 Dec 2022 14:36:15 -0800 (PST)
Received: from localhost (pool-68-160-173-162.bstnma.fios.verizon.net. [68.160.173.162])
        by smtp.gmail.com with ESMTPSA id bn39-20020a05620a2ae700b006ce76811a07sm6504540qkb.75.2022.12.12.14.36.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Dec 2022 14:36:14 -0800 (PST)
Date:   Mon, 12 Dec 2022 17:36:13 -0500
From:   Mike Snitzer <snitzer@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     dm-devel@redhat.com, linux-block@vger.kernel.org,
        Alasdair G Kergon <agk@redhat.com>,
        Luo Meng <luomeng12@huawei.com>,
        Mikulas Patocka <mpatocka@redhat.com>,
        Peter Korsgaard <peter@korsgaard.com>,
        Zhihao Cheng <chengzhihao1@huawei.com>
Subject: [git pull] device mapper changes for 6.2
Message-ID: <Y5es3Sf0DU0QEHPP@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi Linus,

The following changes since commit b7b275e60bcd5f89771e865a8239325f86d9927d:

  Linux 6.1-rc7 (2022-11-27 13:31:48 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/device-mapper/linux-dm.git tags/for-6.2/dm-changes

for you to fetch changes up to 7991dbff6849f67e823b7cc0c15e5a90b0549b9f:

  dm thin: Use last transaction's pmd->root when commit failed (2022-12-08 12:17:09 -0500)

Please pull, thanks.
Mike

----------------------------------------------------------------
- Fix use-after-free races due to missing resource cleanup during DM
  target destruction in DM targets: thin-pool, cache, integrity and
  clone.

- Fix ABBA deadlocks in DM thin-pool and cache targets due to their
  use of a bufio client (that has a shrinker whose locking can cause
  the incorrect locking order).

- Fix DM cache target to set its needs_check flag after first aborting
  the metadata (whereby using reset persistent-data objects to update
  the superblock with, otherwise the superblock update could be
  dropped due to aborting metadata).  This was found with
  code-inspection when comparing with the equivalent in DM thinp
  code.

- Fix DM thin-pool's presume to continue resuming the device even if
  the pool in is fail mode -- otherwise bios may never be failed up
  the IO stack (which will prevent resetting the thin-pool target via
  table reload)

- Fix DM thin-pool's metadata to use proper btree root (from previous
  transaction) if metadata commit failed.

- Add 'waitfor' module param to DM module (dm_mod) to allow dm-init to
  wait for the specified device before continuing with its DM target
  initialization.

----------------------------------------------------------------
Luo Meng (5):
      dm thin: Fix UAF in run_timer_softirq()
      dm clone: Fix UAF in clone_dtr()
      dm cache: Fix UAF in destroy()
      dm integrity: Fix UAF in dm_integrity_dtr()
      dm thin: resume even if in FAIL mode

Mike Snitzer (2):
      dm cache: Fix ABBA deadlock between shrink_slab and dm_cache_metadata_abort
      dm cache: set needs_check flag after aborting metadata

Mikulas Patocka (2):
      dm ioctl: a small code cleanup in list_version_get_info
      dm ioctl: fix a couple ioctl codes

Peter Korsgaard (1):
      dm init: add dm-mod.waitfor to wait for asynchronously probed block devices

Zhihao Cheng (2):
      dm thin: Fix ABBA deadlock between shrink_slab and dm_pool_abort_metadata
      dm thin: Use last transaction's pmd->root when commit failed

 .../admin-guide/device-mapper/dm-init.rst          |  8 +++
 drivers/md/dm-cache-metadata.c                     | 54 ++++++++++++++++---
 drivers/md/dm-cache-target.c                       | 11 ++--
 drivers/md/dm-clone-target.c                       |  1 +
 drivers/md/dm-init.c                               | 22 +++++++-
 drivers/md/dm-integrity.c                          |  2 +
 drivers/md/dm-ioctl.c                              |  6 +--
 drivers/md/dm-thin-metadata.c                      | 60 +++++++++++++++++++---
 drivers/md/dm-thin.c                               | 18 +++++--
 9 files changed, 154 insertions(+), 28 deletions(-)

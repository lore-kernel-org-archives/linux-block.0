Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-21.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DFB8FC433E0
	for <linux-block@archiver.kernel.org>; Mon,  1 Feb 2021 05:11:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9DE3064E27
	for <linux-block@archiver.kernel.org>; Mon,  1 Feb 2021 05:11:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229522AbhBAFLJ (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 1 Feb 2021 00:11:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229476AbhBAFLI (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Mon, 1 Feb 2021 00:11:08 -0500
Received: from mail-pg1-x549.google.com (mail-pg1-x549.google.com [IPv6:2607:f8b0:4864:20::549])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7EFBFC061756
        for <linux-block@vger.kernel.org>; Sun, 31 Jan 2021 21:10:28 -0800 (PST)
Received: by mail-pg1-x549.google.com with SMTP id 33so10667314pgv.0
        for <linux-block@vger.kernel.org>; Sun, 31 Jan 2021 21:10:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:message-id:mime-version:subject:from:to:cc;
        bh=5ZoMmUaGdgNrxvzHYeMz2EcFPXbySR8ZrCc4GJHr60Q=;
        b=GsGk6EeZc10sUAJZaOf4YTwiJ7noIyqt1ZL6Q4iD9nWKnsiLLIf4G98Z0Qa9svXj1a
         5uUDVIxoZ5Ep3sUweBy2fDlOJWdJC9+/XEEPHEXYQ8uhHZDDDndOwryqfBimR1WG2fjY
         UWTLp1Xo1eof/KOu5IJKr1PPP4c1/Dvwcjvhew4XIkbUbw+xK4c+osUzV8D0r9Efhc/H
         I53hHpo/Nxmst24178Rbc8S99wyHtj+jQyw5EKpPo7qFRkduwbhay0nWYoGVvTsMHzQ/
         jUvxoC7NCeUJgovARnpZ9piEdKheliJddcnxWeGf+4lKg+z2GIjWvrW+1mcSpJX57oup
         Tv2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:message-id:mime-version:subject:from
         :to:cc;
        bh=5ZoMmUaGdgNrxvzHYeMz2EcFPXbySR8ZrCc4GJHr60Q=;
        b=Uo/mj6I5sEg9Nzm2DwQDq4/H3S6QUUrlzqJDU/dvzSKQn+Q5su2fmPq2znFtv41Sp2
         BznCbwnR9LmTDz9n1729ixbn/Aag26OYmIZWngYPxp06wf+SlaMU6E+LA5Z7Za+Wkbe3
         esv+ZlysQoes7HKslJHPwrfpPYr75WZyjjZ94Lq/tm1TV2jJTBsvMJmF74FImPFYIPbb
         LPCPEsrxvH5tRrldti/pgfpiVDH4mr9DBrO6Nv1brjYdTdUyin/cBBtj5TJpfeL2kpXw
         0XA+eLLnjAGIGpMkSgLjRXufTvWC1Aqzt54D26tOMM5qBZ6cxAnqaa061uLF+RGxS2Xt
         7+mA==
X-Gm-Message-State: AOAM530JtDSmPgvQIUtmOFxgof3MRK3SQaE6gdju1/2m5uPT5ioqSji5
        xWtroZBKOrOdRJwXbe0dtgBQSHiD2YqTGSOE2vWvjK0ZoCTgfDv3mR9oWTfnPo4qwOi9buViwvV
        AYUOHWWR6Hv7FI2G8RL+cjdlMt12hY2qHf1XoaJLLGnAuQK1At2Fu6x5EIX8J7a6HoPid
X-Google-Smtp-Source: ABdhPJx7kmsVH9WtDT4ayliJVLV/lqAyWP654IizECuvbo2azm7D5+QBqPGedxCBE8YFh0HDRNKdzQUMhKM=
Sender: "satyat via sendgmr" <satyat@satyaprateek.c.googlers.com>
X-Received: from satyaprateek.c.googlers.com ([fda3:e722:ac3:10:24:72f4:c0a8:1092])
 (user=satyat job=sendgmr) by 2002:a05:6a00:86:b029:1c1:99a1:fe2b with SMTP id
 c6-20020a056a000086b02901c199a1fe2bmr15065660pfj.29.1612156227897; Sun, 31
 Jan 2021 21:10:27 -0800 (PST)
Date:   Mon,  1 Feb 2021 05:10:14 +0000
Message-Id: <20210201051019.1174983-1-satyat@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.30.0.365.g02bc693789-goog
Subject: [PATCH v4 0/5] add support for inline encryption to device mapper
From:   Satya Tangirala <satyat@google.com>
To:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        dm-devel@redhat.com
Cc:     Jens Axboe <axboe@kernel.dk>, Alasdair Kergon <agk@redhat.com>,
        Mike Snitzer <snitzer@redhat.com>,
        Eric Biggers <ebiggers@google.com>,
        Satya Tangirala <satyat@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

This patch series adds support for inline encryption to the device mapper.

Patch 1 introduces the "passthrough" keyslot manager.

The regular keyslot manager is designed for inline encryption hardware that
have only a small fixed number of keyslots. A DM device itself does not
actually have only a small fixed number of keyslots - it doesn't actually
have any keyslots in the first place, and programming an encryption context
into a DM device doesn't make much semantic sense. It is possible for a DM
device to set up a keyslot manager with some "sufficiently large" number of
keyslots in its request queue, so that upper layers can use the inline
encryption capabilities of the DM device's underlying devices, but the
memory being allocated for the DM device's keyslots is a waste since they
won't actually be used by the DM device.

The passthrough keyslot manager solves this issue - when the block layer
sees that a request queue has a passthrough keyslot manager, it doesn't
attempt to program any encryption context into the keyslot manager. The
passthrough keyslot manager only allows the device to expose its inline
encryption capabilities, and a way for upper layers to evict keys if
necessary.

There also exist inline encryption hardware that can handle encryption
contexts directly, and allow users to pass them a data request along with
the encryption context (as opposed to inline encryption hardware that
require users to first program a keyslot with an encryption context, and
then require the users to pass the keyslot index with the data request).
Such devices can also make use of the passthrough keyslot manager.

Patch 2 introduces some keyslot manager functions useful for the device
mapper.

Patch 3 introduces the changes for inline encryption support for the device
mapper. A DM device only exposes the intersection of the crypto
capabilities of its underlying devices. This is so that in case a bio with
an encryption context is eventually mapped to an underlying device that
doesn't support that encryption context, the blk-crypto-fallback's cipher
tfms are allocated ahead of time by the call to blk_crypto_start_using_key.

Each DM target can now also specify the "DM_TARGET_PASSES_CRYPTO" flag in
the target type features to opt-in to supporting passing through the
underlying inline encryption capabilities.  This flag is needed because it
doesn't make much semantic sense for certain targets like dm-crypt to
expose the underlying inline encryption capabilities to the upper layers.
Again, the DM exposes inline encryption capabilities of the underlying
devices only if all of them opt-in to passing through inline encryption
support.

A keyslot manager is created for a table when it is loaded. However, the
mapped device's exposed capabilities *only* updated once the table is
swapped in (until the new table is swapped in, the mapped device continues
to expose the old table's crypto capabilities).

This patch only allows the keyslot manager's capabilities to *expand*
because of table changes. Any attempt to load a new table that doesn't
support a crypto capability that the old table did is rejected.

This patch also only exposes the intersection of the underlying device's
capabilities, which has the effect of causing en/decryption of a bio to
fall back to the kernel crypto API (if the fallback is enabled) whenever
any of the underlying devices doesn't support the encryption context of the
bio - it might be possible to make the bio only fall back to the kernel
crypto API if the bio's target underlying device doesn't support the bio's
encryption context, but the use case may be uncommon enough in the first
place not to warrant worrying about it right now.

Patch 4 makes DM evict a key from all its underlying devices when asked to
evict a key.

Patch 5 makes some DM targets opt-in to passing through inline encryption
support. It does not (yet) try to enable this option with dm-raid, since
users can "hot add" disks to a raid device, which makes this not completely
straightforward (we'll need to ensure that any "hot added" disks must have
a superset of the inline encryption capabilities of the rest of the disks
in the raid device, due to the way Patch 2 of this series works).

Changes v3 => v4:
 - Allocate the memory for the ksm of the mapped device in
   dm_table_complete(), and install the ksm in the md queue in __bind()
   (as suggested by Mike). Also drop patch 5 from v3 since it's no longer
   needed.
 - Some cleanups

Changes v2 => v3:
 - Split up the main DM patch into 4 separate patches
 - Removed the priv variable added to struct keyslot manager in v2
 - Use a flag in target type features for opting-in to inline encryption
   support, instead of using "may_passthrough_inline_crypto"
 - cleanups, improve docs and restructure code

Changes v1 => v2:
 - Introduce private field to struct blk_keyslot_manager
 - Allow the DM keyslot manager to expand its crypto capabilities if the
   table is changed.
 - Make DM reject table changes that would otherwise cause crypto
   capabilities to be dropped.
 - Allocate the DM device's keyslot manager only when at least one crypto
   capability is supported (since a NULL value for q->ksm represents "no
   crypto support" anyway).
 - Remove the struct blk_keyslot_manager field from struct mapped_device.
   This patch now relies on just directly setting up the keyslot manager in
   the request queue, since each DM device is tied to only 1 queue.

Satya Tangirala (5):
  block: keyslot-manager: Introduce passthrough keyslot manager
  block: keyslot-manager: Introduce functions for device mapper support
  dm: add support for passing through inline crypto support
  dm: support key eviction from keyslot managers of underlying devices
  dm: set DM_TARGET_PASSES_CRYPTO feature for some targets

 block/blk-crypto.c              |   1 +
 block/keyslot-manager.c         | 146 ++++++++++++++++++++++
 drivers/md/dm-core.h            |   5 +
 drivers/md/dm-flakey.c          |   4 +-
 drivers/md/dm-linear.c          |   5 +-
 drivers/md/dm-table.c           | 210 ++++++++++++++++++++++++++++++++
 drivers/md/dm.c                 |  18 ++-
 include/linux/device-mapper.h   |  11 ++
 include/linux/keyslot-manager.h |  11 ++
 9 files changed, 407 insertions(+), 4 deletions(-)

-- 
2.30.0.365.g02bc693789-goog


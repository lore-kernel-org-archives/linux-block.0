Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-21.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95CBCC433E0
	for <linux-block@archiver.kernel.org>; Tue, 29 Dec 2020 08:56:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 60D62207CF
	for <linux-block@archiver.kernel.org>; Tue, 29 Dec 2020 08:56:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726244AbgL2I4L (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 29 Dec 2020 03:56:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725986AbgL2I4K (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 29 Dec 2020 03:56:10 -0500
Received: from mail-qv1-xf49.google.com (mail-qv1-xf49.google.com [IPv6:2607:f8b0:4864:20::f49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45912C061799
        for <linux-block@vger.kernel.org>; Tue, 29 Dec 2020 00:55:30 -0800 (PST)
Received: by mail-qv1-xf49.google.com with SMTP id t16so11331301qvk.13
        for <linux-block@vger.kernel.org>; Tue, 29 Dec 2020 00:55:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:message-id:mime-version:subject:from:to:cc;
        bh=RWF45nfESoe/xg6vBm9ZSMGF2K7udGDVIpJcJtV7Ubo=;
        b=jXKSiCgesR1WHLlKGxh5BW86oNMIY4QYDJZr0J7nxM1A6YFU5oWJeyhimuVROsl9rc
         D/c7O8dFOGo0kHiN0K3437fWq/Sz/1ADQ3Ay9pGBsVpGEMgKhGDG2tUPuuILqZCcOWdR
         OultJkN1blTae4NaVaDDhTFF7q327kCHdGY8NkC5/IwnHlTneEAI34zke2/SOLkawf1h
         Iiq8DJW9Wsye8AzaGkYR7FBWGLfjV+LjtgwyVOORirC2EW0OjOCyzvgcYsEv2LSJ4ov/
         LGP8uvlibYMNvRU0Rmh/G+SjIz4Ft34nN737H8w+5Y5Zb+J/dLuW0loMfIH054BU0wjT
         sd5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:message-id:mime-version:subject:from
         :to:cc;
        bh=RWF45nfESoe/xg6vBm9ZSMGF2K7udGDVIpJcJtV7Ubo=;
        b=GhosgJ8SLZ1Fvjuaj9q1AUDmlXavR060/ZhSvzKGTmUqpk0PyJtgXLWuKxmyRrzYjG
         nOCYylubyU3Frmsb6qEZBaRf/zdpcESjoldRJH5csnnbN/kMqC2bUHTwQBCAxnu2JV1x
         NWD09kZ9kuBOpu8HQTdQ8JVoetBmFZut25WjS+EyX6W4XN5tj7jLWgi7D5Vu9Ebo2FTC
         5OyNgi0iPrNDzn0JV5wtDKe0NdrR9NsT2eJk0gEE0LE+Xm/VHiEG10s+BKoPCnePFUfl
         3cp+4pxlcTnZjPSMiv/GKn877m0+8+nZPN4QMAPozoN4Yt+xalA93saluihmd38lVsBb
         qACA==
X-Gm-Message-State: AOAM531UUiW6MBhuqaC2JdObd90+ZTX6wYwPc2ug/Taeb7Dyl7hN2Q4Y
        WGiUmuNm5Drr5mirVBGs0uwXs4OxF+Kcbs/03dlMh16yP0+1crrdfsUqHO7gQCTGxWfJsUj2BO1
        zpoK1R6y/wOi0e8/3Ciajs2dZsIyV62GphFbhlm7AxtLBKMb82+vnG8OjG2KPo/aneQrz
X-Google-Smtp-Source: ABdhPJyvfLRGDggGOMtCa+n52qb+E+PZ9C1ZijQyrf0ise7owIlupD7UN+RW9xEOLCNp/pRUGtp9/HE1oZs=
Sender: "satyat via sendgmr" <satyat@satyaprateek.c.googlers.com>
X-Received: from satyaprateek.c.googlers.com ([fda3:e722:ac3:10:24:72f4:c0a8:1092])
 (user=satyat job=sendgmr) by 2002:a05:6214:1266:: with SMTP id
 r6mr50672101qvv.12.1609232129361; Tue, 29 Dec 2020 00:55:29 -0800 (PST)
Date:   Tue, 29 Dec 2020 08:55:18 +0000
Message-Id: <20201229085524.2795331-1-satyat@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.29.2.729.g45daf8777d-goog
Subject: [PATCH v3 0/6] add support for inline encryption to device mapper
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

A DM device's keyslot manager is set up whenever a new table is swapped in.
This patch only allows the keyslot manager's capabilities to *expand*
because of table changes. In this patch, the new inline encryption
capabilities are only verified and used when the table is *swapped* -
nothing is done when a new table is loaded (Patch 5 changes this
behaviour).

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

Patch 5 verifies the inline encryption capabilities of a new table when
it's loaded. Any attempts to load a new table that would cause crypto
capabilities to be dropped are rejected at load time, with this patch.
Still, the keyslot manager for the DM device is only modified when the
table is actually swapped in, since the capabilities of the device may
change further due to changes in capabilities of underlying devices between
the time the table load and table swap happen.

Patch 6 makes some DM targets opt-in to passing through inline encryption
support. It does not (yet) try to enable this option with dm-raid, since
users can "hot add" disks to a raid device, which makes this not completely
straightforward (we'll need to ensure that any "hot added" disks must have
a superset of the inline encryption capabilities of the rest of the disks
in the raid device, due to the way Patch 2 of this series works).

Changes v2 => v3:
 - Split up the main DM patch into 4 separate patches
 - Removed the priv variable added to struct keyslot manager in v2
 - Use a flag in target type features for opting-in to inline encryption
   support, instead of using "may_passthrough_inline_crypto"
 - cleanups and restructure code

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

Satya Tangirala (6):
  block: keyslot-manager: Introduce passthrough keyslot manager
  block: keyslot-manager: Introduce functions for device mapper support
  dm: add support for passing through inline crypto support
  dm: Support key eviction from keyslot managers of underlying devices
  dm: Verify inline encryption capabilities of new table when it is
    loaded
  dm: set DM_TARGET_PASSES_CRYPTO feature for some targets

 block/blk-crypto.c              |   1 +
 block/keyslot-manager.c         | 130 +++++++++++++++++
 drivers/md/dm-flakey.c          |   4 +-
 drivers/md/dm-ioctl.c           |   8 ++
 drivers/md/dm-linear.c          |   5 +-
 drivers/md/dm.c                 | 242 +++++++++++++++++++++++++++++++-
 drivers/md/dm.h                 |  19 +++
 include/linux/device-mapper.h   |   6 +
 include/linux/keyslot-manager.h |  19 +++
 9 files changed, 430 insertions(+), 4 deletions(-)

-- 
2.29.2.729.g45daf8777d-goog


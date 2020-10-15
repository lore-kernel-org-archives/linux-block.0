Return-Path: <SRS0=w0su=DW=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.4 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9AF9DC433DF
	for <linux-block@archiver.kernel.org>; Thu, 15 Oct 2020 21:46:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3B0BB20776
	for <linux-block@archiver.kernel.org>; Thu, 15 Oct 2020 21:46:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="t1sJFz8y"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731445AbgJOVqn (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 15 Oct 2020 17:46:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731433AbgJOVqn (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 15 Oct 2020 17:46:43 -0400
Received: from mail-qv1-xf49.google.com (mail-qv1-xf49.google.com [IPv6:2607:f8b0:4864:20::f49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28208C0613CF
        for <linux-block@vger.kernel.org>; Thu, 15 Oct 2020 14:46:39 -0700 (PDT)
Received: by mail-qv1-xf49.google.com with SMTP id z9so291237qvo.20
        for <linux-block@vger.kernel.org>; Thu, 15 Oct 2020 14:46:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:message-id:mime-version:subject:from:to:cc;
        bh=uzsgrDVDbNo3+n6dFdimxZArMaCeWbOw2YwQOWztNSM=;
        b=t1sJFz8ys2DRh9n3Pw3w8furr+PJFykl29nwiVDCtMxBmc1fD9i/ZtkVes8Jd/wDdy
         7snwI+aF2tRRwi2JzUon9MMib3MFqChFBXaXIxqSax53dOqem+dVDR5zwJ+OvIncIl1w
         tTqlz/W1yzenL1/Q2BMhsrI6DM6NerIV6D93UPBxlqmDXv4OnORy1ALo0GObtlAHOKB5
         7VTELnPMllj+bjnBAcCNdxD4q2EkcHi/Btj9FNrcfiSy9YwQglohZJKME41OX3DocI8S
         5F9TAv4de78oYXmYyunKFt5rOXPYJ16vCycWzhScOpI9CijlO+Ov4qR0/UrQInOIxN8e
         4Wjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:message-id:mime-version:subject:from
         :to:cc;
        bh=uzsgrDVDbNo3+n6dFdimxZArMaCeWbOw2YwQOWztNSM=;
        b=LRR1scOh9VJT65GYBa7ZsIIbXLKDXXS9ujBn8aFMw1j9IWR2XCidqLVqfmJTWr0We5
         UE+RR173/9aUpjbDsWBt0fDn3aRxRX4+TxKEKjY5OweUGYGgZtU/0iqmuYkKNccX9L0O
         RMgTjZu+KAIXQOo9gIL0ZIuC0uXKPKp5X1dWwwjv55SKN3H1ZY9rAvGfEaiDWXSYCrRS
         MJrX5s7CltTD9miTg37FUs63i+eNa31nE6tmgxLCQpRuCJpjtR4X7ldg2v3fHhTZaBJT
         qNNNRnuVZPudIvy/Ah/gP8RMuZE3JJgcYpzxGeJbyGQVS+FkQkSmxli3ExdZwXfL691Q
         9xNw==
X-Gm-Message-State: AOAM531GnSfSx/JBGpaj8jI5ZHp/Lf0Fl23UOUGtjbdJ0rv7MzQmxvnS
        oDPQwFtWMyudUz/RN+CUelEpLhHMoZEXyhautbmXbga2hniUFWO0AKAXHYR4cr0HZr7OMzvDTmP
        lNrbSBmIA1OPcXUzAaZrOhKlgoAetrUJwMsEwPOD5xdVFAeGInzlDzgdhm9r5AGxvCQUb
X-Google-Smtp-Source: ABdhPJwLbfh++KCbzPsp2mTaTGcm34JYSxlvF9jqR4gBntK5n7lNk83rZbBSf8MfpDEu8jjFtOqheno9XAw=
Sender: "satyat via sendgmr" <satyat@satyaprateek.c.googlers.com>
X-Received: from satyaprateek.c.googlers.com ([fda3:e722:ac3:10:24:72f4:c0a8:1092])
 (user=satyat job=sendgmr) by 2002:ad4:46a8:: with SMTP id br8mr852724qvb.24.1602798398042;
 Thu, 15 Oct 2020 14:46:38 -0700 (PDT)
Date:   Thu, 15 Oct 2020 21:46:28 +0000
Message-Id: <20201015214632.41951-1-satyat@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.29.0.rc1.297.gfa9743e501-goog
Subject: [PATCH v2 0/4] add support for inline encryption to device mapper
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

Patch 2 introduces a private field to struct blk_keyslot_manager that
owners of the struct can use for any purpose. The struct
blk_keyslot_manager has been embedded within other structures directly
(like in struct ufs_hba in drivers/scsi/ufs/ufshcd.h), but we don't
want to do that with struct mapped_device. So, the device mapper patches
later in this series use the private field to hold a pointer to the
associated struct mapped_device, since we can't use container_of() anymore.

Patch 3 introduces the changes for inline encryption support for the device
mapper. A DM device only exposes the intersection of the crypto
capabilities of its underlying devices. This is so that in case a bio with
an encryption context is eventually mapped to an underlying device that
doesn't support that encryption context, the blk-crypto-fallback's cipher
tfms are allocated ahead of time by the call to blk_crypto_start_using_key.

Each DM target can now also specify that it "may_passthrough_inline_crypto"
to opt-in to supporting passing through the underlying inline encryption
capabilities.  This flag is needed because it doesn't make much semantic
sense for certain targets like dm-crypt to expose the underlying inline
encryption capabilities to the upper layers. Again, the DM exposes inline
encryption capabilities of the underlying devices only if all of them
opt-in to passing through inline encryption support.

A DM device's keyslot manager is set up whenever a new table is swapped in.
This patch only allows the keyslot manager's capabilities to *expand*
because of table changes. Any attempts to load a new table that would cause
crypto capabilities to be dropped are rejected. The crypto capabilities of
a new table are also verified when the table is loaded (and the load is
rejected if crypto capabilities will be dropped because of the new table),
but the keyslot manager for the DM device is only modified when the table
is actually swapped in.

This patch also only exposes the intersection of the underlying
device's capabilities, which has the effect of causing en/decryption of a
bio to fall back to the kernel crypto API (if the fallback is enabled)
whenever any of the underlying devices doesn't support the encryption
context of the bio - it might be possible to make the bio only fall back to
the kernel crypto API if the bio's target underlying device doesn't support
the bio's encryption context, but the use case may be uncommon enough in
the first place not to warrant worrying about it right now.

Patch 4 makes some DM targets opt-in to passing through inline encryption
support. It does not (yet) try to enable this option with dm-raid, since
users can "hot add" disks to a raid device, which makes this not completely
straightforward (we'll need to ensure that any "hot added" disks must have
a superset of the inline encryption capabilities of the rest of the disks
in the raid device, due to the way Patch 2 of this series works).

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
   This patch now relies on just directly setting up the keyslot manager
   in the request queue, since each DM device is tied to only 1 queue.

Satya Tangirala (4):
  block: keyslot-manager: Introduce passthrough keyslot manager
  block: add private field to struct keyslot_manager
  dm: add support for passing through inline crypto support
  dm: enable may_passthrough_inline_crypto on some targets

 block/blk-crypto.c              |   1 +
 block/keyslot-manager.c         | 130 +++++++++++++++++++
 drivers/md/dm-flakey.c          |   1 +
 drivers/md/dm-ioctl.c           |   8 ++
 drivers/md/dm-linear.c          |   1 +
 drivers/md/dm.c                 | 217 +++++++++++++++++++++++++++++++-
 drivers/md/dm.h                 |  19 +++
 include/linux/device-mapper.h   |   6 +
 include/linux/keyslot-manager.h |  22 ++++
 9 files changed, 404 insertions(+), 1 deletion(-)

-- 
2.29.0.rc1.297.gfa9743e501-goog


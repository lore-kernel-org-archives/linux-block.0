Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-22.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F2EAC433E0
	for <linux-block@archiver.kernel.org>; Thu, 18 Feb 2021 01:55:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EA3B360230
	for <linux-block@archiver.kernel.org>; Thu, 18 Feb 2021 01:55:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229752AbhBRBzR (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 17 Feb 2021 20:55:17 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:58118 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229746AbhBRBzR (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 17 Feb 2021 20:55:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1613613230;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type;
        bh=iCoEeEIKmDrxs9ISbQPCTZm74FvyiA8ItKoBLLOVBV0=;
        b=JtwEFhAf61epA4G2G/c7PMB3JaY1HjRD236TpasWiaoe+kqH5U0T5QvyB0SNw8qzBF0HVw
        fdzdhsthneDYqkCXKLAV0U1qgC30ErVq88tuzWb8gxovvkbpUR2NqEpxz3qND0R/Cq8rwZ
        uWqAFxq2WOStpJk17G9JV8sq2Xo7yb0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-375-Y2JvxOFSMCCXyBr3WfAmDQ-1; Wed, 17 Feb 2021 20:53:48 -0500
X-MC-Unique: Y2JvxOFSMCCXyBr3WfAmDQ-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 7502F8030BB;
        Thu, 18 Feb 2021 01:53:45 +0000 (UTC)
Received: from localhost (unknown [10.18.25.174])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 5A0FF10074FC;
        Thu, 18 Feb 2021 01:53:38 +0000 (UTC)
Date:   Wed, 17 Feb 2021 20:53:37 -0500
From:   Mike Snitzer <snitzer@redhat.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     dm-devel@redhat.com, linux-block@vger.kernel.org,
        Alasdair G Kergon <agk@redhat.com>,
        Ahmad Fatoum <a.fatoum@pengutronix.de>,
        Colin Ian King <colin.king@canonical.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Jeffle Xu <jefflexu@linux.alibaba.com>,
        Jinoh Kang <jinoh.kang.kr@gmail.com>,
        Mike Snitzer <snitzer@redhat.com>,
        Mikulas Patocka <mpatocka@redhat.com>,
        Nikos Tsironis <ntsironis@arrikto.com>,
        Satya Tangirala <satyat@google.com>,
        Tian Tao <tiantao6@hisilicon.com>, Tom Rix <trix@redhat.com>
Subject: [git pull] device mapper changes for 5.12
Message-ID: <20210218015337.GA19999@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi Linus,

These DM changes happen to be based on linux-block from a few weeks ago
(but an expected DM dependency on block turned out to not be needed). 
And the few block/keyslot-manager changes are accompanied by Jens'
Acked-by.

The following changes since commit 8358c28a5d44bf0223a55a2334086c3707bb4185:

  block: fix memory leak of bvec (2021-02-02 08:57:56 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/device-mapper/linux-dm.git tags/for-5.12/dm-changes

for you to fetch changes up to a666e5c05e7c4aaabb2c5d58117b0946803d03d2:

  dm: fix deadlock when swapping to encrypted device (2021-02-11 09:45:28 -0500)

Please pull, thanks.
Mike

----------------------------------------------------------------
- Fix DM integrity's HMAC support to provide enhanced security of
  internal_hash and journal_mac capabilities.

- Various DM writecache fixes to address performance, fix table output
  to match what was provided at table creation, fix writing beyond end
  of device when shrinking underlying data device, and a couple other
  small cleanups.

- Add DM crypt support for using trusted keys.

- Fix deadlock when swapping to DM crypt device by throttling number
  of in-flight REQ_SWAP bios. Implemented in DM core so that other
  bio-based targets can opt-in by setting ti->limit_swap_bios.

- Fix various inverted logic bugs in the .iterate_devices callout
  functions that are used to assess if specific feature or capability
  is supported across all devices being combined/stacked by DM.

- Fix DM era target bugs that exposed users to lost writes or memory
  leaks.

- Add DM core support for passing through inline crypto support of
  underlying devices. Includes block/keyslot-manager changes that
  enable extending this support to DM.

- Various small fixes and cleanups (spelling fixes, front padding
  calculation cleanup, cleanup conditional zoned support in targets,
  etc).

----------------------------------------------------------------
Ahmad Fatoum (2):
      dm crypt: replaced #if defined with IS_ENABLED
      dm crypt: support using trusted keys

Colin Ian King (1):
      dm integrity: fix spelling mistake "flusing" -> "flushing"

Geert Uytterhoeven (1):
      dm crypt: Spelling s/cihper/cipher/

Jeffle Xu (5):
      dm: cleanup of front padding calculation
      dm table: fix iterate_devices based device capability checks
      dm table: fix DAX iterate_devices based device capability checks
      dm table: fix zoned iterate_devices based device capability checks
      dm table: remove needless request_queue NULL pointer checks

Jinoh Kang (1):
      dm persistent data: fix return type of shadow_root()

Mike Snitzer (2):
      dm writecache: use bdev_nr_sectors() instead of open-coded equivalent
      dm: simplify target code conditional on CONFIG_BLK_DEV_ZONED

Mikulas Patocka (5):
      dm integrity: introduce the "fix_hmac" argument
      dm writecache: fix performance degradation in ssd mode
      dm writecache: return the exact table values that were set
      dm writecache: fix writing beyond end of underlying device when shrinking
      dm: fix deadlock when swapping to encrypted device

Nikos Tsironis (7):
      dm era: Recover committed writeset after crash
      dm era: Update in-core bitset after committing the metadata
      dm era: Reinitialize bitset cache before digesting a new writeset
      dm era: Verify the data block size hasn't changed
      dm era: Fix bitset memory leaks
      dm era: Use correct value size in equality function of writeset tree
      dm era: only resize metadata in preresume

Satya Tangirala (5):
      block/keyslot-manager: Introduce passthrough keyslot manager
      block/keyslot-manager: Introduce functions for device mapper support
      dm: add support for passing through inline crypto support
      dm: support key eviction from keyslot managers of underlying devices
      dm: set DM_TARGET_PASSES_CRYPTO feature for some targets

Tian Tao (1):
      dm writecache: fix unnecessary NULL check warnings

Tom Rix (1):
      dm dust: remove h from printk format specifier

 .../admin-guide/device-mapper/dm-crypt.rst         |   2 +-
 .../admin-guide/device-mapper/dm-integrity.rst     |  11 +
 block/blk-crypto.c                                 |   1 +
 block/keyslot-manager.c                            | 146 ++++++++
 drivers/md/Kconfig                                 |   1 +
 drivers/md/dm-core.h                               |   9 +
 drivers/md/dm-crypt.c                              |  39 +-
 drivers/md/dm-dust.c                               |   2 +-
 drivers/md/dm-era-target.c                         |  93 +++--
 drivers/md/dm-flakey.c                             |   6 +-
 drivers/md/dm-integrity.c                          | 140 +++++++-
 drivers/md/dm-linear.c                             |   8 +-
 drivers/md/dm-table.c                              | 399 +++++++++++++++------
 drivers/md/dm-writecache.c                         |  80 +++--
 drivers/md/dm.c                                    |  96 ++++-
 drivers/md/dm.h                                    |   2 +-
 drivers/md/persistent-data/dm-btree-internal.h     |   2 +-
 drivers/md/persistent-data/dm-btree-spine.c        |   2 +-
 include/linux/device-mapper.h                      |  32 +-
 include/linux/keyslot-manager.h                    |  11 +
 include/uapi/linux/dm-ioctl.h                      |   4 +-
 21 files changed, 868 insertions(+), 218 deletions(-)


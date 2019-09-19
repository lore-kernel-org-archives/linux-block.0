Return-Path: <SRS0=Rcc/=XO=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.3 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77624C3A5A6
	for <linux-block@archiver.kernel.org>; Thu, 19 Sep 2019 21:19:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5223B21927
	for <linux-block@archiver.kernel.org>; Thu, 19 Sep 2019 21:19:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389709AbfISVTd (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 19 Sep 2019 17:19:33 -0400
Received: from mx1.redhat.com ([209.132.183.28]:56670 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389707AbfISVTd (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Thu, 19 Sep 2019 17:19:33 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 743CAC04AC69;
        Thu, 19 Sep 2019 21:19:32 +0000 (UTC)
Received: from localhost (unknown [10.18.25.174])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 12D2A60C18;
        Thu, 19 Sep 2019 21:19:25 +0000 (UTC)
Date:   Thu, 19 Sep 2019 17:19:24 -0400
From:   Mike Snitzer <snitzer@redhat.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     dm-devel@redhat.com, linux-block@vger.kernel.org,
        Alasdair G Kergon <agk@redhat.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        Huaisheng Ye <yehs1@lenovo.com>,
        Jaskaran Khurana <jaskarankhurana@linux.microsoft.com>,
        Mikulas Patocka <mpatocka@redhat.com>,
        Ming Lei <ming.lei@redhat.com>,
        Nikos Tsironis <ntsironis@arrikto.com>,
        ZhangXiaoxu <zhangxiaoxu5@huawei.com>,
        Herbert Xu <herbert@gondor.apana.org.au>
Subject: [git pull] device mapper changes for 5.4
Message-ID: <20190919211923.GA16508@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.31]); Thu, 19 Sep 2019 21:19:32 +0000 (UTC)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi Linus,

The following changes since commit 1cfd5d3399e87167b7f9157ef99daa0e959f395d:

  dm table: fix invalid memory accesses with too high sector number (2019-08-23 10:11:42 -0400)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/device-mapper/linux-dm.git tags/for-5.4/dm-changes

for you to fetch changes up to afa179eb603847494aa5061d4f501224a30dd187:

  dm: introduce DM_GET_TARGET_VERSION (2019-09-16 10:18:01 -0400)

Please pull, thanks!
Mike

----------------------------------------------------------------
- crypto and DM crypt advances that allow the crypto API to reclaim
  implementation details that do not belong in DM crypt.  The wrapper
  template for ESSIV generation that was factored out will also be used
  by fscrypt in the future.

- Add root hash pkcs#7 signature verification to the DM verity target.

- Add a new "clone" DM target that allows for efficient remote
  replication of a device.

- Enhance DM bufio's cache to be tailored to each client based on use.
  Clients that make heavy use of the cache get more of it, and those
  that use less have reduced cache usage.

- Add a new DM_GET_TARGET_VERSION ioctl to allow userspace to query the
  version number of a DM target (even if the associated module isn't yet
  loaded).

- Fix invalid memory access in DM zoned target.

- Fix the max_discard_sectors limit advertised by the DM raid target; it
  was mistakenly storing the limit in bytes rather than sectors.

- Small optimizations and cleanups in DM writecache target.

- Various fixes and cleanups in DM core, DM raid1 and space map portion
  of DM persistent data library.

----------------------------------------------------------------
Ard Biesheuvel (4):
      dm crypt: reuse eboiv skcipher for IV generation
      crypto: essiv - create wrapper template for ESSIV generation
      dm crypt: switch to ESSIV crypto API template
      dm crypt: omit parsing of the encapsulated cipher

Gustavo A. R. Silva (2):
      dm raid1: use struct_size() with kzalloc()
      dm stats: use struct_size() helper

Huaisheng Ye (4):
      dm writecache: remove unused member pointer in writeback_struct
      dm writecache: add unlikely for getting two block with same LBA
      dm writecache: optimize performance by sorting the blocks for writeback_all
      dm writecache: skip writecache_wait for pmem mode

Jaskaran Khurana (1):
      dm verity: add root hash pkcs#7 signature verification

Mikulas Patocka (8):
      dm: make dm_table_find_target return NULL
      dm zoned: fix invalid memory access
      dm bufio: call adjust_total_allocated from __link_buffer and __unlink_buffer
      dm bufio: refactor adjust_total_allocated
      dm bufio: introduce a global queue
      dm bufio: remove old-style buffer cleanup
      dm bufio: introduce a global cache replacement
      dm: introduce DM_GET_TARGET_VERSION

Ming Lei (1):
      dm raid: fix updating of max_discard_sectors limit

Nikos Tsironis (1):
      dm: add clone target

ZhangXiaoxu (1):
      dm space map common: remove check for impossible sm_find_free() return value

 .../admin-guide/device-mapper/dm-clone.rst         |  333 +++
 Documentation/admin-guide/device-mapper/verity.rst |    7 +
 crypto/Kconfig                                     |   28 +
 crypto/Makefile                                    |    1 +
 crypto/essiv.c                                     |  663 ++++++
 drivers/md/Kconfig                                 |   27 +
 drivers/md/Makefile                                |    6 +
 drivers/md/dm-bufio.c                              |  192 +-
 drivers/md/dm-clone-metadata.c                     |  964 +++++++++
 drivers/md/dm-clone-metadata.h                     |  158 ++
 drivers/md/dm-clone-target.c                       | 2191 ++++++++++++++++++++
 drivers/md/dm-crypt.c                              |  341 +--
 drivers/md/dm-ioctl.c                              |   34 +-
 drivers/md/dm-raid.c                               |   10 +-
 drivers/md/dm-raid1.c                              |    7 +-
 drivers/md/dm-stats.c                              |    2 +-
 drivers/md/dm-table.c                              |    8 +-
 drivers/md/dm-verity-target.c                      |   43 +-
 drivers/md/dm-verity-verify-sig.c                  |  133 ++
 drivers/md/dm-verity-verify-sig.h                  |   60 +
 drivers/md/dm-verity.h                             |    2 +
 drivers/md/dm-writecache.c                         |   27 +-
 drivers/md/dm-zoned-target.c                       |    2 -
 drivers/md/dm.c                                    |    8 +-
 drivers/md/dm.h                                    |    5 -
 drivers/md/persistent-data/dm-space-map-common.c   |    4 -
 include/uapi/linux/dm-ioctl.h                      |    6 +-
 27 files changed, 4864 insertions(+), 398 deletions(-)
 create mode 100644 Documentation/admin-guide/device-mapper/dm-clone.rst
 create mode 100644 crypto/essiv.c
 create mode 100644 drivers/md/dm-clone-metadata.c
 create mode 100644 drivers/md/dm-clone-metadata.h
 create mode 100644 drivers/md/dm-clone-target.c
 create mode 100644 drivers/md/dm-verity-verify-sig.c
 create mode 100644 drivers/md/dm-verity-verify-sig.h

Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mx1.mpynet.fi ([82.197.21.84]:47356 "EHLO mx1.mpynet.fi"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751005AbdJANWT (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Sun, 1 Oct 2017 09:22:19 -0400
Date: Sun, 1 Oct 2017 16:22:17 +0300
From: Rakesh Pandit <rakesh@tuxera.com>
To: Matias =?iso-8859-1?Q?Bj=F8rling?= <mb@lightnvm.io>,
        <linux-block@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: Javier =?iso-8859-1?Q?Gonz=E1lez?= <jg@lightnvm.io>
Subject: [PATCH 0/6] misc cleanups and error path fixes
Message-ID: <20171001132216.GA5456@hercules.tuxera.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

For 4.15.

These are last set of cleanups, error path fixes most likely and also
some memory leak.  Also removes stale symbols from lightnvm.h.  In
addition remove exported symbols which are no where used (except
locally in core).

Everything is based on top of:
https://github.com/OpenChannelSSD/linux branch for-4.15/pblk

So, they can be queued on top of patches already submitted earlier for
4.15.  Most of them are trivial found while reading algorithms used
during ALPSS yesterday or day before.

Rakesh Pandit (6):
  lightnvm: pblk: remove useless line
  lightnvm: pblk: reduce arguments in __pblk_rb_update_l2p
  lightnvm: remove unused argument from nvm_set_tgt_bb_tbl
  lightnvm: remove stable extern and unused exported symbols
  lightnvm: pblk: free up mempool allocation for erases correctly
  lightnvm: pblk: fix releases of kmem cache in error path

 drivers/lightnvm/core.c      | 138 +++++++++++++++++++++----------------------
 drivers/lightnvm/pblk-core.c |   1 -
 drivers/lightnvm/pblk-init.c |  24 +++++++-
 drivers/lightnvm/pblk-rb.c   |  12 ++--
 drivers/lightnvm/pblk.h      |   1 +
 include/linux/lightnvm.h     |   7 ---
 6 files changed, 94 insertions(+), 89 deletions(-)

-- 
2.7.4

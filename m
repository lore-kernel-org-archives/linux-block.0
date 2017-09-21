Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mx2.mpynet.fi ([82.197.21.85]:10677 "EHLO mx2.mpynet.fi"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751629AbdIULZG (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Thu, 21 Sep 2017 07:25:06 -0400
Date: Thu, 21 Sep 2017 14:25:04 +0300
From: Rakesh Pandit <rakesh@tuxera.com>
To: Matias =?iso-8859-1?Q?Bj=F8rling?= <mb@lightnvm.io>,
        <linux-block@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: Javier =?iso-8859-1?Q?Gonz=E1lez?= <jg@lightnvm.io>
Subject: [PATCH 0/6] misc patches mostly for pblk
Message-ID: <20170921112502.GA28488@dhcp-216.srv.tuxera.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

These are trivial changes up for review.  Most of them I made while
skimming through the code base.  They are mostly cleanups and they are
at random places.

Rakesh Pandit (6):
  lightnvm: pblk: reuse pblk_gc_should_kick
  lightnvm: pblk: protect line bitmap while submitting meta io
  lightnvm: pblk: fix message if L2P MAP is in device
  lightnvm: pblk: improve error message if down_timeout fails
  lightnvm: pblk: print incompatible line version correctly
  lightnvm: include NVM Express driver if OCSSD is selected for build

 drivers/lightnvm/Kconfig         |  1 +
 drivers/lightnvm/pblk-core.c     | 17 ++++++-----------
 drivers/lightnvm/pblk-init.c     |  2 +-
 drivers/lightnvm/pblk-recovery.c |  4 ++--
 drivers/lightnvm/pblk-rl.c       |  9 ---------
 drivers/lightnvm/pblk.h          |  1 +
 6 files changed, 11 insertions(+), 23 deletions(-)

-- 
2.5.0

Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-wm0-f49.google.com ([74.125.82.49]:34942 "EHLO
	mail-wm0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756458AbcGGHye (ORCPT
	<rfc822;linux-block@vger.kernel.org>); Thu, 7 Jul 2016 03:54:34 -0400
Received: by mail-wm0-f49.google.com with SMTP id z126so137768658wme.0
        for <linux-block@vger.kernel.org>; Thu, 07 Jul 2016 00:54:33 -0700 (PDT)
From: =?UTF-8?q?Matias=20Bj=C3=B8rling?= <m@bjorling.me>
To: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
	axboe@fb.com
Cc: =?UTF-8?q?Matias=20Bj=C3=B8rling?= <m@bjorling.me>
Subject: [GIT PULL 00/17] LightNVM pull request for 4.8
Date: Thu,  7 Jul 2016 09:54:06 +0200
Message-Id: <1467878063-22919-1-git-send-email-m@bjorling.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

Hi Jens,

Please pick up the following patches.

Nothing major. A couple of bigger pieces are being prepared. Notably
pblk target, sysfs support and persistent block information.

The patches are also available from here:

  https://github.com/OpenChannelSSD/linux.git for-jens

Thank you,
Matias

Javier González (2):
  lightnvm: add media manager mark_blk helper
  lightnvm: initialize ppa_addr in dev_to_generic_addr()

Johannes Thumshirn (2):
  nvme: lightnvm: make MLC num_pairs little endian
  lightnvm: Make functions not used by ouside static

Matias Bjørling (12):
  lightnvm: remove checkpatch warning for unsigned ints
  lightnvm: fix checkpatch terse errors
  lightnvm: remove open/close statistics for gennvm
  lightnvm: rename gennvm and update description
  lightnvm: move target mgmt into media mgr
  lightnvm: remove nested lock conflict with mm
  lightnvm: remove unused lists from struct rrpc_block
  lightnvm: remove _unlocked variant of [get/put]_blk
  lightnvm: make rrpc_map_page call nvm_get_blk outside locks
  lightnvm: fix lun offset calculation for mark blk
  lightnvm: make ppa_list const in nvm_set_rqd_list
  lightnvm: make __nvm_submit_ppa static

Wenwei Tao (1):
  lightnvm: break the loop when rqd is not null

 drivers/lightnvm/Kconfig     |  10 +-
 drivers/lightnvm/core.c      | 242 +++++++--------------------
 drivers/lightnvm/gennvm.c    | 385 ++++++++++++++++++++++++++++---------------
 drivers/lightnvm/gennvm.h    |  10 +-
 drivers/lightnvm/rrpc.c      | 145 ++++++++--------
 drivers/lightnvm/rrpc.h      |  13 +-
 drivers/lightnvm/sysblk.c    |   8 +-
 drivers/nvme/host/lightnvm.c |   2 +-
 include/linux/lightnvm.h     |  36 ++--
 9 files changed, 420 insertions(+), 431 deletions(-)

-- 
2.1.4


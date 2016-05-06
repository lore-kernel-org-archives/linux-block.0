Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-wm0-f47.google.com ([74.125.82.47]:36373 "EHLO
	mail-wm0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755867AbcEFSDf (ORCPT
	<rfc822;linux-block@vger.kernel.org>); Fri, 6 May 2016 14:03:35 -0400
Received: by mail-wm0-f47.google.com with SMTP id n129so67100199wmn.1
        for <linux-block@vger.kernel.org>; Fri, 06 May 2016 11:03:34 -0700 (PDT)
From: =?UTF-8?q?Matias=20Bj=C3=B8rling?= <m@bjorling.me>
To: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
	axboe@fb.com
Cc: =?UTF-8?q?Matias=20Bj=C3=B8rling?= <m@bjorling.me>
Subject: [PATCH 00/28] LightNVM fixes for 4.7
Date: Fri,  6 May 2016 20:02:53 +0200
Message-Id: <1462557801-24974-1-git-send-email-m@bjorling.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

Hi Jens,

A collection of fixes and features destined for 4.7. They contain:

  Fixes all over the place from Arnd, Jeff, Sagi, Wenwei, Javier and me.

  Preparation patches from Simon to enable sysfs support. The final
  patch is delayed to 4.8. We need to integrate it correctly with
  device drivers.

  A patch from Javier to allow a target to access the metadata field.
  Typically it maps to the flash page out of band area.

  Preparation patches for pblk and persistent block management
  information from me.

Please pick up.

-Matias

Arnd Bergmann (1):
  lightnvm: pass dma address to hardware rather than pointer

Javier González (6):
  lightnvm: do not free unused metadata on rrpc
  lightnvm: enable metadata to be sent to device
  lightnvm: rename dma helper functions
  lightnvm: do not assume sequential lun alloc.
  lightnvm: rename nr_pages to nr_ppas on nvm_rq
  lightnvm: reserved space calculation incorrect

Jeff Mahoney (1):
  lightnvm: fix "warning: ‘ret’ may be used uninitialized"

Matias Bjørling (15):
  lightnvm: handle submit_io failure
  lightnvm: implement nvm_submit_ppa_list
  lightnvm: add fpg_size and pfpg_size to struct nvm_dev
  lightnvm: move block fold outside of get_bb_tbl()
  lightnvm: avoid memory leak when lun_map kcalloc fails
  lightnvm: introduce nvm_for_each_lun_ppa() macro
  lightnvm: refactor device ops->get_bb_tbl()
  lightnvm: remove struct factory_blks
  lightnvm: make nvm_set_rqd_ppalist() aware of vblks
  lightnvm: move responsibility for bad blk mgmt to target
  lightnvm: refactor set_bb_tbl for accepting ppa list
  lightnvm: fix out of bound ppa lun id on bb tbl
  lightnvm: remove mgt targets on mgt removal
  lightnvm: expose gennvm_mark_blk to targets
  lightnvm: add is_cached entry to struct ppa_addr

Sagi Grimberg (1):
  nvme/lightnvm: Log using the ctrl named device

Simon A. F. Lund (2):
  lightnvm: rename nvm_targets to nvm_tgt_type
  lightnvm: refactor dev->online_target to global nvm_targets

Wenwei Tao (2):
  lightnvm: calculate rrpc total blocks and sectors up front
  lightnvm: store rrpc->soffset in device sector size

 drivers/lightnvm/core.c      | 370 +++++++++++++++++++++++++++++--------------
 drivers/lightnvm/gennvm.c    | 100 ++++++------
 drivers/lightnvm/rrpc.c      |  42 +++--
 drivers/lightnvm/rrpc.h      |   2 +-
 drivers/lightnvm/sysblk.c    | 276 ++++++++++++++++----------------
 drivers/nvme/host/lightnvm.c |  82 +++-------
 include/linux/lightnvm.h     |  48 ++++--
 7 files changed, 521 insertions(+), 399 deletions(-)

-- 
2.1.4


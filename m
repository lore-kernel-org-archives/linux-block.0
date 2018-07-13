Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-pg1-f194.google.com ([209.85.215.194]:43462 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726202AbeGMJCr (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 13 Jul 2018 05:02:47 -0400
Received: by mail-pg1-f194.google.com with SMTP id v13-v6so4788852pgr.10
        for <linux-block@vger.kernel.org>; Fri, 13 Jul 2018 01:49:08 -0700 (PDT)
From: =?UTF-8?q?Matias=20Bj=C3=B8rling?= <mb@lightnvm.io>
To: axboe@fb.com
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        bart.vanassche@wdc.com, hans.holmberg@cnexlabs.com,
        javier@cnexlabs.com, hlitz@ucsc.edu, igor.j.konopko@intel.com,
        marcin.dziegielewski@intel.com,
        =?UTF-8?q?Matias=20Bj=C3=B8rling?= <mb@lightnvm.io>
Subject: [GIT PULL 00/10] lightnvm updates for 4.19
Date: Fri, 13 Jul 2018 10:48:35 +0200
Message-Id: <20180713084845.19511-1-mb@lightnvm.io>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

Hi Jens,

Please pick up the following patches for 4.19.

 - A couple of small fixes from Bart, Gustavo, Hans and me.
 - Heiner has reworked the read path to issue reads in parallel on
   partial reads.
 - Marcin fixed up the case where a device does need a host-side
   cache to provide reliability.
 - I added device description to error messages in pblk,
   moved the compile DEBUG option to be pblk only, and limited the
   report chunk command size.

Thanks, Matias

Bart Van Assche (1):
  lightnvm: Remove redundant rq->__data_len initialization

Gustavo A. R. Silva (1):
  lightnvm: pblk: mark expected switch fall-through

Hans Holmberg (1):
  lightnvm: pblk: assume that chunks are closed on 1.2 devices

Heiner Litz (1):
  lightnvm: pblk: add asynchronous partial read

Marcin Dziegielewski (1):
  lightnvm: pblk: handle case when mw_cunits equals to 0

Matias Bjørling (5):
  lightnvm: move NVM_DEBUG to pblk
  lightnvm: pblk: enable line minor version detection
  lightnvm: pblk: fix read_bitmap for 32bit archs
  lightnvm: limit get chunk meta request size
  lightnvm: pblk: expose generic disk name on pr_* msgs

 drivers/lightnvm/Kconfig         |  32 +++---
 drivers/lightnvm/pblk-cache.c    |   4 +-
 drivers/lightnvm/pblk-core.c     |  78 +++++++------
 drivers/lightnvm/pblk-gc.c       |  34 +++---
 drivers/lightnvm/pblk-init.c     | 102 +++++++++--------
 drivers/lightnvm/pblk-rb.c       |  24 ++--
 drivers/lightnvm/pblk-read.c     | 242 ++++++++++++++++++++++++---------------
 drivers/lightnvm/pblk-recovery.c |  47 ++++----
 drivers/lightnvm/pblk-sysfs.c    |  13 +--
 drivers/lightnvm/pblk-write.c    |  35 +++---
 drivers/lightnvm/pblk.h          |  48 +++++---
 drivers/nvme/host/lightnvm.c     |  16 ++-
 12 files changed, 382 insertions(+), 293 deletions(-)

-- 
2.11.0

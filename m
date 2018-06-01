Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-lf0-f68.google.com ([209.85.215.68]:44334 "EHLO
        mail-lf0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751068AbeFANEo (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Fri, 1 Jun 2018 09:04:44 -0400
Received: by mail-lf0-f68.google.com with SMTP id 36-v6so12791415lfr.11
        for <linux-block@vger.kernel.org>; Fri, 01 Jun 2018 06:04:43 -0700 (PDT)
From: =?UTF-8?q?Matias=20Bj=C3=B8rling?= <mb@lightnvm.io>
To: axboe@fb.com
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        javier@cnexlabs.com, igor.j.konopko@intel.com,
        marcin.dziegielewski@intel.com,
        =?UTF-8?q?Matias=20Bj=C3=B8rling?= <mb@lightnvm.io>
Subject: [GIT PULL v2 00/18] lightnvm updates for 4.18
Date: Fri,  1 Jun 2018 15:04:14 +0200
Message-Id: <20180601130432.30866-1-mb@lightnvm.io>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

Hi Jens,

Please pick up the following patches.

 - Hans reworked the write error recovery path in pblk.
 - Igor added extra error handling for lines, and fixed a bug in the
   pblk ringbuffer during GC.
 - Javier refactored the pblk code a bit, added extra error
   handling, and added checks to verify that data returned from drive
   is appropriate.
 - Marcin added some extra logic to manage the write buffer. Now
   MW_CUNITS can be zero and the size of write buffer can be changed
   at module load time.

Changes since v1:

 Removed
  lightnvm: pblk: sync RB and RL states during GC
  lightnvm: error handling when whole line is bad
  lightnvm: pblk: handle case when mw_cunits equals to 0

 Added
  lightnvm: pblk: remove unnecessary bio_get/put

Thanks,
Matias


Hans Holmberg (3):
  lightnvm: pblk: rework write error recovery path
  lightnvm: pblk: garbage collect lines with failed writes
  lightnvm: pblk: fix smeta write error path

Igor Konopko (2):
  lightnvm: proper error handling for pblk_bio_add_pages
  lightnvm: fix partial read error path

Javier González (12):
  lightnvm: pblk: fail gracefully on line alloc. failure
  lightnvm: pblk: recheck for bad lines at runtime
  lightnvm: pblk: check read lba on gc path
  lightnvn: pblk: improve error msg on corrupted LBAs
  lightnvm: pblk: warn in case of corrupted write buffer
  lightnvm: pblk: return NVM_ error on failed submission
  lightnvm: pblk: remove unnecessary indirection
  lightnvm: pblk: remove unnecessary argument
  lightnvm: pblk: check for chunk size before allocating it
  lightnvn: pass flag on graceful teardown to targets
  lightnvm: pblk: remove dead function
  lightnvm: pblk: remove unnecessary bio_get/put

Marcin Dziegielewski (1):
  lightnvm: pblk: add possibility to set write buffer size manually

 drivers/lightnvm/core.c          |  10 +-
 drivers/lightnvm/pblk-core.c     | 144 ++++++++++++++------
 drivers/lightnvm/pblk-gc.c       | 112 ++++++++++------
 drivers/lightnvm/pblk-init.c     | 100 +++++++++-----
 drivers/lightnvm/pblk-map.c      |  33 +++--
 drivers/lightnvm/pblk-rb.c       |  44 +-----
 drivers/lightnvm/pblk-read.c     | 144 ++++++++++++--------
 drivers/lightnvm/pblk-recovery.c |  91 -------------
 drivers/lightnvm/pblk-rl.c       |  29 +++-
 drivers/lightnvm/pblk-sysfs.c    |  15 ++-
 drivers/lightnvm/pblk-write.c    | 281 +++++++++++++++++++++++++--------------
 drivers/lightnvm/pblk.h          |  43 +++---
 include/linux/lightnvm.h         |   2 +-
 13 files changed, 611 insertions(+), 437 deletions(-)

-- 
2.11.0

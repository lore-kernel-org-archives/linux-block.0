Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-wm0-f53.google.com ([74.125.82.53]:35533 "EHLO
        mail-wm0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753267AbdIFKwg (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 6 Sep 2017 06:52:36 -0400
Received: by mail-wm0-f53.google.com with SMTP id f199so7943201wme.0
        for <linux-block@vger.kernel.org>; Wed, 06 Sep 2017 03:52:36 -0700 (PDT)
From: "=?UTF-8?q?Javier=20Gonz=C3=A1lez?=" <jg@lightnvm.io>
To: mb@lightnvm.io, axboe@fb.com
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        =?UTF-8?q?Javier=20Gonz=C3=A1lez?= <javier@cnexlabs.com>
Subject: [PATCH 00/18] lightnvm: pblk patches for 4.14
Date: Wed,  6 Sep 2017 12:50:53 +0200
Message-Id: <1504695071-25928-1-git-send-email-javier@cnexlabs.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

Hi Jens,

Here is the pblk patchset for this window.

The most notable patches are on the read path:
  - ("lightnvm: pblk: check lba sanity on read path") uses the lba
    stored on the out-of-bound area to verify that the read ppa
    corresponds to the lba pointed to by the read bio.
  - ("lightnvm: pblk: guarantee line integrity on reads") guarantees
    that if a line is being GC'ed and a read comes in the middle, that
    line is not being moved into the free list until the read completes.
    Otherwise, the line could be reclaimed to be erased and re-written,
    thus causing data corruption.

The rest of the patches are are basically bug fixes and refactoring to
improve code readability.

The patches apply on your for-4.14/block, and you can be found at:
  https://github.com/OpenChannelSSD/linux/tree/pblk.for-4.14

Thanks,
Javier

Javier González (18):
  lightnvm: pblk: improve naming for internal req.
  lightnvm: pblk: refactor read lba sanity check
  lightnvm: pblk: normalize ppa namings
  lightnvm: pblk: check for failed mempool alloc.
  lightnvm: pblk: initialize debug stat counter
  lightnvm: pblk: use right flag for GC allocation
  lightnvm: pblk: use constant for GC parameter
  lightnvm: pblk: check lba sanity on read path
  lightnvm: pblk: simplify data validity check on GC
  lightnvm: pblk: use bio_copy_kern when possible
  lightnvm: pblk: refactor read path on GC
  lightnvm: pblk: free padded entries in write buffer
  lightnvm: pblk: fix write I/O sync stat
  lightnvm: pblk: simplify path on REQ_PREFLUSH
  lightnvm: pblk: avoid deadlock on low LUN config
  lightnvm: pblk: enable 1 LUN configuration
  lightnvm: pblk: guarantee line integrity on reads
  lightnvm: pblk: remove unnecessary check

 drivers/lightnvm/pblk-cache.c    |  24 ++--
 drivers/lightnvm/pblk-core.c     | 187 ++++++++++++++++--------------
 drivers/lightnvm/pblk-gc.c       | 133 ++++++++++------------
 drivers/lightnvm/pblk-init.c     |  25 ++++-
 drivers/lightnvm/pblk-map.c      |  21 ++--
 drivers/lightnvm/pblk-rb.c       |  14 +--
 drivers/lightnvm/pblk-read.c     | 237 ++++++++++++++++++++++++++-------------
 drivers/lightnvm/pblk-recovery.c |   9 +-
 drivers/lightnvm/pblk-rl.c       |   6 +
 drivers/lightnvm/pblk-write.c    |  37 +++---
 drivers/lightnvm/pblk.h          |  40 +++----
 11 files changed, 423 insertions(+), 310 deletions(-)

-- 
2.7.4

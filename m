Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-pg0-f50.google.com ([74.125.83.50]:34621 "EHLO
        mail-pg0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752355AbdHVRdM (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 22 Aug 2017 13:33:12 -0400
Received: by mail-pg0-f50.google.com with SMTP id s14so13237331pgs.1
        for <linux-block@vger.kernel.org>; Tue, 22 Aug 2017 10:33:12 -0700 (PDT)
From: Omar Sandoval <osandov@osandov.com>
To: linux-block@vger.kernel.org
Cc: kernel-team@fb.com, Hannes Reinecke <hare@suse.de>,
        Ming Lei <ming.lei@redhat.com>, Karel Zak <kzak@redhat.com>,
        Milan Broz <gmazyland@gmail.com>
Subject: [PATCH v3 0/4] loop: LO_FLAGS_BLOCKSIZE fixes
Date: Tue, 22 Aug 2017 10:32:57 -0700
Message-Id: <cover.1503422996.git.osandov@fb.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

From: Omar Sandoval <osandov@fb.com>

Patches 1, 3, and 4 are the same as v2, plus added reviewed-bys and
tested-bys from Milan. Patch 2 is new.

Omar Sandoval (4):
  loop: fix hang if LOOP_SET_STATUS gets invalid blocksize or encrypt
    type
  loop: set discard and write zeroes limits in 512 byte sectors
  loop: use queue limit instead of private lo_logical_blocksize
  loop: always return block size in LOOP_GET_STATUS

 drivers/block/loop.c | 75 ++++++++++++++++++++++++++--------------------------
 drivers/block/loop.h |  1 -
 2 files changed, 37 insertions(+), 39 deletions(-)

-- 
2.14.1

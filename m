Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-pg0-f51.google.com ([74.125.83.51]:36937 "EHLO
        mail-pg0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750993AbdHRT1p (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 18 Aug 2017 15:27:45 -0400
Received: by mail-pg0-f51.google.com with SMTP id y129so70018811pgy.4
        for <linux-block@vger.kernel.org>; Fri, 18 Aug 2017 12:27:44 -0700 (PDT)
From: Omar Sandoval <osandov@osandov.com>
To: linux-block@vger.kernel.org
Cc: kernel-team@fb.com, Hannes Reinecke <hare@suse.de>,
        Ming Lei <ming.lei@redhat.com>, Karel Zak <kzak@redhat.com>
Subject: [PATCH v2 0/3] loop: LO_FLAGS_BLOCKSIZE fixes
Date: Fri, 18 Aug 2017 12:27:34 -0700
Message-Id: <cover.1503084216.git.osandov@fb.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

From: Omar Sandoval <osandov@fb.com>

Patches 1 and 3 are from the original series.

Patch 2 gets rid of the redundant struct loop_device.lo_logical_blocksize
in favor of using the queue's own logical_block_size. Karel, I decided
against adding another sysfs entry since it will always be the same as
queue/logical_block_size, is that alright with you?

Omar Sandoval (3):
  loop: fix hang if LOOP_SET_STATUS gets invalid blocksize or encrypt
    type
  loop: use queue limit instead of private lo_logical_blocksize
  loop: always return block size in LOOP_GET_STATUS

 drivers/block/loop.c | 71 ++++++++++++++++++++++++++--------------------------
 drivers/block/loop.h |  1 -
 2 files changed, 36 insertions(+), 36 deletions(-)

-- 
2.14.1

Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-wm0-f44.google.com ([74.125.82.44]:46721 "EHLO
        mail-wm0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751787AbdINKeQ (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 14 Sep 2017 06:34:16 -0400
Received: by mail-wm0-f44.google.com with SMTP id i189so10116230wmf.1
        for <linux-block@vger.kernel.org>; Thu, 14 Sep 2017 03:34:15 -0700 (PDT)
From: "=?UTF-8?q?Javier=20Gonz=C3=A1lez?=" <jg@lightnvm.io>
To: axboe@fb.com
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        =?UTF-8?q?Javier=20Gonz=C3=A1lez?= <javier@cnexlabs.com>
Subject: [PATCH 0/5] lightnvm: pblk: audit mempool usage
Date: Thu, 14 Sep 2017 12:33:42 +0200
Message-Id: <1505385227-28706-1-git-send-email-javier@cnexlabs.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

As suggested by Jens [1], I audited all mempools on pblk.

This patche series (i) fixes bad mempool allocations that did not
guarantee forward progress and downsizes the sizes of some overused
mempools, (ii) removes unnecessary checks, and (iii) eliminates some
mempools that where introduced in early versions of pblk.

[1] https://patchwork.kernel.org/patch/9940973/

Javier González (5):
  lightnvm: pblk: fix min size for page mempool
  lightnvm: pblk: simplify work_queue mempool
  lightnvm: pblk: decouple read/erase mempools
  lightnvm: pblk: do not use a mempool for line bitmaps
  lightnvm: pblk: remove checks on mempool alloc.

 drivers/lightnvm/pblk-core.c     | 61 ++++++++++----------------
 drivers/lightnvm/pblk-gc.c       | 32 +++++++-------
 drivers/lightnvm/pblk-init.c     | 94 +++++++++++++++++-----------------------
 drivers/lightnvm/pblk-read.c     | 10 +----
 drivers/lightnvm/pblk-recovery.c | 37 ++++------------
 drivers/lightnvm/pblk-write.c    | 32 ++++----------
 drivers/lightnvm/pblk.h          | 21 +++++----
 7 files changed, 106 insertions(+), 181 deletions(-)

-- 
2.7.4

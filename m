Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-wm0-f46.google.com ([74.125.82.46]:35014 "EHLO
        mail-wm0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932627AbdIFPBO (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 6 Sep 2017 11:01:14 -0400
Received: by mail-wm0-f46.google.com with SMTP id f199so10469239wme.0
        for <linux-block@vger.kernel.org>; Wed, 06 Sep 2017 08:01:14 -0700 (PDT)
From: "=?UTF-8?q?Javier=20Gonz=C3=A1lez?=" <jg@lightnvm.io>
To: mb@lightnvm.io, axboe@fb.com
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        =?UTF-8?q?Javier=20Gonz=C3=A1lez?= <javier@cnexlabs.com>
Subject: [PATCH 0/6] lightnvm: pblk bug fixes for 4.14
Date: Wed,  6 Sep 2017 17:01:00 +0200
Message-Id: <1504710066-4699-1-git-send-email-javier@cnexlabs.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

Hi Jens,

Here are the pblk bug fixes for this window.

The patches apply on your for-4.14/block, and you can be found at:
  https://github.com/OpenChannelSSD/linux/tree/pblk.for-4.14

Thanks,
Javier

Javier González (6):
  lightnvm: pblk: check for failed mempool alloc.
  lightnvm: pblk: initialize debug stat counter
  lightnvm: pblk: use right flag for GC allocation
  lightnvm: pblk: free padded entries in write buffer
  lightnvm: pblk: fix write I/O sync stat
  lightnvm: pblk: avoid deadlock on low LUN config

 drivers/lightnvm/pblk-core.c  |  5 ++++-
 drivers/lightnvm/pblk-init.c  |  3 ++-
 drivers/lightnvm/pblk-read.c  |  7 +++++--
 drivers/lightnvm/pblk-rl.c    |  6 ++++++
 drivers/lightnvm/pblk-write.c | 16 ++++++++++++----
 drivers/lightnvm/pblk.h       |  2 ++
 6 files changed, 31 insertions(+), 8 deletions(-)

-- 
2.7.4

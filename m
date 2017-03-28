Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-pg0-f50.google.com ([74.125.83.50]:33334 "EHLO
        mail-pg0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753889AbdC1G3s (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 28 Mar 2017 02:29:48 -0400
Received: by mail-pg0-f50.google.com with SMTP id n5so55445906pgh.0
        for <linux-block@vger.kernel.org>; Mon, 27 Mar 2017 23:29:47 -0700 (PDT)
From: Omar Sandoval <osandov@osandov.com>
To: Jens Axboe <axboe@fb.com>, Vivek Goyal <vgoyal@redhat.com>,
        linux-block@vger.kernel.org
Cc: kernel-team@fb.com
Subject: [PATCH 0/6] block: convert remaining drivers which share a request queue
Date: Mon, 27 Mar 2017 23:28:41 -0700
Message-Id: <cover.1490681910.git.osandov@fb.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

From: Omar Sandoval <osandov@fb.com>

This is clearly the pinnacle of my career: converting all remaining
block drivers which share a request queue across gendisks to use a
separate request queue per gendisk. These are all compile tested (but
the last two platform-specific ones involved hacking the Kconfig and
commenting out a bunch of arch-dependent code to get the rest to
compile), no runtime testing at all.

Let me know if I missed any. Even better, let me know if we can just
delete some of these entirely.

Thanks!

Omar Sandoval (6):
  hd: stop sharing request queue across multiple gendisks
  parport/pd: stop sharing request queue across multiple gendisks
  parport/pcd: stop sharing request queue across multiple gendisks
  parport/pf: stop sharing request queue across multiple gendisks
  swim: stop sharing request queue across multiple gendisks
  jsflash: stop sharing request queue across multiple gendisks

 drivers/block/hd.c          | 62 ++++++++++++++++++++++++++++-----------------
 drivers/block/paride/pcd.c  | 57 +++++++++++++++++++++++++++--------------
 drivers/block/paride/pd.c   | 50 ++++++++++++++++++++++++------------
 drivers/block/paride/pf.c   | 57 +++++++++++++++++++++++++++--------------
 drivers/block/swim.c        | 55 ++++++++++++++++++++++++++--------------
 drivers/sbus/char/jsflash.c | 50 ++++++++++++++++++++++++++----------
 6 files changed, 221 insertions(+), 110 deletions(-)

-- 
2.12.1

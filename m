Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-wr0-f176.google.com ([209.85.128.176]:32950 "EHLO
        mail-wr0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751034AbdGGTI6 (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Fri, 7 Jul 2017 15:08:58 -0400
Received: by mail-wr0-f176.google.com with SMTP id r103so59393198wrb.0
        for <linux-block@vger.kernel.org>; Fri, 07 Jul 2017 12:08:57 -0700 (PDT)
From: "=?UTF-8?q?Javier=20Gonz=C3=A1lez?=" <jg@lightnvm.io>
To: mb@lightnvm.io, axboe@fb.com
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        =?UTF-8?q?Javier=20Gonz=C3=A1lez?= <javier@cnexlabs.com>
Subject: [PATCH 0/2] LightNVM: Fixes for 4.13
Date: Fri,  7 Jul 2017 21:08:51 +0200
Message-Id: <1499454533-14907-1-git-send-email-javier@cnexlabs.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

Hi Jens,

I have 2 extra fixes for this window. One is for controlling write I/Os
when removing a pblk partition, otherwise, some controllers can be
overflowed. We do the same on the fast write path.

This should be the last fixes coming from our side.

They apply on top of your for-4.13/block and can be found at:
  https://github.com/OpenChannelSSD/linux pblk.for-4.13

Thanks,
Javier

Javier González (2):
  lightnvm: pblk: control I/O flow also on tear down
  lightnvm: pblk: remove unnecessary checks

 drivers/lightnvm/pblk-core.c     | 69 ++++++++++++++++++++++++++++++----------
 drivers/lightnvm/pblk-recovery.c | 31 ++++++++++++------
 drivers/lightnvm/pblk-write.c    | 26 +++++----------
 drivers/lightnvm/pblk.h          |  2 ++
 4 files changed, 83 insertions(+), 45 deletions(-)

-- 
2.7.4

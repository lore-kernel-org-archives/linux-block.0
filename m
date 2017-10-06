Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-wm0-f53.google.com ([74.125.82.53]:50505 "EHLO
        mail-wm0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752024AbdJFN0h (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Fri, 6 Oct 2017 09:26:37 -0400
Received: by mail-wm0-f53.google.com with SMTP id u138so7573717wmu.5
        for <linux-block@vger.kernel.org>; Fri, 06 Oct 2017 06:26:36 -0700 (PDT)
From: "=?UTF-8?q?Javier=20Gonz=C3=A1lez?=" <jg@lightnvm.io>
To: mb@lightnvm.io
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        =?UTF-8?q?Javier=20Gonz=C3=A1lez?= <javier@cnexlabs.com>
Subject: [PATCH 0/2] lightnvm: patches for 4.15 on core
Date: Fri,  6 Oct 2017 15:26:23 +0200
Message-Id: <1507296385-6045-1-git-send-email-javier@cnexlabs.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

These are 2 patches on the subsystem for 4.15.

The first one is a fix on the passtrhough path that enables fail fast,
just as it is done on standard nvme passtrough commands.

The second one implements a generic way to send sync. I/O from targets.
Trough time, we ended up having _many_ wait_for_completion()
constructions to implement sync. I/O, both on pblk and at the subsystem
level. One of the main issues - besides code replication - is that we
could not benefit from improvements on blk_execute_rq to prevent hangs.
This should fix it.

Javier González (2):
  lightnvm: fail fast on passthrough commands
  lightnvm: implement generic path for sync I/O

 drivers/lightnvm/core.c          | 25 ++++++++-----
 drivers/lightnvm/pblk-core.c     | 78 +++++++++++++---------------------------
 drivers/lightnvm/pblk-read.c     | 21 ++---------
 drivers/lightnvm/pblk-recovery.c | 31 ++--------------
 drivers/lightnvm/pblk.h          | 42 ++++++++++++++++++++--
 drivers/nvme/host/lightnvm.c     | 72 ++++++++++++++++++++++++++++---------
 include/linux/lightnvm.h         |  3 ++
 7 files changed, 145 insertions(+), 127 deletions(-)

-- 
2.7.4

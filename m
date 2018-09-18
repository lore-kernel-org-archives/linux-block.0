Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-ed1-f66.google.com ([209.85.208.66]:36535 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727202AbeIRNek (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 18 Sep 2018 09:34:40 -0400
Received: by mail-ed1-f66.google.com with SMTP id f4-v6so1119584edq.3
        for <linux-block@vger.kernel.org>; Tue, 18 Sep 2018 01:03:13 -0700 (PDT)
From: "=?UTF-8?q?Javier=20Gonz=C3=A1lez?=" <javier@javigon.com>
To: mb@lightnvm.io
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        =?UTF-8?q?Javier=20Gonz=C3=A1lez?= <javier@cnexlabs.com>
Subject: [PATCH 0/4] lightnvm: pblk: fixes for read buffer
Date: Tue, 18 Sep 2018 10:03:01 +0200
Message-Id: <1537257785-31630-1-git-send-email-javier@cnexlabs.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

This patchet's main motivation is to account for a corner case in which
the read constrains imposed by the device are not respected by pblk. In
the process, it also refactors parts of the read ring buffer to simplify
creation/deletion operations and improve readability.

Note that the checkpatch warnings on missing comments for memory
barriers are false positives.

The code is also available in the for-4.20/pblk branch in the OCSSD github
project.

Thanks,
Javier

Javier González (4):
  lightnvm: pblk: remove unused function
  lightnvm: pblk: encapsulate rb pointer operations
  lightnvm: pblk: move ring buffer alloc/free rb init
  lightnvm: pblk: guarantee mw_cunits on read buffer

 drivers/lightnvm/pblk-init.c  |  21 +++------
 drivers/lightnvm/pblk-rb.c    | 100 +++++++++++++++++++-----------------------
 drivers/lightnvm/pblk-write.c |   7 +--
 drivers/lightnvm/pblk.h       |  11 ++---
 4 files changed, 57 insertions(+), 82 deletions(-)

-- 
2.7.4

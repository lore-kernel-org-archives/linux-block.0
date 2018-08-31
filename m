Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-ed1-f65.google.com ([209.85.208.65]:37034 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727207AbeHaRmS (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 31 Aug 2018 13:42:18 -0400
Received: by mail-ed1-f65.google.com with SMTP id a20-v6so6388374edd.4
        for <linux-block@vger.kernel.org>; Fri, 31 Aug 2018 06:34:46 -0700 (PDT)
From: "=?UTF-8?q?Javier=20Gonz=C3=A1lez?=" <javier@javigon.com>
To: mb@lightnvm.io
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        =?UTF-8?q?Javier=20Gonz=C3=A1lez?= <javier@cnexlabs.com>
Subject: [PATCH 0/4] lightnvm: pblk: add support for chunk metadata on erase
Date: Fri, 31 Aug 2018 15:34:33 +0200
Message-Id: <1535722477-31288-1-git-send-email-javier@cnexlabs.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

Matias,

This patchset implements support for retrieving chunk metadata when
submitting a reset/erase command. Patches 0 and 1 are small fixes that
can be directly merged into your patch:
  
  lightnvm: move bad block and chunk state logic to core

Also, note that these do not apply on top of your for-4.20/core due them
depending on patches that I sent before that you have not picked up yet.
You can see them though in for-4.20/pblk. I'll rebase as patches in the
list appear in your tree.

Thanks,
Javier

Javier González (4):
  lightnvm: use right address format on 1.2 path
  lightnvm: assign block address before slba
  lightnvm: pblk: add helper for printing chunk state
  lightnvm: pblk: retrieve chunk metadata on erase

 drivers/lightnvm/core.c      | 51 +++++++++++++++++++++++++++++++++++++++-----
 drivers/lightnvm/pblk-core.c | 47 ++++++++++++++++++++++++++++++----------
 drivers/lightnvm/pblk.h      |  9 ++++++++
 3 files changed, 91 insertions(+), 16 deletions(-)

-- 
2.7.4

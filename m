Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-wm0-f45.google.com ([74.125.82.45]:57015 "EHLO
        mail-wm0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751604AbdJFLwh (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Fri, 6 Oct 2017 07:52:37 -0400
Received: by mail-wm0-f45.google.com with SMTP id l68so7424164wmd.5
        for <linux-block@vger.kernel.org>; Fri, 06 Oct 2017 04:52:37 -0700 (PDT)
From: "=?UTF-8?q?Javier=20Gonz=C3=A1lez?=" <jg@lightnvm.io>
To: mb@lightnvm.io
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        =?UTF-8?q?Javier=20Gonz=C3=A1lez?= <javier@cnexlabs.com>
Subject: [PATCH 0/2] lightnvm: pblk fixes
Date: Fri,  6 Oct 2017 13:52:20 +0200
Message-Id: <1507290742-8970-1-git-send-email-javier@cnexlabs.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

Two small patches extra for 4.15

The first one is a general cleanup. The second one is an easy fix to
avoid being reported as a hung task when GC is rate-limited

Javier González (2):
  lightnvm: pblk: cleanup unused and static functions
  lightnvm: pblk: avoid being reported as hung on rated GC

 drivers/lightnvm/pblk-core.c | 133 ++++++++++++++++++++-----------------------
 drivers/lightnvm/pblk-gc.c   |  48 +++++++++-------
 drivers/lightnvm/pblk-rl.c   |  10 ----
 drivers/lightnvm/pblk.h      |  14 ++---
 4 files changed, 93 insertions(+), 112 deletions(-)

-- 
2.7.4

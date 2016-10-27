Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-lf0-f46.google.com ([209.85.215.46]:35849 "EHLO
        mail-lf0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934646AbcJ0SBv (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 27 Oct 2016 14:01:51 -0400
Received: by mail-lf0-f46.google.com with SMTP id b75so38484839lfg.3
        for <linux-block@vger.kernel.org>; Thu, 27 Oct 2016 11:01:50 -0700 (PDT)
From: "=?UTF-8?q?Javier=20Gonz=C3=A1lez?=" <jg@lightnvm.io>
To: mb@lightnvm.io
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        =?UTF-8?q?Javier=20Gonz=C3=A1lez?= <javier@cnexlabs.com>
Subject: [PATCH 0/7] LightNVM patchset V2
Date: Thu, 27 Oct 2016 20:01:32 +0200
Message-Id: <1477591299-26504-1-git-send-email-javier@cnexlabs.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

V2: Rebase patches on Matias' for-next

Javier González (7):
  lightnvm: enable to send hint to erase command
  lightnvm: do not decide on device blocks
  lightnvm: manage block list on LUN owner
  lightnvm: drop reserve and release LUN callbacks
  lightnvm: export set bad block table
  lightnvm: add ECC error codes
  lightnvm: rrpc: split bios of size > 256kb

 drivers/lightnvm/core.c      |  41 ++++++++--
 drivers/lightnvm/gennvm.c    | 180 +++++++++++++++++++++++++------------------
 drivers/lightnvm/gennvm.h    |  19 ++---
 drivers/lightnvm/rrpc.c      | 128 ++++++++++++++++++++++++------
 drivers/lightnvm/rrpc.h      |   4 +
 drivers/lightnvm/sysblk.c    |  33 ++------
 drivers/nvme/host/lightnvm.c |   1 +
 include/linux/lightnvm.h     |  52 +++++++++----
 8 files changed, 305 insertions(+), 153 deletions(-)

-- 
2.7.4


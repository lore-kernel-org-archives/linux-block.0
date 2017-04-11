Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-wm0-f50.google.com ([74.125.82.50]:37201 "EHLO
        mail-wm0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752940AbdDKOTF (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 11 Apr 2017 10:19:05 -0400
Received: by mail-wm0-f50.google.com with SMTP id u2so2021165wmu.0
        for <linux-block@vger.kernel.org>; Tue, 11 Apr 2017 07:19:04 -0700 (PDT)
From: "=?UTF-8?q?Javier=20Gonz=C3=A1lez?=" <jg@lightnvm.io>
To: mb@lightnvm.io
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        =?UTF-8?q?Javier=20Gonz=C3=A1lez?= <javier@cnexlabs.com>
Subject: [PATCH 0/3] lightnvm: small fixes
Date: Tue, 11 Apr 2017 16:18:54 +0200
Message-Id: <1491920338-2348-1-git-send-email-javier@cnexlabs.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

Last small lightnvm fixes for lightnvm core. These are  motivated by
Bart's comments on pblk's patch.

Javier González (3):
  lightnvm: clean unused variable
  lightnvm: fix type checks on rrpc
  lightnvm: convert sprintf into strlcpy

 drivers/lightnvm/core.c | 9 +++------
 drivers/lightnvm/rrpc.c | 4 ++--
 2 files changed, 5 insertions(+), 8 deletions(-)

-- 
2.7.4

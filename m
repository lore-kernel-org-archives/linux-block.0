Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-lf0-f67.google.com ([209.85.215.67]:44886 "EHLO
        mail-lf0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751384AbeBUIDu (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 21 Feb 2018 03:03:50 -0500
Received: by mail-lf0-f67.google.com with SMTP id v9so1063354lfa.11
        for <linux-block@vger.kernel.org>; Wed, 21 Feb 2018 00:03:50 -0800 (PST)
From: hans.ml.holmberg@owltronix.com
To: =?UTF-8?q?Matias=20Bj=C3=B8rling?= <mb@lightnvm.io>
Cc: =?UTF-8?q?Javier=20Gonz=C3=A1lez?= <jg@lightnvm.io>,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        Hans Holmberg <hans.holmberg@cnexlabs.com>
Subject: [PATCH 0/3] pblk bugfixes
Date: Wed, 21 Feb 2018 09:02:58 +0100
Message-Id: <1519200181-10886-1-git-send-email-hans.ml.holmberg@owltronix.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

From: Hans Holmberg <hans.holmberg@cnexlabs.com>

This is a slew of generic bugfixes to pblk

The patches apply on top of:
https://github.com/OpenChannelSSD/linux branch for-4.17/core

Hans Holmberg (3):
  lightnvm: pblk: delete writer kick timer before stopping thread
  lightnvm: pblk: allow allocation of new lines during shutdown
  lightnvm: pblk: prevent race in pblk_rb_flush_point_set

 drivers/lightnvm/pblk-core.c | 7 -------
 drivers/lightnvm/pblk-init.c | 2 +-
 drivers/lightnvm/pblk-rb.c   | 7 ++++---
 3 files changed, 5 insertions(+), 11 deletions(-)

-- 
2.7.4

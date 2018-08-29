Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-ed1-f67.google.com ([209.85.208.67]:36199 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727204AbeH2M5y (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 29 Aug 2018 08:57:54 -0400
Received: by mail-ed1-f67.google.com with SMTP id f4-v6so3368273edq.3
        for <linux-block@vger.kernel.org>; Wed, 29 Aug 2018 02:01:59 -0700 (PDT)
From: "=?UTF-8?q?Javier=20Gonz=C3=A1lez?=" <javier@javigon.com>
To: mb@lightnvm.io
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        =?UTF-8?q?Javier=20Gonz=C3=A1lez?= <javier@cnexlabs.com>
Subject: [PATCH 0/4] lightnvm: pblk: collection of small fixes
Date: Wed, 29 Aug 2018 11:01:49 +0200
Message-Id: <1535533313-29944-1-git-send-email-javier@cnexlabs.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

Collection of small helper function fixes, removal of unused variables
and comment typos.

Javier González (4):
  lightnvm: pblk: calculate line pad distance in helper
  lightnvm: pblk: fix comment typo
  lightnvm: pblk: remove unused variable.
  lightnvm: pblk: guarantee emeta on line close

 drivers/lightnvm/pblk-core.c     | 13 +++++++++++--
 drivers/lightnvm/pblk-recovery.c |  2 --
 drivers/lightnvm/pblk-write.c    |  2 +-
 drivers/lightnvm/pblk.h          |  6 +++---
 4 files changed, 15 insertions(+), 8 deletions(-)

-- 
2.7.4

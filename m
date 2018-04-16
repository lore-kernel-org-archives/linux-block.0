Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-wr0-f196.google.com ([209.85.128.196]:38543 "EHLO
        mail-wr0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752201AbeDPKZl (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 16 Apr 2018 06:25:41 -0400
Received: by mail-wr0-f196.google.com with SMTP id h3so11814703wrh.5
        for <linux-block@vger.kernel.org>; Mon, 16 Apr 2018 03:25:41 -0700 (PDT)
From: "=?UTF-8?q?Javier=20Gonz=C3=A1lez?=" <javier@javigon.com>
To: mb@lightnvm.io
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        =?UTF-8?q?Javier=20Gonz=C3=A1lez?= <javier@cnexlabs.com>
Subject: [PATCH 00/11] lightnvm: pblk: small fixes
Date: Mon, 16 Apr 2018 12:25:21 +0200
Message-Id: <1523874332-6272-1-git-send-email-javier@cnexlabs.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

A bunch of small fixes and extra checks for pblk. Non is critical, though
("lightnvm: pblk: check for chunk size before allocating it") might be nice to
get into 4.17 as it is a fix for the 2.0 pblk patches.

Javier

Javier González (11):
  lightnvm: pblk: fail gracefully on line alloc. failure
  lightnvm: pblk: recheck for bad lines at runtime
  lightnvm: pblk: check read lba on gc path
  lightnvn: pblk: improve error msg on corrupted LBAs
  lightnvm: pblk: warn in case of corrupted write buffer
  lightnvm: pblk: return NVM_ error on failed submission
  lightnvm: pblk: remove unnecessary indirection
  lightnvm: pblk: remove unnecessary argument
  lightnvm: pblk: check for chunk size before allocating it
  lightnvn: pass flag on graceful teardown to targets
  lightnvm: pblk: remove dead function

 drivers/lightnvm/core.c      | 10 +++---
 drivers/lightnvm/pblk-core.c | 86 ++++++++++++++++++++++++++------------------
 drivers/lightnvm/pblk-gc.c   | 10 +++---
 drivers/lightnvm/pblk-init.c | 38 ++++++++++++--------
 drivers/lightnvm/pblk-map.c  | 33 ++++++++++++-----
 drivers/lightnvm/pblk-rb.c   |  5 ++-
 drivers/lightnvm/pblk-read.c | 73 ++++++++++++++++++++++++++++---------
 drivers/lightnvm/pblk.h      |  7 ++--
 include/linux/lightnvm.h     |  2 +-
 9 files changed, 173 insertions(+), 91 deletions(-)

-- 
2.7.4

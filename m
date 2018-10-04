Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-ed1-f68.google.com ([209.85.208.68]:44772 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727046AbeJDOFx (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 4 Oct 2018 10:05:53 -0400
Received: by mail-ed1-f68.google.com with SMTP id z21-v6so3155370edb.11
        for <linux-block@vger.kernel.org>; Thu, 04 Oct 2018 00:14:03 -0700 (PDT)
From: "=?UTF-8?q?Javier=20Gonz=C3=A1lez?=" <javier@javigon.com>
To: mb@lightnvm.io
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        =?UTF-8?q?Javier=20Gonz=C3=A1lez?= <javier@cnexlabs.com>
Subject: [V2 PATCH 0/2]  lightnvm: pblk: retrieve chunk metadata on erase
Date: Thu,  4 Oct 2018 09:13:53 +0200
Message-Id: <1538637235-25469-1-git-send-email-javier@cnexlabs.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

Changes singe V1:
  - remove sanity checks on the fast path

This patchset implements support for retrieving chunk metadata on reset.
This is the base for implementing wear-leveling and allowing chunks to
shrink at runtime.

Javier

Javier González (2):
  lightnvm: pblk: add helper for printing chunk state
  lightnvm: pblk: retrieve chunk metadata on erase

 drivers/lightnvm/core.c      | 44 ++++++++++++++++++++++++++++++++++--
 drivers/lightnvm/pblk-core.c | 54 +++++++++++++++++++++++++++++++++-----------
 drivers/lightnvm/pblk.h      |  9 ++++++++
 3 files changed, 92 insertions(+), 15 deletions(-)

-- 
2.7.4

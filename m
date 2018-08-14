Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-lj1-f196.google.com ([209.85.208.196]:46757 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730488AbeHNQEz (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 14 Aug 2018 12:04:55 -0400
Received: by mail-lj1-f196.google.com with SMTP id 203-v6so15296392ljj.13
        for <linux-block@vger.kernel.org>; Tue, 14 Aug 2018 06:17:46 -0700 (PDT)
From: =?UTF-8?q?Matias=20Bj=C3=B8rling?= <mb@lightnvm.io>
To: igor.j.konopko@intel.com, marcin.dziegielewski@intel.com,
        javier@cnexlabs.com, hans.holmberg@cnexlabs.com, hlitz@ucsc.edu,
        youngtack.jin@circuitblvd.com
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        =?UTF-8?q?Matias=20Bj=C3=B8rling?= <mb@lightnvm.io>
Subject: [RFC PATCH 0/1] lightnvm: move bad block and chunk state logic to core
Date: Tue, 14 Aug 2018 15:17:34 +0200
Message-Id: <20180814131735.6853-1-mb@lightnvm.io>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

This patch moves the 1.2 and 2.0 block/chunk metadata retrieval to
core.

Javier, would you like me to pick up your 1.2 chunk state patch and
merge it into this one, or would you like to rebase on this later when
it has been reviewed?

Matias Bjørling (1):
  lightnvm: move bad block and chunk state logic to core

 drivers/lightnvm/core.c      | 166 ++++++++++++++++++++++++++++---------------
 drivers/lightnvm/pblk-core.c |   6 +-
 drivers/lightnvm/pblk-init.c | 116 +-----------------------------
 drivers/lightnvm/pblk.h      |   2 +-
 drivers/nvme/host/lightnvm.c |   4 +-
 include/linux/lightnvm.h     |  15 ++--
 6 files changed, 122 insertions(+), 187 deletions(-)

-- 
2.11.0

Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:32983 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1034185AbeE1PWR (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Mon, 28 May 2018 11:22:17 -0400
From: Coly Li <colyli@suse.de>
To: linux-bcache@vger.kernel.org
Cc: linux-block@vger.kernel.org, Coly Li <colyli@suse.de>
Subject: [PATCH v2 0/4] bcache patches for 4.18
Date: Mon, 28 May 2018 15:37:40 +0800
Message-Id: <20180528073744.71258-1-colyli@suse.de>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

Hi Jens,

Here are the first wave bcache patches for linux v4.18, not too much
changes.

- Andy Shevchenko contributes several clean up patches for bcache.
- A reviewed patch from me, about the bcache device failure improvement
  series.

There are still some patches waiting for peer review. Once they get
reviewed and it is still in good timing, I will submit them in next waves.

Thanks in advance.

Coly Li 
---
Andy Shevchenko (3):
  bcache: Move couple of string arrays to sysfs.c
  bcache: Move couple of functions to sysfs.c
  bcache: Replace bch_read_string_list() by __sysfs_match_string()

Coly Li (1):
  bcache: stop bcache device when backing device is offline

 drivers/md/bcache/bcache.h |  4 +--
 drivers/md/bcache/super.c  | 71 ++++++++++++++++++++++++++++----------
 drivers/md/bcache/sysfs.c  | 51 ++++++++++++++++++++-------
 drivers/md/bcache/util.c   | 35 -------------------
 drivers/md/bcache/util.h   |  5 ---
 5 files changed, 94 insertions(+), 72 deletions(-)

-- 
2.17.0

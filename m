Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mga12.intel.com ([192.55.52.136]:63784 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933165AbeEWPRg (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Wed, 23 May 2018 11:17:36 -0400
From: Marcin Dziegielewski <marcin.dziegielewski@intel.com>
To: mb@lightnvm.io
Cc: linux-block@vger.kernel.org,
        Marcin Dziegielewski <marcin.dziegielewski@intel.com>
Subject: [PATCH 0/2] lightnvm: pblk: write buffer improvements
Date: Wed, 23 May 2018 17:17:18 +0200
Message-Id: <1527088640-13062-1-git-send-email-marcin.dziegielewski@intel.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

This patchset provides two improvements related to setting size of write buffer.

Marcin Dziegielewski (2):
  lightnvm: pblk: add possibility to set write buffer size manually
  lightnvm: pblk: handle case when device expose mw_cunits equal to 0

 drivers/lightnvm/pblk-init.c | 24 +++++++++++++++++++++---
 drivers/nvme/host/lightnvm.c |  1 -
 2 files changed, 21 insertions(+), 4 deletions(-)

-- 
1.8.3.1

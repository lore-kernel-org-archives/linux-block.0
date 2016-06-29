Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-wm0-f66.google.com ([74.125.82.66]:35264 "EHLO
	mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752404AbcF2OmX (ORCPT
	<rfc822;linux-block@vger.kernel.org>);
	Wed, 29 Jun 2016 10:42:23 -0400
Received: by mail-wm0-f66.google.com with SMTP id a66so14846126wme.2
        for <linux-block@vger.kernel.org>; Wed, 29 Jun 2016 07:42:08 -0700 (PDT)
From: =?UTF-8?q?Matias=20Bj=C3=B8rling?= <m@bjorling.me>
To: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: =?UTF-8?q?Matias=20Bj=C3=B8rling?= <m@bjorling.me>
Subject: [RFC PATCH 00/11] Small fixes for LightNVM
Date: Wed, 29 Jun 2016 16:41:45 +0200
Message-Id: <1467211316-22373-1-git-send-email-m@bjorling.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

A collection of small fixes destined for the 4.8 kernel.

Most notably is the move of the target management into the general media
manager. The concept of targets is media manager specific, therefore
this should be managed by itself. Core may only pass thetarget requests
along to the appropriate media manager.

Matias Bjørling (11):
  lightnvm: remove checkpatch warning for unsigned ints
  lightnvm: fix checkpatch terse errors
  lightnvm: remove open/close statistics for gennvm
  lightnvm: rename gennvm and update description
  lightnvm: move target mgmt into media mgr
  lightnvm: remove nested lock conflict with mm
  lightnvm: remove unused lists from struct rrpc_block
  lightnvm: remove _unlocked variant of [get/put]_blk
  lightnvm: fix lun offset calculation for mark blk
  lightnvm: make ppa_list const in nvm_set_rqd_list
  lightnvm: make __nvm_submit_ppa static

 drivers/lightnvm/Kconfig  |  10 +-
 drivers/lightnvm/core.c   | 234 +++++++---------------------
 drivers/lightnvm/gennvm.c | 385 +++++++++++++++++++++++++++++-----------------
 drivers/lightnvm/gennvm.h |  10 +-
 drivers/lightnvm/rrpc.c   |  30 +---
 drivers/lightnvm/rrpc.h   |  12 +-
 include/linux/lightnvm.h  |  33 ++--
 7 files changed, 333 insertions(+), 381 deletions(-)

-- 
2.1.4


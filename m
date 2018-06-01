Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-lf0-f66.google.com ([209.85.215.66]:38008 "EHLO
        mail-lf0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751555AbeFAOnx (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Fri, 1 Jun 2018 10:43:53 -0400
Received: by mail-lf0-f66.google.com with SMTP id i83-v6so3034699lfh.5
        for <linux-block@vger.kernel.org>; Fri, 01 Jun 2018 07:43:53 -0700 (PDT)
From: =?UTF-8?q?Matias=20Bj=C3=B8rling?= <mb@lightnvm.io>
To: axboe@fb.com
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        javier@cnexlabs.com, igor.j.konopko@intel.com,
        marcin.dziegielewski@intel.com,
        =?UTF-8?q?Matias=20Bj=C3=B8rling?= <mb@lightnvm.io>
Subject: [GIT PULL v3 00/10] lightnvm updates for 4.18
Date: Fri,  1 Jun 2018 16:41:04 +0200
Message-Id: <20180601144114.17490-1-mb@lightnvm.io>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

Hi Jens,

Please pick up the following patches.

Changes since v2:

 Rebased write error recovery patch on top of latest
 for-4.18/block

 Added (missed the first round)
  lightnvm: pblk: only try to recover lines with written smeta
  lightnvm: pblk: kick writer on new flush points
  lightnvm: pblk: take bitmap alloc. out of critical section

Changes since v1:

 Removed
  lightnvm: pblk: sync RB and RL states during GC
  lightnvm: error handling when whole line is bad
  lightnvm: pblk: handle case when mw_cunits equals to 0

 Added
  lightnvm: pblk: remove unnecessary bio_get/put

Thanks!

Hans Holmberg (5):
  lightnvm: pblk: rework write error recovery path
  lightnvm: pblk: garbage collect lines with failed writes
  lightnvm: pblk: fix smeta write error path
  lightnvm: pblk: only try to recover lines with written smeta
  lightnvm: pblk: kick writer on new flush points

Igor Konopko (2):
  lightnvm: proper error handling for pblk_bio_add_pages
  lightnvm: fix partial read error path

Javier González (2):
  lightnvm: pblk: remove unnecessary bio_get/put
  lightnvm: pblk: take bitmap alloc. out of critical section

Marcin Dziegielewski (1):
  lightnvm: pblk: add possibility to set write buffer size manually

 drivers/lightnvm/pblk-cache.c    |  10 +-
 drivers/lightnvm/pblk-core.c     | 157 +++++++++++++++-------
 drivers/lightnvm/pblk-gc.c       | 102 ++++++++------
 drivers/lightnvm/pblk-init.c     |  62 ++++++---
 drivers/lightnvm/pblk-rb.c       |  43 +-----
 drivers/lightnvm/pblk-read.c     |  69 +++++-----
 drivers/lightnvm/pblk-recovery.c | 121 +++--------------
 drivers/lightnvm/pblk-rl.c       |  29 +++-
 drivers/lightnvm/pblk-sysfs.c    |  15 ++-
 drivers/lightnvm/pblk-write.c    | 281 +++++++++++++++++++++++++--------------
 drivers/lightnvm/pblk.h          |  37 ++++--
 11 files changed, 524 insertions(+), 402 deletions(-)

-- 
2.11.0

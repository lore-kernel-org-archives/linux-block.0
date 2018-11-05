Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-ed1-f65.google.com ([209.85.208.65]:42008 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726368AbeKEVqO (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Mon, 5 Nov 2018 16:46:14 -0500
Received: by mail-ed1-f65.google.com with SMTP id h21-v6so6862495edq.9
        for <linux-block@vger.kernel.org>; Mon, 05 Nov 2018 04:26:43 -0800 (PST)
From: Hans Holmberg <hans.ml.holmberg@owltronix.com>
To: Matias Bjorling <mb@lightnvm.io>
Cc: Javier Gonzales <javier@cnexlabs.com>, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Hans Holmberg <hans.holmberg@cnexlabs.com>
Subject: [PATCH v2 0/7] PBLK Bugfixes and cleanups
Date: Mon,  5 Nov 2018 13:26:03 +0100
Message-Id: <20181105122610.1555-1-hans.ml.holmberg@owltronix.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

From: Hans Holmberg <hans.holmberg@cnexlabs.com>

This series is a slew of bugfixes and cleanups for PBLK, mostly
fixing issues found during corner-case testing in QEMU.

Changes since v1:
	Messed up from:, now the patches apply with the correct author
	Pardon the mess.

Hans Holmberg (7):
  lightnvm: pblk: fix resubmission of overwritten write err lbas
  lightnvm: pblk: account for write error sectors in emeta
  lightnvm: pblk: stop writes gracefully when running out of lines
  lightnvm: pblk: set conservative threshold for user writes
  lightnvm: pblk: remove unused macro
  lightnvm: pblk: fix pblk_lines_init error handling path
  lightnvm: pblk: remove dead code in pblk_recov_l2p

 drivers/lightnvm/pblk-init.c     | 48 +++++++++++++++++-----------
 drivers/lightnvm/pblk-map.c      | 47 ++++++++++++++++-----------
 drivers/lightnvm/pblk-recovery.c |  1 -
 drivers/lightnvm/pblk-rl.c       |  5 ++-
 drivers/lightnvm/pblk-write.c    | 55 +++++++++++++++++++++++---------
 drivers/lightnvm/pblk.h          | 16 ++++++++--
 6 files changed, 114 insertions(+), 58 deletions(-)

-- 
2.17.1

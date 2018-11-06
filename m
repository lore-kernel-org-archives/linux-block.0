Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-it1-f193.google.com ([209.85.166.193]:40945 "EHLO
        mail-it1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388149AbeKFW6x (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 6 Nov 2018 17:58:53 -0500
Received: by mail-it1-f193.google.com with SMTP id e11so14299417itl.5
        for <linux-block@vger.kernel.org>; Tue, 06 Nov 2018 05:33:39 -0800 (PST)
From: Hans Holmberg <hans.ml.holmberg@owltronix.com>
To: Matias Bjorling <mb@lightnvm.io>
Cc: Javier Gonzales <javier@cnexlabs.com>,
        Sebastien Boisvert <sboisvert@gydle.com>,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        Hans Holmberg <hans.holmberg@cnexlabs.com>
Subject: [PATCH v3 0/7] PBLK Bugfixes and cleanups
Date: Tue,  6 Nov 2018 14:33:23 +0100
Message-Id: <20181106133330.26570-1-hans.ml.holmberg@owltronix.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

From: Hans Holmberg <hans.holmberg@cnexlabs.com>

This series is a slew of bugfixes and cleanups for PBLK, mostly
fixing issues found during corner-case testing in QEMU.

Changes since v1:
	Messed up from:, now the patches apply with the correct author
	Pardon the mess.

Changes since v2:
	Fixed kbuild reported issue and potential divide by zero in:
		("lightnvm: pblk: set conservative threshold for user writes")
	Fixed commit message nitpicks reported by Sebastien

The patch-set applies on top of:
	remote https://github.com/OpenChannelSSD/linux.git
	branch for-4.21/core

Hans Holmberg (7):
  lightnvm: pblk: fix resubmission of overwritten write err lbas
  lightnvm: pblk: account for write error sectors in emeta
  lightnvm: pblk: stop writes gracefully when running out of lines
  lightnvm: pblk: set conservative threshold for user writes
  lightnvm: pblk: remove unused macro
  lightnvm: pblk: fix pblk_lines_init error handling path
  lightnvm: pblk: remove dead code in pblk_recov_l2p

 drivers/lightnvm/pblk-init.c     | 45 ++++++++++++++++++--------
 drivers/lightnvm/pblk-map.c      | 47 ++++++++++++++++-----------
 drivers/lightnvm/pblk-recovery.c |  1 -
 drivers/lightnvm/pblk-rl.c       |  5 ++-
 drivers/lightnvm/pblk-write.c    | 55 +++++++++++++++++++++++---------
 drivers/lightnvm/pblk.h          | 16 ++++++++--
 6 files changed, 116 insertions(+), 53 deletions(-)

-- 
2.17.1

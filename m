Return-Path: <linux-block-owner@vger.kernel.org>
Received: from smtp81.mediacombb.net ([68.66.77.81]:47886 "EHLO
	dsmdc-mail-smtp.mcomdc.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1750788AbcFFQFt (ORCPT
	<rfc822;linux-block@vger.kernel.org>);
	Mon, 6 Jun 2016 12:05:49 -0400
From: Shaun Tancheff <shaun@tancheff.com>
To: util-linux@vger.kernel.org, linux-block@vger.kernel.org
Cc: Shaun Tancheff <shaun@tancheff.com>
Subject: [PATCH] Zoned block device support
Date: Mon,  6 Jun 2016 11:04:54 -0500
Message-Id: <1465229095-27651-1-git-send-email-shaun@tancheff.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

ZBC/ZAC compliant devices such as Host Aware drives are now available.

This patch follows the pattern of blkdiscard to and zoned device
commands Open, Close and Reset as well as Report zones.

Note that this interface depends on Block layer support ZAC/ZBC commands
https://lkml.kernel.org/r/1465227572-27149-1-git-send-email-shaun@tancheff.com

Shaun Tancheff (1):
  Add blkzonecmd and blkreport ZAC/ZBC drives

 configure.ac            |  14 ++
 include/strutils.h      |   1 +
 lib/strutils.c          |   6 +-
 sys-utils/Makemodule.am |  14 ++
 sys-utils/blkreport.8   |  96 +++++++++
 sys-utils/blkreport.c   | 546 ++++++++++++++++++++++++++++++++++++++++++++++++
 sys-utils/blkzonecmd.8  |  78 +++++++
 sys-utils/blkzonecmd.c  | 239 +++++++++++++++++++++
 8 files changed, 993 insertions(+), 1 deletion(-)
 create mode 100644 sys-utils/blkreport.8
 create mode 100644 sys-utils/blkreport.c
 create mode 100644 sys-utils/blkzonecmd.8
 create mode 100644 sys-utils/blkzonecmd.c

-- 
2.8.1


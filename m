Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:38535 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1757887AbcLVQPJ (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 22 Dec 2016 11:15:09 -0500
To: Linus Torvalds <torvalds@linux-foundation.org>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
From: Jens Axboe <axboe@fb.com>
Subject: [GIT PULL] Block fixes for 4.10-rc1
Message-ID: <df33ee1e-2874-6594-1d65-feb9c914f72b@fb.com>
Date: Thu, 22 Dec 2016 09:14:44 -0700
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

Hi Linus,

Just a set of small fixes that have either been queued up after the
original pull for this merge window, or just missed the original pull
request.

- A few bcache fixes/changes from Eric and Kent.

- Adding WRITE_SAME to the command filter whitelist frm Mauricio.

- Kill an unused struct member from Ritesh.

- Partition IO alignment fix from Stefan.

- nvme sysfs printf fix from Stephen.

Please pull!


  git://git.kernel.dk/linux-block.git for-linus


----------------------------------------------------------------
Eric Wheeler (1):
      bcache: partition support: add 16 minors per bcacheN device

Kent Overstreet (1):
      bcache: Make gc wakeup sane, remove set_task_state()

Mauricio Faria de Oliveira (1):
      block: allow WRITE_SAME commands with the SG_IO ioctl

Ritesh Harjani (1):
      block: Remove unused member (busy) from struct blk_queue_tag

Stefan Haberland (1):
      block: check partition alignment

Stephen Bates (1):
      nvme : Use correct scnprintf in cmb show

 block/ioctl.c               |  3 +++
 block/scsi_ioctl.c          |  3 +++
 drivers/md/bcache/bcache.h  |  4 ++--
 drivers/md/bcache/btree.c   | 39 ++++++++++++++++++++-------------------
 drivers/md/bcache/btree.h   |  3 +--
 drivers/md/bcache/request.c |  4 +---
 drivers/md/bcache/super.c   |  7 ++++++-
 drivers/nvme/host/pci.c     |  4 ++--
 include/linux/blkdev.h      |  1 -
 9 files changed, 38 insertions(+), 30 deletions(-)

-- 
Jens Axboe


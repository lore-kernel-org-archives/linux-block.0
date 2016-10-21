Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:43624 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S935043AbcJUQJ2 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 21 Oct 2016 12:09:28 -0400
To: Linus Torvalds <torvalds@linux-foundation.org>
CC: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
From: Jens Axboe <axboe@fb.com>
Subject: [GIT PULL] Block fixes for 4.9-rc
Message-ID: <1b7e59a4-9558-801b-fe8f-0f7375d1c930@fb.com>
Date: Fri, 21 Oct 2016 10:09:18 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"; format=flowed
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

Hi Linus,

A set of fixes that missed the merge window, mostly due to me being away
around that time. Nothing major here, a mix of nvme cleanups and fixes,
and one fix for the badblocks handling.

Please pull!


   git://git.kernel.dk/linux-block.git for-linus


----------------------------------------------------------------
Christoph Hellwig (5):
       nvme.h: resync with nvme-cli
       nvme.h: don't use uuid_be
       nvme.h: add an enum for cns values
       nvme: use symbolic constants for CNS values
       nvmet: use symbolic constants for CNS values

Gabriel Krisman Bertazi (1):
       nvme: Add tertiary number to NVME_VS

Keith Busch (3):
       nvme: Stop probing a removed device
       nvme: Delete created IO queues on reset
       nvme: don't schedule multiple resets

Stephen Bates (1):
       nvme : Add sysfs entry for NVMe CMBs when appropriate

Tomasz Majchrzak (1):
       badblocks: fix overlapping check for clearing

  block/badblocks.c               |  6 ++--
  drivers/nvme/host/core.c        | 14 ++++----
  drivers/nvme/host/pci.c         | 77 
+++++++++++++++++++++++++++++------------
  drivers/nvme/host/scsi.c        |  4 +--
  drivers/nvme/target/admin-cmd.c |  8 ++---
  drivers/nvme/target/core.c      |  2 +-
  drivers/nvme/target/discovery.c |  4 +--
  include/linux/nvme.h            | 49 +++++++++++++++++++++-----
  8 files changed, 115 insertions(+), 49 deletions(-)

-- 
Jens Axboe


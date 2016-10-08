Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:43637 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752314AbcJHCL4 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 7 Oct 2016 22:11:56 -0400
To: Linus Torvalds <torvalds@linux-foundation.org>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
From: Jens Axboe <axboe@fb.com>
Subject: [GIT PULL] blk-mq CPU hotplug
Message-ID: <e5272a53-81d4-61d9-d0c2-bc8279d08fc5@fb.com>
Date: Fri, 7 Oct 2016 20:11:47 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"; format=flowed
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

Hi Linus,

Last topical branch, this is the conversion of blk-mq to the new hotplug
state machine. This should merge cleanly.

Please pull!


   git://git.kernel.dk/linux-block.git for-4.9/block-smp


----------------------------------------------------------------
Jens Axboe (1):
       Merge branch 'smp/for-block' of git://git.kernel.org/.../tip/tip 
into for-4.9/block-smp

Sebastian Andrzej Siewior (2):
       blk-mq: Convert to new hotplug state machine
       blk-mq: fixup "Convert to new hotplug state machine"

Thomas Gleixner (1):
       blk-mq/cpu-notif: Convert to new hotplug state machine

  arch/x86/kernel/smpboot.c    |  11 --
  block/Makefile               |   2 +-
  block/blk-mq-cpu.c           |  67 ---------
  block/blk-mq.c               | 123 +++++++---------
  block/blk-mq.h               |   7 -
  include/linux/blk-mq.h       |   8 +-
  include/linux/cpuhotplug.h   | 112 +++++++++++++-
  include/trace/events/cpuhp.h |  28 ++++
  kernel/cpu.c                 | 344 
+++++++++++++++++++++++++++++++------------
  9 files changed, 444 insertions(+), 258 deletions(-)
  delete mode 100644 block/blk-mq-cpu.c


-- 
Jens Axboe


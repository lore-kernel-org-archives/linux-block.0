Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:35965 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1753067AbdAKVkN (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 11 Jan 2017 16:40:13 -0500
From: Jens Axboe <axboe@fb.com>
To: <linux-kernel@vger.kernel.org>, <linux-block@vger.kernel.org>
CC: <osandov@osandov.com>, <bart.vanassche@sandisk.com>
Subject: [PATCHSET v6] blk-mq scheduling framework
Date: Wed, 11 Jan 2017 14:39:53 -0700
Message-ID: <1484170803-9311-1-git-send-email-axboe@fb.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

Another year, another posting of this patchset. The previous posting
was here:

https://www.spinics.net/lists/kernel/msg2406106.html

(yes, I've skipped v5, it was fixes on top of v4, not the rework).

I've reworked bits of this to get rid of the shadow requests, thanks
to Bart for the inspiration. The missing piece, for me, was the fact
that we have the tags->rqs[] indirection array already. I've done this
somewhat differently, though, by having the internal scheduler tag
map be allocated/torn down when an IO scheduler is attached or
detached. This also means that when we run without a scheduler, we
don't have to do double tag allocations, it'll work like before.

The patchset applies on top of 4.10-rc3, or can be pulled here:

git://git.kernel.dk/linux-block blk-mq-sched.6


 block/Kconfig.iosched    |   50 ++++
 block/Makefile           |    3 
 block/blk-core.c         |   19 -
 block/blk-exec.c         |    3 
 block/blk-flush.c        |   15 -
 block/blk-ioc.c          |   12 
 block/blk-merge.c        |    4 
 block/blk-mq-sched.c     |  354 +++++++++++++++++++++++++++++
 block/blk-mq-sched.h     |  157 ++++++++++++
 block/blk-mq-sysfs.c     |   13 +
 block/blk-mq-tag.c       |   58 ++--
 block/blk-mq-tag.h       |    4 
 block/blk-mq.c           |  413 +++++++++++++++++++---------------
 block/blk-mq.h           |   40 +++
 block/blk-tag.c          |    1 
 block/blk.h              |   26 +-
 block/cfq-iosched.c      |    2 
 block/deadline-iosched.c |    2 
 block/elevator.c         |  247 +++++++++++++++-----
 block/mq-deadline.c      |  569 +++++++++++++++++++++++++++++++++++++++++++++++
 block/noop-iosched.c     |    2 
 drivers/nvme/host/pci.c  |    1 
 include/linux/blk-mq.h   |    9 
 include/linux/blkdev.h   |    6 
 include/linux/elevator.h |   36 ++
 25 files changed, 1732 insertions(+), 314 deletions(-)

-- 
Jens Axboe


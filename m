Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:35258 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1750742AbcJ0QkF (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 27 Oct 2016 12:40:05 -0400
To: Linus Torvalds <torvalds@linux-foundation.org>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
From: Jens Axboe <axboe@fb.com>
Subject: [GIT PULL] Block fixes for 4.9-rc
Message-ID: <b8d9532f-4582-d665-4b7f-7e0c3ff3083c@fb.com>
Date: Thu, 27 Oct 2016 10:39:47 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"; format=flowed
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

Hi Linus,

A set of fixes for this series, most notably the fix for the blk-mq
software queue regression in from this merge window.

Apart from that, a fix for an unlikely hang if a queue is flooded with
FUA requests from Ming, and a few small fixes for nbd and badblocks.
Lastly, a rename update for the proc softirq output, since the block
polling code was made generic.

Please pull!


   git://git.kernel.dk/linux-block.git for-linus


----------------------------------------------------------------
Jens Axboe (1):
       blk-mq: update hardware and software queues for sleeping alloc

John W. Linville (1):
       nbd: fix incorrect unlock of nbd->sock_lock in sock_shutdown

Ming Lei (1):
       block: flush: fix IO hang in case of flood fua req

Sagi Grimberg (1):
       softirq: Display IRQ_POLL for irq-poll statistics

Shaohua Li (1):
       badblocks: badblocks_set/clear update unacked_exist

  block/badblocks.c   | 23 +++++++++++++++++++++++
  block/blk-flush.c   | 28 ++++++++++++++++++++++++++++
  block/blk-mq.c      |  6 +++---
  drivers/block/nbd.c |  2 +-
  kernel/softirq.c    |  2 +-
  5 files changed, 56 insertions(+), 5 deletions(-)

-- 
Jens Axboe


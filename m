Return-Path: <sbates@raithlin.com>
From: Stephen Bates <sbates@raithlin.com>
To: linux-block@vger.kernel.org
Cc: axboe@kernel.dk,
	hch@lst.de
Subject: [PATCH 0/2] block : Patches related to io_polling
Date: Tue, 13 Sep 2016 12:23:14 -0600
Message-Id: <1473790996-27038-1-git-send-email-sbates@raithlin.com>
List-ID: <linux-block@vger.kernel.org>

While profiling the performance of the io_poll feature of the blk-mq
section of the block layer I found it useful to add another entry to
the io_poll stats counters. I also found it really useful to be able
to zero the stats counters by echoing into the relevant sysfs entry.

These two patches are based off commit 0eadf37afc in Jen's
for-4.9/block. I am not sure if that is the right repo and can rebase
if necessary.

In full disclosure the zeroing patch is based heavily on a code
snippet Jens send me a few months ago.

Stephen Bates (2):
  Add poll_considered statistic
  Enable zeroing of io_poll statistics

 block/blk-core.c       |  8 ++++++--
 block/blk-mq-sysfs.c   | 15 +++++++++++++--
 include/linux/blk-mq.h |  1 +
 3 files changed, 20 insertions(+), 4 deletions(-)

--
2.1.4

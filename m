Return-Path: <axboe@kernel.dk>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
From: Jens Axboe <axboe@kernel.dk>
Subject: [GIT PULL] Block fix for 4.19-rc5
Message-ID: <1132dc7f-d3d0-a318-22d5-01d2af8f63c7@kernel.dk>
Date: Sat, 22 Sep 2018 15:21:19 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

Hi Greg,

I was going to wait with this one, but then I decided that I think we
should put it in sooner rather than later. Just a single fix in this
pull request, fixing a regression in /proc/diskstats caused by the
unification of timestamps.

Please pull!


  git://git.kernel.dk/linux-block.git tags/for-linus-20180922


----------------------------------------------------------------
Omar Sandoval (1):
      block: use nanosecond resolution for iostat

 block/bio.c               | 2 +-
 block/blk-core.c          | 4 +---
 block/genhd.c             | 6 +++---
 block/partition-generic.c | 6 +++---
 include/linux/genhd.h     | 5 ++++-
 5 files changed, 12 insertions(+), 11 deletions(-)

-- 
Jens Axboe

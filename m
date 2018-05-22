Return-Path: <colyli@suse.de>
From: Coly Li <colyli@suse.de>
To: axboe@kernel.dk,
	linux-bcache@vger.kernel.org
Cc: linux-block@vger.kernel.org,
	Coly Li <colyli@suse.de>
Subject: [PATCH 0/5] bcache patches for 4.18
Date: Tue, 22 May 2018 17:31:55 +0800
Message-Id: <20180522093200.67193-1-colyli@suse.de>
List-ID: <linux-block@vger.kernel.org>

Hi Jens,

Here is the first wave bcache patches for linux v4.18.

Andy Shevchenko contributes a patch to move crc64 calculation into
lib/crc64.c, and this is the first public crc64 implementation in Linux
kernel. He also contributes other 3 nice code clean up patches.

The patch from me is about backing device failure and reviewed by Hannnes.

So far there are still several patches are waiting for review, once they
have peer reviewer I will post them in following waves.

Please pick the first wave for 4.18. Thanks in advance.

Coly Li
---
Andy Shevchenko (4):
  bcache: Split out crc64 to library
  bcache: Move couple of string arrays to sysfs.c
  bcache: Move couple of functions to sysfs.c
  bcache: Replace bch_read_string_list() by __sysfs_match_string()

Coly Li (1):
  bcache: stop bcache device when backing device is offline

 drivers/md/bcache/Kconfig   |   1 +
 drivers/md/bcache/bcache.h  |   6 +-
 drivers/md/bcache/btree.c   |   2 +-
 drivers/md/bcache/request.c |   2 +-
 drivers/md/bcache/super.c   |  75 ++++++++++++++------
 drivers/md/bcache/sysfs.c   |  51 ++++++++++----
 drivers/md/bcache/util.c    | 166 --------------------------------------------
 drivers/md/bcache/util.h    |   9 +--
 include/linux/crc64.h       |   9 +++
 lib/Kconfig                 |   8 +++
 lib/Makefile                |   1 +
 lib/crc64.c                 | 137 ++++++++++++++++++++++++++++++++++++
 12 files changed, 256 insertions(+), 211 deletions(-)
 create mode 100644 include/linux/crc64.h
 create mode 100644 lib/crc64.c

-- 
2.16.3

Return-Path: <prvs=0123dbb5f9=axboe@fb.com>
From: Jens Axboe <axboe@fb.com>
To: <axboe@kernel.dk>, <linux-block@vger.kernel.org>
CC: <jack@suse.cz>
Subject: [PATCHSET] blk-wbt: cleanups
Date: Fri, 11 Nov 2016 08:21:55 -0700
Message-ID: <1478877717-19624-1-git-send-email-axboe@fb.com>
MIME-Version: 1.0
Content-Type: text/plain
List-ID: <linux-block@vger.kernel.org>

Just two smaller cleanups, since we don't support generic users of
this code anymore. The first is a prep patch, the second one gets
rid of the wrappers around the stats code.

 blk-sysfs.c |   23 +----------------------
 blk-wbt.c   |   35 +++++++++++++++++------------------
 blk-wbt.h   |   17 +++--------------
 3 files changed, 21 insertions(+), 54 deletions(-)

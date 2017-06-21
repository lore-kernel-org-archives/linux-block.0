Return-Path: <Bart.VanAssche@wdc.com>
From: Bart Van Assche <bart.vanassche@wdc.com>
To: Jens Axboe <axboe@kernel.dk>
CC: <linux-block@vger.kernel.org>, Christoph Hellwig <hch@lst.de>, "Bart Van
 Assche" <bart.vanassche@wdc.com>
Subject: [PATCH 0/3] Fixes for kernel v4.13
Date: Wed, 21 Jun 2017 10:55:44 -0700
Message-ID: <20170621175547.21692-1-bart.vanassche@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain
Return-Path: Bart.VanAssche@wdc.com
List-ID: <linux-block@vger.kernel.org>

Hello Jens,

The three patches in this series fix issues in the patches that are queued
for kernel v4.13. Please consider these for kernel v4.13.

Thanks,

Bart.

Bart Van Assche (3):
  block: Declare local symbols static
  block: Fix off-by-one errors in blk_status_to_errno() and
    print_req_error()
  blk-mq: Make it safe to quiesce and unquiesce from an interrupt
    handler

 block/blk-core.c       |  4 ++--
 block/blk-mq.c         | 20 ++++++++++++++++++--
 block/bounce.c         |  2 +-
 include/linux/blk-mq.h | 10 +---------
 4 files changed, 22 insertions(+), 14 deletions(-)

-- 
2.13.1

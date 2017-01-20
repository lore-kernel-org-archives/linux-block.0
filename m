Return-Path: <axboe@kernel.dk>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
From: Jens Axboe <axboe@kernel.dk>
Subject: [GIT PULL] Block fixes for 4.10-rc
Message-ID: <cdb5bd64-414f-4e97-d8df-717703b347b0@kernel.dk>
Date: Fri, 20 Jan 2017 12:20:47 -0800
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

Hi Linus,

Just two small fixes for this -rc. One is just killing an unused
variable from Keith, but the other fixes a performance regression for
nbd in this series, where we inadvertently flipped when we set MSG_MORE
when outputting data.

Please pull!


  git://git.kernel.dk/linux-block.git for-linus


----------------------------------------------------------------
Josef Bacik (1):
      nbd: only set MSG_MORE when we have more to send

Keith Busch (1):
      blk-mq: Remove unused variable

 block/blk-mq.c      | 1 -
 drivers/block/nbd.c | 6 ++----
 2 files changed, 2 insertions(+), 5 deletions(-)

-- 
Jens Axboe

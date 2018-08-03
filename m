Return-Path: <axboe@kernel.dk>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
From: Jens Axboe <axboe@kernel.dk>
Subject: [GIT PULL] Block fix for 4.18
Message-ID: <5388cac2-2134-b903-d41d-6228c7ce5d65@kernel.dk>
Date: Fri, 3 Aug 2018 09:13:33 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

Hi Linus,

Just a single fix, from Ming, fixing a regression in this cycle where
the busy tag iteration was changed to only calling the callback function
for requests that are started. We really want all non-free requests.
This fixes a boot regression on certain VM setups.

Please pull!


  git://git.kernel.dk/linux-block.git tags/for-linus-20180803


----------------------------------------------------------------
Ming Lei (1):
      blk-mq: fix blk_mq_tagset_busy_iter

 block/blk-mq-tag.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

-- 
Jens Axboe

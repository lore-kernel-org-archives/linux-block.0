Return-Path: <axboe@kernel.dk>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
From: Jens Axboe <axboe@kernel.dk>
Subject: [GIT PULL] Block flush handling fix
Message-ID: <b3bbb473-6518-506f-0fae-dedf26d472cb@kernel.dk>
Date: Sun, 10 Jun 2018 10:32:14 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

Hi Linus,

Single fix that we should merge now, fixing a regression in
queuing flush request, accessing request flags after calling
the end_request handler.

Please pull!


  git://git.kernel.dk/linux-block.git tags/for-linus-20180610


----------------------------------------------------------------
Jens Axboe (1):
      block: fix use-after-free in block flush handling

 block/blk-flush.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

-- 
Jens Axboe

Return-Path: <axboe@kernel.dk>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
From: Jens Axboe <axboe@kernel.dk>
Subject: [GIT PULL] Single block fix for 4.10
Message-ID: <54dbd96a-8900-1fc8-0e8b-6501bf49c567@kernel.dk>
Date: Fri, 17 Feb 2017 12:50:16 -0700
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

Hi Linus,

Single fix in this pull request, fixing a lockdep splat reported by
Thomas and Gabriel. Please pull for 4.10 final! Thanks.


  git://git.kernel.dk/linux-block.git for-linus


----------------------------------------------------------------
Jens Axboe (1):
      cfq-iosched: don't call wbt_disable_default() with IRQs disabled

 block/cfq-iosched.c | 25 +++++++++++++------------
 1 file changed, 13 insertions(+), 12 deletions(-)

-- 
Jens Axboe

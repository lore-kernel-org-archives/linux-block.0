Return-Path: <axboe@kernel.dk>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
From: Jens Axboe <axboe@kernel.dk>
Subject: [GIT PULL] Block IO fix for 4.18-rc5
Message-ID: <e486131a-7bb7-02aa-1db8-780a06fe9744@kernel.dk>
Date: Fri, 13 Jul 2018 20:51:55 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

Hi Linus,

Just a single regression fix (from 4.17) for bsg, fixing an EINVAL
return on non-data commands.

Heads-up that I'll be out until 7/23 on vacation. Will still check
emails, but sporadically.

Please pull!


  git://git.kernel.dk/linux-block.git tags/for-linus-20180713


----------------------------------------------------------------
Tony Battersby (1):
      bsg: fix bogus EINVAL on non-data commands

 block/bsg.c | 2 --
 1 file changed, 2 deletions(-)

-- 
Jens Axboe

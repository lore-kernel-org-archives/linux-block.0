Return-Path: <axboe@kernel.dk>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
From: Jens Axboe <axboe@kernel.dk>
Subject: [GIT PULL] Single block fix for 4.17-rc6
Message-ID: <29f1c531-33be-0e72-3f9d-de2a7ad68d8a@kernel.dk>
Date: Fri, 18 May 2018 08:57:20 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

Hi Linus,

Single fix this time, from Coly, fixing a failure case when
CONFIG_DEBUGFS isn't enabled.

Please pull!


  git://git.kernel.dk/linux-block.git tags/for-linus-20180518


----------------------------------------------------------------
Coly Li (1):
      bcache: return 0 from bch_debug_init() if CONFIG_DEBUG_FS=n

 drivers/md/bcache/debug.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

-- 
Jens Axboe

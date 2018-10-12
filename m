Return-Path: <axboe@kernel.dk>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
From: Jens Axboe <axboe@kernel.dk>
Subject: [GIT PULL] Block fix for 4.19-rc
Message-ID: <84f0c518-d7dd-6e54-b3ef-fb4ba15a2764@kernel.dk>
Date: Fri, 12 Oct 2018 13:16:28 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

Hi Greg,

Just a single fix that should go in, fixing a regression introduced in
the blk-wbt code.

Please pull!


  git://git.kernel.dk/linux-block.git tags/for-linus-20181012


----------------------------------------------------------------
Josef Bacik (1):
      blk-wbt: wake up all when we scale up, not down

 block/blk-wbt.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

-- 
Jens Axboe

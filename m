Return-Path: <lucmiccio@gmail.com>
Return-Path: <lucmiccio@gmail.com>
From: Luca Miccio <lucmiccio@gmail.com>
To: axboe@kernel.dk
Cc: paolo.valente@linaro.org,
	linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/1] block,bfq: Disable writeback throttling
Date: Mon,  9 Oct 2017 16:27:20 +0200
Message-Id: <20171009142721.4262-1-lucmiccio@gmail.com>
List-ID: <linux-block@vger.kernel.org>

This is the v2 of the previous patch[1]. There are
no functional changes. The only difference from v1 to
v2 is the fix of the wbt_disable_default's comment,
thanks to Lee Tibbert who pointed me out that mistake.

[1]:https://www.mail-archive.com/linux-block@vger.kernel.org/msg12806.html

Luca Miccio (1):
  block,bfq: Disable writeback throttling

 block/bfq-iosched.c | 3 ++-
 block/blk-wbt.c     | 2 +-
 2 files changed, 3 insertions(+), 2 deletions(-)

-- 
2.11.0

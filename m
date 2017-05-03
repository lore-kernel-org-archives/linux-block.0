Return-Path: <elfring@users.sourceforge.net>
To: linux-block@vger.kernel.org, Bart Van Assche
 <bart.vanassche@sandisk.com>, Jens Axboe <axboe@kernel.dk>
Cc: LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org
From: SF Markus Elfring <elfring@users.sourceforge.net>
Subject: [PATCH 0/2] blk-mq-debugfs: Fine-tuning for five function
 implementations
Message-ID: <507a3eee-6dfe-c218-1056-38221bd22be7@users.sourceforge.net>
Date: Wed, 3 May 2017 20:34:10 +0200
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Wed, 3 May 2017 20:30:40 +0200

Two update suggestions were taken into account
from static source code analysis.

Markus Elfring (2):
  Replace seven seq_puts() calls by seq_putc()
  Add spaces in queue_poll_stat_show()

 block/blk-mq-debugfs.c | 25 ++++++++++++-------------
 1 file changed, 12 insertions(+), 13 deletions(-)

-- 
2.12.2

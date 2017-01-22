Return-Path: <elfring@users.sourceforge.net>
To: linux-block@vger.kernel.org, Jens Axboe <axboe@kernel.dk>
Cc: LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org
From: SF Markus Elfring <elfring@users.sourceforge.net>
Subject: [PATCH 0/5] block: Fine-tuning for five function implementations
Message-ID: <e734cafa-eec0-9d5b-b368-2de496a96c80@users.sourceforge.net>
Date: Sun, 22 Jan 2017 09:30:09 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Sat, 21 Jan 2017 23:00:00 +0100

A few update suggestions were taken into account
from static source code analysis.

Markus Elfring (5):
  Move three assignments for the variable "ret" in tg_set_max()
  Move an assignment for the variable "ret" in tg_set_conf()
  Adjust two function calls together with a variable assignment
  Move an assignment for the variable "ret" in __cfqg_set_weight_device()
  Adjust one function call together with a variable assignment

 block/blk-throttle.c | 34 ++++++++++++++++++++--------------
 block/cfq-iosched.c  | 11 +++++++----
 2 files changed, 27 insertions(+), 18 deletions(-)

-- 
2.11.0

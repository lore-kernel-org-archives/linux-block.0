Return-Path: <axboe@kernel.dk>
From: Jens Axboe <axboe@kernel.dk>
To: linux-block@vger.kernel.org
Cc: Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 3/3] mq-deadline: add 'deadline' as a name alias
Date: Wed, 25 Oct 2017 12:04:47 -0600
Message-Id: <1508954687-3204-4-git-send-email-axboe@kernel.dk>
In-Reply-To: <1508954687-3204-1-git-send-email-axboe@kernel.dk>
References: <1508954687-3204-1-git-send-email-axboe@kernel.dk>
List-ID: <linux-block@vger.kernel.org>

The scheduler framework now supports looking up the appropriate
scheduler with the {name,mq} tupple. We can register mq-deadline
with the alias of 'deadline', so that switching to 'deadline'
will do the right thing based on the type of driver attached to
it.

Signed-off-by: Jens Axboe <axboe@kernel.dk>
---
 block/mq-deadline.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/block/mq-deadline.c b/block/mq-deadline.c
index a1cad4331edd..0179e484ec98 100644
--- a/block/mq-deadline.c
+++ b/block/mq-deadline.c
@@ -657,6 +657,7 @@ static struct elevator_type mq_deadline = {
 #endif
 	.elevator_attrs = deadline_attrs,
 	.elevator_name = "mq-deadline",
+	.elevator_alias = "deadline",
 	.elevator_owner = THIS_MODULE,
 };
 MODULE_ALIAS("mq-deadline-iosched");
-- 
2.7.4

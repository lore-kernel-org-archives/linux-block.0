Return-Path: <Bart.VanAssche@wdc.com>
From: Bart Van Assche <bart.vanassche@wdc.com>
To: Jens Axboe <axboe@kernel.dk>
CC: <linux-block@vger.kernel.org>, Christoph Hellwig <hch@lst.de>, "Bart Van
 Assche" <bart.vanassche@wdc.com>
Subject: [PATCH] block: Add fallthrough markers to switch statements
Date: Wed, 21 Jun 2017 09:40:11 -0700
Message-ID: <20170621164011.4409-1-bart.vanassche@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain
Return-Path: Bart.VanAssche@wdc.com
List-ID: <linux-block@vger.kernel.org>

This patch suppresses gcc 7 warnings about falling through in switch
statements when building with W=1. From the gcc documentation: The
-Wimplicit-fallthrough=3 warning is enabled by -Wextra. See also
https://gcc.gnu.org/onlinedocs/gcc-7.1.0/gcc/Warning-Options.html.

Signed-off-by: Bart Van Assche <bart.vanassche@wdc.com>
---
 block/badblocks.c | 1 +
 block/elevator.c  | 1 +
 block/ioprio.c    | 3 ++-
 3 files changed, 4 insertions(+), 1 deletion(-)

diff --git a/block/badblocks.c b/block/badblocks.c
index 6ebcef282314..43c71166e1e2 100644
--- a/block/badblocks.c
+++ b/block/badblocks.c
@@ -533,6 +533,7 @@ ssize_t badblocks_store(struct badblocks *bb, const char *page, size_t len,
 	case 3:
 		if (newline != '\n')
 			return -EINVAL;
+		/* fall through */
 	case 2:
 		if (length <= 0)
 			return -EINVAL;
diff --git a/block/elevator.c b/block/elevator.c
index dac99fbfc273..4bb2f0c93fa6 100644
--- a/block/elevator.c
+++ b/block/elevator.c
@@ -681,6 +681,7 @@ void __elv_add_request(struct request_queue *q, struct request *rq, int where)
 		 */
 		if (elv_attempt_insert_merge(q, rq))
 			break;
+		/* fall through */
 	case ELEVATOR_INSERT_SORT:
 		BUG_ON(blk_rq_is_passthrough(rq));
 		rq->rq_flags |= RQF_SORTED;
diff --git a/block/ioprio.c b/block/ioprio.c
index 4b120c9cf7e8..6f5d0b6625e3 100644
--- a/block/ioprio.c
+++ b/block/ioprio.c
@@ -75,7 +75,8 @@ SYSCALL_DEFINE3(ioprio_set, int, which, int, who, int, ioprio)
 		case IOPRIO_CLASS_RT:
 			if (!capable(CAP_SYS_ADMIN))
 				return -EPERM;
-			/* fall through, rt has prio field too */
+			/* fall through */
+			/* rt has prio field too */
 		case IOPRIO_CLASS_BE:
 			if (data >= IOPRIO_BE_NR || data < 0)
 				return -EINVAL;
-- 
2.13.1

Return-Path: <geliangtang@gmail.com>
Return-Path: <geliangtang@gmail.com>
From: Geliang Tang <geliangtang@gmail.com>
To: Jens Axboe <axboe@kernel.dk>
Cc: Geliang Tang <geliangtang@gmail.com>,
	linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] elevator: add fall through comment
Date: Fri, 13 Jan 2017 23:17:11 +0800
Message-Id: <4638988b826c4101d6fb461a775a8dae74f1f94a.1483524561.git.geliangtang@gmail.com>
In-Reply-To: <5b23d0cb523f4719673a462ab1569ae99084337e.1483685419.git.geliangtang@gmail.com>
References: <5b23d0cb523f4719673a462ab1569ae99084337e.1483685419.git.geliangtang@gmail.com>
List-ID: <linux-block@vger.kernel.org>

Add fall through comment for ELEVATOR_INSERT_SORT_MERGE.

Signed-off-by: Geliang Tang <geliangtang@gmail.com>
---
 block/elevator.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/block/elevator.c b/block/elevator.c
index 40f0c04..6db8f89 100644
--- a/block/elevator.c
+++ b/block/elevator.c
@@ -638,6 +638,7 @@ void __elv_add_request(struct request_queue *q, struct request *rq, int where)
 		 */
 		if (elv_attempt_insert_merge(q, rq))
 			break;
+		/* Fall through */
 	case ELEVATOR_INSERT_SORT:
 		BUG_ON(rq->cmd_type != REQ_TYPE_FS);
 		rq->rq_flags |= RQF_SORTED;
-- 
2.9.3

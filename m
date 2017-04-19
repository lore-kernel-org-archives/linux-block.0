Return-Path: <Bart.VanAssche@sandisk.com>
From: Bart Van Assche <bart.vanassche@sandisk.com>
To: Jens Axboe <axboe@kernel.dk>
CC: <linux-block@vger.kernel.org>, Bart Van Assche
	<bart.vanassche@sandisk.com>, =?UTF-8?q?Matias=20Bj=C3=B8rling?=
	<m@bjorling.me>
Subject: [PATCH v2 5/5] block: Optimize ioprio_best()
Date: Wed, 19 Apr 2017 14:01:28 -0700
Message-ID: <20170419210128.28374-6-bart.vanassche@sandisk.com>
In-Reply-To: <20170419210128.28374-1-bart.vanassche@sandisk.com>
References: <20170419210128.28374-1-bart.vanassche@sandisk.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-Path: Bart.VanAssche@sandisk.com
List-ID: <linux-block@vger.kernel.org>

Since ioprio_best() translates IOPRIO_CLASS_NONE into IOPRIO_CLASS_BE
and since lower numerical priority values represent a higher priority
a simple numerical comparison is sufficient.

Signed-off-by: Bart Van Assche <bart.vanassche@sandisk.com>
Reviewed-by: Adam Manzanares <adam.manzanares@wdc.com>
Tested-by: Adam Manzanares <adam.manzanares@wdc.com>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Cc: Matias Bjørling <m@bjorling.me>
---
 block/ioprio.c | 12 +-----------
 1 file changed, 1 insertion(+), 11 deletions(-)

diff --git a/block/ioprio.c b/block/ioprio.c
index 0c47a00f92a8..4b120c9cf7e8 100644
--- a/block/ioprio.c
+++ b/block/ioprio.c
@@ -163,22 +163,12 @@ static int get_task_ioprio(struct task_struct *p)
 
 int ioprio_best(unsigned short aprio, unsigned short bprio)
 {
-	unsigned short aclass;
-	unsigned short bclass;
-
 	if (!ioprio_valid(aprio))
 		aprio = IOPRIO_PRIO_VALUE(IOPRIO_CLASS_BE, IOPRIO_NORM);
 	if (!ioprio_valid(bprio))
 		bprio = IOPRIO_PRIO_VALUE(IOPRIO_CLASS_BE, IOPRIO_NORM);
 
-	aclass = IOPRIO_PRIO_CLASS(aprio);
-	bclass = IOPRIO_PRIO_CLASS(bprio);
-	if (aclass == bclass)
-		return min(aprio, bprio);
-	if (aclass > bclass)
-		return bprio;
-	else
-		return aprio;
+	return min(aprio, bprio);
 }
 
 SYSCALL_DEFINE2(ioprio_get, int, which, int, who)
-- 
2.12.2

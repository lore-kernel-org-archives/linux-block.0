Return-Path: <linux-ide-owner@vger.kernel.org>
Date: Mon, 2 Apr 2018 15:05:58 -0700
From: Tejun Heo <tj@kernel.org>
To: Meelis Roos <mroos@linux.ee>
Cc: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Linux Kernel list <linux-kernel@vger.kernel.org>,
        linux-ide@vger.kernel.org, linux-block@vger.kernel.org
Subject: Re: 4.16-rc2+git: pata_serverworks: hanging ata detection thread on
 HP DL380G3
Message-ID: <20180402220558.GK388343@devbig577.frc2.facebook.com>
References: <alpine.LRH.2.21.1802261049140.4893@math.ut.ee>
 <alpine.LRH.2.21.1803291153070.12825@math.ut.ee>
 <CGME20180329101255epcas2p22aeb95d869cdd2954bb9183037dace5f@epcas2p2.samsung.com>
 <1597679.yzYZqmDdA5@amdc3058>
 <alpine.LRH.2.21.1803301144380.11026@math.ut.ee>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <alpine.LRH.2.21.1803301144380.11026@math.ut.ee>
Sender: linux-ide-owner@vger.kernel.org
List-ID: <linux-block@vger.kernel.org>

Hello, Meelis.

Can you please verify whether the following patch fixes the problem?

Thanks.

Subject: blk-mq: Directly schedule q->timeout_work when aborting a request

Request abortion is performed by overriding deadline to now and
scheduling timeout handling immediately.  For the latter part, the
code was using mod_timer(timeout, 0) which can't guarantee that the
timer runs afterwards.  Let's schedule the underlying work item
directly instead.

This fixes the hangs during probing reported by Sitsofe but it isn't
yet clear to me how the failure can happen reliably if it's just the
above described race condition.

Signed-off-by: Tejun Heo <tj@kernel.org>
Reported-by: Sitsofe Wheeler <sitsofe@gmail.com>
Reported-by: Meelis Roos <mroos@linux.ee>
---
 block/blk-timeout.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/block/blk-timeout.c b/block/blk-timeout.c
index a05e367..f0e6e41 100644
--- a/block/blk-timeout.c
+++ b/block/blk-timeout.c
@@ -165,7 +165,7 @@ void blk_abort_request(struct request *req)
 		 * No need for fancy synchronizations.
 		 */
 		blk_rq_set_deadline(req, jiffies);
-		mod_timer(&req->q->timeout, 0);
+		kblockd_schedule_work(&req->q->timeout_work);
 	} else {
 		if (blk_mark_rq_complete(req))
 			return;

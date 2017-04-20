Return-Path: <colin.king@canonical.com>
From: Colin King <colin.king@canonical.com>
To: Paolo Valente <paolo.valente@linaro.org>,
	Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org
Cc: kernel-janitors@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH][-next] block, bfq: don't dereference bic before null checking it
Date: Thu, 20 Apr 2017 15:07:18 +0100
Message-Id: <20170420140718.19694-1-colin.king@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
List-ID: <linux-block@vger.kernel.org>

From: Colin Ian King <colin.king@canonical.com>

The call to bfq_check_ioprio_change will dereference bic, however,
the null check for bic is after this call.  Move the the null
check on bic to before the call to avoid any potential null
pointer dereference issues.

Detected by CoverityScan, CID#1430138 ("Dereference before null check")

Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 block/bfq-iosched.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/block/bfq-iosched.c b/block/bfq-iosched.c
index 6d14f18c0d45..bd8499ef157c 100644
--- a/block/bfq-iosched.c
+++ b/block/bfq-iosched.c
@@ -4401,11 +4401,11 @@ static int bfq_get_rq_private(struct request_queue *q, struct request *rq,
 
 	spin_lock_irq(&bfqd->lock);
 
-	bfq_check_ioprio_change(bic, bio);
-
 	if (!bic)
 		goto queue_fail;
 
+	bfq_check_ioprio_change(bic, bio);
+
 	bfq_bic_update_cgroup(bic, bio);
 
 	bfqq = bfq_get_bfqq_handle_split(bfqd, bic, bio, false, is_sync,
-- 
2.11.0

Return-Path: <yuehaibing@huawei.com>
From: YueHaibing <yuehaibing@huawei.com>
To: Jens Axboe <axboe@kernel.dk>
CC: YueHaibing <yuehaibing@huawei.com>, <linux-block@vger.kernel.org>,
	<kernel-janitors@vger.kernel.org>
Subject: [PATCH -next] blk-iolatency: remove set but not used variables 'changed' and 'blkiolat'
Date: Fri, 14 Sep 2018 01:35:11 +0000
Message-ID: <1536888911-54172-1-git-send-email-yuehaibing@huawei.com>
Content-Type: text/plain; charset="ISO-8859-1"
MIME-Version: 1.0
List-ID: <linux-block@vger.kernel.org>

Fixes gcc '-Wunused-but-set-variable' warning:

block/blk-iolatency.c: In function 'scale_change':
block/blk-iolatency.c:301:7: warning:
 variable 'changed' set but not used [-Wunused-but-set-variable]

block/blk-iolatency.c: In function 'iolatency_set_limit':
block/blk-iolatency.c:765:24: warning:
 variable 'blkiolat' set but not used [-Wunused-but-set-variable]

Signed-off-by: YueHaibing <yuehaibing@huawei.com>
---
 block/blk-iolatency.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/block/blk-iolatency.c b/block/blk-iolatency.c
index 8793f13..d048a92 100644
--- a/block/blk-iolatency.c
+++ b/block/blk-iolatency.c
@@ -298,7 +298,6 @@ static void scale_change(struct iolatency_grp *iolat, bool up)
 	unsigned long qd = blk_queue_depth(iolat->blkiolat->rqos.q);
 	unsigned long scale = scale_amount(qd, up);
 	unsigned long old = iolat->rq_depth.max_depth;
-	bool changed = false;
 
 	if (old > qd)
 		old = qd;
@@ -308,7 +307,6 @@ static void scale_change(struct iolatency_grp *iolat, bool up)
 			return;
 
 		if (old < qd) {
-			changed = true;
 			old += scale;
 			old = min(old, qd);
 			iolat->rq_depth.max_depth = old;
@@ -316,7 +314,6 @@ static void scale_change(struct iolatency_grp *iolat, bool up)
 		}
 	} else if (old > 1) {
 		old >>= 1;
-		changed = true;
 		iolat->rq_depth.max_depth = max(old, 1UL);
 	}
 }
@@ -762,7 +759,6 @@ static ssize_t iolatency_set_limit(struct kernfs_open_file *of, char *buf,
 {
 	struct blkcg *blkcg = css_to_blkcg(of_css(of));
 	struct blkcg_gq *blkg;
-	struct blk_iolatency *blkiolat;
 	struct blkg_conf_ctx ctx;
 	struct iolatency_grp *iolat;
 	char *p, *tok;
@@ -775,7 +771,6 @@ static ssize_t iolatency_set_limit(struct kernfs_open_file *of, char *buf,
 		return ret;
 
 	iolat = blkg_to_lat(ctx.blkg);
-	blkiolat = iolat->blkiolat;
 	p = ctx.body;
 
 	ret = -EINVAL;

Return-Path: <zhongjiang@huawei.com>
From: zhong jiang <zhongjiang@huawei.com>
To: <axboe@kernel.dk>
CC: <linux-block@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH] block/bsg-lib: use PTR_ERR_OR_ZERO to simplify the flow path
Date: Wed, 1 Aug 2018 00:13:14 +0800
Message-ID: <1533053594-35244-1-git-send-email-zhongjiang@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
List-ID: <linux-block@vger.kernel.org>

Simplify the code by using the PTR_ERR_OR_ZERO, instead of the
open code. It is better.

Signed-off-by: zhong jiang <zhongjiang@huawei.com>
---
 block/bsg-lib.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/block/bsg-lib.c b/block/bsg-lib.c
index 9419def..f3501cd 100644
--- a/block/bsg-lib.c
+++ b/block/bsg-lib.c
@@ -48,9 +48,8 @@ static int bsg_transport_fill_hdr(struct request *rq, struct sg_io_v4 *hdr,
 
 	job->request_len = hdr->request_len;
 	job->request = memdup_user(uptr64(hdr->request), hdr->request_len);
-	if (IS_ERR(job->request))
-		return PTR_ERR(job->request);
-	return 0;
+
+	return PTR_ERR_OR_ZERO(job->request);
 }
 
 static int bsg_transport_complete_rq(struct request *rq, struct sg_io_v4 *hdr)
-- 
1.7.12.4

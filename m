Return-Path: <elfring@users.sourceforge.net>
Subject: [PATCH 2/5] blk-throttle: Move an assignment for the variable "ret"
 in tg_set_conf()
To: linux-block@vger.kernel.org, Jens Axboe <axboe@kernel.dk>
References: <e734cafa-eec0-9d5b-b368-2de496a96c80@users.sourceforge.net>
Cc: LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org
From: SF Markus Elfring <elfring@users.sourceforge.net>
Message-ID: <d20da6bc-b84a-3b2c-614c-68ace67db7e0@users.sourceforge.net>
Date: Sun, 22 Jan 2017 09:32:19 +0100
MIME-Version: 1.0
In-Reply-To: <e734cafa-eec0-9d5b-b368-2de496a96c80@users.sourceforge.net>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Sat, 21 Jan 2017 21:40:38 +0100

A local variable was set to an error code before a concrete error situation
was detected. Thus move the corresponding assignment into an if branch
to indicate a software failure there.

This issue was detected by using the Coccinelle software.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
---
 block/blk-throttle.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/block/blk-throttle.c b/block/blk-throttle.c
index 51d112deb02e..b392b48310ba 100644
--- a/block/blk-throttle.c
+++ b/block/blk-throttle.c
@@ -1191,9 +1191,10 @@ static ssize_t tg_set_conf(struct kernfs_open_file *of,
 	if (ret)
 		return ret;
 
-	ret = -EINVAL;
-	if (sscanf(ctx.body, "%llu", &v) != 1)
+	if (sscanf(ctx.body, "%llu", &v) != 1) {
+		ret = -EINVAL;
 		goto out_finish;
+	}
 	if (!v)
 		v = -1;
 
-- 
2.11.0

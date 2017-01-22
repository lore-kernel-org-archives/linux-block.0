Return-Path: <elfring@users.sourceforge.net>
Subject: [PATCH 1/5] blk-throttle: Move three assignments for the variable
 "ret" in tg_set_max()
To: linux-block@vger.kernel.org, Jens Axboe <axboe@kernel.dk>
References: <e734cafa-eec0-9d5b-b368-2de496a96c80@users.sourceforge.net>
Cc: LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org
From: SF Markus Elfring <elfring@users.sourceforge.net>
Message-ID: <75495d45-cfc4-9740-39e4-bd4c3e71232b@users.sourceforge.net>
Date: Sun, 22 Jan 2017 09:31:29 +0100
MIME-Version: 1.0
In-Reply-To: <e734cafa-eec0-9d5b-b368-2de496a96c80@users.sourceforge.net>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Sat, 21 Jan 2017 21:23:06 +0100

A local variable was set to an error code before a concrete error situation
was detected. Thus move the corresponding assignments into if branches
to indicate a software failure there.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
---
 block/blk-throttle.c | 23 +++++++++++++----------
 1 file changed, 13 insertions(+), 10 deletions(-)

diff --git a/block/blk-throttle.c b/block/blk-throttle.c
index 6f4c96e5f86b..51d112deb02e 100644
--- a/block/blk-throttle.c
+++ b/block/blk-throttle.c
@@ -1327,27 +1327,30 @@ static ssize_t tg_set_max(struct kernfs_open_file *of,
 			break;
 		ctx.body += len;
 
-		ret = -EINVAL;
 		p = tok;
 		strsep(&p, "=");
-		if (!p || (sscanf(p, "%llu", &val) != 1 && strcmp(p, "max")))
+		if (!p || (sscanf(p, "%llu", &val) != 1 && strcmp(p, "max"))) {
+			ret = -EINVAL;
 			goto out_finish;
+		}
 
-		ret = -ERANGE;
-		if (!val)
+		if (!val) {
+			ret = -ERANGE;
 			goto out_finish;
+		}
 
-		ret = -EINVAL;
-		if (!strcmp(tok, "rbps"))
+		if (!strcmp(tok, "rbps")) {
 			v[0] = val;
-		else if (!strcmp(tok, "wbps"))
+		} else if (!strcmp(tok, "wbps")) {
 			v[1] = val;
-		else if (!strcmp(tok, "riops"))
+		} else if (!strcmp(tok, "riops")) {
 			v[2] = min_t(u64, val, UINT_MAX);
-		else if (!strcmp(tok, "wiops"))
+		} else if (!strcmp(tok, "wiops")) {
 			v[3] = min_t(u64, val, UINT_MAX);
-		else
+		} else {
+			ret = -EINVAL;
 			goto out_finish;
+		}
 	}
 
 	tg->bps[READ] = v[0];
-- 
2.11.0

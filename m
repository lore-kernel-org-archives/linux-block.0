Return-Path: <elfring@users.sourceforge.net>
Subject: [PATCH 4/5] cfq-iosched: Move an assignment for the variable "ret" in
 __cfqg_set_weight_device()
To: linux-block@vger.kernel.org, Jens Axboe <axboe@kernel.dk>
References: <e734cafa-eec0-9d5b-b368-2de496a96c80@users.sourceforge.net>
Cc: LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org
From: SF Markus Elfring <elfring@users.sourceforge.net>
Message-ID: <66f510a1-432a-260b-2785-6274a3e263b5@users.sourceforge.net>
Date: Sun, 22 Jan 2017 09:34:03 +0100
MIME-Version: 1.0
In-Reply-To: <e734cafa-eec0-9d5b-b368-2de496a96c80@users.sourceforge.net>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Sat, 21 Jan 2017 22:26:38 +0100

A local variable was set to an error code before a concrete error situation
was detected. Thus move the corresponding assignment into an if branch
to indicate a software failure there.

This issue was detected by using the Coccinelle software.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
---
 block/cfq-iosched.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/block/cfq-iosched.c b/block/cfq-iosched.c
index c73a6fcaeb9d..454297fe8fd6 100644
--- a/block/cfq-iosched.c
+++ b/block/cfq-iosched.c
@@ -1788,9 +1788,10 @@ static ssize_t __cfqg_set_weight_device(struct kernfs_open_file *of,
 
 	if (sscanf(ctx.body, "%llu", &v) == 1) {
 		/* require "default" on dfl */
-		ret = -ERANGE;
-		if (!v && on_dfl)
+		if (!v && on_dfl) {
+			ret = -ERANGE;
 			goto out_finish;
+		}
 	} else if (!strcmp(strim(ctx.body), "default")) {
 		v = 0;
 	} else {
-- 
2.11.0

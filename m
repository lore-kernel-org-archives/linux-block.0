Return-Path: <elfring@users.sourceforge.net>
Subject: [PATCH 5/5] cfq-iosched: Adjust one function call together with a
 variable assignment
To: linux-block@vger.kernel.org, Jens Axboe <axboe@kernel.dk>
References: <e734cafa-eec0-9d5b-b368-2de496a96c80@users.sourceforge.net>
Cc: LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org
From: SF Markus Elfring <elfring@users.sourceforge.net>
Message-ID: <f28c7ce0-ae89-4eb5-8270-4ab300caa98b@users.sourceforge.net>
Date: Sun, 22 Jan 2017 09:35:13 +0100
MIME-Version: 1.0
In-Reply-To: <e734cafa-eec0-9d5b-b368-2de496a96c80@users.sourceforge.net>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Sat, 21 Jan 2017 22:44:07 +0100

The script "checkpatch.pl" pointed information out like the following.

ERROR: do not use assignment in if condition

Thus fix the affected source code place.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
---
 block/cfq-iosched.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/block/cfq-iosched.c b/block/cfq-iosched.c
index 454297fe8fd6..8c405eaa2806 100644
--- a/block/cfq-iosched.c
+++ b/block/cfq-iosched.c
@@ -2750,9 +2750,11 @@ static struct cfq_queue *cfq_get_next_queue_forced(struct cfq_data *cfqd)
 	if (!cfqg)
 		return NULL;
 
-	for_each_cfqg_st(cfqg, i, j, st)
-		if ((cfqq = cfq_rb_first(st)) != NULL)
+	for_each_cfqg_st(cfqg, i, j, st) {
+		cfqq = cfq_rb_first(st);
+		if (cfqq)
 			return cfqq;
+	}
 	return NULL;
 }
 
-- 
2.11.0

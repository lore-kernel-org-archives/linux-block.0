Return-Path: <thomas@m3y3r.de>
Subject: [PATCH] bfq: Fix bool initialization/comparison
From: Thomas Meyer <thomas@m3y3r.de>
To: paolo.valente@linaro.org, axboe@kernel.dk, linux-block@vger.kernel.org,
 linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Message-ID: <1507383097082-1668690714-1-diffsplit-thomas@m3y3r.de>
References: <1507383097081-778026979-0-diffsplit-thomas@m3y3r.de>
In-Reply-To: <1507383097081-778026979-0-diffsplit-thomas@m3y3r.de>
Date: Sat, 07 Oct 2017 16:02:21 +0200
List-ID: <linux-block@vger.kernel.org>

Bool initializations should use true and false. Bool tests don't need
comparisons.

Signed-off-by: Thomas Meyer <thomas@m3y3r.de>
---

diff -u -p a/block/bfq-iosched.c b/block/bfq-iosched.c
--- a/block/bfq-iosched.c
+++ b/block/bfq-iosched.c
@@ -4986,7 +4986,7 @@ static ssize_t bfq_low_latency_store(str
 
 	if (__data > 1)
 		__data = 1;
-	if (__data == 0 && bfqd->low_latency != 0)
+	if (__data == 0 && bfqd->low_latency)
 		bfq_end_wr(bfqd);
 	bfqd->low_latency = __data;
 

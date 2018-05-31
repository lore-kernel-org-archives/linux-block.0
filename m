Return-Path: <paolo.valente@linaro.org>
Return-Path: <paolo.valente@linaro.org>
From: Paolo Valente <paolo.valente@linaro.org>
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	ulf.hansson@linaro.org,
	broonie@kernel.org,
	linus.walleij@linaro.org,
	bfq-iosched@googlegroups.com,
	oleksandr@natalenko.name,
	sapienza.dav@gmail.com,
	177992@studenti.unimore.it,
	Paolo Valente <paolo.valente@linaro.org>
Subject: [PATCH BUGFIX/IMPROVEMENTS 3/4] block, bfq: increase weight-raising duration for interactive apps
Date: Thu, 31 May 2018 16:45:07 +0200
Message-Id: <20180531144508.3927-4-paolo.valente@linaro.org>
In-Reply-To: <20180531144508.3927-1-paolo.valente@linaro.org>
References: <20180531144508.3927-1-paolo.valente@linaro.org>
List-ID: <linux-block@vger.kernel.org>

From: Davide Sapienza <sapienza.dav@gmail.com>

The maximum possible duration of the weight-raising period for
interactive applications is limited to 13 seconds, as this is the time
needed to load the largest application that we considered when tuning
weight raising. Unfortunately, in such an evaluation, we did not
consider the case of very slow virtual machines.

For example, on a QEMU/KVM virtual machine
- running in a slow PC;
- with a virtual disk stacked on a slow low-end 5400rpm HDD;
- serving a heavy I/O workload, such as the sequential reading of
several files;
mplayer takes 23 seconds to start, if constantly weight-raised.

To address this issue, this commit conservatively sets the upper limit
for weight-raising duration to 25 seconds.

Signed-off-by: Davide Sapienza <sapienza.dav@gmail.com>
Signed-off-by: Paolo Valente <paolo.valente@linaro.org>
---
 block/bfq-iosched.c | 26 +++++++++++++++-----------
 1 file changed, 15 insertions(+), 11 deletions(-)

diff --git a/block/bfq-iosched.c b/block/bfq-iosched.c
index 262c929e24ee..31ce089d54eb 100644
--- a/block/bfq-iosched.c
+++ b/block/bfq-iosched.c
@@ -930,22 +930,26 @@ static unsigned int bfq_wr_duration(struct bfq_data *bfqd)
 	do_div(dur, bfqd->peak_rate);
 
 	/*
-	 * Limit duration between 3 and 13 seconds. Tests show that
-	 * higher values than 13 seconds often yield the opposite of
-	 * the desired result, i.e., worsen responsiveness by letting
-	 * non-interactive and non-soft-real-time applications
-	 * preserve weight raising for a too long time interval.
+	 * Limit duration between 3 and 25 seconds. The upper limit
+	 * has been conservatively set after the following worst case:
+	 * on a QEMU/KVM virtual machine
+	 * - running in a slow PC
+	 * - with a virtual disk stacked on a slow low-end 5400rpm HDD
+	 * - serving a heavy I/O workload, such as the sequential reading
+	 *   of several files
+	 * mplayer took 23 seconds to start, if constantly weight-raised.
+	 *
+	 * As for higher values than that accomodating the above bad
+	 * scenario, tests show that higher values would often yield
+	 * the opposite of the desired result, i.e., would worsen
+	 * responsiveness by allowing non-interactive applications to
+	 * preserve weight raising for too long.
 	 *
 	 * On the other end, lower values than 3 seconds make it
 	 * difficult for most interactive tasks to complete their jobs
 	 * before weight-raising finishes.
 	 */
-	if (dur > msecs_to_jiffies(13000))
-		dur = msecs_to_jiffies(13000);
-	else if (dur < msecs_to_jiffies(3000))
-		dur = msecs_to_jiffies(3000);
-
-	return dur;
+	return clamp_val(dur, msecs_to_jiffies(3000), msecs_to_jiffies(25000));
 }
 
 /* switch back from soft real-time to interactive weight raising */
-- 
2.16.1

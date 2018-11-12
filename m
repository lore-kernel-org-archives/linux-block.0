Return-Path: <paolo.valente@linaro.org>
Return-Path: <paolo.valente@linaro.org>
From: Paolo Valente <paolo.valente@linaro.org>
To: Jens Axboe <axboe@kernel.dk>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Tejun Heo <tj@kernel.org>,
	Li Zefan <lizefan@huawei.com>,
	Angelo Ruocco <angeloruocco90@gmail.com>,
	Dennis Zhou <dennis@kernel.org>,
	Josef Bacik <josef@toxicpanda.com>,
	Liu Bo <bo.liu@linux.alibaba.com>,
	Bart Van Assche <bvanassche@acm.org>,
	Johannes Weiner <hannes@cmpxchg.org>
Cc: linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	ulf.hansson@linaro.org,
	linus.walleij@linaro.org,
	broonie@kernel.org,
	bfq-iosched@googlegroups.com,
	oleksandr@natalenko.name,
	cgroups@vger.kernel.org,
	linux-doc@vger.kernel.org,
	Jonathan Corbet <corbet@lwn.net>,
	Paolo Valente <paolo.valente@linaro.org>
Subject: [PATCH 10/12] block, throttle: allow sharing cgroup statistic files
Date: Mon, 12 Nov 2018 10:56:30 +0100
Message-Id: <20181112095632.69114-11-paolo.valente@linaro.org>
In-Reply-To: <20181112095632.69114-1-paolo.valente@linaro.org>
References: <20181112095632.69114-1-paolo.valente@linaro.org>
List-ID: <linux-block@vger.kernel.org>

From: Angelo Ruocco <angeloruocco90@gmail.com>

Some of the cgroup files defined in the throttle policy have the same
meaning as those defined in the proportional share policy.

This commit uses the new file sharing interface in cgroup to share
these files.

Signed-off-by: Angelo Ruocco <angeloruocco90@gmail.com>
Signed-off-by: Paolo Valente <paolo.valente@linaro.org>
---
 block/blk-throttle.c | 16 ++++++++++++----
 1 file changed, 12 insertions(+), 4 deletions(-)

diff --git a/block/blk-throttle.c b/block/blk-throttle.c
index 5c43821dc528..239957c12d34 100644
--- a/block/blk-throttle.c
+++ b/block/blk-throttle.c
@@ -1491,22 +1491,30 @@ static struct cftype throtl_legacy_files[] = {
 		.write = tg_set_conf_uint,
 	},
 	{
-		.name = "throttle.io_service_bytes",
+		.name = "io_service_bytes",
+		.owner_name = "throttle",
+		.flags = CFTYPE_SHARES_FILE,
 		.private = (unsigned long)&blkcg_policy_throtl,
 		.seq_show_cft = blkg_print_stat_bytes,
 	},
 	{
-		.name = "throttle.io_service_bytes_recursive",
+		.name = "io_service_bytes_recursive",
+		.owner_name = "throttle",
+		.flags = CFTYPE_SHARES_FILE,
 		.private = (unsigned long)&blkcg_policy_throtl,
 		.seq_show_cft = blkg_print_stat_bytes_recursive,
 	},
 	{
-		.name = "throttle.io_serviced",
+		.name = "io_serviced",
+		.owner_name = "throttle",
+		.flags = CFTYPE_SHARES_FILE,
 		.private = (unsigned long)&blkcg_policy_throtl,
 		.seq_show_cft = blkg_print_stat_ios,
 	},
 	{
-		.name = "throttle.io_serviced_recursive",
+		.name = "io_serviced_recursive",
+		.owner_name = "throttle",
+		.flags = CFTYPE_SHARES_FILE,
 		.private = (unsigned long)&blkcg_policy_throtl,
 		.seq_show_cft = blkg_print_stat_ios_recursive,
 	},
-- 
2.16.1

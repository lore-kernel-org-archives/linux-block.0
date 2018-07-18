Return-Path: <raghuhack78@gmail.com>
Return-Path: <raghuhack78@gmail.com>
From: RAGHU Halharvi <raghuhack78@gmail.com>
To: linux-kernel@vger.kernel.org,
	linux-block@vger.kernel.org
Cc: RAGHU Halharvi <raghuhack78@gmail.com>,
	axboe@kernel.dk
Subject: [PATCH] pktcdvd:checkpatch:remove static initialise null
Date: Wed, 18 Jul 2018 20:25:50 +0530
Message-Id: <20180718145550.3894-1-raghuhack78@gmail.com>
List-ID: <linux-block@vger.kernel.org>

*  Remove checkpatch error due to initialization of static variables to
NULL

Signed-off-by: RAGHU Halharvi <raghuhack78@gmail.com>
---
 drivers/block/pktcdvd.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/block/pktcdvd.c b/drivers/block/pktcdvd.c
index a4b4d524c3af..a7dbb7157115 100644
--- a/drivers/block/pktcdvd.c
+++ b/drivers/block/pktcdvd.c
@@ -100,8 +100,8 @@ static struct mutex ctl_mutex;	/* Serialize open/close/setup/teardown */
 static mempool_t psd_pool;
 static struct bio_set pkt_bio_set;
 
-static struct class	*class_pktcdvd = NULL;    /* /sys/class/pktcdvd */
-static struct dentry	*pkt_debugfs_root = NULL; /* /sys/kernel/debug/pktcdvd */
+static struct class	*class_pktcdvd;    /* /sys/class/pktcdvd */
+static struct dentry	*pkt_debugfs_root; /* /sys/kernel/debug/pktcdvd */
 
 /* forward declaration */
 static int pkt_setup_dev(dev_t dev, dev_t* pkt_dev);
-- 
2.17.1

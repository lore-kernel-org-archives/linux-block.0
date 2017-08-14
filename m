Return-Path: <oleksandr@redhat.com>
Return-Path: <oleksandr@redhat.com>
From: Oleksandr Natalenko <oleksandr@redhat.com>
To: linux-block@vger.kernel.org
Cc: axboe@kernel.dk,
	linux-kernel@vger.kernel.org
Subject: [RFC] block: deprecate choosing elevator via boot param
Date: Mon, 14 Aug 2017 11:27:12 +0200
Message-Id: <20170814092712.14062-1-oleksandr@redhat.com>
List-ID: <linux-block@vger.kernel.org>

Setting I/O scheduler via kernel command line is not flexible enough
anymore. Different schedulers might be desirable for different types
of devices (SSDs and HDDs, for instance). Moreover, setting elevator
while using blk-mq framework does not work in this way already.

This commit enables warning if user specifies "elevator" boot param.
Removing this option at all might be considered in some future.

Signed-off-by: Oleksandr Natalenko <oleksandr@redhat.com>
---
 block/elevator.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/block/elevator.c b/block/elevator.c
index 4bb2f0c93fa6..9ade7e12e417 100644
--- a/block/elevator.c
+++ b/block/elevator.c
@@ -130,6 +130,9 @@ static int __init elevator_setup(char *str)
 	 * Be backwards-compatible with previous kernels, so users
 	 * won't get the wrong elevator.
 	 */
+	printk(KERN_WARNING
+		"Setting I/O scheduler via kernel command line " \
+		"is deprecated. Use udev rule instead.");
 	strncpy(chosen_elevator, str, sizeof(chosen_elevator) - 1);
 	return 1;
 }
-- 
2.14.1

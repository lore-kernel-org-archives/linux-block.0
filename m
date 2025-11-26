Received: from wxsgout04.xfusion.com (wxsgout04.xfusion.com [36.139.87.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93C383043C4;
	Wed, 26 Nov 2025 14:41:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=36.139.87.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764168068; cv=none; b=OsDQZr8q1W00IjM965Y93htkMOFLqQ3iF5N2H6SsP1D41w3BnZ4UFRH7IuKu3CZHVra2MBEFekQhfsXKU+5jz/W4IpFlrseujSCJrR5Mx6Q0zsXo6e7lDm5N5tXL5CeoAaTbfrMjiGBpz8BhK6ypHxqkc/7Lel5arDH5CTogkE0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764168068; c=relaxed/simple;
	bh=kAcLms6LyJfgj/Yr9T5p2bImI6V6VkPM21oqIfO8+jo=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=AyEQJUEBhvxtl9CUuKCc7Fiinm5Zpx8H9CEriE4aQ21bLVAWwth8K0I1rIBXxO2qv8qhtHc4k9P2+YCBebZzi0gPhdkc9kan4aFavSfXlsS8yyAW0u4Qbhd0TisqDlgZBnJtE78n94eUFqnDjQafRwsaIz1S/nCoxO+gDFLwefo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xfusion.com; spf=pass smtp.mailfrom=xfusion.com; arc=none smtp.client-ip=36.139.87.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xfusion.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xfusion.com
Received: from wuxpheds03048.xfusion.com (unknown [10.32.143.30])
	by wxsgout04.xfusion.com (SkyGuard) with ESMTPS id 4dGhxF3JHYzBDTTC;
	Wed, 26 Nov 2025 22:37:53 +0800 (CST)
Received: from DESKTOP-Q8I2N5U.xfusion.com (10.82.130.100) by
 wuxpheds03048.xfusion.com (10.32.143.30) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_RSA_WITH_AES_128_CBC_SHA256) id 15.2.2562.20;
 Wed, 26 Nov 2025 22:40:48 +0800
From: shechenglong <shechenglong@xfusion.com>
To: <axboe@kernel.dk>
CC: <linux-block@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<stone.xulei@xfusion.com>, <chenjialong@xfusion.com>, shechenglong
	<shechenglong@xfusion.com>
Subject: [RESEND PATCH] null_blk: align struct nullb_device field types with module parameters
Date: Wed, 26 Nov 2025 22:39:57 +0800
Message-ID: <20251126143957.1085-1-shechenglong@xfusion.com>
X-Mailer: git-send-email 2.37.1.windows.1
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: wuxpheds03045.xfusion.com (10.32.131.99) To
 wuxpheds03048.xfusion.com (10.32.143.30)

The struct nullb_device previously used generic int types for several
fields that represent boolean flags, unsigned counters, or large size
values. This patch updates the field types to improve type safety and
match the corresponding module parameters:

- Change boolean fields to bool (e.g., no_sched, virt_boundary)
- Change counters and queue-related fields to unsigned int
- Change size-related fields (size, cache_size, zone_size, zone_capacity)
  to unsigned long

This ensures consistency between module_param declarations and internal
data structures, prevents negative values for unsigned parameters.
The output of modinfo before and after applying this patch is as follows:

Before:
[...]
parm:           no_sched:No io scheduler (int)
parm:           submit_queues:Number of submission queues (int)
parm:           poll_queues:Number of IOPOLL submission queues (int)
parm:           home_node:Home node for the device (int)
[...]
parm:           gb:Size in GB (int)
parm:           bs:Block size (in bytes) (int)
parm:           max_sectors:Maximum size of a command
                (in 512B sectors) (int)
[...]
parm:           hw_queue_depth:Queue depth for each hardware queue. 
                Default: 64 (int)
[...]
parm:           zone_append_max_sectors:Maximum size of a zone append 
                command (in 512B sectors). Specify 0 for zone append
                emulation (int)

After:
[...]
parm:           no_sched:No io scheduler (bool)
parm:           submit_queues:Number of submission queues (uint)
parm:           poll_queues:Number of IOPOLL submission queues (uint)
parm:           home_node:Home node for the device (uint)
[...]
parm:           gb:Size in GB (ulong)
parm:           bs:Block size (in bytes) (uint)
parm:           max_sectors:Maximum size of a command
                (in 512B sectors) (uint)
[...]
parm:           hw_queue_depth:Queue depth for each hardware queue.
                Default: 64 (uint)
[...]
parm:           zone_append_max_sectors:Maximum size of a zone append
                command (in 512B sectors). Specify 0 for zone append
                emulation (uint)
Signed-off-by: shechenglong <shechenglong@xfusion.com>
---
 drivers/block/null_blk/main.c | 36 +++++++++++++++++------------------
 1 file changed, 18 insertions(+), 18 deletions(-)

diff --git a/drivers/block/null_blk/main.c b/drivers/block/null_blk/main.c
index 0ee55f889cfd..544009297458 100644
--- a/drivers/block/null_blk/main.c
+++ b/drivers/block/null_blk/main.c
@@ -81,20 +81,20 @@ static bool g_virt_boundary;
 module_param_named(virt_boundary, g_virt_boundary, bool, 0444);
 MODULE_PARM_DESC(virt_boundary, "Require a virtual boundary for the device. Default: False");
 
-static int g_no_sched;
-module_param_named(no_sched, g_no_sched, int, 0444);
+static bool g_no_sched;
+module_param_named(no_sched, g_no_sched, bool, 0444);
 MODULE_PARM_DESC(no_sched, "No io scheduler");
 
-static int g_submit_queues = 1;
-module_param_named(submit_queues, g_submit_queues, int, 0444);
+static unsigned int g_submit_queues = 1;
+module_param_named(submit_queues, g_submit_queues, uint, 0444);
 MODULE_PARM_DESC(submit_queues, "Number of submission queues");
 
-static int g_poll_queues = 1;
-module_param_named(poll_queues, g_poll_queues, int, 0444);
+static unsigned int g_poll_queues = 1;
+module_param_named(poll_queues, g_poll_queues, uint, 0444);
 MODULE_PARM_DESC(poll_queues, "Number of IOPOLL submission queues");
 
-static int g_home_node = NUMA_NO_NODE;
-module_param_named(home_node, g_home_node, int, 0444);
+static unsigned int g_home_node = NUMA_NO_NODE;
+module_param_named(home_node, g_home_node, uint, 0444);
 MODULE_PARM_DESC(home_node, "Home node for the device");
 
 #ifdef CONFIG_BLK_DEV_NULL_BLK_FAULT_INJECTION
@@ -157,16 +157,16 @@ static const struct kernel_param_ops null_queue_mode_param_ops = {
 device_param_cb(queue_mode, &null_queue_mode_param_ops, &g_queue_mode, 0444);
 MODULE_PARM_DESC(queue_mode, "Block interface to use (0=bio,1=rq,2=multiqueue)");
 
-static int g_gb = 250;
-module_param_named(gb, g_gb, int, 0444);
+static unsigned long g_gb = 250;
+module_param_named(gb, g_gb, ulong, 0444);
 MODULE_PARM_DESC(gb, "Size in GB");
 
-static int g_bs = 512;
-module_param_named(bs, g_bs, int, 0444);
+static unsigned int g_bs = 512;
+module_param_named(bs, g_bs, uint, 0444);
 MODULE_PARM_DESC(bs, "Block size (in bytes)");
 
-static int g_max_sectors;
-module_param_named(max_sectors, g_max_sectors, int, 0444);
+static unsigned int g_max_sectors;
+module_param_named(max_sectors, g_max_sectors, uint, 0444);
 MODULE_PARM_DESC(max_sectors, "Maximum size of a command (in 512B sectors)");
 
 static unsigned int nr_devices = 1;
@@ -205,8 +205,8 @@ static unsigned long g_completion_nsec = 10000;
 module_param_named(completion_nsec, g_completion_nsec, ulong, 0444);
 MODULE_PARM_DESC(completion_nsec, "Time in ns to complete a request in hardware. Default: 10,000ns");
 
-static int g_hw_queue_depth = 64;
-module_param_named(hw_queue_depth, g_hw_queue_depth, int, 0444);
+static unsigned int g_hw_queue_depth = 64;
+module_param_named(hw_queue_depth, g_hw_queue_depth, uint, 0444);
 MODULE_PARM_DESC(hw_queue_depth, "Queue depth for each hardware queue. Default: 64");
 
 static bool g_use_per_node_hctx;
@@ -257,8 +257,8 @@ static unsigned int g_zone_max_active;
 module_param_named(zone_max_active, g_zone_max_active, uint, 0444);
 MODULE_PARM_DESC(zone_max_active, "Maximum number of active zones when block device is zoned. Default: 0 (no limit)");
 
-static int g_zone_append_max_sectors = INT_MAX;
-module_param_named(zone_append_max_sectors, g_zone_append_max_sectors, int, 0444);
+static unsigned int g_zone_append_max_sectors = INT_MAX;
+module_param_named(zone_append_max_sectors, g_zone_append_max_sectors, uint, 0444);
 MODULE_PARM_DESC(zone_append_max_sectors,
 		 "Maximum size of a zone append command (in 512B sectors). Specify 0 for zone append emulation");
 
-- 
2.33.0


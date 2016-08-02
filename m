Return-Path: <baolex.ni@intel.com>
From: Baole Ni <baolex.ni@intel.com>
To: axboe@kernel.dk,
	mingo@redhat.com,
	hpa@zytor.com,
	x86@kernel.org
Cc: linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	chuansheng.liu@intel.com,
	baolex.ni@intel.com,
	travis@sgi.com
Subject: [PATCH 0039/1285] Replace numeric parameter like 0444 with macro
Date: Tue,  2 Aug 2016 18:36:23 +0800
Message-Id: <20160802103623.16373-1-baolex.ni@intel.com>
List-ID: <linux-block@vger.kernel.org>

I find that the developers often just specified the numeric value
when calling a macro which is defined with a parameter for access permission.
As we know, these numeric value for access permission have had the corresponding macro,
and that using macro can improve the robustness and readability of the code,
thus, I suggest replacing the numeric parameter with the macro.

Signed-off-by: Chuansheng Liu <chuansheng.liu@intel.com>
Signed-off-by: Baole Ni <baolex.ni@intel.com>
---
 block/genhd.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/block/genhd.c b/block/genhd.c
index 9f42526..1079e623 100644
--- a/block/genhd.c
+++ b/block/genhd.c
@@ -1807,7 +1807,7 @@ static const struct kernel_param_ops disk_events_dfl_poll_msecs_param_ops = {
 #define MODULE_PARAM_PREFIX	"block."
 
 module_param_cb(events_dfl_poll_msecs, &disk_events_dfl_poll_msecs_param_ops,
-		&disk_events_dfl_poll_msecs, 0644);
+		&disk_events_dfl_poll_msecs, S_IRUSR | S_IWUSR | S_IRGRP | S_IROTH);
 
 /*
  * disk_{alloc|add|del|release}_events - initialize and destroy disk_events.
-- 
2.9.2

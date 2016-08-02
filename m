Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mga04.intel.com ([192.55.52.120]:44916 "EHLO mga04.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755955AbcHBLgk (ORCPT <rfc822;linux-block@vger.kernel.org>);
	Tue, 2 Aug 2016 07:36:40 -0400
From: Baole Ni <baolex.ni@intel.com>
To: mb@lightnvm.io, j.anaszewski@samsung.com, hal.rosenstock@gmail.com,
	dledford@redhat.com, sean.hefty@intel.com, bp@alien8.de
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
	chuansheng.liu@intel.com, baolex.ni@intel.com
Subject: [PATCH 0310/1285] Replace numeric parameter like 0444 with macro
Date: Tue,  2 Aug 2016 18:58:59 +0800
Message-Id: <20160802105859.2140-1-baolex.ni@intel.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

I find that the developers often just specified the numeric value
when calling a macro which is defined with a parameter for access permission.
As we know, these numeric value for access permission have had the corresponding macro,
and that using macro can improve the robustness and readability of the code,
thus, I suggest replacing the numeric parameter with the macro.

Signed-off-by: Chuansheng Liu <chuansheng.liu@intel.com>
Signed-off-by: Baole Ni <baolex.ni@intel.com>
---
 drivers/lightnvm/core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/lightnvm/core.c b/drivers/lightnvm/core.c
index 160c1a6..8dec614 100644
--- a/drivers/lightnvm/core.c
+++ b/drivers/lightnvm/core.c
@@ -1032,7 +1032,7 @@ static const struct kernel_param_ops nvm_configure_by_str_event_param_ops = {
 #define MODULE_PARAM_PREFIX	"lnvm."
 
 module_param_cb(configure_debug, &nvm_configure_by_str_event_param_ops, NULL,
-									0644);
+									S_IRUSR | S_IWUSR | S_IRGRP | S_IROTH);
 
 #endif /* CONFIG_NVM_DEBUG */
 
-- 
2.9.2


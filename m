Return-Path: <yuehaibing@huawei.com>
From: YueHaibing <yuehaibing@huawei.com>
To: <axboe@kernel.dk>
CC: <linux-kernel@vger.kernel.org>, <linux-block@vger.kernel.org>, YueHaibing
	<yuehaibing@huawei.com>
Subject: [PATCH] DAC960: hide unused procfs helpers
Date: Fri, 13 Jul 2018 15:16:10 +0800
Message-ID: <20180713071610.14276-1-yuehaibing@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
List-ID: <linux-block@vger.kernel.org>

When CONFIG_PROC_FS isn't set, gcc warning this:

drivers/block/DAC960.c:6429:12: warning: ‘dac960_proc_show’ defined but not used [-Wunused-function]
 static int dac960_proc_show(struct seq_file *m, void *v)
            ^
drivers/block/DAC960.c:6449:12: warning: ‘dac960_initial_status_proc_show’ defined but not used [-Wunused-function]
 static int dac960_initial_status_proc_show(struct seq_file *m, void *v)
            ^
drivers/block/DAC960.c:6456:12: warning: ‘dac960_current_status_proc_show’ defined but not used [-Wunused-function]
 static int dac960_current_status_proc_show(struct seq_file *m, void *v)
            ^
fix this by adding #ifdef around them.

Signed-off-by: YueHaibing <yuehaibing@huawei.com>
---
 drivers/block/DAC960.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/block/DAC960.c b/drivers/block/DAC960.c
index f651806..7a05831 100644
--- a/drivers/block/DAC960.c
+++ b/drivers/block/DAC960.c
@@ -6426,6 +6426,7 @@ static bool DAC960_V2_ExecuteUserCommand(DAC960_Controller_T *Controller,
   return true;
 }
 
+#ifdef CONFIG_PROC_FS
 static int dac960_proc_show(struct seq_file *m, void *v)
 {
   unsigned char *StatusMessage = "OK\n";
@@ -6485,6 +6486,7 @@ static int dac960_current_status_proc_show(struct seq_file *m, void *v)
 	seq_printf(m, "%.*s", Controller->CurrentStatusLength, Controller->CurrentStatusBuffer);
 	return 0;
 }
+#endif
 
 static int dac960_user_command_proc_show(struct seq_file *m, void *v)
 {
-- 
2.7.0

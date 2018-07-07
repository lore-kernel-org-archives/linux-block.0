Return-Path: <rdunlap@infradead.org>
To: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
 axboe <axboe@kernel.dk>
From: Randy Dunlap <rdunlap@infradead.org>
Subject: [PATCH] block/DAC960.c: fix defined but not used build warnings
Cc: LKML <linux-kernel@vger.kernel.org>
Message-ID: <880681dd-f72f-6687-d2cc-59116acd5216@infradead.org>
Date: Fri, 6 Jul 2018 20:49:19 -0700
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

From: Randy Dunlap <rdunlap@infradead.org>

Fix build warnings in DAC960.c when CONFIG_PROC_FS is not enabled
by marking the unused functions as __maybe_unused.

../drivers/block/DAC960.c:6429:12: warning: 'dac960_proc_show' defined but not used [-Wunused-function]
../drivers/block/DAC960.c:6449:12: warning: 'dac960_initial_status_proc_show' defined but not used [-Wunused-function]
../drivers/block/DAC960.c:6456:12: warning: 'dac960_current_status_proc_show' defined but not used [-Wunused-function]

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org
---
 drivers/block/DAC960.c |    9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

--- linux-next-20180706.orig/drivers/block/DAC960.c
+++ linux-next-20180706/drivers/block/DAC960.c
@@ -21,6 +21,7 @@
 #define DAC960_DriverDate			"21 Aug 2007"
 
 
+#include <linux/compiler.h>
 #include <linux/module.h>
 #include <linux/types.h>
 #include <linux/miscdevice.h>
@@ -6426,7 +6427,7 @@ static bool DAC960_V2_ExecuteUserCommand
   return true;
 }
 
-static int dac960_proc_show(struct seq_file *m, void *v)
+static int __maybe_unused dac960_proc_show(struct seq_file *m, void *v)
 {
   unsigned char *StatusMessage = "OK\n";
   int ControllerNumber;
@@ -6446,14 +6447,16 @@ static int dac960_proc_show(struct seq_f
   return 0;
 }
 
-static int dac960_initial_status_proc_show(struct seq_file *m, void *v)
+static int __maybe_unused dac960_initial_status_proc_show(struct seq_file *m,
+							  void *v)
 {
 	DAC960_Controller_T *Controller = (DAC960_Controller_T *)m->private;
 	seq_printf(m, "%.*s", Controller->InitialStatusLength, Controller->CombinedStatusBuffer);
 	return 0;
 }
 
-static int dac960_current_status_proc_show(struct seq_file *m, void *v)
+static int __maybe_unused dac960_current_status_proc_show(struct seq_file *m,
+							  void *v)
 {
   DAC960_Controller_T *Controller = (DAC960_Controller_T *) m->private;
   unsigned char *StatusMessage =

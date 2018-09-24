Return-Path: <gregkh@linuxfoundation.org>
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Randy Dunlap <rdunlap@infradead.org>,
	Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org,
	Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.18 226/235] block/DAC960.c: fix defined but not used build warnings
Date: Mon, 24 Sep 2018 13:53:32 +0200
Message-Id: <20180924113125.675980077@linuxfoundation.org>
In-Reply-To: <20180924113103.999624566@linuxfoundation.org>
References: <20180924113103.999624566@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-block@vger.kernel.org>

4.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Randy Dunlap <rdunlap@infradead.org>

[ Upstream commit 3993e501bf853cce85c5114a704b86b8f486790c ]

Fix build warnings in DAC960.c when CONFIG_PROC_FS is not enabled
by marking the unused functions as __maybe_unused.

../drivers/block/DAC960.c:6429:12: warning: 'dac960_proc_show' defined but not used [-Wunused-function]
../drivers/block/DAC960.c:6449:12: warning: 'dac960_initial_status_proc_show' defined but not used [-Wunused-function]
../drivers/block/DAC960.c:6456:12: warning: 'dac960_current_status_proc_show' defined but not used [-Wunused-function]

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org
Signed-off-by: Jens Axboe <axboe@kernel.dk>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/block/DAC960.c |    9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

--- a/drivers/block/DAC960.c
+++ b/drivers/block/DAC960.c
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

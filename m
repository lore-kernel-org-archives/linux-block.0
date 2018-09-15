Return-Path: <Alexander.Levin@microsoft.com>
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "stable@vger.kernel.org" <stable@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC: Randy Dunlap <rdunlap@infradead.org>, Jens Axboe <axboe@kernel.dk>,
	"linux-block@vger.kernel.org" <linux-block@vger.kernel.org>, Sasha Levin
	<Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.18 85/92] block/DAC960.c: fix defined but not used
 build warnings
Date: Sat, 15 Sep 2018 01:30:50 +0000
Message-ID: <20180915012944.179481-84-alexander.levin@microsoft.com>
References: <20180915012944.179481-1-alexander.levin@microsoft.com>
In-Reply-To: <20180915012944.179481-1-alexander.levin@microsoft.com>
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
List-ID: <linux-block@vger.kernel.org>

From: Randy Dunlap <rdunlap@infradead.org>

[ Upstream commit 3993e501bf853cce85c5114a704b86b8f486790c ]

Fix build warnings in DAC960.c when CONFIG_PROC_FS is not enabled
by marking the unused functions as __maybe_unused.

../drivers/block/DAC960.c:6429:12: warning: 'dac960_proc_show' defined but =
not used [-Wunused-function]
../drivers/block/DAC960.c:6449:12: warning: 'dac960_initial_status_proc_sho=
w' defined but not used [-Wunused-function]
../drivers/block/DAC960.c:6456:12: warning: 'dac960_current_status_proc_sho=
w' defined but not used [-Wunused-function]

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org
Signed-off-by: Jens Axboe <axboe@kernel.dk>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/block/DAC960.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/drivers/block/DAC960.c b/drivers/block/DAC960.c
index f6518067aa7d..f99e5c883368 100644
--- a/drivers/block/DAC960.c
+++ b/drivers/block/DAC960.c
@@ -21,6 +21,7 @@
 #define DAC960_DriverDate			"21 Aug 2007"
=20
=20
+#include <linux/compiler.h>
 #include <linux/module.h>
 #include <linux/types.h>
 #include <linux/miscdevice.h>
@@ -6426,7 +6427,7 @@ static bool DAC960_V2_ExecuteUserCommand(DAC960_Contr=
oller_T *Controller,
   return true;
 }
=20
-static int dac960_proc_show(struct seq_file *m, void *v)
+static int __maybe_unused dac960_proc_show(struct seq_file *m, void *v)
 {
   unsigned char *StatusMessage =3D "OK\n";
   int ControllerNumber;
@@ -6446,14 +6447,16 @@ static int dac960_proc_show(struct seq_file *m, voi=
d *v)
   return 0;
 }
=20
-static int dac960_initial_status_proc_show(struct seq_file *m, void *v)
+static int __maybe_unused dac960_initial_status_proc_show(struct seq_file =
*m,
+							  void *v)
 {
 	DAC960_Controller_T *Controller =3D (DAC960_Controller_T *)m->private;
 	seq_printf(m, "%.*s", Controller->InitialStatusLength, Controller->Combin=
edStatusBuffer);
 	return 0;
 }
=20
-static int dac960_current_status_proc_show(struct seq_file *m, void *v)
+static int __maybe_unused dac960_current_status_proc_show(struct seq_file =
*m,
+							  void *v)
 {
   DAC960_Controller_T *Controller =3D (DAC960_Controller_T *) m->private;
   unsigned char *StatusMessage =3D
--=20
2.17.1

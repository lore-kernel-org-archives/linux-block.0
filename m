Return-Path: <linux-block-owner@vger.kernel.org>
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:62932 "EHLO
        esa4.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751119AbdCMUIF (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 13 Mar 2017 16:08:05 -0400
From: Bart Van Assche <Bart.VanAssche@sandisk.com>
To: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "yanaijie@huawei.com" <yanaijie@huawei.com>,
        "axboe@kernel.dk" <axboe@kernel.dk>
CC: "zhaohongjiang@huawei.com" <zhaohongjiang@huawei.com>,
        "miaoxie@huawei.com" <miaoxie@huawei.com>
Subject: Re: [PATCH] brd: make rd_size static
Date: Mon, 13 Mar 2017 20:07:56 +0000
Message-ID: <1489435663.2658.12.camel@sandisk.com>
References: <1489131159-840-1-git-send-email-yanaijie@huawei.com>
         <4dd2367b-61b9-d390-5bb1-955e90fef0b0@kernel.dk>
In-Reply-To: <4dd2367b-61b9-d390-5bb1-955e90fef0b0@kernel.dk>
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On Sat, 2017-03-11 at 15:29 -0700, Jens Axboe wrote:
> On 03/10/2017 12:32 AM, Jason Yan wrote:
> > Fixes the following sparse warning:
> >=20
> > drivers/block/brd.c:411:15: warning: symbol 'rd_size' was not declared.
> > Should it be static?
>=20
> If you do a search on this topic, you'll find others that attempted
> to do the same. Arm uses it for tag parsing, for some reason, your
> patch below would break it.
>=20
> It'd be great if this was fixed up for real, though.

How about something like the (untested) patch below?


Subject: [PATCH] arch/arm/kernel/atags_parse.c: Fix rd_size declaration

Ensure that the ARM setup code treats "rd_size" as unsigned long instead of=
 int.

---
 arch/arm/kernel/atags_parse.c | 3 ++-
 drivers/block/brd.c           | 2 ++
 drivers/block/brd.h           | 1 +
 3 files changed, 5 insertions(+), 1 deletion(-)
 create mode 100644 drivers/block/brd.h

diff --git a/arch/arm/kernel/atags_parse.c b/arch/arm/kernel/atags_parse.c
index 68c6ae0b9e4c..f18b6deaf050 100644
--- a/arch/arm/kernel/atags_parse.c
+++ b/arch/arm/kernel/atags_parse.c
@@ -30,6 +30,7 @@
 #include <asm/mach/arch.h>
=20
 #include "atags.h"
+#include "../../../drivers/block/brd.h"
=20
 static char default_command_line[COMMAND_LINE_SIZE] __initdata =3D CONFIG_=
CMDLINE;
=20
@@ -91,7 +92,7 @@ __tagtable(ATAG_VIDEOTEXT, parse_tag_videotext);
 #ifdef CONFIG_BLK_DEV_RAM
 static int __init parse_tag_ramdisk(const struct tag *tag)
 {
-	extern int rd_size, rd_image_start, rd_prompt, rd_doload;
+	extern int rd_image_start, rd_prompt, rd_doload;
=20
 	rd_image_start =3D tag->u.ramdisk.start;
 	rd_doload =3D (tag->u.ramdisk.flags & 1) =3D=3D 0;
diff --git a/drivers/block/brd.c b/drivers/block/brd.c
index 3adc32a3153b..f1f9f0338fbd 100644
--- a/drivers/block/brd.c
+++ b/drivers/block/brd.c
@@ -25,6 +25,8 @@
=20
 #include <linux/uaccess.h>
=20
+#include "brd.h"
+
 #define SECTOR_SHIFT		9
 #define PAGE_SECTORS_SHIFT	(PAGE_SHIFT - SECTOR_SHIFT)
 #define PAGE_SECTORS		(1 << PAGE_SECTORS_SHIFT)
diff --git a/drivers/block/brd.h b/drivers/block/brd.h
new file mode 100644
index 000000000000..dbb0f92fefc8
--- /dev/null
+++ b/drivers/block/brd.h
@@ -0,0 +1 @@
+extern unsigned long rd_size;
--=20
2.12.0

Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-io0-f193.google.com ([209.85.223.193]:41382 "EHLO
        mail-io0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750803AbeBQGNL (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sat, 17 Feb 2018 01:13:11 -0500
Date: Sat, 17 Feb 2018 11:43:04 +0530
From: Aishwarya Pant <aishpant@gmail.com>
To: linux-block@vger.kernel.org
Cc: Julia Lawall <julia.lawall@lip6.fr>, linux-kernel@vger.kernel.org,
        Jonathan Corbet <corbet@lwn.net>,
        Greg KH <gregkh@linuxfoundation.org>, linux-doc@vger.kernel.org
Subject: [PATCH v2] block/loop: add documentation for sysfs interface
Message-ID: <20180217061304.GA14083@mordor.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

Documentation has been compiled from git logs and by reading through
code.

Signed-off-by: Aishwarya Pant <aishpant@gmail.com>
---
For drivers/block/loop.c, I don't see any maintainers or mailing lists except
for LKML. I am guessing linux-block mailing list should be okay.

Changes in v2:
- Add linux-block@vger.kernel.org to the recipient list.

 Documentation/ABI/testing/sysfs-block-loop | 50 ++++++++++++++++++++++++++++++
 1 file changed, 50 insertions(+)
 create mode 100644 Documentation/ABI/testing/sysfs-block-loop

diff --git a/Documentation/ABI/testing/sysfs-block-loop b/Documentation/ABI/testing/sysfs-block-loop
new file mode 100644
index 000000000000..627f4eb87286
--- /dev/null
+++ b/Documentation/ABI/testing/sysfs-block-loop
@@ -0,0 +1,50 @@
+What:		/sys/block/loopX/loop/autoclear
+Date:		Aug, 2010
+KernelVersion:	v2.6.37
+Contact:	linux-block@vger.kernel.org
+Description:
+		(RO) Shows if the device is in autoclear mode or not ( "1" or
+		"0"). Autoclear (if set) indicates that the loopback device will
+		self-distruct after last close.
+
+What:		/sys/block/loopX/loop/backing_file
+Date:		Aug, 2010
+KernelVersion:	v2.6.37
+Contact:	linux-block@vger.kernel.org
+Description:
+		(RO) The path of the backing file that the loop device maps its
+		data blocks to.
+
+What:		/sys/block/loopX/loop/offset
+Date:		Aug, 2010
+KernelVersion:	v2.6.37
+Contact:	linux-block@vger.kernel.org
+Description:
+		(RO) Start offset (in bytes).
+
+What:		/sys/block/loopX/loop/sizelimit
+Date:		Aug, 2010
+KernelVersion:	v2.6.37
+Contact:	linux-block@vger.kernel.org
+Description:
+		(RO) The size (in bytes) that the block device maps, starting
+		from the offset.
+
+What:		/sys/block/loopX/loop/partscan
+Date:		Aug, 2011
+KernelVersion:	v3.10
+Contact:	linux-block@vger.kernel.org
+Description:
+		(RO) Shows if automatic partition scanning is enabled for the
+		device or not ("1" or "0"). This can be requested individually
+		per loop device during its setup by setting LO_FLAGS_PARTSCAN in
+		in the ioctl request. By default, no partition tables are
+		scanned.
+
+What:		/sys/block/loopX/loop/dio
+Date:		Aug, 2015
+KernelVersion:	v4.10
+Contact:	linux-block@vger.kernel.org
+Description:
+		(RO) Shows if direct IO is being used to access backing file or
+		not ("1 or "0").
-- 
2.16.1

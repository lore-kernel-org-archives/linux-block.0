Return-Path: <SRS0=MRnn=WT=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4D83C3A5A4
	for <linux-block@archiver.kernel.org>; Fri, 23 Aug 2019 23:01:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8D1972173B
	for <linux-block@archiver.kernel.org>; Fri, 23 Aug 2019 23:01:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=permerror (0-bit key) header.d=manuel-bentele.de header.i=@manuel-bentele.de header.b="lNRYeFmo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726369AbfHWXBq (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 23 Aug 2019 19:01:46 -0400
Received: from host1.nc.manuel-bentele.de ([92.60.37.180]:55828 "EHLO
        host1.nc.manuel-bentele.de" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726907AbfHWXBp (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 23 Aug 2019 19:01:45 -0400
Received: from localhost (localhost [127.0.0.1]) (Authenticated sender: development@manuel-bentele.de)
        by host1.nc.manuel-bentele.de (Postcow) with ESMTPSA id 3A7E86100A;
        Sat, 24 Aug 2019 00:56:21 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=manuel-bentele.de;
        s=dkim; t=1566600981;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=1y+pnJy9zMZOcn11eFXuCkss9haB0GfChOpHxWrcPtI=;
        b=lNRYeFmoa8fknVAPOCF68e+ZGRf4upQjmBNfQcQ0lAcwX/6X4NjuVZgj0mIUDW2emN3qBQ
        QK2pMH67FO6yL5o4HlhBTWtlPGSzrY/EzK46iYyru4fbXmBIKSSAC0AV6wX1MfWSDuT0ID
        7dQR3mwZKhS8Ci5NbCodrY4r6q7fdncwlXN2VK49jFxnPeq02HDoEo6S81Ol1oHeDn9uPU
        ZV6YPwTt3tUCMSV13uZhY0AMBpSkg3VfS1YxgaLmlviRyuPe6J8vZVcGr+e0AS/Eg+KsEx
        BfQjQu3AREwOXxCwHTkgHUEbW94jpSA2vLehfOOzLlbZ8qgWsBUAibdkvb26lg==
From:   development@manuel-bentele.de
To:     linux-block@vger.kernel.org
Cc:     Manuel Bentele <development@manuel-bentele.de>
Subject: [PATCH 2/5] doc: admin-guide: add loop block device documentation
Date:   Sat, 24 Aug 2019 00:56:16 +0200
Message-Id: <20190823225619.15530-3-development@manuel-bentele.de>
In-Reply-To: <20190823225619.15530-1-development@manuel-bentele.de>
References: <20190823225619.15530-1-development@manuel-bentele.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
        d=manuel-bentele.de; s=dkim; t=1566600981;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=1y+pnJy9zMZOcn11eFXuCkss9haB0GfChOpHxWrcPtI=;
        b=SOQW3w2kQNC3v1WWTq0oHTnCNDgf6wbMjnEbyV5iLepcEEnA/3oFyI/6XJmO6A189MblHz
        WE2a1vyA2ts/SWw9K02n2x8MT2YdLfMhbfgUbyUeju5hVoMxAJy2T3EJ4Q8hqpanikmT1N
        VdonGXJQxrcifR9nfLlplmNUEX6cfOFEISAVvgqU7z5doo/efm2ayjj/sMKpHBggTQChtJ
        4ANq/eviHBUcME5jXQTqb8vRKK+5qgFwcd4qNk5Ag1Q7nGizPR4RDmR4338qcDNjijs4gt
        KazKXy7fY+WAAm3HbwLLGuo8Z88nkBCURW1QVD2QprlDHz2xUzY/O8/uKuJtBg==
ARC-Seal: i=1; s=dkim; d=manuel-bentele.de; t=1566600981; a=rsa-sha256;
        cv=none;
        b=TAHpL5ikM/efSuymUvkIyhhm372t8ik8lecqoCVv+1Y0HFwGrgRZZeEmWobBz2BaZM9xpO
        D9++WPgevCl8Y/IZpFJ0aYfvLMbDxdIw2FTImhfTG14TjLbVeVGJX9IBRmYabU7vfgkW8W
        pI9hgOHTgU2RTVgzALZoAUAm0rD4nhHhRNkgDfaVDSb/M3tJme2AfpMU2lUCV0mrtJjWfW
        SNv0ogLsMK2S+HG3t22QGe5tP+VRmKI/6Jpt8z5WnO/o+1oXyZlIBrVjPatrGwZg6N9dJk
        YFk/s5kEnfvm8jgrMKkCuss/M1YL1fWE/LPT/16kdGmuTQrbJQqJyTS+qeAYkw==
ARC-Authentication-Results: i=1;
        host1.nc.manuel-bentele.de;
        auth=pass smtp.auth=development@manuel-bentele.de smtp.mailfrom=development@manuel-bentele.de
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

From: Manuel Bentele <development@manuel-bentele.de>

The configuration of the loop block device module with file format support
is documented in the reST kernel documentation format.

Signed-off-by: Manuel Bentele <development@manuel-bentele.de>
---
 Documentation/admin-guide/blockdev/index.rst |  1 +
 Documentation/admin-guide/blockdev/loop.rst  | 74 ++++++++++++++++++++
 2 files changed, 75 insertions(+)
 create mode 100644 Documentation/admin-guide/blockdev/loop.rst

diff --git a/Documentation/admin-guide/blockdev/index.rst b/Documentation/admin-guide/blockdev/index.rst
index b903cf152091..127e921a0ccc 100644
--- a/Documentation/admin-guide/blockdev/index.rst
+++ b/Documentation/admin-guide/blockdev/index.rst
@@ -8,6 +8,7 @@ The Linux RapidIO Subsystem
    :maxdepth: 1
 
    floppy
+   loop
    nbd
    paride
    ramdisk
diff --git a/Documentation/admin-guide/blockdev/loop.rst b/Documentation/admin-guide/blockdev/loop.rst
new file mode 100644
index 000000000000..69d8172c85db
--- /dev/null
+++ b/Documentation/admin-guide/blockdev/loop.rst
@@ -0,0 +1,74 @@
+.. SPDX-License-Identifier: GPL-2.0
+
+Loopback Block Device
+=====================
+
+Overview
+--------
+
+The loopback device driver allows you to use a regular file as a block device.
+You can then create a file system on that block device and mount it just as you
+would mount other block devices such as hard drive partitions, CD-ROM drives or
+floppy drives. The loop devices are block special device files with major
+number 7 and typically called /dev/loop0, /dev/loop1 etc.
+
+To use the loop device, you need the losetup utility, found in the `util-linux
+package <https://www.kernel.org/pub/linux/utils/util-linux/>`_.
+
+.. note::
+	Note that this loop device has nothing to do with the loopback device \
+	used for network connections from the machine to itself.
+
+
+Parameters
+----------
+
+Kernel Command Line Parameters
+~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+
+	max_loop
+		The number of loop block devices that get unconditionally
+		pre-created at init time. The default number is configured by
+		BLK_DEV_LOOP_MIN_COUNT. Instead of statically allocating a
+		predefined number, loop devices can be requested on-demand
+		with the /dev/loop-control interface.
+
+
+Module parameters
+~~~~~~~~~~~~~~~~~
+
+	max_part
+		Maximum number of partitions per loop device (default: 0).
+
+		If max_part is given, partition scanning is globally enabled
+		for all loop devices.
+
+	max_loop
+		Maximum number of loop devices that should be initialized
+		(default: 8). The default number is configured by
+		BLK_DEV_LOOP_MIN_COUNT.
+
+
+File format drivers
+-------------------
+
+The loopback device driver provides an interface for kernel modules to
+implement custom file formats. By default, an initialized loop device uses the
+**RAW** file format driver.
+
+.. note::
+	If you want to create and set up a new loop device with the losetup \
+	utility make sure that the suitable file format driver is loaded \
+	before.
+
+The following file format drivers are available.
+
+
+RAW
+~~~
+
+The RAW file format driver implements the binary reading and writing of a disk
+image file. It supports discarding, asynchrounous IO, flushing and cryptoloop
+support.
+
+The driver's kernel module is named *loop_file_fmt_raw*.
-- 
2.23.0


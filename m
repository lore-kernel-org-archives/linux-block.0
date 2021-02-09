Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-19.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3CBEBC433DB
	for <linux-block@archiver.kernel.org>; Tue,  9 Feb 2021 14:32:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EDCAE64E56
	for <linux-block@archiver.kernel.org>; Tue,  9 Feb 2021 14:32:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229609AbhBIObo (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 9 Feb 2021 09:31:44 -0500
Received: from mx2.veeam.com ([64.129.123.6]:54914 "EHLO mx2.veeam.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231366AbhBIObn (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Tue, 9 Feb 2021 09:31:43 -0500
Received: from mail.veeam.com (prgmbx01.amust.local [172.24.0.171])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mx2.veeam.com (Postfix) with ESMTPS id E9F9B4031C;
        Tue,  9 Feb 2021 09:30:55 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=veeam.com; s=mx2;
        t=1612881056; bh=xuGBXydOqpQxhGsIdjXtgJDgMIszE2ypZb9iQnBJEG0=;
        h=From:To:CC:Subject:Date:In-Reply-To:References:From;
        b=cDfpmBb+OzQnKKurNJXzfYGxOCw5A3NU5gur3ECNfwjF8kHrDplEx3Q3gTjBL118j
         gb6ELsLwX8dn9cE+O84NJ7Nwhcrvzkum50t5iU1+WCOElzbYjkUS+m6epZUwsEeuTE
         DCLO6Nj0MYlk1n+Mbj9nAMOxv46VMRUTgZwAl1hg=
Received: from prgdevlinuxpatch01.amust.local (172.24.14.5) by
 prgmbx01.amust.local (172.24.0.171) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.721.2;
 Tue, 9 Feb 2021 15:30:50 +0100
From:   Sergei Shtepa <sergei.shtepa@veeam.com>
To:     <Damien.LeMoal@wdc.com>, <snitzer@redhat.com>, <hare@suse.de>,
        <ming.lei@redhat.com>, <agk@redhat.com>, <corbet@lwn.net>,
        <axboe@kernel.dk>, <jack@suse.cz>, <johannes.thumshirn@wdc.com>,
        <gregkh@linuxfoundation.org>, <koct9i@gmail.com>, <steve@sk2.org>,
        <dm-devel@redhat.com>, <linux-block@vger.kernel.org>,
        <linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     <sergei.shtepa@veeam.com>, <pavel.tide@veeam.com>
Subject: [PATCH v5 1/6] docs: device-mapper: add remap_and_filter
Date:   Tue, 9 Feb 2021 17:30:23 +0300
Message-ID: <1612881028-7878-2-git-send-email-sergei.shtepa@veeam.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1612881028-7878-1-git-send-email-sergei.shtepa@veeam.com>
References: <1612881028-7878-1-git-send-email-sergei.shtepa@veeam.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [172.24.14.5]
X-ClientProxiedBy: prgmbx02.amust.local (172.24.0.172) To prgmbx01.amust.local
 (172.24.0.171)
X-EsetResult: clean, is OK
X-EsetId: 37303A29C604D265617465
X-Veeam-MMEX: True
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

remap_and_filter - describes the new features that
blk_interposer provides for device mapper.

Signed-off-by: Sergei Shtepa <sergei.shtepa@veeam.com>
---
 .../admin-guide/device-mapper/index.rst       |   1 +
 .../device-mapper/remap_and_filter.rst        | 132 ++++++++++++++++++
 2 files changed, 133 insertions(+)
 create mode 100644 Documentation/admin-guide/device-mapper/remap_and_filter.rst

diff --git a/Documentation/admin-guide/device-mapper/index.rst b/Documentation/admin-guide/device-mapper/index.rst
index 6cf8adc86fa8..e868d5bbec7e 100644
--- a/Documentation/admin-guide/device-mapper/index.rst
+++ b/Documentation/admin-guide/device-mapper/index.rst
@@ -27,6 +27,7 @@ Device Mapper
     linear
     log-writes
     persistent-data
+    remap_and_filter
     snapshot
     statistics
     striped
diff --git a/Documentation/admin-guide/device-mapper/remap_and_filter.rst b/Documentation/admin-guide/device-mapper/remap_and_filter.rst
new file mode 100644
index 000000000000..b896a7de2c97
--- /dev/null
+++ b/Documentation/admin-guide/device-mapper/remap_and_filter.rst
@@ -0,0 +1,132 @@
+=================
+DM remap & filter
+=================
+
+Introduction
+============
+
+Usually LVM should be used for new devices.
+The administrator has to create logical volumes for the system partition
+when installing the operating system. For a running system with
+partitioned disk space and mounted file systems, it is quite difficult to
+reconfigure to logical volumes. As a result, all the features that Device
+Mapper provides are not available for non-LVM systems.
+This problem is partially solved by the DM remap functionality, which
+uses the kernel's blk_interposer.
+
+Blk_interposer
+==============
+
+Blk_interposer extends the capabilities of the DM, as it allows to
+intercept and redirect bio requests for block devices that are not
+DM devices. At the same time, blk_interposer allows to attach and detach
+from devices "on the fly", without stopping the execution of user
+programs.
+
+Blk_interposer allows to do two tasks: remap and filter.
+Remap allows to redirect all requests from one block device to another.
+Filter allows to do additional processing of the request, but without
+redirection. An intercepted request can get to the block device to which
+it was addressed, without changes.
+
+Remap
+=====
+
+Consider the functionality of the remap. This will allow to connect
+any block device with a DM device "on the fly".
+Suppose we have a file system mounted on the block device /dev/sda1::
+
+  +-------------+
+  | file system |
+  +-------------+
+        ||
+        \/
+  +-------------+
+  |  /dev/sda1  |
+  +-------------+
+
+Creating a new DM device that will be mapped on the same /dev/sda1::
+
+  +-------------+  +-----------+
+  | file system |  | dm-linear |
+  +-------------+  +-----------+
+           ||         ||
+           \/         \/
+         +---------------+
+         |   /dev/sda1   |
+         +---------------+
+
+Redirecting all bio requests for the /dev/sda1 device to the new DM
+device::
+
+  +-------------+
+  | file system |
+  +-------------+
+        ||
+        \/
+   +----------+    +-----------+
+   |  remap   | => | dm-linear |
+   +----------+    +-----------+
+                         ||
+                         \/
+                   +-----------+
+                   | /dev/sda1 |
+                   +-----------+
+
+To achieve this, you need to:
+
+Create new DM device with option 'noexcl'. It's allowed to open the
+underlying block-device without the FMODE_EXCL flag::
+
+  echo "0 `blockdev --getsz $1` linear $DEV 0 noexcl" | dmsetup create dm-noexcl
+
+Call remap command::
+
+  dmsetup remap start dm-noexcl $1
+
+Remap can be used to extend the functionality of dm-snap. This will allow
+to take snapshots from any block devices, not just logical volumes.
+
+Filter
+======
+
+Filter does not redirect the bio to another device. It does not create
+a clone of the bio request. After receiving the request, the filter can
+only add some processing, complete the bio request, or return the bio
+for further processing.
+
+Suppose we have a file system mounted on the block device /dev/sda1::
+
+  +-------------+
+  | file system |
+  +-------------+
+        ||
+        \/
+  +-------------+
+  |  /dev/sda1  |
+  +-------------+
+
+Creating a new DM device that will implement filter::
+
+  +-------------+
+  | file system |
+  +-------------+
+        ||
+        \/
+    +--------+    +----------+
+    | filter | => | dm-delay |
+    +--------+    +----------+
+        ||
+        \/
+  +-------------+
+  |  /dev/sda1  |
+  +-------------+
+
+Using filter we can change the behavior of debugging tools:
+ * dm-dust,
+ * dm-delay,
+ * dm-flakey,
+ * dm-verity.
+
+In the new version, they will be able to change the behavior of any
+existing block device, without creating a new one.
-- 
2.20.1


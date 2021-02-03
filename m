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
	by smtp.lore.kernel.org (Postfix) with ESMTP id B993CC433E9
	for <linux-block@archiver.kernel.org>; Wed,  3 Feb 2021 15:57:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7158064F65
	for <linux-block@archiver.kernel.org>; Wed,  3 Feb 2021 15:57:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234590AbhBCP5T (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 3 Feb 2021 10:57:19 -0500
Received: from mx2.veeam.com ([64.129.123.6]:54930 "EHLO mx2.veeam.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234663AbhBCPz5 (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Wed, 3 Feb 2021 10:55:57 -0500
Received: from mail.veeam.com (prgmbx01.amust.local [172.24.0.171])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mx2.veeam.com (Postfix) with ESMTPS id 1C8E341370;
        Wed,  3 Feb 2021 10:54:28 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=veeam.com; s=mx2;
        t=1612367668; bh=9cj23SyRRouckAdb7Z39R80REv0U3iAfWT8sKecQBIg=;
        h=From:To:CC:Subject:Date:In-Reply-To:References:From;
        b=qNyi3/U2lyC4IlxoeXPmxJV67d+Om4rs6Gkhhs3bIm+kXoi0NV8g6a6NuFhqtO5sF
         GguVDUwzPncEuyjrk226yhysZjaBDHDtUjOrdYWLrUxXIfHEs4e9XaR6pfOgcbkb2n
         YZeq/cIUpsU7qmS6xUi+JbSDfy/YZl/+EXeg9C1I=
Received: from prgdevlinuxpatch01.amust.local (172.24.14.5) by
 prgmbx01.amust.local (172.24.0.171) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.721.2;
 Wed, 3 Feb 2021 16:54:18 +0100
From:   Sergei Shtepa <sergei.shtepa@veeam.com>
To:     <Damien.LeMoal@wdc.com>, <snitzer@redhat.com>, <hare@suse.de>,
        <ming.lei@redhat.com>, <agk@redhat.com>, <corbet@lwn.net>,
        <axboe@kernel.dk>, <jack@suse.cz>, <johannes.thumshirn@wdc.com>,
        <gregkh@linuxfoundation.org>, <koct9i@gmail.com>, <steve@sk2.org>,
        <dm-devel@redhat.com>, <linux-block@vger.kernel.org>,
        <linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     <sergei.shtepa@veeam.com>, <pavgel.tide@veeam.com>
Subject: [PATCH v4 1/6] docs: device-mapper: add remap_and_filter
Date:   Wed, 3 Feb 2021 18:53:53 +0300
Message-ID: <1612367638-3794-2-git-send-email-sergei.shtepa@veeam.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1612367638-3794-1-git-send-email-sergei.shtepa@veeam.com>
References: <1612367638-3794-1-git-send-email-sergei.shtepa@veeam.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [172.24.14.5]
X-ClientProxiedBy: prgmbx02.amust.local (172.24.0.172) To prgmbx01.amust.local
 (172.24.0.171)
X-EsetResult: clean, is OK
X-EsetId: 37303A29C604D265667062
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
index 000000000000..616b67998305
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
+The administrator have to create logical volumes for the system partition
+when installing the operating system. For a running system with
+partitioned disk space and mounted file systems, it is quite difficult to
+reconfigure to logical volumes. As a result, all the features that Device
+Mapper provides are not available for non-LVM systems.
+This problem is partially solved by the dm remap functionality, which
+uses the kernel's blk_interposer.
+
+blk_interposer
+==============
+
+Blk_interposer extends the capabilities of the DM, as it allows to
+intercept and redirect bio requests for block devices that are not
+dm device. At the same time, blk_interposer allows to attach and detach
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
+any block device with a dm device "on the fly".
+Suppose we have a file system mounted on the block device /dev/sda1::
+
+  +-------------+
+  | file system |
+  +-------------+
+        ||
+        \/
+  +-------------+
+  | /dev/sda1   |
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
+Redirecting all bio requests for the /dev/sda1 device to the new dm
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
+Create new dm device with option 'noexcl'. It's allow to open
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
+  | /dev/sda1   |
+  +-------------+
+
+Creating a new dm device that will implement filter::
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
+  | /dev/sda1   |
+  +-------------+
+
+Using filter we can change the behavior of debugging tools:
+ * dm-dust,
+ * dm-delay,
+ * dm-flakey,
+ * dm-verity.
+
+In the new version, they are will be able to change the behavior of any
+existing block device, without creating a new one.
-- 
2.20.1


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
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8F22C433DB
	for <linux-block@archiver.kernel.org>; Wed,  3 Feb 2021 15:57:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9E01364F65
	for <linux-block@archiver.kernel.org>; Wed,  3 Feb 2021 15:57:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234682AbhBCP5O (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 3 Feb 2021 10:57:14 -0500
Received: from mx2.veeam.com ([64.129.123.6]:56874 "EHLO mx2.veeam.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234693AbhBCP4w (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Wed, 3 Feb 2021 10:56:52 -0500
Received: from mail.veeam.com (prgmbx01.amust.local [172.24.0.171])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mx2.veeam.com (Postfix) with ESMTPS id 3009441585;
        Wed,  3 Feb 2021 10:54:53 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=veeam.com; s=mx2;
        t=1612367693; bh=iOyxKFHPVnSJiNEqoIQLb5N7mlhEeMv/ecD8/bTsSt0=;
        h=From:To:CC:Subject:Date:In-Reply-To:References:From;
        b=Cu+rQypwSrNR/OGjg5GfLNWUQxA3We0G2OVdCd5KnehT/KVVe/iAsaSCXZaZWlJDY
         Ao/VQEAVEVBRBDGOohsmH9IZAENV1Bg/+OyxZooN0W7OF7zPCVhYm9G/E/YuJnqi5c
         2hxC7FAnYrQ6lUC4JS29BTXdkwzuB8z0BrVPoJXI=
Received: from prgdevlinuxpatch01.amust.local (172.24.14.5) by
 prgmbx01.amust.local (172.24.0.171) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.721.2;
 Wed, 3 Feb 2021 16:54:28 +0100
From:   Sergei Shtepa <sergei.shtepa@veeam.com>
To:     <Damien.LeMoal@wdc.com>, <snitzer@redhat.com>, <hare@suse.de>,
        <ming.lei@redhat.com>, <agk@redhat.com>, <corbet@lwn.net>,
        <axboe@kernel.dk>, <jack@suse.cz>, <johannes.thumshirn@wdc.com>,
        <gregkh@linuxfoundation.org>, <koct9i@gmail.com>, <steve@sk2.org>,
        <dm-devel@redhat.com>, <linux-block@vger.kernel.org>,
        <linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     <sergei.shtepa@veeam.com>, <pavgel.tide@veeam.com>
Subject: [PATCH v4 6/6] docs: device-mapper: 'noexcl' option for dm-linear
Date:   Wed, 3 Feb 2021 18:53:58 +0300
Message-ID: <1612367638-3794-7-git-send-email-sergei.shtepa@veeam.com>
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

New 'noexcl' option allow to open underlying block-device
without FMODE_EXCL flag.

Signed-off-by: Sergei Shtepa <sergei.shtepa@veeam.com>
---
 .../admin-guide/device-mapper/linear.rst      | 26 ++++++++++++++++---
 1 file changed, 23 insertions(+), 3 deletions(-)

diff --git a/Documentation/admin-guide/device-mapper/linear.rst b/Documentation/admin-guide/device-mapper/linear.rst
index 9d17fc6e64a9..f035cd7ad78c 100644
--- a/Documentation/admin-guide/device-mapper/linear.rst
+++ b/Documentation/admin-guide/device-mapper/linear.rst
@@ -6,12 +6,22 @@ Device-Mapper's "linear" target maps a linear range of the Device-Mapper
 device onto a linear range of another device.  This is the basic building
 block of logical volume managers.
 
-Parameters: <dev path> <offset>
+Parameters: <dev path> <offset> [<options>]
     <dev path>:
-	Full pathname to the underlying block-device, or a
+        Full pathname to the underlying block-device, or a
         "major:minor" device-number.
     <offset>:
-	Starting sector within the device.
+        Starting sector within the device.
+    <options>:
+        Options allow to set the exclusivity mode. The exclusivity mode
+        can be 'excl' and 'noexcl'. By default, then options is not set,
+        the 'excl' mode is used. 'noexcl' mode allow to open device
+        without FMODE_EXCL flag. This allow to create liner device with
+        underlying block-device that are already used by the system. For
+        example, the file system on this device is already mounted.
+        The 'noexcl' option should be used when creating dm devices that
+        will be used as acceptor when connecting the device mapper to an
+        existing block device with the 'dmsetup remap' command.
 
 
 Example scripts
@@ -61,3 +71,13 @@ Example scripts
   }
 
   `echo \"$table\" | dmsetup create $name`;
+
+::
+
+  #!/bin/sh
+  # Create linear device and remap all requests from the original device
+  # to new linear.
+  DEV=$1
+
+  echo "0 `blockdev --getsz $DEV` linear $DEV 0 noexcl" | dmsetup create dm-noexcl
+  dmsetup remap start dm-noexcl $DEV
-- 
2.20.1


Return-Path: <SRS0=7FI7=SR=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35762C10F13
	for <linux-block@archiver.kernel.org>; Mon, 15 Apr 2019 01:22:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F3D4420833
	for <linux-block@archiver.kernel.org>; Mon, 15 Apr 2019 01:22:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726906AbfDOBWl (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sun, 14 Apr 2019 21:22:41 -0400
Received: from mx1.redhat.com ([209.132.183.28]:50484 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726415AbfDOBWl (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Sun, 14 Apr 2019 21:22:41 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 0106530820DD;
        Mon, 15 Apr 2019 01:22:41 +0000 (UTC)
Received: from localhost (ovpn-8-22.pek2.redhat.com [10.72.8.22])
        by smtp.corp.redhat.com (Postfix) with ESMTP id DE1645C1B4;
        Mon, 15 Apr 2019 01:22:37 +0000 (UTC)
From:   Ming Lei <ming.lei@redhat.com>
To:     Omar Sandoval <osandov@fb.com>
Cc:     linux-block@vger.kernel.org, Ming Lei <ming.lei@redhat.com>,
        Eric Sandeen <esandeen@redhat.com>,
        Dave Chinner <dchinner@redhat.com>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        linux-xfs@vger.kernel.org
Subject: [PATCH] nvme/012 & 013: avoid extremely slow xfs IO
Date:   Mon, 15 Apr 2019 09:22:29 +0800
Message-Id: <20190415012229.20689-1-ming.lei@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.47]); Mon, 15 Apr 2019 01:22:41 +0000 (UTC)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

It is observed that nvme/012 may take ~17 minutes to complete on aarch64,
even worse it may trigger IO timeout on nvme-loop.

Eric and Dave replied that it is because of too small log size on small
disk.

So pass '-l size=32m' to avoid the issue.

With this patch, nvme/012 can be completed in one minute.

Cc: Eric Sandeen <esandeen@redhat.com>
Cc: Dave Chinner <dchinner@redhat.com>
Cc: "Darrick J. Wong" <darrick.wong@oracle.com>
Cc: linux-xfs@vger.kernel.org
Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 tests/nvme/012 | 2 +-
 tests/nvme/013 | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/tests/nvme/012 b/tests/nvme/012
index 9a6801511df7..d7a8751ec752 100755
--- a/tests/nvme/012
+++ b/tests/nvme/012
@@ -46,7 +46,7 @@ test() {
 
 	umount ${mount_dir} > /dev/null 2>&1
 
-	mkfs.xfs -f /dev/"${nvmedev}n1" > /dev/null 2>&1
+	mkfs.xfs -l size=32m -f /dev/"${nvmedev}n1" > /dev/null 2>&1
 
 	mount /dev/"${nvmedev}n1" "${mount_dir}"
 
diff --git a/tests/nvme/013 b/tests/nvme/013
index e346cd4baa35..bc435f752dca 100755
--- a/tests/nvme/013
+++ b/tests/nvme/013
@@ -44,7 +44,7 @@ test() {
 
 	umount ${mount_dir} > /dev/null 2>&1
 
-	mkfs.xfs -f /dev/"${nvmedev}n1" > /dev/null 2>&1
+	mkfs.xfs -l size=32m  -f /dev/"${nvmedev}n1" > /dev/null 2>&1
 
 	mount /dev/"${nvmedev}n1" "${mount_dir}"
 
-- 
2.9.5


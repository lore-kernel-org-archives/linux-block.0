Return-Path: <SRS0=RPGG=PR=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC524C43387
	for <linux-block@archiver.kernel.org>; Wed,  9 Jan 2019 01:36:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 792F520821
	for <linux-block@archiver.kernel.org>; Wed,  9 Jan 2019 01:36:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="U6puOVwv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729403AbfAIBgJ (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 8 Jan 2019 20:36:09 -0500
Received: from esa1.hgst.iphmx.com ([68.232.141.245]:65001 "EHLO
        esa1.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729067AbfAIBgI (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 8 Jan 2019 20:36:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1546997768; x=1578533768;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=L9E4l+6ANv/d43USrlZmOsTnsJ3+Z79Ca+1aHtg5aG8=;
  b=U6puOVwvDEbfa6fqMuZ7RKspqHqPoRmD7mwyZ6RJ25qWHBzq5xb0BKIL
   k9L2ONH2caLnPzsybMcVk9t9ni+DKHKtR7+tNQ/bLX94XgrJ5Abv2+q7f
   QvXskn4cqBPHfeJOCfPvfrMeJm8+QYGp+171Snrp5E1Y49ueI70rJvXC5
   xTVyLtNweGUNZ2drzsUHxjQe1Oq9u9sSijvJT+NWgF0Zovqr6+RFNiyz/
   +NgdYVEQPbDuojqzDSPZFKj3BJD7rrKLrlocCZr52dSda3BjdCtqks4Wl
   ua7x+C6VdzZ9uGJ9xL2WcCROHQqbjN2LvG0OQIRN4zWMcR/vmxeitQvDA
   g==;
X-IronPort-AV: E=Sophos;i="5.56,455,1539619200"; 
   d="scan'208";a="203169151"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 09 Jan 2019 09:36:08 +0800
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP; 08 Jan 2019 17:16:09 -0800
Received: from washi.fujisawa.hgst.com ([10.149.53.254])
  by uls-op-cesaip01.wdc.com with ESMTP; 08 Jan 2019 17:36:06 -0800
From:   Damien Le Moal <damien.lemoal@wdc.com>
To:     linux-block@vger.kernel.org, Omar Sandoval <osandov@fb.com>,
        Masato Suzuki <masato.suzuki@wdc.com>,
        Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Cc:     Omar Sandoval <osandov@osandov.com>, Jens Axboe <axboe@kernel.dk>,
        Matias Bjorling <matias.bjorling@wdc.com>,
        Hannes Reinecke <hare@suse.de>,
        Mike Snitzer <snitzer@redhat.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>
Subject: [PATCH blktests 03/14] common: Move set_scheduler() function from multipath-over-rdma to rc
Date:   Wed,  9 Jan 2019 10:35:31 +0900
Message-Id: <20190109013542.23686-4-damien.lemoal@wdc.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190109013542.23686-1-damien.lemoal@wdc.com>
References: <20190109013542.23686-1-damien.lemoal@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

From: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>

set_scheduler() function defined in common/multipath-over-rdma is useful
to set up specific IO scheduler not only for multipath tests but also for
zoned block device tests. Move the function to common/rc to reuse it for
test groups other than multipath.

Signed-off-by: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
---
 common/multipath-over-rdma | 24 ------------------------
 common/rc                  | 24 ++++++++++++++++++++++++
 2 files changed, 24 insertions(+), 24 deletions(-)

diff --git a/common/multipath-over-rdma b/common/multipath-over-rdma
index 308c9b5..6bea8e4 100644
--- a/common/multipath-over-rdma
+++ b/common/multipath-over-rdma
@@ -275,30 +275,6 @@ mount_configfs() {
 	fi
 }
 
-# Set scheduler of block device $1 to $2.
-set_scheduler() {
-	local b=$1 p s=$2
-
-	p=/sys/class/block/$b/queue/scheduler
-	if [ -e "/sys/block/$b/mq" ]; then
-		case "$s" in
-			noop)        s=none;;
-			deadline)    s=mq-deadline;;
-			bfq)         s=bfq;;
-		esac
-	else
-		case "$s" in
-			none)        s=noop;;
-			mq-deadline) s=deadline;;
-			bfq-mq)      s=bfq;;
-		esac
-	fi
-	if ! echo "$s" > "$p"; then
-		echo "Changing scheduler of $b from $(<"$p") into $s failed"
-		return 1
-	fi
-}
-
 # Get a /dev/... path that points at dm device number $1. Set its I/O scheduler
 # to $2 and its timeout to $3. The shell script that includes this file must
 # define a function get_bdev_path() that translates device number $1 into a
diff --git a/common/rc b/common/rc
index 999590d..85f6468 100644
--- a/common/rc
+++ b/common/rc
@@ -223,3 +223,27 @@ _test_dev_is_zoned() {
 	fi
 	return 0
 }
+
+# Set scheduler of block device $1 to $2.
+set_scheduler() {
+	local b=$1 p s=$2
+
+	p=/sys/class/block/$b/queue/scheduler
+	if [ -e "/sys/block/$b/mq" ]; then
+		case "$s" in
+			noop)        s=none;;
+			deadline)    s=mq-deadline;;
+			bfq)         s=bfq;;
+		esac
+	else
+		case "$s" in
+			none)        s=noop;;
+			mq-deadline) s=deadline;;
+			bfq-mq)      s=bfq;;
+		esac
+	fi
+	if ! echo "$s" > "$p"; then
+		echo "Changing scheduler of $b from $(<"$p") into $s failed"
+		return 1
+	fi
+}
-- 
2.20.1


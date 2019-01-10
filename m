Return-Path: <SRS0=tdSH=PS=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5D66C43387
	for <linux-block@archiver.kernel.org>; Thu, 10 Jan 2019 09:37:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A848D214DA
	for <linux-block@archiver.kernel.org>; Thu, 10 Jan 2019 09:37:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="ibem4mrv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727900AbfAJJhn (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 10 Jan 2019 04:37:43 -0500
Received: from esa2.hgst.iphmx.com ([68.232.143.124]:25539 "EHLO
        esa2.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727780AbfAJJhn (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 10 Jan 2019 04:37:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1547113100; x=1578649100;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=VkM8mcqCoPUhPptDLmEbCYbmAZtaGQ2y3SVflzTHfiQ=;
  b=ibem4mrv9m9FIoJiTlnqBoOAH6HLCSrhxVoCP4fhQ/UmsXzaQySAaQ9r
   lZi3eB7Ha9boMFabraELxezl8NQNAVXsKopf/aXkFKGUqojVGRoAzGZw1
   lFiBm0+DoOR631yG8czoYr7YRSEV0GDSCgNxeL0my/suiLARgUWFVmHyS
   kT3WOfajuedmELvMXcvNhWGuGAWTO0PFLgPwXaNVctW5NMgScIacQ58rX
   IDzOeiq0orT/V1XkR3QVspzi6Rb28vQiFQk0mF4EkjTC12xaRnNkOD3zm
   J6/ld/1fSj6BLVty1zrPEt2v/2xN4hCSbLQkmrDZEc1+lwtZUczgM4vKp
   Q==;
X-IronPort-AV: E=Sophos;i="5.56,460,1539619200"; 
   d="scan'208";a="196468976"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 10 Jan 2019 17:38:19 +0800
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep02.wdc.com with ESMTP; 10 Jan 2019 01:19:13 -0800
Received: from shin_dev.dhcp.fujisawa.hgst.com (HELO shin_dev.fujisawa.hgst.com) ([10.149.52.166])
  by uls-op-cesaip01.wdc.com with ESMTP; 10 Jan 2019 01:37:39 -0800
From:   Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To:     linux-block@vger.kernel.org, Omar Sandoval <osandov@fb.com>,
        Masato Suzuki <masato.suzuki@wdc.com>,
        Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Cc:     Omar Sandoval <osandov@osandov.com>, Jens Axboe <axboe@kernel.dk>,
        Matias Bjorling <matias.bjorling@wdc.com>,
        Hannes Reinecke <hare@suse.de>,
        Mike Snitzer <snitzer@redhat.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
Subject: [PATCH blktests v2 03/16] common: Move set_scheduler() function definition
Date:   Thu, 10 Jan 2019 18:37:12 +0900
Message-Id: <20190110093725.32675-4-shinichiro.kawasaki@wdc.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190110093725.32675-1-shinichiro.kawasaki@wdc.com>
References: <20190110093725.32675-1-shinichiro.kawasaki@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

set_scheduler() function defined in common/multipath-over-rdma is useful
to set up a specific IO scheduler not only for multipath tests but also
for zoned block device tests. Move this function to common/rc to allow
its use in test groups other than multipath.

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
index e628f96..0b99e84 100644
--- a/common/rc
+++ b/common/rc
@@ -222,3 +222,27 @@ _test_dev_is_zoned() {
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


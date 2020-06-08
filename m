Return-Path: <SRS0=X1aF=7V=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D315CC433DF
	for <linux-block@archiver.kernel.org>; Mon,  8 Jun 2020 02:45:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AAEAA2076A
	for <linux-block@archiver.kernel.org>; Mon,  8 Jun 2020 02:45:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="a1/kIHm+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728409AbgFHCpC (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sun, 7 Jun 2020 22:45:02 -0400
Received: from esa2.hgst.iphmx.com ([68.232.143.124]:15423 "EHLO
        esa2.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726662AbgFHCpB (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Sun, 7 Jun 2020 22:45:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1591584320; x=1623120320;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=YjnlhYMW1uN7q333xkwiIqK4qzzLwttuJbouQS4B9lw=;
  b=a1/kIHm+KXjh4Y+1h72gGcD3pYrqhQf+hUYMfHD0L2NSmNMAy+0vkChC
   3WXlb2RSj0c7YJ0WZ0imW9UmSS7K71Lyf2aDv70LfLMnHZNjZQB8+4iWO
   8k7L0nJJr6zg6CBfAN3soJVj7II+iJe7FmiQezX9GUWo3SaWAOfRxgVlm
   rbeVisaeAKWkF6WjrVPZXmC+KxsPfk2CN2qB4kXyoOeQuO/MAl9ktjRW1
   2+CTUkJuHzFw+YKUocLUb5rpqKjlwsyn+N3Q0yetT5SrbDSFGGMkawYwI
   oF6obOk/xlCI93l4Fcvsy1NyJN8KBa1Z2iS5+sop6A2yLowK9VZLBdVl/
   A==;
IronPort-SDR: KZdbDBhEdp43+OQ7hBr/ap7uzlDrK2yrZOo3hPkw51Vj8Hc1Y5PdfzQDJK2jvhfk4HcB1IIdjO
 /PDieTcatcgi/X9cQEwHSPTxncEuteoXQhzZfM5N9adb/JvZZVkzVMKB19UvW5tOgsQzAibo+X
 rBSoerG3p9LA0pXFgCf35c9JdAT6WuEwceez+zVEe1F3vcKY+/u+/6+aGneXyWm35m2CXU/nAC
 EtOJd53ZaPg/q3U/O4NEDbJmmm/rrJa7822FsK8M9qeOkpfZpKRLjEXQyMbsuZxneiSzb+wEEu
 TVA=
X-IronPort-AV: E=Sophos;i="5.73,486,1583164800"; 
   d="scan'208";a="242314963"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 08 Jun 2020 10:45:19 +0800
IronPort-SDR: Owmj+erTujn8eo4hxRR9/eB0H0Zf2MHtXJdjq46dy/bm7fF8BrY/hjSlJNbutgNe6FXXY48d8i
 a1BPhaFQb9hgQVKIRlLYZ4sL4UWi4xq40=
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jun 2020 19:33:58 -0700
IronPort-SDR: 6EOdhKqcu2nR7nG1s1nJTLVxtZ1UxNSe3lk142ONz6Q6rVxwtFjwACtiOyAfzg3CDKykJ0ptdR
 DRINeVHzR9Bw==
WDCIronportException: Internal
Received: from shindev.dhcp.fujisawa.hgst.com (HELO shindev.fujisawa.hgst.com) ([10.149.53.87])
  by uls-op-cesaip02.wdc.com with ESMTP; 07 Jun 2020 19:45:00 -0700
From:   Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To:     linux-block@vger.kernel.org, Omar Sandoval <osandov@fb.com>
Cc:     Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
        Damien Le Moal <Damien.LeMoal@wdc.com>,
        Omar Sandoval <osandov@osandov.com>,
        Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
Subject: [PATCH blktests] zbd/007: Add --force option to blkzone reset
Date:   Mon,  8 Jun 2020 11:44:58 +0900
Message-Id: <20200608024458.881519-1-shinichiro.kawasaki@wdc.com>
X-Mailer: git-send-email 2.25.4
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

The test case zbd/007 utilizes blkzone command from util-linux project
to reset zones of test target devices. Recently, blkzone was modified to
report EBUSY error when it was called to change zone status of devices
used by the system. This avoids unintended zone status change by mistake
and good for most of use cases.

However this change triggered failure of the test case zbd/007 with the
EBUSY error. The test case executes blkzone to reset zones of block devices
which the system maps to container devices such as dm-linear.

To avoid this failure, modify zbd/007 to check if blkzone supports --force
option. And if it is supported, add it to blkzone command line. This option
was introduced to blkzone to allow zone status change of devices even when
the system use them.

Signed-off-by: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
---
 tests/zbd/007 | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/tests/zbd/007 b/tests/zbd/007
index 2376b3a..9d7ca67 100755
--- a/tests/zbd/007
+++ b/tests/zbd/007
@@ -68,7 +68,7 @@ test_device() {
 
 	# Reset and move write pointers of the container device
 	for ((i=0; i < ${#test_z[@]}; i++)); do
-		local -a arr
+		local -a arr opts
 
 		read -r -a arr < <(_get_dev_container_and_sector \
 					   "${test_z_start[i]}")
@@ -77,8 +77,11 @@ test_device() {
 
 		echo "${container_dev}" "${container_start}" >> "$FULL"
 
-		if ! blkzone reset -o "${container_start}" -c 1 \
-		     "${container_dev}"; then
+		opts=(-o "${container_start}" -c 1)
+		if blkzone -h | grep -q -e --force; then
+			opts+=(--force)
+		fi
+		if ! blkzone reset "${opts[@]}" "${container_dev}"; then
 			echo "Reset zone failed"
 			return 1
 		fi
-- 
2.25.4


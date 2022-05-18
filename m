Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A74EC433F5
	for <linux-block@archiver.kernel.org>; Wed, 18 May 2022 06:44:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231388AbiERGo1 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 18 May 2022 02:44:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231247AbiERGoZ (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 18 May 2022 02:44:25 -0400
Received: from heian.cn.fujitsu.com (mail.cn.fujitsu.com [183.91.158.132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 899486D1A7
        for <linux-block@vger.kernel.org>; Tue, 17 May 2022 23:44:24 -0700 (PDT)
IronPort-Data: =?us-ascii?q?A9a23=3A9aauQqmsaieUPq7U8l/LDHHo5gxXJERdPkR7XQ2?=
 =?us-ascii?q?eYbTBsI5bpzQHnTRJX2qEPfuPazD0KYpzb9uxpkkAvpTUnNZnHlQ4+CA2RRqmi?=
 =?us-ascii?q?+KfW43BcR2Y0wB+jyH7ZBs+qZ1YM7EsFehsJpPnjkrrYuiJQUVUj/nSHOKmULe?=
 =?us-ascii?q?cY0ideCc/IMsfoUM68wIGqt4w6TSJK1vlVeLa+6UzCnf8s9JHGj58B5a4lf9al?=
 =?us-ascii?q?K+aVAX0EbAJTasjUFf2zxH5BX+ETE27ByOQroJ8RoZWSwtfpYxV8F81/z91Yj+?=
 =?us-ascii?q?kur39NEMXQL/OJhXIgX1TM0SgqkEa4HVsjeBgb7xBAatUo2zhc9RZ2dxLuoz2S?=
 =?us-ascii?q?xYBMLDOmfgGTl9TFCQW0ahuoeWbeiHn7JPIp6HBWz62qxl0N2k8I4Qe8/1sCmF?=
 =?us-ascii?q?D3fUTLXYKdB/rr+WtybS3TfdEiM5lJ87uVKsOuzdyzTjfAt48TJzDSrmM7thdt?=
 =?us-ascii?q?B80h8ZTDbPUY80SahJxYxnaJR5CIFEaDNQ5hujAu5VVW1W0s3rM/exuvTeVl1c?=
 =?us-ascii?q?3jdDQ3BPuUoTiba1ocoyw/AoqJ1jEPyw=3D?=
IronPort-HdrOrdr: =?us-ascii?q?A9a23=3A+hRh3qOmctd888BcTv2jsMiBIKoaSvp037BL?=
 =?us-ascii?q?7TEUdfUxSKGlfq+V8sjzqiWftN98YhAdcLO7Scy9qBHnhP1ICOAqVN/MYOCMgh?=
 =?us-ascii?q?rLEGgN1+vf6gylMyj/28oY7q14bpV5YeeaMXFKyer8/ym0euxN/OW6?=
X-IronPort-AV: E=Sophos;i="5.88,333,1635177600"; 
   d="scan'208";a="124310573"
Received: from unknown (HELO cn.fujitsu.com) ([10.167.33.5])
  by heian.cn.fujitsu.com with ESMTP; 18 May 2022 14:44:23 +0800
Received: from G08CNEXMBPEKD06.g08.fujitsu.local (unknown [10.167.33.206])
        by cn.fujitsu.com (Postfix) with ESMTP id AC5584D1718C;
        Wed, 18 May 2022 14:44:19 +0800 (CST)
Received: from G08CNEXCHPEKD08.g08.fujitsu.local (10.167.33.83) by
 G08CNEXMBPEKD06.g08.fujitsu.local (10.167.33.206) with Microsoft SMTP Server
 (TLS) id 15.0.1497.23; Wed, 18 May 2022 14:44:19 +0800
Received: from localhost.localdomain (10.167.215.54) by
 G08CNEXCHPEKD08.g08.fujitsu.local (10.167.33.209) with Microsoft SMTP Server
 id 15.0.1497.23 via Frontend Transport; Wed, 18 May 2022 14:44:20 +0800
From:   Xiao Yang <yangx.jy@fujitsu.com>
To:     <osandov@fb.com>, <yi.zhang@redhat.com>, <bvanassche@acm.org>
CC:     <linux-block@vger.kernel.org>, Xiao Yang <yangx.jy@fujitsu.com>
Subject: [PATCH blktests] srp/011: Avoid $dev becoming invalid during test
Date:   Wed, 18 May 2022 14:44:17 +0800
Message-ID: <20220518064417.47473-1-yangx.jy@fujitsu.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-yoursite-MailScanner-ID: AC5584D1718C.A768B
X-yoursite-MailScanner: Found to be clean
X-yoursite-MailScanner-From: yangx.jy@fujitsu.com
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

$dev will become invalid when log_out has been done
and fio doesn't run yet. In this case subsequent fio
throws the following error:
-------------------------------------
    From diff -u 011.out 011.out.bad
    Configured SRP target driver
    -Passed

    From 011.full:
    fio: looks like your file system does not support direct=1/buffered=0
    fio: destination does not support O_DIRECT
    run_fio exit code: 1
-------------------------------------
This issue happens randomly.

Try to fix the issue by holding $dev before test.

Signed-off-by: Xiao Yang <yangx.jy@fujitsu.com>
---
 tests/srp/011 | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/tests/srp/011 b/tests/srp/011
index 29b2c03..63ff332 100755
--- a/tests/srp/011
+++ b/tests/srp/011
@@ -12,6 +12,8 @@ test_disconnect_repeatedly() {
 
 	use_blk_mq y y || return $?
 	dev=$(get_bdev 0) || return $?
+	# Hold $dev
+	exec 3< "$dev"
 	simulate_network_failure_loop "$dev" "$TIMEOUT" &
 	run_fio --verify=md5 --rw=randwrite --bs=4K --loops=10000 \
 		--ioengine=libaio --iodepth=64 --iodepth_batch=32 \
@@ -22,6 +24,8 @@ test_disconnect_repeatedly() {
 		>>"$FULL"
 	fio_status=$?
 	wait
+	# Release $dev
+	exec 3<&-
 	log_in
 	return $fio_status
 }
-- 
2.34.1




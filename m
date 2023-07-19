Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA2CEC001E0
	for <linux-block@archiver.kernel.org>; Wed, 19 Jul 2023 07:15:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229689AbjGSHPX (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 19 Jul 2023 03:15:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229697AbjGSHPR (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 19 Jul 2023 03:15:17 -0400
Received: from esa6.hgst.iphmx.com (esa6.hgst.iphmx.com [216.71.154.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF88E1735
        for <linux-block@vger.kernel.org>; Wed, 19 Jul 2023 00:15:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1689750916; x=1721286916;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Muv7okmANNU+PV9/u8DFacQ6U9dpbwAvw/i9eTSpfm4=;
  b=WwknIPsWl1gM6q0ts4HTAQT7uNa+5DA5/7Nj14Y/UbN//LZOdU09hRo6
   HUBE399pErcX07poaKG52qjH2IanzrJ95fox1IDlI10Ni+LqUY/ly407A
   yja3WQSs/1ru8wKp/gksFmBD3RPIBfE91QKED4B9WL9bnlRdNCw46waFp
   uuUrf9cRtBzWhIcdO8CjaRUbp0ZkwS5V4ESKA0J/W73VvLx7MNxhNvgmX
   UyR3V2G2NtIJx9XJRygxguZXfoGnOqEQQ0LoPD++vjLhSnx1aQHpkUaja
   R7n0BbFR9TALuf7EKDIy7o5Klp9yxrNyzN2FtnbkKOZfg7OY7U0xH39lf
   g==;
X-IronPort-AV: E=Sophos;i="6.01,216,1684771200"; 
   d="scan'208";a="238846523"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 19 Jul 2023 15:15:16 +0800
IronPort-SDR: nVMZeeTDWSjGqb9mReecdvFWV4HAwZMG9mPQ0QjdmRMIFtWLDWHPD3fQPf9ezwSPKA2aYybzQA
 64ge7gZjC3n+B+m9rudRLyj9LOjbhpjO18RCo6UXBti3RUWiZmPiynXS50qHiuDJ/J8bNazUCE
 P0yPGq+soOWKCBcK2hHVZ+TPY/Tk9Ol7OH3tRlmr6B7KM2MnDokGl2uuD0qEWXZWujnkcnjJjw
 iKBrBZn+3yVuy6XntW6WYUZpg2k5gpRQxLVFqKdtUTgA6zx+QVtvhpPs+wAUSuyw+DL5j8dHGF
 s5U=
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 18 Jul 2023 23:29:08 -0700
IronPort-SDR: Le8lJIjP92WtraEW9tHcNbFnaSZkNo7oGorcH6OlGtsKvelIawnRWStoYYKCwK1f44B5ZiQ9qQ
 2vWfU3xGnKvnIK5n3AYHs7ne4lUOAtP+EzxlQgkVmuJyEWkk3aztqw+NgQpsvY4tby57xDzk3f
 1WyzGNdeVNmU+279v47ey/9Rv9G6Qoe0cSomLMw8u+/uGn+/qTIDNyDubXjITxdTpHFrwSLXUt
 q3CEPLTcnrLsLzAmo0RSW7jc9y1NKqdBf4dlv00VRfmORRiGjG0oqGYX4xVAWrRLb2vO4k9pdm
 58s=
WDCIronportException: Internal
Received: from shindev.dhcp.fujisawa.hgst.com (HELO shindev.fujisawa.hgst.com) ([10.149.53.55])
  by uls-op-cesaip01.wdc.com with ESMTP; 19 Jul 2023 00:15:14 -0700
From:   Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To:     linux-block@vger.kernel.org
Cc:     Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Subject: [PATCH blktests 5/6] block/004, zbd/{005,006}: call _test_dev_set_scheduler
Date:   Wed, 19 Jul 2023 16:15:09 +0900
Message-Id: <20230719071510.530623-6-shinichiro.kawasaki@wdc.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230719071510.530623-1-shinichiro.kawasaki@wdc.com>
References: <20230719071510.530623-1-shinichiro.kawasaki@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

The test cases block/004, zbd/005 and zbd/006 do write to zoned block
devices which require mq-deadline scheduler. When TEST_DEV is a bio
based device-mapper, mq-deadline scheduler shall be set to destination
devices. For this purpose, call _test_dev_set_scheduler instead of
_test_dev_queue_set.

Signed-off-by: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
---
 tests/block/004 | 2 +-
 tests/zbd/005   | 2 +-
 tests/zbd/006   | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/tests/block/004 b/tests/block/004
index a7cec95..63484a4 100755
--- a/tests/block/004
+++ b/tests/block/004
@@ -24,7 +24,7 @@ test_device() {
 	local -a opts=()
 
 	if _test_dev_is_zoned; then
-		_test_dev_queue_set scheduler deadline
+		_test_dev_set_scheduler deadline
 		opts+=("--direct=1" "--zonemode=zbd")
 		opts+=("--max_open_zones=$(_test_dev_max_open_active_zones)")
 	fi
diff --git a/tests/zbd/005 b/tests/zbd/005
index a7fb175..4aa1ab5 100755
--- a/tests/zbd/005
+++ b/tests/zbd/005
@@ -48,7 +48,7 @@ test_device() {
 
 	blkzone reset -o "${ZONE_STARTS[zone_idx]}" "${TEST_DEV}"
 
-	_test_dev_queue_set scheduler deadline
+	_test_dev_set_scheduler deadline
 
 	: "${TIMEOUT:=30}"
 	FIO_PERF_FIELDS=("write io" "write iops")
diff --git a/tests/zbd/006 b/tests/zbd/006
index b745acd..2db0e9b 100755
--- a/tests/zbd/006
+++ b/tests/zbd/006
@@ -38,7 +38,7 @@ test_device() {
 
 	blkzone reset -o "${ZONE_STARTS[zone_idx]}" "${TEST_DEV}"
 
-	_test_dev_queue_set scheduler deadline
+	_test_dev_set_scheduler deadline
 
 	: "${TIMEOUT:=30}"
 	FIO_PERF_FIELDS=("write io" "write iops")
-- 
2.40.1


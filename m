Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27A8DC7EE2F
	for <linux-block@archiver.kernel.org>; Fri, 26 May 2023 04:58:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234221AbjEZE6u (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 26 May 2023 00:58:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234842AbjEZE6r (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 26 May 2023 00:58:47 -0400
Received: from esa5.hgst.iphmx.com (esa5.hgst.iphmx.com [216.71.153.144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 145AD13A
        for <linux-block@vger.kernel.org>; Thu, 25 May 2023 21:58:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1685077127; x=1716613127;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=govZswT40GqPisVwCC1SU8A5Yon4GMRNQyG6Geg9+Ds=;
  b=fBiPuAC/OYXPHbd1n5/BOaV+QBAMx7pfHAIUrL1IZg5TyxjkC/gFoZM5
   +4XR5j8ZCNonIbwHBjh5VJXr+oSBCcjK9ZxMNgLYXasnjDCPCIKHlDWKh
   t1l0zUVyeMGHZiq6ecZVuZwUBYlrsi9ad/SUZXxmFm3XUIrtvJN8/qTEd
   5T7kwA3hO03PIm+QIDOH3QE5DoQqELZyW9KuxG7m6aB+urEd9NICzjNhN
   ChMuGizkDUOgXYuo8l/Ym849/40ttvpdOeRnzguctWrPWzVz66MVI14YP
   VODihyBSw8hx38yg175rbKlstDmO+pdnL4S9X5TyaiqmF1KgIYTQDlj9F
   w==;
X-IronPort-AV: E=Sophos;i="6.00,193,1681142400"; 
   d="scan'208";a="231616520"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 26 May 2023 12:58:47 +0800
IronPort-SDR: mopwFtmXfBPrtSIvX2bBDrTUekkKSzLZ4903cTE0hkhZ+e1tduL5dq9n1FfsTZ3cL+ceTmyDQM
 yOZ0+cJPxUUJg/9Wi8j0oSJKfQjTsqrevs0wqU37mqpwhAi8MhBdXmt/x2fMX/nqy4Nc8nSHtw
 IyvDqEfhWLsjGbkfX5GQCuG4FoBEoA3f2fBeQOEKyTQcB9oIGMFDQw+CNgcLWZfmT2c1dPC8ai
 DNsdyVJbYMGNqaTrbLMs64clGmvl1k/3ixs2iXSBmCX+ANbwKIN8BP4DdBxmPMIch5go1eiKk9
 CPk=
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 25 May 2023 21:08:04 -0700
IronPort-SDR: NUuM5LWV81tnOdPR86BoSnDEOy4xwg2Ls8jnkslpCzrbGid7kbWP4EHJbFS0bh6ETPs2Qm5/9r
 Eq/7Sr2VyAP1x+psznMOnnQNC1Teptl/itSKreRQvzUBoueGrSPn97u3ID/HfLiBgWtBpYR5Uj
 ISRQoJJWtXCPQeexdwh38F4SdZ9S9u5WFaH49PWJh2rAg6mxJ7q1lw/NPe3LugaWLRNGGFnyH9
 HWMeh7VwHuuO/DwRLYBj4glvz/7jJpsvfIhpSE8lYnKYeXrOVL1/hHjeYiVnpIUqxCNCu1uBUX
 /aA=
WDCIronportException: Internal
Received: from shindev.dhcp.fujisawa.hgst.com (HELO shindev.fujisawa.hgst.com) ([10.149.53.55])
  by uls-op-cesaip02.wdc.com with ESMTP; 25 May 2023 21:58:46 -0700
From:   Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To:     linux-block@vger.kernel.org, linux-nvme@lists.infradead.org
Cc:     Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Subject: [PATCH blktests 3/3] block/011: recover test target NVME device capacity
Date:   Fri, 26 May 2023 13:58:43 +0900
Message-Id: <20230526045843.168739-4-shinichiro.kawasaki@wdc.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230526045843.168739-1-shinichiro.kawasaki@wdc.com>
References: <20230526045843.168739-1-shinichiro.kawasaki@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

The test case runs fio while disabling and enabling PCI device of the
test target block device. When the block device is a NVME PCI device,
the test triggers NVME controller reset. When an error happens during
the reset, NVME PCI driver marks zero capacity for the device. This
zero capacity device causes failures of the following test cases.

To avoid the failures by zero device capacity, check the capacity at the
test end. If it is zero, remove the device and rescan PCI bus to detect
the device again, and regain the correct capacity.

Signed-off-by: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
---
 tests/block/011 | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/tests/block/011 b/tests/block/011
index 0699936..a4230f4 100755
--- a/tests/block/011
+++ b/tests/block/011
@@ -59,4 +59,18 @@ test_device() {
 	done
 
 	echo "Test complete"
+
+	# This test triggers NVME controller resets. When any failure happens
+	# during the resets, the driver marks the NVME block devices with zero
+	# capacity. Then following tests fail with the zero capacity devices. To
+	# get back the correct capacity, remove and rescan the devices.
+	if ((!$(<"$TEST_DEV_SYSFS/size"))); then
+		echo "$TEST_DEV has zero capacity" >> "$FULL"
+		if [[ -w $TEST_DEV_SYSFS/device/device/remove ]] &&
+			   [[ -w /sys/bus/pci/rescan ]]; then
+			echo "Rescan to tegain the correct capacity" >> "$FULL"
+			echo 1 > "$TEST_DEV_SYSFS/device/device/remove"
+			echo 1 > /sys/bus/pci/rescan
+		fi
+	fi
 }
-- 
2.40.1


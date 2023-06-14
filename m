Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63FAFEB64D8
	for <linux-block@archiver.kernel.org>; Wed, 14 Jun 2023 19:31:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230195AbjFNTbn (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 14 Jun 2023 15:31:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233075AbjFNTbn (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 14 Jun 2023 15:31:43 -0400
Received: from mailout3.samsung.com (mailout3.samsung.com [203.254.224.33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5171129
        for <linux-block@vger.kernel.org>; Wed, 14 Jun 2023 12:31:40 -0700 (PDT)
Received: from epcas5p3.samsung.com (unknown [182.195.41.41])
        by mailout3.samsung.com (KnoxPortal) with ESMTP id 20230614193134epoutp03adb760868b95702612e9ebea91534722~onV_hm4cN3236532365epoutp03N
        for <linux-block@vger.kernel.org>; Wed, 14 Jun 2023 19:31:34 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20230614193134epoutp03adb760868b95702612e9ebea91534722~onV_hm4cN3236532365epoutp03N
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1686771094;
        bh=FSD6U1IcbHwg8HuGnCy6Yna3tOdSfIwmGmDZosr6cgY=;
        h=From:To:Cc:Subject:Date:References:From;
        b=sGYGPy0YHseSomebck2sVfd5kZHhjxAdb1Yctp3xT892obT1+PgHrs+Jrbv3/Z7UD
         2KEfsoONoe5s83tYkU73LmFAKdDpBM/JjCgOUDTShqT5ViJqSeERUUohgflXroAGsD
         mL+qPWE7n7fy4xYvj3t+Yc126ZwnKpg7FZMqby2M=
Received: from epsnrtp4.localdomain (unknown [182.195.42.165]) by
        epcas5p1.samsung.com (KnoxPortal) with ESMTP id
        20230614193134epcas5p1404fa723021561ef03cb9f8d193d7641~onV_KjeIb1037010370epcas5p1d;
        Wed, 14 Jun 2023 19:31:34 +0000 (GMT)
Received: from epsmges5p3new.samsung.com (unknown [182.195.38.182]) by
        epsnrtp4.localdomain (Postfix) with ESMTP id 4QhFsc3r0Nz4x9Pq; Wed, 14 Jun
        2023 19:31:32 +0000 (GMT)
Received: from epcas5p4.samsung.com ( [182.195.41.42]) by
        epsmges5p3new.samsung.com (Symantec Messaging Gateway) with SMTP id
        7F.3C.16380.4951A846; Thu, 15 Jun 2023 04:31:32 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas5p3.samsung.com (KnoxPortal) with ESMTPA id
        20230614170954epcas5p33d4ddecf3bf2ff178068b073ff2e2a06~olaSZ9D_B0962809628epcas5p33;
        Wed, 14 Jun 2023 17:09:54 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20230614170954epsmtrp1b421a97a763330d7c03075e293c8af83~olaSZW4ch2197721977epsmtrp1_;
        Wed, 14 Jun 2023 17:09:54 +0000 (GMT)
X-AuditID: b6c32a4b-7dffd70000013ffc-83-648a15940598
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        48.B8.27706.264F9846; Thu, 15 Jun 2023 02:09:54 +0900 (KST)
Received: from green245.sa.corp.samsungelectronics.net (unknown
        [107.99.41.245]) by epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20230614170953epsmtip1f17bdeb5b9e31413e18fb5e32ddce487~olaRo2aaV2673526735epsmtip1t;
        Wed, 14 Jun 2023 17:09:53 +0000 (GMT)
From:   Nitesh Shetty <nj.shetty@samsung.com>
To:     shinichiro.kawasaki@wdc.com, gost.dev@samsung.com
Cc:     linux-block@vger.kernel.org, Nitesh Shetty <nj.shetty@samsung.com>
Subject: [PATCH v2 blktests] block/034: Test memory is released by null-blk
 driver with memory_backed=1
Date:   Wed, 14 Jun 2023 22:36:42 +0530
Message-Id: <20230614170642.2115-1-nj.shetty@samsung.com>
X-Mailer: git-send-email 2.35.1.500.gb896f729e2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrGKsWRmVeSWpSXmKPExsWy7bCmlu4U0a4Ug69/pC1uHtjJZLH3lrbF
        tt/zmS32zfJ0YPHo27KK0ePzJjmP9gPdTAHMUdk2GamJKalFCql5yfkpmXnptkrewfHO8aZm
        Boa6hpYW5koKeYm5qbZKLj4Bum6ZOUC7lBTKEnNKgUIBicXFSvp2NkX5pSWpChn5xSW2SqkF
        KTkFJgV6xYm5xaV56Xp5qSVWhgYGRqZAhQnZGQcn/WcreC1UcfGOdgPjQv4uRk4OCQETia93
        5rJ1MXJxCAnsZpR4NnMDK4TziVFi7cuzUM43RoneFQ8YYVpmL58O1bKXUWLvtl9QVa1MElvO
        /mfuYuTgYBPQljj9nwOkQUTAVOLQPZAaTg5mATeJSZtesYDYwgKZEq+3PQCLswioSqxb0ATW
        yitgKdG+UxHElBDQl+i/LwhSwSsgKHFy5hMWiCnyEs1bZzODbJUQWMYusWbbDFaI21wkvj17
        xwRhC0u8Or6FHcKWknjZ3wZll0usnLKCDaK5hVFi1vVZUI/ZS7Se6ge7gVlAU2L9Ln2IsKzE
        1FPrmCAW80n0/n4CNZ9XYsc8GFtZYs36BWwQtqTEte+NULaHxLWmp2A1QgKxEht2vWSewCg/
        C8k/s5D8Mwth8wJG5lWMkqkFxbnpqcWmBcZ5qeXwaE3Oz93ECE5wWt47GB89+KB3iJGJg/EQ
        owQHs5II71ON9hQh3pTEyqrUovz4otKc1OJDjKbAIJ7ILCWanA9MsXkl8YYmlgYmZmZmJpbG
        ZoZK4rzqtieThQTSE0tSs1NTC1KLYPqYODilGpgOL2OV3GW+UfTnVZ/qWOmintyHKn+dtP1m
        uzxxYs64sWyfveCLncp3Dr+KUs2dM+FVctcLRZOnV3oOeAf5fcyJL9ep//xX69/eb+v/WM5T
        4pHNsf5/Ud+2tj0x4eKR1+05HOu1/1iZW7IdWXUwyegI97adflqcC/slTHa8OdMv/I35mdWM
        qjzrSiv2w8uyNV8qpC6T15i9u+WEaPnZsJZdW8XXpW68e//XkvVPxOPEMr0WBEd57hCf9Xr2
        tyKmsuqy3ozK//8WLZ/zosYpXVj/6IM1Vla7wnaUeM5/Yn9T8eGcwqKJNexrnFYnMGn8E1/z
        UGwqv+WyaeIRK+Vnyxo8e2nA8s16TQKnyd9FeeeVWIozEg21mIuKEwEaLhIq+QMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFupnluLIzCtJLcpLzFFi42LZdlhJTjfpS2eKweGDChY3D+xksth7S9ti
        2+/5zBb7Znk6sHj0bVnF6PF5k5xH+4FupgDmKC6blNSczLLUIn27BK6Mg5P+sxW8Fqq4eEe7
        gXEhfxcjJ4eEgInE7OXT2UBsIYHdjBITtoZCxCUllv09wgxhC0us/PecvYuRC6immUli3pG1
        QA0cHGwC2hKn/3OA1IgImEtMWwAxh1nAQ+LMzeeMILawQLrEia3L2EFsFgFViXULmphBWnkF
        LCXadyqCmBIC+hL99wVBKngFBCVOznzCAjFFXqJ562zmCYx8s5CkZiFJLWBkWsUomVpQnJue
        W2xYYJiXWq5XnJhbXJqXrpecn7uJERxmWpo7GLev+qB3iJGJg/EQowQHs5II71ON9hQh3pTE
        yqrUovz4otKc1OJDjNIcLErivBe6TsYLCaQnlqRmp6YWpBbBZJk4OKUamALfzFB7KTn/XdL1
        axa7C95UG5RufBf8uWnZ6vtHMtbOOK1sW+nPnsn1vTAh+L2NunwgU2XK9vqbkjN+bckX5TaZ
        qhg+30P1gdOrIvnP2ocVdT3jjPb4Bp6dc7tdYJfNTufPh556bLA+kRcSGK03Y6ttpkT6OyaB
        asmHKQHPOrXtRF9+eTXTd2Gw6sbDbQ3qwsKmmlem5kRPnJhx6GxTy/vuoI/HvikujC66tlsg
        0VWrgDVE6VHmQqPSgNa6v0x1s9KMxXvWWFdkb06ujFrKuu7VveP1+9/tZOj+9+mZyAn79XM3
        zXJcka8bYCnWLsv/K6PQQdpSddvWOuFHvw1Mp7IzW036+vFk4G9hiy/JSizFGYmGWsxFxYkA
        E2pq6qICAAA=
X-CMS-MailID: 20230614170954epcas5p33d4ddecf3bf2ff178068b073ff2e2a06
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20230614170954epcas5p33d4ddecf3bf2ff178068b073ff2e2a06
References: <CGME20230614170954epcas5p33d4ddecf3bf2ff178068b073ff2e2a06@epcas5p3.samsung.com>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

This tests memory leak, by loading/unloading nullblk driver.
Steps:
	1. Load nullblk driver with memory_backed=1
	2. "dd" of 50M
	3. Unload null-blk driver
We do it for 5 iterations to avoid any noise.

Commit 8cfb98196cceec35416041c6b91212d2b99392e4 fixes issue in kernel

Signed-off-by: Nitesh Shetty <nj.shetty@samsung.com>
---
 tests/block/034     | 60 +++++++++++++++++++++++++++++++++++++++++++++
 tests/block/034.out |  2 ++
 2 files changed, 62 insertions(+)
 create mode 100644 tests/block/034
 create mode 100644 tests/block/034.out

diff --git a/tests/block/034 b/tests/block/034
new file mode 100644
index 0000000..9a3bec4
--- /dev/null
+++ b/tests/block/034
@@ -0,0 +1,60 @@
+#!/bin/bash
+# SPDX-License-Identifier: GPL-3.0+
+# Copyright (C) 2023 Nitesh Shetty
+#
+# Check memory leak when null_blk driver is loaded with memory_backed=1
+
+. tests/block/rc
+. common/null_blk
+
+DESCRIPTION="load/unload null_blk memory_backed=1 to check memleak"
+QUICK=1
+
+requires() {
+	_have_module null_blk
+	_have_module_param null_blk memory_backed
+	_have_program dd
+}
+
+run_nullblk_dd() {
+	if ! _init_null_blk memory_backed=1; then
+		echo "Loading null_blk failed"
+		return 1
+	fi
+	dd if=/dev/urandom of=/dev/nullb0 oflag=direct bs=1M count="$1" > \
+		/dev/null 2>&1
+	_exit_null_blk
+}
+
+free_memory() {
+	sed -n -e 's/^MemFree:[[:blank:]]*\([0-9]*\)[[:blank:]]*kB$/\1/p' \
+		/proc/meminfo
+}
+
+test() {
+	echo "Running ${TEST_NAME}"
+
+	local mem_leak=0 size=50
+	local i mem_start mem_end mem_used
+
+	for ((i = 0; i < 5; i++)); do
+		mem_start=$(free_memory)
+		run_nullblk_dd $size
+		mem_end=$(free_memory)
+
+		mem_used=$(((mem_start - mem_end) / 1024))
+		# -10MB to account for some randomness in freeing by some
+		# simultaneous process
+		if ((mem_used >= size - 10)); then
+			mem_leak=$((mem_leak + 1))
+		fi
+	done
+
+	# There might be possibilty of some random process freeing up memory at
+	# same time nullblk is unloaded.
+	# we consider 3/5 times to be positive.
+	if ((mem_leak > 3)); then
+		echo "Memleak: Memory is not freed by null-blk driver"
+	fi
+	echo "Test complete"
+}
diff --git a/tests/block/034.out b/tests/block/034.out
new file mode 100644
index 0000000..a916dd8
--- /dev/null
+++ b/tests/block/034.out
@@ -0,0 +1,2 @@
+Running block/034
+Test complete
-- 
2.25.1


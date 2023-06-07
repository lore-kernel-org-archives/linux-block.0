Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7218C7EE23
	for <linux-block@archiver.kernel.org>; Mon, 12 Jun 2023 09:22:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233034AbjFLJWB (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 12 Jun 2023 05:22:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233108AbjFLJVU (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 12 Jun 2023 05:21:20 -0400
Received: from mailout4.samsung.com (mailout4.samsung.com [203.254.224.34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9402A4203
        for <linux-block@vger.kernel.org>; Mon, 12 Jun 2023 02:13:57 -0700 (PDT)
Received: from epcas5p2.samsung.com (unknown [182.195.41.40])
        by mailout4.samsung.com (KnoxPortal) with ESMTP id 20230612091354epoutp04455207bbcb6a83f373618a354790fde8~n3oG3A8TT2531025310epoutp04F
        for <linux-block@vger.kernel.org>; Mon, 12 Jun 2023 09:13:54 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20230612091354epoutp04455207bbcb6a83f373618a354790fde8~n3oG3A8TT2531025310epoutp04F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1686561234;
        bh=SwKXuRwbEljvVm+7vOlHhflmuXpNx7cnySFxJAsCnzE=;
        h=From:To:Cc:Subject:Date:References:From;
        b=P8Nnzo8IaMe3btvdfHBO2ajPuvzGHWuQq9cbbByp6Ny0AlDxk2e0Nv+/EqdrHhNVB
         IeOp1ja3nZDVycne/gu8ZKsBAP/siogFkC/MWzCghoapBHTb/Q+aOXSc4//LA6CXfE
         h2ye8eHY+y3nmCqyPzNQfexTeewo4XSJtMT5Nl+8=
Received: from epsnrtp4.localdomain (unknown [182.195.42.165]) by
        epcas5p2.samsung.com (KnoxPortal) with ESMTP id
        20230612091353epcas5p22a39377adbf0872ec0df9922a54ca970~n3oGZE3Ip3066430664epcas5p2I;
        Mon, 12 Jun 2023 09:13:53 +0000 (GMT)
Received: from epsmges5p1new.samsung.com (unknown [182.195.38.178]) by
        epsnrtp4.localdomain (Postfix) with ESMTP id 4QfmFq6J4yz4x9Q8; Mon, 12 Jun
        2023 09:13:51 +0000 (GMT)
Received: from epcas5p2.samsung.com ( [182.195.41.40]) by
        epsmges5p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        D0.59.04567.FC1E6846; Mon, 12 Jun 2023 18:13:51 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas5p1.samsung.com (KnoxPortal) with ESMTPA id
        20230607115145epcas5p1d8a01f6fedf7b3522db1353d1a08e78f~mXjgoKVuF0662106621epcas5p1s;
        Wed,  7 Jun 2023 11:51:45 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20230607115145epsmtrp2696c3a362ef74597d26fb79af8ea36c8~mXjgnlxxw0302803028epsmtrp2X;
        Wed,  7 Jun 2023 11:51:45 +0000 (GMT)
X-AuditID: b6c32a49-943ff700000011d7-ef-6486e1cf0333
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        A0.FA.27706.15F60846; Wed,  7 Jun 2023 20:51:45 +0900 (KST)
Received: from green245.sa.corp.samsungelectronics.net (unknown
        [107.99.41.245]) by epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20230607115144epsmtip2b4a66c0e8f75e74457e5be04dbc5d59f~mXjfu2QkD2502525025epsmtip2-;
        Wed,  7 Jun 2023 11:51:44 +0000 (GMT)
From:   Nitesh Shetty <nj.shetty@samsung.com>
To:     shinichiro.kawasaki@wdc.com, gost.dev@samsung.com
Cc:     linux-block@vger.kernel.org, Nitesh Shetty <nj.shetty@samsung.com>
Subject: [PATCH blktests] block/034: Test memory is released by null-blk
 driver with memory_backed=1
Date:   Wed,  7 Jun 2023 17:18:36 +0530
Message-Id: <20230607114836.9779-1-nj.shetty@samsung.com>
X-Mailer: git-send-email 2.35.1.500.gb896f729e2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrOKsWRmVeSWpSXmKPExsWy7bCmhu75h20pBpf6DS1uHtjJZLH3lrbF
        tt/zmS32zfJ0YPHo27KK0ePzJjmP9gPdTAHMUdk2GamJKalFCql5yfkpmXnptkrewfHO8aZm
        Boa6hpYW5koKeYm5qbZKLj4Bum6ZOUC7lBTKEnNKgUIBicXFSvp2NkX5pSWpChn5xSW2SqkF
        KTkFJgV6xYm5xaV56Xp5qSVWhgYGRqZAhQnZGXdmdrMWPBKq2LJrDVMD43T+LkZODgkBE4mv
        ky+wdTFycQgJ7GaU+N+1gBkkISTwiVGiZ2kNROIbo8Sfh//YYToOLNnKDJHYyygx8/JUdgin
        lUni9LnljF2MHBxsAtoSp/9zgDSICJhKHLr3ixXEZhZwk5i06RULiC0skCbx7/teMJtFQFXi
        yOULYDW8ApYSh852MoGMkRDQl+i/LwgRFpQ4OfMJC8QYeYnmrbPBbpAQWMcusf7GURaI41wk
        HqzdCXWosMSr41ugbCmJz+/2skHY5RIrp6xgg2huYZSYdX0WI0TCXqL1VD8zyGJmAU2J9bv0
        IcKyElNPrWOCWMwn0fv7CRNEnFdixzwYW1lizfoFUPMlJa59b4SyPSSOvbjKAgnRWInt3XtZ
        JzDKz0Lyzywk/8xC2LyAkXkVo2RqQXFuemqxaYFhXmo5PF6T83M3MYJTnJbnDsa7Dz7oHWJk
        4mA8xCjBwawkwqtt0pwixJuSWFmVWpQfX1Sak1p8iNEUGMYTmaVEk/OBSTavJN7QxNLAxMzM
        zMTS2MxQSZxX3fZkspBAemJJanZqakFqEUwfEwenVANT8JoileLeti0hrw9oKlm84DMXZipb
        KRx24j/rA1EOq8d6ldWlWpkuMTeiKg65v3r29eEB/hV6SxLUcvl6D0tOsfRNElCQefH6xO9A
        pm0mUrpLM3NVopwPfJy89V/shI0iV94cF5B7UM+7RpX73k4JJXs7ifwQgwkeanJrpvIJ8rRl
        GrsxfOY3C7vvM53x4o/W+WEJh35dXFMtp+OoY38sM37tzG0pexyX113tS7hfPPnKVyvzS6z7
        znyKVnDzdb1Sf1HBumv6r/3PP57Wn7Uz5sK1mdm7ajrmVc9oEDmnvvHO65/3nzusZH+Vs6bw
        ffGfhf+LXm70U9j7R1w4altSgqXHl5iLU3e36e2+d4lJiaU4I9FQi7moOBEAGatoffoDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprILMWRmVeSWpSXmKPExsWy7bCSvG5gfkOKwbmNmhY3D+xksth7S9ti
        2+/5zBb7Znk6sHj0bVnF6PF5k5xH+4FupgDmKC6blNSczLLUIn27BK6MOzO7WQseCVVs2bWG
        qYFxOn8XIyeHhICJxIElW5m7GLk4hAR2M0rs/7CfDSIhKbHs7xFmCFtYYuW/5+wgtpBAM5PE
        3J9VXYwcHGwC2hKn/3OAhEUEzCWmLZgO1sos4CFx5uZzRhBbWCBFovnKRLBWFgFViSOXL7CC
        2LwClhKHznYygYyRENCX6L8vCBEWlDg58wkLxBh5ieats5knMPLNQpKahSS1gJFpFaNkakFx
        bnpusWGBYV5quV5xYm5xaV66XnJ+7iZGcKhpae5g3L7qg94hRiYOxkOMEhzMSiK8Wfb1KUK8
        KYmVValF+fFFpTmpxYcYpTlYlMR5L3SdjBcSSE8sSc1OTS1ILYLJMnFwSjUwHZ4e4rFUTH1t
        bO4EqzNv98+aJlw/9Sq/dJKXl3fxqncvf207pjfTsU8k8tTWQEahhTsvFev1To2Nc/2j8TAo
        8FkCR+Rnw4+HPvIeYNeRcGMRMXZ/p7yFa9Fq2d+Osq+Lf95ddcE3ZV/x5j1XfU8yHj0/eTIL
        t+CVq/lfe2qb3vFJTt70+dzMmpYbDYvd3+1KDnf7tXR50ivvLQfXXnl3q9Of+0370UXJZgI8
        +37pS7eq5VuVh5sEqGZuLcyO3Xz+VfPPmvW3Nz2N7Jot0nv3/bKlUbPurIvf/yy9dpfp9CcX
        I+5PljkwXVukrahfqHqa3PQXCqmfJlwTP2GYWdYlWHYirSV789OIzVf+vexY76HEUpyRaKjF
        XFScCACi730ApAIAAA==
X-CMS-MailID: 20230607115145epcas5p1d8a01f6fedf7b3522db1353d1a08e78f
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20230607115145epcas5p1d8a01f6fedf7b3522db1353d1a08e78f
References: <CGME20230607115145epcas5p1d8a01f6fedf7b3522db1353d1a08e78f@epcas5p1.samsung.com>
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
index 0000000..dc4f447
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
+DESCRIPTION="load/unload null_blk memory_backed=1 and run dd to check memleak"
+TIMED=1
+
+requires() {
+	_have_null_blk
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
+	mem=$(sed -n 's/^MemFree:[[:blank:]]*\([0-9]*\)[[:blank:]]*kB$/\1/p' \
+		/proc/meminfo)
+	echo "$mem"
+}
+
+test() {
+	echo "Running ${TEST_NAME}"
+
+	mem_leak=0
+	size=50
+	for ((i = 0; i < 5; i++)); do
+		mem_start=$(free_memory)
+		run_nullblk_dd $size
+		mem_end=$(free_memory)
+
+		mem_used=$((((mem_start - mem_end)) / 1024))
+		# -10MB to account for some randomness in freeing by some
+		# simultaneous process
+		if [ $mem_used -ge $((size - 10)) ]; then
+			mem_leak=$((mem_leak + 1))
+		fi
+	done
+
+	# There might be possibilty of some random process freeing up memory at
+	# same time nullblk is unloaded.
+	# we consider 3/5 times to be positive.
+	if [ $mem_leak -gt 3 ]; then
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


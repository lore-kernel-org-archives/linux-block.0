Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6CCDDECAAD2
	for <linux-block@archiver.kernel.org>; Fri,  2 Sep 2022 03:45:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233769AbiIBDpa (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 1 Sep 2022 23:45:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235356AbiIBDp1 (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 1 Sep 2022 23:45:27 -0400
Received: from esa1.hgst.iphmx.com (esa1.hgst.iphmx.com [68.232.141.245])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5F541EAD6
        for <linux-block@vger.kernel.org>; Thu,  1 Sep 2022 20:45:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1662090324; x=1693626324;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=RLRiQgEDMy2HV4ND1KbrWwYnIjENVIT1saTaZ5sA81U=;
  b=XLVssJDG8HaE/UegELjreXnIV29t6RHKHAVJjJqsYtgve/MHnd+pAXl1
   T2avarGlXdTXA5M3hAhbWZ/8nsifLl6FPcbgy13Nq2yo1KKb7omCSULOV
   3aMhRwZUCFnjO7Ir3/2llGPmJNrw4dEQINRG80MjM46pduUN2IlHRAVyZ
   j0KoNzkKNWqHriZ5eJvA8Dl/PUuwIKhS2Zo0UAmfWMfDq+6oW9AffqGnE
   Byszi7vnwfYAjlTs2IzMyhebwgx9Ym7iq/nA4+CIYcoie4hwtB6mVjvn/
   wksCm5tQM8teHfHirmukzh0xRWG3dN3rqH/jHDYatiKFFa5dmpFgSEcfm
   A==;
X-IronPort-AV: E=Sophos;i="5.93,281,1654531200"; 
   d="scan'208";a="322404168"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 02 Sep 2022 11:45:23 +0800
IronPort-SDR: RrxPFc9F19i2NGdZ4DCQyNAX0ZqqVpjkDU0XoVj8k0ODgZzWFsKFS9qdXFSgvHrstBimxLSUpQ
 Ttz0hlBMAl+tOiDi7F9y0S64SSlb4jQEiaOtTj7g6IeIyLMqvObUzZbXfssJcbbj7uxuYm5q/r
 Hf7WMlkf2Qwxt+h1xl3AHVnwEOjVgPeaaRAc5A80BojB+qEDeXW4IBW3n8HbgFdH+Dff4VtFC4
 xVfe+xuzkgRTKnGqys8UxV7Pk7YT4vHgj6/6ZN9RXF+drMhyC8yBLweIUtkCOEFuoC6A6oBieR
 Q+WVzX1lbct/LDBoCi7GNQHV
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 01 Sep 2022 20:05:51 -0700
IronPort-SDR: 7rPdPEpbF52LM+k19JdXfxw3W5JoHI69B0jlDSFzm7KdqxVQTqZkmYLA6cUDVDOMFLdux9T0vY
 SmMepXKOukRlcEuJrmSDRZp7MN08IXhw1aDiKNp8zOtCtRTaed5iHNOVIbzEU8NP6bKfBBTr+Z
 xIOaVkWQrNRl95Gp49VjGFCm7fd4Vq50S/Kst1nxwA+WHeVAp8MAjZYxqaHqFLlcAP4XZ6SdBD
 83G/YISnA0C2ov/iYEDI+/OeSaJ0Fr+/nOT2isZYxGomOZfsxlzYPO6dROJcK5C033LAAOz8+d
 5Mg=
WDCIronportException: Internal
Received: from shindev.dhcp.fujisawa.hgst.com (HELO shindev.fujisawa.hgst.com) ([10.149.52.207])
  by uls-op-cesaip02.wdc.com with ESMTP; 01 Sep 2022 20:45:22 -0700
From:   Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To:     linux-block@vger.kernel.org
Cc:     Christoph Hellwig <hch@lst.de>,
        Bart Van Assche <bvanassche@acm.org>,
        Sagi Grimberg <sagi@grimberg.me>,
        Chaitanya Kulkarni <kch@nvidia.com>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Subject: [PATCH blktests 4/5] check,common/rc: load module in _have_driver() and unload after test
Date:   Fri,  2 Sep 2022 12:45:15 +0900
Message-Id: <20220902034516.223173-5-shinichiro.kawasaki@wdc.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20220902034516.223173-1-shinichiro.kawasaki@wdc.com>
References: <20220902034516.223173-1-shinichiro.kawasaki@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

The commit 06a0ba866d90 ("common/rc: avoid module load in
_have_driver()") removed module load from _have_driver(). However, it
was pointed out no module load in _have_driver() is confusing and adds
complexity [1]. It requires explicit module loads and unloads in number
of test cases. The module unloads must be checked if unload is safe or
not. Also module load error must be handled. To avoid these complexity,
a new helper function would be required, but it will be look like the
_have_driver() with module load.

Then revert back the feature to load module in _have_driver(). To
address the issue that the commit 06a0ba866d90 tried to fix, record the
modules loaded by _have_driver() in MODULES_TO_UNLOAD array. Unload
the recorded modules after each test case processing completed. This
avoids the side-effect by the modules loaded by _have_driver().

[1] https://lore.kernel.org/linux-block/89aedf1d-ae08-adef-db29-17e5bf85d054@grimberg.me/

Fixes: 06a0ba866d90 ("common/rc: avoid module load in _have_driver()")
Signed-off-by: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
---
 check     | 13 +++++++++++++
 common/rc | 13 ++++++++++---
 2 files changed, 23 insertions(+), 3 deletions(-)

diff --git a/check b/check
index 5f57386..34e96c4 100755
--- a/check
+++ b/check
@@ -452,6 +452,16 @@ _unload_module() {
 	return 1
 }
 
+_unload_modules() {
+	local i
+
+	for ((i=${#MODULES_TO_UNLOAD[@]}; i > 0; i--)); do
+		_unload_module "${MODULES_TO_UNLOAD[i-1]}" 10
+	done
+
+	unset MODULES_TO_UNLOAD
+}
+
 _run_test() {
 	TEST_NAME="$1"
 	CAN_BE_ZONED=0
@@ -459,6 +469,7 @@ _run_test() {
 	DMESG_FILTER="cat"
 	RUN_FOR_ZONED=0
 	FALLBACK_DEVICE=0
+	MODULES_TO_UNLOAD=()
 
 	local ret=0
 
@@ -538,6 +549,8 @@ _run_test() {
 		fi
 	fi
 
+	_unload_modules
+
 	return $ret
 }
 
diff --git a/common/rc b/common/rc
index 9bc0dbc..a764b57 100644
--- a/common/rc
+++ b/common/rc
@@ -43,17 +43,24 @@ _module_file_exists()
 }
 
 # Check that the specified module or driver is available, regardless of whether
-# it is built-in or built separately as a module.
+# it is built-in or built separately as a module. Load the module if it is
+# loadable and not yet loaded. In this case, the loaded module is unloaded at
+# test case end regardless of whether the test case is skipped or executed.
 _have_driver()
 {
 	local modname="${1//-/_}"
 
-	if [ ! -d "/sys/module/${modname}" ] &&
-		   ! modprobe -qn "${modname}"; then
+	if [ -d "/sys/module/${modname}" ]; then
+		return 0
+	fi
+
+	if ! modprobe -q "${modname}"; then
 		SKIP_REASONS+=("driver ${modname} is not available")
 		return 1
 	fi
 
+	MODULES_TO_UNLOAD+=("${modname}")
+
 	return 0
 }
 
-- 
2.37.1


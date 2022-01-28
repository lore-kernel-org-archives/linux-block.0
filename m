Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9D61C433F5
	for <linux-block@archiver.kernel.org>; Fri, 28 Jan 2022 09:45:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238433AbiA1JpO (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 28 Jan 2022 04:45:14 -0500
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:21655 "EHLO
        esa4.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229745AbiA1JpO (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 28 Jan 2022 04:45:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1643363114; x=1674899114;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=7r8f6mQ4y3zh+LqBxZcVkxcFpv5O4PyoJTs130LMDEY=;
  b=ltTnUueMqhstNlR6VopffykbVACy444rQ9Pi1j6r/I+xjWZ6VaPmaMlK
   R5pCbI8fLXti23bPvcJbkJCVx5RI+2gX5BIbP4fzvRKySzQLbddGNPQMV
   OMpovzIrkd/WDq7kEFE7duNBjorbtgfwLQhlUSX3FdN8vtV+JBOgFmA0P
   PYWZ4S03v6eeem0Mg503nhf5mfSy8CUrJVYgxrN+2/07h9oofKLeAGBzY
   Hp92yKbDkknCGGfDzuSkUfk022OD6gbgJRlvYetoh5WuscQOt8i8TsoPe
   7JSZH18V5vvsQKD1wxgWg63uNGMFpaHLJyJSKzgnJOiOx2y0P4tktAnKK
   g==;
X-IronPort-AV: E=Sophos;i="5.88,323,1635177600"; 
   d="scan'208";a="190577148"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 28 Jan 2022 17:45:13 +0800
IronPort-SDR: tbgYJAOatDER1kuMbdtp2J2FA4KQ5BqWlzrhD3nU4w9I6qpXg5oVRgSUOym0itk0yjVKtPWynV
 jer1REezyyTopD02Wah38Y+/uizphNf+eY9Hhv1+ZnDF9C3Vrn3WiCxePvgFfSBBFJcKxbiGn7
 b2RTeyg+Coj2DMEk3Ho409mEGyDZ9lIKAOUQ9jJd8kZ0+aQlS9PULGcXyQPyze1EJrZeYNlTiC
 tMQ5M2dYP+oTs5pGekmBUzubc5AkJCTWOJIjNhWkkruhVPW0Kepv0fG6illDWidUNMcU/QwVuY
 GadITKAgI95Fn/nzo7+Agml+
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jan 2022 01:17:17 -0800
IronPort-SDR: qN//hC+xFKfP+XISZaAFcKIan+PKkLNLW52umrfO3qUejYzNq5rC8Sqg6w6/MNMXAfIEuoCdBB
 e6/56wjfZTy6kUHoQAZzEyd8r1r1/KgndHRpXlalM28s8GYHW8G0EkaBp/NBwD3/f1ZCTdDG4Y
 YdJXdQJHWqHRGM5xDH6lebSTuD+od/ZYRVE6G2XqIsyUnKBFUbR2k6qa+XpJ/GQVBdmDIt8qm2
 UuABPTIkxdq4hoS+mW07TFaLhJ43jg4X7BRAkEIho14WduQgYgK09IUKa2IWEKESk8KkjCATKk
 mvE=
WDCIronportException: Internal
Received: from shindev.dhcp.fujisawa.hgst.com (HELO shindev.fujisawa.hgst.com) ([10.149.52.173])
  by uls-op-cesaip01.wdc.com with ESMTP; 28 Jan 2022 01:45:13 -0800
From:   Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To:     linux-block@vger.kernel.org, Omar Sandoval <osandov@osandov.com>
Cc:     Omar Sandoval <osandov@fb.com>,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Subject: [PATCH blktests] block/008: check CPU offline failure due to many IRQs
Date:   Fri, 28 Jan 2022 18:45:12 +0900
Message-Id: <20220128094512.24508-1-shinichiro.kawasaki@wdc.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

When systems have more IRQs than a single CPU can handle, the test case
block/008 fails with kernel message such as,

   "CPU 31 has 111 vectors, 90 available. Cannot disable CPU"

The failure cause is that the test case offlined too many CPUs and the
left online CPU can not hold all of the required IRQ vectors. To avoid
this failure, check error message of CPU offline. If CPU offline failure
cause is IRQ vector resource shortage, do not handle it as a failure.
Also keep the actual number of CPUs which can be offlined without the
failure and use this number for the test.

Signed-off-by: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
---
 tests/block/008 | 23 ++++++++++++++++++-----
 1 file changed, 18 insertions(+), 5 deletions(-)

diff --git a/tests/block/008 b/tests/block/008
index 7445f8f..75aae65 100755
--- a/tests/block/008
+++ b/tests/block/008
@@ -60,17 +60,30 @@ test_device() {
 
 		if (( offlining )); then
 			idx=$((RANDOM % ${#online_cpus[@]}))
-			_offline_cpu "${online_cpus[$idx]}"
-			offline_cpus+=("${online_cpus[$idx]}")
-			unset "online_cpus[$idx]"
-			online_cpus=("${online_cpus[@]}")
-		else
+			if err=$(_offline_cpu "${online_cpus[$idx]}" 2>&1); then
+				offline_cpus+=("${online_cpus[$idx]}")
+				unset "online_cpus[$idx]"
+				online_cpus=("${online_cpus[@]}")
+			elif [[ $err =~ "No space left on device" ]]; then
+				# ENOSPC means CPU offline failure due to IRQ
+				# vector shortage. Keep current number of
+				# offline CPUs as maximum CPUs to offline.
+				max_offline=${#offline_cpus[@]}
+				offlining=0
+			else
+				echo "Failed to offline CPU: $err"
+				break
+			fi
+		fi
+
+		if (( !offlining )); then
 			idx=$((RANDOM % ${#offline_cpus[@]}))
 			_online_cpu "${offline_cpus[$idx]}"
 			online_cpus+=("${offline_cpus[$idx]}")
 			unset "offline_cpus[$idx]"
 			offline_cpus=("${offline_cpus[@]}")
 		fi
+
 		end_time=$(date +%s)
 		if (( end_time - start_time > timeout + 15 )); then
 			echo "fio did not finish after $timeout seconds!"
-- 
2.34.1


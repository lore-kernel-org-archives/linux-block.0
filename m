Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0FEC0C433EF
	for <linux-block@archiver.kernel.org>; Mon,  4 Jul 2022 11:16:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232685AbiGDLQm (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 4 Jul 2022 07:16:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231339AbiGDLQl (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Mon, 4 Jul 2022 07:16:41 -0400
Received: from esa2.hgst.iphmx.com (esa2.hgst.iphmx.com [68.232.143.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95884F58B
        for <linux-block@vger.kernel.org>; Mon,  4 Jul 2022 04:16:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1656933400; x=1688469400;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=VNgkiwqgLCvv/IcVNjUwL9tCzsdUDTAp6zVIJjdA3x8=;
  b=RTBcXcqFQwEK9708sus/ob/Yd5i8MkowexOPKN8aKBhNYigQj7KZzfqa
   bPHPb+VNIQx2uA8vIMFbtm2YsO+FvsCCv+nuAvc3BLoRT4uzlp/849XtC
   x1AHn56oMjt7CjGns20CXLTy6tBDvbI1LIftQrhkw+zt5jIO9LlZJ6aV2
   DmUNLbEQ4F8nD6qQAyzUPuLOvX/Vy57W8LDo9YTARQg48GLLcK6uWOf73
   3HpBsetbIxnm9y5RPxDQ9/dHiZcofZFtoHCWt4T29BPdZW/HoIcYmezw6
   hsvi9prgci1izcEaKcxUVIf67zrwYZMWro6AoSZrUT85Mga3m06PUj0bA
   A==;
X-IronPort-AV: E=Sophos;i="5.92,243,1650902400"; 
   d="scan'208";a="309082963"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 04 Jul 2022 19:16:39 +0800
IronPort-SDR: hZv4PaBGSPD8erm0gjM5A2Vd6b9xRPR8GUtApPJo7yBP/N4YpXJ/OxMQRQUPNSmNjAmb1hU3Sb
 veEf8AOw881JnExkaOXD885Wyqbz8UEDwy9Bi3bwdsAwUaUBum096DyWvotPLu96Z+bSM77qKO
 qSFpNopPqyEB7C/ap4sh/J16vAJT8mVZKr3abSQcAwrp4SkLAG+L/LsYQKkQDDdM+LBqRBWgTD
 NaGHxR/Uq47FZHVgGiVlK3gdgHrTP0PddcOYmCCkab8taS7JmejSzaDsK8mrTNBp/D72cXxvaO
 BwD/7/42M8r6bKCRGvnegx80
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 04 Jul 2022 03:34:00 -0700
IronPort-SDR: xVD9bUCyWOGaeAr8znywC4ggPFnyrKTrMeWhsBrO4VQfjlynzFSXRbn4WAOXNJapGaHlpgfkFe
 atv1TNQhoG4auAA++JbnWd1J6o8tNWNu8O5rYiYAsIMFQjn08AE1tfqIEnmEwCetGZ0ExLBiFW
 yUYoUP1aoaQ5bKsr6+EhQVAUDgAWAlKLZvfY9zwqrwsZqDPU+XUnxHVDMK1/mJ3Lw2dPfR4qlm
 rVDBTspJ3XZqldbbj7iQfmxofF5/WdMO557ETrYtPE1N3QIF9QWSfpR0LB5FijwVawbiTnch6b
 CtI=
WDCIronportException: Internal
Received: from shindev.dhcp.fujisawa.hgst.com (HELO shindev.fujisawa.hgst.com) ([10.149.52.207])
  by uls-op-cesaip01.wdc.com with ESMTP; 04 Jul 2022 04:16:39 -0700
From:   Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To:     linux-block@vger.kernel.org
Cc:     Yi Zhang <yi.zhang@redhat.com>,
        Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Subject: [PATCH blktests] block/008: avoid _offline_cpu() call in sub-shell
Date:   Mon,  4 Jul 2022 20:16:38 +0900
Message-Id: <20220704111638.1109883-1-shinichiro.kawasaki@wdc.com>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

The helper function _offline_cpu() sets a value to RESTORE_CPUS_ONLINE.
However, the commit bd6b882b2650 ("block/008: check CPU offline failure
due to many IRQs") put _offline_cpu() call in sub-shell, then the set
value to RESTORE_CPUS_ONLINE no longer affects function caller's
environment. This resulted in offlined CPUs not restored by _cleanup()
when the test case block/008 calls only _offline_cpu() and does not call
_online_cpu().

To fix the issue, avoid _offline_cpu() call in sub-shell. Use file
redirect to get output of _offline_cpu() instead of sub-shell execution.

Fixes: bd6b882b2650 ("block/008: check CPU offline failure due to many IRQs")
Reported-by: Yi Zhang <yi.zhang@redhat.com>
Tested-by: Yi Zhang <yi.zhang@redhat.com>
Link: https://lore.kernel.org/linux-block/20220703180956.2922025-1-yi.zhang@redhat.com/
Signed-off-by: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
---
 tests/block/008 | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/tests/block/008 b/tests/block/008
index 75aae65..cd09352 100755
--- a/tests/block/008
+++ b/tests/block/008
@@ -34,6 +34,7 @@ test_device() {
 	local offline_cpus=()
 	local offlining=1
 	local max_offline=${#HOTPLUGGABLE_CPUS[@]}
+	local o=$TMPDIR/offline_cpu_out
 	if [[ ${#HOTPLUGGABLE_CPUS[@]} -eq ${#ALL_CPUS[@]} ]]; then
 		(( max_offline-- ))
 	fi
@@ -60,18 +61,18 @@ test_device() {
 
 		if (( offlining )); then
 			idx=$((RANDOM % ${#online_cpus[@]}))
-			if err=$(_offline_cpu "${online_cpus[$idx]}" 2>&1); then
+			if _offline_cpu "${online_cpus[$idx]}" > "$o" 2>&1; then
 				offline_cpus+=("${online_cpus[$idx]}")
 				unset "online_cpus[$idx]"
 				online_cpus=("${online_cpus[@]}")
-			elif [[ $err =~ "No space left on device" ]]; then
+			elif [[ $(<"$o") =~ "No space left on device" ]]; then
 				# ENOSPC means CPU offline failure due to IRQ
 				# vector shortage. Keep current number of
 				# offline CPUs as maximum CPUs to offline.
 				max_offline=${#offline_cpus[@]}
 				offlining=0
 			else
-				echo "Failed to offline CPU: $err"
+				echo "Failed to offline CPU: $(<"$o")"
 				break
 			fi
 		fi
-- 
2.36.1


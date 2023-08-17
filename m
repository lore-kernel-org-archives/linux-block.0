Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A3A6C41513
	for <linux-block@archiver.kernel.org>; Thu, 17 Aug 2023 07:31:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348424AbjHQHa3 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 17 Aug 2023 03:30:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348467AbjHQHa2 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 17 Aug 2023 03:30:28 -0400
Received: from esa1.hgst.iphmx.com (esa1.hgst.iphmx.com [68.232.141.245])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 015CF1FCE
        for <linux-block@vger.kernel.org>; Thu, 17 Aug 2023 00:30:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1692257424; x=1723793424;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=UUWnka0lvWrfZ4NWtFcx8XJGzhEQIbMjxWq1Vz1NalM=;
  b=Kf/lXpYNgZONb4hQq2koNh68ZLgfBLx34X7XC60fXA6yeH6SVvTKVsgn
   aA/Srmgd+knf5Wsk0kNocrtrSnON7m9zCrcehAcLdG//eBkZV62ljo/bt
   L3ugqt/WpKnikD4FBcYARH13muSz1GzoL/cfvEWHQ7uPIZ4Gq/Q2wFNEB
   gXmknMdoZChbwHQrV3hY81R6+cnLVwIHiy7oCI4KECGPvPBLY9n/9Xwip
   OUPBeigP1m5VaiLiac1LVux6DNbZVHEJ381u5CGCgUcm3YKE6Evws98JO
   meOH+neN5/pKSsesvRW4/97Z8/0YnDq8pSQWTDXp8Z+dBE/gBCc6ycaDO
   g==;
X-IronPort-AV: E=Sophos;i="6.01,179,1684771200"; 
   d="scan'208";a="353323165"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 17 Aug 2023 15:30:24 +0800
IronPort-SDR: 7ErwrZ3dp+8GW5FJyj7828dmNR/dfSeKFmuL1DdZXG9+x5OYZKOUz4hzYIQ4z68MdyRhc/Wg5U
 lz1dw3N4OWpmoxPGacs/iWMyAiNhAD/Olr/XVF9CCtaSynC4snE2TjDzu0x6PSupqZbu0F8C/6
 V/QL6FpInFjiUkCN7svwbZ3Q07B6XvsX79ZtqHjaAbmYTZsl+L2+gHAKrW0q/C39K7kUONu1/M
 3g/jOZYRKG6XVMPs/O8UUPQpk46nheSQEfrgxgl49Si8lHlxkdyvA73Rlh7sS5OwRtjh6n2Wyx
 v/s=
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 16 Aug 2023 23:38:01 -0700
IronPort-SDR: 8LjGFSSJVg+jApn3yw0OMSkd9bVshYGe6Bu5zGrlSFZELSAdq8SilxFMx6AK0BPuVRVcZtnoJb
 unTVjMuZTsoP9EJlvwi3a5xGvZE7GO3Sf17VnNLzZkOF7h8f0n69pzY1OOuvmkTMzJNaPlVDn4
 +vPK5Fa19SC6KSDWrXYPsQwYjH/8Hp4OjnKKf3ub6ZTtByGPOjIxuLh3b6KLHxAkye+BEvRsVu
 PxPa4ax9BMlX+MMwwEAT4AKLfWKzam4vOB+uUR2M1hBR6C9hYgAzSFWnUe3KScvBgtEpFTQxSv
 gCo=
WDCIronportException: Internal
Received: from shindev.dhcp.fujisawa.hgst.com (HELO shindev.fujisawa.hgst.com) ([10.149.53.55])
  by uls-op-cesaip01.wdc.com with ESMTP; 17 Aug 2023 00:30:23 -0700
From:   Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To:     linux-block@vger.kernel.org, linux-nvme@lists.infradead.org
Cc:     Yi Zhang <yi.zhang@redhat.com>, Daniel Wagner <dwagner@suse.de>,
        Sagi Grimberg <sagi@grimberg.me>,
        Bart Van Assche <bvanassche@acm.org>,
        Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Subject: [PATCH blktests v2 2/2] nvme: remove "udevadm settle" after _nvme_connect_subsys
Date:   Thu, 17 Aug 2023 16:30:21 +0900
Message-Id: <20230817073021.3674602-2-shinichiro.kawasaki@wdc.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230817073021.3674602-1-shinichiro.kawasaki@wdc.com>
References: <20230817073021.3674602-1-shinichiro.kawasaki@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

The previous commit introduced "udevadm settle" command at the end of
_nvme_connect_subsys. Then the command is no longer required after
calling _nvme_connect_subsys in test cases.

Signed-off-by: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
---
 tests/nvme/005 | 2 --
 tests/nvme/008 | 2 --
 tests/nvme/009 | 2 --
 tests/nvme/040 | 1 -
 tests/nvme/041 | 2 --
 tests/nvme/042 | 3 ---
 tests/nvme/043 | 4 ----
 tests/nvme/044 | 8 --------
 tests/nvme/045 | 2 --
 9 files changed, 26 deletions(-)

diff --git a/tests/nvme/005 b/tests/nvme/005
index 6646b82..4ca87ff 100755
--- a/tests/nvme/005
+++ b/tests/nvme/005
@@ -40,8 +40,6 @@ test() {
 
 	nvmedev=$(_find_nvme_dev "${def_subsysnqn}")
 
-	udevadm settle
-
 	echo 1 > "/sys/class/nvme/${nvmedev}/reset_controller"
 
 	_nvme_disconnect_ctrl "${nvmedev}"
diff --git a/tests/nvme/008 b/tests/nvme/008
index 3921fc6..bd5e10f 100755
--- a/tests/nvme/008
+++ b/tests/nvme/008
@@ -40,8 +40,6 @@ test() {
 	cat "/sys/block/${nvmedev}n1/uuid"
 	cat "/sys/block/${nvmedev}n1/wwid"
 
-	udevadm settle
-
 	_nvme_disconnect_subsys "${def_subsysnqn}"
 
 	_remove_nvmet_subsystem_from_port "${port}" "${def_subsysnqn}"
diff --git a/tests/nvme/009 b/tests/nvme/009
index aac3c1e..c9a4b57 100755
--- a/tests/nvme/009
+++ b/tests/nvme/009
@@ -36,8 +36,6 @@ test() {
 	cat "/sys/block/${nvmedev}n1/uuid"
 	cat "/sys/block/${nvmedev}n1/wwid"
 
-	udevadm settle
-
 	_nvme_disconnect_subsys "${def_subsysnqn}"
 
 	_remove_nvmet_subsystem_from_port "${port}" "${def_subsysnqn}"
diff --git a/tests/nvme/040 b/tests/nvme/040
index 1a9be5c..ed6df3b 100755
--- a/tests/nvme/040
+++ b/tests/nvme/040
@@ -35,7 +35,6 @@ test() {
 	_create_nvmet_host "${def_subsysnqn}" "${def_hostnqn}"
 
 	_nvme_connect_subsys "${nvme_trtype}" "${def_subsysnqn}"
-	udevadm settle
 	nvmedev=$(_find_nvme_dev "${def_subsysnqn}")
 
 	# start fio job
diff --git a/tests/nvme/041 b/tests/nvme/041
index cb27666..bc84412 100755
--- a/tests/nvme/041
+++ b/tests/nvme/041
@@ -57,8 +57,6 @@ test() {
 			     --hostid "${def_hostid}" \
 			     --dhchap-secret "${hostkey}"
 
-	udevadm settle
-
 	_nvme_disconnect_subsys "${def_subsysnqn}"
 
 	_remove_nvmet_subsystem_from_port "${port}" "${def_subsysnqn}"
diff --git a/tests/nvme/042 b/tests/nvme/042
index 9180fce..47e1b95 100755
--- a/tests/nvme/042
+++ b/tests/nvme/042
@@ -50,7 +50,6 @@ test() {
 				     --hostnqn "${def_hostnqn}" \
 				     --hostid "${def_hostid}" \
 				     --dhchap-secret "${hostkey}"
-		udevadm settle
 
 		_nvme_disconnect_subsys "${def_subsysnqn}"
 	done
@@ -69,8 +68,6 @@ test() {
 				     --hostid "${def_hostid}" \
 				     --dhchap-secret "${hostkey}"
 
-		udevadm settle
-
 		_nvme_disconnect_subsys "${def_subsysnqn}"
 	done
 
diff --git a/tests/nvme/043 b/tests/nvme/043
index f084229..15676f8 100755
--- a/tests/nvme/043
+++ b/tests/nvme/043
@@ -55,8 +55,6 @@ test() {
 				     --hostid "${def_hostid}" \
 				     --dhchap-secret "${hostkey}"
 
-		udevadm settle
-
 		_nvme_disconnect_subsys "${def_subsysnqn}"
 	done
 
@@ -71,8 +69,6 @@ test() {
 				      --hostid "${def_hostid}" \
 				      --dhchap-secret "${hostkey}"
 
-		udevadm settle
-
 		_nvme_disconnect_subsys "${def_subsysnqn}"
 	done
 
diff --git a/tests/nvme/044 b/tests/nvme/044
index 5eb163d..9407ac6 100755
--- a/tests/nvme/044
+++ b/tests/nvme/044
@@ -59,8 +59,6 @@ test() {
 			     --hostid "${def_hostid}" \
 			     --dhchap-secret "${hostkey}"
 
-	udevadm settle
-
 	_nvme_disconnect_subsys "${def_subsysnqn}"
 
 	# Step 2: Connect with host authentication
@@ -72,8 +70,6 @@ test() {
 			     --dhchap-secret "${hostkey}" \
 			     --dhchap-ctrl-secret "${hostkey}"
 
-	udevadm settle
-
 	_nvme_disconnect_subsys "${def_subsysnqn}"
 
 	# Step 3: Connect with host authentication
@@ -85,8 +81,6 @@ test() {
 			     --dhchap-secret "${hostkey}" \
 			     --dhchap-ctrl-secret "${ctrlkey}"
 
-	udevadm settle
-
 	_nvme_disconnect_subsys "${def_subsysnqn}"
 
 	# Step 4: Connect with host authentication
@@ -99,8 +93,6 @@ test() {
 			     --dhchap-secret "${hostkey}" \
 			     --dhchap-ctrl-secret "${invkey}"
 
-	udevadm settle
-
 	_nvme_disconnect_subsys "${def_subsysnqn}"
 
 	_remove_nvmet_subsystem_from_port "${port}" "${def_subsysnqn}"
diff --git a/tests/nvme/045 b/tests/nvme/045
index 8364d5e..396bcde 100755
--- a/tests/nvme/045
+++ b/tests/nvme/045
@@ -61,8 +61,6 @@ test() {
 			     --dhchap-secret "${hostkey}" \
 			     --dhchap-ctrl-secret "${ctrlkey}"
 
-	udevadm settle
-
 	echo "Re-authenticate with original host key"
 
 	ctrldev=$(_find_nvme_dev "${def_subsysnqn}")
-- 
2.40.1


Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8AFF3C71136
	for <linux-block@archiver.kernel.org>; Fri, 18 Aug 2023 04:41:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357859AbjHRElV (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 18 Aug 2023 00:41:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1357910AbjHRElF (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 18 Aug 2023 00:41:05 -0400
Received: from esa1.hgst.iphmx.com (esa1.hgst.iphmx.com [68.232.141.245])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65D263C0F
        for <linux-block@vger.kernel.org>; Thu, 17 Aug 2023 21:41:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1692333660; x=1723869660;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=LyNRwf8ssMynfsyFtHTj7f6WyJDWVTzXFNCD6YowvTE=;
  b=RqUVUJQHk6CkRH8KhORUW2sgCC3gTns442Ck4G+9/yY1Q+zbHm6DA2Dw
   JOCvV56lNccVI7ZQZi8nKmB0yBg6uST1wMyL7izWSxBTYMXD5wDaKt3PR
   kOGAaFDx2PYjYxEs8bWC/m5YQSnTufPK3Jz7PuDuBBpKtA3pwklhyyQnd
   zbN/wXBu5U0YqzLMIgk7zb5v5FoSXv7KqEE9+8an0ae9hJB2tVvroPR2F
   2/ukCiX7/JqJuKN7vujhfm7gzh0AvzaVRrPsBNqnTJm+6CAOZ3N43H8pk
   O38XJKwWJaaG4npcVaePY1FK/cKkswCBsKDwzhw0DkLg6jHxQ8MjZhQIE
   g==;
X-IronPort-AV: E=Sophos;i="6.01,182,1684771200"; 
   d="scan'208";a="353431501"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 18 Aug 2023 12:41:00 +0800
IronPort-SDR: 8Z2MN+svzMU/lZc5CnGe3cnh5mnR+lCbsulpsHY5EYpmvFNauPn2EEaLZGnzq69RJrKl56/fH5
 irr+za+uvhKpWr9BFGhVrxB3mK2HlyK7jMAa4AA246IdAcgBlGigKgAqMyEcdLHmV3PuLADtrb
 mq4pozrYkBNT6mAZVEZKyPBSHHrooK2jwuaiv/9LHauw5b/Fxd51p3BefjKhWdN7M6ZO3u4J2r
 CbawSFc4H1EVKjLWNDtl1tGJvjmVq/OcSNXEg8TKV0lkDyp8Vc2eSWGTr5cCS2GSuDWmvk8+b6
 R0U=
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 17 Aug 2023 20:54:16 -0700
IronPort-SDR: ctxTS/nXU+6yvVnIZOsyLhN+sMXQP9TPdxjTp6pRZjvraxfTgQZGoNgnF2MfHXQZ8fq5qt7NiO
 UE71mxIFB5Zpb92qKbPYOf5PuD6lm5M4PIQOj0rnYQNEHwJxK7e7/zsD5DS7HGY8jmZsUK25/J
 eg9XtRL2FZOAIofscuv/4+tvNYFrDOuTva3b565H5xvPgWQIlxueOEhwJqeBXewZ2ZNy6ozKTx
 ROOGKHJvlyGm3mQF+VdQBhSqOtCSzkYthO2EhrzvBXAOdE9TJ/OsiptK4Lj2J+TWdMtyuM4yyk
 l3Y=
WDCIronportException: Internal
Received: from shindev.dhcp.fujisawa.hgst.com (HELO shindev.fujisawa.hgst.com) ([10.149.53.55])
  by uls-op-cesaip02.wdc.com with ESMTP; 17 Aug 2023 21:40:59 -0700
From:   Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To:     linux-block@vger.kernel.org, linux-nvme@lists.infradead.org
Cc:     Yi Zhang <yi.zhang@redhat.com>, Daniel Wagner <dwagner@suse.de>,
        Sagi Grimberg <sagi@grimberg.me>,
        Bart Van Assche <bvanassche@acm.org>,
        Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Subject: [PATCH blktests v3 2/2] nvme: remove "udevadm settle" after _nvme_connect_subsys
Date:   Fri, 18 Aug 2023 13:40:57 +0900
Message-Id: <20230818044057.3794564-2-shinichiro.kawasaki@wdc.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230818044057.3794564-1-shinichiro.kawasaki@wdc.com>
References: <20230818044057.3794564-1-shinichiro.kawasaki@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

The previous commit introduced "udevadm settle" command at the end of
_nvme_connect_subsys. Then the command is no longer required after
calling _nvme_connect_subsys in test cases.

Reviewed-by: Daniel Wagner <dwagner@suse.de>
Signed-off-by: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
---
Changes from v2:
* Added Reviewed-by tag

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


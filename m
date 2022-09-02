Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A240C6FA81
	for <linux-block@archiver.kernel.org>; Fri,  2 Sep 2022 03:45:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232014AbiIBDp2 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 1 Sep 2022 23:45:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235324AbiIBDpY (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 1 Sep 2022 23:45:24 -0400
Received: from esa1.hgst.iphmx.com (esa1.hgst.iphmx.com [68.232.141.245])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D16921E2E
        for <linux-block@vger.kernel.org>; Thu,  1 Sep 2022 20:45:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1662090322; x=1693626322;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=KfkrzAmmWHHAh0R5vMDd/q87eehsr4Uhga/alYF3tuU=;
  b=aMopikGLzkb2l+eUOjgWySK4/tX/3CsTz+cVbS8JJtvKENA19SLXUcyq
   GiHCuzlgc4hH+g6ZvER3ksv4IduC3DSoiYAPSC2DZPKFqGCtV2HoBuWuG
   Q3MKT5SyLLGo11PQYbxqYXXSJOiuuzi6K+oFQs5LAKZCodrf/l+cfc2zc
   FB8MRkMTGqiCE6iubnUk63eZcWXR00Ere6uJ0trIkOIjS193p0Hqc/0uZ
   AeXFoUrp5/wDrI47M+K9Y8o+hGO2kZU1Y97os3RVkY81joXzq0OPOTLXA
   ZMwqLAoWPM7DjgFE+D0cbPVes5ycd1eqYZ3Q4cO1THcAEAGFZr7K/7tC+
   Q==;
X-IronPort-AV: E=Sophos;i="5.93,281,1654531200"; 
   d="scan'208";a="322404163"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 02 Sep 2022 11:45:20 +0800
IronPort-SDR: AKAIpoGdrzOz9rCu2SNXVDrmo+X73r+5tE6OEP3YWWckLUsunTGeu+deBN+ckt8regF5AcaNEp
 wviQWIe6sVK6Dq2jf5KLeqN2MSNluOLxNlonpqFnRyi9FDsR8ufO0NLnOTvr7YEnE5biAYNZal
 PvSblSJqZ+1ZLhABOEN1VQDX3VE2hkjmYcqzEEvrBUZqCYQmQnVaA2nDnG9LeW8RSs4lhquwV+
 8MOO21sB7Ui14pcXHo7wBfnyDIMBYlD1nwoOhDrjuTPKMR4MsOgID0nyzk1M4+3/cMH6044cwB
 SF9xevsJYWh0Wb0FjsxnAHfV
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 01 Sep 2022 20:05:49 -0700
IronPort-SDR: hJwvAZOsgKXqTQon1pv88bjPHwaONozkq8LTZgLtIC3t95r5aUbJ1ZYEE9O4AuIn3u7Nq/PGMA
 zUW/d5aO9drcQLs26GgkUy0kB1T0IHNb9JbLhIoUffFl1DLRO0VaF9u3cCQX4aoXPp8Vhy4dxN
 z20geQTmrttRhs6F4LzI8r+nakRAYMoAL4QFgu/L/+62pRXlTB8BdwvdAWlJv+dUIKerMZCTEP
 xJPsYujy3abQRUxCNRZnFKkfZZvFO/tPIpQvdFPiKUPhfUdtHTqbUIgvRey/E/MCn0qs0/SYmn
 OwE=
WDCIronportException: Internal
Received: from shindev.dhcp.fujisawa.hgst.com (HELO shindev.fujisawa.hgst.com) ([10.149.52.207])
  by uls-op-cesaip02.wdc.com with ESMTP; 01 Sep 2022 20:45:20 -0700
From:   Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To:     linux-block@vger.kernel.org
Cc:     Christoph Hellwig <hch@lst.de>,
        Bart Van Assche <bvanassche@acm.org>,
        Sagi Grimberg <sagi@grimberg.me>,
        Chaitanya Kulkarni <kch@nvidia.com>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Subject: [PATCH blktests 2/5] common,tests: rename unload_module() to _unload_module()
Date:   Fri,  2 Sep 2022 12:45:13 +0900
Message-Id: <20220902034516.223173-3-shinichiro.kawasaki@wdc.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20220902034516.223173-1-shinichiro.kawasaki@wdc.com>
References: <20220902034516.223173-1-shinichiro.kawasaki@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

All helper functions in common/rc have underscore prefix except
unload_module(). Add the prefix to it.

Signed-off-by: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
---
 common/multipath-over-rdma |  4 ++--
 common/rc                  |  2 +-
 tests/nvmeof-mp/rc         | 12 ++++++------
 tests/srp/rc               |  8 ++++----
 4 files changed, 13 insertions(+), 13 deletions(-)

diff --git a/common/multipath-over-rdma b/common/multipath-over-rdma
index c1c2e7c..fb820d6 100644
--- a/common/multipath-over-rdma
+++ b/common/multipath-over-rdma
@@ -428,11 +428,11 @@ stop_soft_rdma() {
 		      echo "$i ..."
 		      rdma link del "${i}" || echo "Failed to remove ${i}"
 		done
-	if ! unload_module rdma_rxe 10; then
+	if ! _unload_module rdma_rxe 10; then
 		echo "Unloading rdma_rxe failed"
 		return 1
 	fi
-	if ! unload_module siw 10; then
+	if ! _unload_module siw 10; then
 		echo "Unloading siw failed"
 		return 1
 	fi
diff --git a/common/rc b/common/rc
index be69a4d..738a32f 100644
--- a/common/rc
+++ b/common/rc
@@ -385,7 +385,7 @@ _uptime_s() {
 }
 
 # Arguments: module to unload ($1) and retry count ($2).
-unload_module() {
+_unload_module() {
 	local i m=$1 rc=${2:-1}
 
 	[ ! -e "/sys/module/$m" ] && return 0
diff --git a/tests/nvmeof-mp/rc b/tests/nvmeof-mp/rc
index ed27b5c..4238a4c 100755
--- a/tests/nvmeof-mp/rc
+++ b/tests/nvmeof-mp/rc
@@ -162,12 +162,12 @@ start_nvme_client() {
 }
 
 stop_nvme_client() {
-	unload_module nvme-rdma || return $?
-	unload_module nvme-fabrics || return $?
+	_unload_module nvme-rdma || return $?
+	_unload_module nvme-fabrics || return $?
 	# Ignore nvme and nvme-core unload errors - this test may be run on a
 	# system equipped with one or more NVMe SSDs.
-	unload_module nvme >&/dev/null
-	unload_module nvme-core >&/dev/null
+	_unload_module nvme >&/dev/null
+	_unload_module nvme-core >&/dev/null
 	return 0
 }
 
@@ -267,8 +267,8 @@ stop_nvme_target() {
 				rmdir "$d"
 			done
 	)
-	unload_module nvmet_rdma &&
-		unload_module nvmet &&
+	_unload_module nvmet_rdma &&
+		_unload_module nvmet &&
 		_exit_null_blk
 }
 
diff --git a/tests/srp/rc b/tests/srp/rc
index 23f87e4..55b535a 100755
--- a/tests/srp/rc
+++ b/tests/srp/rc
@@ -325,14 +325,14 @@ stop_srp_ini() {
 	log_out
 	for ((i=40;i>=0;i--)); do
 		remove_mpath_devs || return $?
-		unload_module ib_srp >/dev/null 2>&1 && break
+		_unload_module ib_srp >/dev/null 2>&1 && break
 		sleep 1
 	done
 	if [ -e /sys/module/ib_srp ]; then
 		echo "Error: unloading kernel module ib_srp failed"
 		return 1
 	fi
-	unload_module scsi_transport_srp || return $?
+	_unload_module scsi_transport_srp || return $?
 }
 
 # Associate the LIO device with name $1/$2 with file $3 and SCSI serial $4.
@@ -491,7 +491,7 @@ start_lio_srpt() {
 	if modinfo ib_srpt | grep -q '^parm:[[:blank:]]*rdma_cm_port:'; then
 		opts+=("rdma_cm_port=${srp_rdma_cm_port}")
 	fi
-	unload_module ib_srpt
+	_unload_module ib_srpt
 	modprobe ib_srpt "${opts[@]}" || return $?
 	i=0
 	for r in "${vdev_path[@]}"; do
@@ -553,7 +553,7 @@ stop_lio_srpt() {
 			 target_core_file target_core_stgt target_core_user \
 			 target_core_mod
 	do
-		unload_module $m 10 || return $?
+		_unload_module $m 10 || return $?
 	done
 }
 
-- 
2.37.1


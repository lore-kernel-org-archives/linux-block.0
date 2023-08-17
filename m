Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52E30C2FC0E
	for <linux-block@archiver.kernel.org>; Thu, 17 Aug 2023 07:31:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344134AbjHQHa3 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 17 Aug 2023 03:30:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348466AbjHQHa2 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 17 Aug 2023 03:30:28 -0400
Received: from esa1.hgst.iphmx.com (esa1.hgst.iphmx.com [68.232.141.245])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F07241FC8
        for <linux-block@vger.kernel.org>; Thu, 17 Aug 2023 00:30:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1692257423; x=1723793423;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=kWnODAqt0Mw2BZKaBie2yj1ClUJdr2nuftoERPO8Oi4=;
  b=V0in4o9215LSn7AOCSvjgJAcnGloPNQD6gH5+HeXec8rry1AONHN38jn
   IS/5DyP05UDspRTNyInOC3RGm0eEDfaw8LkAN1Inj4Z//Fz/+VBwwLBey
   RwxTrKYG1u3euFz8ytjl4aptHQkOqUrtW2qNXKIPqjXF6+YRSgR4289Rh
   OcEki8bKfW1meeqixcBqi94ymxJTtUkxRuX4WmoBzOlVhwv1UmaLnmko8
   TZJgPaiPJG55mXpixxNMdQ/WgLj65kRL0oKC4vrZCsnMX2Hi3JlvjPe5P
   zEGvxBDvk4hUVQ+wNaFihcF9ubK4EvTHdk9Bd/F4XpULKIDw8vo2meJaz
   Q==;
X-IronPort-AV: E=Sophos;i="6.01,179,1684771200"; 
   d="scan'208";a="353323160"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 17 Aug 2023 15:30:23 +0800
IronPort-SDR: CsRLVQE9ihaZRJfvWx/thg6c6QdW7ENDsVbm9n3pRUV3UfBgZbUOk4WnzLrW8KvYfwHxgxykZV
 7vz/wr2Q1zlBRJev0CVewbge+HTSLW9oip3s0pIjn9cKI93rjbzeaT+4zOn/BTVMua7MtW1pU+
 7N2u+tzylOeBKRyjXENKz/109id+GBUSqDVLoCr7HDOyXEuAoxsraJSCqc2NsUb86gkFv9bx+3
 SwrZHcEcDvHHDnCeCKPv0C50Eg/WshqP/DIThFOnhaNiVgtkW6YebN5TL4vRvpwlq5HA/LhJz1
 5Bg=
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 16 Aug 2023 23:37:59 -0700
IronPort-SDR: LAr0+QMRHuwnWLVYg6EaJ+VLplf4pxXvEatSUgI4U3v9CFhhYDtJ3Nn//+eb8hsbFgBimh1EzD
 7DxhSAi9se9Q6P9OB3zB/Coc2TdNflkJAAz2moDjTScg1dId40qB92ekl/7OQkdtbXDswp6FXU
 WiEZR5FzrEfR/aL1IctiboqG+ApjcU4eDKaj3AvDlRQun2Os/4vxM8TthoiyMNNhCCL/f3nSgT
 JkACwd9+Edof+HCK1FEIyXSkgGIT2zbu4VrOdVjtqoxis6TSUPnNrLFaaJM3TJHRxOUMDDUalx
 61E=
WDCIronportException: Internal
Received: from shindev.dhcp.fujisawa.hgst.com (HELO shindev.fujisawa.hgst.com) ([10.149.53.55])
  by uls-op-cesaip01.wdc.com with ESMTP; 17 Aug 2023 00:30:22 -0700
From:   Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To:     linux-block@vger.kernel.org, linux-nvme@lists.infradead.org
Cc:     Yi Zhang <yi.zhang@redhat.com>, Daniel Wagner <dwagner@suse.de>,
        Sagi Grimberg <sagi@grimberg.me>,
        Bart Van Assche <bvanassche@acm.org>,
        Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Subject: [PATCH blktests v2 1/2] nvme/rc: fix nvme device readiness check after _nvme_connect_subsys
Date:   Thu, 17 Aug 2023 16:30:20 +0900
Message-Id: <20230817073021.3674602-1-shinichiro.kawasaki@wdc.com>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

The helper function _nvme_connect_subsys() creates a nvme device. It may
take some time after the function call until the device gets ready for
I/O. So it is expected that the test cases call _find_nvme_dev() after
_nvme_connect_subsys() before I/O. _find_nvme_dev() returns the path of
the created device, and it also waits for uuid and wwid sysfs attributes
of the created device get ready. This wait works as the wait for the
device I/O readiness.

However, this wait by _find_nvme_dev() has two problems. The first
problem is missing call of _find_nvme_dev(). The test case nvme/047
calls _nvme_connect_subsys() twice, but _find_nvme_dev() is called only
for the first _nvme_connect_subsys() call. This causes too early I/O to
the device with tcp transport [1]. Fix this by moving the wait for the
device readiness from _find_nvme_dev() to _nvme_connect_subsys(). Also
add --wait-for option to _nvme_connect_subsys(). It allows to skip the
wait in _nvmet_passthru_target_connect() which has its own wait for
device readiness.

The second problem is wrong paths for the sysfs attributes. The paths
do not include namespace index, so the check for the attributes always
fail. Still _find_nvme_dev() does 1 second wait and allows the device
get ready for I/O in most cases, but this is not intended behavior.
Fix the paths by adding the namespace index.

On top of the checks for sysfs attributes, add 'udevadm settle' and a
check for the created device file. These ensures that the create device
is ready for I/O.

[1] https://lore.kernel.org/linux-block/CAHj4cs9GNohGUjohNw93jrr8JGNcRYC-ienAZz+sa7az1RK77w@mail.gmail.com/

Fixes: c766fccf3aff ("Make the NVMe tests more reliable")
Signed-off-by: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
---
Changes from v1:
* Added --wait-for option to _nvme_connect_subsys()
* Added 'udevadm settle' before readiness check

 tests/nvme/rc | 31 +++++++++++++++++++++++--------
 1 file changed, 23 insertions(+), 8 deletions(-)

diff --git a/tests/nvme/rc b/tests/nvme/rc
index 0b964e9..797483e 100644
--- a/tests/nvme/rc
+++ b/tests/nvme/rc
@@ -428,6 +428,8 @@ _nvme_connect_subsys() {
 	local keep_alive_tmo=""
 	local reconnect_delay=""
 	local ctrl_loss_tmo=""
+	local wait_for="ns"
+	local dev i
 
 	while [[ $# -gt 0 ]]; do
 		case $1 in
@@ -483,6 +485,10 @@ _nvme_connect_subsys() {
 				ctrl_loss_tmo="$2"
 				shift 2
 				;;
+			--wait-for)
+				wait_for="$2"
+				shift 2
+				;;
 			*)
 				positional_args+=("$1")
 				shift
@@ -532,6 +538,21 @@ _nvme_connect_subsys() {
 	fi
 
 	nvme connect "${ARGS[@]}" 2> /dev/null
+
+	# Wait until device file and uuid/wwid sysfs attributes get ready for
+	# namespace 1.
+	if [[ ${wait_for} == ns ]]; then
+		udevadm settle
+		dev=$(_find_nvme_dev "$subsysnqn")
+		for ((i = 0; i < 10; i++)); do
+			if [[ -b /dev/${dev}n1 &&
+				      -e /sys/block/${dev}n1/uuid &&
+				      -e /sys/block/${dev}n1/wwid ]]; then
+				return
+			fi
+			sleep .1
+		done
+	fi
 }
 
 _nvme_discover() {
@@ -758,13 +779,6 @@ _find_nvme_dev() {
 		subsysnqn="$(cat "/sys/class/nvme/${dev}/subsysnqn")"
 		if [[ "$subsysnqn" == "$subsys" ]]; then
 			echo "$dev"
-			for ((i = 0; i < 10; i++)); do
-				if [[ -e /sys/block/$dev/uuid &&
-					-e /sys/block/$dev/wwid ]]; then
-					return
-				fi
-				sleep .1
-			done
 		fi
 	done
 }
@@ -794,7 +808,8 @@ _nvmet_passthru_target_connect() {
 	local trtype=$1
 	local subsys_name=$2
 
-	_nvme_connect_subsys "${trtype}" "${subsys_name}" || return
+	_nvme_connect_subsys "${trtype}" "${subsys_name}" --wait-for=none ||
+		return
 	nsdev=$(_find_nvme_passthru_loop_dev "${subsys_name}")
 
 	# The following tests can race with the creation
-- 
2.40.1


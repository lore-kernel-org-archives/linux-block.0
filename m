Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79484C001DE
	for <linux-block@archiver.kernel.org>; Fri, 18 Aug 2023 04:41:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244231AbjHRElU (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 18 Aug 2023 00:41:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1357902AbjHRElC (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 18 Aug 2023 00:41:02 -0400
Received: from esa1.hgst.iphmx.com (esa1.hgst.iphmx.com [68.232.141.245])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7439B3C06
        for <linux-block@vger.kernel.org>; Thu, 17 Aug 2023 21:40:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1692333659; x=1723869659;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=S5ymVNujHDKKAiN5sqGAayD/JOzweF2ZXKdxqx2iBU8=;
  b=XvZIrSdiGcUxHFRjuQyxCuDf3BRRcOkz7i62OzSydjQuqocVVwJN3fJS
   6afWCX0+ioO6UXJV0yHVBJDJd0xMCDaB1Qdip5U+8uYIBIdWML6i4XXqU
   d9hd06OC7zZJOUThQl62gdxyYrsDKyjU1z/eZ3B1tQ465hyiSI7LHl4cQ
   wjeVsPneOUHoTxfCFHpRHzT4PMZJSBojXwkXD5C46JH8NtMF+Is9XgC6E
   +4kaqR/YTIPwAi433ttEVDu4mqkSbH9NaLi6FsmaSUNXQKQvgEfXhsdYd
   CbMchaQeByfXC2wQURgx1eIm7tiJ23r9Zta14kp/bV3bdMdUCF3WEBWkA
   w==;
X-IronPort-AV: E=Sophos;i="6.01,182,1684771200"; 
   d="scan'208";a="353431500"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 18 Aug 2023 12:40:58 +0800
IronPort-SDR: GNgOAQK2/y2fsE4KZ/ecC+vjuddIwnvKeBOI4cSHed1t5mc9DA2p/5u0xHwkN7MCm+q6yPP7zG
 tldyl8dSzCBU5NMNerA+etr0RtQMCk8hdF8T7vtAz3+gShmANVAUKAJFfEvi2z/nV/9xK3Ir/K
 kkk0zTMn/vaZu9UUvNvXaA2Zx/Lqsc/Z/lSLLehBdPkn32jFWkfu84RFgej0vHco/6kfxQ8kQF
 2G3EPkncq35Yjl+esIqyAiKxl0RJ+5JlH8T/Xo0Tm5kiOKgfn9rWg2I7KOaTg/00zWF8wGwbEo
 PDc=
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 17 Aug 2023 20:54:14 -0700
IronPort-SDR: cAF+r+dTuJWOWihuAcnPCYclBGzKNFfNPmLrxAq6SSUESV24cFIWNgLCvTv2/wcSn2NvUOL3lb
 iL5oDxWbbteCjaCDtTrEygD4gLaYQxo+OCGap8oEpa+KtaIGE7qF0zIeOg0a/OPWc84yY373MX
 UkvwliQAThJkGXM7mSCyWhO401F3a2GfhyHFLNxze5sdp6yrM6wWxCLlYnZpcchVMdbLpzl/wO
 FnrnpzgHhwRYcfpUfLRTII7DCpXdfAMHc0J69MSBVwZ6Vd3juhdfRq4KJZG6GKfjdmDUyUzmAQ
 5vo=
WDCIronportException: Internal
Received: from shindev.dhcp.fujisawa.hgst.com (HELO shindev.fujisawa.hgst.com) ([10.149.53.55])
  by uls-op-cesaip02.wdc.com with ESMTP; 17 Aug 2023 21:40:57 -0700
From:   Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To:     linux-block@vger.kernel.org, linux-nvme@lists.infradead.org
Cc:     Yi Zhang <yi.zhang@redhat.com>, Daniel Wagner <dwagner@suse.de>,
        Sagi Grimberg <sagi@grimberg.me>,
        Bart Van Assche <bvanassche@acm.org>,
        Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Subject: [PATCH blktests v3 1/2] nvme/rc: fix nvme device readiness check after _nvme_connect_subsys
Date:   Fri, 18 Aug 2023 13:40:56 +0900
Message-Id: <20230818044057.3794564-1-shinichiro.kawasaki@wdc.com>
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
add --no-wait option to _nvme_connect_subsys(). It allows to skip the
wait in _nvmet_passthru_target_connect() which has its own wait for
device readiness.

The second problem is wrong paths for the sysfs attributes. The paths
do not include namespace index, so the check for the attributes always
fail. Still _find_nvme_dev() does 1 second wait and allows the device
get ready for I/O in most cases, but this is not intended behavior.
Fix this by checking sysfs paths with the namespace index. Get list of
namespace indices for the sub-system and do the check for all indices.

On top of the checks for sysfs attributes, add 'udevadm settle' and a
check for the created device file. These ensures that the create device
is ready for I/O.

[1] https://lore.kernel.org/linux-block/CAHj4cs9GNohGUjohNw93jrr8JGNcRYC-ienAZz+sa7az1RK77w@mail.gmail.com/

Fixes: c766fccf3aff ("Make the NVMe tests more reliable")
Signed-off-by: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
---
Changes from v2:
* Renamed --wait-for option to --no-wait
* Modified to check all namespaces

Changes from v1:
* Added --wait-for option to _nvme_connect_subsys()
* Added 'udevadm settle' before readiness check

 tests/nvme/rc | 42 ++++++++++++++++++++++++++++++++++--------
 1 file changed, 34 insertions(+), 8 deletions(-)

diff --git a/tests/nvme/rc b/tests/nvme/rc
index 0b964e9..92eac06 100644
--- a/tests/nvme/rc
+++ b/tests/nvme/rc
@@ -428,6 +428,8 @@ _nvme_connect_subsys() {
 	local keep_alive_tmo=""
 	local reconnect_delay=""
 	local ctrl_loss_tmo=""
+	local no_wait=""
+	local i
 
 	while [[ $# -gt 0 ]]; do
 		case $1 in
@@ -483,6 +485,10 @@ _nvme_connect_subsys() {
 				ctrl_loss_tmo="$2"
 				shift 2
 				;;
+			--no-wait)
+				no_wait=true
+				shift 1
+				;;
 			*)
 				positional_args+=("$1")
 				shift
@@ -532,6 +538,33 @@ _nvme_connect_subsys() {
 	fi
 
 	nvme connect "${ARGS[@]}" 2> /dev/null
+
+	# Wait until device file and uuid/wwid sysfs attributes get ready for
+	# all namespaces.
+	if [[ -z ${no_wait} ]]; then
+		udevadm settle
+		for ((i = 0; i < 10; i++)); do
+			_nvme_ns_ready "${subsysnqn}" && return
+			sleep .1
+		done
+	fi
+}
+
+_nvme_ns_ready() {
+	local subsysnqn="${1}"
+	local ns_path ns_id dev
+	local cfs_path="${NVMET_CFS}/subsystems/$subsysnqn"
+
+	dev=$(_find_nvme_dev "$subsysnqn")
+	for ns_path in "${cfs_path}/namespaces/"*; do
+		ns_id=${ns_path##*/}
+		if [[ ! -b /dev/${dev}n${ns_id} ||
+			   ! -e /sys/block/${dev}n${ns_id}/uuid ||
+			   ! -e /sys/block/${dev}n${ns_id}/wwid ]]; then
+			return 1
+		fi
+	done
+	return 0
 }
 
 _nvme_discover() {
@@ -758,13 +791,6 @@ _find_nvme_dev() {
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
@@ -794,7 +820,7 @@ _nvmet_passthru_target_connect() {
 	local trtype=$1
 	local subsys_name=$2
 
-	_nvme_connect_subsys "${trtype}" "${subsys_name}" || return
+	_nvme_connect_subsys "${trtype}" "${subsys_name}" --no-wait || return
 	nsdev=$(_find_nvme_passthru_loop_dev "${subsys_name}")
 
 	# The following tests can race with the creation
-- 
2.40.1


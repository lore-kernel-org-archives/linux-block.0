Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4F22C04A94
	for <linux-block@archiver.kernel.org>; Fri, 11 Aug 2023 01:23:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229580AbjHKBXk (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 10 Aug 2023 21:23:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229503AbjHKBXk (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 10 Aug 2023 21:23:40 -0400
Received: from esa6.hgst.iphmx.com (esa6.hgst.iphmx.com [216.71.154.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74552273E
        for <linux-block@vger.kernel.org>; Thu, 10 Aug 2023 18:23:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1691717019; x=1723253019;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=lQkrLEJOnEmWSUncnB7H5JsGyGJ220SolBqq4n6SNa4=;
  b=E2MjHC/PilaFgf9ECM4fL4/iMXm23s9rBccAkntr5xW/I1XqHbEiAOnp
   cctukoDO1uk9zaZQUHDxqkkOu3iX5WWGrgJAIvBopr9J0WQyDg5RkLCms
   SkJkQG0o7IF+zNOdNN4PZ872XmEyM3ZfYC2LsN/6YAYRVeP6a0d7aoCHo
   P1tG8Tg5GWAM461gTEPUXAtM8Cweg54bWwpK9Xz2ldV4F1f9FEC0ryawH
   EVcWQHMeRKXk9QajNtjHv9wkXa/o0YmyOCrcHsYB5FFUKwkbToINnf2Mu
   j3IZMMQKPicwP/Z/yf0sz4/2K1Rp9XglfYWqVlDcVx9+QxPkwwdGdAz0t
   Q==;
X-IronPort-AV: E=Sophos;i="6.01,164,1684771200"; 
   d="scan'208";a="241082143"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 11 Aug 2023 09:23:38 +0800
IronPort-SDR: hf49wq1D/LVsEMpBwFVbTnTAK2EBkvAUywAZIC8GI3h21pw59RrWhq4xcjwg6DeRXSqQhHVzbB
 aS7h6sVh/vKqaP4YzKLywynj/Rkf7LZwvVj9vA1JbdsU00dthKAneR5zxipihAUVQ7Cb/B/bmV
 UH0XYH3qFvKb4KDFudel3pGCWmZgc1c/n6kybEQyz9nHrGiD5I4UVRbdNWI1LGJotKuKNj0iHQ
 +9SPMbEj3OnbOd39kFMZZDzdK2ETOIWbscUHLaS8xVnzqOealqw9hIsB6Oh0V5/tyt354wuhSy
 V+c=
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 10 Aug 2023 17:31:22 -0700
IronPort-SDR: EBD7Zsap+FTYB854yNdN2NfsiEr1MfXNc30Bu1vU1Muqxhttsk3sdWS5ZND/JMPiilMneIE3xq
 cnvliOtwiuF9JLsx6oh7NpCOA4eOAFv+UDJ9yLC0S9cN9/fNlwEe2D93QHgHf2jS073tiJxoVD
 51j1CyO+1WfJKvs/f5gzlT4G8CCQA6g9i2RJhpSjp+bsPxX9yc4U3BmkkI5qoAbIRjiLyVv7l6
 YoR+WS32iYxcvJXxbgR3ksumW+34nZwmvzcIuh1UfApVsM2N6Q4zuDSznm20C807iBTKjhwWHd
 L4o=
WDCIronportException: Internal
Received: from shindev.dhcp.fujisawa.hgst.com (HELO shindev.fujisawa.hgst.com) ([10.149.53.55])
  by uls-op-cesaip02.wdc.com with ESMTP; 10 Aug 2023 18:23:35 -0700
From:   Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To:     linux-block@vger.kernel.org, linux-nvme@lists.infradead.org
Cc:     Yi Zhang <yi.zhang@redhat.com>, Daniel Wagner <dwagner@suse.de>,
        Bart Van Assche <bvanassche@acm.org>,
        Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Subject: [PATCH blktests] nvme/rc: fix nvme device readiness check after _nvme_connect_subsys
Date:   Fri, 11 Aug 2023 10:23:34 +0900
Message-Id: <20230811012334.3392220-1-shinichiro.kawasaki@wdc.com>
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
the device with tcp transport [1]. Fix this by moving the code for
device readiness wait from _find_nvme_dev() to _nvme_connect_subsys().

The second problem is wrong paths for the sysfs attributes. The paths
do not include namespace index, so the check for the attributes always
fail. Still _find_nvme_dev() does 1 second wait and allows the device
get ready for I/O in most cases, but this is not intended behavior.
Fix the paths by adding the namespace index.

On top of the checks for sysfs attributes, add check for the created
device file. This ensures that the create device is ready for I/O.

[1] https://lore.kernel.org/linux-block/CAHj4cs9GNohGUjohNw93jrr8JGNcRYC-ienAZz+sa7az1RK77w@mail.gmail.com/

Fixes: c766fccf3aff ("Make the NVMe tests more reliable")
Signed-off-by: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
---
 tests/nvme/rc | 18 +++++++++++-------
 1 file changed, 11 insertions(+), 7 deletions(-)

diff --git a/tests/nvme/rc b/tests/nvme/rc
index 4f3a994..d09e7b4 100644
--- a/tests/nvme/rc
+++ b/tests/nvme/rc
@@ -425,6 +425,7 @@ _nvme_connect_subsys() {
 	local keep_alive_tmo=""
 	local reconnect_delay=""
 	local ctrl_loss_tmo=""
+	local dev i
 
 	while [[ $# -gt 0 ]]; do
 		case $1 in
@@ -529,6 +530,16 @@ _nvme_connect_subsys() {
 	fi
 
 	nvme connect "${ARGS[@]}" 2> /dev/null
+
+	dev=$(_find_nvme_dev "$subsysnqn")
+	for ((i = 0; i < 10; i++)); do
+		if [[ -b /dev/${dev}n1 &&
+			      -e /sys/block/${dev}n1/uuid &&
+			      -e /sys/block/${dev}n1/wwid ]]; then
+			return
+		fi
+		sleep .1
+	done
 }
 
 _nvme_discover() {
@@ -739,13 +750,6 @@ _find_nvme_dev() {
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
-- 
2.40.1


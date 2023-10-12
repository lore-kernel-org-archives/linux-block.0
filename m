Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC785CDB465
	for <linux-block@archiver.kernel.org>; Thu, 12 Oct 2023 02:12:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233989AbjJLCME (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 11 Oct 2023 22:12:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233929AbjJLCME (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 11 Oct 2023 22:12:04 -0400
Received: from esa1.hgst.iphmx.com (esa1.hgst.iphmx.com [68.232.141.245])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3AB46A9
        for <linux-block@vger.kernel.org>; Wed, 11 Oct 2023 19:11:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1697076720; x=1728612720;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=vHBSuirUxnrDeXtKpL4MAu0PGBcG61Buk+PcsYsGzkI=;
  b=J3rOyOSsZleF4/Wi1JkKZ9dyX7xnO0K8Pql91MfMHbAmZvHDjNPBcuUj
   a9jYVjlz6xSSTkoLILCHvDYj80XAtSpwwexKMJKdYoYBb9MQj/NvJ1vK7
   l9reHU5967q2UxBmq0HTRv6Mudc4p/QzhuUuCifPR3E76AtvBQfVL0nw5
   9eZMZiygZPbi94ZxOU3afCjChi5Kl4xxH+QQnma46CbySbY+Z235+KBH2
   hLp5yH2866idozmZEbu5GczPp5l5PMfNG+xK0O3E7uLw44h/hJk2PJGmz
   D1yxWTDn8mij9Sn7lydU3cbbTXEcQqqEnb31ugqyVePXdcItT+l8382ZU
   g==;
X-CSE-ConnectionGUID: 292CY/P9QuO914+ixk3+Gw==
X-CSE-MsgGUID: xkF0ieesT7OA188WF+QH9g==
X-IronPort-AV: E=Sophos;i="6.03,217,1694707200"; 
   d="scan'208";a="358430903"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 12 Oct 2023 10:11:55 +0800
IronPort-SDR: Tt4xaDHEjLBRZ/Q7qLi2aCkU42ocZP4vdU2t3vYHqIJt9/kfzwmLa9EzLxlsrDHftftdt+XYJF
 9RP9GNQ8nJJM7/mN5t/JtVjatJcfGt2NJsUYF+1BgEYDSZzJZM1aZ9DIlFYv/hX+i6pJzsrX1g
 SccY6PZzdr7EfCOJhYZc3Y5ewUxqQErZc+NQUUtX6qpEm1jkqCfZSlYmK9XUSkZufUtWXuP0A7
 UoJYT5ytPOof8h9bBkklNzHXx/QdiibRI/KMk3NiXjxOw13hgttjIVN3Ro65koyZEXGsOTkiQx
 1C0=
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 11 Oct 2023 18:24:03 -0700
IronPort-SDR: 2IrWY0yZovMuNrS4/ZY2rwjMPtYuBw+cL7xk09X/JelqD0QBy/GcqT3u9B86QdoklN8LkVItL3
 XwIHmAwD6l4igpHVxjVvP5LqJNHn7lzHgAiQ9xnqrynGOmDE7GP+U8+13ZmzXEinxboagtnodj
 gDjaXVFSaMqFBiUYePdvbTlhjCzDmJu9E/kPaLYxdBU++wMXttZOJYCiVGVrOy+R70Zupvuf68
 55sIt+bH6C5YY/gjf+9XWHLU9O4G7Q0rYJlmhJW4zIgaeXS9Dyelg13itACvU6n1dNjdDpSbFI
 BE4=
WDCIronportException: Internal
Received: from shindev.dhcp.fujisawa.hgst.com (HELO shindev.fujisawa.hgst.com) ([10.149.53.55])
  by uls-op-cesaip01.wdc.com with ESMTP; 11 Oct 2023 19:11:55 -0700
From:   Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To:     linux-block@vger.kernel.org
Cc:     Yi Zhang <yi.zhang@redhat.com>, Daniel Wagner <dwagner@suse.de>,
        Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Subject: [PATCH blktests 1/2] nvme/{rc,017,031}: replace def_file_path with _nvme_def_file_path()
Date:   Thu, 12 Oct 2023 11:11:51 +0900
Message-ID: <20231012021152.832553-2-shinichiro.kawasaki@wdc.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231012021152.832553-1-shinichiro.kawasaki@wdc.com>
References: <20231012021152.832553-1-shinichiro.kawasaki@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

The commit b6356f6 ("nvme/rc: Add common file_path name define") defined
a global variable 'def_file_path' in nvme/rc, which refers TMPDIR.
However, when nvme/rc is sourced and def_file_path is defined for the
nvme test group, TMPDIR is not yet defined since TMPDIR is defined for
each test case. Then an unexpected path is set to def_file_path and
temporary files are created at the unexpected path.

Fix this by replacing the global variable def_file_path with a helper
function _nvme_def_file_path(). This helper function allows to refer
TMPDIR not at nvme/rc source timing but in test() or test_device()
context of each test case.

Reported-by: Yi Zhang <yi.zhang@redhat.com>
Fixes: b6356f6 ("nvme/rc: Add common file_path name define")
Signed-off-by: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
---
 tests/nvme/017 |  9 +++++----
 tests/nvme/031 |  6 +++---
 tests/nvme/rc  | 17 +++++++++++------
 3 files changed, 19 insertions(+), 13 deletions(-)

diff --git a/tests/nvme/017 b/tests/nvme/017
index aa0a3fe..c8d9b32 100755
--- a/tests/nvme/017
+++ b/tests/nvme/017
@@ -21,15 +21,16 @@ test() {
 	local port
 	local iterations="${nvme_num_iter}"
 
-	truncate -s "${nvme_img_size}" "${def_file_path}"
+	truncate -s "${nvme_img_size}" "$(_nvme_def_file_path)"
 
 	local genctr=1
 
-	_create_nvmet_subsystem "${def_subsysnqn}" "${def_file_path}" \
+	_create_nvmet_subsystem "${def_subsysnqn}" "$(_nvme_def_file_path)" \
 		"${def_subsys_uuid}"
 
 	for ((i = 2; i <= iterations; i++)); do
-		_create_nvmet_ns "${def_subsysnqn}" "${i}" "${def_file_path}"
+		_create_nvmet_ns "${def_subsysnqn}" "${i}" \
+				 "$(_nvme_def_file_path)"
 	done
 
 	port="$(_create_nvmet_port "${nvme_trtype}")"
@@ -46,7 +47,7 @@ test() {
 
 	_remove_nvmet_subsystem "${def_subsysnqn}"
 
-	rm "${def_file_path}"
+	rm "$(_nvme_def_file_path)"
 
 	echo "Test complete"
 }
diff --git a/tests/nvme/031 b/tests/nvme/031
index 696db2d..ed5f196 100755
--- a/tests/nvme/031
+++ b/tests/nvme/031
@@ -33,9 +33,9 @@ test() {
 	local loop_dev
 	local port
 
-	truncate -s "${nvme_img_size}" "${def_file_path}"
+	truncate -s "${nvme_img_size}" "$(_nvme_def_file_path)"
 
-	loop_dev="$(losetup -f --show "${def_file_path}")"
+	loop_dev="$(losetup -f --show "$(_nvme_def_file_path)")"
 
 	port="$(_create_nvmet_port "${nvme_trtype}")"
 
@@ -52,7 +52,7 @@ test() {
 
 	_remove_nvmet_port "${port}"
 	losetup -d "$loop_dev"
-	rm "${def_file_path}"
+	rm "$(_nvme_def_file_path)"
 
 	echo "Test complete"
 }
diff --git a/tests/nvme/rc b/tests/nvme/rc
index 1ec9eb6..012ca95 100644
--- a/tests/nvme/rc
+++ b/tests/nvme/rc
@@ -18,11 +18,16 @@ def_hostid="0f01fb42-9f7f-4856-b0b3-51e60b8de349"
 def_hostnqn="nqn.2014-08.org.nvmexpress:uuid:${def_hostid}"
 export def_subsysnqn="blktests-subsystem-1"
 export def_subsys_uuid="91fdba0d-f87b-4c25-b80f-db7be1418b9e"
-export def_file_path="${TMPDIR}/img"
 nvme_trtype=${nvme_trtype:-"loop"}
 nvme_img_size=${nvme_img_size:-"1G"}
 nvme_num_iter=${nvme_num_iter:-"1000"}
 
+# TMPDIR can not be referred out of test() or test_device() context. Instead of
+# global variable def_flie_path, use this getter function.
+_nvme_def_file_path() {
+	echo "${TMPDIR}/img"
+}
+
 _nvme_requires() {
 	_have_program nvme
 	_require_nvme_test_img_size 4m
@@ -300,11 +305,11 @@ _cleanup_blkdev() {
 	local blkdev
 	local dev
 
-	blkdev="$(losetup -l | awk '$6 == "'"${def_file_path}"'" { print $1 }')"
+	blkdev="$(losetup -l | awk '$6 == "'"$(_nvme_def_file_path)"'" { print $1 }')"
 	for dev in ${blkdev}; do
 		losetup -d "${dev}"
 	done
-	rm -f "${def_file_path}"
+	rm -f "$(_nvme_def_file_path)"
 }
 
 _cleanup_nvmet() {
@@ -859,11 +864,11 @@ _nvmet_target_setup() {
 		esac
 	done
 
-	truncate -s "${nvme_img_size}" "${def_file_path}"
+	truncate -s "${nvme_img_size}" "$(_nvme_def_file_path)"
 	if [[ "${blkdev_type}" == "device" ]]; then
-		blkdev="$(losetup -f --show "${def_file_path}")"
+		blkdev="$(losetup -f --show "$(_nvme_def_file_path)")"
 	else
-		blkdev="${def_file_path}"
+		blkdev="$(_nvme_def_file_path)"
 	fi
 
 	_create_nvmet_subsystem "${def_subsysnqn}" "${blkdev}" \
-- 
2.41.0


Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3FFFC4332F
	for <linux-block@archiver.kernel.org>; Wed, 23 Nov 2022 03:38:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235536AbiKWDiQ (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 22 Nov 2022 22:38:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235464AbiKWDiQ (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 22 Nov 2022 22:38:16 -0500
Received: from resqmta-h1p-028591.sys.comcast.net (resqmta-h1p-028591.sys.comcast.net [IPv6:2001:558:fd02:2446::9])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49C82E6ECE
        for <linux-block@vger.kernel.org>; Tue, 22 Nov 2022 19:38:13 -0800 (PST)
Received: from resomta-h1p-027914.sys.comcast.net ([96.102.179.199])
        by resqmta-h1p-028591.sys.comcast.net with ESMTP
        id xdj7oE63h3B3mxgaTopQsP; Wed, 23 Nov 2022 03:38:13 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=comcastmailservice.net; s=20211018a; t=1669174693;
        bh=hQzLNxeVwxXXcietcYnNiJmhzt78/d1Q4sA4HI+a4es=;
        h=Received:Received:From:To:Subject:Date:Message-Id:MIME-Version:
         Xfinity-Spam-Result;
        b=mA4zlSU50g0+Lv/4E95eiHd7mF+rWSru9YhjN8YHbzpjamteoad04z4HztPHPCuCd
         ZAe3Dw11lODnVbU9SyycFOv7JVCDiE1vj/4QpeQKJu3vZ4kg3BO/ZTUMyrIdhWY/G1
         lGNVyNR7RjWeurEjfjKTTo65I2YNV893C7HGll/m6z0TxXfzh/MoY0xi7eTCbli+4C
         tp9Mbli/t2s6XyNPCjR6WLfs3MfORl9KJZlrCb/0Vxn2ua5GXBt18Mpu6fepu+/U61
         LZAfpf3cZ1jG2gMuUYZZ0E8Gttj5b3yoJ9XwCsSNyczXqApSCHj7fCUMyO6zp0Vi0R
         a9qcJ/BALeiqw==
Received: from jderrick-mobl4.amr.corp.intel.com ([71.205.181.50])
        by resomta-h1p-027914.sys.comcast.net with ESMTPA
        id xgZxoyAM5eZC2xga2o0O5J; Wed, 23 Nov 2022 03:37:51 +0000
X-Xfinity-VAAS: gggruggvucftvghtrhhoucdtuddrgedvgedriedtgdeivdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucevohhmtggrshhtqdftvghsihdpqfgfvfdppffquffrtefokffrnecuuegrihhlohhuthemuceftddunecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvfevufffkffoggfgsedtkeertdertddtnecuhfhrohhmpeflohhnrghthhgrnhcuffgvrhhrihgtkhcuoehjohhnrghthhgrnhdruggvrhhrihgtkheslhhinhhugidruggvvheqnecuggftrfgrthhtvghrnhepueegudevvdfffeefvdekjefgueetgffhgfdtueeufeevtdelfedutefftdekueevnecuffhomhgrihhnpehkvghrnhgvlhdrohhrghenucfkphepjedurddvtdehrddukedurdehtdenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhephhgvlhhopehjuggvrhhrihgtkhdqmhhosghlgedrrghmrhdrtghorhhprdhinhhtvghlrdgtohhmpdhinhgvthepjedurddvtdehrddukedurdehtddpmhgrihhlfhhrohhmpehjohhnrghthhgrnhdruggvrhhrihgtkheslhhinhhugidruggvvhdpnhgspghrtghpthhtohepledprhgtphhtthhopehlihhnuhigqdhnvhhmvgeslhhishhtshdrihhnfhhrrgguvggrugdrohhrghdprhgtphhtthhopehlihhnuhigqdgslhhotghksehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepshhhihhnihgthhhirhhordhkrgifrghsrghkihesfi
 gutgdrtghomhdprhgtphhtthhopegthhgrihhtrghnhigrkhesnhhvihguihgrrdgtohhmpdhrtghpthhtohepkhgsuhhstghhsehkvghrnhgvlhdrohhrghdprhgtphhtthhopehhtghhsehlshhtrdguvgdprhgtphhtthhopehsrghgihesghhrihhmsggvrhhgrdhmvgdprhgtphhtthhopehithhssehirhhrvghlvghvrghnthdrughkpdhrtghpthhtohepjhhonhgrthhhrghnrdguvghrrhhitghksehlihhnuhigrdguvghv
X-Xfinity-VMeta: sc=-100.00;st=legit
From:   Jonathan Derrick <jonathan.derrick@linux.dev>
To:     <linux-nvme@lists.infradead.org>
Cc:     <linux-block@vger.kernel.org>,
        "Shin\\'ichiro Kawasaki" <shinichiro.kawasaki@wdc.com>,
        Chaitanya Kulkarni <chaitanyak@nvidia.com>,
        Keith Busch <kbusch@kernel.org>,
        Christoph Hellwig <hch@lst.de>,
        Sagi Grimberg <sagi@grimberg.me>,
        Klaus Jensen <its@irrelevant.dk>,
        Jonathan Derrick <jonathan.derrick@linux.dev>
Subject: [PATCH v3] tests/nvme: Add admin-passthru+reset race test
Date:   Tue, 22 Nov 2022 20:37:39 -0700
Message-Id: <20221123033739.1122-1-jonathan.derrick@linux.dev>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Adds a test which runs many formats and controller resets in parallel.
The intent is to expose timing holes in the controller state machine
which will lead to hung task timeouts and the controller becoming
unavailable.

Reported by https://bugzilla.kernel.org/show_bug.cgi?id=216354

Signed-off-by: Jonathan Derrick <jonathan.derrick@linux.dev>
---
v3:
I noticed I couldn't rely on checking state within the loop because it was
constantly on 'resetting', so I moved the last_live declaration to update when
a reset completes.

I updated the kernel in my QEMU instance to origin/nvme-6.2 (it was on a
previous origin/nvme-6.2), and applied Klaus' format fix to QEMU. This doesn't
crash my QEMU anymore, but now gets stuck in 'connecting'.

 tests/nvme/047     | 137 +++++++++++++++++++++++++++++++++++++++++++++
 tests/nvme/047.out |   2 +
 2 files changed, 139 insertions(+)
 create mode 100755 tests/nvme/047
 create mode 100644 tests/nvme/047.out

diff --git a/tests/nvme/047 b/tests/nvme/047
new file mode 100755
index 0000000..76b7fdf
--- /dev/null
+++ b/tests/nvme/047
@@ -0,0 +1,137 @@
+#!/bin/bash
+# SPDX-License-Identifier: GPL-3.0+
+# Copyright (C) 2022 Jonathan Derrick <jonathan.derrick@linux.dev>
+#
+# Test nvme reset controller during admin passthru
+#
+# Regression for issue reported by
+# https://bugzilla.kernel.org/show_bug.cgi?id=216354
+#
+# Simpler form:
+# for i in {1..50}; do
+#	nvme format -f /dev/nvme0n1 &
+#	echo 1 > /sys/block/nvme0n1/device/reset_controller &
+# done
+
+. tests/nvme/rc
+
+#restrict test to nvme-pci only
+nvme_trtype=pci
+
+DESCRIPTION="test nvme reset controller during admin passthru"
+QUICK=1
+CAN_BE_ZONED=1
+
+RUN_TIME=300
+RESET_MISSING=true
+RESET_DEAD=true
+
+requires() {
+	_nvme_requires
+}
+
+device_requires() {
+	_require_test_dev_is_nvme
+}
+
+test_device() {
+	echo "Running ${TEST_NAME}"
+
+	local pdev
+	local blkdev
+	local ctrldev
+	local sysfs
+	local max_timeout
+	local timeout
+	local timeleft
+	local start
+	local i
+
+	pdev="$(_get_pci_dev_from_blkdev)"
+	blkdev="${TEST_DEV_SYSFS##*/}"
+	ctrldev="$(echo "$blkdev" | grep -Eo 'nvme[0-9]+')"
+	sysfs="/sys/block/$blkdev/device"
+	max_timeout=$(cat /proc/sys/kernel/hung_task_timeout_secs)
+	timeout=$((max_timeout * 3 / 4))
+
+	get_state() {
+		state=$(cat "$sysfs/state" 2> /dev/null)
+		if [[ -n "$state" ]]; then
+			echo "$state"
+		else
+			echo "unknown"
+		fi
+	}
+
+	tmp=$(mktemp /tmp/blk_tmp_XXXXXX)
+	lock=$(mktemp /tmp/blk_lock_XXXXXX)
+	exec 47>"$lock"
+	update_live() {
+		flock -s 047
+		date "+%s" > "$tmp"
+		flock -u 47
+	}
+
+	last_live() {
+		flock -s 47
+		cat "$tmp"
+		flock -u 47
+	}
+
+	now() {
+		date "+%s"
+	}
+
+	sleep 5
+
+	update_live
+	start=$(now)
+	while [[ $(($(now) - start)) -le $RUN_TIME ]]; do
+		# Failure case appears to stack up formats while controller is resetting/connecting
+		if [[ $(pgrep -cf "nvme format") -lt 100 ]]; then
+			for ((i=0; i<100; i++)); do
+				nvme format -f "$TEST_DEV" &
+				( echo 1 > "$sysfs/reset_controller" && update_live; ) &
+			done &> /dev/null
+		fi
+
+		# Might have failed probe, so reset and continue test
+		if [[ $(($(now) - $(last_live))) -gt 10 ]]; then
+			if [[ (! -c "/dev/$ctrldev" && "$RESET_MISSING" == true) ||
+			      ("$(get_state)" == "dead" && "$RESET_DEAD" == true) ]]; then
+				{
+					echo 1 > /sys/bus/pci/devices/"$pdev"/remove
+					echo 1 > /sys/bus/pci/rescan
+				} &
+
+				timeleft=$((max_timeout - timeout))
+				sleep $((timeleft < 30 ? timeleft : 30))
+				if [[ ! -c "/dev/$ctrldev" ]]; then
+					echo "/dev/$ctrldev missing"
+					echo "failed to reset $ctrldev's pcie device $pdev"
+					break
+				fi
+				sleep 5
+				continue
+			fi
+		fi
+
+		if [[ $(($(now) - $(last_live))) -gt $timeout ]]; then
+			if [[ ! -c "/dev/$ctrldev" ]]; then
+				echo "/dev/$ctrldev missing"
+				break
+			fi
+
+			# Assume the controller is hung and unrecoverable
+			echo "nvme controller hung ($(get_state))"
+			break
+		fi
+	done
+
+	if [[ ! -c "/dev/$ctrldev" || "$(get_state)" != "live" ]]; then
+		echo "nvme still not live after $(($(now) - $(last_live))) seconds!"
+	fi
+	udevadm settle
+
+	echo "Test complete"
+}
diff --git a/tests/nvme/047.out b/tests/nvme/047.out
new file mode 100644
index 0000000..915d0a2
--- /dev/null
+++ b/tests/nvme/047.out
@@ -0,0 +1,2 @@
+Running nvme/047
+Test complete
-- 
2.27.0


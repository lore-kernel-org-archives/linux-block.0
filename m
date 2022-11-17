Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4410BC4332F
	for <linux-block@archiver.kernel.org>; Thu, 17 Nov 2022 21:26:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240934AbiKQV0U (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 17 Nov 2022 16:26:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239980AbiKQVZ1 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 17 Nov 2022 16:25:27 -0500
X-Greylist: delayed 150 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 17 Nov 2022 13:25:13 PST
Received: from resdmta-c1p-023852.sys.comcast.net (resdmta-c1p-023852.sys.comcast.net [IPv6:2001:558:fd00:56::c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B6E9490B4
        for <linux-block@vger.kernel.org>; Thu, 17 Nov 2022 13:25:13 -0800 (PST)
Received: from resomta-c1p-023269.sys.comcast.net ([96.102.18.227])
        by resdmta-c1p-023852.sys.comcast.net with ESMTP
        id vlsEo1dFn9RorvmLKoymbH; Thu, 17 Nov 2022 21:22:42 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=comcastmailservice.net; s=20211018a; t=1668720162;
        bh=ZFnTdm2gyyk3AIYG+7WjvGTFAbvC92e2yMedMg6h24U=;
        h=Received:Received:From:To:Subject:Date:Message-Id:MIME-Version:
         Xfinity-Spam-Result;
        b=IsTRE0zd8xcQbDBpR/WIN65xhhDwekJGczFgp78Pm9Nl69CdsjA5PlPbN4FqaRoA1
         o5k39+BF13+XQ7UI7/wOCDfPBNfb3tS1Q/1RQu5mnNryEAC6qVHAh86u59EfGS++sS
         wlm4XT1On29X73ULLaNmFfQUi7JtdlPePzhQf8W4jlgC5ekfrH7F9r+uZCbEXjutwz
         1OEMOe2y8zAhYpuXcqULy1X7uusbAbDgFJsDlhR7orPiQGqpTlNg1uHs18b3pQDzGy
         ffujIiKIy8TWXC47XarSA+t39EK7nCyMGPrdFTA6Ecbi8JDg+/bVp0CGsswv4gU6a9
         jAdBGW4Qk6f7g==
Received: from jderrick-mobl4.amr.corp.intel.com ([71.205.181.50])
        by resomta-c1p-023269.sys.comcast.net with ESMTPA
        id vmKqoGUS3xf0xvmKvowVoN; Thu, 17 Nov 2022 21:22:21 +0000
X-Xfinity-VAAS: gggruggvucftvghtrhhoucdtuddrgedvgedrgeekgddugeejucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuvehomhgtrghsthdqtfgvshhipdfqfgfvpdfpqffurfetoffkrfenuceurghilhhouhhtmecufedtudenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvvefufffkofgggfestdekredtredttdenucfhrhhomheplfhonhgrthhhrghnucffvghrrhhitghkuceojhhonhgrthhhrghnrdguvghrrhhitghksehlihhnuhigrdguvghvqeenucggtffrrghtthgvrhhnpeeugeduvedvffeffedvkeejgfeutefghffgtdeuueefvedtleefudetffdtkeeuveenucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecukfhppeejuddrvddthedrudekuddrhedtnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehhvghlohepjhguvghrrhhitghkqdhmohgslhegrdgrmhhrrdgtohhrphdrihhnthgvlhdrtghomhdpihhnvghtpeejuddrvddthedrudekuddrhedtpdhmrghilhhfrhhomhepjhhonhgrthhhrghnrdguvghrrhhitghksehlihhnuhigrdguvghvpdhnsggprhgtphhtthhopeekpdhrtghpthhtoheplhhinhhugidqnhhvmhgvsehlihhsthhsrdhinhhfrhgruggvrggurdhorhhgpdhrtghpthhtoheplhhinhhugidqsghlohgtkhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehshhhinhhitghhihhrohdrkhgrfigrshgrkhhise
 ifuggtrdgtohhmpdhrtghpthhtoheptghhrghithgrnhihrghksehnvhhiughirgdrtghomhdprhgtphhtthhopehksghushgthheskhgvrhhnvghlrdhorhhgpdhrtghpthhtohephhgthheslhhsthdruggvpdhrtghpthhtohepshgrghhisehgrhhimhgsvghrghdrmhgvpdhrtghpthhtohepjhhonhgrthhhrghnrdguvghrrhhitghksehlihhnuhigrdguvghv
X-Xfinity-VMeta: sc=-100.00;st=legit
From:   Jonathan Derrick <jonathan.derrick@linux.dev>
To:     <linux-nvme@lists.infradead.org>
Cc:     <linux-block@vger.kernel.org>,
        "Shin\\'ichiro Kawasaki" <shinichiro.kawasaki@wdc.com>,
        Chaitanya Kulkarni <chaitanyak@nvidia.com>,
        Keith Busch <kbusch@kernel.org>,
        Christoph Hellwig <hch@lst.de>,
        Sagi Grimberg <sagi@grimberg.me>,
        Jonathan Derrick <jonathan.derrick@linux.dev>
Subject: [PATCH v2] tests/nvme: Add admin-passthru+reset race test
Date:   Thu, 17 Nov 2022 14:22:10 -0700
Message-Id: <20221117212210.934-1-jonathan.derrick@linux.dev>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Adds a test which runs many formats and reset_controllers in parallel.
The intent is to expose timing holes in the controller state machine
which will lead to hung task timeouts and the controller becoming
unavailable.

Reported by https://bugzilla.kernel.org/show_bug.cgi?id=216354

Signed-off-by: Jonathan Derrick <jonathan.derrick@linux.dev>
---
I seem to have isolated the error mechanism for older kernels, but 6.2.0-rc2
reliably segfaults my QEMU instance (something else to look into) and I don't
have any 'real' hardware to test this on at the moment. It looks like several
passthru commands are able to enqueue prior/during/after resetting/connecting.

The issue seems to be very heavily timing related, so the loop in the header is
a lot more forceful in this approach.

As far as the loop goes, I've noticed it will typically repro immediately or
pass the whole test.

 tests/nvme/047     | 121 +++++++++++++++++++++++++++++++++++++++++++++
 tests/nvme/047.out |   2 +
 2 files changed, 123 insertions(+)
 create mode 100755 tests/nvme/047
 create mode 100644 tests/nvme/047.out

diff --git a/tests/nvme/047 b/tests/nvme/047
new file mode 100755
index 0000000..fb8609c
--- /dev/null
+++ b/tests/nvme/047
@@ -0,0 +1,121 @@
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
+RESET_PCIE=true
+
+requires() {
+	_nvme_requires
+}
+
+device_requires() {
+	_require_test_dev_is_nvme
+}
+
+remove_and_rescan() {
+	local pdev=$1
+	echo 1 > /sys/bus/pci/devices/"$pdev"/remove
+	echo 1 > /sys/bus/pci/rescan
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
+	local last_live
+	local i
+
+	pdev="$(_get_pci_dev_from_blkdev)"
+	blkdev="${TEST_DEV_SYSFS##*/}"
+	ctrldev="$(echo "$blkdev" | grep -Eo 'nvme[0-9]+')"
+	sysfs="/sys/block/$blkdev/device"
+	max_timeout=$(cat /proc/sys/kernel/hung_task_timeout_secs)
+	timeout=$((max_timeout * 3 / 4))
+
+	sleep 5
+
+	start=$SECONDS
+	while [[ $((SECONDS - start)) -le $RUN_TIME ]]; do
+		if [[ $(cat "$sysfs/state") == "live" ]]; then
+			last_live=$SECONDS
+		fi
+
+		# Failure case appears to stack up formats while controller is resetting/connecting
+		if [[ $(pgrep -cf "nvme format") -lt 100 ]]; then
+			for ((i=0; i<100; i++)); do
+				nvme format -f "$TEST_DEV" &
+				echo 1 > "$sysfs/reset_controller" &
+			done &> /dev/null
+		fi
+
+		# Might have failed probe, so reset and continue test
+		if [[ $((SECONDS - last_live)) -gt 10 && \
+		      ! -c "/dev/$ctrldev" && "$RESET_PCIE" == true ]]; then
+			{
+				echo 1 > /sys/bus/pci/devices/"$pdev"/remove
+				echo 1 > /sys/bus/pci/rescan
+			} &
+
+			timeleft=$((max_timeout - timeout))
+			sleep $((timeleft < 30 ? timeleft : 30))
+			if [[ ! -c "/dev/$ctrldev" ]]; then
+				echo "/dev/$ctrldev missing"
+				echo "failed to reset $ctrldev's pcie device $pdev"
+				break
+			fi
+			sleep 5
+			continue
+		fi
+
+		if [[ $((SECONDS - last_live)) -gt $timeout ]]; then
+			if [[ ! -c "/dev/$ctrldev" ]]; then
+				echo "/dev/$ctrldev missing"
+				break
+			fi
+
+			# Assume the controller is hung and unrecoverable
+			if [[ -f "$sysfs/state" ]]; then
+				echo "nvme controller hung ($(cat "$sysfs/state"))"
+				break
+			else
+				echo "nvme controller hung"
+				break
+			fi
+		fi
+	done
+
+	if [[ ! -c "/dev/$ctrldev" || $(cat "$sysfs/state") != "live" ]]; then
+		echo "nvme still not live after $((SECONDS - last_live)) seconds!"
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


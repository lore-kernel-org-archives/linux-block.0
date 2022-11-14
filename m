Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4BE0C433FE
	for <linux-block@archiver.kernel.org>; Mon, 14 Nov 2022 20:37:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235995AbiKNUhh (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 14 Nov 2022 15:37:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235636AbiKNUhg (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 14 Nov 2022 15:37:36 -0500
X-Greylist: delayed 150 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 14 Nov 2022 12:37:34 PST
Received: from resdmta-h1p-028597.sys.comcast.net (resdmta-h1p-028597.sys.comcast.net [IPv6:2001:558:fd02:2446::d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 506F0101D5
        for <linux-block@vger.kernel.org>; Mon, 14 Nov 2022 12:37:34 -0800 (PST)
Received: from resomta-h1p-027908.sys.comcast.net ([96.102.179.197])
        by resdmta-h1p-028597.sys.comcast.net with ESMTP
        id uYh7omcd3fagrugAYoTiJx; Mon, 14 Nov 2022 20:35:02 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=comcastmailservice.net; s=20211018a; t=1668458102;
        bh=tOQ2uBUDLF0h8iyRoUOUMg45l54ag5/2AuUbFTQSgiA=;
        h=Received:Received:From:To:Subject:Date:Message-Id:MIME-Version:
         Xfinity-Spam-Result;
        b=gPH0t0KjXi/MM+A9tWkZ0UOubkAQ6azean+yu7/OLggOwsodcmtWaaIn7oW7BaVKD
         /akgDvVLONgWPGmmH78o3OOTWay+IrodbV5cDbbv1hOeKoAWCA3aZ77J5Pvzu1+Mqo
         booF3VRY/az1ZqAsJ60oRLcWs7hDxSAdEXCPC3el+M2pZsChZsdLRXnvDuQLvHTUJc
         tdEe83MwaG/Fc4eyk6llA06WKve5gle/9FOdM7eePUC2r2P4g12hfPOPXfF7i1xpB4
         CzNgYGxiWNNAEbbJrmytnZRGBrO8Mnyrifs/6beOa9+tgha3aQiLAiz5UpoirHasRC
         UdrnXIBU2qd7A==
Received: from jderrick-mobl4.solidigmtechnology.com ([137.83.219.25])
        by resomta-h1p-027908.sys.comcast.net with ESMTPA
        id ug9moRZwyxQh3ug9ros9eM; Mon, 14 Nov 2022 20:34:38 +0000
X-Xfinity-VAAS: gggruggvucftvghtrhhoucdtuddrgedvgedrgedvgdduudduucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuvehomhgtrghsthdqtfgvshhipdfqfgfvpdfpqffurfetoffkrfenuceurghilhhouhhtmecufedtudenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvvefufffkofgggfestdekredtredttdenucfhrhhomheplfhonhgrthhhrghnucffvghrrhhitghkuceojhhonhgrthhhrghnrdguvghrrhhitghksehlihhnuhigrdguvghvqeenucggtffrrghtthgvrhhnpeeugeduvedvffeffedvkeejgfeutefghffgtdeuueefvedtleefudetffdtkeeuveenucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecukfhppedufeejrdekfedrvdduledrvdehnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehhvghlohepjhguvghrrhhitghkqdhmohgslhegrdhsohhlihguihhgmhhtvggthhhnohhlohhghidrtghomhdpihhnvghtpedufeejrdekfedrvdduledrvdehpdhmrghilhhfrhhomhepjhhonhgrthhhrghnrdguvghrrhhitghksehlihhnuhigrdguvghvpdhnsggprhgtphhtthhopeeipdhrtghpthhtoheplhhinhhugidqnhhvmhgvsehlihhsthhsrdhinhhfrhgruggvrggurdhorhhgpdhrtghpthhtoheplhhinhhugidqsghlohgtkhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehshhhinhhitghhihhrohdrkhgrfigrsh
 grkhhiseifuggtrdgtohhmpdhrtghpthhtohepkhgsuhhstghhsehkvghrnhgvlhdrohhrghdprhgtphhtthhopehoshgrnhguohhvsehoshgrnhguohhvrdgtohhmpdhrtghpthhtohepjhhonhgrthhhrghnrdguvghrrhhitghksehlihhnuhigrdguvghv
X-Xfinity-VMeta: sc=-100.00;st=legit
From:   Jonathan Derrick <jonathan.derrick@linux.dev>
To:     <linux-nvme@lists.infradead.org>, <linux-block@vger.kernel.org>,
        "Shin\\'ichiro Kawasaki" <shinichiro.kawasaki@wdc.com>
Cc:     Keith Busch <kbusch@kernel.org>,
        Omar Sandoval <osandov@osandov.com>,
        Jonathan Derrick <jonathan.derrick@linux.dev>
Subject: [PATCH] tests/nvme: Add admin-passthru+reset race test
Date:   Mon, 14 Nov 2022 13:34:12 -0700
Message-Id: <20221114203412.383-1-jonathan.derrick@linux.dev>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Adds a test which runs many formats and reset_controllers in parallel.
The intent is to expose timing holes in the controller state machine
which will lead to hung task timing and the controller becoming
unavailable.

Reported by https://bugzilla.kernel.org/show_bug.cgi?id=216354

Signed-off-by: Jonathan Derrick <jonathan.derrick@linux.dev>
---
 tests/nvme/046     | 85 ++++++++++++++++++++++++++++++++++++++++++++++
 tests/nvme/046.out |  2 ++
 2 files changed, 87 insertions(+)
 create mode 100755 tests/nvme/046
 create mode 100644 tests/nvme/046.out

diff --git a/tests/nvme/046 b/tests/nvme/046
new file mode 100755
index 0000000..4b47783
--- /dev/null
+++ b/tests/nvme/046
@@ -0,0 +1,85 @@
+#!/bin/bash
+# SPDX-License-Identifier: GPL-3.0+
+# Copyright (C) 2022 Jonathan Derrick <jonathan.derrick@linux.dev>
+#
+# Test nvme reset controller during admin passthru
+#
+# Regression for issue reported by
+# https://bugzilla.kernel.org/show_bug.cgi?id=216354
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
+	local sysfs
+	local attr
+	local m
+
+	sysfs="$TEST_DEV_SYSFS/device"
+	timeout=$(($(cat /proc/sys/kernel/hung_task_timeout_secs) / 2))
+
+	sleep 5
+
+	if [[ ! -d "$sysfs" ]]; then
+		echo "$sysfs doesn't exist"
+	fi
+
+	# do reset controller/format loops
+	# don't check status now because a timing race is desired
+	i=0
+	start=0
+	timing_out=false
+	while [[ $i -le 1000 ]]; do
+		start=$SECONDS
+		if [[ -f "$sysfs/reset_controller" ]]; then
+			echo 1 > "$sysfs/reset_controller" 2>/dev/null &
+			i=$((i+1))
+		fi
+		nvme format -l 0 -f $TEST_DEV 2>/dev/null &
+
+		#Assume the controller is hung and unrecoverable
+		if [[ $(($SECONDS - $start)) -gt $timeout ]]; then
+			echo "nvme controller timing out"
+			timing_out=true
+			break
+		fi
+	done
+
+	{ kill $!; wait; } &> /dev/null
+
+	# at this point it may have waited hung_task_timeout / 2 already, so
+	# only wait 25% longer for a total of about 75% of allowed timeout
+	m=0
+	while [[ $m -le $((timeout / 2)) ]]; do
+		if [[ $timing_out == true ]]; then
+			break
+		fi
+		if grep -q live "$sysfs/state"; then
+			break
+		fi
+		sleep 1
+		m=$((m+1))
+	done
+	if ! grep -q live "$sysfs/state"; then
+		echo "nvme still not live after $(($SECONDS - $start)) seconds!"
+	fi
+	udevadm settle
+
+	echo "Test complete"
+}
diff --git a/tests/nvme/046.out b/tests/nvme/046.out
new file mode 100644
index 0000000..2b5fa6a
--- /dev/null
+++ b/tests/nvme/046.out
@@ -0,0 +1,2 @@
+Running nvme/046
+Test complete
-- 
2.31.1


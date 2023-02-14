Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40609C61DA4
	for <linux-block@archiver.kernel.org>; Tue, 14 Feb 2023 04:47:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229707AbjBNErr (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 13 Feb 2023 23:47:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229604AbjBNErp (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 13 Feb 2023 23:47:45 -0500
Received: from esa4.hgst.iphmx.com (esa4.hgst.iphmx.com [216.71.154.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95F8AE382
        for <linux-block@vger.kernel.org>; Mon, 13 Feb 2023 20:47:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1676350064; x=1707886064;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=bPrKthtri+NB2gPqV0Nok8p/xom0Dfj8aMpLUeYGGhI=;
  b=qx03HbBxmb6n4dvxTGkshYitvJmDdqnLwl0kMI4YUO5b6gGwkfuxaLTT
   kSWzHkHXMOV2H47SH24wiCElwVIX6JtdVQdyJr3iCXtddaeGkGVBI4vAl
   PRUyfJGqwhFApQtVtxEhNSJ93HlXxrIV9hD0xxOsDi/cCXx4S/qMx9I25
   1XG46kBC1H3BPgI2kc92auqRvXKanHcX5L11ZEBoGnYny4FvgXVkGqFFx
   Ucust+KRglxo5VkkMGXTWocq26e5Fyt/BFIQJd6ZZXa0l1CerWAgS+EsH
   DKhJuCF2uJHt2pfJKRUX4Nd/NlZsz4mz7LHYJ5OIQM1vF5tLZaQX3tg/D
   w==;
X-IronPort-AV: E=Sophos;i="5.97,294,1669046400"; 
   d="scan'208";a="221538218"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 14 Feb 2023 12:47:43 +0800
IronPort-SDR: LvW0XZpIINcNF0HWjWJ5V2tmN5P+KpQboDffPxVG5/WNCrUOuCH0ZwTz0rsseED9Npo1QMMSqa
 noL8VicXwBhMFR80UCXtablhExaWW0RKJpPeq0TG9w2miNkm3hP/T9WggWTrcy56gluHQZmUCq
 B/adGOxn2lsErkGebCXQRYpS+c25VOljymjHokWm4rpzeqx/loIhTUeRxf1O8WP+n3gZfc7VeV
 zNUn5KZsc+OoIZEcXO3yOWczGgu5SDMREMknio74ANpbOAkLu9+Gn0h6mfoW2aUpn//gByYTgE
 hi0=
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 13 Feb 2023 20:04:52 -0800
IronPort-SDR: w05zWcaTY4cKo0aB3CxHw1xTaU7GgRD2DWXNBz9ac5MSCfQR2Z1DHpvF8V0z/ptfj2Ppfxc0HS
 Plc32RL7cST9mjQ0m6LbXJjqCHbzVm+1ipHMr53bAfCrWRruqbdYK1LR7H4iuFMd06IrJixC/Q
 Q5j++so8J7Tfsevl/azwXc4hGGfdv3Z586ZApQWYpFm5el+F4R2hp/jdGfKVZFepFbjb2tpo7z
 5TfZVgu0VZVZR6nS4KfysJfg2oZycdelnDxQhSzCl9RfkA2hr7Qa8LVXejrPAnb4KVRvJHK0QM
 VvY=
WDCIronportException: Internal
Received: from shindev.dhcp.fujisawa.hgst.com (HELO shindev.fujisawa.hgst.com) ([10.149.52.207])
  by uls-op-cesaip01.wdc.com with ESMTP; 13 Feb 2023 20:47:44 -0800
From:   Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To:     linux-block@vger.kernel.org, linux-nvme@lists.infradead.org,
        Kanchan Joshi <joshi.k@samsung.com>
Cc:     Christoph Hellwig <hch@lst.de>,
        Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Subject: [PATCH blktests v2 2/2] nvme/046: add test for unprivileged passthrough
Date:   Tue, 14 Feb 2023 13:47:39 +0900
Message-Id: <20230214044739.1903364-3-shinichiro.kawasaki@wdc.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20230214044739.1903364-1-shinichiro.kawasaki@wdc.com>
References: <20230214044739.1903364-1-shinichiro.kawasaki@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

From: Kanchan Joshi <joshi.k@samsung.com>

Alters permissions for char-device node (/dev/ngX) and runs few
passthrough commands as a normal user to exercise nvme_cmd_allowed().

Signed-off-by: Kanchan Joshi <joshi.k@samsung.com>
[Shin'ichiro: adjusted to normal user helper functions]
Signed-off-by: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
---
 tests/nvme/046     | 50 ++++++++++++++++++++++++++++++++++++++++++++++
 tests/nvme/046.out |  2 ++
 2 files changed, 52 insertions(+)
 create mode 100644 tests/nvme/046
 create mode 100644 tests/nvme/046.out

diff --git a/tests/nvme/046 b/tests/nvme/046
new file mode 100644
index 0000000..5689a2b
--- /dev/null
+++ b/tests/nvme/046
@@ -0,0 +1,50 @@
+#!/bin/bash
+# SPDX-License-Identifier: GPL-3.0+
+# Copyright (C) 2023 Kanchan Joshi, Samsung Electronics
+# Test for unprivileged passthrough
+
+. tests/nvme/rc
+
+DESCRIPTION="basic test for unprivileged passthrough on /dev/ngX"
+QUICK=1
+
+requires() {
+	_nvme_requires
+	_require_normal_user
+}
+
+test_device() {
+	echo "Running ${TEST_NAME}"
+	local ngdev=${TEST_DEV/nvme/ng}
+	local perm nsid
+
+	perm="$(stat -c "%a" "$ngdev")"
+	nsid="$(_test_dev_nvme_nsid)"
+
+	chmod g+r,o+r "$ngdev"
+
+	if ! _run_user "nvme io-passthru ${ngdev} -o 2 -l 4096 \
+		-n $nsid -r" >> "${FULL}" 2>&1; then
+		echo "Error: io-passthru read failed"
+	fi
+
+	if _run_user "echo hello | nvme io-passthru ${ngdev} -o 1 -l 4096 \
+		-n $nsid -r" >> "${FULL}" 2>&1; then
+		echo "Error: io-passthru write passed (unexpected)"
+	fi
+
+	if ! _run_user "nvme id-ns ${ngdev}" >> "${FULL}" 2>&1; then
+		echo "Error: id-ns failed"
+	fi
+
+	if ! _run_user "nvme id-ctrl ${ngdev}" >> "${FULL}" 2>&1; then
+		echo "Error: id-ctrl failed"
+	fi
+
+	if _run_user "nvme ns-descs ${ngdev}" >> "${FULL}" 2>&1; then
+		echo "Error: ns-descs passed (unexpected)"
+	fi
+
+	echo "Test complete"
+	chmod "$perm" "$ngdev"
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
2.38.1


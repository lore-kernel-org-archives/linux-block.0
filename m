Return-Path: <SRS0=Iyu6=4D=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 218B3C3B1BF
	for <linux-block@archiver.kernel.org>; Sat, 15 Feb 2020 01:38:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EE12A2073A
	for <linux-block@archiver.kernel.org>; Sat, 15 Feb 2020 01:38:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="eqUkJCU9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727680AbgBOBik (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 14 Feb 2020 20:38:40 -0500
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:15619 "EHLO
        esa5.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727572AbgBOBik (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 14 Feb 2020 20:38:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1581730721; x=1613266721;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=5L38YCFHyNaTJJrUPZRKoSjD9YGnj5K8/s1glqKjrms=;
  b=eqUkJCU9brTjSXgwINqHmjU5ongADY8kw6gdxpNK0Yzc8I0/mYeePPCA
   gNGP4eXbnjAGbgsdvVqcAuJ0KIHy2fW7KOYVzVZRjljSA+PaXVgQLTULF
   BcjS+5VXgj8fw8cnTyP22wXNslZVF26QCgbcr/8m9+zNqymPPnKzAxrwD
   Xr/wK2r5+O9XnvTUxo9flt8iMfDuiNmC8v747HimxO3nMFNf6qX8dobCD
   /I1L5U8ibS0vFhpQ9JRYj1lC9iPjWeb+K67LkBhGv3VT+Yvl59YD40tdF
   d0K4MokEfECErtUzjUjv+wEroNIyhGFlb7e/7kZ0egZ6bSQMCDKWmKDlZ
   w==;
IronPort-SDR: q5ax0shiLVnwShsbQ5BfbRBwthuK++HMzP24qzGUPhDVYncSPnaTkkQEmc1xYF4SHzQvwIkkl7
 mXRoJagQ70xmyFWblWKHn6iPQYvw6Sb5u/uonzbYqxw3Oi9AaVMfU7dZtSaIt6HpXx0UzAAQnx
 eRvmkh6FlHRYhqAjmxOLN/MbldjNLMfM50i0gmtHbglXpX8VLD0ZZbkCjSuSBdVWF6FkuQ82Id
 zf5V1lgkcHz+Cl7zfTRvTmKNJZGec26Dg9on8cwTJ0ZBMBqjtNxHlQ/pcaQ4ly4gI5/sa42pJW
 cVQ=
X-IronPort-AV: E=Sophos;i="5.70,442,1574092800"; 
   d="scan'208";a="130431808"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 15 Feb 2020 09:38:41 +0800
IronPort-SDR: sleUPPdhQHzf3/pZX2y6Pc2Ele57xP2kWlMomX2IG+gg0zsZieZ8Q5xvPreHWm9MdOzxxZU6vi
 /3E0D7GwIjoGwZrovjt+55vF7BV5vd/it27X1zy05qAfwGHgmWuua8TBHwY5E56zr5r8Nk5xdo
 X/ITFoF0rkyXURVB9ZV9qJwwLemt49h8j2UVDiY/pIbM+phkh5lEN8i/l8+0P2tZ31UDFe+vP3
 gIyoGiF2fasdf/RB7Adwlxx3KMQ1zGUv0fMVjIt7lFiqpc+igOEEWvn0kLRc7RXV5QKIOLpJ8N
 dhDEfYmGS+VDxlxQsdNPbZ1t
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Feb 2020 17:31:24 -0800
IronPort-SDR: ddlkWu/OvFKpj3IaiZX2oNYEfsDFFydug6wgJKZkSuljNLr79ok5eouWq6JutStbefJSaycQjK
 mxEwZwOQPsiqg2tcLipcWX0kYMX9h7pJXvJNxU+r3JmXmQOgeIJ5vaEGeNz939b3QKYjht+SsL
 p59ldazokABtXMNfGXEOoqkC8MLkUu2QtOe4zfkxsBfcYNykU4c5P3iJZiyh+M3tV3bvDr0/Fm
 AiFM+5DC+5c+pSL+40KIBPRTo90A77y3ko67hg/fKhy+3lkK5qr0hRuCeFmYIvJpsd8bD6b/8I
 BMg=
WDCIronportException: Internal
Received: from iouring.labspan.wdc.com (HELO iouring.sc.wdc.com) ([10.6.138.107])
  by uls-op-cesaip01.wdc.com with ESMTP; 14 Feb 2020 17:38:39 -0800
From:   Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
To:     osandov@fb.com
Cc:     linux-block@vger.kernel.org, linux-nvme@lists.infradead.org,
        Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
Subject: [PATCH blktests V2 3/3] nvme: test target model attribute
Date:   Fri, 14 Feb 2020 17:38:31 -0800
Message-Id: <20200215013831.6715-4-chaitanya.kulkarni@wdc.com>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20200215013831.6715-1-chaitanya.kulkarni@wdc.com>
References: <20200215013831.6715-1-chaitanya.kulkarni@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

The new testcases exercises newly added model attribute for
NVMeOF target.

Signed-off-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
---
 tests/nvme/034     | 64 ++++++++++++++++++++++++++++++++++++++++++++++
 tests/nvme/034.out |  3 +++
 2 files changed, 67 insertions(+)
 create mode 100755 tests/nvme/034
 create mode 100644 tests/nvme/034.out

diff --git a/tests/nvme/034 b/tests/nvme/034
new file mode 100755
index 0000000..0e51a62
--- /dev/null
+++ b/tests/nvme/034
@@ -0,0 +1,64 @@
+#!/bin/bash
+# SPDX-License-Identifier: GPL-2.0+
+# Copyright (c) 2017-2018 Western Digital Corporation or its affiliates.
+#
+# Test NVMeOF target model attributes.
+
+. tests/nvme/rc
+
+DESCRIPTION="Test NVMeOF target model attribute"
+QUICK=1
+
+PORT=""
+NVMEDEV=""
+LOOP_DEV=""
+MODEL="test~model"
+FILE_PATH="$TMPDIR/img"
+SUBSYS_NAME="blktests-subsystem-1"
+
+_have_model()
+
+{
+	_setup_nvmet
+	truncate -s 1G "${FILE_PATH}"
+	LOOP_DEV="$(losetup -f --show "${FILE_PATH}")"
+
+	# we can only know skip reason when we create a subsys
+	 _create_nvmet_subsystem "${SUBSYS_NAME}" "${LOOP_DEV}" \
+		"91fdba0d-f87b-4c25-b80f-db7be1418b9e" 14 15 \
+		${MODEL}
+}
+
+requires() {
+	_have_program nvme && _have_modules loop nvme-loop nvmet && \
+		_have_configfs && _have_model
+}
+
+test() {
+	echo "Running ${TEST_NAME}"
+
+	PORT="$(_create_nvmet_port "loop")"
+	_add_nvmet_subsys_to_port "${PORT}" "${SUBSYS_NAME}"
+
+	nvme connect -t loop -n "${SUBSYS_NAME}"
+
+	udevadm settle
+
+	NVMEDEV="$(_find_nvme_loop_dev)"
+	nvme list | grep "${NVMEDEV}"n1 | grep -q "${MODEL}"
+	result=$?
+
+	nvme disconnect -n "${SUBSYS_NAME}"
+
+	_remove_nvmet_subsystem_from_port "${PORT}" "${SUBSYS_NAME}"
+	_remove_nvmet_subsystem "${SUBSYS_NAME}"
+	_remove_nvmet_port "${PORT}"
+
+	losetup -d "${LOOP_DEV}"
+
+	rm "${FILE_PATH}"
+
+	if [ ${result} -eq 0 ]; then
+		echo "Test complete"
+	fi
+}
diff --git a/tests/nvme/034.out b/tests/nvme/034.out
new file mode 100644
index 0000000..0a7bd2f
--- /dev/null
+++ b/tests/nvme/034.out
@@ -0,0 +1,3 @@
+Running nvme/034
+NQN:blktests-subsystem-1 disconnected 1 controller(s)
+Test complete
-- 
2.22.1


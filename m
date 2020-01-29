Return-Path: <SRS0=SUnH=3S=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F8A6C35240
	for <linux-block@archiver.kernel.org>; Wed, 29 Jan 2020 23:29:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2438F206D5
	for <linux-block@archiver.kernel.org>; Wed, 29 Jan 2020 23:29:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="Kh97kVwz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726671AbgA2X3d (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 29 Jan 2020 18:29:33 -0500
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:24315 "EHLO
        esa4.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726401AbgA2X3d (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 29 Jan 2020 18:29:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1580340573; x=1611876573;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=KXZsNyr6H+GgS1XHW+oCnKz+5nhllTOXchAqtu9WpTE=;
  b=Kh97kVwzi1uYcTgpoKHnr7c0htZXkKIl9FPJy8FrFo+aagNY8Liq7Cpj
   pecq//5ZTmQEKBqZWC4P5OFzDJaArte/X9t47QyhBDY6FqMKfs8oaXTzA
   argcrk8/xPkGTf/fxHkNzQMUlEwsMVix4e9Fh9vhtbnGqydiYouqQ9Pe6
   77fj7FJA4/mylQKaiUT2SvRR/iKjz+fBPJXxQX0aGg3mg+d/t7Vld9c7I
   zIyvmAfPgOCzsWdeuD3KhQG6aFPljBIpUIpQ9aCm97AmK9Z9JfbCMz+wl
   yoqPytaJPsUtP7lZaLBRU/sdqsxt4Md7mox1UYhecrwGJ+vRBrsfMTME3
   A==;
IronPort-SDR: 9edk02KLuF3RvpSiUt+XhdS/l5YS6K62oKEFOwd5dBm6CYkynnfkaVeqzOxD3HDo5vWOKT/8XK
 hR3h1OYVrAm5Zf34f3HHwMYfmDLM1mgK81gW3LrkVIwwIGemFLd+TZmBO/z5RJ5du3s3R2WS22
 bvJYxC1bg5YKhuSti1R/H20PUAmYDjWO8l7IpGBfv4MpNaQpGHXfylIhGsCSX3o+RDQ5J/+/H/
 XZxuTgeVJ0y8BBK3RgWmxfLw61XCBd6XBPwgVGDePbpaJb4huSAkVPQkEGhUKfJvLBwzrPyWsl
 75c=
X-IronPort-AV: E=Sophos;i="5.70,379,1574092800"; 
   d="scan'208";a="128691698"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 30 Jan 2020 07:29:33 +0800
IronPort-SDR: PWP0xArGjb/+Z0g+3ZeYRtO/cujMsrU+iO7FZK7sMrHk2/glbi8Ad+FjOQmTwoRTLeoTpAuB5u
 Fd5JEfWOFSOOtoF29/4My62RWkA/aLO+nw9zp7qNKiL+LV19+LFLIT1kpuhQ7UHsisdfZVfgRI
 34M/c7QspnD1JwyYrqI9bW+fIlKzayJZTWjTfOY7A2JfJn5zPTJt6fcbinW+pcrtf1ntfcY0nO
 R4od+Dyj0fYoY9sFbFJfYT+EXx9NNE7HapJbZkDp4u3pKwuZ+2+4JHk73d0Kmb4dUmO2xYVF8I
 wsnt8MqLDCzYPRNPndIH8aVw
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jan 2020 15:22:45 -0800
IronPort-SDR: +Fg+K68EUDIVpRmHuf0S6I/mwkBrljSa5T8RJpGzPLemxJPtQ/eeT8+hdmj4s+TO3xbMtWLijM
 0ekH1rT2WIJVZIWUdEXtuyVBgX8kWvdTvYQfu6gfHd7NdUcfXFyhcRc/yBeThlvZZ6OWpEskP4
 lLansx0+vPIlNRiZS4Ll8SVWnjK0oJHzeA00YLWiJobtD3ARFxI3ym+kve1ge4Lg9A4ZwhH2zb
 Kbqocnda3m/2FW2Dvn6tToxTDfrJmVgBji2cgsEilRzxn54CIUVm9mKvrsMkVYGuW0LGwmwaH1
 EDI=
WDCIronportException: Internal
Received: from iouring.labspan.wdc.com (HELO iouring.sc.wdc.com) ([10.6.138.107])
  by uls-op-cesaip01.wdc.com with ESMTP; 29 Jan 2020 15:29:33 -0800
From:   Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
To:     linux-block@vger.kernel.org, linux-nvme@lists.infradead.org
Cc:     Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
Subject: [PATCH 4/5 blktests] nvme: test target model attribute
Date:   Wed, 29 Jan 2020 15:29:20 -0800
Message-Id: <20200129232921.11771-5-chaitanya.kulkarni@wdc.com>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20200129232921.11771-1-chaitanya.kulkarni@wdc.com>
References: <20200129232921.11771-1-chaitanya.kulkarni@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

The new testcases exercises newly added cntlid [min|max] attribute for
NVMeOF target.

Signed-off-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
---
 tests/nvme/034     | 60 ++++++++++++++++++++++++++++++++++++++++++++++
 tests/nvme/034.out |  3 +++
 2 files changed, 63 insertions(+)
 create mode 100755 tests/nvme/034
 create mode 100644 tests/nvme/034.out

diff --git a/tests/nvme/034 b/tests/nvme/034
new file mode 100755
index 0000000..1a55ff9
--- /dev/null
+++ b/tests/nvme/034
@@ -0,0 +1,60 @@
+#!/bin/bash
+# SPDX-License-Identifier: GPL-2.0+
+# Copyright (c) 2017-2018 Western Digital Corporation or its affiliates.
+#
+# Test NVMeOF target cntlid[min|max] attributes.
+
+. tests/nvme/rc
+
+DESCRIPTION="Test NVMeOF target model attribute"
+QUICK=1
+
+requires() {
+	_have_program nvme && _have_modules loop nvme-loop nvmet && \
+		_have_configfs
+}
+
+test() {
+	echo "Running ${TEST_NAME}"
+
+	_setup_nvmet
+
+	local port
+	local result
+	local nvmedev
+	local loop_dev
+	local model="test~model"
+	local file_path="$TMPDIR/img"
+	local subsys_name="blktests-subsystem-1"
+
+	truncate -s 1G "${file_path}"
+
+	loop_dev="$(losetup -f --show "${file_path}")"
+
+	_create_nvmet_subsystem "${subsys_name}" "${loop_dev}" \
+		"91fdba0d-f87b-4c25-b80f-db7be1418b9e" 0 100 ${model}
+	port="$(_create_nvmet_port "loop")"
+	_add_nvmet_subsys_to_port "${port}" "${subsys_name}"
+
+	nvme connect -t loop -n "${subsys_name}"
+
+	udevadm settle
+
+	nvmedev="$(_find_nvme_loop_dev)"
+	nvme list | grep ${nvmedev}n1 | grep -q test~model
+	result=$?
+
+	nvme disconnect -n "${subsys_name}"
+
+	_remove_nvmet_subsystem_from_port "${port}" "${subsys_name}"
+	_remove_nvmet_subsystem "${subsys_name}"
+	_remove_nvmet_port "${port}"
+
+	losetup -d "${loop_dev}"
+
+	rm "${file_path}"
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


Return-Path: <SRS0=Iyu6=4D=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2F3FC35242
	for <linux-block@archiver.kernel.org>; Sat, 15 Feb 2020 01:38:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A94F9207FF
	for <linux-block@archiver.kernel.org>; Sat, 15 Feb 2020 01:38:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="QgSChhn9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727641AbgBOBij (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 14 Feb 2020 20:38:39 -0500
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:15619 "EHLO
        esa5.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727572AbgBOBij (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 14 Feb 2020 20:38:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1581730720; x=1613266720;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=PVVWGcIQHoA1Y15S9BkGYIyI5ZJjziivksjUZDcIiq4=;
  b=QgSChhn90Cm9cfTwFhMfwjqKDnm4bv23g5dps5/hil3ATc5ZJ6OM1bqA
   F/rG0RVGURm0JlL67MKnjc3ckNHcdjWIOViydozLpMAWxojqFdccwqEfp
   xpiAf+xf/k2zjCJVMeEJ+l0RZQb7ZOOH69/sTmN7XBtHOyTnLaAPkEUEf
   GgYtk2SN2EI+aSS7muB4n7+5y3J323Te8wwNa7Q6CJtHQ8dTLb+Dn8ivP
   xHsJJJ6mxeMajUxqASkdpT9WYuwoWohswp5vNO80N7vC3gkoirK4jMpLZ
   F8zNEnrrADZXYH5TLuYuwHw8oEOXWm6CDfuZ2b71C5Y7l/OIxT9a2dDfs
   A==;
IronPort-SDR: 8cViXBQBJ/c4hcrXXtfQuEegPxLJ8FkKtFoM/5xhRKWSwPCS30L445TpnoLUGz7Ems3WrGym9r
 0J3/niJHHRN5PY1EeujfE5iTchLFnOvv7ZrPh+58JYZ8ZlF9mpMd4/fag6vD13APrVwPURes2D
 riTpl5ABbVAfZW58VSIEDBbkuvgD62VMfoILQ04QdwuLnYdd2e0wJqxOsflRS9eim9WyYAXyh9
 roX/hovC+9FwYvltr6vxExZkuO1aUIv6eBNjvJ9xjAtlrXEKWcOBQeyiM6sGqNCt3WqZoukTN6
 /ZA=
X-IronPort-AV: E=Sophos;i="5.70,442,1574092800"; 
   d="scan'208";a="130431807"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 15 Feb 2020 09:38:39 +0800
IronPort-SDR: ksbNvR1/IacZ1RLC+gOq15oXq9hD2Uequn+lVkPzm4+wP0WUk9GKOeY7hfhMkvPENeK798j2hp
 EaI5C78VqIerDw6OPca6F7K+4DbzC3kdSG7px+aOTyyd7JTVqv68ARsV1MkSbjLSt/+TeEqHpY
 UJC5kQ1044BbZ18nZG65ttd7MSqRlXdTtcJD1CGAxKDRNB58FU6Xr9NUS1Tr1NF2w9Mp6FsaNA
 KGdgvmllrXh52F499vATgLv4g+TDWGMG1JrNBY+YA/lSVmxbvwXgbc3k8uEnwQR/8j/08oO8pr
 b+4SFGU9Hl89JYq21dwTT3Cc
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Feb 2020 17:31:23 -0800
IronPort-SDR: S28rkRdp/fHt66j4ARdXmJ9N3zErjASd2Ogir+OINWiXB52XMzv4bBfrIJwrnB+fuDjOUBQxF9
 qgoNys/vi4xbs8F9YOn25v5OYKJgd6rlFB2Y426YMyX9AusvEhsZQES47tTRwh6O7xqjafHDR0
 zMtlyhKjvUSfCB9UEd0dciLyqeNNE5r1nZF0YbRdbPnalt33k5af6s+59hkP+xD+gTNI1DBlqz
 68FXTl3QHtpFT513vra0NATLlitUtymLvCteneegwDAhstZmW1nWl3Hfwe5UcWYQ7olGQuIDkA
 HKg=
WDCIronportException: Internal
Received: from iouring.labspan.wdc.com (HELO iouring.sc.wdc.com) ([10.6.138.107])
  by uls-op-cesaip01.wdc.com with ESMTP; 14 Feb 2020 17:38:37 -0800
From:   Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
To:     osandov@fb.com
Cc:     linux-block@vger.kernel.org, linux-nvme@lists.infradead.org,
        Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
Subject: [PATCH blktests V2 2/3] nvme: test target cntlid min cntlid max
Date:   Fri, 14 Feb 2020 17:38:30 -0800
Message-Id: <20200215013831.6715-3-chaitanya.kulkarni@wdc.com>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20200215013831.6715-1-chaitanya.kulkarni@wdc.com>
References: <20200215013831.6715-1-chaitanya.kulkarni@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

The new testcases exercises newly added cntlid [min|max] attributes
for NVMeOF target.

Signed-off-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
---
 tests/nvme/033     | 61 ++++++++++++++++++++++++++++++++++++++++++++++
 tests/nvme/033.out |  4 +++
 2 files changed, 65 insertions(+)
 create mode 100755 tests/nvme/033
 create mode 100644 tests/nvme/033.out

diff --git a/tests/nvme/033 b/tests/nvme/033
new file mode 100755
index 0000000..49f2fa1
--- /dev/null
+++ b/tests/nvme/033
@@ -0,0 +1,61 @@
+#!/bin/bash
+# SPDX-License-Identifier: GPL-2.0+
+# Copyright (c) 2017-2018 Western Digital Corporation or its affiliates.
+#
+# Test NVMeOF target cntlid[min|max] attributes.
+
+. tests/nvme/rc
+
+DESCRIPTION="Test NVMeOF target cntlid[min|max] attributes"
+QUICK=1
+
+PORT=""
+NVMEDEV=""
+LOOP_DEV=""
+FILE_PATH="$TMPDIR/img"
+SUBSYS_NAME="blktests-subsystem-1"
+
+_have_cid_min_max()
+{
+	local cid_min=14
+	local cid_max=15
+
+	_setup_nvmet
+	truncate -s 1G "${FILE_PATH}"
+	LOOP_DEV="$(losetup -f --show "${FILE_PATH}")"
+
+	# we can only know skip reason when we create a subsys
+	 _create_nvmet_subsystem "${SUBSYS_NAME}" "${LOOP_DEV}" \
+		"91fdba0d-f87b-4c25-b80f-db7be1418b9e" ${cid_min} ${cid_max}
+}
+
+requires() {
+	_have_program nvme && _have_modules loop nvme-loop nvmet && \
+		_have_configfs && _have_cid_min_max
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
+	nvme id-ctrl /dev/"${NVMEDEV}"n1 | grep cntlid | tr -s ' ' ' '
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
+	echo "Test complete"
+}
diff --git a/tests/nvme/033.out b/tests/nvme/033.out
new file mode 100644
index 0000000..b1b0d15
--- /dev/null
+++ b/tests/nvme/033.out
@@ -0,0 +1,4 @@
+Running nvme/033
+cntlid : e
+NQN:blktests-subsystem-1 disconnected 1 controller(s)
+Test complete
-- 
2.22.1


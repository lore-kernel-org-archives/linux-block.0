Return-Path: <SRS0=SUnH=3S=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65D7CC2D0DB
	for <linux-block@archiver.kernel.org>; Wed, 29 Jan 2020 23:29:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 382C7206D5
	for <linux-block@archiver.kernel.org>; Wed, 29 Jan 2020 23:29:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="MHsseLsw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726648AbgA2X3b (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 29 Jan 2020 18:29:31 -0500
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:24315 "EHLO
        esa4.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726401AbgA2X3b (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 29 Jan 2020 18:29:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1580340570; x=1611876570;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=6LRKDrLJNKRzqs49kNk7BQqax8ZTUAptPqv9+XRu5GE=;
  b=MHsseLsw5+An9S8qK/yM/vwBlggPd+wjYls9/Yp9LE3HflWT7l6NES5G
   Ido40pjZlvqDqlV37NyjJbjqTtjNcHnKex8mGgMvMw8EGkz/VDT9bPqI3
   Y5rV+lACo07N+O2YO4FhB36VOIbX3I5wVcIb+XA1XOpeO2kQGOX1W6JIX
   tAUyogaytuOVf6OpEYirkp8rBdOeEWa1pUDDJctI/9M6EMdaS9Zw2Eg0R
   B0m9sfczgHtzKxHM3etlqt0Ys0vqwTWMAbA80Kd38Xhx0C+7x22FDhZuK
   KEzWp9NuYFIjvsV3ufoLDEUbahVj9jZ7xYjvBcbouWzzVY6Fm/fObQmt0
   g==;
IronPort-SDR: 2tHyWaDHTymBqbaIuDQl3WsD4KfbJ13C4IQMBBlLYu/H/AtxhnPMRBMlmIHz/kx+dznrkfJqVl
 FzoxawJfIEJbGDi8F4jpfW+85ARaRvvs8EvJSIJjc6lkOJUMMRzdOm0qEa8U7phyN6f5Cg7puC
 IhNzkIhUNEJtYovpdo5TJDZr6dei82TrHH6+6Eobgib93kGFZWUu0tqWPdB39yJpKXP9fChuFt
 aM1I1IEsaqVSBsuJZj3kNpU9oEZ+jI4FnjeagE1P4+GfJQTiDttG63pTuRGx2dBGPRMiumgTOM
 YZE=
X-IronPort-AV: E=Sophos;i="5.70,379,1574092800"; 
   d="scan'208";a="128691695"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 30 Jan 2020 07:29:30 +0800
IronPort-SDR: +ZJSIYi+YhtKSgKhcYz9uxf7n3R2MbEYaZYrO/SoVGQZy/JzFB1l67dCQqvzV5xYA2/Xf1tl4U
 SXDwa+EFQ8u53rcD95H596YtaCzJ1UwApzPSUOfpu0KqmgUOX1VKwdtA9jFjus9vaaq/zRv7Co
 rOumY0zfvVhlQy9mC961pQ9JOo/nL4CvakmBWgZaNc4HZUTB3LJBzQtmehhl6uWaZqVwDPR13+
 WD3RIV+g982iXpUMRarRPfF4kW/EtLkZSMaT+JeLVwZqiu7BVQ5cR3Z8UAUybBH2Lhb0XKudDR
 pOm8A3uwrt/BqtPm9No2ksoD
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jan 2020 15:22:42 -0800
IronPort-SDR: 7Z3ts7qElZgUF3XUm8Y4K1zcsg7VGjQAv3RDKP+yYNWNy1ls92mpDFadk5UBAQnqsp2I20viqf
 8KFbd85lKDbLjXPZDPxdOEEq2G0wZ4jTyWG0obrDldOTd/1CNleP7P7XViPlFqWvU+OyjgmVrc
 8RDYJY8Vrg8J0hR4gtxTtF+2zdE4gPVNRbrIkhi/VHgIMQJ/Vwgg/SN2mLNHZo7GR+KfMGYXsI
 OjeLHwIt7gRepdOjpeeDzCYPVjf3mjeVUIi61b/ILaWZzez9ECmVS17w/xZeOE4XMz4fNTdb9p
 MaI=
WDCIronportException: Internal
Received: from iouring.labspan.wdc.com (HELO iouring.sc.wdc.com) ([10.6.138.107])
  by uls-op-cesaip01.wdc.com with ESMTP; 29 Jan 2020 15:29:31 -0800
From:   Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
To:     linux-block@vger.kernel.org, linux-nvme@lists.infradead.org
Cc:     Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
Subject: [PATCH 2/5 blktests] nvme: test target cntlid min cntlid max
Date:   Wed, 29 Jan 2020 15:29:18 -0800
Message-Id: <20200129232921.11771-3-chaitanya.kulkarni@wdc.com>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20200129232921.11771-1-chaitanya.kulkarni@wdc.com>
References: <20200129232921.11771-1-chaitanya.kulkarni@wdc.com>
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
 tests/nvme/033     | 57 ++++++++++++++++++++++++++++++++++++++++++++++
 tests/nvme/033.out |  4 ++++
 2 files changed, 61 insertions(+)
 create mode 100755 tests/nvme/033
 create mode 100644 tests/nvme/033.out

diff --git a/tests/nvme/033 b/tests/nvme/033
new file mode 100755
index 0000000..97eba7f
--- /dev/null
+++ b/tests/nvme/033
@@ -0,0 +1,57 @@
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
+	local nvmedev
+	local loop_dev
+	local cid_min=14
+	local cid_max=15
+	local file_path="$TMPDIR/img"
+	local subsys_name="blktests-subsystem-1"
+
+	truncate -s 1G "${file_path}"
+
+	loop_dev="$(losetup -f --show "${file_path}")"
+
+	_create_nvmet_subsystem "${subsys_name}" "${loop_dev}" \
+		"91fdba0d-f87b-4c25-b80f-db7be1418b9e" ${cid_min} ${cid_max}
+	port="$(_create_nvmet_port "loop")"
+	_add_nvmet_subsys_to_port "${port}" "${subsys_name}"
+
+	nvme connect -t loop -n "${subsys_name}"
+
+	udevadm settle
+
+	nvmedev="$(_find_nvme_loop_dev)"
+	nvme id-ctrl /dev/${nvmedev}n1 | grep cntlid | tr -s ' ' ' '
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


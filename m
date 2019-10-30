Return-Path: <SRS0=yN0i=YX=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47E63CA9EC6
	for <linux-block@archiver.kernel.org>; Wed, 30 Oct 2019 19:53:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1827F2080F
	for <linux-block@archiver.kernel.org>; Wed, 30 Oct 2019 19:53:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="JxFhfnCI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726377AbfJ3TxG (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 30 Oct 2019 15:53:06 -0400
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:25749 "EHLO
        esa3.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726269AbfJ3TxG (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 30 Oct 2019 15:53:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1572465186; x=1604001186;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=xxB8ONVZT3rpIcghMpkObANMXcuVWQBdbOCLaXtbr1I=;
  b=JxFhfnCIhqxlFXRZAz9hyw/2PADQD66fi2rvfiCeZdcHjecr4CM2o56B
   WhaglzFGYO8WCYjiiUjtJA7mCZyH2HXr5wWMXX9S3VQ0U6zkW5Cp4z1Km
   eZDq5O60YuYp8joMqvwcv9nKnXV/MCXnuOWc7yuDAHVbZ1Fjvf3sgX2Va
   TBBHnC+DpS+wBaFermDNi5YaBhNctI8XjikCWWgrXDplCPVUoad4nfULs
   Y1xNuhniSJIp0B3gayL+OKPNcgdrAU7VlplYgyC2flXOASTcZK3+ud03b
   NlpnrfAv2hl6DdRizrW4JZDWOLm7KrovxzhgEeeRYPIP93Vlkmb3LKH5F
   g==;
IronPort-SDR: gzpuZ1ChTqss8rRdi6yo4YvLUntV/Jq1McPyS3go2iQbwIzKh/bpIQybzauTmTbd4Uhzztuo07
 JFbhLX4hPehssxVBLeg/3IDjIlGOsvaqpZ3S5lF2eJvXk0wDNO9bVjTq7s9loOoZ9rHHcqKF8i
 nIF+i3Zurv6Uo8arO5uji/HHCgkupe/M5utOeBIxqBc84PTbv6f9YHClE6HKrXBwhdv+BYiIM5
 qR2jpO78iu8cnIEYTyD+7Fy8dHNTl8XEDDp21AGf7u6Z4svyXEYkXCL10v3Zc/tRo1eWCGMXWD
 0dA=
X-IronPort-AV: E=Sophos;i="5.68,248,1569254400"; 
   d="scan'208";a="126145675"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 31 Oct 2019 03:53:06 +0800
IronPort-SDR: zAs91kX4dButYVBE80Ut/hZCoC18+FLTMwZTjlTJHpdHykOYUOE/eaTUMOxoZp9fSX7LI6j6G5
 wJiEmqFkoo5s5qpe1Xw1eWcIHzKWV1bm9BCYnrdsNIjZFAVRrsELOgY5MgQoh/kcK0/Axl57Nd
 ziyt4nyEQ1JrSHYEaMIFvss2sccH/B2GxhXkK0y6sDKnVzk+4Dgk6KkxtHdQDLRCidiATA58Qv
 o7rzutb21cyfVlPHZwB9NtwwyXDRu0adrDOIIN/6EDw5Mh+2k5lJmtq/sGLs6bUb0XRxHa4/oK
 JUZUsWXV50ATFaCCbk2nezy+
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Oct 2019 12:48:28 -0700
IronPort-SDR: GXvbH9Em6dJjDgNe6Ub/OVEaXoNkdvc7w9xpN2Cp3umpxLOCn9pz0oSy7s6GUkq6pUor08D5j/
 JzvF8gEnMaBjU8HsP+xDvybKLrTyr8KeeETqNdCHCCFbI5NO/JEf1tGxTrZ4c7v1UJe8yMiXr/
 Wemw3Cg/SsllkFVUc87a4FhRem2ly1rb8hzhpnoKMru1DsEjbwLhbU1vrxQjFzKCa/0VJIMJjR
 9Firr6ts4Fkw0bkdeLTGNR24cqhiPfYZ64W9ijP8AIwTQJtRowc7h+MldvVXonpJBhtDEuuHCF
 Dp0=
WDCIronportException: Internal
Received: from cvenusqemu.hgst.com ([10.202.66.73])
  by uls-op-cesaip01.wdc.com with ESMTP; 30 Oct 2019 12:53:06 -0700
From:   Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
To:     linux-block@vger.kernel.org, linux-nvme@lists.infradead.org
Cc:     Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
Subject: [blktests PATCH 2/2] nvme: add new test to check model attribute
Date:   Wed, 30 Oct 2019 12:52:58 -0700
Message-Id: <20191030195258.31108-3-chaitanya.kulkarni@wdc.com>
X-Mailer: git-send-email 2.22.1
In-Reply-To: <20191030195258.31108-1-chaitanya.kulkarni@wdc.com>
References: <20191030195258.31108-1-chaitanya.kulkarni@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

This test allows us to dynamically set the subsys model attribute
and verify in the nvme list command output.
---
 tests/nvme/033     | 61 ++++++++++++++++++++++++++++++++++++++++++++++
 tests/nvme/033.out |  3 +++
 2 files changed, 64 insertions(+)
 create mode 100755 tests/nvme/033
 create mode 100644 tests/nvme/033.out

diff --git a/tests/nvme/033 b/tests/nvme/033
new file mode 100755
index 0000000..8ddadcf
--- /dev/null
+++ b/tests/nvme/033
@@ -0,0 +1,61 @@
+#!/bin/bash
+# SPDX-License-Identifier: GPL-2.0+
+# Copyright (c) 2017-2018 Western Digital Corporation or its affiliates.
+#
+# Test NVMeOF model attribute for subsys.
+
+. tests/nvme/rc
+
+DESCRIPTION="test added subsys model attribute"
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
+	local file_path="$TMPDIR/img"
+	local subsys_name="blktests-subsystem-1"
+
+	truncate -s 1G "${file_path}"
+
+	loop_dev="$(losetup -f --show "${file_path}")"
+
+	_create_nvmet_subsystem "${subsys_name}" "${loop_dev}" \
+		"91fdba0d-f87b-4c25-b80f-db7be1418b9e" "${subsys_name}"
+	port="$(_create_nvmet_port "loop")"
+	_add_nvmet_subsys_to_port "${port}" "${subsys_name}"
+
+	nvme connect -t loop -n "${subsys_name}"
+
+	nvme list | grep -v grep | grep -q "${subsys_name}"
+	ret=$?
+	
+	nvmedev="$(_find_nvme_loop_dev)"
+
+	udevadm settle
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
+	if [ ${ret} == 1 ]; then
+		echo "Test Fail"
+	else
+		echo "Test complete"
+	fi
+}
diff --git a/tests/nvme/033.out b/tests/nvme/033.out
new file mode 100644
index 0000000..eb508be
--- /dev/null
+++ b/tests/nvme/033.out
@@ -0,0 +1,3 @@
+Running nvme/033
+NQN:blktests-subsystem-1 disconnected 1 controller(s)
+Test complete
-- 
2.22.1


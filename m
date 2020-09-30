Return-Path: <SRS0=Yhvv=DH=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A116C4727E
	for <linux-block@archiver.kernel.org>; Wed, 30 Sep 2020 19:14:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 06A2920708
	for <linux-block@archiver.kernel.org>; Wed, 30 Sep 2020 19:14:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=deltatee.com header.i=@deltatee.com header.b="bwsWTfFj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729912AbgI3TOv (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 30 Sep 2020 15:14:51 -0400
Received: from ale.deltatee.com ([204.191.154.188]:37980 "EHLO
        ale.deltatee.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729872AbgI3TOu (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 30 Sep 2020 15:14:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=deltatee.com; s=20200525; h=Subject:Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=AypN6BiW5IZls5gXpg36zLOXH+Gz+gN2WSrQr0Ie4nM=; b=bwsWTfFjsUOMn+Fx8u+4+wJzNI
        27bEpULOOQr5ECY0uEppTVtEGqDngvKfBO5vavk0t/JhSdU0isc9dkF/0ZKVRu+EqyEDaNWyRQcYA
        iC4C2AWh4+lSLeA2bdSJj7483YBzS40fWK2goweEpLNwdfYNnFCqHFxW0qIuh2QZGlJr49wlkO9a6
        mnbIisuc2GKdh8UuBCAvbu6oC+I5eGTw1xTFLUZfdIJXMwoZh5hUXbWXfN3IGnBBy9mttGdxuifh9
        U39tPmZyHx+xlOLTqRfTsFc0UkATCPYtiUqpGxayewl2DLn8kRQyovCeXBLD3jtPNjhp8//vhmc9I
        ZVUFeQtA==;
Received: from cgy1-donard.priv.deltatee.com ([172.16.1.31])
        by ale.deltatee.com with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <gunthorp@deltatee.com>)
        id 1kNhFK-0000ux-OD; Wed, 30 Sep 2020 12:54:35 -0600
Received: from gunthorp by cgy1-donard.priv.deltatee.com with local (Exim 4.92)
        (envelope-from <gunthorp@deltatee.com>)
        id 1kNhFD-00030a-PW; Wed, 30 Sep 2020 12:54:27 -0600
From:   Logan Gunthorpe <logang@deltatee.com>
To:     linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org,
        linux-block@vger.kernel.org, Omar Sandoval <osandov@osandov.com>
Cc:     Sagi Grimberg <sagi@grimberg.me>,
        Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>,
        Stephen Bates <sbates@raithlin.com>,
        Logan Gunthorpe <logang@deltatee.com>
Date:   Wed, 30 Sep 2020 12:54:17 -0600
Message-Id: <20200930185422.11494-7-logang@deltatee.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200930185422.11494-1-logang@deltatee.com>
References: <20200930185422.11494-1-logang@deltatee.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 172.16.1.31
X-SA-Exim-Rcpt-To: linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org, linux-block@vger.kernel.org, osandov@osandov.com, sagi@grimberg.me, Chaitanya.Kulkarni@wdc.com, sbates@raithlin.com, logang@deltatee.com
X-SA-Exim-Mail-From: gunthorp@deltatee.com
Subject: [PATCH blktests v2 06/11] nvme/033: Simple test to create and connect to a passthru target
X-SA-Exim-Version: 4.2.1 (built Wed, 08 May 2019 21:11:16 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

This tests creates and connects to a passthru controller backed
by a test NVMe namespace. It then verifies that some common fields
in id-ctrl and id-ns are the same in the target and the orginial
device.

Signed-off-by: Logan Gunthorpe <logang@deltatee.com>
---
 tests/nvme/033     | 67 ++++++++++++++++++++++++++++++++++++++++++++++
 tests/nvme/033.out |  7 +++++
 2 files changed, 74 insertions(+)
 create mode 100755 tests/nvme/033
 create mode 100644 tests/nvme/033.out

diff --git a/tests/nvme/033 b/tests/nvme/033
new file mode 100755
index 000000000000..c6a3f7feb50e
--- /dev/null
+++ b/tests/nvme/033
@@ -0,0 +1,67 @@
+#!/bin/bash
+# SPDX-License-Identifier: GPL-3.0+
+# Copyright (C) 2019 Logan Gunthorpe
+# Copyright (C) 2019 Eideticom Communications Inc.
+
+. tests/nvme/rc
+
+DESCRIPTION="create and connect to an NVMeOF target with a passthru controller"
+QUICK=1
+
+requires() {
+	_nvme_requires
+	_have_kernel_option NVME_TARGET_PASSTHRU
+}
+
+nvme_info() {
+	local ns=$1
+
+	nvme id-ctrl "${ns}" | grep -E '^(vid|sn|mn|fr) '
+	nvme id-ns "${ns}" | grep -E '^(nsze|ncap) '
+}
+
+compare_dev_info() {
+	local passthru_dev=$1
+	local testdev_info
+	local passthru_info
+
+	testdev_info=$(nvme_info "${TEST_DEV}")
+	passthru_info=$(nvme_info "${passthru_dev}")
+
+	cat >> "${FULL}" <<- EOF
+
+	Test Device ${TEST_DEV} Info:
+	$testdev_info
+
+	Passthru Device ${passthru_dev} Info:
+	$passthru_info
+
+	EOF
+
+	diff -u <(echo "${testdev_info}") <(echo "${passthru_info}")
+	if [[ "${testdev_info}" != "${passthru_info}" ]]; then
+		echo "ERROR: Device information does not match! (See ${FULL})"
+	fi
+}
+
+test_device() {
+	local subsys="blktests-subsystem-1"
+	local nsdev
+	local port
+
+	echo "Running ${TEST_NAME}"
+
+	_setup_nvmet
+	port=$(_nvmet_passthru_target_setup "${subsys}")
+
+	_nvme_discover "${nvme_trtype}" | _filter_discovery
+
+	nsdev=$(_nvmet_passthru_target_connect "${nvme_trtype}" "${subsys}")
+
+	compare_dev_info "${nsdev}"
+
+	_nvme_disconnect_subsys "${subsys}"
+	_nvmet_passthru_target_cleanup "${port}" "${subsys}"
+
+	echo "Test complete"
+}
diff --git a/tests/nvme/033.out b/tests/nvme/033.out
new file mode 100644
index 000000000000..6f45a1d5ec1d
--- /dev/null
+++ b/tests/nvme/033.out
@@ -0,0 +1,7 @@
+Running nvme/033
+Discovery Log Number of Records 1, Generation counter X
+=====Discovery Log Entry 0======
+trtype:  loop
+subnqn:  blktests-subsystem-1
+NQN:blktests-subsystem-1 disconnected 1 controller(s)
+Test complete
-- 
2.20.1


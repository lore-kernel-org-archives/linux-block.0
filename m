Return-Path: <SRS0=Yhvv=DH=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72E0DC4741F
	for <linux-block@archiver.kernel.org>; Wed, 30 Sep 2020 19:14:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3E8AD20709
	for <linux-block@archiver.kernel.org>; Wed, 30 Sep 2020 19:14:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=deltatee.com header.i=@deltatee.com header.b="liTAEk7v"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729994AbgI3TO4 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 30 Sep 2020 15:14:56 -0400
Received: from ale.deltatee.com ([204.191.154.188]:37996 "EHLO
        ale.deltatee.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729992AbgI3TO4 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 30 Sep 2020 15:14:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=deltatee.com; s=20200525; h=Subject:Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=JVPaqWSpQ5haRzwQ/xrH0Kw+7eTy8s+uTMUVQHnv9sU=; b=liTAEk7vbHwbclVv0TjqEyGnfk
        IOE0oop9x89iqYHY77x9K3JVKe+CficHyMNtvyAUjfXybhaTMP3wv/nf+7vt0VKNxhx0vHMMvfW71
        sz1rOBHXrJnDzOtsEf3TTBC6JkF+SfoLRnOPJw4B4qZPG4SG+MY94Q5EKAk3jKOwR+zBS71sJ1m8U
        jjSeJnRVTfdPDQOlTHohEw+t+P1jWTnb4dYmGNJkYz7sj6JLpS8cg9DGa+FancyeJDwtpeHDqyBMq
        gFh9mw5tdabEBXdALBjpJMe2qmoPKOp0mMnFoJ+Et/MnNwwuuChRvcCYuSecvqA5gHKnwcS73vdiU
        o7/Uho+g==;
Received: from cgy1-donard.priv.deltatee.com ([172.16.1.31])
        by ale.deltatee.com with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <gunthorp@deltatee.com>)
        id 1kNhFI-0000v0-AJ; Wed, 30 Sep 2020 12:54:32 -0600
Received: from gunthorp by cgy1-donard.priv.deltatee.com with local (Exim 4.92)
        (envelope-from <gunthorp@deltatee.com>)
        id 1kNhFE-00030m-C9; Wed, 30 Sep 2020 12:54:28 -0600
From:   Logan Gunthorpe <logang@deltatee.com>
To:     linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org,
        linux-block@vger.kernel.org, Omar Sandoval <osandov@osandov.com>
Cc:     Sagi Grimberg <sagi@grimberg.me>,
        Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>,
        Stephen Bates <sbates@raithlin.com>,
        Logan Gunthorpe <logang@deltatee.com>
Date:   Wed, 30 Sep 2020 12:54:21 -0600
Message-Id: <20200930185422.11494-11-logang@deltatee.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200930185422.11494-1-logang@deltatee.com>
References: <20200930185422.11494-1-logang@deltatee.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 172.16.1.31
X-SA-Exim-Rcpt-To: linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org, linux-block@vger.kernel.org, osandov@osandov.com, sagi@grimberg.me, Chaitanya.Kulkarni@wdc.com, sbates@raithlin.com, logang@deltatee.com
X-SA-Exim-Mail-From: gunthorp@deltatee.com
Subject: [PATCH blktests v2 10/11] nvme/037: Add test which loops passthru connect and disconnect
X-SA-Exim-Version: 4.2.1 (built Wed, 08 May 2019 21:11:16 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Similar to test nvme/031 except for passthru controllers.

Note: it's normal to get I/O errors in this test as when the controller
disconnects it races with the partition table read.

Signed-off-by: Logan Gunthorpe <logang@deltatee.com>
---
 tests/nvme/037     | 35 +++++++++++++++++++++++++++++++++++
 tests/nvme/037.out |  2 ++
 2 files changed, 37 insertions(+)
 create mode 100755 tests/nvme/037
 create mode 100644 tests/nvme/037.out

diff --git a/tests/nvme/037 b/tests/nvme/037
new file mode 100755
index 000000000000..fc6c21343652
--- /dev/null
+++ b/tests/nvme/037
@@ -0,0 +1,35 @@
+#!/bin/bash
+# SPDX-License-Identifier: GPL-3.0+
+# Copyright (C) 2019 Logan Gunthorpe
+# Copyright (C) 2019 Eideticom Communications Inc.
+
+. tests/nvme/rc
+
+DESCRIPTION="test deletion of NVMeOF passthru controllers immediately after setup"
+
+requires() {
+	_nvme_requires
+	_have_kernel_option NVME_TARGET_PASSTHRU
+}
+
+test_device() {
+	local subsys="blktests-subsystem-"
+	local iterations=10
+	local ctrldev
+	local port
+
+	echo "Running ${TEST_NAME}"
+
+	_setup_nvmet
+
+	for ((i = 0; i < iterations; i++)); do
+		port=$(_nvmet_passthru_target_setup "${subsys}${i}")
+		nsdev=$(_nvmet_passthru_target_connect "${nvme_trtype}" \
+				"${subsys}${i}")
+
+		_nvme_disconnect_subsys "${subsys}${i}" >>"${FULL}" 2>&1
+		_nvmet_passthru_target_cleanup "${port}" "${subsys}${i}"
+	done
+
+	echo "Test complete"
+}
diff --git a/tests/nvme/037.out b/tests/nvme/037.out
new file mode 100644
index 000000000000..eaf903d0520e
--- /dev/null
+++ b/tests/nvme/037.out
@@ -0,0 +1,2 @@
+Running nvme/037
+Test complete
-- 
2.20.1


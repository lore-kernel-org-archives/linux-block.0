Return-Path: <SRS0=Yhvv=DH=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34CB9C4741F
	for <linux-block@archiver.kernel.org>; Wed, 30 Sep 2020 19:14:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D5E4620708
	for <linux-block@archiver.kernel.org>; Wed, 30 Sep 2020 19:14:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=deltatee.com header.i=@deltatee.com header.b="OUtQk0w6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729893AbgI3TOx (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 30 Sep 2020 15:14:53 -0400
Received: from ale.deltatee.com ([204.191.154.188]:37984 "EHLO
        ale.deltatee.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729936AbgI3TOw (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 30 Sep 2020 15:14:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=deltatee.com; s=20200525; h=Subject:Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=UpWM+yjj8ziy97ndQzgM2ZJFF0WlYfaYMS3RABD6FHI=; b=OUtQk0w6VLrF2XMMJhvoxhd58D
        WxJk162Ct6437Xt2MV9Vcsxa6lNuZtmreRU4E2BvOebfWncRcu2Tr9kAOCLgwFcws5mrc/bOVzDEJ
        ZsAw9ZDMgaUiJSLihuQSS2cKlW4HTOSryFYk1dDsZ6b5ogP3ubn/BOr/t18qaknYSSfW+a7onDZ6L
        35b4nga9qlsWzQArvALcnM3q+31UzrzH4Gx5wjboHLutCWdHzPo4IWCWylqVM/OiHyjHly1rnDAYD
        QLfjTKal6SD3IhKQjUK4PmFPML6PnF/XRoap2lzae+heRrxp7tY28ZRjGDq9XnK+aWCUXJlLY7pE7
        BAfuSLJw==;
Received: from cgy1-donard.priv.deltatee.com ([172.16.1.31])
        by ale.deltatee.com with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <gunthorp@deltatee.com>)
        id 1kNhFH-0000uy-Au; Wed, 30 Sep 2020 12:54:31 -0600
Received: from gunthorp by cgy1-donard.priv.deltatee.com with local (Exim 4.92)
        (envelope-from <gunthorp@deltatee.com>)
        id 1kNhFE-00030p-Hp; Wed, 30 Sep 2020 12:54:28 -0600
From:   Logan Gunthorpe <logang@deltatee.com>
To:     linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org,
        linux-block@vger.kernel.org, Omar Sandoval <osandov@osandov.com>
Cc:     Sagi Grimberg <sagi@grimberg.me>,
        Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>,
        Stephen Bates <sbates@raithlin.com>,
        Logan Gunthorpe <logang@deltatee.com>
Date:   Wed, 30 Sep 2020 12:54:22 -0600
Message-Id: <20200930185422.11494-12-logang@deltatee.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200930185422.11494-1-logang@deltatee.com>
References: <20200930185422.11494-1-logang@deltatee.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 172.16.1.31
X-SA-Exim-Rcpt-To: linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org, linux-block@vger.kernel.org, osandov@osandov.com, sagi@grimberg.me, Chaitanya.Kulkarni@wdc.com, sbates@raithlin.com, logang@deltatee.com
X-SA-Exim-Mail-From: gunthorp@deltatee.com
Subject: [PATCH blktests v2 11/11] nvme/038: Test removal of un-enabled subsystem and ports
X-SA-Exim-Version: 4.2.1 (built Wed, 08 May 2019 21:11:16 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Test that we can remove a subsystem that has not been enabled by
passthru or any ns. Do the same for ports while we are at it.

This was an issue in the original passthru patches and is
not commonly tested. So this test will ensure we don't regress this.

Signed-off-by: Logan Gunthorpe <logang@deltatee.com>
---
 tests/nvme/038     | 36 ++++++++++++++++++++++++++++++++++++
 tests/nvme/038.out |  2 ++
 2 files changed, 38 insertions(+)
 create mode 100755 tests/nvme/038
 create mode 100644 tests/nvme/038.out

diff --git a/tests/nvme/038 b/tests/nvme/038
new file mode 100755
index 000000000000..24f02d4ad4d1
--- /dev/null
+++ b/tests/nvme/038
@@ -0,0 +1,36 @@
+#!/bin/bash
+# SPDX-License-Identifier: GPL-3.0+
+# Copyright (C) 2019 Logan Gunthorpe
+# Copyright (C) 2019 Eideticom Communications Inc.
+#
+# Test that we can remove a subsystem that has not been enabled by
+# passthru or any ns. Do the same for ports while we are at it.
+#
+# This was an issue in the original passthru patches and is
+# not commonly tested. So this test will ensure we don't regress this.
+#
+. tests/nvme/rc
+
+DESCRIPTION="test deletion of NVMeOF subsystem without enabling"
+QUICK=1
+
+requires() {
+	_nvme_requires
+}
+
+test() {
+	local subsys_path="${NVMET_CFS}/subsystems/blktests-subsystem-1"
+	local port
+
+	echo "Running ${TEST_NAME}"
+
+	_setup_nvmet
+
+	mkdir -p "${subsys_path}"
+	rmdir "${subsys_path}"
+
+	port=$(_create_nvmet_port loop)
+	_remove_nvmet_port "${port}"
+
+	echo "Test complete"
+}
diff --git a/tests/nvme/038.out b/tests/nvme/038.out
new file mode 100644
index 000000000000..06bc98022c33
--- /dev/null
+++ b/tests/nvme/038.out
@@ -0,0 +1,2 @@
+Running nvme/038
+Test complete
-- 
2.20.1


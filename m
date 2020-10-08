Return-Path: <SRS0=cFNo=DP=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0828DC43457
	for <linux-block@archiver.kernel.org>; Thu,  8 Oct 2020 16:41:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BCB92221F1
	for <linux-block@archiver.kernel.org>; Thu,  8 Oct 2020 16:41:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=deltatee.com header.i=@deltatee.com header.b="k9K0ZAQ9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731063AbgJHQlC (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 8 Oct 2020 12:41:02 -0400
Received: from ale.deltatee.com ([204.191.154.188]:48832 "EHLO
        ale.deltatee.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726766AbgJHQkg (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 8 Oct 2020 12:40:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=deltatee.com; s=20200525; h=Subject:Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=UpWM+yjj8ziy97ndQzgM2ZJFF0WlYfaYMS3RABD6FHI=; b=k9K0ZAQ9vDNCok9vpYAJxhT37P
        yzreEWuuUDUvoJ42mR7dcucehon2sEsbg1taS1OcKjUEU7xIf0m9zPMwpm2qNZrtpxw1YZr7jT2rE
        dfCEr+lbV/VCGFokf/qR2k6keWvjYeuzex56fd7vGg6AinuUJK6WYdP7TVdM68GWunj/kwD2TWKgQ
        bTLuRY/1fAlUM5S8b+vb8YAPLyk6ctCKZFW52bNMBNhPSe1jvrVAB3KYBD0u9wcUT/YwE2VMJVGS/
        s/sHbrRSW8hqxZdK9IiAcY9UamCuSRCxPfCtnVOvHOVZMJCRJG6uFucVGE7DR8RNlAg1Clj77IyuP
        Q5dRoUXw==;
Received: from cgy1-donard.priv.deltatee.com ([172.16.1.31])
        by ale.deltatee.com with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <gunthorp@deltatee.com>)
        id 1kQYy2-0000ij-Hw; Thu, 08 Oct 2020 10:40:35 -0600
Received: from gunthorp by cgy1-donard.priv.deltatee.com with local (Exim 4.92)
        (envelope-from <gunthorp@deltatee.com>)
        id 1kQYy0-0003Hm-60; Thu, 08 Oct 2020 10:40:32 -0600
From:   Logan Gunthorpe <logang@deltatee.com>
To:     linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org,
        linux-block@vger.kernel.org, Omar Sandoval <osandov@osandov.com>
Cc:     Sagi Grimberg <sagi@grimberg.me>,
        Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>,
        Stephen Bates <sbates@raithlin.com>,
        Logan Gunthorpe <logang@deltatee.com>
Date:   Thu,  8 Oct 2020 10:40:24 -0600
Message-Id: <20201008164024.12546-12-logang@deltatee.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20201008164024.12546-1-logang@deltatee.com>
References: <20201008164024.12546-1-logang@deltatee.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 172.16.1.31
X-SA-Exim-Rcpt-To: linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org, linux-block@vger.kernel.org, osandov@osandov.com, sagi@grimberg.me, Chaitanya.Kulkarni@wdc.com, sbates@raithlin.com, logang@deltatee.com
X-SA-Exim-Mail-From: gunthorp@deltatee.com
Subject: [PATCH blktests v3 11/11] nvme/038: Test removal of un-enabled subsystem and ports
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


Return-Path: <SRS0=E5Vf=CF=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05715C433DF
	for <linux-block@archiver.kernel.org>; Thu, 27 Aug 2020 19:49:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DBF9E207DF
	for <linux-block@archiver.kernel.org>; Thu, 27 Aug 2020 19:49:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=deltatee.com header.i=@deltatee.com header.b="YipRMnxn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727998AbgH0TtZ (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 27 Aug 2020 15:49:25 -0400
Received: from ale.deltatee.com ([204.191.154.188]:54846 "EHLO
        ale.deltatee.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727959AbgH0TtU (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 27 Aug 2020 15:49:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=deltatee.com; s=20200525; h=Subject:Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=owdyuiWAgXc6gdvBmGEQOP1nWrWeXBypwNyTeAJ08TI=; b=YipRMnxnITFKCqPDBjApUgdO5+
        yM3bLUvqNFat+qH3HqA+0vYgkf0N7WdBxM7n4ewVigc6haI5kQeb1dNam4LLzeBJDu4qHO9aauXMr
        na6EbGcNRCKZB/MgZ5C05y6oumVucvFGV0Q7c4JCDQJtsV9PPKso3pK0vAQaTbyuiwmTmBpUmmGLz
        r21ufakconhB1sC2ULVf5r25jCoIw7gQpTooKluTALjIUai0eb3axFwtPUg9cxiqZVwqNJz1CK4Mo
        Lmo6h2+HH0ZXof2dwX5cVILswiPiAG3cIR6XiABsLtJl8G/A/oyPlIsWSPB31QpuOj7dIGeFCmRNE
        e2OUXvXA==;
Received: from cgy1-donard.priv.deltatee.com ([172.16.1.31])
        by ale.deltatee.com with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <gunthorp@deltatee.com>)
        id 1kBNte-0000Cg-Os; Thu, 27 Aug 2020 13:49:19 -0600
Received: from gunthorp by cgy1-donard.priv.deltatee.com with local (Exim 4.92)
        (envelope-from <gunthorp@deltatee.com>)
        id 1kBNta-0001cE-HP; Thu, 27 Aug 2020 13:49:14 -0600
From:   Logan Gunthorpe <logang@deltatee.com>
To:     linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org,
        linux-block@vger.kernel.org, Omar Sandoval <osandov@osandov.com>
Cc:     Sagi Grimberg <sagi@grimberg.me>,
        Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>,
        Stephen Bates <sbates@raithlin.com>,
        Logan Gunthorpe <logang@deltatee.com>
Date:   Thu, 27 Aug 2020 13:49:09 -0600
Message-Id: <20200827194912.6135-9-logang@deltatee.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200827194912.6135-1-logang@deltatee.com>
References: <20200827194912.6135-1-logang@deltatee.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 172.16.1.31
X-SA-Exim-Rcpt-To: linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org, linux-block@vger.kernel.org, osandov@osandov.com, sagi@grimberg.me, Chaitanya.Kulkarni@wdc.com, sbates@raithlin.com, logang@deltatee.com
X-SA-Exim-Mail-From: gunthorp@deltatee.com
Subject: [PATCH blktests 08/11] nvme/035: Add test to verify passthru controller with a filesystem
X-SA-Exim-Version: 4.2.1 (built Wed, 08 May 2019 21:11:16 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

This is a similar test as nvme/012 and nvme/013, except with a
passthru controller.

Signed-off-by: Logan Gunthorpe <logang@deltatee.com>
---
 tests/nvme/035     | 39 +++++++++++++++++++++++++++++++++++++++
 tests/nvme/035.out |  2 ++
 2 files changed, 41 insertions(+)
 create mode 100755 tests/nvme/035
 create mode 100644 tests/nvme/035.out

diff --git a/tests/nvme/035 b/tests/nvme/035
new file mode 100755
index 000000000000..de5f57c9b95f
--- /dev/null
+++ b/tests/nvme/035
@@ -0,0 +1,39 @@
+#!/bin/bash
+# SPDX-License-Identifier: GPL-3.0+
+# Copyright (C) 2019 Logan Gunthorpe
+# Copyright (C) 2019 Eideticom Communications Inc.
+
+. tests/nvme/rc
+. common/xfs
+
+DESCRIPTION="run mkfs and data verification fio job on an NVMeOF passthru controller"
+TIMED=1
+
+requires() {
+	_have_program nvme &&
+	_have_modules nvme-loop nvmet &&
+	_have_configfs &&
+	_have_kernel_option NVME_TARGET_PASSTHRU &&
+	_have_xfs &&
+	_have_fio
+}
+
+test_device() {
+	local subsys="blktests-subsystem-1"
+	local ctrldev
+	local nsdev
+	local port
+
+	echo "Running ${TEST_NAME}"
+
+	_setup_nvmet
+	port=$(_nvmet_passthru_target_setup "$subsys")
+	nsdev=$(_nvmet_passthru_target_connect "$subsys")
+
+	_xfs_run_fio_verify_io "${nsdev}"
+
+	_nvmet_passthru_target_disconnect "$subsys"
+	_nvmet_passthru_target_cleanup "$port" "$subsys"
+
+	echo "Test complete"
+}
diff --git a/tests/nvme/035.out b/tests/nvme/035.out
new file mode 100644
index 000000000000..455110c046a5
--- /dev/null
+++ b/tests/nvme/035.out
@@ -0,0 +1,2 @@
+Running nvme/035
+Test complete
-- 
2.20.1


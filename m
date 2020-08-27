Return-Path: <SRS0=E5Vf=CF=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 883D8C433E1
	for <linux-block@archiver.kernel.org>; Thu, 27 Aug 2020 19:50:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 50E31207F7
	for <linux-block@archiver.kernel.org>; Thu, 27 Aug 2020 19:50:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=deltatee.com header.i=@deltatee.com header.b="hSuGMfQ5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727979AbgH0TtU (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 27 Aug 2020 15:49:20 -0400
Received: from ale.deltatee.com ([204.191.154.188]:54830 "EHLO
        ale.deltatee.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727949AbgH0TtT (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 27 Aug 2020 15:49:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=deltatee.com; s=20200525; h=Subject:Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=TkVopvHv5LAYAxNxYaHAAyEr54uZWHdpNC4+1QmgoMQ=; b=hSuGMfQ57klMFTRuxdvAeVDkuN
        eQDx0hMaKMjwQB+p6jJbfoGxDYRY1IIwifA0tx3dC2la+3BqfkYJVGkSvWcqwMLqOj8OvFwgac3M8
        V3yMPLha4Hqc9TPZjF8XTOIf/hL+1dZRDwuOlZFvr5e8kUv3+0UvlMnSJm8RTw8G/i+9jShQa2++M
        utvDfxuNgP8MZ8yCEW8JRLwUnYiG5vt3x6frTZfrWA3BVKNsLW5BOlJ3wTPPU/I5/sUQZWZqi2ySx
        nMySv9Y6tykB9xEELh07Gt9qOBVIaZiTN7jS7yCui4ATOXWxdXsw6Nc5kLGYT68oL1idLe2vjdwG2
        UasyRvOg==;
Received: from cgy1-donard.priv.deltatee.com ([172.16.1.31])
        by ale.deltatee.com with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <gunthorp@deltatee.com>)
        id 1kBNtd-0000Cf-OE; Thu, 27 Aug 2020 13:49:18 -0600
Received: from gunthorp by cgy1-donard.priv.deltatee.com with local (Exim 4.92)
        (envelope-from <gunthorp@deltatee.com>)
        id 1kBNta-0001cK-Po; Thu, 27 Aug 2020 13:49:14 -0600
From:   Logan Gunthorpe <logang@deltatee.com>
To:     linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org,
        linux-block@vger.kernel.org, Omar Sandoval <osandov@osandov.com>
Cc:     Sagi Grimberg <sagi@grimberg.me>,
        Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>,
        Stephen Bates <sbates@raithlin.com>,
        Logan Gunthorpe <logang@deltatee.com>
Date:   Thu, 27 Aug 2020 13:49:11 -0600
Message-Id: <20200827194912.6135-11-logang@deltatee.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200827194912.6135-1-logang@deltatee.com>
References: <20200827194912.6135-1-logang@deltatee.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 172.16.1.31
X-SA-Exim-Rcpt-To: linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org, linux-block@vger.kernel.org, osandov@osandov.com, sagi@grimberg.me, Chaitanya.Kulkarni@wdc.com, sbates@raithlin.com, logang@deltatee.com
X-SA-Exim-Mail-From: gunthorp@deltatee.com
Subject: [PATCH blktests 10/11] nvme/037: Add test which loops passthru connect and disconnect
X-SA-Exim-Version: 4.2.1 (built Wed, 08 May 2019 21:11:16 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Similar to test nvme/031 except for passthru controllers.

Note: it's normal to get I/O errors in this test as
when the controller disconnects it races with the partition
table read.

Signed-off-by: Logan Gunthorpe <logang@deltatee.com>
---
 tests/nvme/037     | 36 ++++++++++++++++++++++++++++++++++++
 tests/nvme/037.out |  2 ++
 2 files changed, 38 insertions(+)
 create mode 100755 tests/nvme/037
 create mode 100644 tests/nvme/037.out

diff --git a/tests/nvme/037 b/tests/nvme/037
new file mode 100755
index 000000000000..dce25b9f63cf
--- /dev/null
+++ b/tests/nvme/037
@@ -0,0 +1,36 @@
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
+	_have_program nvme &&
+	_have_modules nvme-loop nvmet &&
+	_have_configfs &&
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
+		port=$(_nvmet_passthru_target_setup "${subsys}$i")
+		_nvmet_passthru_target_connect "${subsys}$i" > /dev/null
+
+		_nvmet_passthru_target_disconnect "${subsys}$i"
+		_nvmet_passthru_target_cleanup "$port" "${subsys}$i"
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


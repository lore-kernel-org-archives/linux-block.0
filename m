Return-Path: <SRS0=cFNo=DP=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4759C433E7
	for <linux-block@archiver.kernel.org>; Thu,  8 Oct 2020 16:40:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5D1A9221F1
	for <linux-block@archiver.kernel.org>; Thu,  8 Oct 2020 16:40:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=deltatee.com header.i=@deltatee.com header.b="hfs8b5pM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731081AbgJHQkj (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 8 Oct 2020 12:40:39 -0400
Received: from ale.deltatee.com ([204.191.154.188]:48842 "EHLO
        ale.deltatee.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731011AbgJHQkh (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 8 Oct 2020 12:40:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=deltatee.com; s=20200525; h=Subject:Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=Nm9S1mrD71DL+fV1grCBmg3CM4YNMP/hpGKwYK5ic38=; b=hfs8b5pMuvD7VF5xO+QimFWDpu
        OWfAXQvAPtsSAZ2IH25NqZqu11dGq4XO6o72uzFwcB5dDuINplt9N5FC0p1aRafn+1vwThtRmIM7+
        OzW2UFiC1IXArsyigZk0ERL5F2wZDI0zb64CwB5NQuWHDVOqcPlDSkFSC7vDg08Ae0wigDYObIZCu
        p3tx7+Sc42sDIzDQFzBGJI6rv8jK3hJ1il620wZTWYSY4LGzFlw27H7ikpnLZv86BtOCIPFFBqI/i
        9Ibq6U6o0luprhdgKHSGAOagM6WxjvFurdWpsDPvxaq27126LLYOAxO1YoX4k8XOuNBOJ687Oo5t6
        g8NaMGsw==;
Received: from cgy1-donard.priv.deltatee.com ([172.16.1.31])
        by ale.deltatee.com with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <gunthorp@deltatee.com>)
        id 1kQYy3-0000ik-85; Thu, 08 Oct 2020 10:40:35 -0600
Received: from gunthorp by cgy1-donard.priv.deltatee.com with local (Exim 4.92)
        (envelope-from <gunthorp@deltatee.com>)
        id 1kQYxz-0003Hg-Sm; Thu, 08 Oct 2020 10:40:31 -0600
From:   Logan Gunthorpe <logang@deltatee.com>
To:     linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org,
        linux-block@vger.kernel.org, Omar Sandoval <osandov@osandov.com>
Cc:     Sagi Grimberg <sagi@grimberg.me>,
        Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>,
        Stephen Bates <sbates@raithlin.com>,
        Logan Gunthorpe <logang@deltatee.com>
Date:   Thu,  8 Oct 2020 10:40:22 -0600
Message-Id: <20201008164024.12546-10-logang@deltatee.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20201008164024.12546-1-logang@deltatee.com>
References: <20201008164024.12546-1-logang@deltatee.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 172.16.1.31
X-SA-Exim-Rcpt-To: linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org, linux-block@vger.kernel.org, osandov@osandov.com, sagi@grimberg.me, Chaitanya.Kulkarni@wdc.com, sbates@raithlin.com, logang@deltatee.com
X-SA-Exim-Mail-From: gunthorp@deltatee.com
Subject: [PATCH blktests v3 09/11] nvme/036: Add test for testing reset command on nvme-passthru
X-SA-Exim-Version: 4.2.1 (built Wed, 08 May 2019 21:11:16 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Similar to test 022 but for passthru controllers.

Signed-off-by: Logan Gunthorpe <logang@deltatee.com>
---
 tests/nvme/036     | 37 +++++++++++++++++++++++++++++++++++++
 tests/nvme/036.out |  3 +++
 2 files changed, 40 insertions(+)
 create mode 100755 tests/nvme/036
 create mode 100644 tests/nvme/036.out

diff --git a/tests/nvme/036 b/tests/nvme/036
new file mode 100755
index 000000000000..8218c6538dfd
--- /dev/null
+++ b/tests/nvme/036
@@ -0,0 +1,37 @@
+#!/bin/bash
+# SPDX-License-Identifier: GPL-3.0+
+# Copyright (C) 2019 Logan Gunthorpe
+# Copyright (C) 2019 Eideticom Communications Inc.
+
+. tests/nvme/rc
+
+DESCRIPTION="test NVMe reset command on an NVMeOF target with a passthru controller"
+QUICK=1
+
+requires() {
+	_nvme_requires
+	_have_kernel_option NVME_TARGET_PASSTHRU
+}
+
+test_device() {
+	local subsys="blktests-subsystem-1"
+	local ctrldev
+	local port
+
+	echo "Running ${TEST_NAME}"
+
+	_setup_nvmet
+	port=$(_nvmet_passthru_target_setup "${subsys}")
+	nsdev=$(_nvmet_passthru_target_connect "${nvme_trtype}" "${subsys}")
+
+	ctrldev=$(_find_nvme_dev "${subsys}")
+
+	if ! nvme reset "/dev/${ctrldev}" >> "$FULL" 2>&1; then
+		echo "ERROR: reset failed"
+	fi
+
+	_nvme_disconnect_subsys "${subsys}"
+	_nvmet_passthru_target_cleanup "${port}" "${subsys}"
+
+	echo "Test complete"
+}
diff --git a/tests/nvme/036.out b/tests/nvme/036.out
new file mode 100644
index 000000000000..d294f8646b20
--- /dev/null
+++ b/tests/nvme/036.out
@@ -0,0 +1,3 @@
+Running nvme/036
+NQN:blktests-subsystem-1 disconnected 1 controller(s)
+Test complete
-- 
2.20.1


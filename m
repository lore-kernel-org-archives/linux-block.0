Return-Path: <SRS0=E5Vf=CF=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D61CC433E5
	for <linux-block@archiver.kernel.org>; Thu, 27 Aug 2020 19:50:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 40D7922BEA
	for <linux-block@archiver.kernel.org>; Thu, 27 Aug 2020 19:50:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=deltatee.com header.i=@deltatee.com header.b="tPoyX7LB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727961AbgH0TtT (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 27 Aug 2020 15:49:19 -0400
Received: from ale.deltatee.com ([204.191.154.188]:54792 "EHLO
        ale.deltatee.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727930AbgH0TtR (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 27 Aug 2020 15:49:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=deltatee.com; s=20200525; h=Subject:Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=T2/WWXhmesEttKgAkD/m71X8OynQjfURTrXfzc8i8WQ=; b=tPoyX7LBneOCOkyMdOq4SKMsX6
        QcY9nftn2g//8rXYw7GJw0gf0+TsfLc5f9X9wvu7BxVbZk9dIA63DyN3zNSC6z/DmHQ+vKvRm/RBH
        uN4+mCDhXbrnhoBck7eOsDaBmrTTsag9KIK6DIbzU+HVZAbwRU/N2trZQ6WL+vUuShuARehPTBBI7
        zSmDr/SOSC0ol2ialz0Aei/XjYw8fQq8p6yJcgP3ir/G3UoTe53go+EEHDhUXUJok+hJEIq7w1MJT
        nagPMnqCrcpzqU7kGGe+YyaOvDTh/ugdxHFcyZRZL5bou3OpN/WJnXmLLx4Hy2koORRKAAYVA0ACO
        IgAztFIQ==;
Received: from cgy1-donard.priv.deltatee.com ([172.16.1.31])
        by ale.deltatee.com with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <gunthorp@deltatee.com>)
        id 1kBNta-0000Ce-Tv; Thu, 27 Aug 2020 13:49:15 -0600
Received: from gunthorp by cgy1-donard.priv.deltatee.com with local (Exim 4.92)
        (envelope-from <gunthorp@deltatee.com>)
        id 1kBNtZ-0001bw-RV; Thu, 27 Aug 2020 13:49:13 -0600
From:   Logan Gunthorpe <logang@deltatee.com>
To:     linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org,
        linux-block@vger.kernel.org, Omar Sandoval <osandov@osandov.com>
Cc:     Sagi Grimberg <sagi@grimberg.me>,
        Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>,
        Stephen Bates <sbates@raithlin.com>,
        Logan Gunthorpe <logang@deltatee.com>
Date:   Thu, 27 Aug 2020 13:49:03 -0600
Message-Id: <20200827194912.6135-3-logang@deltatee.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200827194912.6135-1-logang@deltatee.com>
References: <20200827194912.6135-1-logang@deltatee.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 172.16.1.31
X-SA-Exim-Rcpt-To: linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org, linux-block@vger.kernel.org, osandov@osandov.com, sagi@grimberg.me, Chaitanya.Kulkarni@wdc.com, sbates@raithlin.com, logang@deltatee.com
X-SA-Exim-Mail-From: gunthorp@deltatee.com
Subject: [PATCH blktests 02/11] common/xfs: Create common helper to check for XFS support
X-SA-Exim-Version: 4.2.1 (built Wed, 08 May 2019 21:11:16 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Two nvme tests create and mount XFS filesystems and
check for mkfs.xfs.

They should also check for XFS support in the kernel so
create a common helper for this.

Signed-off-by: Logan Gunthorpe <logang@deltatee.com>
---
 common/rc      |  8 ++++++++
 common/xfs     | 11 +++++++++++
 tests/nvme/012 |  3 ++-
 tests/nvme/013 |  3 ++-
 4 files changed, 23 insertions(+), 2 deletions(-)
 create mode 100644 common/xfs

diff --git a/common/rc b/common/rc
index 7f02103dc786..3dd1ab76f737 100644
--- a/common/rc
+++ b/common/rc
@@ -181,6 +181,14 @@ _have_tracepoint() {
 	return 0
 }
 
+_have_fs() {
+	modprobe "$1" >/dev/null 2>&1
+	if [[ ! -d "/sys/fs/$1" ]]; then
+		SKIP_REASON="kernel does not support filesystem $1"
+		return 1
+	fi
+}
+
 _test_dev_is_rotational() {
 	[[ $(cat "${TEST_DEV_SYSFS}/queue/rotational") -ne 0 ]]
 }
diff --git a/common/xfs b/common/xfs
new file mode 100644
index 000000000000..d1a603b8c7b5
--- /dev/null
+++ b/common/xfs
@@ -0,0 +1,11 @@
+#!/bin/bash
+# SPDX-License-Identifier: GPL-3.0+
+# Copyright (C) 2017 Omar Sandoval
+#
+# fio helper functions.
+
+. common/shellcheck
+
+_have_xfs() {
+	_have_fs xfs && _have_program mkfs.xfs
+}
diff --git a/tests/nvme/012 b/tests/nvme/012
index dc86ee647729..981e7779e21d 100755
--- a/tests/nvme/012
+++ b/tests/nvme/012
@@ -5,12 +5,13 @@
 # Test mkfs with data verification for block device backed ns.
 
 . tests/nvme/rc
+. common/xfs
 
 DESCRIPTION="run mkfs and data verification fio job on NVMeOF block device-backed ns"
 TIMED=1
 
 requires() {
-	_have_program nvme && _have_program mkfs.xfs && _have_program fio && \
+	_have_program nvme && _have_xfs && _have_program fio && \
 		_have_modules loop nvme-loop nvmet && _have_configfs
 }
 
diff --git a/tests/nvme/013 b/tests/nvme/013
index 0ed52926363a..228fab9ff02b 100755
--- a/tests/nvme/013
+++ b/tests/nvme/013
@@ -5,12 +5,13 @@
 # Test mkfs with data verification for file backed ns.
 
 . tests/nvme/rc
+. common/xfs
 
 DESCRIPTION="run mkfs and data verification fio job on NVMeOF file-backed ns"
 TIMED=1
 
 requires() {
-	_have_program nvme && _have_program mkfs.xfs && _have_fio && \
+	_have_program nvme && _have_xfs && _have_fio && \
 		_have_modules nvme-loop nvmet && _have_configfs
 }
 
-- 
2.20.1


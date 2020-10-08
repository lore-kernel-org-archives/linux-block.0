Return-Path: <SRS0=cFNo=DP=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF441C2BB1B
	for <linux-block@archiver.kernel.org>; Thu,  8 Oct 2020 16:41:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8317A221F1
	for <linux-block@archiver.kernel.org>; Thu,  8 Oct 2020 16:41:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=deltatee.com header.i=@deltatee.com header.b="sACgK/RE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729465AbgJHQke (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 8 Oct 2020 12:40:34 -0400
Received: from ale.deltatee.com ([204.191.154.188]:48790 "EHLO
        ale.deltatee.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726766AbgJHQkd (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 8 Oct 2020 12:40:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=deltatee.com; s=20200525; h=Subject:Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=jmZbySZXjmmi8+BukunACpKuNnADqVJZ1o4R+xzQg+E=; b=sACgK/REf+ZkmnOQitiTGrI+zK
        AGXi0oH7ClYOzdzkOROScK7euCGD9oX43xnfmvg0X0tpdvRcdFIXoatlTS/zx5wLibAh4fCnqKvez
        ucQQ1soaxH9Ux2+HCIoeSf19XMcJfcSt2pFFpTeuQiIg3NAG6rB4qIugQokHw8U7l5IcxwJ3U8gLI
        COhYZWW3WQHLbEvn5voJvV4jOpGM6u0Mb3mA04GNT4I4YzQoVFHrAGDz9noaBQlwvjp7RgqzeCiwG
        WOaM+Cx4S1QXkfK9GTHtxq1qOsQlAobYxIBHJcsJkymJl90kBNYMiSHry5mnjC/2LIyweZ3sga621
        NdrvBAPQ==;
Received: from cgy1-donard.priv.deltatee.com ([172.16.1.31])
        by ale.deltatee.com with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <gunthorp@deltatee.com>)
        id 1kQYxz-0000ij-Po; Thu, 08 Oct 2020 10:40:32 -0600
Received: from gunthorp by cgy1-donard.priv.deltatee.com with local (Exim 4.92)
        (envelope-from <gunthorp@deltatee.com>)
        id 1kQYxy-0003HL-V5; Thu, 08 Oct 2020 10:40:31 -0600
From:   Logan Gunthorpe <logang@deltatee.com>
To:     linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org,
        linux-block@vger.kernel.org, Omar Sandoval <osandov@osandov.com>
Cc:     Sagi Grimberg <sagi@grimberg.me>,
        Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>,
        Stephen Bates <sbates@raithlin.com>,
        Logan Gunthorpe <logang@deltatee.com>
Date:   Thu,  8 Oct 2020 10:40:15 -0600
Message-Id: <20201008164024.12546-3-logang@deltatee.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20201008164024.12546-1-logang@deltatee.com>
References: <20201008164024.12546-1-logang@deltatee.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 172.16.1.31
X-SA-Exim-Rcpt-To: linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org, linux-block@vger.kernel.org, osandov@osandov.com, sagi@grimberg.me, Chaitanya.Kulkarni@wdc.com, sbates@raithlin.com, logang@deltatee.com
X-SA-Exim-Mail-From: gunthorp@deltatee.com
Subject: [PATCH blktests v3 02/11] common/xfs: Create common helper to check for XFS support
X-SA-Exim-Version: 4.2.1 (built Wed, 08 May 2019 21:11:16 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Two nvme tests create and mount XFS filesystems and check for mkfs.xfs.

They should also check for XFS support in the kernel so create a common
helper for this.

Signed-off-by: Logan Gunthorpe <logang@deltatee.com>
---
 common/rc      |  8 ++++++++
 common/xfs     | 11 +++++++++++
 tests/nvme/012 |  6 ++++--
 tests/nvme/013 |  4 +++-
 4 files changed, 26 insertions(+), 3 deletions(-)
 create mode 100644 common/xfs

diff --git a/common/rc b/common/rc
index cdc0150ea5ea..44cb218c2fac 100644
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
index 1dbd59804ed7..1d8d8e3cc271 100755
--- a/tests/nvme/012
+++ b/tests/nvme/012
@@ -5,14 +5,16 @@
 # Test mkfs with data verification for block device backed ns.
 
 . tests/nvme/rc
+. common/xfs
 
 DESCRIPTION="run mkfs and data verification fio job on NVMeOF block device-backed ns"
 TIMED=1
 
 requires() {
 	_nvme_requires
-	_have_program mkfs.xfs && _have_program fio && \
-		_have_modules loop
+	_have_xfs
+	_have_program fio
+	_have_modules loop
 	_require_nvme_trtype_is_fabrics
 }
 
diff --git a/tests/nvme/013 b/tests/nvme/013
index df7f23e69252..3819a2730d9b 100755
--- a/tests/nvme/013
+++ b/tests/nvme/013
@@ -5,13 +5,15 @@
 # Test mkfs with data verification for file backed ns.
 
 . tests/nvme/rc
+. common/xfs
 
 DESCRIPTION="run mkfs and data verification fio job on NVMeOF file-backed ns"
 TIMED=1
 
 requires() {
 	_nvme_requires
-	_have_program mkfs.xfs && _have_fio
+	_have_xfs
+	_have_fio
 	_require_nvme_trtype_is_fabrics
 }
 
-- 
2.20.1


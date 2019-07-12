Return-Path: <SRS0=GKUn=VJ=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48AC2C742D7
	for <linux-block@archiver.kernel.org>; Fri, 12 Jul 2019 23:57:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2A0FD20874
	for <linux-block@archiver.kernel.org>; Fri, 12 Jul 2019 23:57:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727392AbfGLX54 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 12 Jul 2019 19:57:56 -0400
Received: from ale.deltatee.com ([207.54.116.67]:60284 "EHLO ale.deltatee.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727053AbfGLX54 (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Fri, 12 Jul 2019 19:57:56 -0400
Received: from cgy1-donard.priv.deltatee.com ([172.16.1.31])
        by ale.deltatee.com with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <gunthorp@deltatee.com>)
        id 1hm5QG-0004Oy-Dy; Fri, 12 Jul 2019 17:57:55 -0600
Received: from gunthorp by cgy1-donard.priv.deltatee.com with local (Exim 4.89)
        (envelope-from <gunthorp@deltatee.com>)
        id 1hm5QE-0005uO-IO; Fri, 12 Jul 2019 17:57:50 -0600
From:   Logan Gunthorpe <logang@deltatee.com>
To:     linux-block@vger.kernel.org, linux-nvme@lists.infradead.org,
        Omar Sandoval <osandov@fb.com>
Cc:     Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>,
        Michael Moese <mmoese@suse.de>, Theodore Ts'o <tytso@mit.edu>,
        Johannes Thumshirn <jthumshirn@suse.de>,
        Stephen Bates <sbates@raithlin.com>,
        Logan Gunthorpe <logang@deltatee.com>
Date:   Fri, 12 Jul 2019 17:57:35 -0600
Message-Id: <20190712235742.22646-6-logang@deltatee.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190712235742.22646-1-logang@deltatee.com>
References: <20190712235742.22646-1-logang@deltatee.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 172.16.1.31
X-SA-Exim-Rcpt-To: linux-block@vger.kernel.org, linux-nvme@lists.infradead.org, osandov@fb.com, chaitanya.kulkarni@wdc.com, tytso@mit.edu, mmoese@suse.de, jthumshirn@suse.de, sbates@raithlin.com, logang@deltatee.com
X-SA-Exim-Mail-From: gunthorp@deltatee.com
Subject: [PATCH blktests 05/12] nvme/005: Don't rely on modprobing to set the multipath paramater
X-SA-Exim-Version: 4.2.1 (built Tue, 02 Aug 2016 21:08:31 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On test systems with existing nvme drives or built-in modules it may not
be possible to remove nvme-core in order to re-probe it with
multipath=1.

Instead, skip the test if the multipath parameter is not already set
ahead of time.

Note: the multipath parameter of nvme-core is set by default if
CONFIG_NVME_MULTIPATH is set so this will only affect systems
that explicitly disable it via the module parameter.

Signed-off-by: Logan Gunthorpe <logang@deltatee.com>
---
 common/rc      | 16 ++++++++++++++++
 tests/nvme/005 | 10 ++--------
 2 files changed, 18 insertions(+), 8 deletions(-)

diff --git a/common/rc b/common/rc
index 5dd2c9512fd2..49050c71dabf 100644
--- a/common/rc
+++ b/common/rc
@@ -55,6 +55,22 @@ _have_module_param() {
 	return 0
 }
 
+_have_module_param_value() {
+	local value
+
+	if ! _have_module_param "$1" "$2"; then
+		return 1
+	fi
+
+	value=$(cat "/sys/module/$1/parameters/$2")
+	if [[ "${value}" != "$3" ]]; then
+		SKIP_REASON="$1 module parameter $2 must be set to $3"
+		return 1
+	fi
+
+	return 0
+}
+
 _have_program() {
 	if command -v "$1" >/dev/null 2>&1; then
 		return 0
diff --git a/tests/nvme/005 b/tests/nvme/005
index e72fc809c936..91c164de73e6 100755
--- a/tests/nvme/005
+++ b/tests/nvme/005
@@ -12,18 +12,13 @@ QUICK=1
 
 requires() {
 	_have_modules loop nvme-core nvme-loop nvmet && \
-		_have_module_param nvme-core multipath && _have_configfs
+		_have_module_param_value nvme_core multipath Y && \
+		_have_configfs
 }
 
 test() {
 	echo "Running ${TEST_NAME}"
 
-	# Clean up all stale modules
-	modprobe -r nvme-loop
-	modprobe -r nvme-core
-	modprobe -r nvmet
-
-	modprobe nvme-core multipath=1
 	modprobe nvmet
 	modprobe nvme-loop
 
@@ -57,7 +52,6 @@ test() {
 	rm "$TMPDIR/img"
 
 	modprobe -r nvme-loop
-	modprobe -r nvme-core
 	modprobe -r nvmet
 
 	echo "Test complete"
-- 
2.17.1


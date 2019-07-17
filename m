Return-Path: <SRS0=ez2/=VO=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C23C0C7618F
	for <linux-block@archiver.kernel.org>; Wed, 17 Jul 2019 17:13:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A1F6A21841
	for <linux-block@archiver.kernel.org>; Wed, 17 Jul 2019 17:13:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731219AbfGQRNQ (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 17 Jul 2019 13:13:16 -0400
Received: from ale.deltatee.com ([207.54.116.67]:60218 "EHLO ale.deltatee.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731208AbfGQRNP (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Wed, 17 Jul 2019 13:13:15 -0400
Received: from cgy1-donard.priv.deltatee.com ([172.16.1.31])
        by ale.deltatee.com with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <gunthorp@deltatee.com>)
        id 1hnnUQ-00012x-8g; Wed, 17 Jul 2019 11:13:15 -0600
Received: from gunthorp by cgy1-donard.priv.deltatee.com with local (Exim 4.89)
        (envelope-from <gunthorp@deltatee.com>)
        id 1hnnUL-0000sm-2y; Wed, 17 Jul 2019 11:13:09 -0600
From:   Logan Gunthorpe <logang@deltatee.com>
To:     linux-block@vger.kernel.org, linux-nvme@lists.infradead.org,
        Omar Sandoval <osandov@fb.com>
Cc:     Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>,
        Michael Moese <mmoese@suse.de>, Theodore Ts'o <tytso@mit.edu>,
        Johannes Thumshirn <jthumshirn@suse.de>,
        Stephen Bates <sbates@raithlin.com>,
        Logan Gunthorpe <logang@deltatee.com>
Date:   Wed, 17 Jul 2019 11:12:57 -0600
Message-Id: <20190717171259.3311-11-logang@deltatee.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190717171259.3311-1-logang@deltatee.com>
References: <20190717171259.3311-1-logang@deltatee.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 172.16.1.31
X-SA-Exim-Rcpt-To: linux-block@vger.kernel.org, linux-nvme@lists.infradead.org, osandov@fb.com, chaitanya.kulkarni@wdc.com, tytso@mit.edu, mmoese@suse.de, jthumshirn@suse.de, sbates@raithlin.com, logang@deltatee.com
X-SA-Exim-Mail-From: gunthorp@deltatee.com
Subject: [PATCH blktests v2 10/12] nvme: Ensure all ports and subsystems are removed on cleanup
X-SA-Exim-Version: 4.2.1 (built Tue, 02 Aug 2016 21:08:31 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

This ensures any test that fails or is interrupted will cleanup
their subsystems. This will prevent the system from being left
in an inconsistent state that will fail subsequent tests.

Signed-off-by: Logan Gunthorpe <logang@deltatee.com>
---
 tests/nvme/rc | 43 +++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 43 insertions(+)

diff --git a/tests/nvme/rc b/tests/nvme/rc
index 16bdb7f0c083..a6b4d5938680 100644
--- a/tests/nvme/rc
+++ b/tests/nvme/rc
@@ -25,6 +25,49 @@ _test_dev_is_nvme() {
 }
 
 _cleanup_nvmet() {
+	local dev
+	local port
+	local subsys
+	local transport
+	local name
+
+	if [[ ! -d "${NVMET_CFS}" ]]; then
+		return 0
+	fi
+
+	# Don't let successive Ctrl-Cs interrupt the cleanup processes
+	stty -isig
+
+	shopt -s nullglob
+
+	for dev in /sys/class/nvme/nvme*; do
+		dev="$(basename "$dev")"
+		transport="$(cat "/sys/class/nvme/${dev}/transport")"
+		if [[ "$transport" == "loop" ]]; then
+			echo "WARNING: Test did not clean up loop device: ${dev}"
+			nvme disconnect -d "${dev}"
+		fi
+	done
+
+	for port in "${NVMET_CFS}"/ports/*; do
+		name=$(basename "${port}")
+		echo "WARNING: Test did not clean up port: ${name}"
+		rm -f "${port}"/subsystems/*
+		rmdir "${port}"
+	done
+
+	for subsys in "${NVMET_CFS}"/subsystems/*; do
+		name=$(basename "${subsys}")
+		echo "WARNING: Test did not clean up subsystem: ${name}"
+		for ns in "${subsys}"/namespaces/*; do
+			rmdir "${ns}"
+		done
+		rmdir "${subsys}"
+	done
+
+	shopt -u nullglob
+	stty isig
+
 	modprobe -r nvme-loop
 	modprobe -r nvmet
 }
-- 
2.17.1


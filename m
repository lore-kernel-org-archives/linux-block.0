Return-Path: <SRS0=ez2/=VO=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2507EC76192
	for <linux-block@archiver.kernel.org>; Wed, 17 Jul 2019 17:13:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 02E6C2186A
	for <linux-block@archiver.kernel.org>; Wed, 17 Jul 2019 17:13:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731178AbfGQRNT (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 17 Jul 2019 13:13:19 -0400
Received: from ale.deltatee.com ([207.54.116.67]:60260 "EHLO ale.deltatee.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731264AbfGQRNS (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Wed, 17 Jul 2019 13:13:18 -0400
Received: from cgy1-donard.priv.deltatee.com ([172.16.1.31])
        by ale.deltatee.com with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <gunthorp@deltatee.com>)
        id 1hnnUQ-00012y-Ag; Wed, 17 Jul 2019 11:13:18 -0600
Received: from gunthorp by cgy1-donard.priv.deltatee.com with local (Exim 4.89)
        (envelope-from <gunthorp@deltatee.com>)
        id 1hnnUL-0000sp-5f; Wed, 17 Jul 2019 11:13:09 -0600
From:   Logan Gunthorpe <logang@deltatee.com>
To:     linux-block@vger.kernel.org, linux-nvme@lists.infradead.org,
        Omar Sandoval <osandov@fb.com>
Cc:     Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>,
        Michael Moese <mmoese@suse.de>, Theodore Ts'o <tytso@mit.edu>,
        Johannes Thumshirn <jthumshirn@suse.de>,
        Stephen Bates <sbates@raithlin.com>,
        Logan Gunthorpe <logang@deltatee.com>
Date:   Wed, 17 Jul 2019 11:12:58 -0600
Message-Id: <20190717171259.3311-12-logang@deltatee.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190717171259.3311-1-logang@deltatee.com>
References: <20190717171259.3311-1-logang@deltatee.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 172.16.1.31
X-SA-Exim-Rcpt-To: linux-block@vger.kernel.org, linux-nvme@lists.infradead.org, osandov@fb.com, chaitanya.kulkarni@wdc.com, tytso@mit.edu, mmoese@suse.de, jthumshirn@suse.de, sbates@raithlin.com, logang@deltatee.com
X-SA-Exim-Mail-From: gunthorp@deltatee.com
Subject: [PATCH blktests v2 11/12] common: Use sysfs instead of modinfo for _have_module_param()
X-SA-Exim-Version: 4.2.1 (built Tue, 02 Aug 2016 21:08:31 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Using modinfo fails if the given module is built-in.

Instead, if the module is already in the kernel, check for the
parameter in sysfs.

Signed-off-by: Logan Gunthorpe <logang@deltatee.com>
---
 common/rc | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/common/rc b/common/rc
index a487cc69026c..41aee3aaa735 100644
--- a/common/rc
+++ b/common/rc
@@ -48,6 +48,12 @@ _have_modules() {
 }
 
 _have_module_param() {
+	if [ -d "/sys/module/$1" ]; then
+		if [ -e "/sys/module/$1/parameters/$2" ]; then
+			return 0
+		fi
+	fi
+
 	if ! modinfo -F parm -0 "$1" | grep -q -z "^$2:"; then
 		SKIP_REASON="$1 module does not have parameter $2"
 		return 1
-- 
2.17.1


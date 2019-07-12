Return-Path: <SRS0=GKUn=VJ=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65234C742DD
	for <linux-block@archiver.kernel.org>; Fri, 12 Jul 2019 23:57:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3BEC420874
	for <linux-block@archiver.kernel.org>; Fri, 12 Jul 2019 23:57:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727451AbfGLX56 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 12 Jul 2019 19:57:58 -0400
Received: from ale.deltatee.com ([207.54.116.67]:60306 "EHLO ale.deltatee.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727393AbfGLX55 (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Fri, 12 Jul 2019 19:57:57 -0400
Received: from cgy1-donard.priv.deltatee.com ([172.16.1.31])
        by ale.deltatee.com with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <gunthorp@deltatee.com>)
        id 1hm5QG-0004P6-E3; Fri, 12 Jul 2019 17:57:56 -0600
Received: from gunthorp by cgy1-donard.priv.deltatee.com with local (Exim 4.89)
        (envelope-from <gunthorp@deltatee.com>)
        id 1hm5QF-0005uk-8y; Fri, 12 Jul 2019 17:57:51 -0600
From:   Logan Gunthorpe <logang@deltatee.com>
To:     linux-block@vger.kernel.org, linux-nvme@lists.infradead.org,
        Omar Sandoval <osandov@fb.com>
Cc:     Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>,
        Michael Moese <mmoese@suse.de>, Theodore Ts'o <tytso@mit.edu>,
        Johannes Thumshirn <jthumshirn@suse.de>,
        Stephen Bates <sbates@raithlin.com>,
        Logan Gunthorpe <logang@deltatee.com>
Date:   Fri, 12 Jul 2019 17:57:42 -0600
Message-Id: <20190712235742.22646-13-logang@deltatee.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190712235742.22646-1-logang@deltatee.com>
References: <20190712235742.22646-1-logang@deltatee.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 172.16.1.31
X-SA-Exim-Rcpt-To: linux-block@vger.kernel.org, linux-nvme@lists.infradead.org, osandov@fb.com, chaitanya.kulkarni@wdc.com, tytso@mit.edu, mmoese@suse.de, jthumshirn@suse.de, sbates@raithlin.com, logang@deltatee.com
X-SA-Exim-Mail-From: gunthorp@deltatee.com
Subject: [PATCH blktests 12/12] nvme: Ignore errors when removing modules
X-SA-Exim-Version: 4.2.1 (built Tue, 02 Aug 2016 21:08:31 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

It is no longer important for correct test functionality to
remove the modules between tests. Therefore, we ignore errors
if the modules are not removed (ie. if they are builtin).

With this patch, it is now safe to run the tests with the nvmet
modules built-in. This will be more convienent for developers
that want to run the tests in a simple VM.

Signed-off-by: Logan Gunthorpe <logang@deltatee.com>
---
 tests/nvme/rc | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tests/nvme/rc b/tests/nvme/rc
index 1c9e4af0cbe5..0b98b89d0634 100644
--- a/tests/nvme/rc
+++ b/tests/nvme/rc
@@ -68,8 +68,8 @@ _cleanup_nvmet() {
 	shopt -u nullglob
 	stty isig
 
-	modprobe -r nvme-loop
-	modprobe -r nvmet
+	modprobe -r nvme-loop 2>/dev/null
+	modprobe -r nvmet 2>/dev/null
 }
 
 _setup_nvmet() {
-- 
2.17.1


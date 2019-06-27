Return-Path: <SRS0=TUEB=U2=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF198C4321A
	for <linux-block@archiver.kernel.org>; Thu, 27 Jun 2019 22:29:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BB7332063F
	for <linux-block@archiver.kernel.org>; Thu, 27 Jun 2019 22:29:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726786AbfF0W34 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 27 Jun 2019 18:29:56 -0400
Received: from mga04.intel.com ([192.55.52.120]:9985 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726445AbfF0W34 (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Thu, 27 Jun 2019 18:29:56 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga104.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 27 Jun 2019 15:29:56 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.63,425,1557212400"; 
   d="scan'208";a="162788164"
Received: from revanth-x299-aorus-gaming-3-pro.lm.intel.com ([10.232.116.91])
  by fmsmga008.fm.intel.com with ESMTP; 27 Jun 2019 15:29:55 -0700
From:   Revanth Rajashekar <revanth.rajashekar@intel.com>
To:     <linux-block@vger.kernel.org>
Cc:     Jonathan Derrick <jonathan.derrick@intel.com>,
        Scott Bauer <sbauer@plzdonthack.me>,
        Revanth Rajashekar <revanth.rajashekar@intel.com>
Subject: [PATCH] block: sed-opal: "Never True" conditions
Date:   Thu, 27 Jun 2019 16:31:09 -0600
Message-Id: <20190627223109.8155-1-revanth.rajashekar@intel.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

'who' an unsigned variable in stucture opal_session_info
can never be lesser than zero. Hence, the condition
"who < OPAL_ADMIN1" can never be true.

Signed-off-by: Revanth Rajashekar <revanth.rajashekar@intel.com>
---
 block/sed-opal.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/block/sed-opal.c b/block/sed-opal.c
index a46e8d13e16d..c75935bb6c1d 100644
--- a/block/sed-opal.c
+++ b/block/sed-opal.c
@@ -2092,8 +2092,7 @@ static int opal_lock_unlock(struct opal_dev *dev,
 {
 	int ret;

-	if (lk_unlk->session.who < OPAL_ADMIN1 ||
-	    lk_unlk->session.who > OPAL_USER9)
+	if (lk_unlk->session.who > OPAL_USER9)
 		return -EINVAL;

 	mutex_lock(&dev->dev_lock);
@@ -2171,9 +2170,7 @@ static int opal_set_new_pw(struct opal_dev *dev, struct opal_new_pw *opal_pw)
 	};
 	int ret;

-	if (opal_pw->session.who < OPAL_ADMIN1 ||
-	    opal_pw->session.who > OPAL_USER9  ||
-	    opal_pw->new_user_pw.who < OPAL_ADMIN1 ||
+	if (opal_pw->session.who > OPAL_USER9  ||
 	    opal_pw->new_user_pw.who > OPAL_USER9)
 		return -EINVAL;

--
2.17.1


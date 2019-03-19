Return-Path: <SRS0=YHP0=RW=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5561CC43381
	for <linux-block@archiver.kernel.org>; Tue, 19 Mar 2019 14:24:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2E41D2133D
	for <linux-block@archiver.kernel.org>; Tue, 19 Mar 2019 14:24:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726712AbfCSOYv (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 19 Mar 2019 10:24:51 -0400
Received: from mga02.intel.com ([134.134.136.20]:45759 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726703AbfCSOYv (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Tue, 19 Mar 2019 10:24:51 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 19 Mar 2019 07:24:50 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.58,498,1544515200"; 
   d="scan'208";a="132882483"
Received: from mdziegie-mobl.ger.corp.intel.com (HELO localhost.igk.intel.com) ([10.237.142.119])
  by fmsmga008.fm.intel.com with ESMTP; 19 Mar 2019 07:24:48 -0700
From:   Marcin Dziegielewski <marcin.dziegielewski@intel.com>
To:     mb@lightnvm.io, javier@javigon.com, hans.holmberg@cnexlabs.com
Cc:     linux-block@vger.kernel.org, marcin.dziegielewski@intel.com,
        igor.j.konopko@intel.com
Subject: [PATCH] lightnvm: add a lock to prevent before the race condition on pblk remove
Date:   Tue, 19 Mar 2019 15:24:44 +0100
Message-Id: <1553005484-10584-1-git-send-email-marcin.dziegielewski@intel.com>
X-Mailer: git-send-email 1.8.3.1
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

When we trigger nvm target remove during device hot unplug, we
have a chance to hit general protection fault caused by use of
nvm_dev which was freed from another (hot unplug) thread (in
nvm_unregister function).

This patch introduce lock in nvme_ioctl_dev_remove function to
prevent us before a situation like described above.

Signed-off-by: Marcin Dziegielewski <marcin.dziegielewski@intel.com>
---
 drivers/lightnvm/core.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/lightnvm/core.c b/drivers/lightnvm/core.c
index 5f82036..84f0b9a 100644
--- a/drivers/lightnvm/core.c
+++ b/drivers/lightnvm/core.c
@@ -1335,11 +1335,13 @@ static long nvm_ioctl_dev_remove(struct file *file, void __user *arg)
 		return -EINVAL;
 	}
 
+	down_read(&nvm_lock);
 	list_for_each_entry(dev, &nvm_devices, devices) {
 		ret = nvm_remove_tgt(dev, &remove);
 		if (!ret)
 			break;
 	}
+	up_read(&nvm_lock);
 
 	return ret;
 }
-- 
1.8.3.1


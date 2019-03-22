Return-Path: <SRS0=iCYb=RZ=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9AE3BC43381
	for <linux-block@archiver.kernel.org>; Fri, 22 Mar 2019 14:52:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6943B20883
	for <linux-block@archiver.kernel.org>; Fri, 22 Mar 2019 14:52:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728789AbfCVOwd (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 22 Mar 2019 10:52:33 -0400
Received: from mga03.intel.com ([134.134.136.65]:54714 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728733AbfCVOwc (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Fri, 22 Mar 2019 10:52:32 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga103.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 22 Mar 2019 07:52:32 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,256,1549958400"; 
   d="scan'208";a="216593387"
Received: from gklab-107-059.igk.intel.com ([10.102.107.59])
  by orsmga001.jf.intel.com with ESMTP; 22 Mar 2019 07:52:30 -0700
From:   Igor Konopko <igor.j.konopko@intel.com>
To:     mb@lightnvm.io, javier@javigon.com, hans.holmberg@cnexlabs.com
Cc:     linux-block@vger.kernel.org, igor.j.konopko@intel.com
Subject: [PATCH v2 09/16] lightnvm: pblk: fix spin_unlock order
Date:   Fri, 22 Mar 2019 15:48:36 +0100
Message-Id: <20190322144843.9602-10-igor.j.konopko@intel.com>
X-Mailer: git-send-email 2.9.5
In-Reply-To: <20190322144843.9602-1-igor.j.konopko@intel.com>
References: <20190322144843.9602-1-igor.j.konopko@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

In pblk_rb_tear_down_check() spin_unlock() functions are not
called in proper order. This patch fixes that.

Fixes: a4bd217 ("lightnvm: physical block device (pblk) target")
Signed-off-by: Igor Konopko <igor.j.konopko@intel.com>
Reviewed-by: Javier González <javier@javigon.com>
Reviewed-by: Hans Holmberg <hans.holmberg@cnexlabs.com>
---
 drivers/lightnvm/pblk-rb.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/lightnvm/pblk-rb.c b/drivers/lightnvm/pblk-rb.c
index 03c241b..3555014 100644
--- a/drivers/lightnvm/pblk-rb.c
+++ b/drivers/lightnvm/pblk-rb.c
@@ -799,8 +799,8 @@ int pblk_rb_tear_down_check(struct pblk_rb *rb)
 	}
 
 out:
-	spin_unlock(&rb->w_lock);
 	spin_unlock_irq(&rb->s_lock);
+	spin_unlock(&rb->w_lock);
 
 	return ret;
 }
-- 
2.9.5


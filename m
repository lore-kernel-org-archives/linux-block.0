Return-Path: <SRS0=7rSP=3F=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25D61C47409
	for <linux-block@archiver.kernel.org>; Thu, 16 Jan 2020 18:27:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E9912208C3
	for <linux-block@archiver.kernel.org>; Thu, 16 Jan 2020 18:27:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1579199245;
	bh=4ObR9pZ3j4UB200gUrKQfZlwtblOWEmrN4/PjLnBIOs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=jjaI2m7T8KfV5MNu+TZOvYD0BBXMUWYD+/F7HQcDuxwOVb/SzybTup3PK5+sQBaWr
	 cxUOrK56rN7ulSioroO/kzi3Xuo6YvYcv8KUBJsLJJe7cO+yTzTxggb/rcZrz3QOsy
	 m3t9HQC/n69+7ya/vtpDHfBrVUv40MY5awGX9lqU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392357AbgAPR05 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 16 Jan 2020 12:26:57 -0500
Received: from mail.kernel.org ([198.145.29.99]:36198 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2392350AbgAPR04 (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Thu, 16 Jan 2020 12:26:56 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BE9E0246D9;
        Thu, 16 Jan 2020 17:26:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1579195615;
        bh=4ObR9pZ3j4UB200gUrKQfZlwtblOWEmrN4/PjLnBIOs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=t+QvEue5Nbp8lhf2dFz7i995taaq1iJKlVHd+ZWbUkc5mmA7DWq0HKTf5M07v9WfU
         HgVe2aCjIm2Rz7fZJ4SsjxgRaraiiKhhSxQZH19vMf8DRxCF5eIMG4vjOmAFwpv/WM
         ADaGvQFpblK5EKKkyiWhiSnhe37D7/tc4qQxltGo=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Igor Konopko <igor.j.konopko@intel.com>,
        =?UTF-8?q?Javier=20Gonz=C3=A1lez?= <javier@javigon.com>,
        Hans Holmberg <hans.holmberg@cnexlabs.com>,
        =?UTF-8?q?Matias=20Bj=C3=B8rling?= <mb@lightnvm.io>,
        Jens Axboe <axboe@kernel.dk>, Sasha Levin <sashal@kernel.org>,
        linux-block@vger.kernel.org
Subject: [PATCH AUTOSEL 4.14 188/371] lightnvm: pblk: fix lock order in pblk_rb_tear_down_check
Date:   Thu, 16 Jan 2020 12:21:00 -0500
Message-Id: <20200116172403.18149-131-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200116172403.18149-1-sashal@kernel.org>
References: <20200116172403.18149-1-sashal@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

From: Igor Konopko <igor.j.konopko@intel.com>

[ Upstream commit 486b5aac85f6ec0b2df3e82a6a629d5eb7804db5 ]

In pblk_rb_tear_down_check() the spinlock functions are not
called in proper order.

Fixes: a4bd217 ("lightnvm: physical block device (pblk) target")
Signed-off-by: Igor Konopko <igor.j.konopko@intel.com>
Reviewed-by: Javier González <javier@javigon.com>
Reviewed-by: Hans Holmberg <hans.holmberg@cnexlabs.com>
Signed-off-by: Matias Bjørling <mb@lightnvm.io>
Signed-off-by: Jens Axboe <axboe@kernel.dk>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/lightnvm/pblk-rb.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/lightnvm/pblk-rb.c b/drivers/lightnvm/pblk-rb.c
index c0dd17a82170..73de2deaba67 100644
--- a/drivers/lightnvm/pblk-rb.c
+++ b/drivers/lightnvm/pblk-rb.c
@@ -825,8 +825,8 @@ int pblk_rb_tear_down_check(struct pblk_rb *rb)
 	}
 
 out:
-	spin_unlock(&rb->w_lock);
 	spin_unlock_irq(&rb->s_lock);
+	spin_unlock(&rb->w_lock);
 
 	return ret;
 }
-- 
2.20.1


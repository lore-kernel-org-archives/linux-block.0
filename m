Return-Path: <SRS0=8u48=QA=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.9 required=3.0 tests=DATE_IN_PAST_96_XX,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7C18C282C3
	for <linux-block@archiver.kernel.org>; Thu, 24 Jan 2019 08:09:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 12E0A217D4
	for <linux-block@archiver.kernel.org>; Thu, 24 Jan 2019 08:09:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fjfi.cvut.cz header.i=@fjfi.cvut.cz header.b="YxRJV4U1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726199AbfAXIJH (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 24 Jan 2019 03:09:07 -0500
Received: from mailgw1.fjfi.cvut.cz ([147.32.9.3]:56754 "EHLO
        mailgw1.fjfi.cvut.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725986AbfAXIJH (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 24 Jan 2019 03:09:07 -0500
Received: from localhost (localhost [127.0.0.1])
        by mailgw1.fjfi.cvut.cz (Postfix) with ESMTP id 8D4B3A7193;
        Thu, 24 Jan 2019 09:09:04 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fjfi.cvut.cz;
        s=20151024; t=1548317344; i=@fjfi.cvut.cz;
        bh=iW70peVUWZxWgivNF0f1XrW7MfNGYLHtjRJ4rSwtkYw=;
        h=From:Date:Subject:To:Cc;
        b=YxRJV4U1/PmYu5fs6cbssRpvNd57J1pC8YuuOduWQFoRUfoIhcl/N2TcUYqNkVaIq
         6ibSAFfei6nIirXMMzn7aJfyb0F5VB023kBGV/yxbIgLyN/pREk4xm4ZK1YES5qI97
         FJpqNY63SR4kUMu7+4nVIbOaYiYwM3GR/p4Tigvs=
X-CTU-FNSPE-Virus-Scanned: amavisd-new at fjfi.cvut.cz
Received: from mailgw1.fjfi.cvut.cz ([127.0.0.1])
        by localhost (mailgw1.fjfi.cvut.cz [127.0.0.1]) (amavisd-new, port 10022)
        with ESMTP id Hvbc9hWdG3gN; Thu, 24 Jan 2019 09:08:57 +0100 (CET)
Received: from linux.fjfi.cvut.cz (linux.fjfi.cvut.cz [147.32.5.111])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mailgw1.fjfi.cvut.cz (Postfix) with ESMTPS id 4EF4EAEFB1;
        Wed, 16 Jan 2019 23:55:51 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailgw1.fjfi.cvut.cz 4EF4EAEFB1
Received: by linux.fjfi.cvut.cz (Postfix, from userid 1001)
        id 2C5C86004E; Wed, 16 Jan 2019 23:55:51 +0100 (CET)
From:   David Kozub <zub@linux.fjfi.cvut.cz>
Date:   Thu, 3 Jan 2019 23:59:36 +0100
Subject: [PATCH 16/16] block: sed-opal: rename next to execute_steps
To:     Jens Axboe <axboe@kernel.dk>, Scott Bauer <scott.bauer@intel.com>,
        Jonathan Derrick <jonathan.derrick@intel.com>,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Jonas Rabenstein <jonas.rabenstein@studium.uni-erlangen.de>
Message-Id: <20190116225551.2C5C86004E@linux.fjfi.cvut.cz>
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

As the function is responsible for executing the individual steps supplied
in the steps argument, execute_steps is a more descriptive name than the
rather generic next.

Signed-off-by: David Kozub <zub@linux.fjfi.cvut.cz>
---
 block/sed-opal.c | 37 +++++++++++++++++++------------------
 1 file changed, 19 insertions(+), 18 deletions(-)

diff --git a/block/sed-opal.c b/block/sed-opal.c
index cedf4d12138d..f2bd16de8764 100644
--- a/block/sed-opal.c
+++ b/block/sed-opal.c
@@ -401,8 +401,8 @@ static int execute_step(struct opal_dev *dev,
 	return error;
 }
 
-static int next(struct opal_dev *dev, const struct opal_step *steps,
-		size_t n_steps)
+static int execute_steps(struct opal_dev *dev,
+			 const struct opal_step *steps, size_t n_steps)
 {
 	size_t state;
 	int error;
@@ -2032,7 +2032,7 @@ static int opal_secure_erase_locking_range(struct opal_dev *dev,
 
 	mutex_lock(&dev->dev_lock);
 	setup_opal_dev(dev);
-	ret = next(dev, erase_steps, ARRAY_SIZE(erase_steps));
+	ret = execute_steps(dev, erase_steps, ARRAY_SIZE(erase_steps));
 	mutex_unlock(&dev->dev_lock);
 	return ret;
 }
@@ -2049,7 +2049,7 @@ static int opal_erase_locking_range(struct opal_dev *dev,
 
 	mutex_lock(&dev->dev_lock);
 	setup_opal_dev(dev);
-	ret = next(dev, erase_steps, ARRAY_SIZE(erase_steps));
+	ret = execute_steps(dev, erase_steps, ARRAY_SIZE(erase_steps));
 	mutex_unlock(&dev->dev_lock);
 	return ret;
 }
@@ -2075,7 +2075,7 @@ static int opal_enable_disable_shadow_mbr(struct opal_dev *dev,
 
 	mutex_lock(&dev->dev_lock);
 	setup_opal_dev(dev);
-	ret = next(dev, mbr_steps, ARRAY_SIZE(mbr_steps));
+	ret = execute_steps(dev, mbr_steps, ARRAY_SIZE(mbr_steps));
 	mutex_unlock(&dev->dev_lock);
 	return ret;
 }
@@ -2097,7 +2097,7 @@ static int opal_mbr_status(struct opal_dev *dev, struct opal_mbr_data *opal_mbr)
 
 	mutex_lock(&dev->dev_lock);
 	setup_opal_dev(dev);
-	ret = next(dev, mbr_steps, ARRAY_SIZE(mbr_steps));
+	ret = execute_steps(dev, mbr_steps, ARRAY_SIZE(mbr_steps));
 	mutex_unlock(&dev->dev_lock);
 	return ret;
 }
@@ -2120,7 +2120,7 @@ static int opal_write_shadow_mbr(struct opal_dev *dev,
 
 	mutex_lock(&dev->dev_lock);
 	setup_opal_dev(dev);
-	ret = next(dev, mbr_steps, ARRAY_SIZE(mbr_steps));
+	ret = execute_steps(dev, mbr_steps, ARRAY_SIZE(mbr_steps));
 	mutex_unlock(&dev->dev_lock);
 	return ret;
 }
@@ -2172,7 +2172,7 @@ static int opal_add_user_to_lr(struct opal_dev *dev,
 
 	mutex_lock(&dev->dev_lock);
 	setup_opal_dev(dev);
-	ret = next(dev, steps, ARRAY_SIZE(steps));
+	ret = execute_steps(dev, steps, ARRAY_SIZE(steps));
 	mutex_unlock(&dev->dev_lock);
 	return ret;
 }
@@ -2187,7 +2187,7 @@ static int opal_reverttper(struct opal_dev *dev, struct opal_key *opal)
 
 	mutex_lock(&dev->dev_lock);
 	setup_opal_dev(dev);
-	ret = next(dev, revert_steps, ARRAY_SIZE(revert_steps));
+	ret = execute_steps(dev, revert_steps, ARRAY_SIZE(revert_steps));
 	mutex_unlock(&dev->dev_lock);
 
 	/*
@@ -2215,10 +2215,11 @@ static int __opal_lock_unlock(struct opal_dev *dev,
 	};
 
 	if (lk_unlk->session.sum)
-		return next(dev, unlock_sum_steps,
-			    ARRAY_SIZE(unlock_sum_steps));
+		return execute_steps(dev, unlock_sum_steps,
+				     ARRAY_SIZE(unlock_sum_steps));
 	else
-		return next(dev, unlock_steps, ARRAY_SIZE(unlock_steps));
+		return execute_steps(dev, unlock_steps,
+				     ARRAY_SIZE(unlock_steps));
 }
 
 static int __opal_set_mbr_done(struct opal_dev *dev, struct opal_key *key)
@@ -2230,7 +2231,7 @@ static int __opal_set_mbr_done(struct opal_dev *dev, struct opal_key *key)
 		{ end_opal_session, }
 	};
 
-	return next(dev, mbrdone_step, ARRAY_SIZE(mbrdone_step));
+	return execute_steps(dev, mbrdone_step, ARRAY_SIZE(mbrdone_step));
 }
 
 static int opal_lock_unlock(struct opal_dev *dev,
@@ -2265,7 +2266,7 @@ static int opal_take_ownership(struct opal_dev *dev, struct opal_key *opal)
 
 	mutex_lock(&dev->dev_lock);
 	setup_opal_dev(dev);
-	ret = next(dev, owner_steps, ARRAY_SIZE(owner_steps));
+	ret = execute_steps(dev, owner_steps, ARRAY_SIZE(owner_steps));
 	mutex_unlock(&dev->dev_lock);
 	return ret;
 }
@@ -2286,7 +2287,7 @@ static int opal_activate_lsp(struct opal_dev *dev,
 
 	mutex_lock(&dev->dev_lock);
 	setup_opal_dev(dev);
-	ret = next(dev, active_steps, ARRAY_SIZE(active_steps));
+	ret = execute_steps(dev, active_steps, ARRAY_SIZE(active_steps));
 	mutex_unlock(&dev->dev_lock);
 	return ret;
 }
@@ -2303,7 +2304,7 @@ static int opal_setup_locking_range(struct opal_dev *dev,
 
 	mutex_lock(&dev->dev_lock);
 	setup_opal_dev(dev);
-	ret = next(dev, lr_steps, ARRAY_SIZE(lr_steps));
+	ret = execute_steps(dev, lr_steps, ARRAY_SIZE(lr_steps));
 	mutex_unlock(&dev->dev_lock);
 	return ret;
 }
@@ -2325,7 +2326,7 @@ static int opal_set_new_pw(struct opal_dev *dev, struct opal_new_pw *opal_pw)
 
 	mutex_lock(&dev->dev_lock);
 	setup_opal_dev(dev);
-	ret = next(dev, pw_steps, ARRAY_SIZE(pw_steps));
+	ret = execute_steps(dev, pw_steps, ARRAY_SIZE(pw_steps));
 	mutex_unlock(&dev->dev_lock);
 	return ret;
 }
@@ -2349,7 +2350,7 @@ static int opal_activate_user(struct opal_dev *dev,
 
 	mutex_lock(&dev->dev_lock);
 	setup_opal_dev(dev);
-	ret = next(dev, act_steps, ARRAY_SIZE(act_steps));
+	ret = execute_steps(dev, act_steps, ARRAY_SIZE(act_steps));
 	mutex_unlock(&dev->dev_lock);
 	return ret;
 }
-- 
2.20.1


Return-Path: <SRS0=aLpJ=QW=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 991C4C4360F
	for <linux-block@archiver.kernel.org>; Fri, 15 Feb 2019 16:11:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5BECB2192B
	for <linux-block@archiver.kernel.org>; Fri, 15 Feb 2019 16:11:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fjfi.cvut.cz header.i=@fjfi.cvut.cz header.b="UtrI75kJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730399AbfBOQLg (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 15 Feb 2019 11:11:36 -0500
Received: from mailgw1.fjfi.cvut.cz ([147.32.9.3]:43284 "EHLO
        mailgw1.fjfi.cvut.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726354AbfBOQLe (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 15 Feb 2019 11:11:34 -0500
Received: from localhost (localhost [127.0.0.1])
        by mailgw1.fjfi.cvut.cz (Postfix) with ESMTP id B4EFBAAD4D;
        Fri, 15 Feb 2019 17:11:31 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fjfi.cvut.cz;
        s=20151024; t=1550247091; i=@fjfi.cvut.cz;
        bh=CcTALm0rCGSrPSEFO5JMjD47CI9IdOjgOYt1TmoowXs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References;
        b=UtrI75kJouNKeLvwc0fD76ugOQ74VYMYO6BylPtRovzGBYqeYFQpYml+geZ/93bk4
         F8/ITY9zlXL/WLkKGbcRgdEduA1/8yinNx7REVqttT7g+teMIqtmsoyuvqpU/Q4IjO
         9t1w3/l4TIHpbG2AYooL8JkaDC50lMY0BRFl0WgM=
X-CTU-FNSPE-Virus-Scanned: amavisd-new at fjfi.cvut.cz
Received: from mailgw1.fjfi.cvut.cz ([127.0.0.1])
        by localhost (mailgw1.fjfi.cvut.cz [127.0.0.1]) (amavisd-new, port 10022)
        with ESMTP id Ggqqd4EZihJ7; Fri, 15 Feb 2019 17:11:26 +0100 (CET)
Received: from linux.fjfi.cvut.cz (linux.fjfi.cvut.cz [147.32.5.111])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mailgw1.fjfi.cvut.cz (Postfix) with ESMTPS id 51D87AA26F;
        Thu, 14 Feb 2019 01:17:10 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailgw1.fjfi.cvut.cz 51D87AA26F
Received: by linux.fjfi.cvut.cz (Postfix, from userid 1001)
        id 299926004E; Thu, 14 Feb 2019 01:17:10 +0100 (CET)
From:   David Kozub <zub@linux.fjfi.cvut.cz>
To:     Jens Axboe <axboe@kernel.dk>,
        Jonathan Derrick <jonathan.derrick@intel.com>,
        Scott Bauer <sbauer@plzdonthack.me>,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Jonas Rabenstein <jonas.rabenstein@studium.uni-erlangen.de>,
        David Kozub <zub@linux.fjfi.cvut.cz>
Subject: [PATCH 16/16] block: sed-opal: rename next to execute_steps
Date:   Thu, 14 Feb 2019 01:16:08 +0100
Message-Id: <1550103368-4605-17-git-send-email-zub@linux.fjfi.cvut.cz>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1550103368-4605-1-git-send-email-zub@linux.fjfi.cvut.cz>
References: <1550103368-4605-1-git-send-email-zub@linux.fjfi.cvut.cz>
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

As the function is responsible for executing the individual steps supplied
in the steps argument, execute_steps is a more descriptive name than the
rather generic next.

Signed-off-by: David Kozub <zub@linux.fjfi.cvut.cz>
Reviewed-by: Scott Bauer <sbauer@plzdonthack.me>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Jon Derrick <jonathan.derrick@intel.com>
---
 block/sed-opal.c | 33 +++++++++++++++++----------------
 1 file changed, 17 insertions(+), 16 deletions(-)

diff --git a/block/sed-opal.c b/block/sed-opal.c
index b947efd6d4d9..b1aa0cc25803 100644
--- a/block/sed-opal.c
+++ b/block/sed-opal.c
@@ -396,8 +396,8 @@ static int execute_step(struct opal_dev *dev,
 	return error;
 }
 
-static int next(struct opal_dev *dev, const struct opal_step *steps,
-		size_t n_steps)
+static int execute_steps(struct opal_dev *dev,
+			 const struct opal_step *steps, size_t n_steps)
 {
 	size_t state = 0;
 	int error;
@@ -1937,7 +1937,7 @@ static int opal_secure_erase_locking_range(struct opal_dev *dev,
 
 	mutex_lock(&dev->dev_lock);
 	setup_opal_dev(dev);
-	ret = next(dev, erase_steps, ARRAY_SIZE(erase_steps));
+	ret = execute_steps(dev, erase_steps, ARRAY_SIZE(erase_steps));
 	mutex_unlock(&dev->dev_lock);
 	return ret;
 }
@@ -1954,7 +1954,7 @@ static int opal_erase_locking_range(struct opal_dev *dev,
 
 	mutex_lock(&dev->dev_lock);
 	setup_opal_dev(dev);
-	ret = next(dev, erase_steps, ARRAY_SIZE(erase_steps));
+	ret = execute_steps(dev, erase_steps, ARRAY_SIZE(erase_steps));
 	mutex_unlock(&dev->dev_lock);
 	return ret;
 }
@@ -1981,7 +1981,7 @@ static int opal_enable_disable_shadow_mbr(struct opal_dev *dev,
 
 	mutex_lock(&dev->dev_lock);
 	setup_opal_dev(dev);
-	ret = next(dev, mbr_steps, ARRAY_SIZE(mbr_steps));
+	ret = execute_steps(dev, mbr_steps, ARRAY_SIZE(mbr_steps));
 	mutex_unlock(&dev->dev_lock);
 	return ret;
 }
@@ -2033,7 +2033,7 @@ static int opal_add_user_to_lr(struct opal_dev *dev,
 
 	mutex_lock(&dev->dev_lock);
 	setup_opal_dev(dev);
-	ret = next(dev, steps, ARRAY_SIZE(steps));
+	ret = execute_steps(dev, steps, ARRAY_SIZE(steps));
 	mutex_unlock(&dev->dev_lock);
 	return ret;
 }
@@ -2048,7 +2048,7 @@ static int opal_reverttper(struct opal_dev *dev, struct opal_key *opal)
 
 	mutex_lock(&dev->dev_lock);
 	setup_opal_dev(dev);
-	ret = next(dev, revert_steps, ARRAY_SIZE(revert_steps));
+	ret = execute_steps(dev, revert_steps, ARRAY_SIZE(revert_steps));
 	mutex_unlock(&dev->dev_lock);
 
 	/*
@@ -2076,10 +2076,11 @@ static int __opal_lock_unlock(struct opal_dev *dev,
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
@@ -2091,7 +2092,7 @@ static int __opal_set_mbr_done(struct opal_dev *dev, struct opal_key *key)
 		{ end_opal_session, }
 	};
 
-	return next(dev, mbrdone_step, ARRAY_SIZE(mbrdone_step));
+	return execute_steps(dev, mbrdone_step, ARRAY_SIZE(mbrdone_step));
 }
 
 static int opal_lock_unlock(struct opal_dev *dev,
@@ -2126,7 +2127,7 @@ static int opal_take_ownership(struct opal_dev *dev, struct opal_key *opal)
 
 	mutex_lock(&dev->dev_lock);
 	setup_opal_dev(dev);
-	ret = next(dev, owner_steps, ARRAY_SIZE(owner_steps));
+	ret = execute_steps(dev, owner_steps, ARRAY_SIZE(owner_steps));
 	mutex_unlock(&dev->dev_lock);
 	return ret;
 }
@@ -2147,7 +2148,7 @@ static int opal_activate_lsp(struct opal_dev *dev,
 
 	mutex_lock(&dev->dev_lock);
 	setup_opal_dev(dev);
-	ret = next(dev, active_steps, ARRAY_SIZE(active_steps));
+	ret = execute_steps(dev, active_steps, ARRAY_SIZE(active_steps));
 	mutex_unlock(&dev->dev_lock);
 	return ret;
 }
@@ -2164,7 +2165,7 @@ static int opal_setup_locking_range(struct opal_dev *dev,
 
 	mutex_lock(&dev->dev_lock);
 	setup_opal_dev(dev);
-	ret = next(dev, lr_steps, ARRAY_SIZE(lr_steps));
+	ret = execute_steps(dev, lr_steps, ARRAY_SIZE(lr_steps));
 	mutex_unlock(&dev->dev_lock);
 	return ret;
 }
@@ -2186,7 +2187,7 @@ static int opal_set_new_pw(struct opal_dev *dev, struct opal_new_pw *opal_pw)
 
 	mutex_lock(&dev->dev_lock);
 	setup_opal_dev(dev);
-	ret = next(dev, pw_steps, ARRAY_SIZE(pw_steps));
+	ret = execute_steps(dev, pw_steps, ARRAY_SIZE(pw_steps));
 	mutex_unlock(&dev->dev_lock);
 	return ret;
 }
@@ -2210,7 +2211,7 @@ static int opal_activate_user(struct opal_dev *dev,
 
 	mutex_lock(&dev->dev_lock);
 	setup_opal_dev(dev);
-	ret = next(dev, act_steps, ARRAY_SIZE(act_steps));
+	ret = execute_steps(dev, act_steps, ARRAY_SIZE(act_steps));
 	mutex_unlock(&dev->dev_lock);
 	return ret;
 }
-- 
2.20.1


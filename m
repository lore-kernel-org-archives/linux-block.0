Return-Path: <SRS0=Gtqi=QL=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 793D5C282C4
	for <linux-block@archiver.kernel.org>; Mon,  4 Feb 2019 11:18:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D559920815
	for <linux-block@archiver.kernel.org>; Mon,  4 Feb 2019 11:18:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fjfi.cvut.cz header.i=@fjfi.cvut.cz header.b="uwKjusG7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728605AbfBDLSu (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 4 Feb 2019 06:18:50 -0500
Received: from mailgw1.fjfi.cvut.cz ([147.32.9.3]:42626 "EHLO
        mailgw1.fjfi.cvut.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728568AbfBDLSu (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Mon, 4 Feb 2019 06:18:50 -0500
Received: from localhost (localhost [127.0.0.1])
        by mailgw1.fjfi.cvut.cz (Postfix) with ESMTP id 500DCA01A4;
        Mon,  4 Feb 2019 12:18:45 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fjfi.cvut.cz;
        s=20151024; t=1549279125; i=@fjfi.cvut.cz;
        bh=MU62U2EcEz0tPvxtD+ujPGtB+t2POSvh3S+OypS72+A=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References;
        b=uwKjusG7czNkPA8X3wImNs9ka0bb4NNdgubqTpgsNWctNnQYh4leaYOS2d7DMnJ+i
         F++quFFb94Dx5bvILi71jpyFp66oZjYeOMWxdKxD8ACpD+TENGwPAsduoDo26iumBh
         MPpiTRWutC7p2D2vUD584ocKM8prsjlV+6uBKcPk=
X-CTU-FNSPE-Virus-Scanned: amavisd-new at fjfi.cvut.cz
Received: from mailgw1.fjfi.cvut.cz ([127.0.0.1])
        by localhost (mailgw1.fjfi.cvut.cz [127.0.0.1]) (amavisd-new, port 10022)
        with ESMTP id 1w52gO0uXpW2; Mon,  4 Feb 2019 12:18:38 +0100 (CET)
Received: from linux.fjfi.cvut.cz (linux.fjfi.cvut.cz [147.32.5.111])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mailgw1.fjfi.cvut.cz (Postfix) with ESMTPS id 634FBAD12C;
        Fri,  1 Feb 2019 21:50:56 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailgw1.fjfi.cvut.cz 634FBAD12C
Received: by linux.fjfi.cvut.cz (Postfix, from userid 1001)
        id 472BA6004E; Fri,  1 Feb 2019 21:50:56 +0100 (CET)
From:   David Kozub <zub@linux.fjfi.cvut.cz>
To:     Jens Axboe <axboe@kernel.dk>,
        Jonathan Derrick <jonathan.derrick@intel.com>,
        Scott Bauer <sbauer@plzdonthack.me>,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Jonas Rabenstein <jonas.rabenstein@studium.uni-erlangen.de>,
        David Kozub <zub@linux.fjfi.cvut.cz>
Subject: [PATCH v4 16/16] block: sed-opal: rename next to execute_steps
Date:   Fri,  1 Feb 2019 21:50:23 +0100
Message-Id: <1549054223-12220-17-git-send-email-zub@linux.fjfi.cvut.cz>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1549054223-12220-1-git-send-email-zub@linux.fjfi.cvut.cz>
References: <1549054223-12220-1-git-send-email-zub@linux.fjfi.cvut.cz>
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

As the function is responsible for executing the individual steps supplied
in the steps argument, execute_steps is a more descriptive name than the
rather generic next.

Signed-off-by: David Kozub <zub@linux.fjfi.cvut.cz>
Reviewed-by: Scott Bauer <sbauer@plzdonthack.me>
---
 block/sed-opal.c | 37 +++++++++++++++++++------------------
 1 file changed, 19 insertions(+), 18 deletions(-)

diff --git a/block/sed-opal.c b/block/sed-opal.c
index 3362741dd198..c09149dd5e0a 100644
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
@@ -2034,7 +2034,7 @@ static int opal_secure_erase_locking_range(struct opal_dev *dev,
 
 	mutex_lock(&dev->dev_lock);
 	setup_opal_dev(dev);
-	ret = next(dev, erase_steps, ARRAY_SIZE(erase_steps));
+	ret = execute_steps(dev, erase_steps, ARRAY_SIZE(erase_steps));
 	mutex_unlock(&dev->dev_lock);
 	return ret;
 }
@@ -2051,7 +2051,7 @@ static int opal_erase_locking_range(struct opal_dev *dev,
 
 	mutex_lock(&dev->dev_lock);
 	setup_opal_dev(dev);
-	ret = next(dev, erase_steps, ARRAY_SIZE(erase_steps));
+	ret = execute_steps(dev, erase_steps, ARRAY_SIZE(erase_steps));
 	mutex_unlock(&dev->dev_lock);
 	return ret;
 }
@@ -2077,7 +2077,7 @@ static int opal_enable_disable_shadow_mbr(struct opal_dev *dev,
 
 	mutex_lock(&dev->dev_lock);
 	setup_opal_dev(dev);
-	ret = next(dev, mbr_steps, ARRAY_SIZE(mbr_steps));
+	ret = execute_steps(dev, mbr_steps, ARRAY_SIZE(mbr_steps));
 	mutex_unlock(&dev->dev_lock);
 	return ret;
 }
@@ -2099,7 +2099,7 @@ static int opal_mbr_status(struct opal_dev *dev, struct opal_mbr_data *opal_mbr)
 
 	mutex_lock(&dev->dev_lock);
 	setup_opal_dev(dev);
-	ret = next(dev, mbr_steps, ARRAY_SIZE(mbr_steps));
+	ret = execute_steps(dev, mbr_steps, ARRAY_SIZE(mbr_steps));
 	mutex_unlock(&dev->dev_lock);
 	return ret;
 }
@@ -2122,7 +2122,7 @@ static int opal_write_shadow_mbr(struct opal_dev *dev,
 
 	mutex_lock(&dev->dev_lock);
 	setup_opal_dev(dev);
-	ret = next(dev, mbr_steps, ARRAY_SIZE(mbr_steps));
+	ret = execute_steps(dev, mbr_steps, ARRAY_SIZE(mbr_steps));
 	mutex_unlock(&dev->dev_lock);
 	return ret;
 }
@@ -2174,7 +2174,7 @@ static int opal_add_user_to_lr(struct opal_dev *dev,
 
 	mutex_lock(&dev->dev_lock);
 	setup_opal_dev(dev);
-	ret = next(dev, steps, ARRAY_SIZE(steps));
+	ret = execute_steps(dev, steps, ARRAY_SIZE(steps));
 	mutex_unlock(&dev->dev_lock);
 	return ret;
 }
@@ -2189,7 +2189,7 @@ static int opal_reverttper(struct opal_dev *dev, struct opal_key *opal)
 
 	mutex_lock(&dev->dev_lock);
 	setup_opal_dev(dev);
-	ret = next(dev, revert_steps, ARRAY_SIZE(revert_steps));
+	ret = execute_steps(dev, revert_steps, ARRAY_SIZE(revert_steps));
 	mutex_unlock(&dev->dev_lock);
 
 	/*
@@ -2217,10 +2217,11 @@ static int __opal_lock_unlock(struct opal_dev *dev,
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
@@ -2232,7 +2233,7 @@ static int __opal_set_mbr_done(struct opal_dev *dev, struct opal_key *key)
 		{ end_opal_session, }
 	};
 
-	return next(dev, mbrdone_step, ARRAY_SIZE(mbrdone_step));
+	return execute_steps(dev, mbrdone_step, ARRAY_SIZE(mbrdone_step));
 }
 
 static int opal_lock_unlock(struct opal_dev *dev,
@@ -2267,7 +2268,7 @@ static int opal_take_ownership(struct opal_dev *dev, struct opal_key *opal)
 
 	mutex_lock(&dev->dev_lock);
 	setup_opal_dev(dev);
-	ret = next(dev, owner_steps, ARRAY_SIZE(owner_steps));
+	ret = execute_steps(dev, owner_steps, ARRAY_SIZE(owner_steps));
 	mutex_unlock(&dev->dev_lock);
 	return ret;
 }
@@ -2288,7 +2289,7 @@ static int opal_activate_lsp(struct opal_dev *dev,
 
 	mutex_lock(&dev->dev_lock);
 	setup_opal_dev(dev);
-	ret = next(dev, active_steps, ARRAY_SIZE(active_steps));
+	ret = execute_steps(dev, active_steps, ARRAY_SIZE(active_steps));
 	mutex_unlock(&dev->dev_lock);
 	return ret;
 }
@@ -2305,7 +2306,7 @@ static int opal_setup_locking_range(struct opal_dev *dev,
 
 	mutex_lock(&dev->dev_lock);
 	setup_opal_dev(dev);
-	ret = next(dev, lr_steps, ARRAY_SIZE(lr_steps));
+	ret = execute_steps(dev, lr_steps, ARRAY_SIZE(lr_steps));
 	mutex_unlock(&dev->dev_lock);
 	return ret;
 }
@@ -2327,7 +2328,7 @@ static int opal_set_new_pw(struct opal_dev *dev, struct opal_new_pw *opal_pw)
 
 	mutex_lock(&dev->dev_lock);
 	setup_opal_dev(dev);
-	ret = next(dev, pw_steps, ARRAY_SIZE(pw_steps));
+	ret = execute_steps(dev, pw_steps, ARRAY_SIZE(pw_steps));
 	mutex_unlock(&dev->dev_lock);
 	return ret;
 }
@@ -2351,7 +2352,7 @@ static int opal_activate_user(struct opal_dev *dev,
 
 	mutex_lock(&dev->dev_lock);
 	setup_opal_dev(dev);
-	ret = next(dev, act_steps, ARRAY_SIZE(act_steps));
+	ret = execute_steps(dev, act_steps, ARRAY_SIZE(act_steps));
 	mutex_unlock(&dev->dev_lock);
 	return ret;
 }
-- 
2.20.1


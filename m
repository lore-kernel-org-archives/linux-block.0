Return-Path: <SRS0=Oz1R=QV=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB50DC43381
	for <linux-block@archiver.kernel.org>; Thu, 14 Feb 2019 00:17:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 86B6321920
	for <linux-block@archiver.kernel.org>; Thu, 14 Feb 2019 00:17:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fjfi.cvut.cz header.i=@fjfi.cvut.cz header.b="r/7LMe9G"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404840AbfBNARW (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 13 Feb 2019 19:17:22 -0500
Received: from mailgw1.fjfi.cvut.cz ([147.32.9.3]:47752 "EHLO
        mailgw1.fjfi.cvut.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2393605AbfBNARV (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 13 Feb 2019 19:17:21 -0500
Received: from localhost (localhost [127.0.0.1])
        by mailgw1.fjfi.cvut.cz (Postfix) with ESMTP id 5658DAA25C;
        Thu, 14 Feb 2019 01:17:16 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fjfi.cvut.cz;
        s=20151024; t=1550103436; i=@fjfi.cvut.cz;
        bh=IluV0/fEDgG9s6Kegfa1P59A1RBx1Mv3QN22BSgLaws=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References;
        b=r/7LMe9GysTX0hj0o/CdcqrMhEIRKT3zzypGli7F9aLznwdm709RcknciZONVknvZ
         AQw5z/FVhHkeVnkI4LtchBD7vvpyJTJqJYwOodN2OykSM+q7kirJiI1Ft5eORNnpF1
         dfPAt6AygFf0VOkkDQHf20+NDk/IfGE8rq2Pptfk=
X-CTU-FNSPE-Virus-Scanned: amavisd-new at fjfi.cvut.cz
Received: from mailgw1.fjfi.cvut.cz ([127.0.0.1])
        by localhost (mailgw1.fjfi.cvut.cz [127.0.0.1]) (amavisd-new, port 10022)
        with ESMTP id tD-y8TaBvLgL; Thu, 14 Feb 2019 01:17:08 +0100 (CET)
Received: from linux.fjfi.cvut.cz (linux.fjfi.cvut.cz [147.32.5.111])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mailgw1.fjfi.cvut.cz (Postfix) with ESMTPS id DE112AA295;
        Thu, 14 Feb 2019 01:17:05 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailgw1.fjfi.cvut.cz DE112AA295
Received: by linux.fjfi.cvut.cz (Postfix, from userid 1001)
        id BD10A6004E; Thu, 14 Feb 2019 01:17:05 +0100 (CET)
From:   David Kozub <zub@linux.fjfi.cvut.cz>
To:     Jens Axboe <axboe@kernel.dk>,
        Jonathan Derrick <jonathan.derrick@intel.com>,
        Scott Bauer <sbauer@plzdonthack.me>,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Jonas Rabenstein <jonas.rabenstein@studium.uni-erlangen.de>,
        David Kozub <zub@linux.fjfi.cvut.cz>
Subject: [PATCH 14/16] block: sed-opal: pass steps via argument rather than via opal_dev
Date:   Thu, 14 Feb 2019 01:16:06 +0100
Message-Id: <1550103368-4605-15-git-send-email-zub@linux.fjfi.cvut.cz>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1550103368-4605-1-git-send-email-zub@linux.fjfi.cvut.cz>
References: <1550103368-4605-1-git-send-email-zub@linux.fjfi.cvut.cz>
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

The steps argument is only read by the next function, so it can
be passed directly as an argument rather than via opal_dev.

Normally, the steps is an array on the stack, so the pointer stops
being valid then the function that set opal_dev.steps returns.
If opal_dev.steps was not set to NULL before return it would become
a dangling pointer. When the steps are passed as argument this
becomes easier to see and more difficult to misuse.

Signed-off-by: David Kozub <zub@linux.fjfi.cvut.cz>
---
 block/sed-opal.c | 158 +++++++++++++++++++++--------------------------
 1 file changed, 69 insertions(+), 89 deletions(-)

diff --git a/block/sed-opal.c b/block/sed-opal.c
index be0d633783c8..f027c0cb682e 100644
--- a/block/sed-opal.c
+++ b/block/sed-opal.c
@@ -85,7 +85,6 @@ struct opal_dev {
 	void *data;
 	sec_send_recv *send_recv;
 
-	const struct opal_step *steps;
 	struct mutex dev_lock;
 	u16 comid;
 	u32 hsn;
@@ -382,37 +381,34 @@ static void check_geometry(struct opal_dev *dev, const void *data)
 	dev->lowest_lba = geo->lowest_aligned_lba;
 }
 
-static int next(struct opal_dev *dev)
+static int next(struct opal_dev *dev, const struct opal_step *steps,
+		size_t n_steps)
 {
 	const struct opal_step *step;
-	int state = 0, error = 0;
+	size_t state;
+	int error = 0;
 
-	do {
-		step = &dev->steps[state];
-		if (!step->fn)
-			break;
+	for (state = 0; state < n_steps; state++) {
+		step = &steps[state];
 
 		error = step->fn(dev, step->data);
-		if (error) {
-			pr_debug("Step %d (%pS) failed with error %d: %s\n",
-				 state, step->fn, error,
-				 opal_error_to_human(error));
-
-			/* For each OPAL command we do a discovery0 then we
-			 * start some sort of session.
-			 * If we haven't passed state 1 then there was an error
-			 * on discovery0 or during the attempt to start a
-			 * session. Therefore we shouldn't attempt to terminate
-			 * a session, as one has not yet been created.
-			 */
-			if (state > 1) {
-				end_opal_session_error(dev);
-				return error;
-			}
+		if (error)
+			goto out_error;
+	}
 
-		}
-		state++;
-	} while (!error);
+	return 0;
+
+out_error:
+	/*
+	 * For each OPAL command the first step in steps does a discovery0
+	 * and the second step starts some sort of session. If an error occurred
+	 * in the first two steps (and thus stopping the loop with state <= 1)
+	 * then there was an error before or during the attempt to start a
+	 * session. Therefore we shouldn't attempt to terminate a session, as
+	 * one has not yet been created.
+	 */
+	if (state > 1)
+		end_opal_session_error(dev);
 
 	return error;
 }
@@ -1836,17 +1832,13 @@ static int end_opal_session(struct opal_dev *dev, void *data)
 static int end_opal_session_error(struct opal_dev *dev)
 {
 	const struct opal_step error_end_session[] = {
-		{ end_opal_session, },
-		{ NULL, }
+		{ end_opal_session, }
 	};
-	dev->steps = error_end_session;
-	return next(dev);
+	return next(dev, error_end_session, ARRAY_SIZE(error_end_session));
 }
 
-static inline void setup_opal_dev(struct opal_dev *dev,
-				  const struct opal_step *steps)
+static inline void setup_opal_dev(struct opal_dev *dev)
 {
-	dev->steps = steps;
 	dev->tsn = 0;
 	dev->hsn = 0;
 	dev->prev_data = NULL;
@@ -1855,14 +1847,13 @@ static inline void setup_opal_dev(struct opal_dev *dev,
 static int check_opal_support(struct opal_dev *dev)
 {
 	const struct opal_step steps[] = {
-		{ opal_discovery0, },
-		{ NULL, }
+		{ opal_discovery0, }
 	};
 	int ret;
 
 	mutex_lock(&dev->dev_lock);
-	setup_opal_dev(dev, steps);
-	ret = next(dev);
+	setup_opal_dev(dev);
+	ret = next(dev, steps, ARRAY_SIZE(steps));
 	dev->supported = !ret;
 	mutex_unlock(&dev->dev_lock);
 	return ret;
@@ -1919,14 +1910,13 @@ static int opal_secure_erase_locking_range(struct opal_dev *dev,
 		{ start_auth_opal_session, opal_session },
 		{ get_active_key, &opal_session->opal_key.lr },
 		{ gen_key, },
-		{ end_opal_session, },
-		{ NULL, }
+		{ end_opal_session, }
 	};
 	int ret;
 
 	mutex_lock(&dev->dev_lock);
-	setup_opal_dev(dev, erase_steps);
-	ret = next(dev);
+	setup_opal_dev(dev);
+	ret = next(dev, erase_steps, ARRAY_SIZE(erase_steps));
 	mutex_unlock(&dev->dev_lock);
 	return ret;
 }
@@ -1938,14 +1928,13 @@ static int opal_erase_locking_range(struct opal_dev *dev,
 		{ opal_discovery0, },
 		{ start_auth_opal_session, opal_session },
 		{ erase_locking_range, opal_session },
-		{ end_opal_session, },
-		{ NULL, }
+		{ end_opal_session, }
 	};
 	int ret;
 
 	mutex_lock(&dev->dev_lock);
-	setup_opal_dev(dev, erase_steps);
-	ret = next(dev);
+	setup_opal_dev(dev);
+	ret = next(dev, erase_steps, ARRAY_SIZE(erase_steps));
 	mutex_unlock(&dev->dev_lock);
 	return ret;
 }
@@ -1963,8 +1952,7 @@ static int opal_enable_disable_shadow_mbr(struct opal_dev *dev,
 		{ end_opal_session, },
 		{ start_admin1LSP_opal_session, &opal_mbr->key },
 		{ set_mbr_enable_disable, &enable_disable },
-		{ end_opal_session, },
-		{ NULL, }
+		{ end_opal_session, }
 	};
 	int ret;
 
@@ -1973,8 +1961,8 @@ static int opal_enable_disable_shadow_mbr(struct opal_dev *dev,
 		return -EINVAL;
 
 	mutex_lock(&dev->dev_lock);
-	setup_opal_dev(dev, mbr_steps);
-	ret = next(dev);
+	setup_opal_dev(dev);
+	ret = next(dev, mbr_steps, ARRAY_SIZE(mbr_steps));
 	mutex_unlock(&dev->dev_lock);
 	return ret;
 }
@@ -1991,7 +1979,7 @@ static int opal_save(struct opal_dev *dev, struct opal_lock_unlock *lk_unlk)
 	suspend->lr = lk_unlk->session.opal_key.lr;
 
 	mutex_lock(&dev->dev_lock);
-	setup_opal_dev(dev, NULL);
+	setup_opal_dev(dev);
 	add_suspend_info(dev, suspend);
 	mutex_unlock(&dev->dev_lock);
 	return 0;
@@ -2004,8 +1992,7 @@ static int opal_add_user_to_lr(struct opal_dev *dev,
 		{ opal_discovery0, },
 		{ start_admin1LSP_opal_session, &lk_unlk->session.opal_key },
 		{ add_user_to_lr, lk_unlk },
-		{ end_opal_session, },
-		{ NULL, }
+		{ end_opal_session, }
 	};
 	int ret;
 
@@ -2027,8 +2014,8 @@ static int opal_add_user_to_lr(struct opal_dev *dev,
 	}
 
 	mutex_lock(&dev->dev_lock);
-	setup_opal_dev(dev, steps);
-	ret = next(dev);
+	setup_opal_dev(dev);
+	ret = next(dev, steps, ARRAY_SIZE(steps));
 	mutex_unlock(&dev->dev_lock);
 	return ret;
 }
@@ -2038,14 +2025,13 @@ static int opal_reverttper(struct opal_dev *dev, struct opal_key *opal)
 	const struct opal_step revert_steps[] = {
 		{ opal_discovery0, },
 		{ start_SIDASP_opal_session, opal },
-		{ revert_tper, }, /* controller will terminate session */
-		{ NULL, }
+		{ revert_tper, } /* controller will terminate session */
 	};
 	int ret;
 
 	mutex_lock(&dev->dev_lock);
-	setup_opal_dev(dev, revert_steps);
-	ret = next(dev);
+	setup_opal_dev(dev);
+	ret = next(dev, revert_steps, ARRAY_SIZE(revert_steps));
 	mutex_unlock(&dev->dev_lock);
 
 	/*
@@ -2065,19 +2051,20 @@ static int __opal_lock_unlock(struct opal_dev *dev,
 		{ opal_discovery0, },
 		{ start_auth_opal_session, &lk_unlk->session },
 		{ lock_unlock_locking_range, lk_unlk },
-		{ end_opal_session, },
-		{ NULL, }
+		{ end_opal_session, }
 	};
 	const struct opal_step unlock_sum_steps[] = {
 		{ opal_discovery0, },
 		{ start_auth_opal_session, &lk_unlk->session },
 		{ lock_unlock_locking_range_sum, lk_unlk },
-		{ end_opal_session, },
-		{ NULL, }
+		{ end_opal_session, }
 	};
 
-	dev->steps = lk_unlk->session.sum ? unlock_sum_steps : unlock_steps;
-	return next(dev);
+	if (lk_unlk->session.sum)
+		return next(dev, unlock_sum_steps,
+			    ARRAY_SIZE(unlock_sum_steps));
+	else
+		return next(dev, unlock_steps, ARRAY_SIZE(unlock_steps));
 }
 
 static int __opal_set_mbr_done(struct opal_dev *dev, struct opal_key *key)
@@ -2087,12 +2074,10 @@ static int __opal_set_mbr_done(struct opal_dev *dev, struct opal_key *key)
 		{ opal_discovery0, },
 		{ start_admin1LSP_opal_session, key },
 		{ set_mbr_done, &mbr_done_tf },
-		{ end_opal_session, },
-		{ NULL, }
+		{ end_opal_session, }
 	};
 
-	dev->steps = mbrdone_step;
-	return next(dev);
+	return next(dev, mbrdone_step, ARRAY_SIZE(mbrdone_step));
 }
 
 static int opal_lock_unlock(struct opal_dev *dev,
@@ -2119,8 +2104,7 @@ static int opal_take_ownership(struct opal_dev *dev, struct opal_key *opal)
 		{ end_opal_session, },
 		{ start_SIDASP_opal_session, opal },
 		{ set_sid_cpin_pin, opal },
-		{ end_opal_session, },
-		{ NULL, }
+		{ end_opal_session, }
 	};
 	int ret;
 
@@ -2128,8 +2112,8 @@ static int opal_take_ownership(struct opal_dev *dev, struct opal_key *opal)
 		return -ENODEV;
 
 	mutex_lock(&dev->dev_lock);
-	setup_opal_dev(dev, owner_steps);
-	ret = next(dev);
+	setup_opal_dev(dev);
+	ret = next(dev, owner_steps, ARRAY_SIZE(owner_steps));
 	mutex_unlock(&dev->dev_lock);
 	return ret;
 }
@@ -2142,8 +2126,7 @@ static int opal_activate_lsp(struct opal_dev *dev,
 		{ start_SIDASP_opal_session, &opal_lr_act->key },
 		{ get_lsp_lifecycle, },
 		{ activate_lsp, opal_lr_act },
-		{ end_opal_session, },
-		{ NULL, }
+		{ end_opal_session, }
 	};
 	int ret;
 
@@ -2151,8 +2134,8 @@ static int opal_activate_lsp(struct opal_dev *dev,
 		return -EINVAL;
 
 	mutex_lock(&dev->dev_lock);
-	setup_opal_dev(dev, active_steps);
-	ret = next(dev);
+	setup_opal_dev(dev);
+	ret = next(dev, active_steps, ARRAY_SIZE(active_steps));
 	mutex_unlock(&dev->dev_lock);
 	return ret;
 }
@@ -2164,14 +2147,13 @@ static int opal_setup_locking_range(struct opal_dev *dev,
 		{ opal_discovery0, },
 		{ start_auth_opal_session, &opal_lrs->session },
 		{ setup_locking_range, opal_lrs },
-		{ end_opal_session, },
-		{ NULL, }
+		{ end_opal_session, }
 	};
 	int ret;
 
 	mutex_lock(&dev->dev_lock);
-	setup_opal_dev(dev, lr_steps);
-	ret = next(dev);
+	setup_opal_dev(dev);
+	ret = next(dev, lr_steps, ARRAY_SIZE(lr_steps));
 	mutex_unlock(&dev->dev_lock);
 	return ret;
 }
@@ -2182,8 +2164,7 @@ static int opal_set_new_pw(struct opal_dev *dev, struct opal_new_pw *opal_pw)
 		{ opal_discovery0, },
 		{ start_auth_opal_session, &opal_pw->session },
 		{ set_new_pw, &opal_pw->new_user_pw },
-		{ end_opal_session, },
-		{ NULL }
+		{ end_opal_session, }
 	};
 	int ret;
 
@@ -2194,8 +2175,8 @@ static int opal_set_new_pw(struct opal_dev *dev, struct opal_new_pw *opal_pw)
 		return -EINVAL;
 
 	mutex_lock(&dev->dev_lock);
-	setup_opal_dev(dev, pw_steps);
-	ret = next(dev);
+	setup_opal_dev(dev);
+	ret = next(dev, pw_steps, ARRAY_SIZE(pw_steps));
 	mutex_unlock(&dev->dev_lock);
 	return ret;
 }
@@ -2207,8 +2188,7 @@ static int opal_activate_user(struct opal_dev *dev,
 		{ opal_discovery0, },
 		{ start_admin1LSP_opal_session, &opal_session->opal_key },
 		{ internal_activate_user, opal_session },
-		{ end_opal_session, },
-		{ NULL, }
+		{ end_opal_session, }
 	};
 	int ret;
 
@@ -2220,8 +2200,8 @@ static int opal_activate_user(struct opal_dev *dev,
 	}
 
 	mutex_lock(&dev->dev_lock);
-	setup_opal_dev(dev, act_steps);
-	ret = next(dev);
+	setup_opal_dev(dev);
+	ret = next(dev, act_steps, ARRAY_SIZE(act_steps));
 	mutex_unlock(&dev->dev_lock);
 	return ret;
 }
@@ -2238,7 +2218,7 @@ bool opal_unlock_from_suspend(struct opal_dev *dev)
 		return false;
 
 	mutex_lock(&dev->dev_lock);
-	setup_opal_dev(dev, NULL);
+	setup_opal_dev(dev);
 
 	list_for_each_entry(suspend, &dev->unlk_lst, node) {
 		dev->tsn = 0;
-- 
2.20.1


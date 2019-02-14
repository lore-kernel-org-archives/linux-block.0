Return-Path: <SRS0=Oz1R=QV=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68FB7C4360F
	for <linux-block@archiver.kernel.org>; Thu, 14 Feb 2019 00:17:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 24CA4222CC
	for <linux-block@archiver.kernel.org>; Thu, 14 Feb 2019 00:17:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fjfi.cvut.cz header.i=@fjfi.cvut.cz header.b="TrKI/tUr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393553AbfBNAR2 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 13 Feb 2019 19:17:28 -0500
Received: from mailgw1.fjfi.cvut.cz ([147.32.9.3]:47832 "EHLO
        mailgw1.fjfi.cvut.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404863AbfBNAR2 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 13 Feb 2019 19:17:28 -0500
Received: from localhost (localhost [127.0.0.1])
        by mailgw1.fjfi.cvut.cz (Postfix) with ESMTP id 0E031AA288;
        Thu, 14 Feb 2019 01:17:24 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fjfi.cvut.cz;
        s=20151024; t=1550103444; i=@fjfi.cvut.cz;
        bh=MbOSwvGCyBFxM4wt4ePGdXq4U5j2IXIy8e9gki0t2fY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References;
        b=TrKI/tUrUpl+7aPDMg/66x1pj0WEc2JlBBv84igBiIUjW+s/sSGlK6mJ0SrTzW3U+
         TpeF6KHMxl8gi29FuF5Jy+HyP4k5zcYwwkspDu9esZsmH2jC38ks1CgxhTtyDHiWKd
         uq5+F5+OwHCdBJkVAgQLMp27IF1XJpN87gby8StY=
X-CTU-FNSPE-Virus-Scanned: amavisd-new at fjfi.cvut.cz
Received: from mailgw1.fjfi.cvut.cz ([127.0.0.1])
        by localhost (mailgw1.fjfi.cvut.cz [127.0.0.1]) (amavisd-new, port 10022)
        with ESMTP id nH8I364iX69J; Thu, 14 Feb 2019 01:17:16 +0100 (CET)
Received: from linux.fjfi.cvut.cz (linux.fjfi.cvut.cz [147.32.5.111])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mailgw1.fjfi.cvut.cz (Postfix) with ESMTPS id 32D0AAA285;
        Thu, 14 Feb 2019 01:17:08 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailgw1.fjfi.cvut.cz 32D0AAA285
Received: by linux.fjfi.cvut.cz (Postfix, from userid 1001)
        id 0AB316004E; Thu, 14 Feb 2019 01:17:07 +0100 (CET)
From:   David Kozub <zub@linux.fjfi.cvut.cz>
To:     Jens Axboe <axboe@kernel.dk>,
        Jonathan Derrick <jonathan.derrick@intel.com>,
        Scott Bauer <sbauer@plzdonthack.me>,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Jonas Rabenstein <jonas.rabenstein@studium.uni-erlangen.de>,
        David Kozub <zub@linux.fjfi.cvut.cz>
Subject: [PATCH 15/16] block: sed-opal: don't repeat opal_discovery0 in each steps array
Date:   Thu, 14 Feb 2019 01:16:07 +0100
Message-Id: <1550103368-4605-16-git-send-email-zub@linux.fjfi.cvut.cz>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1550103368-4605-1-git-send-email-zub@linux.fjfi.cvut.cz>
References: <1550103368-4605-1-git-send-email-zub@linux.fjfi.cvut.cz>
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Originally each of the opal functions that call next include
opal_discovery0 in the array of steps. This is superfluous and
can be done always inside next.

Signed-off-by: David Kozub <zub@linux.fjfi.cvut.cz>
---
 block/sed-opal.c | 75 +++++++++++++++++++++++++++---------------------
 1 file changed, 42 insertions(+), 33 deletions(-)

diff --git a/block/sed-opal.c b/block/sed-opal.c
index f027c0cb682e..b947efd6d4d9 100644
--- a/block/sed-opal.c
+++ b/block/sed-opal.c
@@ -216,6 +216,7 @@ static const u8 opalmethod[][OPAL_METHOD_LENGTH] = {
 };
 
 static int end_opal_session_error(struct opal_dev *dev);
+static int opal_discovery0_step(struct opal_dev *dev);
 
 struct opal_suspend_data {
 	struct opal_lock_unlock unlk;
@@ -381,17 +382,33 @@ static void check_geometry(struct opal_dev *dev, const void *data)
 	dev->lowest_lba = geo->lowest_aligned_lba;
 }
 
+static int execute_step(struct opal_dev *dev,
+			const struct opal_step *step, size_t stepIndex)
+{
+	int error = step->fn(dev, step->data);
+
+	if (error) {
+		pr_debug("Step %zu (%pS) failed with error %d: %s\n",
+			 stepIndex, step->fn, error,
+			 opal_error_to_human(error));
+	}
+
+	return error;
+}
+
 static int next(struct opal_dev *dev, const struct opal_step *steps,
 		size_t n_steps)
 {
-	const struct opal_step *step;
-	size_t state;
-	int error = 0;
+	size_t state = 0;
+	int error;
 
-	for (state = 0; state < n_steps; state++) {
-		step = &steps[state];
+	/* first do a discovery0 */
+	error = opal_discovery0_step(dev);
+	if (error)
+		return error;
 
-		error = step->fn(dev, step->data);
+	for (state = 0; state < n_steps; state++) {
+		error = execute_step(dev, &steps[state], state);
 		if (error)
 			goto out_error;
 	}
@@ -400,14 +417,14 @@ static int next(struct opal_dev *dev, const struct opal_step *steps,
 
 out_error:
 	/*
-	 * For each OPAL command the first step in steps does a discovery0
-	 * and the second step starts some sort of session. If an error occurred
-	 * in the first two steps (and thus stopping the loop with state <= 1)
-	 * then there was an error before or during the attempt to start a
-	 * session. Therefore we shouldn't attempt to terminate a session, as
-	 * one has not yet been created.
+	 * For each OPAL command the first step in steps starts some sort of
+	 * session. If an error occurred in the initial discovery0 or if an
+	 * error occurred in the first step (and thus stopping the loop with
+	 * state == 0) then there was an error before or during the attempt to
+	 * start a session. Therefore we shouldn't attempt to terminate a
+	 * session, as one has not yet been created.
 	 */
-	if (state > 1)
+	if (state > 0)
 		end_opal_session_error(dev);
 
 	return error;
@@ -506,6 +523,14 @@ static int opal_discovery0(struct opal_dev *dev, void *data)
 	return opal_discovery0_end(dev);
 }
 
+static int opal_discovery0_step(struct opal_dev *dev)
+{
+	const struct opal_step discovery0_step = {
+		opal_discovery0,
+	};
+	return execute_step(dev, &discovery0_step, 0);
+}
+
 static bool can_add(int *err, struct opal_dev *cmd, size_t len)
 {
 	if (*err)
@@ -1831,10 +1856,10 @@ static int end_opal_session(struct opal_dev *dev, void *data)
 
 static int end_opal_session_error(struct opal_dev *dev)
 {
-	const struct opal_step error_end_session[] = {
-		{ end_opal_session, }
+	const struct opal_step error_end_session = {
+		end_opal_session,
 	};
-	return next(dev, error_end_session, ARRAY_SIZE(error_end_session));
+	return execute_step(dev, &error_end_session, 0);
 }
 
 static inline void setup_opal_dev(struct opal_dev *dev)
@@ -1846,14 +1871,11 @@ static inline void setup_opal_dev(struct opal_dev *dev)
 
 static int check_opal_support(struct opal_dev *dev)
 {
-	const struct opal_step steps[] = {
-		{ opal_discovery0, }
-	};
 	int ret;
 
 	mutex_lock(&dev->dev_lock);
 	setup_opal_dev(dev);
-	ret = next(dev, steps, ARRAY_SIZE(steps));
+	ret = opal_discovery0_step(dev);
 	dev->supported = !ret;
 	mutex_unlock(&dev->dev_lock);
 	return ret;
@@ -1906,7 +1928,6 @@ static int opal_secure_erase_locking_range(struct opal_dev *dev,
 					   struct opal_session_info *opal_session)
 {
 	const struct opal_step erase_steps[] = {
-		{ opal_discovery0, },
 		{ start_auth_opal_session, opal_session },
 		{ get_active_key, &opal_session->opal_key.lr },
 		{ gen_key, },
@@ -1925,7 +1946,6 @@ static int opal_erase_locking_range(struct opal_dev *dev,
 				    struct opal_session_info *opal_session)
 {
 	const struct opal_step erase_steps[] = {
-		{ opal_discovery0, },
 		{ start_auth_opal_session, opal_session },
 		{ erase_locking_range, opal_session },
 		{ end_opal_session, }
@@ -1946,7 +1966,6 @@ static int opal_enable_disable_shadow_mbr(struct opal_dev *dev,
 		OPAL_TRUE : OPAL_FALSE;
 
 	const struct opal_step mbr_steps[] = {
-		{ opal_discovery0, },
 		{ start_admin1LSP_opal_session, &opal_mbr->key },
 		{ set_mbr_done, &enable_disable },
 		{ end_opal_session, },
@@ -1989,7 +2008,6 @@ static int opal_add_user_to_lr(struct opal_dev *dev,
 			       struct opal_lock_unlock *lk_unlk)
 {
 	const struct opal_step steps[] = {
-		{ opal_discovery0, },
 		{ start_admin1LSP_opal_session, &lk_unlk->session.opal_key },
 		{ add_user_to_lr, lk_unlk },
 		{ end_opal_session, }
@@ -2023,7 +2041,6 @@ static int opal_add_user_to_lr(struct opal_dev *dev,
 static int opal_reverttper(struct opal_dev *dev, struct opal_key *opal)
 {
 	const struct opal_step revert_steps[] = {
-		{ opal_discovery0, },
 		{ start_SIDASP_opal_session, opal },
 		{ revert_tper, } /* controller will terminate session */
 	};
@@ -2048,13 +2065,11 @@ static int __opal_lock_unlock(struct opal_dev *dev,
 			      struct opal_lock_unlock *lk_unlk)
 {
 	const struct opal_step unlock_steps[] = {
-		{ opal_discovery0, },
 		{ start_auth_opal_session, &lk_unlk->session },
 		{ lock_unlock_locking_range, lk_unlk },
 		{ end_opal_session, }
 	};
 	const struct opal_step unlock_sum_steps[] = {
-		{ opal_discovery0, },
 		{ start_auth_opal_session, &lk_unlk->session },
 		{ lock_unlock_locking_range_sum, lk_unlk },
 		{ end_opal_session, }
@@ -2071,7 +2086,6 @@ static int __opal_set_mbr_done(struct opal_dev *dev, struct opal_key *key)
 {
 	u8 mbr_done_tf = OPAL_TRUE;
 	const struct opal_step mbrdone_step[] = {
-		{ opal_discovery0, },
 		{ start_admin1LSP_opal_session, key },
 		{ set_mbr_done, &mbr_done_tf },
 		{ end_opal_session, }
@@ -2098,7 +2112,6 @@ static int opal_lock_unlock(struct opal_dev *dev,
 static int opal_take_ownership(struct opal_dev *dev, struct opal_key *opal)
 {
 	const struct opal_step owner_steps[] = {
-		{ opal_discovery0, },
 		{ start_anybodyASP_opal_session, },
 		{ get_msid_cpin_pin, },
 		{ end_opal_session, },
@@ -2122,7 +2135,6 @@ static int opal_activate_lsp(struct opal_dev *dev,
 			     struct opal_lr_act *opal_lr_act)
 {
 	const struct opal_step active_steps[] = {
-		{ opal_discovery0, },
 		{ start_SIDASP_opal_session, &opal_lr_act->key },
 		{ get_lsp_lifecycle, },
 		{ activate_lsp, opal_lr_act },
@@ -2144,7 +2156,6 @@ static int opal_setup_locking_range(struct opal_dev *dev,
 				    struct opal_user_lr_setup *opal_lrs)
 {
 	const struct opal_step lr_steps[] = {
-		{ opal_discovery0, },
 		{ start_auth_opal_session, &opal_lrs->session },
 		{ setup_locking_range, opal_lrs },
 		{ end_opal_session, }
@@ -2161,7 +2172,6 @@ static int opal_setup_locking_range(struct opal_dev *dev,
 static int opal_set_new_pw(struct opal_dev *dev, struct opal_new_pw *opal_pw)
 {
 	const struct opal_step pw_steps[] = {
-		{ opal_discovery0, },
 		{ start_auth_opal_session, &opal_pw->session },
 		{ set_new_pw, &opal_pw->new_user_pw },
 		{ end_opal_session, }
@@ -2185,7 +2195,6 @@ static int opal_activate_user(struct opal_dev *dev,
 			      struct opal_session_info *opal_session)
 {
 	const struct opal_step act_steps[] = {
-		{ opal_discovery0, },
 		{ start_admin1LSP_opal_session, &opal_session->opal_key },
 		{ internal_activate_user, opal_session },
 		{ end_opal_session, }
-- 
2.20.1


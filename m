Return-Path: <SRS0=mhrr=QI=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2847C282D8
	for <linux-block@archiver.kernel.org>; Fri,  1 Feb 2019 20:52:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A6E43218F0
	for <linux-block@archiver.kernel.org>; Fri,  1 Feb 2019 20:52:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fjfi.cvut.cz header.i=@fjfi.cvut.cz header.b="zDn435xb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729778AbfBAUwK (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 1 Feb 2019 15:52:10 -0500
Received: from mailgw1.fjfi.cvut.cz ([147.32.9.3]:33962 "EHLO
        mailgw1.fjfi.cvut.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730826AbfBAUvw (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Fri, 1 Feb 2019 15:51:52 -0500
Received: from localhost (localhost [127.0.0.1])
        by mailgw1.fjfi.cvut.cz (Postfix) with ESMTP id B1494AD135;
        Fri,  1 Feb 2019 21:51:48 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fjfi.cvut.cz;
        s=20151024; t=1549054308; i=@fjfi.cvut.cz;
        bh=Wx2s2NAkVhUk87kQ81AahoNwmNnG1I1p3Gwdpy1BktY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References;
        b=zDn435xb0A6Cl1b9yOseaCys+gum3mOiTjSGW3fditkgio/bB5fpm6kZOPtWyLdMx
         clnIKr6Icj1oY3CXlCKRLNC+Qg5qENjN68i9qCsAxPC6i/9q/0jVz+sJ80WpF15+B6
         WjpuiO3ghLzPXJfbEm/+5HJu7KVPSONnDIg7+bpw=
X-CTU-FNSPE-Virus-Scanned: amavisd-new at fjfi.cvut.cz
Received: from mailgw1.fjfi.cvut.cz ([127.0.0.1])
        by localhost (mailgw1.fjfi.cvut.cz [127.0.0.1]) (amavisd-new, port 10022)
        with ESMTP id lg4J98Jh5nMs; Fri,  1 Feb 2019 21:51:40 +0100 (CET)
Received: from linux.fjfi.cvut.cz (linux.fjfi.cvut.cz [147.32.5.111])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mailgw1.fjfi.cvut.cz (Postfix) with ESMTPS id B2460AD126;
        Fri,  1 Feb 2019 21:50:55 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailgw1.fjfi.cvut.cz B2460AD126
Received: by linux.fjfi.cvut.cz (Postfix, from userid 1001)
        id 956296004E; Fri,  1 Feb 2019 21:50:55 +0100 (CET)
From:   David Kozub <zub@linux.fjfi.cvut.cz>
To:     Jens Axboe <axboe@kernel.dk>,
        Jonathan Derrick <jonathan.derrick@intel.com>,
        Scott Bauer <sbauer@plzdonthack.me>,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Jonas Rabenstein <jonas.rabenstein@studium.uni-erlangen.de>,
        David Kozub <zub@linux.fjfi.cvut.cz>
Subject: [PATCH v4 15/16] block: sed-opal: don't repeat opal_discovery0 in each steps array
Date:   Fri,  1 Feb 2019 21:50:22 +0100
Message-Id: <1549054223-12220-16-git-send-email-zub@linux.fjfi.cvut.cz>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1549054223-12220-1-git-send-email-zub@linux.fjfi.cvut.cz>
References: <1549054223-12220-1-git-send-email-zub@linux.fjfi.cvut.cz>
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Originally each of the opal functions that call next include
opal_discovery0 in the array of steps. This is superfluous and
can be done always inside next.

Signed-off-by: David Kozub <zub@linux.fjfi.cvut.cz>
Reviewed-by: Scott Bauer <sbauer@plzdonthack.me>
---
 block/sed-opal.c | 89 +++++++++++++++++++++++-------------------------
 1 file changed, 43 insertions(+), 46 deletions(-)

diff --git a/block/sed-opal.c b/block/sed-opal.c
index 21f2789a20cb..3362741dd198 100644
--- a/block/sed-opal.c
+++ b/block/sed-opal.c
@@ -221,6 +221,7 @@ static const u8 opalmethod[][OPAL_METHOD_LENGTH] = {
 };
 
 static int end_opal_session_error(struct opal_dev *dev);
+static int opal_discovery0_step(struct opal_dev *dev);
 
 struct opal_suspend_data {
 	struct opal_lock_unlock unlk;
@@ -386,36 +387,42 @@ static void check_geometry(struct opal_dev *dev, const void *data)
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
 	size_t state;
-	int error = 0;
+	int error;
 
-	for (state = 0; !error && state < n_steps; state++) {
-		step = &steps[state];
-
-		error = step->fn(dev, step->data);
-		if (error) {
-			pr_debug("Step %zu (%pS) failed with error %d: %s\n",
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
+	/* first do a discovery0 */
+	error = opal_discovery0_step(dev);
 
-		}
-	}
+	for (state = 0; !error && state < n_steps; state++)
+		error = execute_step(dev, &steps[state], state);
+
+	/*
+	 * For each OPAL command the first step in steps starts some sort of
+	 * session. If an error occurred in the initial discovery0 or if an
+	 * error occurred in the first step (and thus stopping the loop with
+	 * state == 1) then there was an error before or during the attempt to
+	 * start a session. Therefore we shouldn't attempt to terminate a
+	 * session, as one has not yet been created.
+	 */
+	if (error && state > 1)
+		end_opal_session_error(dev);
 
 	return error;
 }
@@ -513,6 +520,14 @@ static int opal_discovery0(struct opal_dev *dev, void *data)
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
 static size_t remaining_size(struct opal_dev *cmd)
 {
 	return IO_BUFFER_LENGTH - cmd->pos;
@@ -1938,10 +1953,10 @@ static int end_opal_session(struct opal_dev *dev, void *data)
 
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
@@ -1953,14 +1968,11 @@ static inline void setup_opal_dev(struct opal_dev *dev)
 
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
@@ -2013,7 +2025,6 @@ static int opal_secure_erase_locking_range(struct opal_dev *dev,
 					   struct opal_session_info *opal_session)
 {
 	const struct opal_step erase_steps[] = {
-		{ opal_discovery0, },
 		{ start_auth_opal_session, opal_session },
 		{ get_active_key, &opal_session->opal_key.lr },
 		{ gen_key, },
@@ -2032,7 +2043,6 @@ static int opal_erase_locking_range(struct opal_dev *dev,
 				    struct opal_session_info *opal_session)
 {
 	const struct opal_step erase_steps[] = {
-		{ opal_discovery0, },
 		{ start_auth_opal_session, opal_session },
 		{ erase_locking_range, opal_session },
 		{ end_opal_session, }
@@ -2052,7 +2062,6 @@ static int opal_enable_disable_shadow_mbr(struct opal_dev *dev,
 	u8 token = opal_mbr->enable_disable == OPAL_MBR_ENABLE
 		? OPAL_TRUE : OPAL_FALSE;
 	const struct opal_step mbr_steps[] = {
-		{ opal_discovery0, },
 		{ start_admin1LSP_opal_session, &opal_mbr->key },
 		{ set_mbr_done, &token },
 		{ end_opal_session, },
@@ -2078,7 +2087,6 @@ static int opal_mbr_status(struct opal_dev *dev, struct opal_mbr_data *opal_mbr)
 	u8 token = opal_mbr->enable_disable == OPAL_MBR_ENABLE
 		? OPAL_TRUE : OPAL_FALSE;
 	const struct opal_step mbr_steps[] = {
-		{ opal_discovery0, },
 		{ start_admin1LSP_opal_session, &opal_mbr->key },
 		{ set_mbr_done, &token },
 		{ end_opal_session, }
@@ -2100,7 +2108,6 @@ static int opal_write_shadow_mbr(struct opal_dev *dev,
 				 struct opal_shadow_mbr *info)
 {
 	const struct opal_step mbr_steps[] = {
-		{ opal_discovery0, },
 		{ start_admin1LSP_opal_session, &info->key },
 		{ write_shadow_mbr, info },
 		{ end_opal_session, }
@@ -2142,7 +2149,6 @@ static int opal_add_user_to_lr(struct opal_dev *dev,
 			       struct opal_lock_unlock *lk_unlk)
 {
 	const struct opal_step steps[] = {
-		{ opal_discovery0, },
 		{ start_admin1LSP_opal_session, &lk_unlk->session.opal_key },
 		{ add_user_to_lr, lk_unlk },
 		{ end_opal_session, }
@@ -2176,7 +2182,6 @@ static int opal_add_user_to_lr(struct opal_dev *dev,
 static int opal_reverttper(struct opal_dev *dev, struct opal_key *opal)
 {
 	const struct opal_step revert_steps[] = {
-		{ opal_discovery0, },
 		{ start_SIDASP_opal_session, opal },
 		{ revert_tper, } /* controller will terminate session */
 	};
@@ -2201,13 +2206,11 @@ static int __opal_lock_unlock(struct opal_dev *dev,
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
@@ -2224,7 +2227,6 @@ static int __opal_set_mbr_done(struct opal_dev *dev, struct opal_key *key)
 {
 	u8 mbr_done_tf = 1;
 	const struct opal_step mbrdone_step[] = {
-		{ opal_discovery0, },
 		{ start_admin1LSP_opal_session, key },
 		{ set_mbr_done, &mbr_done_tf },
 		{ end_opal_session, }
@@ -2251,7 +2253,6 @@ static int opal_lock_unlock(struct opal_dev *dev,
 static int opal_take_ownership(struct opal_dev *dev, struct opal_key *opal)
 {
 	const struct opal_step owner_steps[] = {
-		{ opal_discovery0, },
 		{ start_anybodyASP_opal_session, },
 		{ get_msid_cpin_pin, },
 		{ end_opal_session, },
@@ -2275,7 +2276,6 @@ static int opal_activate_lsp(struct opal_dev *dev,
 			     struct opal_lr_act *opal_lr_act)
 {
 	const struct opal_step active_steps[] = {
-		{ opal_discovery0, },
 		{ start_SIDASP_opal_session, &opal_lr_act->key },
 		{ get_lsp_lifecycle, },
 		{ activate_lsp, opal_lr_act },
@@ -2297,7 +2297,6 @@ static int opal_setup_locking_range(struct opal_dev *dev,
 				    struct opal_user_lr_setup *opal_lrs)
 {
 	const struct opal_step lr_steps[] = {
-		{ opal_discovery0, },
 		{ start_auth_opal_session, &opal_lrs->session },
 		{ setup_locking_range, opal_lrs },
 		{ end_opal_session, }
@@ -2314,7 +2313,6 @@ static int opal_setup_locking_range(struct opal_dev *dev,
 static int opal_set_new_pw(struct opal_dev *dev, struct opal_new_pw *opal_pw)
 {
 	const struct opal_step pw_steps[] = {
-		{ opal_discovery0, },
 		{ start_auth_opal_session, &opal_pw->session },
 		{ set_new_pw, &opal_pw->new_user_pw },
 		{ end_opal_session, }
@@ -2338,7 +2336,6 @@ static int opal_activate_user(struct opal_dev *dev,
 			      struct opal_session_info *opal_session)
 {
 	const struct opal_step act_steps[] = {
-		{ opal_discovery0, },
 		{ start_admin1LSP_opal_session, &opal_session->opal_key },
 		{ internal_activate_user, opal_session },
 		{ end_opal_session, }
-- 
2.20.1


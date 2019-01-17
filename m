Return-Path: <SRS0=sC6v=PZ=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A222C43387
	for <linux-block@archiver.kernel.org>; Thu, 17 Jan 2019 21:33:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5DFD820855
	for <linux-block@archiver.kernel.org>; Thu, 17 Jan 2019 21:33:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fjfi.cvut.cz header.i=@fjfi.cvut.cz header.b="WmQJ7NKr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728237AbfAQVdz (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 17 Jan 2019 16:33:55 -0500
Received: from mailgw1.fjfi.cvut.cz ([147.32.9.3]:35776 "EHLO
        mailgw1.fjfi.cvut.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729828AbfAQVdm (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 17 Jan 2019 16:33:42 -0500
Received: from localhost (localhost [127.0.0.1])
        by mailgw1.fjfi.cvut.cz (Postfix) with ESMTP id 411FFA39AD;
        Thu, 17 Jan 2019 22:33:37 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fjfi.cvut.cz;
        s=20151024; t=1547760817; i=@fjfi.cvut.cz;
        bh=+bodnmxnalG6Z9VELEJzJB4TJfoYrpGNJ2Dfw8sRVYI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References;
        b=WmQJ7NKrdOG+5drCZLhwBJo/okYePmGP8Nhwcm/HN1Y9vffqQOP+xUGK69U3VaniT
         5dkCnT31lBdYqa/vpB69ekE/l0HtdXxvjmpIF2pstDGN6Mr0NJ9ok617Is0DskKZWY
         bw6TiP8y1rIssAkn+77jw+wuphLc7GG0oWcU47yI=
X-CTU-FNSPE-Virus-Scanned: amavisd-new at fjfi.cvut.cz
Received: from mailgw1.fjfi.cvut.cz ([127.0.0.1])
        by localhost (mailgw1.fjfi.cvut.cz [127.0.0.1]) (amavisd-new, port 10022)
        with ESMTP id bxQjievR2SvW; Thu, 17 Jan 2019 22:33:29 +0100 (CET)
Received: from linux.fjfi.cvut.cz (linux.fjfi.cvut.cz [147.32.5.111])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mailgw1.fjfi.cvut.cz (Postfix) with ESMTPS id 3C1F4A3942;
        Thu, 17 Jan 2019 22:33:15 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailgw1.fjfi.cvut.cz 3C1F4A3942
Received: by linux.fjfi.cvut.cz (Postfix, from userid 1001)
        id 20B036004E; Thu, 17 Jan 2019 22:33:15 +0100 (CET)
From:   David Kozub <zub@linux.fjfi.cvut.cz>
To:     Jens Axboe <axboe@kernel.dk>,
        Jonathan Derrick <jonathan.derrick@intel.com>,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Jonas Rabenstein <jonas.rabenstein@studium.uni-erlangen.de>,
        David Kozub <zub@linux.fjfi.cvut.cz>
Subject: [PATCH v2 15/16] block: sed-opal: don't repeat opal_discovery0 in each steps array
Date:   Thu, 17 Jan 2019 22:31:55 +0100
Message-Id: <1547760716-7304-16-git-send-email-zub@linux.fjfi.cvut.cz>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1547760716-7304-1-git-send-email-zub@linux.fjfi.cvut.cz>
References: <1547760716-7304-1-git-send-email-zub@linux.fjfi.cvut.cz>
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Originally each of the opal functions that call next include
opal_discovery0 in the array of steps. This is superfluous and
can be done always inside next.

Signed-off-by: David Kozub <zub@linux.fjfi.cvut.cz>
---
 block/sed-opal.c | 88 +++++++++++++++++++++++-------------------------
 1 file changed, 42 insertions(+), 46 deletions(-)

diff --git a/block/sed-opal.c b/block/sed-opal.c
index 82ef81b66ed5..cedf4d12138d 100644
--- a/block/sed-opal.c
+++ b/block/sed-opal.c
@@ -221,6 +221,7 @@ static const u8 opalmethod[][OPAL_METHOD_LENGTH] = {
 };
 
 static int end_opal_session_error(struct opal_dev *dev);
+static int opal_discovery0_step(struct opal_dev *dev);
 
 struct opal_suspend_data {
 	struct opal_lock_unlock unlk;
@@ -386,36 +387,41 @@ static void check_geometry(struct opal_dev *dev, const void *data)
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
+	/* For each OPAL command the first step in steps starts some sort
+	 * of session. If an error occurred in the initial discovery0 or if
+	 * an error stopped the loop in state 0 then there was an error
+	 * before or during the attempt to start a session. Therefore we
+	 * shouldn't attempt to terminate a session, as one has not yet
+	 * been created.
+	 */
+	if (error && state > 0)
+		end_opal_session_error(dev);
 
 	return error;
 }
@@ -513,6 +519,14 @@ static int opal_discovery0(struct opal_dev *dev, void *data)
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
@@ -1937,10 +1951,10 @@ static int end_opal_session(struct opal_dev *dev, void *data)
 
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
@@ -1952,14 +1966,11 @@ static inline void setup_opal_dev(struct opal_dev *dev)
 
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
@@ -2012,7 +2023,6 @@ static int opal_secure_erase_locking_range(struct opal_dev *dev,
 					   struct opal_session_info *opal_session)
 {
 	const struct opal_step erase_steps[] = {
-		{ opal_discovery0, },
 		{ start_auth_opal_session, opal_session },
 		{ get_active_key, &opal_session->opal_key.lr },
 		{ gen_key, },
@@ -2031,7 +2041,6 @@ static int opal_erase_locking_range(struct opal_dev *dev,
 				    struct opal_session_info *opal_session)
 {
 	const struct opal_step erase_steps[] = {
-		{ opal_discovery0, },
 		{ start_auth_opal_session, opal_session },
 		{ erase_locking_range, opal_session },
 		{ end_opal_session, }
@@ -2051,7 +2060,6 @@ static int opal_enable_disable_shadow_mbr(struct opal_dev *dev,
 	u8 token = opal_mbr->enable_disable == OPAL_MBR_ENABLE
 		? OPAL_TRUE : OPAL_FALSE;
 	const struct opal_step mbr_steps[] = {
-		{ opal_discovery0, },
 		{ start_admin1LSP_opal_session, &opal_mbr->key },
 		{ set_mbr_done, &token },
 		{ end_opal_session, },
@@ -2077,7 +2085,6 @@ static int opal_mbr_status(struct opal_dev *dev, struct opal_mbr_data *opal_mbr)
 	u8 token = opal_mbr->enable_disable == OPAL_MBR_ENABLE
 		? OPAL_TRUE : OPAL_FALSE;
 	const struct opal_step mbr_steps[] = {
-		{ opal_discovery0, },
 		{ start_admin1LSP_opal_session, &opal_mbr->key },
 		{ set_mbr_done, &token },
 		{ end_opal_session, }
@@ -2099,7 +2106,6 @@ static int opal_write_shadow_mbr(struct opal_dev *dev,
 				 struct opal_shadow_mbr *info)
 {
 	const struct opal_step mbr_steps[] = {
-		{ opal_discovery0, },
 		{ start_admin1LSP_opal_session, &info->key },
 		{ write_shadow_mbr, info },
 		{ end_opal_session, }
@@ -2141,7 +2147,6 @@ static int opal_add_user_to_lr(struct opal_dev *dev,
 			       struct opal_lock_unlock *lk_unlk)
 {
 	const struct opal_step steps[] = {
-		{ opal_discovery0, },
 		{ start_admin1LSP_opal_session, &lk_unlk->session.opal_key },
 		{ add_user_to_lr, lk_unlk },
 		{ end_opal_session, }
@@ -2175,7 +2180,6 @@ static int opal_add_user_to_lr(struct opal_dev *dev,
 static int opal_reverttper(struct opal_dev *dev, struct opal_key *opal)
 {
 	const struct opal_step revert_steps[] = {
-		{ opal_discovery0, },
 		{ start_SIDASP_opal_session, opal },
 		{ revert_tper, } /* controller will terminate session */
 	};
@@ -2200,13 +2204,11 @@ static int __opal_lock_unlock(struct opal_dev *dev,
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
@@ -2223,7 +2225,6 @@ static int __opal_set_mbr_done(struct opal_dev *dev, struct opal_key *key)
 {
 	u8 mbr_done_tf = 1;
 	const struct opal_step mbrdone_step[] = {
-		{ opal_discovery0, },
 		{ start_admin1LSP_opal_session, key },
 		{ set_mbr_done, &mbr_done_tf },
 		{ end_opal_session, }
@@ -2250,7 +2251,6 @@ static int opal_lock_unlock(struct opal_dev *dev,
 static int opal_take_ownership(struct opal_dev *dev, struct opal_key *opal)
 {
 	const struct opal_step owner_steps[] = {
-		{ opal_discovery0, },
 		{ start_anybodyASP_opal_session, },
 		{ get_msid_cpin_pin, },
 		{ end_opal_session, },
@@ -2274,7 +2274,6 @@ static int opal_activate_lsp(struct opal_dev *dev,
 			     struct opal_lr_act *opal_lr_act)
 {
 	const struct opal_step active_steps[] = {
-		{ opal_discovery0, },
 		{ start_SIDASP_opal_session, &opal_lr_act->key },
 		{ get_lsp_lifecycle, },
 		{ activate_lsp, opal_lr_act },
@@ -2296,7 +2295,6 @@ static int opal_setup_locking_range(struct opal_dev *dev,
 				    struct opal_user_lr_setup *opal_lrs)
 {
 	const struct opal_step lr_steps[] = {
-		{ opal_discovery0, },
 		{ start_auth_opal_session, &opal_lrs->session },
 		{ setup_locking_range, opal_lrs },
 		{ end_opal_session, }
@@ -2313,7 +2311,6 @@ static int opal_setup_locking_range(struct opal_dev *dev,
 static int opal_set_new_pw(struct opal_dev *dev, struct opal_new_pw *opal_pw)
 {
 	const struct opal_step pw_steps[] = {
-		{ opal_discovery0, },
 		{ start_auth_opal_session, &opal_pw->session },
 		{ set_new_pw, &opal_pw->new_user_pw },
 		{ end_opal_session, }
@@ -2337,7 +2334,6 @@ static int opal_activate_user(struct opal_dev *dev,
 			      struct opal_session_info *opal_session)
 {
 	const struct opal_step act_steps[] = {
-		{ opal_discovery0, },
 		{ start_admin1LSP_opal_session, &opal_session->opal_key },
 		{ internal_activate_user, opal_session },
 		{ end_opal_session, }
-- 
2.20.1


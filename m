Return-Path: <SRS0=sC6v=PZ=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2136C43444
	for <linux-block@archiver.kernel.org>; Thu, 17 Jan 2019 21:32:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8539F20855
	for <linux-block@archiver.kernel.org>; Thu, 17 Jan 2019 21:32:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fjfi.cvut.cz header.i=@fjfi.cvut.cz header.b="A1UhlyBK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726905AbfAQVc6 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 17 Jan 2019 16:32:58 -0500
Received: from mailgw1.fjfi.cvut.cz ([147.32.9.3]:34894 "EHLO
        mailgw1.fjfi.cvut.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726066AbfAQVc6 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 17 Jan 2019 16:32:58 -0500
Received: from localhost (localhost [127.0.0.1])
        by mailgw1.fjfi.cvut.cz (Postfix) with ESMTP id 18862A3946;
        Thu, 17 Jan 2019 22:32:55 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fjfi.cvut.cz;
        s=20151024; t=1547760775; i=@fjfi.cvut.cz;
        bh=UBxIMAPDODPNIQgGigLkcRAIWQR7DtqhIBTjJHo7StA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References;
        b=A1UhlyBKnFtoXzYuL1KbCPNiVXIjoRF7w/dxSuvO4MWHSO7VcVMwODIhrXsm5WTYf
         5wkeZu5esOArczavV3LQra2LsyPP1t+S7pSkLypqx7P/MkSflltJVlhsip2BHuC55P
         Eq4tCiqwXddGjd4rjc12wf0rGOMfD8wokBG1/c/g=
X-CTU-FNSPE-Virus-Scanned: amavisd-new at fjfi.cvut.cz
Received: from mailgw1.fjfi.cvut.cz ([127.0.0.1])
        by localhost (mailgw1.fjfi.cvut.cz [127.0.0.1]) (amavisd-new, port 10022)
        with ESMTP id HH437vOQcbzk; Thu, 17 Jan 2019 22:32:52 +0100 (CET)
Received: from linux.fjfi.cvut.cz (linux.fjfi.cvut.cz [147.32.5.111])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mailgw1.fjfi.cvut.cz (Postfix) with ESMTPS id 4992CA393B;
        Thu, 17 Jan 2019 22:32:52 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailgw1.fjfi.cvut.cz 4992CA393B
Received: by linux.fjfi.cvut.cz (Postfix, from userid 1001)
        id 1BFDC6004E; Thu, 17 Jan 2019 22:32:52 +0100 (CET)
From:   David Kozub <zub@linux.fjfi.cvut.cz>
To:     Jens Axboe <axboe@kernel.dk>,
        Jonathan Derrick <jonathan.derrick@intel.com>,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Jonas Rabenstein <jonas.rabenstein@studium.uni-erlangen.de>,
        David Kozub <zub@linux.fjfi.cvut.cz>
Subject: [PATCH v2 01/16] block: sed-opal: fix typos and formatting
Date:   Thu, 17 Jan 2019 22:31:41 +0100
Message-Id: <1547760716-7304-2-git-send-email-zub@linux.fjfi.cvut.cz>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1547760716-7304-1-git-send-email-zub@linux.fjfi.cvut.cz>
References: <1547760716-7304-1-git-send-email-zub@linux.fjfi.cvut.cz>
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

This should make no change in functionality.
The formatting changes were triggered by checkpatch.pl.

Signed-off-by: David Kozub <zub@linux.fjfi.cvut.cz>
---
 block/sed-opal.c | 19 +++++++++++--------
 1 file changed, 11 insertions(+), 8 deletions(-)

diff --git a/block/sed-opal.c b/block/sed-opal.c
index e0de4dd448b3..c882a193e162 100644
--- a/block/sed-opal.c
+++ b/block/sed-opal.c
@@ -11,8 +11,8 @@
  *
  * This program is distributed in the hope it will be useful, but WITHOUT
  * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
- * FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for
- * more details.
+ * FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License
+ * for more details.
  */
 
 #define pr_fmt(fmt) KBUILD_MODNAME ":OPAL: " fmt
@@ -157,7 +157,7 @@ static const u8 opaluid[][OPAL_UID_LENGTH] = {
 
 	/* C_PIN_TABLE object ID's */
 
-        [OPAL_C_PIN_MSID] =
+	[OPAL_C_PIN_MSID] =
 		{ 0x00, 0x00, 0x00, 0x0B, 0x00, 0x00, 0x84, 0x02},
 	[OPAL_C_PIN_SID] =
 		{ 0x00, 0x00, 0x00, 0x0B, 0x00, 0x00, 0x00, 0x01},
@@ -623,7 +623,7 @@ static int build_locking_range(u8 *buffer, size_t length, u8 lr)
 static int build_locking_user(u8 *buffer, size_t length, u8 lr)
 {
 	if (length > OPAL_UID_LENGTH) {
-		pr_debug("Can't build locking range user, Length OOB\n");
+		pr_debug("Can't build locking range user. Length OOB\n");
 		return -ERANGE;
 	}
 
@@ -1324,6 +1324,7 @@ static int start_SIDASP_opal_session(struct opal_dev *dev, void *data)
 
 	if (!key) {
 		const struct opal_key *okey = data;
+
 		ret = start_generic_opal_session(dev, OPAL_SID_UID,
 						 OPAL_ADMINSP_UID,
 						 okey->key,
@@ -1341,6 +1342,7 @@ static int start_SIDASP_opal_session(struct opal_dev *dev, void *data)
 static int start_admin1LSP_opal_session(struct opal_dev *dev, void *data)
 {
 	struct opal_key *key = data;
+
 	return start_generic_opal_session(dev, OPAL_ADMIN1_UID,
 					  OPAL_LOCKINGSP_UID,
 					  key->key, key->key_len);
@@ -1714,7 +1716,7 @@ static int lock_unlock_locking_range(struct opal_dev *dev, void *data)
 		write_locked = 0;
 		break;
 	case OPAL_LK:
-		/* vars are initalized to locked */
+		/* vars are initialized to locked */
 		break;
 	default:
 		pr_debug("Tried to set an invalid locking state... returning to uland\n");
@@ -1775,7 +1777,7 @@ static int lock_unlock_locking_range_sum(struct opal_dev *dev, void *data)
 		write_locked = 0;
 		break;
 	case OPAL_LK:
-		/* vars are initalized to locked */
+		/* vars are initialized to locked */
 		break;
 	default:
 		pr_debug("Tried to set an invalid locking state.\n");
@@ -2222,7 +2224,7 @@ static int __opal_lock_unlock(struct opal_dev *dev,
 static int __opal_set_mbr_done(struct opal_dev *dev, struct opal_key *key)
 {
 	u8 mbr_done_tf = 1;
-	const struct opal_step mbrdone_step [] = {
+	const struct opal_step mbrdone_step[] = {
 		{ opal_discovery0, },
 		{ start_admin1LSP_opal_session, key },
 		{ set_mbr_done, &mbr_done_tf },
@@ -2273,7 +2275,8 @@ static int opal_take_ownership(struct opal_dev *dev, struct opal_key *opal)
 	return ret;
 }
 
-static int opal_activate_lsp(struct opal_dev *dev, struct opal_lr_act *opal_lr_act)
+static int opal_activate_lsp(struct opal_dev *dev,
+			     struct opal_lr_act *opal_lr_act)
 {
 	const struct opal_step active_steps[] = {
 		{ opal_discovery0, },
-- 
2.20.1


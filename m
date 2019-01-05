Return-Path: <SRS0=7Bp6=PY=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.9 required=3.0 tests=DATE_IN_PAST_96_XX,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4CED2C43612
	for <linux-block@archiver.kernel.org>; Wed, 16 Jan 2019 23:05:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1AC6420675
	for <linux-block@archiver.kernel.org>; Wed, 16 Jan 2019 23:05:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fjfi.cvut.cz header.i=@fjfi.cvut.cz header.b="kkaL5lMA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387612AbfAPXFI (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 16 Jan 2019 18:05:08 -0500
Received: from mailgw1.fjfi.cvut.cz ([147.32.9.3]:45700 "EHLO
        mailgw1.fjfi.cvut.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726362AbfAPXD4 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 16 Jan 2019 18:03:56 -0500
Received: from localhost (localhost [127.0.0.1])
        by mailgw1.fjfi.cvut.cz (Postfix) with ESMTP id E7883AE0C6;
        Wed, 16 Jan 2019 23:55:37 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fjfi.cvut.cz;
        s=20151024; t=1547679337; i=@fjfi.cvut.cz;
        bh=UBxIMAPDODPNIQgGigLkcRAIWQR7DtqhIBTjJHo7StA=;
        h=From:Date:Subject:To:Cc;
        b=kkaL5lMAJeo6xdUy3g3F4ethNBTwuC+HT1EnH9jdYAsOAzzHKBtX41Tfittv96Gye
         e4VP+e+fERd6oyA+UkxoxsNCAj38BFyB9NfJtP/E9FHmDRgnhcYoI0BdS3Og6bCEIC
         nxZ4EMTjIgCxBZ3+3aJqoYxBNsBu9kUznYLrX8uY=
X-CTU-FNSPE-Virus-Scanned: amavisd-new at fjfi.cvut.cz
Received: from mailgw1.fjfi.cvut.cz ([127.0.0.1])
        by localhost (mailgw1.fjfi.cvut.cz [127.0.0.1]) (amavisd-new, port 10022)
        with ESMTP id zl1W4sOpkHIQ; Wed, 16 Jan 2019 23:55:35 +0100 (CET)
Received: from linux.fjfi.cvut.cz (linux.fjfi.cvut.cz [147.32.5.111])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mailgw1.fjfi.cvut.cz (Postfix) with ESMTPS id 03EA9ADF0E;
        Wed, 16 Jan 2019 23:55:35 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailgw1.fjfi.cvut.cz 03EA9ADF0E
Received: by linux.fjfi.cvut.cz (Postfix, from userid 1001)
        id D1B586004E; Wed, 16 Jan 2019 23:55:34 +0100 (CET)
From:   David Kozub <zub@linux.fjfi.cvut.cz>
Date:   Sat, 5 Jan 2019 22:23:56 +0100
Subject: [PATCH 01/16] block: sed-opal: fix typos and formatting
To:     Jens Axboe <axboe@kernel.dk>, Scott Bauer <scott.bauer@intel.com>,
        Jonathan Derrick <jonathan.derrick@intel.com>,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Jonas Rabenstein <jonas.rabenstein@studium.uni-erlangen.de>
Message-Id: <20190116225534.D1B586004E@linux.fjfi.cvut.cz>
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


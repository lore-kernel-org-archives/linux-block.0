Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7E24C6FD1F
	for <linux-block@archiver.kernel.org>; Wed, 22 Mar 2023 15:17:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230293AbjCVPR4 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 22 Mar 2023 11:17:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231509AbjCVPRx (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 22 Mar 2023 11:17:53 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E27362FF4
        for <linux-block@vger.kernel.org>; Wed, 22 Mar 2023 08:17:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1679498219;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=GWgn/7iiSuiFiGie8vcrKEH1Y0KQ7ME6mcmkWZsyzDc=;
        b=LQjId4hiMT9jNbOs5pkTsOIuf64FQzM0a7NagAVvarwRcIsQm8iPotpjUJcnlZA3h9NGgc
        ulUNCjznqerttQ0a56Gm4L+uHHOiDrpUeMqTuHKOsKQrVjf1JFthvYQ0GiZm548YkahUIR
        JcsqUG0uvrr9ibx9OjLtLhQGDXy1WZw=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-610-Xg_moGaiPduelp9fLIgRqg-1; Wed, 22 Mar 2023 11:16:38 -0400
X-MC-Unique: Xg_moGaiPduelp9fLIgRqg-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id D93393813F41;
        Wed, 22 Mar 2023 15:16:22 +0000 (UTC)
Received: from mrjust8.localdomain (unknown [10.43.17.42])
        by smtp.corp.redhat.com (Postfix) with ESMTP id B117F44002;
        Wed, 22 Mar 2023 15:16:21 +0000 (UTC)
From:   Ondrej Kozina <okozina@redhat.com>
To:     linux-block@vger.kernel.org
Cc:     bluca@debian.org, gmazyland@gmail.com, axboe@kernel.dk,
        hch@infradead.org, brauner@kernel.org, rafael.antognolli@intel.com,
        Ondrej Kozina <okozina@redhat.com>
Subject: [PATCH 2/5] sed-opal: add helper for adding user authorities in ACE.
Date:   Wed, 22 Mar 2023 16:16:01 +0100
Message-Id: <20230322151604.401680-3-okozina@redhat.com>
In-Reply-To: <20230322151604.401680-1-okozina@redhat.com>
References: <20230322151604.401680-1-okozina@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.5
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Moves ACE construction away from add_user_to_lr routine
to be used later in added code.

Signed-off-by: Ondrej Kozina <okozina@redhat.com>
Tested-by: Luca Boccassi <bluca@debian.org>
Tested-by: Milan Broz <gmazyland@gmail.com>
---
 block/sed-opal.c | 64 +++++++++++++++++++++++++++++++++---------------
 1 file changed, 44 insertions(+), 20 deletions(-)

diff --git a/block/sed-opal.c b/block/sed-opal.c
index d86d3e5f5a44..2c3e38df9c65 100644
--- a/block/sed-opal.c
+++ b/block/sed-opal.c
@@ -1759,25 +1759,16 @@ static int set_sid_cpin_pin(struct opal_dev *dev, void *data)
 	return finalize_and_send(dev, parse_and_check_status);
 }
 
-static int add_user_to_lr(struct opal_dev *dev, void *data)
+static int set_lr_boolean_ace(struct opal_dev *dev, unsigned int opal_uid, u8 lr,
+			      const u8 *users, size_t users_len)
 {
 	u8 lr_buffer[OPAL_UID_LENGTH];
 	u8 user_uid[OPAL_UID_LENGTH];
-	struct opal_lock_unlock *lkul = data;
+	u8 u;
 	int err;
 
-	memcpy(lr_buffer, opaluid[OPAL_LOCKINGRANGE_ACE_RDLOCKED],
-	       OPAL_UID_LENGTH);
-
-	if (lkul->l_state == OPAL_RW)
-		memcpy(lr_buffer, opaluid[OPAL_LOCKINGRANGE_ACE_WRLOCKED],
-		       OPAL_UID_LENGTH);
-
-	lr_buffer[7] = lkul->session.opal_key.lr;
-
-	memcpy(user_uid, opaluid[OPAL_USER1_UID], OPAL_UID_LENGTH);
-
-	user_uid[7] = lkul->session.who;
+	memcpy(lr_buffer, opaluid[opal_uid], OPAL_UID_LENGTH);
+	lr_buffer[7] = lr;
 
 	err = cmd_start(dev, lr_buffer, opalmethod[OPAL_SET]);
 
@@ -1790,19 +1781,52 @@ static int add_user_to_lr(struct opal_dev *dev, void *data)
 
 	add_token_u8(&err, dev, OPAL_STARTLIST);
 
+	for (u = 0; u < users_len; u++) {
+		if (users[u] == OPAL_ADMIN1)
+			memcpy(user_uid, opaluid[OPAL_ADMIN1_UID], OPAL_UID_LENGTH);
+		else {
+			memcpy(user_uid, opaluid[OPAL_USER1_UID], OPAL_UID_LENGTH);
+			user_uid[7] = users[u];
+		}
 
-	add_token_u8(&err, dev, OPAL_STARTNAME);
-	add_token_bytestring(&err, dev,
-			     opaluid[OPAL_HALF_UID_AUTHORITY_OBJ_REF],
-			     OPAL_UID_LENGTH/2);
-	add_token_bytestring(&err, dev, user_uid, OPAL_UID_LENGTH);
-	add_token_u8(&err, dev, OPAL_ENDNAME);
+		add_token_u8(&err, dev, OPAL_STARTNAME);
+		add_token_bytestring(&err, dev,
+				     opaluid[OPAL_HALF_UID_AUTHORITY_OBJ_REF],
+				     OPAL_UID_LENGTH/2);
+		add_token_bytestring(&err, dev, user_uid, OPAL_UID_LENGTH);
+		add_token_u8(&err, dev, OPAL_ENDNAME);
+
+		if (u > 0) {
+			add_token_u8(&err, dev, OPAL_STARTNAME);
+			add_token_bytestring(&err, dev, opaluid[OPAL_HALF_UID_BOOLEAN_ACE],
+					     OPAL_UID_LENGTH/2);
+			add_token_u8(&err, dev, 1);
+			add_token_u8(&err, dev, OPAL_ENDNAME);
+		}
+	}
 
 	add_token_u8(&err, dev, OPAL_ENDLIST);
 	add_token_u8(&err, dev, OPAL_ENDNAME);
 	add_token_u8(&err, dev, OPAL_ENDLIST);
 	add_token_u8(&err, dev, OPAL_ENDNAME);
 
+	return err;
+}
+
+static int add_user_to_lr(struct opal_dev *dev, void *data)
+{
+	int err;
+	struct opal_lock_unlock *lkul = data;
+	const u8 users[] = {
+		lkul->session.who
+	};
+
+	err = set_lr_boolean_ace(dev,
+				 lkul->l_state == OPAL_RW ?
+					OPAL_LOCKINGRANGE_ACE_WRLOCKED :
+					OPAL_LOCKINGRANGE_ACE_RDLOCKED,
+				 lkul->session.opal_key.lr, users,
+				 ARRAY_SIZE(users));
 	if (err) {
 		pr_debug("Error building add user to locking range command.\n");
 		return err;
-- 
2.31.1


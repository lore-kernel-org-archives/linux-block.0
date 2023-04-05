Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06F36C76188
	for <linux-block@archiver.kernel.org>; Wed,  5 Apr 2023 11:13:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229874AbjDELNs (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 5 Apr 2023 07:13:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237210AbjDELNr (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 5 Apr 2023 07:13:47 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF4C7194
        for <linux-block@vger.kernel.org>; Wed,  5 Apr 2023 04:13:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1680693184;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ttYZmLJKXr76OL+dZ2wrCyBN7cFB9DM+SJg2wEjWKes=;
        b=Krb4laPQ7YRJYL5Lag5lVfpyPU0Ydv5We8t7iNXdFWOOjjD+HC/ZsNrEulydBSQ1wbW7B0
        idRo2cjQ86fEd4fQ3G2Z4G87CoVpnyCj5zvvjbIpbca7j3Lrp1HzwTj2CSHprVJH0Ik6FD
        2jzvvmxmoyngpw01Ho3lYJzTyAUSdbQ=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-180-_13QKQwbOe6186Lhlq9a_g-1; Wed, 05 Apr 2023 07:13:03 -0400
X-MC-Unique: _13QKQwbOe6186Lhlq9a_g-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com [10.11.54.2])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 74F8B85C6E3;
        Wed,  5 Apr 2023 11:13:02 +0000 (UTC)
Received: from mrjust8.localdomain (unknown [10.43.17.42])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 5246040C6EC4;
        Wed,  5 Apr 2023 11:13:01 +0000 (UTC)
From:   Ondrej Kozina <okozina@redhat.com>
To:     linux-block@vger.kernel.org
Cc:     bluca@debian.org, gmazyland@gmail.com, axboe@kernel.dk,
        hch@infradead.org, brauner@kernel.org, jonathan.derrick@linux.dev,
        Ondrej Kozina <okozina@redhat.com>
Subject: [PATCH v2 2/5] sed-opal: add helper for adding user authorities in ACE.
Date:   Wed,  5 Apr 2023 13:12:20 +0200
Message-Id: <20230405111223.272816-3-okozina@redhat.com>
In-Reply-To: <20230405111223.272816-1-okozina@redhat.com>
References: <20230322151604.401680-1-okozina@redhat.com>
 <20230405111223.272816-1-okozina@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.2
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Move ACE construction away from add_user_to_lr routine
and refactor it to be used also in later code.

Also adds boolean operators defines from TCG Core
specification.

Signed-off-by: Ondrej Kozina <okozina@redhat.com>
Tested-by: Luca Boccassi <bluca@debian.org>
Tested-by: Milan Broz <gmazyland@gmail.com>
---
 block/opal_proto.h |  9 +++++
 block/sed-opal.c   | 88 +++++++++++++++++++++++++++++++++++-----------
 2 files changed, 77 insertions(+), 20 deletions(-)

diff --git a/block/opal_proto.h b/block/opal_proto.h
index 7152aa1f1a49..b045cbb9d76e 100644
--- a/block/opal_proto.h
+++ b/block/opal_proto.h
@@ -86,6 +86,15 @@ enum opal_response_token {
 #define OPAL_MSID_KEYLEN 15
 #define OPAL_UID_LENGTH_HALF 4
 
+/*
+ * Boolean operators from TCG Core spec 2.01 Section:
+ * 5.1.3.11
+ * Table 61
+ */
+#define OPAL_BOOLEAN_AND 0
+#define OPAL_BOOLEAN_OR  1
+#define OPAL_BOOLEAN_NOT 2
+
 /* Enum to index OPALUID array */
 enum opal_uid {
 	/* users */
diff --git a/block/sed-opal.c b/block/sed-opal.c
index d86d3e5f5a44..4d0253bc2bfd 100644
--- a/block/sed-opal.c
+++ b/block/sed-opal.c
@@ -1759,25 +1759,43 @@ static int set_sid_cpin_pin(struct opal_dev *dev, void *data)
 	return finalize_and_send(dev, parse_and_check_status);
 }
 
-static int add_user_to_lr(struct opal_dev *dev, void *data)
+static void add_authority_object_ref(int *err,
+				     struct opal_dev *dev,
+				     const u8 *uid,
+				     size_t uid_len)
+{
+	add_token_u8(err, dev, OPAL_STARTNAME);
+	add_token_bytestring(err, dev,
+			     opaluid[OPAL_HALF_UID_AUTHORITY_OBJ_REF],
+			     OPAL_UID_LENGTH/2);
+	add_token_bytestring(err, dev, uid, uid_len);
+	add_token_u8(err, dev, OPAL_ENDNAME);
+}
+
+static void add_boolean_object_ref(int *err,
+				   struct opal_dev *dev,
+				   u8 boolean_op)
+{
+	add_token_u8(err, dev, OPAL_STARTNAME);
+	add_token_bytestring(err, dev, opaluid[OPAL_HALF_UID_BOOLEAN_ACE],
+			     OPAL_UID_LENGTH/2);
+	add_token_u8(err, dev, boolean_op);
+	add_token_u8(err, dev, OPAL_ENDNAME);
+}
+
+static int set_lr_boolean_ace(struct opal_dev *dev,
+			      unsigned int opal_uid,
+			      u8 lr,
+			      const u8 *users,
+			      size_t users_len)
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
 
@@ -1790,19 +1808,49 @@ static int add_user_to_lr(struct opal_dev *dev, void *data)
 
 	add_token_u8(&err, dev, OPAL_STARTLIST);
 
+	for (u = 0; u < users_len; u++) {
+		if (users[u] == OPAL_ADMIN1)
+			memcpy(user_uid, opaluid[OPAL_ADMIN1_UID],
+			       OPAL_UID_LENGTH);
+		else {
+			memcpy(user_uid, opaluid[OPAL_USER1_UID],
+			       OPAL_UID_LENGTH);
+			user_uid[7] = users[u];
+		}
+
+		add_authority_object_ref(&err, dev, user_uid, sizeof(user_uid));
 
-	add_token_u8(&err, dev, OPAL_STARTNAME);
-	add_token_bytestring(&err, dev,
-			     opaluid[OPAL_HALF_UID_AUTHORITY_OBJ_REF],
-			     OPAL_UID_LENGTH/2);
-	add_token_bytestring(&err, dev, user_uid, OPAL_UID_LENGTH);
-	add_token_u8(&err, dev, OPAL_ENDNAME);
+		/*
+		 * Add boolean operator in postfix only with
+		 * two or more authorities being added in ACE
+		 * expresion.
+		 * */
+		if (u > 0)
+			add_boolean_object_ref(&err, dev, OPAL_BOOLEAN_OR);
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


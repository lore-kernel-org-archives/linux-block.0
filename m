Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5E20C77B60
	for <linux-block@archiver.kernel.org>; Wed,  5 Apr 2023 11:13:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237528AbjDELNw (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 5 Apr 2023 07:13:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237359AbjDELNu (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 5 Apr 2023 07:13:50 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7BC9123
        for <linux-block@vger.kernel.org>; Wed,  5 Apr 2023 04:13:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1680693189;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=kTgNZhjlArdmvIOSyYW5ahnk6qeRaMv8l68Fzwp2+lk=;
        b=UcGvnKUSnTqtqWTZ30OtlAUm4CqcXv5jk4hU1shVcgzaFEIl9PkZDUIxm/rrd9iLZAgHsd
        wsDfeUF4erA4vn/7qk3lSTbo7EVW7E38f9IHWS8KZ5yJnEHbkUgxwBJIv28azSyTKtTQf6
        Ya04sxDL0qjR9u/z5NCE/zxQ4PUngAk=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-121-32vQ2FO-Nia_5ZKGeQaD8A-1; Wed, 05 Apr 2023 07:13:04 -0400
X-MC-Unique: 32vQ2FO-Nia_5ZKGeQaD8A-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com [10.11.54.2])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id E92B7889058;
        Wed,  5 Apr 2023 11:13:03 +0000 (UTC)
Received: from mrjust8.localdomain (unknown [10.43.17.42])
        by smtp.corp.redhat.com (Postfix) with ESMTP id AAE8140C6EC4;
        Wed,  5 Apr 2023 11:13:02 +0000 (UTC)
From:   Ondrej Kozina <okozina@redhat.com>
To:     linux-block@vger.kernel.org
Cc:     bluca@debian.org, gmazyland@gmail.com, axboe@kernel.dk,
        hch@infradead.org, brauner@kernel.org, jonathan.derrick@linux.dev,
        Ondrej Kozina <okozina@redhat.com>,
        Christoph Hellwig <hch@lst.de>
Subject: [PATCH v2 3/5] sed-opal: allow user authority to get locking range attributes.
Date:   Wed,  5 Apr 2023 13:12:21 +0200
Message-Id: <20230405111223.272816-4-okozina@redhat.com>
In-Reply-To: <20230405111223.272816-1-okozina@redhat.com>
References: <20230322151604.401680-1-okozina@redhat.com>
 <20230405111223.272816-1-okozina@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.2
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Extend ACE set of locking range attributes accessible to user
authority. This patch allows user authority to get following
locking range attribues when user get added to locking range via
IOC_OPAL_ADD_USR_TO_LR:

locking range start
locking range end
read lock enabled
write lock enabled
read locked
write locked
lock on reset
active key

Note: Admin1 authority always remains in the ACE. Otherwise
it breaks current userspace expecting Admin1 in the ACE (sedutils).

See TCG OPAL2 s.4.3.1.7 "ACE_Locking_RangeNNNN_Get_RangeStartToActiveKey".

Signed-off-by: Ondrej Kozina <okozina@redhat.com>
Tested-by: Luca Boccassi <bluca@debian.org>
Tested-by: Milan Broz <gmazyland@gmail.com>
Acked-by: Christian Brauner <brauner@kernel.org>
Reviewed-by: Christoph Hellwig <hch@lst.de>
---
 block/opal_proto.h |  1 +
 block/sed-opal.c   | 24 ++++++++++++++++++++++++
 2 files changed, 25 insertions(+)

diff --git a/block/opal_proto.h b/block/opal_proto.h
index b045cbb9d76e..a4e56845dd82 100644
--- a/block/opal_proto.h
+++ b/block/opal_proto.h
@@ -114,6 +114,7 @@ enum opal_uid {
 	/* tables */
 	OPAL_TABLE_TABLE,
 	OPAL_LOCKINGRANGE_GLOBAL,
+	OPAL_LOCKINGRANGE_ACE_START_TO_KEY,
 	OPAL_LOCKINGRANGE_ACE_RDLOCKED,
 	OPAL_LOCKINGRANGE_ACE_WRLOCKED,
 	OPAL_MBRCONTROL,
diff --git a/block/sed-opal.c b/block/sed-opal.c
index 4d0253bc2bfd..38cc02b708ac 100644
--- a/block/sed-opal.c
+++ b/block/sed-opal.c
@@ -132,6 +132,8 @@ static const u8 opaluid[][OPAL_UID_LENGTH] = {
 		{ 0x00, 0x00, 0x00, 0x01, 0x00, 0x00, 0x00, 0x01 },
 	[OPAL_LOCKINGRANGE_GLOBAL] =
 		{ 0x00, 0x00, 0x08, 0x02, 0x00, 0x00, 0x00, 0x01 },
+	[OPAL_LOCKINGRANGE_ACE_START_TO_KEY] =
+		{ 0x00, 0x00, 0x00, 0x08, 0x00, 0x03, 0xD0, 0x01 },
 	[OPAL_LOCKINGRANGE_ACE_RDLOCKED] =
 		{ 0x00, 0x00, 0x00, 0x08, 0x00, 0x03, 0xE0, 0x01 },
 	[OPAL_LOCKINGRANGE_ACE_WRLOCKED] =
@@ -1859,6 +1861,27 @@ static int add_user_to_lr(struct opal_dev *dev, void *data)
 	return finalize_and_send(dev, parse_and_check_status);
 }
 
+static int add_user_to_lr_ace(struct opal_dev *dev, void *data)
+{
+	int err;
+	struct opal_lock_unlock *lkul = data;
+	const u8 users[] = {
+		OPAL_ADMIN1,
+		lkul->session.who
+	};
+
+	err = set_lr_boolean_ace(dev, OPAL_LOCKINGRANGE_ACE_START_TO_KEY,
+				 lkul->session.opal_key.lr, users,
+				 ARRAY_SIZE(users));
+
+	if (err) {
+		pr_debug("Error building add user to locking ranges ACEs.\n");
+		return err;
+	}
+
+	return finalize_and_send(dev, parse_and_check_status);
+}
+
 static int lock_unlock_locking_range(struct opal_dev *dev, void *data)
 {
 	u8 lr_buffer[OPAL_UID_LENGTH];
@@ -2396,6 +2419,7 @@ static int opal_add_user_to_lr(struct opal_dev *dev,
 	const struct opal_step steps[] = {
 		{ start_admin1LSP_opal_session, &lk_unlk->session.opal_key },
 		{ add_user_to_lr, lk_unlk },
+		{ add_user_to_lr_ace, lk_unlk },
 		{ end_opal_session, }
 	};
 	int ret;
-- 
2.31.1


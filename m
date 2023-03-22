Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EFE7EC6FD1F
	for <linux-block@archiver.kernel.org>; Wed, 22 Mar 2023 15:17:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231343AbjCVPRO (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 22 Mar 2023 11:17:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231305AbjCVPRN (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 22 Mar 2023 11:17:13 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2AD78637E0
        for <linux-block@vger.kernel.org>; Wed, 22 Mar 2023 08:16:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1679498189;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=fIxxnzjFRY0uSu981Hr0uPm3P79oK13XuBYjyWTm3jc=;
        b=PIupVdaoqXSJWvUah6DpYKooe2ufFKfRzoLd/PgGn/6MHMuv8OYOMoFjule0L+9a/wV5JB
        JD6ohLEeuVjWJHr/EPb77ieceHySiFAlgji/BkLynNV7LFXVrvEc189sz29jWrdmjBTxPr
        juYLvhYWRPcsvfJrYRMYClgcV3q/tvQ=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-112-nvti2NTQPtK_PDRS3P4kJg-1; Wed, 22 Mar 2023 11:16:24 -0400
X-MC-Unique: nvti2NTQPtK_PDRS3P4kJg-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 435B0884348;
        Wed, 22 Mar 2023 15:16:24 +0000 (UTC)
Received: from mrjust8.localdomain (unknown [10.43.17.42])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 1B4D151FF;
        Wed, 22 Mar 2023 15:16:22 +0000 (UTC)
From:   Ondrej Kozina <okozina@redhat.com>
To:     linux-block@vger.kernel.org
Cc:     bluca@debian.org, gmazyland@gmail.com, axboe@kernel.dk,
        hch@infradead.org, brauner@kernel.org, rafael.antognolli@intel.com,
        Ondrej Kozina <okozina@redhat.com>
Subject: [PATCH 3/5] sed-opal: allow user authority to get locking range attributes.
Date:   Wed, 22 Mar 2023 16:16:02 +0100
Message-Id: <20230322151604.401680-4-okozina@redhat.com>
In-Reply-To: <20230322151604.401680-1-okozina@redhat.com>
References: <20230322151604.401680-1-okozina@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.5
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
---
 block/opal_proto.h |  1 +
 block/sed-opal.c   | 23 +++++++++++++++++++++++
 2 files changed, 24 insertions(+)

diff --git a/block/opal_proto.h b/block/opal_proto.h
index 7152aa1f1a49..6dfaea272db2 100644
--- a/block/opal_proto.h
+++ b/block/opal_proto.h
@@ -105,6 +105,7 @@ enum opal_uid {
 	/* tables */
 	OPAL_TABLE_TABLE,
 	OPAL_LOCKINGRANGE_GLOBAL,
+	OPAL_LOCKINGRANGE_ACE_START_TO_KEY,
 	OPAL_LOCKINGRANGE_ACE_RDLOCKED,
 	OPAL_LOCKINGRANGE_ACE_WRLOCKED,
 	OPAL_MBRCONTROL,
diff --git a/block/sed-opal.c b/block/sed-opal.c
index 2c3e38df9c65..1ce61adc732c 100644
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
@@ -1835,6 +1837,26 @@ static int add_user_to_lr(struct opal_dev *dev, void *data)
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
+				 lkul->session.opal_key.lr, users, ARRAY_SIZE(users));
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
@@ -2372,6 +2394,7 @@ static int opal_add_user_to_lr(struct opal_dev *dev,
 	const struct opal_step steps[] = {
 		{ start_admin1LSP_opal_session, &lk_unlk->session.opal_key },
 		{ add_user_to_lr, lk_unlk },
+		{ add_user_to_lr_ace, lk_unlk },
 		{ end_opal_session, }
 	};
 	int ret;
-- 
2.31.1


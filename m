Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB67FC7619A
	for <linux-block@archiver.kernel.org>; Wed,  5 Apr 2023 11:14:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237485AbjDELOD (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 5 Apr 2023 07:14:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237260AbjDELOC (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 5 Apr 2023 07:14:02 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4ABD7122
        for <linux-block@vger.kernel.org>; Wed,  5 Apr 2023 04:13:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1680693193;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=FFbYRQyq5xN1IxIZck0blaTXjTJZb4fNVnd55agHtN0=;
        b=SHEfZvtJscCvHcjCxfZnKKB12tduumn6eLs65gg9wDztanTweCB5GB2FKjCsK6iz90MqVS
        IDCMPF79mgkngIxDL7qcc12+31xj9dHZJQw9oxNYy2BMi3aaPKvsH2bM5X5q8mUnvFN9be
        wyUA2ERp3AqnQWFBMGL26PuUyGGtwgg=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-357-9xdkMEx4NDW7eAOUJ-aSPA-1; Wed, 05 Apr 2023 07:13:08 -0400
X-MC-Unique: 9xdkMEx4NDW7eAOUJ-aSPA-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com [10.11.54.2])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id C1BFC1C07547;
        Wed,  5 Apr 2023 11:13:06 +0000 (UTC)
Received: from mrjust8.localdomain (unknown [10.43.17.42])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 9E5D840C6EC4;
        Wed,  5 Apr 2023 11:13:05 +0000 (UTC)
From:   Ondrej Kozina <okozina@redhat.com>
To:     linux-block@vger.kernel.org
Cc:     bluca@debian.org, gmazyland@gmail.com, axboe@kernel.dk,
        hch@infradead.org, brauner@kernel.org, jonathan.derrick@linux.dev,
        Ondrej Kozina <okozina@redhat.com>
Subject: [PATCH v2 5/5] sed-opal: Add command to read locking range parameters.
Date:   Wed,  5 Apr 2023 13:12:23 +0200
Message-Id: <20230405111223.272816-6-okozina@redhat.com>
In-Reply-To: <20230405111223.272816-1-okozina@redhat.com>
References: <20230322151604.401680-1-okozina@redhat.com>
 <20230405111223.272816-1-okozina@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.2
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

It returns following attributes:

locking range start
locking range length
read lock enabled
write lock enabled
lock state (RW, RO or LK)

It can be retrieved by user authority provided the authority
was added to locking range via prior IOC_OPAL_ADD_USR_TO_LR
ioctl command. The command was extended to add user in ACE that
allows to read attributes listed above.

Signed-off-by: Ondrej Kozina <okozina@redhat.com>
Tested-by: Luca Boccassi <bluca@debian.org>
Tested-by: Milan Broz <gmazyland@gmail.com>
---
 block/sed-opal.c              | 153 ++++++++++++++++++++++++++++++++++
 include/linux/sed-opal.h      |   1 +
 include/uapi/linux/sed-opal.h |  11 +++
 3 files changed, 165 insertions(+)

diff --git a/block/sed-opal.c b/block/sed-opal.c
index b95560d9c5eb..3fc4e65db111 100644
--- a/block/sed-opal.c
+++ b/block/sed-opal.c
@@ -1445,6 +1445,129 @@ static int setup_locking_range(struct opal_dev *dev, void *data)
 	return finalize_and_send(dev, parse_and_check_status);
 }
 
+static int response_get_column(const struct parsed_resp *resp,
+			       int *iter,
+			       u8 column,
+			       u64 *value)
+{
+	const struct opal_resp_tok *tok;
+	int n = *iter;
+	u64 val;
+
+	tok = response_get_token(resp, n);
+	if (IS_ERR(tok))
+		return PTR_ERR(tok);
+
+	if (!response_token_matches(tok, OPAL_STARTNAME)) {
+		pr_debug("Unexpected response token type %d.\n", n);
+		return OPAL_INVAL_PARAM;
+	}
+	n++;
+
+	if (response_get_u64(resp, n) != column) {
+		pr_debug("Token %d does not match expected column %u.\n",
+			 n, column);
+		return OPAL_INVAL_PARAM;
+	}
+	n++;
+
+	val = response_get_u64(resp, n);
+	n++;
+
+	tok = response_get_token(resp, n);
+	if (IS_ERR(tok))
+		return PTR_ERR(tok);
+
+	if (!response_token_matches(tok, OPAL_ENDNAME)) {
+		pr_debug("Unexpected response token type %d.\n", n);
+		return OPAL_INVAL_PARAM;
+	}
+	n++;
+
+	*value = val;
+	*iter = n;
+
+	return 0;
+}
+
+static int locking_range_status(struct opal_dev *dev, void *data)
+{
+	u8 lr_buffer[OPAL_UID_LENGTH];
+	u64 resp;
+	bool rlocked, wlocked;
+	int err, tok_n = 2;
+	struct opal_lr_status *lrst = data;
+
+	err = build_locking_range(lr_buffer, sizeof(lr_buffer),
+				  lrst->session.opal_key.lr);
+	if (err)
+		return err;
+
+	err = generic_get_columns(dev, lr_buffer, OPAL_RANGESTART,
+				  OPAL_WRITELOCKED);
+	if (err) {
+		pr_debug("Couldn't get lr %u table columns %d to %d.\n",
+			 lrst->session.opal_key.lr, OPAL_RANGESTART,
+			 OPAL_WRITELOCKED);
+		return err;
+	}
+
+	/* range start */
+	err = response_get_column(&dev->parsed, &tok_n, OPAL_RANGESTART,
+				  &lrst->range_start);
+	if (err)
+		return err;
+
+	/* range length */
+	err = response_get_column(&dev->parsed, &tok_n, OPAL_RANGELENGTH,
+				  &lrst->range_length);
+	if (err)
+		return err;
+
+	/* RLE */
+	err = response_get_column(&dev->parsed, &tok_n, OPAL_READLOCKENABLED,
+				  &resp);
+	if (err)
+		return err;
+
+	lrst->RLE = !!resp;
+
+	/* WLE */
+	err = response_get_column(&dev->parsed, &tok_n, OPAL_WRITELOCKENABLED,
+				  &resp);
+	if (err)
+		return err;
+
+	lrst->WLE = !!resp;
+
+	/* read locked */
+	err = response_get_column(&dev->parsed, &tok_n, OPAL_READLOCKED, &resp);
+	if (err)
+		return err;
+
+	rlocked = !!resp;
+
+	/* write locked */
+	err = response_get_column(&dev->parsed, &tok_n, OPAL_WRITELOCKED, &resp);
+	if (err)
+		return err;
+
+	wlocked = !!resp;
+
+	/* opal_lock_state can not map 'read locked' only state. */
+	lrst->l_state = OPAL_RW;
+	if (rlocked && wlocked)
+		lrst->l_state = OPAL_LK;
+	else if (wlocked)
+		lrst->l_state = OPAL_RO;
+	else if (rlocked) {
+		pr_debug("Can not report read locked only state.\n");
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
 static int start_generic_opal_session(struct opal_dev *dev,
 				      enum opal_uid auth,
 				      enum opal_uid sp_type,
@@ -2642,6 +2765,33 @@ static int opal_setup_locking_range(struct opal_dev *dev,
 	return ret;
 }
 
+static int opal_locking_range_status(struct opal_dev *dev,
+			  struct opal_lr_status *opal_lrst,
+			  void __user *data)
+{
+	const struct opal_step lr_steps[] = {
+		{ start_auth_opal_session, &opal_lrst->session },
+		{ locking_range_status, opal_lrst },
+		{ end_opal_session, }
+	};
+	int ret;
+
+	mutex_lock(&dev->dev_lock);
+	setup_opal_dev(dev);
+	ret = execute_steps(dev, lr_steps, ARRAY_SIZE(lr_steps));
+	mutex_unlock(&dev->dev_lock);
+
+	/* skip session info when copying back to uspace */
+	if (!ret && copy_to_user(data + offsetof(struct opal_lr_status, range_start),
+				(void *)opal_lrst + offsetof(struct opal_lr_status, range_start),
+				sizeof(*opal_lrst) - offsetof(struct opal_lr_status, range_start))) {
+		pr_debug("Error copying status to userspace\n");
+		return -EFAULT;
+	}
+
+	return ret;
+}
+
 static int opal_set_new_pw(struct opal_dev *dev, struct opal_new_pw *opal_pw)
 {
 	const struct opal_step pw_steps[] = {
@@ -2876,6 +3026,9 @@ int sed_ioctl(struct opal_dev *dev, unsigned int cmd, void __user *arg)
 	case IOC_OPAL_GET_STATUS:
 		ret = opal_get_status(dev, arg);
 		break;
+	case IOC_OPAL_GET_LR_STATUS:
+		ret = opal_locking_range_status(dev, p, arg);
+		break;
 	default:
 		break;
 	}
diff --git a/include/linux/sed-opal.h b/include/linux/sed-opal.h
index 31ac562a17d7..042c1e2cb0ce 100644
--- a/include/linux/sed-opal.h
+++ b/include/linux/sed-opal.h
@@ -45,6 +45,7 @@ static inline bool is_sed_ioctl(unsigned int cmd)
 	case IOC_OPAL_WRITE_SHADOW_MBR:
 	case IOC_OPAL_GENERIC_TABLE_RW:
 	case IOC_OPAL_GET_STATUS:
+	case IOC_OPAL_GET_LR_STATUS:
 		return true;
 	}
 	return false;
diff --git a/include/uapi/linux/sed-opal.h b/include/uapi/linux/sed-opal.h
index d7a1524023db..3905c8ffedbf 100644
--- a/include/uapi/linux/sed-opal.h
+++ b/include/uapi/linux/sed-opal.h
@@ -78,6 +78,16 @@ struct opal_user_lr_setup {
 	struct opal_session_info session;
 };
 
+struct opal_lr_status {
+	struct opal_session_info session;
+	__u64 range_start;
+	__u64 range_length;
+	__u32 RLE; /* Read Lock enabled */
+	__u32 WLE; /* Write Lock Enabled */
+	__u32 l_state;
+	__u8  align[4];
+};
+
 struct opal_lock_unlock {
 	struct opal_session_info session;
 	__u32 l_state;
@@ -168,5 +178,6 @@ struct opal_status {
 #define IOC_OPAL_WRITE_SHADOW_MBR   _IOW('p', 234, struct opal_shadow_mbr)
 #define IOC_OPAL_GENERIC_TABLE_RW   _IOW('p', 235, struct opal_read_write_table)
 #define IOC_OPAL_GET_STATUS         _IOR('p', 236, struct opal_status)
+#define IOC_OPAL_GET_LR_STATUS      _IOW('p', 237, struct opal_lr_status)
 
 #endif /* _UAPI_SED_OPAL_H */
-- 
2.31.1


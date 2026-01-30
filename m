Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8277E303A3B
	for <linux-block@vger.kernel.org>; Fri, 30 Jan 2026 16:26:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769790375; cv=none; b=GzladMS2B5FeYah1LdSakGWVH+kIO9Gne4r1TJDB4+VTjZvz5UemQKErszETeGR0cdy3M3zUZnKV981pPAGBD7ry5IAtLeAqz11gqlp2EFsP527hIwYMo+turzMlemDtS/od9l2yHOpiQgfPPGiD6I3MxiCOvcF06U2fQc1wlig=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769790375; c=relaxed/simple;
	bh=7O3w9noXcm0G0Z8mm0wt/jgwGRZvmvcFcwrYLJsqGBo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=q5+M+EimiTgXMBMwxKXgn9eZUWSWRwLIKMjjnIW+f2fzsjB378JhttbNcLlrKIfeT5M/26o8827c9mebQjvqKHxUFaaFVYTNkEMWJMht1tlvTqYx2+qjhKSJIuL56lBMJcH6dd7iQBMHZnZADc8XWAchLj19WeYlzRwZ2JHuVxE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Iqb4B7Te; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Iqb4B7Te"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1769790372;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=oOLnkJ90iCzzVTObZ679r/hKWTTcqG7OG+rfZyKUbEY=;
	b=Iqb4B7TeHyNIQ2+O1TqnjW/4ECBBYzBAKcuzJcKq9u1fUFT6cCsw/aV/qymMUXEbGiGx1Q
	Vgu4aQK+g2+X/2B6THFDRtka+278OZm0YPcGzEbq5kiNGb+qePtpepbD8pf3nGERZC/hhb
	+bvf60tj43Jr6hfj4qI5gfprz6Pg93M=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-537-_lHVV58kO5unq6jDSLW-Xg-1; Fri,
 30 Jan 2026 11:26:09 -0500
X-MC-Unique: _lHVV58kO5unq6jDSLW-Xg-1
X-Mimecast-MFC-AGG-ID: _lHVV58kO5unq6jDSLW-Xg_1769790367
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id CA6021800447;
	Fri, 30 Jan 2026 16:26:07 +0000 (UTC)
Received: from fedora.brq.redhat.com (unknown [10.43.17.192])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id ED4E63000218;
	Fri, 30 Jan 2026 16:26:05 +0000 (UTC)
From: Ondrej Kozina <okozina@redhat.com>
To: linux-block@vger.kernel.org
Cc: Ondrej Kozina <okozina@redhat.com>,
	gmazyland@gmail.com,
	gjoyce@ibm.com,
	jonathan.derrick@linux.dev
Subject: [PATCH 6/6] sed-opal: add IOC_OPAL_GET_SUM_STATUS ioctl.
Date: Fri, 30 Jan 2026 17:25:12 +0100
Message-ID: <20260130162527.570255-7-okozina@redhat.com>
In-Reply-To: <20260130162527.570255-1-okozina@redhat.com>
References: <20260130162527.570255-1-okozina@redhat.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

This adds a function for retrieving the set of Locking objects enabled
for Single User Mode (SUM) and the value of the
RangeStartRangeLengthPolicy parameter.

Signed-off-by: Ondrej Kozina <okozina@redhat.com>
---
 block/sed-opal.c              | 149 ++++++++++++++++++++++++++++++++++
 include/linux/sed-opal.h      |   1 +
 include/uapi/linux/sed-opal.h |   9 ++
 3 files changed, 159 insertions(+)

diff --git a/block/sed-opal.c b/block/sed-opal.c
index ae1a6f668cbb..695d25bccd8b 100644
--- a/block/sed-opal.c
+++ b/block/sed-opal.c
@@ -1759,6 +1759,12 @@ static int start_anybodyASP_opal_session(struct opal_dev *dev, void *data)
 					  OPAL_ADMINSP_UID, NULL, 0);
 }
 
+static int start_anybodyLSP_opal_session(struct opal_dev *dev, void *data)
+{
+	return start_generic_opal_session(dev, OPAL_ANYBODY_UID,
+					  OPAL_LOCKINGSP_UID, NULL, 0);
+}
+
 static int start_SIDASP_opal_session(struct opal_dev *dev, void *data)
 {
 	int ret;
@@ -3381,6 +3387,146 @@ static int opal_get_geometry(struct opal_dev *dev, void __user *data)
 	return 0;
 }
 
+static int get_sum_ranges(struct opal_dev *dev, void *data)
+{
+	const char *lr_uid;
+	size_t lr_uid_len;
+	u64 val;
+	const struct opal_resp_tok *tok;
+	int err, tok_n = 2;
+	struct opal_sum_ranges *sranges = data;
+	const __u8 lr_all[OPAL_MAX_LRS] = { 0, 1, 2, 3, 4, 5, 6, 7, 8 };
+
+	err = generic_get_columns(dev, opaluid[OPAL_LOCKING_INFO_TABLE], OPAL_SUM_SET_LIST,
+				  OPAL_SUM_RANGE_POLICY);
+	if (err) {
+		pr_debug("Couldn't get locking info table columns %d to %d.\n",
+			 OPAL_SUM_SET_LIST, OPAL_SUM_RANGE_POLICY);
+		return err;
+	}
+
+	tok = response_get_token(&dev->parsed, tok_n);
+	if (IS_ERR(tok))
+		return PTR_ERR(tok);
+
+	if (!response_token_matches(tok, OPAL_STARTNAME)) {
+		pr_debug("Unexpected response token type %d.\n", tok_n);
+		return OPAL_INVAL_PARAM;
+	}
+	tok_n++;
+
+	if (response_get_u64(&dev->parsed, tok_n) != OPAL_SUM_SET_LIST) {
+		pr_debug("Token %d does not match expected column %u.\n",
+			 tok_n, OPAL_SUM_SET_LIST);
+		return OPAL_INVAL_PARAM;
+	}
+	tok_n++;
+
+	tok = response_get_token(&dev->parsed, tok_n);
+	if (IS_ERR(tok))
+		return PTR_ERR(tok);
+
+	if (response_token_matches(tok, OPAL_STARTLIST)) {
+		sranges->num_lrs = 0;
+
+		tok_n++;
+		tok = response_get_token(&dev->parsed, tok_n);
+		if (IS_ERR(tok))
+			return PTR_ERR(tok);
+
+		while (!response_token_matches(tok, OPAL_ENDLIST)) {
+			lr_uid_len = response_get_string(&dev->parsed, tok_n, &lr_uid);
+			if (lr_uid_len != OPAL_UID_LENGTH) {
+				pr_debug("Unexpected response token type %d.\n", tok_n);
+				return OPAL_INVAL_PARAM;
+			}
+
+			if (memcmp(lr_uid, opaluid[OPAL_LOCKINGRANGE_GLOBAL], OPAL_UID_LENGTH)) {
+				if (lr_uid[5] != LOCKING_RANGE_NON_GLOBAL) {
+					pr_debug("Unexpected byte %d at LR UUID position 5.\n",
+						 lr_uid[5]);
+					return OPAL_INVAL_PARAM;
+				}
+				sranges->lr[sranges->num_lrs++] = lr_uid[7];
+			} else
+				sranges->lr[sranges->num_lrs++] = 0;
+
+			tok_n++;
+			tok = response_get_token(&dev->parsed, tok_n);
+			if (IS_ERR(tok))
+				return PTR_ERR(tok);
+		}
+	} else {
+		/* Only OPAL_LOCKING_TABLE UID is an alternative to OPAL_STARTLIST here. */
+		lr_uid_len = response_get_string(&dev->parsed, tok_n, &lr_uid);
+		if (lr_uid_len != OPAL_UID_LENGTH) {
+			pr_debug("Unexpected response token type %d.\n", tok_n);
+			return OPAL_INVAL_PARAM;
+		}
+
+		if (memcmp(lr_uid, opaluid[OPAL_LOCKING_TABLE], OPAL_UID_LENGTH)) {
+			pr_debug("Unexpected response UID.\n");
+			return OPAL_INVAL_PARAM;
+		}
+
+		/* sed-opal kernel API already provides following limit in Activate command */
+		sranges->num_lrs = OPAL_MAX_LRS;
+		memcpy(sranges->lr, lr_all, OPAL_MAX_LRS);
+	}
+	tok_n++;
+
+	tok = response_get_token(&dev->parsed, tok_n);
+	if (IS_ERR(tok))
+		return PTR_ERR(tok);
+
+	if (!response_token_matches(tok, OPAL_ENDNAME)) {
+		pr_debug("Unexpected response token type %d.\n", tok_n);
+		return OPAL_INVAL_PARAM;
+	}
+	tok_n++;
+
+	err = response_get_column(&dev->parsed, &tok_n, OPAL_SUM_RANGE_POLICY, &val);
+	if (err)
+		return err;
+
+	sranges->range_policy = val ? 1 : 0;
+
+	return 0;
+}
+
+static int opal_get_sum_ranges(struct opal_dev *dev, struct opal_sum_ranges *opal_sum_rngs,
+			       void __user *data)
+{
+	const struct opal_step admin_steps[] = {
+		{ start_admin1LSP_opal_session, &opal_sum_rngs->key },
+		{ get_sum_ranges, opal_sum_rngs },
+		{ end_opal_session, }
+	}, anybody_steps[] = {
+		{ start_anybodyLSP_opal_session, NULL },
+		{ get_sum_ranges, opal_sum_rngs },
+		{ end_opal_session, }
+	};
+	int ret;
+
+	mutex_lock(&dev->dev_lock);
+	setup_opal_dev(dev);
+	if (opal_sum_rngs->key.key_len)
+		ret = execute_steps(dev, admin_steps, ARRAY_SIZE(admin_steps));
+	else
+		ret = execute_steps(dev, anybody_steps, ARRAY_SIZE(anybody_steps));
+	mutex_unlock(&dev->dev_lock);
+
+	/* skip session info when copying back to uspace */
+	if (!ret && copy_to_user(data + offsetof(struct opal_sum_ranges, num_lrs),
+				(void *)opal_sum_rngs + offsetof(struct opal_sum_ranges, num_lrs),
+				sizeof(*opal_sum_rngs) - offsetof(struct opal_sum_ranges, num_lrs))) {
+		pr_debug("Error copying SUM ranges info to userspace\n");
+		return -EFAULT;
+	}
+
+	return ret;
+}
+
 int sed_ioctl(struct opal_dev *dev, unsigned int cmd, void __user *arg)
 {
 	void *p;
@@ -3475,6 +3621,9 @@ int sed_ioctl(struct opal_dev *dev, unsigned int cmd, void __user *arg)
 	case IOC_OPAL_ENABLE_DISABLE_LR:
 		ret = opal_enable_disable_range(dev, p);
 		break;
+	case IOC_OPAL_GET_SUM_STATUS:
+		ret = opal_get_sum_ranges(dev, p, arg);
+		break;
 
 	default:
 		break;
diff --git a/include/linux/sed-opal.h b/include/linux/sed-opal.h
index 1d63479838cf..aa006edb612b 100644
--- a/include/linux/sed-opal.h
+++ b/include/linux/sed-opal.h
@@ -56,6 +56,7 @@ static inline bool is_sed_ioctl(unsigned int cmd)
 	case IOC_OPAL_REACTIVATE_LSP:
 	case IOC_OPAL_LR_SET_START_LEN:
 	case IOC_OPAL_ENABLE_DISABLE_LR:
+	case IOC_OPAL_GET_SUM_STATUS:
 		return true;
 	}
 	return false;
diff --git a/include/uapi/linux/sed-opal.h b/include/uapi/linux/sed-opal.h
index 5c3a9f3e4abc..28d97a03f98f 100644
--- a/include/uapi/linux/sed-opal.h
+++ b/include/uapi/linux/sed-opal.h
@@ -111,6 +111,14 @@ struct opal_lr_status {
 	__u8  align[4];
 };
 
+struct opal_sum_ranges {
+	struct opal_key key;
+	__u8 num_lrs;
+	__u8 lr[OPAL_MAX_LRS];
+	__u8 range_policy;
+	__u8 align[5]; /* Align to 8 byte boundary */
+};
+
 struct opal_lock_unlock {
 	struct opal_session_info session;
 	__u32 l_state;
@@ -232,5 +240,6 @@ struct opal_revert_lsp {
 #define IOC_OPAL_REACTIVATE_LSP     _IOW('p', 242, struct opal_lr_react)
 #define IOC_OPAL_LR_SET_START_LEN   _IOW('p', 243, struct opal_user_lr_setup)
 #define IOC_OPAL_ENABLE_DISABLE_LR  _IOW('p', 244, struct opal_user_lr_setup)
+#define IOC_OPAL_GET_SUM_STATUS     _IOW('p', 245, struct opal_sum_ranges)
 
 #endif /* _UAPI_SED_OPAL_H */
-- 
2.52.0


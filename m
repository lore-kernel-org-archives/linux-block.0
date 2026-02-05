Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2D7B4219E2
	for <linux-block@vger.kernel.org>; Thu,  5 Feb 2026 15:10:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770304203; cv=none; b=eV1ya1E5enV0azHP+9vrXMvquAlXrabgsci7tZSCAQt1xKzgML1ceMMzW2hbBwveyGFoUlNTsfpezpBAo8HK0DaCivzNEeK6L77HDUV0ZZWo0cU0jeRz98gNxf3VSyC7PcphnKqC/ltEf6FgFlT0jPNlSmoBJSuvruWVfiAJvtQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770304203; c=relaxed/simple;
	bh=K4hOnS22AM5a3H5j6QhgrB1u1ctvCVlre4yKknPK6Hs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cyP5ukGSCg/XXEgncLfu6ziQWLdwBCCog5eXfN0aay13iwSrHgq4qyYKmrLZBH6GJDr4LwGe0FJflZ2mMotdBMQ0SJNR1Bo+iB6Q1B7ZMoHehUUoPfHISToqFEbUTV3fjHVHf9bkU1akoHx52OmoFrKj32lqY3KVJaaAZzDkbWE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Le6nyIcR; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Le6nyIcR"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1770304202;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5ZMkB0VlL+MGnVJ3Mn6OH/pxuFKf/ljhfw/rzKdHYkE=;
	b=Le6nyIcRIrlW0w+MJMlfReb75ekbUVJxdfThYK8RISAuhGe7IfTV5fbjkt594opwVoljSv
	/nyZFIb/YhsS4eYfqSU1ieqOJyXG7Kj8/diAlAMzSbCNIw9a0vdKLXx0U2WJzNh0X4oolI
	Sa6/mm9VKJTPTb8kAQCngNacuiq3qn0=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-508-6-56WVmJPwaU_BUJ8FhQmw-1; Thu,
 05 Feb 2026 10:09:57 -0500
X-MC-Unique: 6-56WVmJPwaU_BUJ8FhQmw-1
X-Mimecast-MFC-AGG-ID: 6-56WVmJPwaU_BUJ8FhQmw_1770304196
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 73E641956095;
	Thu,  5 Feb 2026 15:09:56 +0000 (UTC)
Received: from fedora.brq.redhat.com (unknown [10.43.17.192])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id D07A118004BB;
	Thu,  5 Feb 2026 15:09:54 +0000 (UTC)
From: Ondrej Kozina <okozina@redhat.com>
To: linux-block@vger.kernel.org
Cc: Ondrej Kozina <okozina@redhat.com>,
	gmazyland@gmail.com,
	jonathan.derrick@linux.dev,
	gjoyce@ibm.com,
	hare@suse.de
Subject: [PATCH v2 4/9] sed-opal: add IOC_OPAL_REACTIVATE_LSP.
Date: Thu,  5 Feb 2026 16:09:27 +0100
Message-ID: <20260205150935.238137-5-okozina@redhat.com>
In-Reply-To: <20260130162527.570255-1-okozina@redhat.com>
References: <20260130162527.570255-1-okozina@redhat.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

This adds the 'Reactivate' method as described in the
"TCG Storage Opal SSC Feature Set: Single User Mode"
document (ch. 3.1.1.1).

The method enables switching an already active SED OPAL2 device,
with appropriate firmware support for Single User Mode (SUM),
to or from SUM.

Signed-off-by: Ondrej Kozina <okozina@redhat.com>
---
 block/opal_proto.h            |  1 +
 block/sed-opal.c              | 99 +++++++++++++++++++++++++++++++++++
 include/linux/sed-opal.h      |  1 +
 include/uapi/linux/sed-opal.h | 14 +++++
 4 files changed, 115 insertions(+)

diff --git a/block/opal_proto.h b/block/opal_proto.h
index 3ccee5977c10..d138785b8198 100644
--- a/block/opal_proto.h
+++ b/block/opal_proto.h
@@ -155,6 +155,7 @@ enum opal_method {
 	OPAL_AUTHENTICATE,
 	OPAL_RANDOM,
 	OPAL_ERASE,
+	OPAL_REACTIVATE,
 };
 
 enum opal_token {
diff --git a/block/sed-opal.c b/block/sed-opal.c
index 13ed2dd83c5d..a8d18afb3eba 100644
--- a/block/sed-opal.c
+++ b/block/sed-opal.c
@@ -220,6 +220,8 @@ static const u8 opalmethod[][OPAL_METHOD_LENGTH] = {
 		{ 0x00, 0x00, 0x00, 0x06, 0x00, 0x00, 0x06, 0x01 },
 	[OPAL_ERASE] =
 		{ 0x00, 0x00, 0x00, 0x06, 0x00, 0x00, 0x08, 0x03 },
+	[OPAL_REACTIVATE] =
+		{ 0x00, 0x00, 0x00, 0x06, 0x00, 0x00, 0x08, 0x01 },
 };
 
 static int end_opal_session_error(struct opal_dev *dev);
@@ -2287,6 +2289,74 @@ static int activate_lsp(struct opal_dev *dev, void *data)
 	return finalize_and_send(dev, parse_and_check_status);
 }
 
+static int reactivate_lsp(struct opal_dev *dev, void *data)
+{
+	struct opal_lr_react *opal_react = data;
+	u8 user_lr[OPAL_UID_LENGTH];
+	int err, i;
+
+	err = cmd_start(dev, opaluid[OPAL_THISSP_UID],
+			opalmethod[OPAL_REACTIVATE]);
+
+	if (err) {
+		pr_debug("Error building Reactivate LockingSP command.\n");
+		return err;
+	}
+
+	/*
+	 * If neither 'entire_table' nor 'num_lrs' is set, the device
+	 * gets reactivated with SUM disabled. Only Admin1PIN will change
+	 * if set.
+	 */
+	if (opal_react->entire_table) {
+		/* Entire Locking table (all locking ranges) will be put in SUM. */
+		add_token_u8(&err, dev, OPAL_STARTNAME);
+		add_token_u64(&err, dev, OPAL_SUM_SET_LIST);
+		add_token_bytestring(&err, dev, opaluid[OPAL_LOCKING_TABLE], OPAL_UID_LENGTH);
+		add_token_u8(&err, dev, OPAL_ENDNAME);
+	} else if (opal_react->num_lrs) {
+		/* Subset of Locking table (selected locking range(s)) to be put in SUM */
+		err = build_locking_range(user_lr, sizeof(user_lr),
+					  opal_react->lr[0]);
+		if (err)
+			return err;
+
+		add_token_u8(&err, dev, OPAL_STARTNAME);
+		add_token_u64(&err, dev, OPAL_SUM_SET_LIST);
+
+		add_token_u8(&err, dev, OPAL_STARTLIST);
+		add_token_bytestring(&err, dev, user_lr, OPAL_UID_LENGTH);
+		for (i = 1; i < opal_react->num_lrs; i++) {
+			user_lr[7] = opal_react->lr[i];
+			add_token_bytestring(&err, dev, user_lr, OPAL_UID_LENGTH);
+		}
+		add_token_u8(&err, dev, OPAL_ENDLIST);
+		add_token_u8(&err, dev, OPAL_ENDNAME);
+	}
+
+	/* Skipping the rangle policy parameter is same as setting its value to zero */
+	if (opal_react->range_policy && (opal_react->num_lrs || opal_react->entire_table)) {
+		add_token_u8(&err, dev, OPAL_STARTNAME);
+		add_token_u64(&err, dev, OPAL_SUM_RANGE_POLICY);
+		add_token_u8(&err, dev, 1);
+		add_token_u8(&err, dev, OPAL_ENDNAME);
+	}
+
+	/*
+	 * Optional parameter. If set, it changes the Admin1 PIN even when SUM
+	 * is being disabled.
+	 */
+	if (opal_react->new_admin_key.key_len) {
+		add_token_u8(&err, dev, OPAL_STARTNAME);
+		add_token_u64(&err, dev, OPAL_SUM_ADMIN1_PIN);
+		add_token_bytestring(&err, dev, opal_react->new_admin_key.key,
+				     opal_react->new_admin_key.key_len);
+		add_token_u8(&err, dev, OPAL_ENDNAME);
+	}
+
+	return finalize_and_send(dev, parse_and_check_status);
+}
+
 /* Determine if we're in the Manufactured Inactive or Active state */
 static int get_lsp_lifecycle(struct opal_dev *dev, void *data)
 {
@@ -2956,6 +3026,32 @@ static int opal_activate_lsp(struct opal_dev *dev,
 	return ret;
 }
 
+static int opal_reactivate_lsp(struct opal_dev *dev,
+			       struct opal_lr_react *opal_lr_react)
+{
+	const struct opal_step active_steps[] = {
+		{ start_admin1LSP_opal_session, &opal_lr_react->key },
+		{ reactivate_lsp, opal_lr_react },
+		/* No end_opal_session. The controller terminates the session */
+	};
+	int ret;
+
+	/* use either 'entire_table' parameter or set of locking ranges */
+	if (opal_lr_react->num_lrs > OPAL_MAX_LRS ||
+	    (opal_lr_react->num_lrs && opal_lr_react->entire_table))
+		return -EINVAL;
+
+	ret = opal_get_key(dev, &opal_lr_react->key);
+	if (ret)
+		return ret;
+	mutex_lock(&dev->dev_lock);
+	setup_opal_dev(dev);
+	ret = execute_steps(dev, active_steps, ARRAY_SIZE(active_steps));
+	mutex_unlock(&dev->dev_lock);
+
+	return ret;
+}
+
 static int opal_setup_locking_range(struct opal_dev *dev,
 				    struct opal_user_lr_setup *opal_lrs)
 {
@@ -3314,6 +3410,9 @@ int sed_ioctl(struct opal_dev *dev, unsigned int cmd, void __user *arg)
 	case IOC_OPAL_SET_SID_PW:
 		ret = opal_set_new_sid_pw(dev, p);
 		break;
+	case IOC_OPAL_REACTIVATE_LSP:
+		ret = opal_reactivate_lsp(dev, p);
+		break;
 
 	default:
 		break;
diff --git a/include/linux/sed-opal.h b/include/linux/sed-opal.h
index 80f33a93f944..2ae5e6b0ac21 100644
--- a/include/linux/sed-opal.h
+++ b/include/linux/sed-opal.h
@@ -53,6 +53,7 @@ static inline bool is_sed_ioctl(unsigned int cmd)
 	case IOC_OPAL_DISCOVERY:
 	case IOC_OPAL_REVERT_LSP:
 	case IOC_OPAL_SET_SID_PW:
+	case IOC_OPAL_REACTIVATE_LSP:
 		return true;
 	}
 	return false;
diff --git a/include/uapi/linux/sed-opal.h b/include/uapi/linux/sed-opal.h
index 9025dd5a4f0f..d03e590b6501 100644
--- a/include/uapi/linux/sed-opal.h
+++ b/include/uapi/linux/sed-opal.h
@@ -74,6 +74,19 @@ struct opal_lr_act {
 	__u8 align[2]; /* Align to 8 byte boundary */
 };
 
+struct opal_lr_react {
+	struct opal_key key;
+	struct opal_key new_admin_key; /* Set new Admin1 PIN if key_len is > 0 */
+	__u8 num_lrs; /*
+		       * Configure selected ranges (from lr[]) in SUM.
+		       * If num_lrs > 0 the 'entire_table' must be 0
+		       */
+	__u8 lr[OPAL_MAX_LRS];
+	__u8 range_policy; /* Set RangeStartRangeLengthPolicy parameter */
+	__u8 entire_table; /* Set all locking objects in SUM */
+	__u8 align[4]; /* Align to 8 byte boundary */
+};
+
 struct opal_session_info {
 	__u32 sum;
 	__u32 who;
@@ -216,5 +229,6 @@ struct opal_revert_lsp {
 #define IOC_OPAL_DISCOVERY          _IOW('p', 239, struct opal_discovery)
 #define IOC_OPAL_REVERT_LSP         _IOW('p', 240, struct opal_revert_lsp)
 #define IOC_OPAL_SET_SID_PW         _IOW('p', 241, struct opal_new_pw)
+#define IOC_OPAL_REACTIVATE_LSP     _IOW('p', 242, struct opal_lr_react)
 
 #endif /* _UAPI_SED_OPAL_H */
-- 
2.52.0


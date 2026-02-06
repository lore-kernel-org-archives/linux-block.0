Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 730BE3EF0A7
	for <linux-block@vger.kernel.org>; Fri,  6 Feb 2026 14:18:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770387535; cv=none; b=aJL9ssft3wWCaU/ze6djW+YfPewvB9niD19imT/H8P+QrOEj2myqTtKOwjJEzODr0MALtsHzTYEpeFNBN+qX25AH22vLTsjB3lwYJR6978Uto7NEBsQRGaSLKNJfX5q3w9hDY20/AkLRMtiTNDfCYD3KzrqWmc53OIb7uAT8ndI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770387535; c=relaxed/simple;
	bh=1DCRIQfi6Lw8EG63xjl+gV4qIy1T39/6lELueUO4foo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Nfhn80bSad14U2SziiAMWC9bb+qdXvkWkkC9qfvdJk2BYTOkCoUC1cmdCMeXNiEJBLVDO4nMnLaesjCIqURA+/H3yLqo8iORJXp5f5IIH5OiUZHjvd5RNlopM1hcGVzT1Xj2aIFcYPk3vKsMmsBeIGgS3hfVqe7zrSym376m8kw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=M3p6OAQq; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="M3p6OAQq"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1770387534;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=KCyWytnLCTs9RUSFH2WHBbxzB9IFRxyXLOmryEvJBk8=;
	b=M3p6OAQqwvUVzsEUc9zLCafHJfSSueBrzWMGH4AJusQxhozu3kIM5cuxUniq1sUPWLqFW9
	NnLWw4YgZmCTVP868zHpuPH/K96ji0hUdkvObV0nU+gANmRd7RKhJ7ZjTwybCawy9GOKYo
	fiQZ0beSWXl8rYbze6sLFM7H80FNOnY=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-330-hubF3lKoP5elKYyL-xAbMA-1; Fri,
 06 Feb 2026 09:18:51 -0500
X-MC-Unique: hubF3lKoP5elKYyL-xAbMA-1
X-Mimecast-MFC-AGG-ID: hubF3lKoP5elKYyL-xAbMA_1770387530
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 30B4E1800A3E;
	Fri,  6 Feb 2026 14:18:50 +0000 (UTC)
Received: from fedora.redhat.com (unknown [10.44.34.202])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 6476B18004BB;
	Fri,  6 Feb 2026 14:18:48 +0000 (UTC)
From: Ondrej Kozina <okozina@redhat.com>
To: linux-block@vger.kernel.org
Cc: Ondrej Kozina <okozina@redhat.com>,
	gmazyland@gmail.com,
	jonathan.derrick@linux.dev,
	gjoyce@ibm.com,
	hare@suse.de
Subject: [PATCH v3 6/9] sed-opal: add IOC_OPAL_LR_SET_START_LEN ioctl.
Date: Fri,  6 Feb 2026 15:18:00 +0100
Message-ID: <20260206141804.278721-7-okozina@redhat.com>
In-Reply-To: <20260205150935.238137-1-okozina@redhat.com>
References: <20260205150935.238137-1-okozina@redhat.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

This ioctl is used to set up locking range start (offset)
and locking range length attributes only.

In Single User Mode (SUM), if the RangeStartRangeLengthPolicy parameter
is set in the 'Reactivate' method, only Admin authority maintains the
locking range length and start (offset) attributes of Locking objects
set up for SUM. All other attributes from struct opal_user_lr_setup
(RLE - read locking enabled, WLE - write locking enabled) shall
remain in possession of the User authority associated with the Locking
object set for SUM.

Therefore, we need a separate function for setting up locking range
start and locking range length because it may require two different
authorities (and sessions) if the RangeStartRangeLengthPolicy attribute
is set.

With the IOC_OPAL_LR_SET_START_LEN ioctl, the opal_user_lr_setup
members 'RLE' and 'WLE' of the ioctl argument are ignored.

Signed-off-by: Ondrej Kozina <okozina@redhat.com>
---
 block/sed-opal.c              | 28 ++++++++++++++++++++++++++++
 include/linux/sed-opal.h      |  1 +
 include/uapi/linux/sed-opal.h |  1 +
 3 files changed, 30 insertions(+)

diff --git a/block/sed-opal.c b/block/sed-opal.c
index 502ff9b0940b..07b68cae362d 100644
--- a/block/sed-opal.c
+++ b/block/sed-opal.c
@@ -3090,6 +3090,31 @@ static int opal_setup_locking_range(struct opal_dev *dev,
 	return ret;
 }
 
+static int opal_setup_locking_range_start_length(struct opal_dev *dev,
+				    struct opal_user_lr_setup *opal_lrs)
+{
+	const struct opal_step lr_steps[] = {
+		{ start_auth_opal_session, &opal_lrs->session },
+		{ setup_locking_range_start_length, opal_lrs },
+		{ end_opal_session, }
+	};
+	int ret;
+
+	/* we can not set global locking range offset or length */
+	if (opal_lrs->session.opal_key.lr == 0)
+		return -EINVAL;
+
+	ret = opal_get_key(dev, &opal_lrs->session.opal_key);
+	if (ret)
+		return ret;
+	mutex_lock(&dev->dev_lock);
+	setup_opal_dev(dev);
+	ret = execute_steps(dev, lr_steps, ARRAY_SIZE(lr_steps));
+	mutex_unlock(&dev->dev_lock);
+
+	return ret;
+}
+
 static int opal_locking_range_status(struct opal_dev *dev,
 			  struct opal_lr_status *opal_lrst,
 			  void __user *data)
@@ -3430,6 +3455,9 @@ int sed_ioctl(struct opal_dev *dev, unsigned int cmd, void __user *arg)
 	case IOC_OPAL_REACTIVATE_LSP:
 		ret = opal_reactivate_lsp(dev, p);
 		break;
+	case IOC_OPAL_LR_SET_START_LEN:
+		ret = opal_setup_locking_range_start_length(dev, p);
+		break;
 
 	default:
 		break;
diff --git a/include/linux/sed-opal.h b/include/linux/sed-opal.h
index 2ae5e6b0ac21..a0df6819b0a9 100644
--- a/include/linux/sed-opal.h
+++ b/include/linux/sed-opal.h
@@ -54,6 +54,7 @@ static inline bool is_sed_ioctl(unsigned int cmd)
 	case IOC_OPAL_REVERT_LSP:
 	case IOC_OPAL_SET_SID_PW:
 	case IOC_OPAL_REACTIVATE_LSP:
+	case IOC_OPAL_LR_SET_START_LEN:
 		return true;
 	}
 	return false;
diff --git a/include/uapi/linux/sed-opal.h b/include/uapi/linux/sed-opal.h
index d03e590b6501..82de38f3fbeb 100644
--- a/include/uapi/linux/sed-opal.h
+++ b/include/uapi/linux/sed-opal.h
@@ -230,5 +230,6 @@ struct opal_revert_lsp {
 #define IOC_OPAL_REVERT_LSP         _IOW('p', 240, struct opal_revert_lsp)
 #define IOC_OPAL_SET_SID_PW         _IOW('p', 241, struct opal_new_pw)
 #define IOC_OPAL_REACTIVATE_LSP     _IOW('p', 242, struct opal_lr_react)
+#define IOC_OPAL_LR_SET_START_LEN   _IOW('p', 243, struct opal_user_lr_setup)
 
 #endif /* _UAPI_SED_OPAL_H */
-- 
2.52.0


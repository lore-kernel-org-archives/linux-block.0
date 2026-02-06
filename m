Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E19F2FCBE5
	for <linux-block@vger.kernel.org>; Fri,  6 Feb 2026 14:18:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770387538; cv=none; b=Zkdp+t5TkCg75gFIM/thVeRBCH7uXId6h5mEpeFxXQAljuD+94Y+u25TLevd+TfylMLqXlX9XpN49haPopMbxVuLKMnzwLmX4JJUdt85k90/ehTxKiNlJjNTWssLPTppxm0//1PYPzAB7VyE9NDHC/RnZBkG/DodsJdl/UlAiwU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770387538; c=relaxed/simple;
	bh=5qKOg0/m/wCR2J0WbcfKj6pl/Z24rVhu7xcuw07UZ9s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=adqjFcyTdQKcmv3AjHpoybY2PIgfOuAw7hZ89ybZdELrdTw2ulFIjp5/dofUE5EKCEPUiimQwnExQ1/O/dhdWGvb4npwFykXT3e60cNZik/5y1ctYfXFuIYX9UByvM/xAfaequcrgsgH2J8jLoobLynNwKDX/eRs62TQYUrPYqI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Xh7jMHnE; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Xh7jMHnE"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1770387537;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=nzuJtAXWNX96QnJs8OpJg6X4DNbKoe05ajnOzOJFoBs=;
	b=Xh7jMHnE8qUua0e6HaeDyRGLMcrwduNqVFgVQW13a5mkkijsdiGtRF665V0SKcEOIjNAp3
	mNebOfQLVYlFDzCpU8gYAdhDOAvk6ZRxaBlROfAtuDbyDObKB9OGWWowKJDJUUiVcdRPqa
	+eiFXyoCZVv8MbZ0jCDm4J21oYCTbZs=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-610-7WDIL22HPJ6bksFlihQEFw-1; Fri,
 06 Feb 2026 09:18:53 -0500
X-MC-Unique: 7WDIL22HPJ6bksFlihQEFw-1
X-Mimecast-MFC-AGG-ID: 7WDIL22HPJ6bksFlihQEFw_1770387532
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 768C719560A7;
	Fri,  6 Feb 2026 14:18:52 +0000 (UTC)
Received: from fedora.redhat.com (unknown [10.44.34.202])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 9969B180035A;
	Fri,  6 Feb 2026 14:18:50 +0000 (UTC)
From: Ondrej Kozina <okozina@redhat.com>
To: linux-block@vger.kernel.org
Cc: Ondrej Kozina <okozina@redhat.com>,
	gmazyland@gmail.com,
	jonathan.derrick@linux.dev,
	gjoyce@ibm.com,
	hare@suse.de
Subject: [PATCH v3 7/9] sed-opal: add IOC_OPAL_ENABLE_DISABLE_LR.
Date: Fri,  6 Feb 2026 15:18:01 +0100
Message-ID: <20260206141804.278721-8-okozina@redhat.com>
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

This ioctl is used to set up RLE (read lock enabled) and WLE (write
lock enabled) parameters of the Locking object.

In Single User Mode (SUM), if the RangeStartRangeLengthPolicy parameter
is set in the 'Reactivate' method, only Admin authority maintains the
locking range length and start (offset) attributes of Locking objects
set up for SUM. All other attributes from struct opal_user_lr_setup
(RLE - read locking enabled, WLE - write locking enabled) shall
remain in possession of the User authority associated with the Locking
object set for SUM.

With the IOC_OPAL_ENABLE_DISABLE_LR ioctl, the opal_user_lr_setup
members 'range_start' and 'range_length' of the ioctl argument are
ignored.

Signed-off-by: Ondrej Kozina <okozina@redhat.com>
---
 block/sed-opal.c              | 24 ++++++++++++++++++++++++
 include/linux/sed-opal.h      |  1 +
 include/uapi/linux/sed-opal.h |  1 +
 3 files changed, 26 insertions(+)

diff --git a/block/sed-opal.c b/block/sed-opal.c
index 07b68cae362d..edde7fa52ab3 100644
--- a/block/sed-opal.c
+++ b/block/sed-opal.c
@@ -3115,6 +3115,27 @@ static int opal_setup_locking_range_start_length(struct opal_dev *dev,
 	return ret;
 }
 
+static int opal_enable_disable_range(struct opal_dev *dev,
+			     struct opal_user_lr_setup *opal_lrs)
+{
+	const struct opal_step lr_steps[] = {
+		{ start_auth_opal_session, &opal_lrs->session },
+		{ setup_enable_range, opal_lrs },
+		{ end_opal_session, }
+	};
+	int ret;
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
@@ -3458,6 +3479,9 @@ int sed_ioctl(struct opal_dev *dev, unsigned int cmd, void __user *arg)
 	case IOC_OPAL_LR_SET_START_LEN:
 		ret = opal_setup_locking_range_start_length(dev, p);
 		break;
+	case IOC_OPAL_ENABLE_DISABLE_LR:
+		ret = opal_enable_disable_range(dev, p);
+		break;
 
 	default:
 		break;
diff --git a/include/linux/sed-opal.h b/include/linux/sed-opal.h
index a0df6819b0a9..1d63479838cf 100644
--- a/include/linux/sed-opal.h
+++ b/include/linux/sed-opal.h
@@ -55,6 +55,7 @@ static inline bool is_sed_ioctl(unsigned int cmd)
 	case IOC_OPAL_SET_SID_PW:
 	case IOC_OPAL_REACTIVATE_LSP:
 	case IOC_OPAL_LR_SET_START_LEN:
+	case IOC_OPAL_ENABLE_DISABLE_LR:
 		return true;
 	}
 	return false;
diff --git a/include/uapi/linux/sed-opal.h b/include/uapi/linux/sed-opal.h
index 82de38f3fbeb..bde023ae2295 100644
--- a/include/uapi/linux/sed-opal.h
+++ b/include/uapi/linux/sed-opal.h
@@ -231,5 +231,6 @@ struct opal_revert_lsp {
 #define IOC_OPAL_SET_SID_PW         _IOW('p', 241, struct opal_new_pw)
 #define IOC_OPAL_REACTIVATE_LSP     _IOW('p', 242, struct opal_lr_react)
 #define IOC_OPAL_LR_SET_START_LEN   _IOW('p', 243, struct opal_user_lr_setup)
+#define IOC_OPAL_ENABLE_DISABLE_LR  _IOW('p', 244, struct opal_user_lr_setup)
 
 #endif /* _UAPI_SED_OPAL_H */
-- 
2.52.0


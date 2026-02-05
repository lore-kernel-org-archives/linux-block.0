Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 073B041324C
	for <linux-block@vger.kernel.org>; Thu,  5 Feb 2026 15:10:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770304208; cv=none; b=nzSrXzPrX/ISBC1cjbPDoQDmAHz+6zhhUUya/hXNPp8HInbSdBomDAJFlRMZbTmBwxod2n+I1AJQY/+6cIcKRikHulIQOE18jyWzhbPvnIa28q0pQGhXiQW1L8RP1CmS0ehpl7qpVcJz/NO2HtRupV3sJGwDm9VqdngL8Ipk3j4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770304208; c=relaxed/simple;
	bh=5qKOg0/m/wCR2J0WbcfKj6pl/Z24rVhu7xcuw07UZ9s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CGZQo7jo8P1KCPvc9Gb8YglIefejwBu/fKsVoW/bDgpkWezJzNiXkjR1qcJfF4/NR5jgI+ayWJzXyfJJ+s/zamrCX7/pT/ajeoyYki8CA4QFOPsTzybBJlwqfhvsSaU3OnFUffpa916/dIXNveSt8cEBbAyNoIf3U/SCksR4oNY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=imbKgGud; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="imbKgGud"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1770304207;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=nzuJtAXWNX96QnJs8OpJg6X4DNbKoe05ajnOzOJFoBs=;
	b=imbKgGudqxRH56pXShjia3kmNR4EXmzTUiMdHaGzNOAF0blqV/gNl2w93lZp5WqyL6VvX8
	5w/FH8/XzFONQ6XIRUQHg7ay2WU5bLyGMgh1ibKYzJs8Fx+CPcAT+Wu+Q14GIsojUNchZv
	Qx3PcgzhJOlGMsxV1ORdDVWXjUy35TI=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-417-gLZC-iuLMC-gR2KpOtOK1Q-1; Thu,
 05 Feb 2026 10:10:03 -0500
X-MC-Unique: gLZC-iuLMC-gR2KpOtOK1Q-1
X-Mimecast-MFC-AGG-ID: gLZC-iuLMC-gR2KpOtOK1Q_1770304202
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 986C218001C6;
	Thu,  5 Feb 2026 15:10:02 +0000 (UTC)
Received: from fedora.brq.redhat.com (unknown [10.43.17.192])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id EE87E18004AD;
	Thu,  5 Feb 2026 15:10:00 +0000 (UTC)
From: Ondrej Kozina <okozina@redhat.com>
To: linux-block@vger.kernel.org
Cc: Ondrej Kozina <okozina@redhat.com>,
	gmazyland@gmail.com,
	jonathan.derrick@linux.dev,
	gjoyce@ibm.com,
	hare@suse.de
Subject: [PATCH v2 7/9] sed-opal: add IOC_OPAL_ENABLE_DISABLE_LR.
Date: Thu,  5 Feb 2026 16:09:30 +0100
Message-ID: <20260205150935.238137-8-okozina@redhat.com>
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


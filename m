Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A50FE34D3BE
	for <linux-block@vger.kernel.org>; Fri, 30 Jan 2026 16:26:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769790371; cv=none; b=V3rewFjlOmHMMpOKGjzieHtriuYm4sanwEa292BM95r4DCH3Ok5/mU32lUCCTvBF7+T+TssxJU6HBGc2KB9zCwXI2iHXn3IH8XFT+O5puFHG0LOEfvKE0ZbrMwqicuLNrRi467vmxzi9AOFfWkc0n3q2lmHgl6kuc5iG23Ch6mg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769790371; c=relaxed/simple;
	bh=LUHberTBcD00Rzh0FJIr9mcZcm6nJKaOLFruOU/ToHI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=thTPreCWJDBOgGxhAdvZ0bYJES21z6d+Ys4mptSjz5KSDfgcJOU1hIgwOPpO21r+t9mymIxiAlsRqZH7QUhCAKtlhJIDET8Wb/iBmvRfwGVNBO6DeC66oWsp3E8IsRLfwCtOVTwob6gs5sguAhrhNx4i29gCAHJEsXS5UX0vfWo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=iZmrwjvh; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="iZmrwjvh"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1769790368;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/JX+/lcgD+/cEobIU2ygLgxKz7RfsYBwtZbB0c89K/Y=;
	b=iZmrwjvhDWXmA8yTa2qgIeCz13WOpD1ffJbOLhRMRPXJcBDYILG3u1GEn8D/zwSZJf380X
	RLVFxbcI6hWhGTJbPjmaCBXFMGRf8aV+NfjgjfM8Sw1fNz+HQPP3roTwceVM4veIS5UCPH
	+uoE5a51Vh7mHHl/EKsT3QmUpQoH/Vc=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-223-_6YfAivmPamr1NtDufVjjA-1; Fri,
 30 Jan 2026 11:26:04 -0500
X-MC-Unique: _6YfAivmPamr1NtDufVjjA-1
X-Mimecast-MFC-AGG-ID: _6YfAivmPamr1NtDufVjjA_1769790363
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id B4A8818005BD;
	Fri, 30 Jan 2026 16:26:03 +0000 (UTC)
Received: from fedora.brq.redhat.com (unknown [10.43.17.192])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 379473001DB7;
	Fri, 30 Jan 2026 16:26:01 +0000 (UTC)
From: Ondrej Kozina <okozina@redhat.com>
To: linux-block@vger.kernel.org
Cc: Ondrej Kozina <okozina@redhat.com>,
	gmazyland@gmail.com,
	gjoyce@ibm.com,
	jonathan.derrick@linux.dev
Subject: [PATCH 4/6] sed-opal: add IOC_OPAL_ENABLE_DISABLE_LR.
Date: Fri, 30 Jan 2026 17:25:10 +0100
Message-ID: <20260130162527.570255-5-okozina@redhat.com>
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

The RangeStartRangeLengthPolicy attribute is described in ch.
3.1.1.1.1.2 of the TCG Storage Opal SSC Feature Set: Single User Mode
document.

Signed-off-by: Ondrej Kozina <okozina@redhat.com>
---
 block/sed-opal.c              | 24 ++++++++++++++++++++++++
 include/linux/sed-opal.h      |  1 +
 include/uapi/linux/sed-opal.h |  1 +
 3 files changed, 26 insertions(+)

diff --git a/block/sed-opal.c b/block/sed-opal.c
index 2c8d85cabdd5..d960450ab3ac 100644
--- a/block/sed-opal.c
+++ b/block/sed-opal.c
@@ -3108,6 +3108,27 @@ static int opal_setup_locking_range_start_length(struct opal_dev *dev,
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
@@ -3451,6 +3472,9 @@ int sed_ioctl(struct opal_dev *dev, unsigned int cmd, void __user *arg)
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
index bf796c05f4d0..5c3a9f3e4abc 100644
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


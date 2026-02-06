Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 987662FCBE5
	for <linux-block@vger.kernel.org>; Fri,  6 Feb 2026 14:18:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770387530; cv=none; b=dkx2xSnJvdZ6lwMV/GlG1U84X96L1P+rUlECFpDfQuCilnWaWRs5bpa2XepVTnuSTE2IHJ5/BaQHfLHNgIP9f0hkX+cn3t/I5EWqBMh7cAcrLGLrnd1DIypoxi5gaXMCCwTnTEhP3jpUTsO5eOCmRh0pcJwIKfclJVXApWH+abQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770387530; c=relaxed/simple;
	bh=iR/7R0L0PZX6hYlPwNbobvTEr6vnnf4eFBva5/Q6CuU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RTwZoxKkTwTFjq6MteUurMu6QrHG85g2boKJjEVjKnwFvDHGAQ6JvwdaFjjxE0VM4bjKs77Xrp6nKbZU9ECRMYtQAoKHLDgWnxw3HI/1XE64IznISCf9BjL5yYRlEIV4gd4hwompmUiecfotL54SoV6nHTqA9lXPa+jzvEp9hr0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Zo2DfVvw; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Zo2DfVvw"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1770387529;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4OZMYmfRu3bh/eGdRCoxi5mSyap6kGpFTDCzU5c95iU=;
	b=Zo2DfVvwnIiWsNhkApfREqp3mx6WJrrF2Uhh4mBfxFiReF2mSzgO9ImpQwJo4PQH/lid9T
	I9LWUJYiKSKF+u1UOezQqhcnASfu1fnKrMttXR2ykwuK5C91fJ2Zr1Yf5Sl4F3hMywAffi
	nMPiJkZONBSe5qQfjWcG39BjxsYGjxc=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-621-qlzj3AczP0-bANln7eyWkg-1; Fri,
 06 Feb 2026 09:18:46 -0500
X-MC-Unique: qlzj3AczP0-bANln7eyWkg-1
X-Mimecast-MFC-AGG-ID: qlzj3AczP0-bANln7eyWkg_1770387525
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id A963A19776B0;
	Fri,  6 Feb 2026 14:18:38 +0000 (UTC)
Received: from fedora.redhat.com (unknown [10.44.34.202])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id B356F1800671;
	Fri,  6 Feb 2026 14:18:36 +0000 (UTC)
From: Ondrej Kozina <okozina@redhat.com>
To: linux-block@vger.kernel.org
Cc: Ondrej Kozina <okozina@redhat.com>,
	gmazyland@gmail.com,
	jonathan.derrick@linux.dev,
	gjoyce@ibm.com,
	hare@suse.de
Subject: [PATCH v3 1/9] sed-opal: add UID of Locking Table.
Date: Fri,  6 Feb 2026 15:17:55 +0100
Message-ID: <20260206141804.278721-2-okozina@redhat.com>
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

As described in ch. 6.3, Table 240 in TCG Storage
Architecture Core Specification document.

It's also referenced in TCG Storage Opal SSC Feature Set:
Single User Mode document, ch. 3.1.1.1 Reactivate method.

It will be used later in Reactivate method implemetation
for sed-opal interface.

Signed-off-by: Ondrej Kozina <okozina@redhat.com>
---
 block/opal_proto.h | 1 +
 block/sed-opal.c   | 2 ++
 2 files changed, 3 insertions(+)

diff --git a/block/opal_proto.h b/block/opal_proto.h
index d247a457bf6e..3dfba3de7be1 100644
--- a/block/opal_proto.h
+++ b/block/opal_proto.h
@@ -125,6 +125,7 @@ enum opal_uid {
 	OPAL_LOCKING_INFO_TABLE,
 	OPAL_ENTERPRISE_LOCKING_INFO_TABLE,
 	OPAL_DATASTORE,
+	OPAL_LOCKING_TABLE,
 	/* C_PIN_TABLE object ID's */
 	OPAL_C_PIN_MSID,
 	OPAL_C_PIN_SID,
diff --git a/block/sed-opal.c b/block/sed-opal.c
index 5a28f23f7f22..13ed2dd83c5d 100644
--- a/block/sed-opal.c
+++ b/block/sed-opal.c
@@ -160,6 +160,8 @@ static const u8 opaluid[][OPAL_UID_LENGTH] = {
 		{ 0x00, 0x00, 0x08, 0x01, 0x00, 0x00, 0x00, 0x00 },
 	[OPAL_DATASTORE] =
 		{ 0x00, 0x00, 0x10, 0x01, 0x00, 0x00, 0x00, 0x00 },
+	[OPAL_LOCKING_TABLE] =
+		{ 0x00, 0x00, 0x08, 0x02, 0x00, 0x00, 0x00, 0x00 },
 
 	/* C_PIN_TABLE object ID's */
 	[OPAL_C_PIN_MSID] =
-- 
2.52.0


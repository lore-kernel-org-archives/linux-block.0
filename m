Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26C0D18871F
	for <linux-block@vger.kernel.org>; Thu,  5 Feb 2026 15:10:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770304203; cv=none; b=T01q/8MhiOLdT9OwkMxbsl0gDO7pOPGpePfi6pettxtPF+7jv28CewGDRcPawBVvB/aeXVFKPiXP8X9k8vr1pq5uBEHbZuaj/LXfPUsLTXncsV4TyZu01cD2tyYxt0lefzQerx7ndfL4bf5ZZPV2DLj30reuM/m6IYEOjXUSCi0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770304203; c=relaxed/simple;
	bh=x6C19RHMe93+xU1Xcv7s3oqCwTuTyK52h0lRhS4h+ig=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ny4Srcgt9uYyOJ5E9QcXZ76RQaX1j5mvn6g4fbP9NwrWmjSoxMuvUkr+RsSvfFwBgbWpfPnvDRB+Ipyg1hULJEIOb3zM6NX96paOo52alNOnsQ77HzzCzwOj6HTMotr50zDzAFqfqQCBtu6dT+Ocj3m/xynZw+nZXvuX/TwgcCE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=NF8VVKIt; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NF8VVKIt"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1770304202;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=zPawCfML16h0jnyFQtsw2kAjKS6b2nyyaeDleyq5jcw=;
	b=NF8VVKItzJb1NMUeAmYA859z2EfoJOdWzq0rHM0jN3X3yWKDOlNh9370gagcCIye/eeinJ
	yEtIkLlZC1YiNifNHj+dWTpEqgRddeW3aRekg6B0fi9eWrDegj7hz29OAhm/yukczDVaZT
	uPHi38uEanqsP/tQsM8To7uDy769E6s=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-494-HVlyCbu0ONuQ3jU59ecmUA-1; Thu,
 05 Feb 2026 10:09:56 -0500
X-MC-Unique: HVlyCbu0ONuQ3jU59ecmUA-1
X-Mimecast-MFC-AGG-ID: HVlyCbu0ONuQ3jU59ecmUA_1770304194
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 73BE2195609E;
	Thu,  5 Feb 2026 15:09:54 +0000 (UTC)
Received: from fedora.brq.redhat.com (unknown [10.43.17.192])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id C65C618004AD;
	Thu,  5 Feb 2026 15:09:52 +0000 (UTC)
From: Ondrej Kozina <okozina@redhat.com>
To: linux-block@vger.kernel.org
Cc: Ondrej Kozina <okozina@redhat.com>,
	gmazyland@gmail.com,
	jonathan.derrick@linux.dev,
	gjoyce@ibm.com,
	hare@suse.de
Subject: [PATCH v2 3/9] sed-opal: add Admin1PIN parameter.
Date: Thu,  5 Feb 2026 16:09:26 +0100
Message-ID: <20260205150935.238137-4-okozina@redhat.com>
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

As desribed in ch. 3.1.1.1.1.3 of TCG Storage Opal SSC Feature Set:
Single User Mode document.

To be used later in Reactivate method implementation.

Signed-off-by: Ondrej Kozina <okozina@redhat.com>
---
 block/opal_proto.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/block/opal_proto.h b/block/opal_proto.h
index b9877eacfe91..3ccee5977c10 100644
--- a/block/opal_proto.h
+++ b/block/opal_proto.h
@@ -226,6 +226,7 @@ enum opal_lockingstate {
 enum opal_parameter {
 	OPAL_SUM_SET_LIST = 0x060000,
 	OPAL_SUM_RANGE_POLICY = 0x060001,
+	OPAL_SUM_ADMIN1_PIN = 0x060002,
 };
 
 enum opal_revertlsp {
-- 
2.52.0


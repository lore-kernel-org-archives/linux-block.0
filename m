Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D73119F137
	for <linux-block@vger.kernel.org>; Fri, 30 Jan 2026 16:34:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769790868; cv=none; b=d29C7RdzZHIBeuKEjMxYwAAca45ZRbzJUYDXuMINuV43yJvI2nKcO1/AEV1ruH0VBcMmGrmIe6m/yhfAH3chUXtsR/9zwW+nZUSSTyTzm/PoHSE2bhflwINhBBLNLqYhqTrtpegZxrjJZQMw9yRnbsgYdfybpFu/tLg+1uMAKPs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769790868; c=relaxed/simple;
	bh=9bnCZr/v2q3WKowBg3IoF1ImW7SII5/PwmcL2WXJD/o=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=q121hvLCcRpqqChH8uD0i7I/8FiUYQDZZrw01okw7WOfPZ8TXegvH58LleoXX3zRkk4VuoBPSt0nc5R4f/KHs/kkBuhSgPcufliOBbICTU7HSJP7g8Sng9YOFWhfh+pfa5PM/G921N0AePb/tHJPDliA0n9aMc9p+UzuNClQxRY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=bbRvx8fG; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bbRvx8fG"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1769790866;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=M9kMTxZZn6akxbL5bK7EzAglUZuVa77+RwCgOjtFW3c=;
	b=bbRvx8fGZ6OKB1dqiVgz0SyFOHTIcbV80R3x03WAulFgjcrFOILCtz0iFJ2H1AH/6hi8Ih
	9R+hbuPIOse9WgpiFPzCqS4o7JnJxQy8bccHIYmK96vKF2EAYC+bV8gj1xoJGuhePT5c6M
	Jeueo2IL4s1yFhpatB8f4GzE4IjIM98=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-556-lgBjHo3JP7OFygt9QXH05A-1; Fri,
 30 Jan 2026 11:34:23 -0500
X-MC-Unique: lgBjHo3JP7OFygt9QXH05A-1
X-Mimecast-MFC-AGG-ID: lgBjHo3JP7OFygt9QXH05A_1769790863
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id EDF5518005B2;
	Fri, 30 Jan 2026 16:34:22 +0000 (UTC)
Received: from fedora.brq.redhat.com (unknown [10.43.17.192])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id ADB643001DB7;
	Fri, 30 Jan 2026 16:34:21 +0000 (UTC)
From: Ondrej Kozina <okozina@redhat.com>
To: linux-block@vger.kernel.org
Cc: Ondrej Kozina <okozina@redhat.com>,
	gmazyland@gmail.com,
	jonathan.derrick@linux.dev
Subject: [PATCH] sed-opal: ignore locking ranges array when not enabling SUM.
Date: Fri, 30 Jan 2026 17:33:52 +0100
Message-ID: <20260130163402.571854-1-okozina@redhat.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

The locking ranges count and the array items are always ignored unless
Single User Mode (SUM) is requested in the activate method.

It is useless to enforce limits of unused array in the non-SUM case.

Signed-off-by: Ondrej Kozina <okozina@redhat.com>
---
 block/sed-opal.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/block/sed-opal.c b/block/sed-opal.c
index 37746801479c..a26a94642d84 100644
--- a/block/sed-opal.c
+++ b/block/sed-opal.c
@@ -2942,7 +2942,8 @@ static int opal_activate_lsp(struct opal_dev *dev,
 	};
 	int ret;
 
-	if (!opal_lr_act->num_lrs || opal_lr_act->num_lrs > OPAL_MAX_LRS)
+	if (opal_lr_act->sum &&
+	    (!opal_lr_act->num_lrs || opal_lr_act->num_lrs > OPAL_MAX_LRS))
 		return -EINVAL;
 
 	ret = opal_get_key(dev, &opal_lr_act->key);
-- 
2.52.0


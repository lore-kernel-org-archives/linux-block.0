Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E743C2FCBE5
	for <linux-block@vger.kernel.org>; Fri,  6 Feb 2026 14:18:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770387540; cv=none; b=EMICi7F5Z83CJ3KIs6eBZR78GzKqCxyeBOnHaJTpD+QjPsGXPEr+NtA1yuf2eU0lzoWTkZAD8Y8JI3Lix2+cFYq8EQXP7PZr0fJqCY94NYMPoXirttu1x2JHB/hC49BLVjrWRltCJ2pw41KEy0LQ0/G0RYm+cRx6CSBYfJnr/Gc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770387540; c=relaxed/simple;
	bh=mPFgKXyo1rCk7daYO5lbR8h/FgMa/u3dz5Q1U4TWmWM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Gfoy7EdvoMUDEnHtnjQwZDfJWUDEspSVNrrE7DK1PBAH9qk9CbdQoOYzCtUbiIL2e0fFEJCvLL3MUNkMkMZlOgBDoYfUgQhuC9IJKrgvfr2IzLSGBZZO3NIlF9DKsrNRsvJyDKXXl7krU5T1PwN3OpJdboGafw6brzS5IIJ6ags=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=hNqrAH7m; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hNqrAH7m"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1770387539;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vvCLdv3CYjSTRfjo+P4zktU7VDFZBWXUNhh0gXPp4eI=;
	b=hNqrAH7mRQd70hLRzeqIAtiFU0Fw87r2aFqirDT6NE6ZzMZKvP+A6zuX7hqC7XV+kBEKXS
	dNzwUguqcrNCUkK4wDZGayXik2RWFmTXOSm228RTOV4Kd6fyudybPDh16M9ZFX3Mw7GbF2
	7ha0Vk8pI+a7quErMT9fWfrsuAja06E=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-672-ONj5nZ6cPHyiKuQJVCmcfA-1; Fri,
 06 Feb 2026 09:18:55 -0500
X-MC-Unique: ONj5nZ6cPHyiKuQJVCmcfA-1
X-Mimecast-MFC-AGG-ID: ONj5nZ6cPHyiKuQJVCmcfA_1770387534
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id C04C61956094;
	Fri,  6 Feb 2026 14:18:54 +0000 (UTC)
Received: from fedora.redhat.com (unknown [10.44.34.202])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id DE34218004BB;
	Fri,  6 Feb 2026 14:18:52 +0000 (UTC)
From: Ondrej Kozina <okozina@redhat.com>
To: linux-block@vger.kernel.org
Cc: Ondrej Kozina <okozina@redhat.com>,
	gmazyland@gmail.com,
	jonathan.derrick@linux.dev,
	gjoyce@ibm.com,
	hare@suse.de
Subject: [PATCH v3 8/9] sed-opal: increase column attribute type size to 64 bits.
Date: Fri,  6 Feb 2026 15:18:02 +0100
Message-ID: <20260206141804.278721-9-okozina@redhat.com>
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

Change the column parameter in response_get_column() from u8 to u64
to support the full range of column identifiers.

Signed-off-by: Ondrej Kozina <okozina@redhat.com>
---
 block/sed-opal.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/block/sed-opal.c b/block/sed-opal.c
index edde7fa52ab3..aec5f4708987 100644
--- a/block/sed-opal.c
+++ b/block/sed-opal.c
@@ -1581,7 +1581,7 @@ static int setup_locking_range_start_length(struct opal_dev *dev, void *data)
 
 static int response_get_column(const struct parsed_resp *resp,
 			       int *iter,
-			       u8 column,
+			       u64 column,
 			       u64 *value)
 {
 	const struct opal_resp_tok *tok;
@@ -1599,7 +1599,7 @@ static int response_get_column(const struct parsed_resp *resp,
 	n++;
 
 	if (response_get_u64(resp, n) != column) {
-		pr_debug("Token %d does not match expected column %u.\n",
+		pr_debug("Token %d does not match expected column %llu.\n",
 			 n, column);
 		return OPAL_INVAL_PARAM;
 	}
-- 
2.52.0


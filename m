Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B86B23EA90
	for <linux-block@vger.kernel.org>; Thu,  5 Feb 2026 15:10:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770304210; cv=none; b=OciONzWN8L3phTcLZom6uhdJYMDJwk0yw6K2RAmGsqRPw9xg814+Bytt7tUWF7NLjEUyJw+xpoXxpmbqJlUnMIXkWbewxPwXLND06x9FOI+RbozJIDdqXbju45rFWeDoQMmG9fmwLrgmcTCLr9DuqPI3MIW5dAhmIZZ23mF5Ik8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770304210; c=relaxed/simple;
	bh=mPFgKXyo1rCk7daYO5lbR8h/FgMa/u3dz5Q1U4TWmWM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ce2h1a75hr5YsWOoJLeSNSYo8Cfrwue9htxBBibXrvB494juLaITy8a1PnHjgHemF+zJAhAYkUFX/E/0Oes7mFDW4D+YOj9Z8QdMnZYSNEj140XwuGAO/8QcUNJZqo0IZNplVmKX57GPfHA4KcjaTgQDC7j8vLWYQmqnMdn8oeQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=bOXFkSrr; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bOXFkSrr"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1770304209;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vvCLdv3CYjSTRfjo+P4zktU7VDFZBWXUNhh0gXPp4eI=;
	b=bOXFkSrrlmGlGsXtVlWRBouAX6C4hml+dyQhe3YwTz9jAMnwXec3KY8vxP+ZmuomVNnHy3
	Ktxyti62e4pYLp+POByj/RIJy9MMmJdkgvj/BOnxss+PwFr+dU40XHPEeOQ5ArOkC/UvAq
	AdoVkFoU4j6EFcSrzw2HbVK/0k1n9O0=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-678-La9bCuVoORqiqllALVMO1w-1; Thu,
 05 Feb 2026 10:10:05 -0500
X-MC-Unique: La9bCuVoORqiqllALVMO1w-1
X-Mimecast-MFC-AGG-ID: La9bCuVoORqiqllALVMO1w_1770304204
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id A65221956095;
	Thu,  5 Feb 2026 15:10:04 +0000 (UTC)
Received: from fedora.brq.redhat.com (unknown [10.43.17.192])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 0213718004AD;
	Thu,  5 Feb 2026 15:10:02 +0000 (UTC)
From: Ondrej Kozina <okozina@redhat.com>
To: linux-block@vger.kernel.org
Cc: Ondrej Kozina <okozina@redhat.com>,
	gmazyland@gmail.com,
	jonathan.derrick@linux.dev,
	gjoyce@ibm.com,
	hare@suse.de
Subject: [PATCH v2 8/9] sed-opal: increase column attribute type size to 64 bits.
Date: Thu,  5 Feb 2026 16:09:31 +0100
Message-ID: <20260205150935.238137-9-okozina@redhat.com>
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


Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1715534D3BD
	for <linux-block@vger.kernel.org>; Fri, 30 Jan 2026 16:26:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769790372; cv=none; b=dgoFX0kU/6/uC7MtTlgtvcme621j8US5O3zOzHT0HAwsPUb4ndvTU+QvYgYAi6hlj7UJnFwkg1CaC3QOfvvu21/21puqs+lRCtyhqXiL4R5Cwo0UTzd0KNv8CDEy509Hh3PRM2KUFOJcb4wGprQ0QByF7nZ6+yKuHcgHayy0i0A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769790372; c=relaxed/simple;
	bh=0eBmVu6uXk+RT64vCfYQi/I4IsKylsq3u2puTJ8xNFk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fANK97s6Vi+nClAk2qhCNHhxfAv3VWPkcD5QhTTdEEtNMlUJ/9dP/ojoKtW6LkMy+DdeFEp8qO2qtJRA1hLGUVoFMXebedc4CPSQ2O7QvmO/1WVyfwT9ZWtAhj1fS279sztWlkUEgEnRZGgTV1sWN0O2OBKgGpMdiJTER+fnI/8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=au4nAGMq; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="au4nAGMq"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1769790370;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=PxsDwHxQmNodS5RypyCm4TkyLAl9DQ0bsXSMA8yz3FA=;
	b=au4nAGMqY8xalfhb1q8/PvepszwJvfBJVU5eDounpEnZZUX/MsrkLt/7w0v/lGJeoan+Es
	da1SWFQQDUWQTc0eCpXUiY8IjphX/lT/1LwP/gPPx4ovsey5DS/+qVXptx/DZWsVJdcPkr
	zsaw4CT8lPLpc/SIfgmKL3oos9F6mcI=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-156-tLNageS2PYKrlTALgpMFPg-1; Fri,
 30 Jan 2026 11:26:06 -0500
X-MC-Unique: tLNageS2PYKrlTALgpMFPg-1
X-Mimecast-MFC-AGG-ID: tLNageS2PYKrlTALgpMFPg_1769790365
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 924FB180047F;
	Fri, 30 Jan 2026 16:26:05 +0000 (UTC)
Received: from fedora.brq.redhat.com (unknown [10.43.17.192])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 1DA173000218;
	Fri, 30 Jan 2026 16:26:03 +0000 (UTC)
From: Ondrej Kozina <okozina@redhat.com>
To: linux-block@vger.kernel.org
Cc: Ondrej Kozina <okozina@redhat.com>,
	gmazyland@gmail.com,
	gjoyce@ibm.com,
	jonathan.derrick@linux.dev
Subject: [PATCH 5/6] sed-opal: increase column attribute type size to 64 bits.
Date: Fri, 30 Jan 2026 17:25:11 +0100
Message-ID: <20260130162527.570255-6-okozina@redhat.com>
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

Change the column parameter in response_get_column() from u8 to u64
to support the full range of column identifiers.

Signed-off-by: Ondrej Kozina <okozina@redhat.com>
---
 block/sed-opal.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/block/sed-opal.c b/block/sed-opal.c
index d960450ab3ac..ae1a6f668cbb 100644
--- a/block/sed-opal.c
+++ b/block/sed-opal.c
@@ -1583,7 +1583,7 @@ static int setup_locking_range_start_length(struct opal_dev *dev, void *data)
 
 static int response_get_column(const struct parsed_resp *resp,
 			       int *iter,
-			       u8 column,
+			       u64 column,
 			       u64 *value)
 {
 	const struct opal_resp_tok *tok;
@@ -1601,7 +1601,7 @@ static int response_get_column(const struct parsed_resp *resp,
 	n++;
 
 	if (response_get_u64(resp, n) != column) {
-		pr_debug("Token %d does not match expected column %u.\n",
+		pr_debug("Token %d does not match expected column %llu.\n",
 			 n, column);
 		return OPAL_INVAL_PARAM;
 	}
-- 
2.52.0


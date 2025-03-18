Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37C7120AF7C
	for <linux-block@vger.kernel.org>; Tue, 18 Mar 2025 14:26:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742307983; cv=none; b=XY3d+NAf5JO/cDtFDR4PhBZQAcoN4p/VKiiLFHJGkb5zLhMI6ri9nZOIk/rwTfGp+dJ6oo4F0K8x9Aajgg2fU29cE0YnmY/OOOS6uICq1rIXB1D4ri8W1WCItF4jJXZucGSaxDlLMgBMjhzo3UaBpOa0RHT4o2dB2JAbcsUvbTY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742307983; c=relaxed/simple;
	bh=OosZcgJIKzG1WoaoxuMYkBhQpSNSLo+s8stp5KAGHJQ=;
	h=Date:From:To:cc:Subject:Message-ID:MIME-Version:Content-Type; b=tOwnHs1tfw8hQKqPAQVzCmXk/a9TKK7b+rpjx9l4KY6TdJpApmu7nmdgQGIpNz+7oN3fLERAPqtrci3vb3kM4YTRAg/h6VLvoMqsOMEg7tKwz9rfjE+9wlE8PMdP1UvhrfppGcCWFARVpxqmw7DXV49mGz+nIjUyTfaNTADu/Ts=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=UGJqKU7G; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UGJqKU7G"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1742307980;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
	bh=9DK79vEkj60H4A6R6HETunbW5RhdY45htg39zNnZN74=;
	b=UGJqKU7GGQIsNG3lcaiI2CjTdeUPQbSFUCkPdYwAeJfQnOmnymBCvkx5hOy57Ns//p7/2X
	9CcqW2cWcUDu/Sx+PDISqYUpg3+H9uVVamOAJSEbsTr1x+WwoiqcldVYbIvasoSaogwwsH
	OO4AT+bkCcAUgeJWKdaKuR65nU0vX9M=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-434-Dj22WKlSOWKVl3TP6Ptv-A-1; Tue,
 18 Mar 2025 10:26:19 -0400
X-MC-Unique: Dj22WKlSOWKVl3TP6Ptv-A-1
X-Mimecast-MFC-AGG-ID: Dj22WKlSOWKVl3TP6Ptv-A_1742307978
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 51FBD19560B3;
	Tue, 18 Mar 2025 14:26:17 +0000 (UTC)
Received: from [10.22.82.75] (unknown [10.22.82.75])
	by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 94CFC1955BE1;
	Tue, 18 Mar 2025 14:26:15 +0000 (UTC)
Date: Tue, 18 Mar 2025 15:26:10 +0100 (CET)
From: Mikulas Patocka <mpatocka@redhat.com>
To: Jens Axboe <axboe@kernel.dk>
cc: Alasdair Kergon <agk@redhat.com>, Mike Snitzer <snitzer@kernel.org>, 
    linux-block@vger.kernel.org, dm-devel@lists.linux.dev
Subject: [PATC] block: update queue limits atomically
Message-ID: <ee66a4f2-ecc4-68d2-4594-a0bcba7ffe9c@redhat.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40

The block limits may be read while they are being modified. The statement
"q->limits = *lim" is not really atomic. The compiler may turn it into
memcpy (clang does).

On x86-64, the kernel uses the "rep movsb" instruction for memcpy - it is
optimized on modern CPUs, but it is not atomic, it may be interrupted at
any byte boundary - and if it is interrupted, the readers may read
garbage.

On sparc64, there's an instruction that zeroes a cache line without
reading it from memory. The kernel memcpy implementation uses it (see
b3a04ed507bf) to avoid loading the destination buffer from memory. The
problem is that if we copy a block of data to q->limits and someone reads
it at the same time, the reader may read zeros.

This commit changes it to use WRITE_ONCE, so that individual words are
updated atomically.

Signed-off-by: Mikulas Patocka <mpatocka@redhat.com>
Cc: stable@vger.kernel.org

---
 block/blk-settings.c |   10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

Index: linux-2.6/block/blk-settings.c
===================================================================
--- linux-2.6.orig/block/blk-settings.c
+++ linux-2.6/block/blk-settings.c
@@ -433,6 +433,7 @@ int queue_limits_commit_update(struct re
 		struct queue_limits *lim)
 {
 	int error;
+	size_t i;
 
 	error = blk_validate_limits(lim);
 	if (error)
@@ -446,7 +447,14 @@ int queue_limits_commit_update(struct re
 	}
 #endif
 
-	q->limits = *lim;
+	/*
+	 * Note that direct assignment like "q->limits = *lim" is not atomic
+	 * (the compiler can generate things like "rep movsb" for it),
+	 * so we use WRITE_ONCE.
+	 */
+	for (i = 0; i < sizeof(struct queue_limits) / sizeof(long); i++)
+		WRITE_ONCE(*((long *)&q->limits + i), *((long *)lim + i));
+
 	if (q->disk)
 		blk_apply_bdi_limits(q->disk->bdi, lim);
 out_unlock:


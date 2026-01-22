Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D92102D7DC1
	for <linux-block@vger.kernel.org>; Thu, 22 Jan 2026 19:31:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769110318; cv=none; b=luwn7lYKPocICaS1ZVsZb1st+/ajz8m6kj4OwXLhsCfD6C/UZtzyFQkLqsWWqsNex4Lh2oeO0JocDhwae/JHAqMPkfLkb8Okbe2i2GfcstipnKDGcqV4mzptpc60uHDng+QnvBfLT1NIpUcqcVfOKjgOk9s7IEIixOfpAH4VLjc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769110318; c=relaxed/simple;
	bh=7TjAb712XfYQZXI4jMUAQMYZAytoCsluBCOqHhgj+4s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pbGMdTzaBTAA+ilHoLxMkPQiS+Cm5eAKLgDmZ39rcy5VXF4DWDtI1L06wyAiqJhLzZy5UknXKiewolENhoShrB2v5iDeMAprYW6O4QHApjxAuTKstW3OGqaALhpdHJRe6uq/keI51oJrW5aZXzh3hhpzovxudewDpms3hVbv/SQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=B5fFy6O9; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="B5fFy6O9"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1769110303;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ZsDVGsHFtn5FS0qVA4Bm82Ye5ky7sxbJFigQ51xjAIU=;
	b=B5fFy6O9C+vjoqXfaa8/KVyzGeDGBSUTJLsEvGk0cS2vqFbAKYpoy9vRYVSdXSVVfsK30K
	HRBG4IyMEKy9KygE265nuTYwuvwVaE8YISrlsp2toMKFDA5HLPzuDr5dIetbP3OmPgfUOS
	iZvvNZE/1PgXR8zjUbNNGxpFOQIv5ms=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-19-K5B0JpQoMnyuJdozmRlOUg-1; Thu,
 22 Jan 2026 14:31:42 -0500
X-MC-Unique: K5B0JpQoMnyuJdozmRlOUg-1
X-Mimecast-MFC-AGG-ID: K5B0JpQoMnyuJdozmRlOUg_1769110301
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id B13481800372;
	Thu, 22 Jan 2026 19:31:41 +0000 (UTC)
Received: from host.redhat.com (unknown [10.22.80.189])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 17A091956095;
	Thu, 22 Jan 2026 19:31:40 +0000 (UTC)
From: John Pittman <jpittman@redhat.com>
To: shinichiro.kawasaki@wdc.com
Cc: linux-block@vger.kernel.org,
	John Pittman <jpittman@redhat.com>
Subject: [PATCH blktests v2 2/2] block/042: check sysfs values prior to running
Date: Thu, 22 Jan 2026 14:31:33 -0500
Message-ID: <20260122193133.3087906-3-jpittman@redhat.com>
In-Reply-To: <20260122193133.3087906-1-jpittman@redhat.com>
References: <20260122193133.3087906-1-jpittman@redhat.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

In testing some older kernels recently, block/042 has failed due
to dma_alignment and virt_boundary_mask not being present.

   Running block/042
   +cat: '.../queue/dma_alignment': No such file or directory
   +cat: '.../queue/virt_boundary_mask': No such file or directory
   +dio-offsets: test_dma_aligned: failed to write buf: Invalid argument

To ensure we skip if this is the case, check all sysfs values prior
to run. Also, change the spaces to tabs before _require_test_dev_sysfs
for consistency with the rest of blktests.

Signed-off-by: John Pittman <jpittman@redhat.com>
---
 tests/block/042 | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/tests/block/042 b/tests/block/042
index 28ac4a2..8a31149 100644
--- a/tests/block/042
+++ b/tests/block/042
@@ -11,7 +11,9 @@ DESCRIPTION="Test unusual direct-io offsets"
 QUICK=1
 
 device_requires() {
-        _require_test_dev_sysfs
+	_require_test_dev_sysfs "queue/max_segments" "queue/dma_alignment" \
+		"queue/virt_boundary_mask" "queue/logical_block_size" \
+		"queue/max_sectors_kb"
 }
 
 test_device() {
-- 
2.51.1


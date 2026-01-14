Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF76430FC36
	for <linux-block@vger.kernel.org>; Wed, 14 Jan 2026 21:08:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768424903; cv=none; b=RVRud1Cql6+DNhBw1PDpFwi50h8LTqo7dYAj09vWYybhL9d9PGTBAGC7OMZdL2rgaNaiZmckyF+e43GDeBRKvmvDpD08VcoYIwDYMRfLoU+6WlvAP7DlV3fgeEQupuNt4qJPUzwYLZ70CGXZ8K3LM8DD9/rHqZ+0q3/rigeCAcc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768424903; c=relaxed/simple;
	bh=/8F5kV9yOOzbNrHSEOXS7hlwe/f6ztDhpsNvVRbMfK4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jvIYC/CCaseAImhsRkA7ymacog8nBWz5IPHWAaHmukuSRjjsXGJ4IVbBcTHYAjzhehUi7UyslyfakwzpJbybIQrm3weyqJ7+9CgCMTjwFC6L53Y10lJ9nAw58wggK05VRVMsRXVwDlk6iYJcrI14OpwCWJDH+vai5AhKXdYqJk0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=GC4qbrMI; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GC4qbrMI"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1768424901;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=XENWcPOcV7G+5uU0knwxRdaklm3D9mxu4ZDz+RrVEN4=;
	b=GC4qbrMIkafJOVcl0Y8ryxorYtICVPwG9T3SnStpm+WpsfJkBpVShhM/17lb3+rhUmOQQw
	vwqRrDn1tYqjwDVcC6soTCHXamxdD8hOTNmduUhP3prqXVIi3eevt4XLLrGDp6n0Y9ODR8
	Fq3FA8vkYb6rOzsPBsD/Uaov4kekXV8=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-194-ERgGJrz5MySYg6PJJri8vA-1; Wed,
 14 Jan 2026 16:08:19 -0500
X-MC-Unique: ERgGJrz5MySYg6PJJri8vA-1
X-Mimecast-MFC-AGG-ID: ERgGJrz5MySYg6PJJri8vA_1768424899
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id E49DB195605B;
	Wed, 14 Jan 2026 21:08:18 +0000 (UTC)
Received: from host.redhat.com (unknown [10.22.66.14])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 4CFA730002D8;
	Wed, 14 Jan 2026 21:08:18 +0000 (UTC)
From: John Pittman <jpittman@redhat.com>
To: shinichiro.kawasaki@wdc.com
Cc: linux-block@vger.kernel.org,
	John Pittman <jpittman@redhat.com>
Subject: [PATCH blktests 2/2] block/042: check sysfs values prior to running
Date: Wed, 14 Jan 2026 16:08:09 -0500
Message-ID: <20260114210809.2195262-3-jpittman@redhat.com>
In-Reply-To: <20260114210809.2195262-1-jpittman@redhat.com>
References: <20260114210809.2195262-1-jpittman@redhat.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

In testing some older kernels recently, block/042 has failed due
to dma_alignment and virt_boundary_mask not being present.

   Running block/042
   +cat: '.../queue/dma_alignment': No such file or directory
   +cat: '.../queue/virt_boundary_mask': No such file or directory
   +dio-offsets: test_dma_aligned: failed to write buf: Invalid argument

To ensure we skip if this is the case, check all sysfs values prior
to run.

Signed-off-by: John Pittman <jpittman@redhat.com>
---
 tests/block/042 | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/tests/block/042 b/tests/block/042
index 28ac4a2..bbf13fd 100644
--- a/tests/block/042
+++ b/tests/block/042
@@ -11,7 +11,9 @@ DESCRIPTION="Test unusual direct-io offsets"
 QUICK=1
 
 device_requires() {
-        _require_test_dev_sysfs
+        _require_test_dev_sysfs "" "queue/max_segments" "queue/dma_alignment" \
+		"queue/virt_boundary_mask" "queue/logical_block_size" \
+		"queue/max_sectors_kb"
 }
 
 test_device() {
-- 
2.51.1


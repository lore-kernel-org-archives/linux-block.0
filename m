Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1211B192B75
	for <linux-block@vger.kernel.org>; Wed, 12 Nov 2025 09:38:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762940338; cv=none; b=AkY1rpQyjE4o7UKDtiHJSWvPZyBMySKRfbVfVMaR2Bg1j5/QcY/itqPTSg4pj85/bpuN2+csQpo0kxPUC13CCojiEt+SxAPQl5RvWQIPKPNs8HqxRf23g2+ZsEYTmGAnoQhIyMfkzm1YJCsiAiyh5YJ9CPuB8Rx+eALuj4xQS8w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762940338; c=relaxed/simple;
	bh=wc7uVEPgvumn3qUInNW2qzr8pXqU8VcwVDLxV8Jgchk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FBqk1AxBOTZNTITyzHoI4HcRlPiTGbrkpEYQVvIgqpd31NlUEbGF87O0TVaSsTspYWmzwgXz7DBdBrnNxdpjX4tI6JwSHKasYl0NuZI9nYRTT5FfVqxXoEZgvQS/R4ZgfWHSSuzcr65Bv06+spo7KBIy/UqnCIWnmYTOJY27l2s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=PdfcKg/Y; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PdfcKg/Y"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1762940335;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=blkQAeJEHaRweMCt5CZgvoecL4DXqcAjPitWRFOfzFE=;
	b=PdfcKg/YCG9mN5QbtpLMX9h/SNvOiYVGOfMNwOEFehApLYLs6uP/Towv4o/Iy6hlakOQz2
	QWlAdjsNWSTelRPLH5VWmBEEXtcnQ/59h4EkqRs2vD4x7K9zcgKXJqLTjmGHdKUgH/D/HJ
	u71KXtgxnxwt7muEhFwXp9Qj/SPYnK0=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-252-tRI3BllCO_u0kvxXBbAPFA-1; Wed,
 12 Nov 2025 04:38:53 -0500
X-MC-Unique: tRI3BllCO_u0kvxXBbAPFA-1
X-Mimecast-MFC-AGG-ID: tRI3BllCO_u0kvxXBbAPFA_1762940332
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 674911800343;
	Wed, 12 Nov 2025 09:38:52 +0000 (UTC)
Received: from localhost (unknown [10.72.116.179])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 4E68930044E0;
	Wed, 12 Nov 2025 09:38:50 +0000 (UTC)
From: Ming Lei <ming.lei@redhat.com>
To: Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org
Cc: Caleb Sander Mateos <csander@purestorage.com>,
	Uday Shankar <ushankar@purestorage.com>,
	Ming Lei <ming.lei@redhat.com>
Subject: [PATCH V3 05/27] ublk: pass const pointer to ublk_queue_is_zoned()
Date: Wed, 12 Nov 2025 17:37:43 +0800
Message-ID: <20251112093808.2134129-6-ming.lei@redhat.com>
In-Reply-To: <20251112093808.2134129-1-ming.lei@redhat.com>
References: <20251112093808.2134129-1-ming.lei@redhat.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

Pass const pointer to ublk_queue_is_zoned() because it is readonly.

Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 drivers/block/ublk_drv.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/block/ublk_drv.c b/drivers/block/ublk_drv.c
index b36cd55eceb0..5e83c1b2a69e 100644
--- a/drivers/block/ublk_drv.c
+++ b/drivers/block/ublk_drv.c
@@ -265,7 +265,7 @@ static inline bool ublk_dev_is_zoned(const struct ublk_device *ub)
 	return ub->dev_info.flags & UBLK_F_ZONED;
 }
 
-static inline bool ublk_queue_is_zoned(struct ublk_queue *ubq)
+static inline bool ublk_queue_is_zoned(const struct ublk_queue *ubq)
 {
 	return ubq->flags & UBLK_F_ZONED;
 }
-- 
2.47.0


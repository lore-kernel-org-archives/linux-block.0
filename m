Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9AD12FD1DA
	for <linux-block@vger.kernel.org>; Thu, 23 Oct 2025 15:33:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761233605; cv=none; b=gSaJS8E+GyY0Of/n3H4ldFhzVmlN6Q4ml6To/sxb3Ry+p3b2YiAz2CH/X9DKq9NpkanWv+e/ir48FfGBUgmoubqegSRyTWeBzhZu00z4AMEnlTmOlXiehG2xfqVhw9dA35Go/O2FarCp8NiGXNM4W53GLIzZYEoMlIKujTdBpy4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761233605; c=relaxed/simple;
	bh=U1ADO+Ik0MdlxPiaLYscx/EFYxAhfN4ZLHMzRK7ljtk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=txx20UXTOu1crXMdtLnZitx2OypwPX9w1fV97xEbexx0l+0n1fw+Mwf+6thabOBpnHWYFao4AtGKic9m4mK1c7Pwd13LdjH3nHJffa9N8ckF7qUYlYXHTZZxaH+Urqb9QuQcCxRO/5FfEA+FOOpC5SNYRlA/uIHRE3WuLd2rDh4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=DHJQiMeJ; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DHJQiMeJ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1761233603;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=eHLXJv8Alfnioo0EleQIIIK56XpY34JDFpukrtf+vIY=;
	b=DHJQiMeJq11YWJIrYoAu+LGb09qUhEfy9+uCo7n0A+yMo5lnn6bMTdpeyMa0sHPxIaQw9Z
	SMw6QbahiUA6ZPrywivk8PANiZyeTF7ZFjA6tsoW98f8KURWeLmjXqF2F7Z6Z8zyULqGpH
	M0s8Qqsq/+B4UTl90KLDeZ/SuXxKrk4=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-670-zJekiedIOA2rUJDFJDQkTw-1; Thu,
 23 Oct 2025 11:33:19 -0400
X-MC-Unique: zJekiedIOA2rUJDFJDQkTw-1
X-Mimecast-MFC-AGG-ID: zJekiedIOA2rUJDFJDQkTw_1761233598
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id D6914195609E;
	Thu, 23 Oct 2025 15:33:16 +0000 (UTC)
Received: from localhost (unknown [10.72.120.30])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id D9D51180057E;
	Thu, 23 Oct 2025 15:33:15 +0000 (UTC)
From: Ming Lei <ming.lei@redhat.com>
To: Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org
Cc: Uday Shankar <ushankar@purestorage.com>,
	Caleb Sander Mateos <csander@purestorage.com>,
	Ming Lei <ming.lei@redhat.com>
Subject: [PATCH V2 07/25] ublk: pass const pointer to ublk_queue_is_zoned()
Date: Thu, 23 Oct 2025 23:32:12 +0800
Message-ID: <20251023153234.2548062-8-ming.lei@redhat.com>
In-Reply-To: <20251023153234.2548062-1-ming.lei@redhat.com>
References: <20251023153234.2548062-1-ming.lei@redhat.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

Pass const pointer to ublk_queue_is_zoned() because it is readonly.

Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 drivers/block/ublk_drv.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/block/ublk_drv.c b/drivers/block/ublk_drv.c
index 7f02d9233a62..09f6cc49b627 100644
--- a/drivers/block/ublk_drv.c
+++ b/drivers/block/ublk_drv.c
@@ -271,7 +271,7 @@ static inline bool ublk_dev_is_zoned(const struct ublk_device *ub)
 	return ub->dev_info.flags & UBLK_F_ZONED;
 }
 
-static inline bool ublk_queue_is_zoned(struct ublk_queue *ubq)
+static inline bool ublk_queue_is_zoned(const struct ublk_queue *ubq)
 {
 	return ubq->flags & UBLK_F_ZONED;
 }
-- 
2.47.0


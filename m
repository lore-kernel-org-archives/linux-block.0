Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C70E283682
	for <linux-block@vger.kernel.org>; Fri, 21 Nov 2025 01:59:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763690373; cv=none; b=qB13y4Mz75ursCBpkH6XXLkUE1varcV0vAaEgXX9T3EwHERbdnNc7fuvclbjiP2Maf46r0BBo7pLvMxGQa/1H83RYZ//BJ8qJ+ABCEeEi9vD/sOfq1Hz84yCWiclckwMn6t0Z9rPxMt/RoB49X/tFGEikc5oWfMYWe+JAs7ZTVY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763690373; c=relaxed/simple;
	bh=Nr4pSoQwCzbbKfxs/8KKTOumo6FQ5gMWaQtD5tU/aJk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ES8dcSSoMxclNreZpQi4FQtUEH+NhK02BoilibB/2/p6QlIZJbCa0XytJuVcVI4qTNygWavZrRHBlemEdjqELaqtKolIgKAkox4+vrGptzxZweLqy9gjnaufB8JKEaw3SQs5U06Cm7BIXHrJUS9+sdybWXzDTtgQRSr+8o57gLI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=f4/Dc/q+; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="f4/Dc/q+"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1763690371;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=gtLgc3ofh2FJNoVGQhSZzQnpnokBG3N60WsQ1kIOUHs=;
	b=f4/Dc/q+mgfQLHlSqhr6AdpiiSpre9Zs9f2VHhc9e+N/UHVDmEiG9ewUQrxNoOKcJoXlZN
	e95PnklVi4palxZHnmVOG+kMnOTJz774MwXk7ODcWmDS7GvJOQfJB0mWckgSFzgyJRIC5G
	ru/2sdz09GdI8CyAXJBOCp0qzfsvW5I=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-586-vBWxKaVsM_K2ZUL1wRs-OA-1; Thu,
 20 Nov 2025 20:59:27 -0500
X-MC-Unique: vBWxKaVsM_K2ZUL1wRs-OA-1
X-Mimecast-MFC-AGG-ID: vBWxKaVsM_K2ZUL1wRs-OA_1763690365
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 8455F19560AE;
	Fri, 21 Nov 2025 01:59:25 +0000 (UTC)
Received: from localhost (unknown [10.72.116.211])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 0BEDD1940E82;
	Fri, 21 Nov 2025 01:59:23 +0000 (UTC)
From: Ming Lei <ming.lei@redhat.com>
To: Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org
Cc: Caleb Sander Mateos <csander@purestorage.com>,
	Uday Shankar <ushankar@purestorage.com>,
	Stefani Seibold <stefani@seibold.net>,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-kernel@vger.kernel.org,
	Ming Lei <ming.lei@redhat.com>
Subject: [PATCH V4 05/27] ublk: pass const pointer to ublk_queue_is_zoned()
Date: Fri, 21 Nov 2025 09:58:27 +0800
Message-ID: <20251121015851.3672073-6-ming.lei@redhat.com>
In-Reply-To: <20251121015851.3672073-1-ming.lei@redhat.com>
References: <20251121015851.3672073-1-ming.lei@redhat.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

Pass const pointer to ublk_queue_is_zoned() because it is readonly.

Reviewed-by: Caleb Sander Mateos <csander@purestorage.com>
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


Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F272B2147EB
	for <linux-block@vger.kernel.org>; Tue, 29 Apr 2025 02:30:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745893816; cv=none; b=iKyxxSUg64xNaOqeOhiLLeeiBdg7CI47mzfajCloWkaFgnUr5WCVmFWsTZ6VI0VFMRbDCNaAwCUqL6y7ICRPPX+nLjlC2WZalxDoXmpQFz/cy4fzGMSfl2A54J0Vmks6CFKyI3ivx5oSYnJiVIqOMsH8Dqzv7jve/0iq8CqVLMM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745893816; c=relaxed/simple;
	bh=lWkgMxc1zosAnB9QOKhz2RulLILw3ULoMZVId57HWrQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dUMeYmBZF3w2NraU2bqzhU2Cl4prOeb059kfKr310kpCZMFKvphAQmUJfGCt/Soec7qEhKJ5omv/CooAitltiJ6X9XM9a8UCwZTY9VjuNk3CAQv4czPGWOVOdFKfjSKGTw440E/C7l8qJ2XkC28OOz1YrcJ8ndxQNfRpj7aGcvE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=DdVZ7TYI; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DdVZ7TYI"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1745893813;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=otv72E7kb538clJy+u0MrT/qtl6HQd6KboFOKcH7OMU=;
	b=DdVZ7TYIC9RHWSonDh5CGaL7FKBAS4VjqcdDsSCopDHZ95gsefBd7EGjj+IoNFNY8EmeTi
	bqQWFy9xAx9zeF+8siVYIB2FGFTSdk93AFxPnlcW7IJfQn9prtRA4ju0m2VdKBryzDRHb5
	zSCsrMfnYQBE6ZxYHVU3yEGZNOU7g2o=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-183-tyUUgaUzO2-XLIYhF2CaQA-1; Mon,
 28 Apr 2025 22:30:08 -0400
X-MC-Unique: tyUUgaUzO2-XLIYhF2CaQA-1
X-Mimecast-MFC-AGG-ID: tyUUgaUzO2-XLIYhF2CaQA_1745893806
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 251071800446;
	Tue, 29 Apr 2025 02:30:06 +0000 (UTC)
Received: from localhost (unknown [10.72.116.57])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 1A3B51956096;
	Tue, 29 Apr 2025 02:30:04 +0000 (UTC)
From: Ming Lei <ming.lei@redhat.com>
To: Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org
Cc: Uday Shankar <ushankar@purestorage.com>,
	Caleb Sander Mateos <csander@purestorage.com>,
	Keith Busch <kbusch@kernel.org>,
	Ming Lei <ming.lei@redhat.com>
Subject: [PATCH v6.15 v2 4/4] ublk: remove the check of ublk_need_req_ref() from __ublk_check_and_get_req
Date: Tue, 29 Apr 2025 10:29:39 +0800
Message-ID: <20250429022941.1718671-5-ming.lei@redhat.com>
In-Reply-To: <20250429022941.1718671-1-ming.lei@redhat.com>
References: <20250429022941.1718671-1-ming.lei@redhat.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

__ublk_check_and_get_req() is only called from ublk_check_and_get_req()
and ublk_register_io_buf(), the same check has been covered in the two
calling sites.

So remove the check from __ublk_check_and_get_req().

Suggested-by: Caleb Sander Mateos <csander@purestorage.com>
Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 drivers/block/ublk_drv.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/block/ublk_drv.c b/drivers/block/ublk_drv.c
index c624d8f653ae..f9032076bc06 100644
--- a/drivers/block/ublk_drv.c
+++ b/drivers/block/ublk_drv.c
@@ -2148,9 +2148,6 @@ static inline struct request *__ublk_check_and_get_req(struct ublk_device *ub,
 {
 	struct request *req;
 
-	if (!ublk_need_req_ref(ubq))
-		return NULL;
-
 	req = blk_mq_tag_to_rq(ub->tag_set.tags[ubq->q_id], tag);
 	if (!req)
 		return NULL;
-- 
2.47.0


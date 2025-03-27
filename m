Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 987491FF7D1
	for <linux-block@vger.kernel.org>; Thu, 27 Mar 2025 09:51:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743069112; cv=none; b=dPtENvZGeYJy4w4ZEiIoCDFiA1KTE2h6gclWmGRqTyba82wAJEj0GlPXc8flHY6BkXWR6oQUxluvS09/7OgPBcOvXjIVKWbv47LilE6bRhKYyZc5MEUON2Smk2drL+QbFAZaJqBPLgZfHnZF+UjTDXOfamCC94dHYok++ujGTAE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743069112; c=relaxed/simple;
	bh=vM5RCPqqars1JiVo3VTMCH+sEX8ClfU7cQlmM8rT2Nw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Hq82X09u7bfD7pwy1z1zLmgEmYswxkUA84YSbr4EwaNWnUEfLZcyG68vUvDWgt9W8NI7WdnbdTa6qmsqgjQryAF7aRXpwZY+Bq984sc9kjFm9ZBe2g/+f7cKffWSNzl7KN+bvJmQVe4m1+67FAAV3oswv/0B1Oo/WghzZcQmPnU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=NCdCyL3i; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NCdCyL3i"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1743069109;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=BrlM3R/3kpZES33UArusZEl/45PNa3KkxjrEiiO3lSI=;
	b=NCdCyL3idTnAx6ud9DUuW/UogbuG9+mBv3QrFGZ4gNqoQJRxL4g5SbDRS+aKuN4XdLJ+fa
	cmQ9D6TYsKhkZqE/QYuq5eRmEXHPGBQmtDLE6ck810bY1ytBN2C/pGBxvu1Ej4hpJchpH1
	9ErMGCiAHB5tSOhVZa93LAJD6P1z0V4=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-83-1SPJWKUePp6vNGflltc4VA-1; Thu,
 27 Mar 2025 05:51:43 -0400
X-MC-Unique: 1SPJWKUePp6vNGflltc4VA-1
X-Mimecast-MFC-AGG-ID: 1SPJWKUePp6vNGflltc4VA_1743069102
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 3C6481800361;
	Thu, 27 Mar 2025 09:51:42 +0000 (UTC)
Received: from localhost (unknown [10.72.120.3])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id E73B11801747;
	Thu, 27 Mar 2025 09:51:40 +0000 (UTC)
From: Ming Lei <ming.lei@redhat.com>
To: Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org
Cc: Caleb Sander Mateos <csander@purestorage.com>,
	Keith Busch <kbusch@kernel.org>,
	Uday Shankar <ushankar@purestorage.com>,
	Ming Lei <ming.lei@redhat.com>
Subject: [PATCH V2 02/11] ublk: comment on ubq->canceling handling in ublk_queue_rq()
Date: Thu, 27 Mar 2025 17:51:11 +0800
Message-ID: <20250327095123.179113-3-ming.lei@redhat.com>
In-Reply-To: <20250327095123.179113-1-ming.lei@redhat.com>
References: <20250327095123.179113-1-ming.lei@redhat.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

In ublk_queue_rq(), ubq->canceling has to be handled after ->fail_io and
->force_abort are dealt with, otherwise the request may not be failed
when deleting disk.

Add comment on this usage.

Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 drivers/block/ublk_drv.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/block/ublk_drv.c b/drivers/block/ublk_drv.c
index fbcb7c2ff851..5b0c885dc38f 100644
--- a/drivers/block/ublk_drv.c
+++ b/drivers/block/ublk_drv.c
@@ -1310,6 +1310,11 @@ static blk_status_t ublk_queue_rq(struct blk_mq_hw_ctx *hctx,
 	if (ublk_nosrv_should_queue_io(ubq) && unlikely(ubq->force_abort))
 		return BLK_STS_IOERR;
 
+	/*
+	 * ->canceling has to be handled after ->force_abort and ->fail_io
+	 * is dealt with, otherwise this request may not be failed in case
+	 * of recovery, and cause hang when deleting disk
+	 */
 	if (unlikely(ubq->canceling)) {
 		__ublk_abort_rq(ubq, rq);
 		return BLK_STS_OK;
-- 
2.47.0


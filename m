Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF1163242B1
	for <linux-block@vger.kernel.org>; Fri, 16 Jan 2026 14:19:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768573168; cv=none; b=LbWAM5ROc9o366oaJT0ldP4YQ5VYJthqgBJ7NfIMRr2R/cQe2eueyfDwnI80cg0DHSC/zb53ZYeSx2nTXfFMsNQb5gQwBwxHmhscEJ1WTqnSNRkZC51GBSx7TVvo1Yi4MYVXk0ptrwLdPJliFChsdrlddoFlf5IlNp0BnOv9ZOQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768573168; c=relaxed/simple;
	bh=zd75MSVm8tOnAP1n/soU+omONHqmNOWGwlsUiJUX+j0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MbjkjUH5jWRFyq/INyycumCRU0CIEGEQh9ngYOfxSvGOdXKhvAWcaanMM81XYM29DpaEp+mS4zjRNfDZot3dUVLRkj/qF/zKUSU/zXL++AqZjbxD+T6o4BFt+SPvIZWa6s4AB0dwIcFpL05jmohqsd/fS0TuuOItcyWEmYD0f5Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=gHhqwZiR; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gHhqwZiR"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1768573163;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=i0U7gidcvFDu52TWSUbwsFBKam5IDilT0qddIG6CIyA=;
	b=gHhqwZiR4hln0Jtq7mw8uhSMNIk3tR2xK2b/mdCwDvxKCLnshyu2FAfYpv2Ml/cL8Fo1W9
	EsrzeIyehDks+XhiGdYf9cow8C41Egj/VVrz5wKmkvwlvoHFy+6dJUr1G1PSNQnIjK8mYb
	bWtY2vdeGzhB5TcTZW8u1VI8zFSAr0M=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-76-H5BR_VdnONeOJ64iBtFq8g-1; Fri,
 16 Jan 2026 09:19:20 -0500
X-MC-Unique: H5BR_VdnONeOJ64iBtFq8g-1
X-Mimecast-MFC-AGG-ID: H5BR_VdnONeOJ64iBtFq8g_1768573159
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 699C618003FC;
	Fri, 16 Jan 2026 14:19:19 +0000 (UTC)
Received: from localhost (unknown [10.72.116.198])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 5C9331800665;
	Fri, 16 Jan 2026 14:19:17 +0000 (UTC)
From: Ming Lei <ming.lei@redhat.com>
To: Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org
Cc: Caleb Sander Mateos <csander@purestorage.com>,
	Uday Shankar <ushankar@purestorage.com>,
	Ming Lei <ming.lei@redhat.com>
Subject: [PATCH V6 02/24] ublk: prepare for not tracking task context for command batch
Date: Fri, 16 Jan 2026 22:18:35 +0800
Message-ID: <20260116141859.719929-3-ming.lei@redhat.com>
In-Reply-To: <20260116141859.719929-1-ming.lei@redhat.com>
References: <20260116141859.719929-1-ming.lei@redhat.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

batch io is designed to be independent of task context, and we will not
track task context for batch io feature.

Reviewed-by: Caleb Sander Mateos <csander@purestorage.com>
Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 drivers/block/ublk_drv.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/block/ublk_drv.c b/drivers/block/ublk_drv.c
index dfb5b1177cfd..8a0155f5e8f2 100644
--- a/drivers/block/ublk_drv.c
+++ b/drivers/block/ublk_drv.c
@@ -2423,7 +2423,10 @@ static int __ublk_fetch(struct io_uring_cmd *cmd, struct ublk_device *ub,
 
 	ublk_fill_io_cmd(io, cmd);
 
-	WRITE_ONCE(io->task, get_task_struct(current));
+	if (ublk_dev_support_batch_io(ub))
+		WRITE_ONCE(io->task, NULL);
+	else
+		WRITE_ONCE(io->task, get_task_struct(current));
 	ublk_mark_io_ready(ub);
 
 	return 0;
-- 
2.47.0


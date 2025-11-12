Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 143462DC76C
	for <linux-block@vger.kernel.org>; Wed, 12 Nov 2025 09:39:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762940351; cv=none; b=HgfZCi+7zTh3G0PQxoMAEczKIHdqsRJ4hoW8gvj90Ubeyxeg6WGxgHeuoL7yIvTUZ1uhNPr5HVF/dVJOx2OFFqonK/rhFuxwr1Jjs1nfiQeXQaeOZmiPmKLMHBsIB2dPduB+l9UlX4c5dRv4qjUWayWXezjWp4JS8CGXhVZaVF8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762940351; c=relaxed/simple;
	bh=w58HUTy20BPc2SqGoWaQo20oL1iM1E0M1wZepEGh6WM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qud1eGguSqxJUmZ3aXRaAfcW3e8R/ou6Uk4jeVoUKfaVk3ZuRnv33IYW5eoYC3iqI2blM77ky+dJkPjg3TBcta/ODdlzwU+vppGs/MRTsLTbZPfDaRAd0/8P1PJfttm/zEgEo7vOViSXbBrKmAQ+Wuy4hF8Val+/QiuUXqPVGhA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=BTnv6cyT; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BTnv6cyT"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1762940348;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=CjdHdHYyPUPSz1VH38ACq9mHnMe/y5q0w7PSPR9G9jg=;
	b=BTnv6cyTd4L77pObeHdb/lKi5SYCmSxNdf/hGS/6y7tjDOhegJQ50pXGaQosY5BEXgEDBT
	Tk582jdBvxHo/GLcGPHkBblcSjWWuy/E05DZ2OEtlz2HuCNvZnMjLoKkT3y92JV1MIu0W8
	uALafx01wxAjrDy5tV2yFVSO8W0BOw8=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-496-TPha5DipNJu7a2QMGok3zg-1; Wed,
 12 Nov 2025 04:39:05 -0500
X-MC-Unique: TPha5DipNJu7a2QMGok3zg-1
X-Mimecast-MFC-AGG-ID: TPha5DipNJu7a2QMGok3zg_1762940344
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 217E918011EF;
	Wed, 12 Nov 2025 09:39:04 +0000 (UTC)
Received: from localhost (unknown [10.72.116.179])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 2637819560A2;
	Wed, 12 Nov 2025 09:39:02 +0000 (UTC)
From: Ming Lei <ming.lei@redhat.com>
To: Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org
Cc: Caleb Sander Mateos <csander@purestorage.com>,
	Uday Shankar <ushankar@purestorage.com>,
	Ming Lei <ming.lei@redhat.com>
Subject: [PATCH V3 08/27] ublk: prepare for not tracking task context for command batch
Date: Wed, 12 Nov 2025 17:37:46 +0800
Message-ID: <20251112093808.2134129-9-ming.lei@redhat.com>
In-Reply-To: <20251112093808.2134129-1-ming.lei@redhat.com>
References: <20251112093808.2134129-1-ming.lei@redhat.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

batch io is designed to be independent of task context, and we will not
track task context for batch io feature.

So warn on non-batch-io code paths.

Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 drivers/block/ublk_drv.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/block/ublk_drv.c b/drivers/block/ublk_drv.c
index 1fcca52591c3..c62b2f2057fe 100644
--- a/drivers/block/ublk_drv.c
+++ b/drivers/block/ublk_drv.c
@@ -2254,7 +2254,10 @@ static int __ublk_fetch(struct io_uring_cmd *cmd, struct ublk_device *ub,
 
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


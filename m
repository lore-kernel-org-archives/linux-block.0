Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FCA43148DA
	for <linux-block@vger.kernel.org>; Thu, 23 Oct 2025 15:33:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761233599; cv=none; b=JCzwxpz3oWY508e6Gt/TjKs+nc+xC+1f1CYPFR8XDYlJs4bNCf45QVpPEkQQuLMrJdf/4QZKBFc+uGDHnuajpm+hObke8vW8Fl8JVf50H1K5qOYCmj4oqt4tlmmIyfC45CrbVcuL2VnegjotIM8Csg2JuB0LXWoOzJy2NDwbZD4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761233599; c=relaxed/simple;
	bh=Duc05TDZVZ/VJGHf202ZPetl5dy6+rQ3GjK2FYFxUYM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CxSLLULWRFVtCx9XCaVHtmnWt2550D/pCXdHgJXaePegYXDmVd/oa+sxBa6/lagHJPh2Kd4hl0Qqc1P/hdTqInCknPn+FZfa4ZKfn4IwXqr+8aC6qEmAdWo29b8LtUyMeM19+H6Z29+s/ySFGnNAhYZ3lSle4OKW4jMYs2JxNX4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=P6MLTywh; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="P6MLTywh"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1761233597;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=kHmVmQclxSCK2cx/4jGOQcFPnpRNyQPkjMJGv7UX/Zg=;
	b=P6MLTywh3+cmbFtVzYTveCG7nwczKl9o5Hf9mnfqbmaShe2jYahn72uQXKj1EQmgYdGxWf
	88CIzLOM4QNKCMGNvVlRGUJU1MgBw6/Jvg2lDhBqOD8BDrsPHg97nhuzMlfEkSebeLK2zV
	Mdre7mcGU6NBvIcQC5lA6H37cFMTOCQ=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-594-k1Jeb_vUO1S-zT2iIA-19w-1; Thu,
 23 Oct 2025 11:33:13 -0400
X-MC-Unique: k1Jeb_vUO1S-zT2iIA-19w-1
X-Mimecast-MFC-AGG-ID: k1Jeb_vUO1S-zT2iIA-19w_1761233592
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id C59FB1956080;
	Thu, 23 Oct 2025 15:33:12 +0000 (UTC)
Received: from localhost (unknown [10.72.120.30])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 81BC519560B5;
	Thu, 23 Oct 2025 15:33:11 +0000 (UTC)
From: Ming Lei <ming.lei@redhat.com>
To: Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org
Cc: Uday Shankar <ushankar@purestorage.com>,
	Caleb Sander Mateos <csander@purestorage.com>,
	Ming Lei <ming.lei@redhat.com>
Subject: [PATCH V2 06/25] ublk: prepare for not tracking task context for command batch
Date: Thu, 23 Oct 2025 23:32:11 +0800
Message-ID: <20251023153234.2548062-7-ming.lei@redhat.com>
In-Reply-To: <20251023153234.2548062-1-ming.lei@redhat.com>
References: <20251023153234.2548062-1-ming.lei@redhat.com>
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
index 6b6e82ec7e45..7f02d9233a62 100644
--- a/drivers/block/ublk_drv.c
+++ b/drivers/block/ublk_drv.c
@@ -2320,7 +2320,10 @@ static int __ublk_fetch(struct io_uring_cmd *cmd, struct ublk_device *ub,
 
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


Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71E9526E6F2
	for <linux-block@vger.kernel.org>; Fri, 21 Nov 2025 01:59:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763690385; cv=none; b=qFO/4fONwEt5QO0IIknak3iBu2/dMhNPyd/05gf/6TDxwA2bJdopjGlM5HRrcmSgXlPcD41O/SoEcwLEMqAWx5yVFREKyOlw2ssex/dt53v0eGAYPPygDE5ySaGCj7GDqPSIyVX8WI+2kSctq/31QVxIprbv8q9dhoQ0RHUPh/g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763690385; c=relaxed/simple;
	bh=kJcy4CUmvgEo2byWDAoPUrwSACio5iRzha6q2St6BWk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Jyhtt90L2nwjisum3112pJXYaQJlm4JGukxIXnjUIRhdbZW/X2r1jduC316ImquR6ieHJrECCk3Uz57uA7EZg6MY/Msk5RF9M/72xkhPtRNdbB2QEPapRxGDOWywzBUDqjKczsCsDHEsekt59pnN6B7RFEpRvW0Usx91+tB9Qm8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=DVUqP0II; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DVUqP0II"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1763690382;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ODUrNlcPCRXeNA5FcaQBBiL+omHRqn5JUmPJnFh1T0E=;
	b=DVUqP0II1wllWVQwl6AQI6xPpD+zHmjz+1ZbeOq0yaEq5wk2hfsFmnnpYEemEKBYJY/KGR
	vBTRmpWVfO9kC4OxN5iVc+WXHKpsDySEn1qOnNmyibXD4EYAmUQKrNcXiILUrZ7r3d92dt
	sWMA0l0qhVbMEaHJe39DQiMZNoXX4eA=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-692-U5BkInFHMZaC0o3oUkwELw-1; Thu,
 20 Nov 2025 20:59:38 -0500
X-MC-Unique: U5BkInFHMZaC0o3oUkwELw-1
X-Mimecast-MFC-AGG-ID: U5BkInFHMZaC0o3oUkwELw_1763690377
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 849C718001FE;
	Fri, 21 Nov 2025 01:59:37 +0000 (UTC)
Received: from localhost (unknown [10.72.116.211])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 14A0C30044FE;
	Fri, 21 Nov 2025 01:59:35 +0000 (UTC)
From: Ming Lei <ming.lei@redhat.com>
To: Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org
Cc: Caleb Sander Mateos <csander@purestorage.com>,
	Uday Shankar <ushankar@purestorage.com>,
	Stefani Seibold <stefani@seibold.net>,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-kernel@vger.kernel.org,
	Ming Lei <ming.lei@redhat.com>
Subject: [PATCH V4 08/27] ublk: prepare for not tracking task context for command batch
Date: Fri, 21 Nov 2025 09:58:30 +0800
Message-ID: <20251121015851.3672073-9-ming.lei@redhat.com>
In-Reply-To: <20251121015851.3672073-1-ming.lei@redhat.com>
References: <20251121015851.3672073-1-ming.lei@redhat.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

batch io is designed to be independent of task context, and we will not
track task context for batch io feature.

Reviewed-by: Caleb Sander Mateos <csander@purestorage.com>
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


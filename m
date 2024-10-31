Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49ACB19CD1D
	for <linux-block@vger.kernel.org>; Thu, 31 Oct 2024 13:38:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730381883; cv=none; b=tJtymk5iKnXkAwXY6JXSw9lMWo3khwBm0IGav0Q0dGH5ycYVfcQVSFOrh9O60aSzoo6AuNamtX1dROrAq7sMKwdG6M8B+yrTXJ2rjG8o2q0DAh8uTQvcl+jn3kb+Hscl0QqLJeejMRsUn2Lnff/RVsyD1d+JUXEirMrL+ntC0lU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730381883; c=relaxed/simple;
	bh=gXsK2VvJJr1YYExr4GmB0lDit2VWZcMeO6PuMnMwz6A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hgBJp0qdXN2zUtA7litv0LHBDmjrzVRsLNccPmN59tG/w8yitTDi+DMtnmK1F7H9fKpRAFB5i3ZkG9uU5qd5HwNx97brIpHogjgKt9v5F/VzyNiLfb92O6qrzE6DUx7zcN18YRhlQf1IINT1AQO7+ZRqZ3tFlmKzXTstvbtmT1o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=EajpF3E5; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="EajpF3E5"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1730381880;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=wJead7//fGN4rU3BNFjrPXdL1/fRs8werddPjH4A2BE=;
	b=EajpF3E5GFKi/sQpVr2bm5ZBUm5m0WhkUeV5XV8SJDMwfXjrMz8eSMga1Mb2uP43zGJlRP
	n5AyCaZJwNh7NkLx9zltjZhGegHcuO8Rne55nOr+X2tF87iH9O57rz2tW4lw4XpnuJmFnn
	qT7uvx94IBYEOxNK+dRIFLn228LxpUM=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-126-JpsZMk31MkKb4-NzHSA5RA-1; Thu,
 31 Oct 2024 09:37:55 -0400
X-MC-Unique: JpsZMk31MkKb4-NzHSA5RA-1
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 80EAB195608F;
	Thu, 31 Oct 2024 13:37:49 +0000 (UTC)
Received: from localhost (unknown [10.72.116.4])
	by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 7997A1956086;
	Thu, 31 Oct 2024 13:37:48 +0000 (UTC)
From: Ming Lei <ming.lei@redhat.com>
To: Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org
Cc: Christoph Hellwig <hch@lst.de>,
	Ming Lei <ming.lei@redhat.com>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Lai Yi <yi1.lai@linux.intel.com>
Subject: [PATCH V2 4/4] block: don't verify IO lock for freeze/unfreeze in elevator_init_mq()
Date: Thu, 31 Oct 2024 21:37:20 +0800
Message-ID: <20241031133723.303835-5-ming.lei@redhat.com>
In-Reply-To: <20241031133723.303835-1-ming.lei@redhat.com>
References: <20241031133723.303835-1-ming.lei@redhat.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15

elevator_init_mq() is only called at the entry of add_disk_fwnode() when
disk IO isn't allowed yet.

So not verify io lock(q->io_lockdep_map) for freeze & unfreeze in
elevator_init_mq().

Reported-by: Marek Szyprowski <m.szyprowski@samsung.com>
Reported-by: Lai Yi <yi1.lai@linux.intel.com>
Fixes: f1be1788a32e ("block: model freeze & enter queue as lock for supporting lockdep")
Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 block/elevator.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/block/elevator.c b/block/elevator.c
index f169f4bae917..7c3ba80e5ff4 100644
--- a/block/elevator.c
+++ b/block/elevator.c
@@ -598,13 +598,19 @@ void elevator_init_mq(struct request_queue *q)
 	 * drain any dispatch activities originated from passthrough
 	 * requests, then no need to quiesce queue which may add long boot
 	 * latency, especially when lots of disks are involved.
+	 *
+	 * Disk isn't added yet, so verifying queue lock only manually.
 	 */
-	blk_mq_freeze_queue(q);
+	blk_freeze_queue_start_non_owner(q);
+	blk_freeze_acquire_lock(q, true, false);
+	blk_mq_freeze_queue_wait(q);
+
 	blk_mq_cancel_work_sync(q);
 
 	err = blk_mq_init_sched(q, e);
 
-	blk_mq_unfreeze_queue(q);
+	blk_unfreeze_release_lock(q, true, false);
+	blk_mq_unfreeze_queue_non_owner(q);
 
 	if (err) {
 		pr_warn("\"%s\" elevator initialization failed, "
-- 
2.47.0


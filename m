Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38B8E14277
	for <linux-block@vger.kernel.org>; Fri, 25 Oct 2024 00:38:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729816682; cv=none; b=JQwTBsUZBjmnMgFkwuZZB2Mrf148loazP1B9PCHnd7R/xDcQlJP0xH5C+pnwB1OxxeeHu5EtFkk8hvUdFcfqU/G6b4iDjkWPcypUu1t5frS5zwPltT38G89XCrVGvzp5pg3KlApMsoYh33IOe+eTOlnwv819mhIq/XW6wmJL3r0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729816682; c=relaxed/simple;
	bh=Olg2lpE8qFdYHK1854gCWeI/rvnaCSXJqNbsUpx8ubA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hUrTXyPy2B1fUTuCtENTWQozmYrFseLdHVHn7Lv12RroYDc+YmPZE+KYgvd7XruJNOZcWmv0/trNlXUcxTk08sR9qMs1j12cnDFjXU1Syi9Mei3+Eo0Q3V0PwuIS4wpH4iIjiUeTixMHRItAKAXU13CjLK5SpmmbPYmYgBQic/s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=SvxBpFiJ; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SvxBpFiJ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1729816679;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=uE1fr5Ij3ZfzUwzW5aMbdzvUD+Foxf2eQ6lm2mTzYMU=;
	b=SvxBpFiJccNsRGf9GrM7KVcfPs1PGh+Wt6gHddeHCiR9I8pgNorGaniAJIx4iJ3QzqpINZ
	Khxa15seokvIrVePTPLpGZwBwg+j0qh686BfTKy+7Dwrs7nWwswl0h8Vp2no91S2bJ6yvP
	UlDCSJ4uWFfg4z47Dhxq1APbC/Cq8ss=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-295-LJYOV8XoMXS9NDdZSkRLTQ-1; Thu,
 24 Oct 2024 20:37:45 -0400
X-MC-Unique: LJYOV8XoMXS9NDdZSkRLTQ-1
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id E0F071956096;
	Fri, 25 Oct 2024 00:37:43 +0000 (UTC)
Received: from localhost (unknown [10.72.116.27])
	by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 7FF30196BB7D;
	Fri, 25 Oct 2024 00:37:41 +0000 (UTC)
From: Ming Lei <ming.lei@redhat.com>
To: Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org
Cc: Christoph Hellwig <hch@lst.de>,
	Peter Zijlstra <peterz@infradead.org>,
	Waiman Long <longman@redhat.com>,
	Boqun Feng <boqun.feng@gmail.com>,
	Ingo Molnar <mingo@redhat.com>,
	Will Deacon <will@kernel.org>,
	linux-kernel@vger.kernel.org,
	Bart Van Assche <bvanassche@acm.org>,
	Ming Lei <ming.lei@redhat.com>
Subject: [PATCH V2 2/3] nvme: core: switch to non_owner variant of start_freeze/unfreeze queue
Date: Fri, 25 Oct 2024 08:37:19 +0800
Message-ID: <20241025003722.3630252-3-ming.lei@redhat.com>
In-Reply-To: <20241025003722.3630252-1-ming.lei@redhat.com>
References: <20241025003722.3630252-1-ming.lei@redhat.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40

nvme_start_freeze() and nvme_unfreeze() may be called from same context,
so switch them to call non_owner variant of start_freeze/unfreeze queue.

Reviewed-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 drivers/nvme/host/core.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index ba6508455e18..66d76a9296b1 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -4871,7 +4871,7 @@ void nvme_unfreeze(struct nvme_ctrl *ctrl)
 
 	srcu_idx = srcu_read_lock(&ctrl->srcu);
 	list_for_each_entry_rcu(ns, &ctrl->namespaces, list)
-		blk_mq_unfreeze_queue(ns->queue);
+		blk_mq_unfreeze_queue_non_owner(ns->queue);
 	srcu_read_unlock(&ctrl->srcu, srcu_idx);
 	clear_bit(NVME_CTRL_FROZEN, &ctrl->flags);
 }
@@ -4913,7 +4913,12 @@ void nvme_start_freeze(struct nvme_ctrl *ctrl)
 	set_bit(NVME_CTRL_FROZEN, &ctrl->flags);
 	srcu_idx = srcu_read_lock(&ctrl->srcu);
 	list_for_each_entry_rcu(ns, &ctrl->namespaces, list)
-		blk_freeze_queue_start(ns->queue);
+		/*
+		 * Typical non_owner use case is from pci driver, in which
+		 * start_freeze is called from timeout work function, but
+		 * unfreeze is done in reset work context
+		 */
+		blk_freeze_queue_start_non_owner(ns->queue);
 	srcu_read_unlock(&ctrl->srcu, srcu_idx);
 }
 EXPORT_SYMBOL_GPL(nvme_start_freeze);
-- 
2.46.0


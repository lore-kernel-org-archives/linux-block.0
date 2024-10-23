Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 408681A7275
	for <linux-block@vger.kernel.org>; Wed, 23 Oct 2024 09:55:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729677311; cv=none; b=RYfempuRqz0nVEwoqBw5jOghRq7nSmwUUh0UriUb8s9zgUI/jjYsKAWNUx0aRhSuc0oy0kMD0HeGuo0C4Nniaj95OX3t8HwckvgNF/8XLfB8VTFJY5DK/VDgd9Y+gBdkAv4Pk6IhL9kexW+JY943xilZfWty03CEP5WcwFK/ovI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729677311; c=relaxed/simple;
	bh=zlIJnV19+kvfCZ475p6XXehMNRmYT+ypXvfSmPyDANE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WWAPUwMi1FffjuiEoBqXejl9IuVnSnYJ9vUFOOL2nax2Pba4yNgfK6nuoysPGk/jFXCbB/grNFmOthS/RfGw19KZqAOBmkZ8msENQvcd4nqDRhaMHAK2sAtGXbskCVitQvr9BmNmXRaFiKDHBAAEJU1RckeTV0ZqtMLc+IVPTAs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=JWt00fWp; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JWt00fWp"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1729677309;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3frOuUOwN8tRn7DUXsZgTp8QrBlHIkulSdEobuUctI4=;
	b=JWt00fWpQn88yJOeuajV31sl9B7zupf2Ogd0ulxEeGuFE9OVGRzm215CVpiC+q/GaQM1Nc
	iH2PC0lwHD2DB9At7z1ybAakPHh1NQ12d35sieGfVoCRkjF9tZ4+gHL9i/pufl/YyLQ7VM
	1nCt9flVp0Ypb2I0LNIswFnLhAkypR8=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-517-BheH5eESPUSHqLTG0XYwCg-1; Wed,
 23 Oct 2024 05:55:05 -0400
X-MC-Unique: BheH5eESPUSHqLTG0XYwCg-1
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 738E71955F3C;
	Wed, 23 Oct 2024 09:55:04 +0000 (UTC)
Received: from localhost (unknown [10.72.116.171])
	by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id D8C4019560AE;
	Wed, 23 Oct 2024 09:55:02 +0000 (UTC)
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
Subject: [PATCH 2/3] nvme: core: switch to non_owner variant of start_freeze/unfreeze queue
Date: Wed, 23 Oct 2024 17:54:34 +0800
Message-ID: <20241023095438.3451156-3-ming.lei@redhat.com>
In-Reply-To: <20241023095438.3451156-1-ming.lei@redhat.com>
References: <20241023095438.3451156-1-ming.lei@redhat.com>
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

Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 drivers/nvme/host/core.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index ba6508455e18..06c1e4e8456f 100644
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
@@ -4913,7 +4913,7 @@ void nvme_start_freeze(struct nvme_ctrl *ctrl)
 	set_bit(NVME_CTRL_FROZEN, &ctrl->flags);
 	srcu_idx = srcu_read_lock(&ctrl->srcu);
 	list_for_each_entry_rcu(ns, &ctrl->namespaces, list)
-		blk_freeze_queue_start(ns->queue);
+		blk_freeze_queue_start_non_owner(ns->queue);
 	srcu_read_unlock(&ctrl->srcu, srcu_idx);
 }
 EXPORT_SYMBOL_GPL(nvme_start_freeze);
-- 
2.46.0


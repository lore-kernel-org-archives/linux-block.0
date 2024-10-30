Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 391F11E411D
	for <linux-block@vger.kernel.org>; Wed, 30 Oct 2024 12:43:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730292190; cv=none; b=HaEcLu+P47x82pzy+MAno68l4SRUUmau7rjkOiY+VpJE+GhtV7biQAPnHhc4TAAPHtSDClvfxVCbUcvAa8XL8nfEsUq3cLvcAoMUB1/+Yg3PcB7ZFwPxJ6gpzSRBpE+MgJ0icpkbwsE1u6zkHAhDQk5GmKkKw9VvePvMvZS8mRo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730292190; c=relaxed/simple;
	bh=xIDDJ2iriMWUvhnOBPwvhMViDw2wqRXR4WaxMM2XkGg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=g1ErkIK/C3qef2luVdw/DNromJKQ3+UwHAIAEHw+lpTRfMxBymHKz64EiZw3bAHiDbjyPFDm/9REWNfLa26zJJGAbXfZq45eQhjVYzwh3O2UwQYwJ/63VRl4eqDLOkDL5fHeC1/vBvcNThumaKryJpoG2FXVAlvFfpb18hQpseA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=TGqMTh2c; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TGqMTh2c"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1730292186;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=EkQqbAAQxUN8KVTJJir8/kNitbMwZ9QU4FyTIn53bVw=;
	b=TGqMTh2cl9zqevcFqI35YOEkz481cXdKV9RqLTRq/UCx5FMU09NUWfrZhi6mgREIdIYZYu
	DgtccYFVDUkoTBykQvFeYS+0cMZrEK4hu6pjzNecBUzi7o592xuPJV7dK1z1Y9TLr93xGr
	RQutmDtYhplzw5T0nHkcBn6Ik+DSrLw=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-543-TP-ektvbMBSzS6pFAFBjqA-1; Wed,
 30 Oct 2024 08:43:04 -0400
X-MC-Unique: TP-ektvbMBSzS6pFAFBjqA-1
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 8DD551955D5F;
	Wed, 30 Oct 2024 12:43:03 +0000 (UTC)
Received: from localhost (unknown [10.72.116.140])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 6F4DC19560A2;
	Wed, 30 Oct 2024 12:43:01 +0000 (UTC)
From: Ming Lei <ming.lei@redhat.com>
To: Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org
Cc: Christoph Hellwig <hch@lst.de>,
	Ming Lei <ming.lei@redhat.com>,
	Ilya Dryomov <idryomov@gmail.com>
Subject: [PATCH 3/5] rbd: convert to blk_mq_freeze_queue_non_owner
Date: Wed, 30 Oct 2024 20:42:35 +0800
Message-ID: <20241030124240.230610-4-ming.lei@redhat.com>
In-Reply-To: <20241030124240.230610-1-ming.lei@redhat.com>
References: <20241030124240.230610-1-ming.lei@redhat.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

rbd just calls blk_mq_freeze_queue() only, and doesn't unfreeze queue in
current context, so convert to blk_mq_freeze_queue_non_owner().

Cc: Ilya Dryomov <idryomov@gmail.com>
Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 drivers/block/rbd.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/block/rbd.c b/drivers/block/rbd.c
index 9c8b19a22c2a..63c183ecdad9 100644
--- a/drivers/block/rbd.c
+++ b/drivers/block/rbd.c
@@ -7282,7 +7282,7 @@ static ssize_t do_rbd_remove(const char *buf, size_t count)
 		 * Prevent new IO from being queued and wait for existing
 		 * IO to complete/fail.
 		 */
-		blk_mq_freeze_queue(rbd_dev->disk->queue);
+		blk_mq_freeze_queue_non_owner(rbd_dev->disk->queue);
 		blk_mark_disk_dead(rbd_dev->disk);
 	}
 
-- 
2.47.0


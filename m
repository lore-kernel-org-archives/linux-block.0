Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90E4C2FFDFA
	for <linux-block@vger.kernel.org>; Mon, 27 Oct 2025 11:50:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761565810; cv=none; b=leQOFkrcQJV4nzi1k9A30xiJi/zbxLHK8QsFEJI30Jle3coVag2JwVSRnVmSnysCBI6SkKmXw1n7NDFrnCcKi3a1YwSywN6t/9OXZr3s9bZMCgE3nt6PBTuvykwsNd/G/2xBpp0UyuotNrdqoKj7RDCa1TAotW/wUMbmWJhrh0k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761565810; c=relaxed/simple;
	bh=b88/3EBGPJc9lzm/1nNld4B7KP2zJeqohaTkIIqcqWQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tJVpap2xcgFVIeFRa3CkhXsFn+kPTUsq1GqlBKtkCZOS3uf6fQsjJfzKsaspCqlyyvrEbbwb8xUEpRZaqP6LdZ/ArUoeTbhp1SQqMeXADIGrAk18zVqDGPhEsML4FWvs4yZprDny8a8n9KacY/A9CcnVd8tOkHVCxIxKtAOZrmM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=WmL+MYdZ; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WmL+MYdZ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1761565807;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ridfegMKiCWwyYVYIRWxiR2J+JhEK7Yce+cXCCHxbKw=;
	b=WmL+MYdZXn9JPRHtG5GkJY7tvpYEVpjkV/H7B45DtwWWLtpMcrJ9S6VgzHKyWFFdbynIHE
	Yv62yCKem7HUgVLNENPaCfD4ztqrDizqXX11iMUW9/5VRRNZaGPXRXQv2jlo9mXkhoIA3R
	+jIj4ba2Hn1HAZ9xYJwrxAK1hKk2Zgw=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-546-ic7qNOvYMm-1iYA4ArFjVQ-1; Mon,
 27 Oct 2025 07:50:06 -0400
X-MC-Unique: ic7qNOvYMm-1iYA4ArFjVQ-1
X-Mimecast-MFC-AGG-ID: ic7qNOvYMm-1iYA4ArFjVQ_1761565805
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 92FFD1954224;
	Mon, 27 Oct 2025 11:50:04 +0000 (UTC)
Received: from localhost (unknown [10.72.120.21])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 648941955F1B;
	Mon, 27 Oct 2025 11:50:02 +0000 (UTC)
From: Ming Lei <ming.lei@redhat.com>
To: Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org
Cc: Uday Shankar <ushankar@purestorage.com>,
	Caleb Sander Mateos <csander@purestorage.com>,
	Ming Lei <ming.lei@redhat.com>
Subject: [PATCH 1/4] ublk: reorder tag_set initialization before queue allocation
Date: Mon, 27 Oct 2025 19:49:45 +0800
Message-ID: <20251027114950.129414-2-ming.lei@redhat.com>
In-Reply-To: <20251027114950.129414-1-ming.lei@redhat.com>
References: <20251027114950.129414-1-ming.lei@redhat.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

Move ublk_add_tag_set() before ublk_init_queues() in the device
initialization path. This allows us to use the blk-mq CPU-to-queue
mapping established by the tag_set to determine the appropriate
NUMA node for each queue allocation.

The error handling paths are also reordered accordingly.

Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 drivers/block/ublk_drv.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/block/ublk_drv.c b/drivers/block/ublk_drv.c
index 0c74a41a6753..2569566bf5e6 100644
--- a/drivers/block/ublk_drv.c
+++ b/drivers/block/ublk_drv.c
@@ -3178,17 +3178,17 @@ static int ublk_ctrl_add_dev(const struct ublksrv_ctrl_cmd *header)
 			ub->dev_info.nr_hw_queues, nr_cpu_ids);
 	ublk_align_max_io_size(ub);
 
-	ret = ublk_init_queues(ub);
+	ret = ublk_add_tag_set(ub);
 	if (ret)
 		goto out_free_dev_number;
 
-	ret = ublk_add_tag_set(ub);
+	ret = ublk_init_queues(ub);
 	if (ret)
-		goto out_deinit_queues;
+		goto out_free_tag_set;
 
 	ret = -EFAULT;
 	if (copy_to_user(argp, &ub->dev_info, sizeof(info)))
-		goto out_free_tag_set;
+		goto out_deinit_queues;
 
 	/*
 	 * Add the char dev so that ublksrv daemon can be setup.
@@ -3197,10 +3197,10 @@ static int ublk_ctrl_add_dev(const struct ublksrv_ctrl_cmd *header)
 	ret = ublk_add_chdev(ub);
 	goto out_unlock;
 
-out_free_tag_set:
-	blk_mq_free_tag_set(&ub->tag_set);
 out_deinit_queues:
 	ublk_deinit_queues(ub);
+out_free_tag_set:
+	blk_mq_free_tag_set(&ub->tag_set);
 out_free_dev_number:
 	ublk_free_dev_number(ub);
 out_free_ub:
-- 
2.47.0


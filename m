Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB7D96BFC0
	for <linux-block@vger.kernel.org>; Thu,  8 May 2025 08:58:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746694707; cv=none; b=jx5Oqf2D+m6vNRzC4x/dWQ/8boFnK/ExfT2sIy47+6oF7ZZFCt9ik6A/TJCUsuKAWx/Jq9lGsa5Lnl/xLQj7/o8E6vuHxfxqvN4LxygcpYFmAofRXqsl+cV2z87/zc1ZzUPU7Dru3qBxjZp4LRJHt4TMZfZM5w2EEa+8Ml4snEQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746694707; c=relaxed/simple;
	bh=s5RYA0DrSvqMqeBTDVZyTA5Z6LT/qFwBZkw9+79wYaE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=a9ZmubnkNXTj0x+VxPvaz28YBiPYvEuBpETpAEhUnIiC89ESL9GSBOAiL+1coF9K/RI6r33hxH+92lijVjO5Q4mzdbR9wYvn7dJrhHZ9rerG2E7LYBT5vdchDNDhbGsh53Mc3xbgYoy0KM6sbT6nSuMiUgrjrinqAqm5QF9QWGM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Jc3re0qa; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Jc3re0qa"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1746694704;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8pg1j0beJbaq7N9nQecwJgBV2tSO9a6qDDrGFGZFV8w=;
	b=Jc3re0qaw7f7hCdTJVhbBMeQn4o3RWOQrsmB68xtkbWyoeF22DhRJvn4xMEdvqtqgXEhMB
	Avku9G+AhiciF4azz9jwOWQACg2LMizIZxaGFcPvToDjkYYzBv01oGrP+sLh7kJuA3QwyL
	O6qUEDRoVAOmOE/So7Coinz36g24Ohc=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-92-nnvpXkKuMMGrLz6raIIicg-1; Thu,
 08 May 2025 04:58:19 -0400
X-MC-Unique: nnvpXkKuMMGrLz6raIIicg-1
X-Mimecast-MFC-AGG-ID: nnvpXkKuMMGrLz6raIIicg_1746694698
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 5F3021800875;
	Thu,  8 May 2025 08:58:18 +0000 (UTC)
Received: from localhost (unknown [10.72.116.149])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 2E4CF180045B;
	Thu,  8 May 2025 08:58:16 +0000 (UTC)
From: Ming Lei <ming.lei@redhat.com>
To: Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org
Cc: Nilay Shroff <nilay@linux.ibm.com>,
	Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
	Christoph Hellwig <hch@lst.de>,
	Ming Lei <ming.lei@redhat.com>
Subject: [PATCH 1/2] block: don't quiesce queue for calling elevator_set_none()
Date: Thu,  8 May 2025 16:58:04 +0800
Message-ID: <20250508085807.3175112-2-ming.lei@redhat.com>
In-Reply-To: <20250508085807.3175112-1-ming.lei@redhat.com>
References: <20250508085807.3175112-1-ming.lei@redhat.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

blk_mq_freeze_queue() can't be called on quiesced queue, otherwise it may
never return if there is any queued requests.

Fix it by removing quiesce queue around elevator_set_none() because
elevator_switch() does quiesce queue in case that we need to switch
to none really.

Fixes: 1e44bedbc921 ("block: unifying elevator change")
Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 block/blk-sysfs.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/block/blk-sysfs.c b/block/blk-sysfs.c
index 386374ff655b..8be2390c3c19 100644
--- a/block/blk-sysfs.c
+++ b/block/blk-sysfs.c
@@ -948,11 +948,8 @@ void blk_unregister_queue(struct gendisk *disk)
 		blk_mq_sysfs_unregister(disk);
 	blk_crypto_sysfs_unregister(disk);
 
-	if (queue_is_mq(q)) {
-		blk_mq_quiesce_queue(q);
+	if (queue_is_mq(q))
 		elevator_set_none(q);
-		blk_mq_unquiesce_queue(q);
-	}
 
 	mutex_lock(&q->sysfs_lock);
 	disk_unregister_independent_access_ranges(disk);
-- 
2.47.0


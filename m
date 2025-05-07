Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0002C258CC8
	for <linux-block@vger.kernel.org>; Wed,  7 May 2025 12:04:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746619470; cv=none; b=SiUoZtLqSVc9sDehkYzM4tU73ucFqqcrZxQvDV6Hy4fmSmKsAM96UMHKz2ZyxLnpUOMOWeywmmEvqxwIR4HyQUXpfIiLXkupBXnuP3GOdTQLip/1iW5ThM4GbF4zYQi1YX2VAGfCubkC9KtLacIa+zRAlflZrlFOeMetgxWxoWE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746619470; c=relaxed/simple;
	bh=jDdr9+1dqFbh6bc5Wu3sE5rkR0pQLXaWkqok5h/w9n0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Uc8YpF1ya4Lg//rvwihnU2T1yujvbC057LUMO/aiSamF9Q2sYJgvrVRJAVPpzJVaVu72qdnYgQfkkWoLcHCkHEomMg2BOANkLxeMItXgqFSWyMI68IQmiWHpK+X8YtjSDIVqIlwWFs1Rj+Mi63K1jI/Zo6koQFhjSx7UJL6h5NQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=VS09G4Du; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VS09G4Du"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1746619467;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Qbiums1SZlRXR91ijnSXg7/lh9j/5RGs/vH/Ar9axvE=;
	b=VS09G4Du6J86LBmuiTVO5McbM05Wdrtk2DxtqiFfSn+7vWH+ldL2XkwjYsYeZCNpRi7GJy
	dLmAgDSSMrTFTOfyZe01hh63JSu6lVIihmsxP4VZpMxr+spmIxnKl8OB7H4Tpu1O9LD72K
	mab2vHYeKqYPXh9idpmGw/41vACor9g=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-492-0hnVKSHNMp2i8Em9YU8SFg-1; Wed,
 07 May 2025 08:04:24 -0400
X-MC-Unique: 0hnVKSHNMp2i8Em9YU8SFg-1
X-Mimecast-MFC-AGG-ID: 0hnVKSHNMp2i8Em9YU8SFg_1746619463
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id AF656180036D;
	Wed,  7 May 2025 12:04:23 +0000 (UTC)
Received: from localhost (unknown [10.72.116.52])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 655B319560A7;
	Wed,  7 May 2025 12:04:21 +0000 (UTC)
From: Ming Lei <ming.lei@redhat.com>
To: Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org
Cc: Nilay Shroff <nilay@linux.ibm.com>,
	Christoph Hellwig <hch@lst.de>,
	Ming Lei <ming.lei@redhat.com>
Subject: [PATCH 2/2] block: avoid unnecessary queue freeze in elevator_set_none()
Date: Wed,  7 May 2025 20:04:03 +0800
Message-ID: <20250507120406.3028670-3-ming.lei@redhat.com>
In-Reply-To: <20250507120406.3028670-1-ming.lei@redhat.com>
References: <20250507120406.3028670-1-ming.lei@redhat.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

elevator_set_none() is called when deleting disk, in which queue has been
un-registered, and elevator switch can't happen any more.

So if q->elevator is NULL, it is not necessary to freeze queue and drain
IO any more.

Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 block/elevator.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/block/elevator.c b/block/elevator.c
index e1386b84a415..35f4de749dcd 100644
--- a/block/elevator.c
+++ b/block/elevator.c
@@ -754,8 +754,18 @@ void elevator_set_none(struct request_queue *q)
 		.name	= "none",
 		.quiesce_queue = true,
 	};
+	bool need_change;
 	int err;
 
+	WARN_ON_ONCE(blk_queue_registered(q));
+
+	/* queue has been unregisted, elevator can't be switched anymore */
+	mutex_lock(&q->elevator_lock);
+	need_change = !!q->elevator;
+	mutex_unlock(&q->elevator_lock);
+	if (!need_change)
+		return;
+
 	err = elevator_change(q, &ctx);
 	if (err < 0)
 		pr_warn("%s: set none elevator failed %d\n", __func__, err);
-- 
2.47.0


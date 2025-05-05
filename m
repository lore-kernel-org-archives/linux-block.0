Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EED925C83A
	for <linux-block@vger.kernel.org>; Mon,  5 May 2025 14:19:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746454743; cv=none; b=ZpVhlBDp3er8EdytWKnbh8qhW/Ev/zeXM6tBoP+dJbhkSKNsi5qZF+h7dRRdTEcu4/A3YwCewNSUhesCZH7XOUMNpyV2FN3HbYBkZXDweSapc4CR12vF6MsIF2don0d73m4YzEP//C9iomtxSeYF5lKo/DOodFbGtL8jfwFe9aY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746454743; c=relaxed/simple;
	bh=dif8ML4/auPZBQJmWjJ1YJKTjq5mIPxYIGJzCTJ+ygg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pdtzn2KWn1lA81+Pt7mQzDRcI1MbVgaFM8As2sF798XYcITcACr2IlUZgRmLwy8UvGfHqgsSuRZiSik/OEZNCyZipBdgm3cB47+pIII0U0uVmP9updVHgbuqBFaBzWBJSETIpwB95EQVwMaO66rkDzDUK4C0TE6oQJvFCWLJKJM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=PsLxBQGH; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PsLxBQGH"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1746454740;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=CxEGbPJrO9YOmDSHkyo2N4Y+uNulcFFxijBXUk5VW/0=;
	b=PsLxBQGH4c0BHpg5nfszizOsgp5J17XWIwxplZLZ8Fo9wkt1U8IOqzDXmO/Jhb6wb0Xrb0
	gCThdl5JzzNFYtD5oSMSd0XDBhmkgMD9ALEYAPyU6Kemj6DyktFn1CtUddiM3zBVbcAg7q
	j3ysb6PKj6xhCmALeeITMWyo69Nfqwc=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-204-oxbv6yLZPieD7x2YdRfipA-1; Mon,
 05 May 2025 10:18:57 -0400
X-MC-Unique: oxbv6yLZPieD7x2YdRfipA-1
X-Mimecast-MFC-AGG-ID: oxbv6yLZPieD7x2YdRfipA_1746454736
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 2D60F1800984;
	Mon,  5 May 2025 14:18:56 +0000 (UTC)
Received: from localhost (unknown [10.72.116.4])
	by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id CF77719560A3;
	Mon,  5 May 2025 14:18:54 +0000 (UTC)
From: Ming Lei <ming.lei@redhat.com>
To: Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org
Cc: Nilay Shroff <nilay@linux.ibm.com>,
	Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
	=?UTF-8?q?Thomas=20Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>,
	Christoph Hellwig <hch@lst.de>,
	Ming Lei <ming.lei@redhat.com>,
	Hannes Reinecke <hare@suse.de>
Subject: [PATCH V5 09/25] block: don't allow to switch elevator if updating nr_hw_queues is in-progress
Date: Mon,  5 May 2025 22:17:47 +0800
Message-ID: <20250505141805.2751237-10-ming.lei@redhat.com>
In-Reply-To: <20250505141805.2751237-1-ming.lei@redhat.com>
References: <20250505141805.2751237-1-ming.lei@redhat.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40

Elevator switch code is another `nr_hw_queue` reader in non-fast-IO code
path, so it can't be done if updating `nr_hw_queues` is in-progress.

Take same approach with not allowing add/del disk when updating
nr_hw_queues is in-progress, by grabbing read lock of
set->update_nr_hwq_sema.

Reviewed-by: Hannes Reinecke <hare@suse.de>
Link: https://lore.kernel.org/linux-block/aAWv3NPtNIKKvJZc@fedora/ [1]
Reported-by: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Closes: https://lore.kernel.org/linux-block/mz4t4tlwiqjijw3zvqnjb7ovvvaegkqganegmmlc567tt5xj67@xal5ro544cnc/
Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 block/elevator.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/block/elevator.c b/block/elevator.c
index 4400eb8fe54f..2e18513dcd73 100644
--- a/block/elevator.c
+++ b/block/elevator.c
@@ -723,6 +723,7 @@ ssize_t elv_iosched_store(struct gendisk *disk, const char *buf,
 	int ret;
 	unsigned int memflags;
 	struct request_queue *q = disk->queue;
+	struct blk_mq_tag_set *set = q->tag_set;
 
 	/*
 	 * If the attribute needs to load a module, do it before freezing the
@@ -734,6 +735,7 @@ ssize_t elv_iosched_store(struct gendisk *disk, const char *buf,
 
 	elv_iosched_load_module(name);
 
+	down_read(&set->update_nr_hwq_lock);
 	memflags = blk_mq_freeze_queue(q);
 	mutex_lock(&q->elevator_lock);
 	ret = elevator_change(q, name);
@@ -741,6 +743,7 @@ ssize_t elv_iosched_store(struct gendisk *disk, const char *buf,
 		ret = count;
 	mutex_unlock(&q->elevator_lock);
 	blk_mq_unfreeze_queue(q, memflags);
+	up_read(&set->update_nr_hwq_lock);
 	return ret;
 }
 
-- 
2.47.0


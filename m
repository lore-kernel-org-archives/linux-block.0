Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0414C239E7A
	for <linux-block@vger.kernel.org>; Thu,  8 May 2025 08:58:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746694712; cv=none; b=lkCQZdVdANgUlPjCf7Z8bPqJloNQSYoykSw+y/OghCthi7LIJskAtZAoPy8bNFto5oojpCXawZI/rVFa70/2AHxXECsNxJ/XmtseumjWT9vr84T+H2Bf9slm9gAFC0Nk7cuqhxq99lZwfkq2OCUDPj1NaJGDzuiZ8RNWVd7NXY0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746694712; c=relaxed/simple;
	bh=I9ipHg4dJF/BPcXllOG4sXkI86fXyicTDv5G4kbgFZo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FeoumWZiQIh8mVde0V7F+bWicNTaj6Rah8p2OwIeKg1Dvc8Tr/igiF/LdgdPWXUYAeqfYite8CmCl208L7V9OXUTYojno8cR9rvIcc8Icn4ed6TnyOkOJLaC4nSAzNqmHbB7NviKWvXKIgHQWMR1dVFoqD3YqFQ6P9DLDskLZfc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=VzcX9nVo; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VzcX9nVo"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1746694707;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vOpwlRdGJTOhHRjpjXfIanRvLHq7IBM8HuE2P1omRoE=;
	b=VzcX9nVoPvu0maJNLVh/FQk86i+DT4IeaMlT6YUKQc9Zn+B+l3bdqYdrK8x1NM38lrlt25
	lI5jBlldHDn/Bi3mST/qGdmAoQ3WmZeZaT5lynls7XMzbNwfwQiw4B8yc0e/s9o74PMlt6
	P6K4nqpdM0Mp2p6VWvVm6Lj1JHb0/jk=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-680-7YzdQrFYMy6zeD-qGO1oyA-1; Thu,
 08 May 2025 04:58:23 -0400
X-MC-Unique: 7YzdQrFYMy6zeD-qGO1oyA-1
X-Mimecast-MFC-AGG-ID: 7YzdQrFYMy6zeD-qGO1oyA_1746694702
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 5A0A818004AD;
	Thu,  8 May 2025 08:58:22 +0000 (UTC)
Received: from localhost (unknown [10.72.116.149])
	by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 3BE1C19560B4;
	Thu,  8 May 2025 08:58:20 +0000 (UTC)
From: Ming Lei <ming.lei@redhat.com>
To: Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org
Cc: Nilay Shroff <nilay@linux.ibm.com>,
	Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
	Christoph Hellwig <hch@lst.de>,
	Ming Lei <ming.lei@redhat.com>
Subject: [PATCH 2/2] block: move removing elevator after deleting disk->queue_kobj
Date: Thu,  8 May 2025 16:58:05 +0800
Message-ID: <20250508085807.3175112-3-ming.lei@redhat.com>
In-Reply-To: <20250508085807.3175112-1-ming.lei@redhat.com>
References: <20250508085807.3175112-1-ming.lei@redhat.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40

When blk_unregister_queue() is called from add_disk() failure path,
there is race in registering/unregistering elevator queue kobject
from the two code paths, because commit 559dc11143eb ("block: move
elv_register[unregister]_queue out of elevator_lock") moves elevator
queue register/unregister out of elevator lock.

Fix the race by removing elevator after deleting disk->queue_kobj,
because kobject_del(&disk->queue_kobj) drains in-progress sysfs
show()/store() of all attributes.

Fixes: 559dc11143eb ("block: move elv_register[unregister]_queue out of elevator_lock")
Reported-by: Nilay Shroff <nilay@linux.ibm.com>
Suggested-by: Nilay Shroff <nilay@linux.ibm.com>
Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 block/blk-sysfs.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/block/blk-sysfs.c b/block/blk-sysfs.c
index 8be2390c3c19..b2b9b89d6967 100644
--- a/block/blk-sysfs.c
+++ b/block/blk-sysfs.c
@@ -948,9 +948,6 @@ void blk_unregister_queue(struct gendisk *disk)
 		blk_mq_sysfs_unregister(disk);
 	blk_crypto_sysfs_unregister(disk);
 
-	if (queue_is_mq(q))
-		elevator_set_none(q);
-
 	mutex_lock(&q->sysfs_lock);
 	disk_unregister_independent_access_ranges(disk);
 	mutex_unlock(&q->sysfs_lock);
@@ -959,5 +956,8 @@ void blk_unregister_queue(struct gendisk *disk)
 	kobject_uevent(&disk->queue_kobj, KOBJ_REMOVE);
 	kobject_del(&disk->queue_kobj);
 
+	if (queue_is_mq(q))
+		elevator_set_none(q);
+
 	blk_debugfs_remove(disk);
 }
-- 
2.47.0


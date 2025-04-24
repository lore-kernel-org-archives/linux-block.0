Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B98761C3C1F
	for <linux-block@vger.kernel.org>; Thu, 24 Apr 2025 15:22:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745508166; cv=none; b=uZKzUsZnajkvc5JrFt5n0hwaE/RGevqYtveWMQ/j0RMy1nfY1YzA6d9FcvAF28olVHxPZUKNmUTweUvkFMdKkU4TWcrmH5Mi1oxJ/+e2m7GquPr/8zkjUxI9v0yCUabk7Ruhnp6R8USdbtuOAh5jvCyXTYWK8yY/fQLe+nxkTSs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745508166; c=relaxed/simple;
	bh=jnMTanq6HQ6Y66flakT4077iFxq/ZI5qJIZw/cocgR0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qEQjyoBt49I1yh7yP796ZnrJl4906Juc4b/Xq1AYKU1pMOuwsbSUS+t42lzikRfRQrYMxj8f/qPUJ7jpJbdoWQ8EEtHv1gXGTIUPx/Wpfl3MzlO5r9igv3RWP5Q7m5rj1mYn7wgCuwjlJ+nt3TqI8YyXcCdSoua5aGZp+J2O0go=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ZtE2bSW/; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZtE2bSW/"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1745508163;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=YJZQeB9oVu8sQhlXzqmbj/EI0Fpg00cat95J+NsqlU0=;
	b=ZtE2bSW/2mP8o7WWp8yPnbgJTMOFYRvG5w52fJdJZ4RIiDC1AYNMyzEBmnb4GTYqJPz5MR
	t477zpOvIuHJ+LQghoTv8C1J6Iyl9hZk83BMcVcKzfsiYkeaSOnv0/M2dVydYxrruTlp8H
	HeUQ2awKpl3LeGhq8Fg6qOp4TPcOcw4=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-652-udQ88UgbPJSroDgI2iv0IQ-1; Thu,
 24 Apr 2025 11:22:36 -0400
X-MC-Unique: udQ88UgbPJSroDgI2iv0IQ-1
X-Mimecast-MFC-AGG-ID: udQ88UgbPJSroDgI2iv0IQ_1745508154
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id BE4A7195608A;
	Thu, 24 Apr 2025 15:22:34 +0000 (UTC)
Received: from localhost (unknown [10.72.116.90])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id DC10E180047F;
	Thu, 24 Apr 2025 15:22:33 +0000 (UTC)
From: Ming Lei <ming.lei@redhat.com>
To: Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org
Cc: Nilay Shroff <nilay@linux.ibm.com>,
	Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
	=?UTF-8?q?Thomas=20Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>,
	Christoph Hellwig <hch@lst.de>,
	Ming Lei <ming.lei@redhat.com>
Subject: [PATCH V3 10/20] block: move blk_unregister_queue() & device_del() after freeze wait
Date: Thu, 24 Apr 2025 23:21:33 +0800
Message-ID: <20250424152148.1066220-11-ming.lei@redhat.com>
In-Reply-To: <20250424152148.1066220-1-ming.lei@redhat.com>
References: <20250424152148.1066220-1-ming.lei@redhat.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

Move blk_unregister_queue() & device_del() after freeze wait, and prepare
for unifying elevator switch.

This way is just fine, since bdev has been unhashed at the beginning of
del_gendisk(), both blk_unregister_queue() & device_del() are dealing
with kobject & debugfs thing only.

Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 block/genhd.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/block/genhd.c b/block/genhd.c
index 7f3ae3d23b26..53c5b1e9e1d2 100644
--- a/block/genhd.c
+++ b/block/genhd.c
@@ -733,8 +733,6 @@ static void __del_gendisk(struct gendisk *disk)
 		bdi_unregister(disk->bdi);
 	}
 
-	blk_unregister_queue(disk);
-
 	kobject_put(disk->part0->bd_holder_dir);
 	kobject_put(disk->slave_dir);
 	disk->slave_dir = NULL;
@@ -743,10 +741,12 @@ static void __del_gendisk(struct gendisk *disk)
 	disk->part0->bd_stamp = 0;
 	sysfs_remove_link(block_depr, dev_name(disk_to_dev(disk)));
 	pm_runtime_set_memalloc_noio(disk_to_dev(disk), false);
-	device_del(disk_to_dev(disk));
 
 	blk_mq_freeze_queue_wait(q);
 
+	blk_unregister_queue(disk);
+	device_del(disk_to_dev(disk));
+
 	blk_throtl_cancel_bios(disk);
 
 	blk_sync_queue(q);
-- 
2.47.0


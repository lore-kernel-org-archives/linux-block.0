Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F0798633A
	for <linux-block@vger.kernel.org>; Thu, 10 Apr 2025 13:31:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744291894; cv=none; b=dsFCNzCgtRRJs3HgPPbvP4GjULqYK1YUuKkcENOWzMYRLpUHYXxw7C4XgXy4qKZ4/zQvmTy2a87skWsBvVFOa+KF0jBym1sa5Zn2wVNcVesTKvAdM9XAkM5Zre1C0dwL8JDu59cURCj7air+33voqFjyMrC6H/0UlxYuC/hTlHY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744291894; c=relaxed/simple;
	bh=ys36xuRxasvFBQAggPOSKq0MJ+kOM4dkpKM1wXgaWKA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YDu0a//XDDVhhkmcMUaWSYZiXbLRrCw8BCOkuUWODYzyjlS1noHyyAciQrlLZigYlXCduo/ib09bd/r5EVlU63OCvUGASkiYJB+QemqvlG4jcPKqktJnV46ggCrFRRBzBlkFA0bHxAtKniPoCyyrH3s0LYtyfwC1g6V8k0/FC0E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=CXb3k+A6; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CXb3k+A6"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1744291890;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=F78dOB1IcPUXETUNoydupo0qY3sU/ZSPJ3VakeLk0+4=;
	b=CXb3k+A6hJPUiuHZ9gw+x1iVyAPcrDqVQgAwJX1p/fbAAv0glFAqh04baOrzpZg/8Y0qpN
	oZZkawZ47+KB3Lu/xmxc5A3yI6EoIFG55CwmQKviGuzICnAoLA0bwkV4LGhmbiyE6rJr7i
	M8NNeLefiOkhdOoRS+I90Ic6bQbr5CM=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-56-_CT1uXJ_PmGcachMhWwE_Q-1; Thu,
 10 Apr 2025 09:31:26 -0400
X-MC-Unique: _CT1uXJ_PmGcachMhWwE_Q-1
X-Mimecast-MFC-AGG-ID: _CT1uXJ_PmGcachMhWwE_Q_1744291883
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 0815C1801A06;
	Thu, 10 Apr 2025 13:31:23 +0000 (UTC)
Received: from localhost (unknown [10.72.120.20])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id E767B1808882;
	Thu, 10 Apr 2025 13:31:21 +0000 (UTC)
From: Ming Lei <ming.lei@redhat.com>
To: Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org
Cc: Nilay Shroff <nilay@linux.ibm.com>,
	Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
	=?UTF-8?q?Thomas=20Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>,
	Christoph Hellwig <hch@lst.de>,
	Ming Lei <ming.lei@redhat.com>
Subject: [PATCH 07/15] block: move blk_unregister_queue() & device_del() after freeze wait
Date: Thu, 10 Apr 2025 21:30:19 +0800
Message-ID: <20250410133029.2487054-8-ming.lei@redhat.com>
In-Reply-To: <20250410133029.2487054-1-ming.lei@redhat.com>
References: <20250410133029.2487054-1-ming.lei@redhat.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

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
index c2bd86cd09de..f426c13edf55 100644
--- a/block/genhd.c
+++ b/block/genhd.c
@@ -721,8 +721,6 @@ void del_gendisk(struct gendisk *disk)
 		bdi_unregister(disk->bdi);
 	}
 
-	blk_unregister_queue(disk);
-
 	kobject_put(disk->part0->bd_holder_dir);
 	kobject_put(disk->slave_dir);
 	disk->slave_dir = NULL;
@@ -731,10 +729,12 @@ void del_gendisk(struct gendisk *disk)
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


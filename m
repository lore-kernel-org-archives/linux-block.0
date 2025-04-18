Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90B181DE89C
	for <linux-block@vger.kernel.org>; Fri, 18 Apr 2025 16:38:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744994293; cv=none; b=lb3+wp5pFKweNMwSKNWJwZCxBxRKdTaFnX9y47R3DxGVU1zS0p64grKbLZ+RbT2rzWmV0Qz/i6PX3YkfmEK/30aDHpv7hSQAm7Y6rqCIko8UKr05yciMxt7FNdq9y4ghuoeLSFUwRv3swiVt5/31aXYn0nWbd3gMWSTb61m+I/c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744994293; c=relaxed/simple;
	bh=9umTJ+eIsj6kjjaD7RaWGUUqxxEKtJldOR0awF0uALY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Y2+ua6yDxCQICdE00X1c6wYbknAzYjoP6rKCcAJDEKtpSJqS6zi71MePAgGQTQJqhXrKTCkn5PmtFNbEgnLJXTsubMikgEjDWOhz8aZw+pqcq89zzWTJ8loWfuoinFMZTHxPBWUeVkZV91Dn7t9gKZbS56BAyZKwIgXLcNOuIwA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=KGRQA6G1; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KGRQA6G1"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1744994290;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=gaEe/cy87tCmAT8pjSKB35mAoRNQ92uw8XtLksZPyAQ=;
	b=KGRQA6G14t4EWutKdGsTarL6j696r4TYOuj9HmZ84jK9EAA7LU03Qk1OkyDO29LY5K9vJ4
	4zrgnOXm9gzQrWv9B+VSbder3+8ER0mNJ7ZHDK3+HSlU94cPOPzWgFhw3Ry6aGmjNzuS/W
	q37Vapr1NmefrJpM1S/PLJieEB169zg=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-322-vsy2F_ZfPiK-u0PJR19jdw-1; Fri,
 18 Apr 2025 12:38:08 -0400
X-MC-Unique: vsy2F_ZfPiK-u0PJR19jdw-1
X-Mimecast-MFC-AGG-ID: vsy2F_ZfPiK-u0PJR19jdw_1744994287
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id EB5FE180087B;
	Fri, 18 Apr 2025 16:38:06 +0000 (UTC)
Received: from localhost (unknown [10.72.116.50])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id EACFB19560A3;
	Fri, 18 Apr 2025 16:38:05 +0000 (UTC)
From: Ming Lei <ming.lei@redhat.com>
To: Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org
Cc: Nilay Shroff <nilay@linux.ibm.com>,
	Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
	=?UTF-8?q?Thomas=20Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>,
	Christoph Hellwig <hch@lst.de>,
	Ming Lei <ming.lei@redhat.com>
Subject: [PATCH V2 11/20] block: move blk_unregister_queue() & device_del() after freeze wait
Date: Sat, 19 Apr 2025 00:36:52 +0800
Message-ID: <20250418163708.442085-12-ming.lei@redhat.com>
In-Reply-To: <20250418163708.442085-1-ming.lei@redhat.com>
References: <20250418163708.442085-1-ming.lei@redhat.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

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
index d22fdc0d5383..86c3db5b9305 100644
--- a/block/genhd.c
+++ b/block/genhd.c
@@ -749,8 +749,6 @@ static int __del_gendisk(struct gendisk_data *data)
 		bdi_unregister(disk->bdi);
 	}
 
-	blk_unregister_queue(disk);
-
 	kobject_put(disk->part0->bd_holder_dir);
 	kobject_put(disk->slave_dir);
 	disk->slave_dir = NULL;
@@ -759,10 +757,12 @@ static int __del_gendisk(struct gendisk_data *data)
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


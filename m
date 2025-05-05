Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA32A25A33E
	for <linux-block@vger.kernel.org>; Mon,  5 May 2025 14:18:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746454734; cv=none; b=WwrFX3zrzWA2UwxRtF3G49/qSkOqs+fTzV0+zEfYVQkmBjqSleQAbjLmxaLyV8iFu3GzKbvn6ukD1t9Vhqpq1e9lZ8tU+eboiJ3QIjvaGEIanHqwrdff3Fusmb+yDAf12Xal5JxPaTqUp2reMAH3N1QugvM4nkDLdQ+pVGCoyRM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746454734; c=relaxed/simple;
	bh=KLaAmRXFebYUnJPpxw0yHyEqXo4/L39PSYQEzjfwIGk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LdaLINfKmv4a4jdD3JsbgKN/lJg7Hfhyn8ZLJthkmIgAr3UAFP4bXk6H/qBQmXCMfZlixeXNcEBT+K03rGO+d/WCfCUBAIeJPiAHASOnsa43qFhpgOU54rD3y/AWoOyROtlu5RfcUhFhaw8FtCunTbKpmt4yBupugdbVqVNHhps=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=OFri2Gft; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OFri2Gft"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1746454732;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=srV6yLsfcHQubB72hVhgedR+8aju/mp6/2r59GeOSIU=;
	b=OFri2GftZGH1zwRSQC+0igwka55GYPzG2TzgIAh1HIqNxGDx30rKPHpAenKJX5rPQu/7i4
	QB+lnTAYciNoKyTyM+VM94Z29SVwhdZCrYaBoKFqitf7Ob/nDmq4EpXVo5QasMFScoUm9S
	P3pTnJITr+/UXSf0TZb3JaByD4DjBKg=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-607-p7bPd3zTM8WkVnI-z3m1vA-1; Mon,
 05 May 2025 10:18:48 -0400
X-MC-Unique: p7bPd3zTM8WkVnI-z3m1vA-1
X-Mimecast-MFC-AGG-ID: p7bPd3zTM8WkVnI-z3m1vA_1746454726
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id CEEA5195608B;
	Mon,  5 May 2025 14:18:46 +0000 (UTC)
Received: from localhost (unknown [10.72.116.4])
	by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id ABE2E19560AF;
	Mon,  5 May 2025 14:18:44 +0000 (UTC)
From: Ming Lei <ming.lei@redhat.com>
To: Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org
Cc: Nilay Shroff <nilay@linux.ibm.com>,
	Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
	=?UTF-8?q?Thomas=20Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>,
	Christoph Hellwig <hch@lst.de>,
	Ming Lei <ming.lei@redhat.com>
Subject: [PATCH V5 07/25] block: add helper add_disk_final()
Date: Mon,  5 May 2025 22:17:45 +0800
Message-ID: <20250505141805.2751237-8-ming.lei@redhat.com>
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

Add helper add_disk_final() for scanning partitions, announcing disk and
handling the last thing for adding disk.

No functional change, and prepare for prevent adding disk from happening
when updating nr_hw_queues.

Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 block/genhd.c | 46 +++++++++++++++++++++++++++-------------------
 1 file changed, 27 insertions(+), 19 deletions(-)

diff --git a/block/genhd.c b/block/genhd.c
index c2bd86cd09de..50f3deeec5e3 100644
--- a/block/genhd.c
+++ b/block/genhd.c
@@ -389,6 +389,32 @@ int disk_scan_partitions(struct gendisk *disk, blk_mode_t mode)
 	return ret;
 }
 
+static void add_disk_final(struct gendisk *disk)
+{
+	struct device *ddev = disk_to_dev(disk);
+
+	if (!(disk->flags & GENHD_FL_HIDDEN)) {
+		/* Make sure the first partition scan will be proceed */
+		if (get_capacity(disk) && disk_has_partscan(disk))
+			set_bit(GD_NEED_PART_SCAN, &disk->state);
+
+		bdev_add(disk->part0, ddev->devt);
+		if (get_capacity(disk))
+			disk_scan_partitions(disk, BLK_OPEN_READ);
+
+		/*
+		 * Announce the disk and partitions after all partitions are
+		 * created. (for hidden disks uevents remain suppressed forever)
+		 */
+		dev_set_uevent_suppress(ddev, 0);
+		disk_uevent(disk, KOBJ_ADD);
+	}
+
+	blk_apply_bdi_limits(disk->bdi, &disk->queue->limits);
+	disk_add_events(disk);
+	set_bit(GD_ADDED, &disk->state);
+}
+
 /**
  * add_disk_fwnode - add disk information to kernel list with fwnode
  * @parent: parent device for the disk
@@ -516,21 +542,6 @@ int __must_check add_disk_fwnode(struct device *parent, struct gendisk *disk,
 					&disk->bdi->dev->kobj, "bdi");
 		if (ret)
 			goto out_unregister_bdi;
-
-		/* Make sure the first partition scan will be proceed */
-		if (get_capacity(disk) && disk_has_partscan(disk))
-			set_bit(GD_NEED_PART_SCAN, &disk->state);
-
-		bdev_add(disk->part0, ddev->devt);
-		if (get_capacity(disk))
-			disk_scan_partitions(disk, BLK_OPEN_READ);
-
-		/*
-		 * Announce the disk and partitions after all partitions are
-		 * created. (for hidden disks uevents remain suppressed forever)
-		 */
-		dev_set_uevent_suppress(ddev, 0);
-		disk_uevent(disk, KOBJ_ADD);
 	} else {
 		/*
 		 * Even if the block_device for a hidden gendisk is not
@@ -539,10 +550,7 @@ int __must_check add_disk_fwnode(struct device *parent, struct gendisk *disk,
 		 */
 		disk->part0->bd_dev = MKDEV(disk->major, disk->first_minor);
 	}
-
-	blk_apply_bdi_limits(disk->bdi, &disk->queue->limits);
-	disk_add_events(disk);
-	set_bit(GD_ADDED, &disk->state);
+	add_disk_final(disk);
 	return 0;
 
 out_unregister_bdi:
-- 
2.47.0


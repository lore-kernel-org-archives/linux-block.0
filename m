Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41A0C23F29B
	for <linux-block@vger.kernel.org>; Wed, 15 Jan 2025 09:27:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736933226; cv=none; b=cihT0uIQyVikcDu/rnmySonTYN+p4mrfID0qINnyvv3tAbEUvo/s3llQ7Sgqo7Y4dcyTtEBLTZF1F9n9oX9IPp68SjYZC33hCZwSDSiyKpRbVn688YrIwpbegzWlglOowyuW1Jq8sU+/TsxAB06hGQ92k9LP2hEeHrQF+j+xoy4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736933226; c=relaxed/simple;
	bh=HRuynDTjVeVzGfMxgATd2ozGoRfCzQJex+LLSl9v4sc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=NgiL6d5ntAt0otMHErwW6nfyCSK+SaLSflBnir0HK8QF0OWqL9rDvB46400gVNxyWGQ3PDLvypfeN/tMZP2KqZWUzl847BWl1CG06MQNy7HOZadtCaPgQZsCDcyiHPli7dhMT6lWbxJ1nJ3Njt+9E2BImOe/G/VHTjxctLvWdcc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=hsJboMT+; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hsJboMT+"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1736933223;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=33Thuv6bBji2Q9STFyfa+uQEJS3KDxg05CxOfWDCCEs=;
	b=hsJboMT+320J+ExrIhVRMrleLy4PsrKWnf/n+QAYrOoVs7f9g2tJ/OEXNBG1CdrU4+r1nY
	yBqeRYIqOY7PRBQXxcxOvmAHFwjGiudMEZw/IAE7v7aqjFztOQf0/LDL4s/QMQ1FVdu8Zv
	q0Z28pxY3zqpnMl3ywCLwgtGC4PneGA=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-93-8O_FV8cDPhagQZ9uLW_2rw-1; Wed,
 15 Jan 2025 04:26:59 -0500
X-MC-Unique: 8O_FV8cDPhagQZ9uLW_2rw-1
X-Mimecast-MFC-AGG-ID: 8O_FV8cDPhagQZ9uLW_2rw
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 05F591956048;
	Wed, 15 Jan 2025 09:26:58 +0000 (UTC)
Received: from localhost (unknown [10.72.116.128])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 008D93003FD3;
	Wed, 15 Jan 2025 09:26:55 +0000 (UTC)
From: Ming Lei <ming.lei@redhat.com>
To: Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org
Cc: Ming Lei <ming.lei@redhat.com>
Subject: [PATCH] block: limit disk max sectors to (LLONG_MAX >> 9)
Date: Wed, 15 Jan 2025 17:26:48 +0800
Message-ID: <20250115092648.1104452-1-ming.lei@redhat.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

Kernel `loff_t` is defined as `long long int`, so we can't support disk
which size is > LLONG_MAX.

There are many virtual block drivers, and hardware may report bad capacity
too, so limit max sectors to (LLONG_MAX >> 9) for avoiding potential
trouble.

Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 block/blk.h   |  2 ++
 block/genhd.c | 10 ++++++++++
 2 files changed, 12 insertions(+)

diff --git a/block/blk.h b/block/blk.h
index 4904b86d5fec..90fa5f28ccab 100644
--- a/block/blk.h
+++ b/block/blk.h
@@ -13,6 +13,8 @@
 
 struct elevator_type;
 
+#define	BLK_DEV_MAX_SECTORS	(LLONG_MAX >> 9)
+
 /* Max future timer expiry for timeouts */
 #define BLK_MAX_TIMEOUT		(5 * HZ)
 
diff --git a/block/genhd.c b/block/genhd.c
index befb7a516bcf..e9375e20d866 100644
--- a/block/genhd.c
+++ b/block/genhd.c
@@ -58,6 +58,13 @@ static DEFINE_IDA(ext_devt_ida);
 
 void set_capacity(struct gendisk *disk, sector_t sectors)
 {
+	if (sectors > BLK_DEV_MAX_SECTORS) {
+		pr_warn_once("%s: truncate capacity from %lld to %lld\n",
+				disk->disk_name, sectors,
+				BLK_DEV_MAX_SECTORS);
+		sectors = BLK_DEV_MAX_SECTORS;
+	}
+
 	bdev_set_nr_sectors(disk->part0, sectors);
 }
 EXPORT_SYMBOL(set_capacity);
@@ -400,6 +407,9 @@ int __must_check add_disk_fwnode(struct device *parent, struct gendisk *disk,
 	struct device *ddev = disk_to_dev(disk);
 	int ret;
 
+	if (WARN_ON_ONCE(bdev_nr_sectors(disk->part0) > BLK_DEV_MAX_SECTORS))
+		return -EINVAL;
+
 	if (queue_is_mq(disk->queue)) {
 		/*
 		 * ->submit_bio and ->poll_bio are bypassed for blk-mq drivers.
-- 
2.44.0


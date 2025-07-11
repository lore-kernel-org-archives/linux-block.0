Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50991219A86
	for <linux-block@vger.kernel.org>; Fri, 11 Jul 2025 08:30:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752222642; cv=none; b=bELv/CIU7zxm8Yl3iEoxD+ogiR8ohqovMcyxwkjmlLZeKQ+ji4PXmEAmm6KWL7+xwzokSIi4XNWjJoDcOTTwjrPJlFTg/2ICWp5LeRwXrzs65MFX46RenPka9sXkZ+OdZQcXnoLTKoORORt9Fh+vD7mluWoGDRHIQBBWQ5aURQI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752222642; c=relaxed/simple;
	bh=s87+GSrJxABKe5ulGVCYXPUOqlZAScXqzE/sCmJeMy0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=pLpNA26b+kQWH423eb6pDMMZ4xJEN+b8KonDAWgsVZ+1MAQ3s3dstFbnl+5K6jnUZEWWARPW3rmq7Nz5eruZ42oe4rBe4zdwnbrvKy3yYd8da/HT0Ca9NNH9Aamu6TB3cNo2biqf6HmNOpHWCPseQgBWxy2zzRYd6RzNl9RAUi0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=RQ8+wXuv; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RQ8+wXuv"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1752222639;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=ui6+afpXcABXZigqTLygt5/JpAKyYoPERyhNQzBpqRU=;
	b=RQ8+wXuvNas4dc+tRBuXcifP4aAFLwGpjIwxnkkpvgs8ns7DdrWPwuP/9BRyeTPJkc5d08
	1XRxmMvGyr1/C0KysM+hDps1wUl2U7EvndxD/1AJqv2fCFy9lYIHpEV3Le2NAv+cYYxjbC
	Uy+/mvxEz9B11N07tWvVc4yIWLV8WHs=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-567-TeIk4fmaNyulDkUMNskq1w-1; Fri,
 11 Jul 2025 04:30:35 -0400
X-MC-Unique: TeIk4fmaNyulDkUMNskq1w-1
X-Mimecast-MFC-AGG-ID: TeIk4fmaNyulDkUMNskq1w_1752222635
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 50FA11809C83;
	Fri, 11 Jul 2025 08:30:34 +0000 (UTC)
Received: from localhost (unknown [10.72.116.162])
	by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 253DC1956094;
	Fri, 11 Jul 2025 08:30:32 +0000 (UTC)
From: Ming Lei <ming.lei@redhat.com>
To: Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org
Cc: Ming Lei <ming.lei@redhat.com>,
	Christoph Hellwig <hch@lst.de>
Subject: [PATCH] block: fix kobject leak in blk_unregister_queue
Date: Fri, 11 Jul 2025 16:30:09 +0800
Message-ID: <20250711083009.2574432-1-ming.lei@redhat.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15

The kobject for the queue, `disk->queue_kobj`, is initialized with a
reference count of 1 via `kobject_init()` in `blk_register_queue()`.
While `kobject_del()` is called during the unregister path to remove
the kobject from sysfs, the initial reference is never released.

Add a call to `kobject_put()` in `blk_unregister_queue()` to properly
decrement the reference count and fix the leak.

Fixes: 2bd85221a625 ("block: untangle request_queue refcounting from sysfs")
Cc: Christoph Hellwig <hch@lst.de>
Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 block/blk-sysfs.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/block/blk-sysfs.c b/block/blk-sysfs.c
index b2b9b89d6967..c611444480b3 100644
--- a/block/blk-sysfs.c
+++ b/block/blk-sysfs.c
@@ -960,4 +960,5 @@ void blk_unregister_queue(struct gendisk *disk)
 		elevator_set_none(q);
 
 	blk_debugfs_remove(disk);
+	kobject_put(&disk->queue_kobj);
 }
-- 
2.47.0


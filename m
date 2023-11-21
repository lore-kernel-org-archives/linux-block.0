Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="aFBWN/Iy"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A757495
	for <linux-block@vger.kernel.org>; Tue, 21 Nov 2023 02:12:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1700561535;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=wFoNCDNFycrLKwTlQyJifnLzi0ZIjnDGQ2SmvPPDNXU=;
	b=aFBWN/IySwKX0z72PuB97YngyjRm4HBe5jg1ABWOyc7dnSGb6APraHrPN8sJe6At2q55O4
	BBM/Y5XHHqqubiRIoAgUkS4oKxt0f9agawlOZNGLU51Sh2Je2/81TOw8K/f9/WonFb9b8V
	r3QKxtcZsD6num3eRq0O4vbWlm7/IW8=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-54-16nDeiBRPg6V2mKJhNfsJg-1; Tue, 21 Nov 2023 05:12:11 -0500
X-MC-Unique: 16nDeiBRPg6V2mKJhNfsJg-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 6635284B0C0;
	Tue, 21 Nov 2023 10:12:11 +0000 (UTC)
Received: from localhost (unknown [10.72.120.14])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 837AA20268D0;
	Tue, 21 Nov 2023 10:12:10 +0000 (UTC)
From: Ming Lei <ming.lei@redhat.com>
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org,
	Ming Lei <ming.lei@redhat.com>,
	Yu Kuai <yukuai3@huawei.com>
Subject: [PATCH] block: move .bd_inode into 1st cacheline of block_device
Date: Tue, 21 Nov 2023 18:11:56 +0800
Message-ID: <20231121101156.378105-1-ming.lei@redhat.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.4

The .bd_inode field of block_device is used in IO fast path of
blkdev_write_iter() and blkdev_llseek(), so it is more efficient to keep
it into the 1st cacheline.

.bd_openers is only touched in open()/close(), and .bd_size_lock is only
for updating bdev capacity, which is in slow path too.

So swap .bd_inode layout with .bd_openers & .bd_size_lock to move
.bd_inode into the 1st cache line.

Cc: Yu Kuai <yukuai3@huawei.com>
Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 include/linux/blk_types.h | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/include/linux/blk_types.h b/include/linux/blk_types.h
index d5c5e59ddbd2..f7d40692dd94 100644
--- a/include/linux/blk_types.h
+++ b/include/linux/blk_types.h
@@ -49,9 +49,10 @@ struct block_device {
 	bool			bd_write_holder;
 	bool			bd_has_submit_bio;
 	dev_t			bd_dev;
+	struct inode		*bd_inode;	/* will die */
+
 	atomic_t		bd_openers;
 	spinlock_t		bd_size_lock; /* for bd_inode->i_size updates */
-	struct inode *		bd_inode;	/* will die */
 	void *			bd_claiming;
 	void *			bd_holder;
 	const struct blk_holder_ops *bd_holder_ops;
-- 
2.41.0


Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EDDBD304
	for <linux-block@vger.kernel.org>; Thu,  9 Nov 2023 08:28:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QR2jRGLs"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4DAA5210A
	for <linux-block@vger.kernel.org>; Thu,  9 Nov 2023 00:28:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1699518530;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=TKug77vrVJVfRfMMq1oTjfuQ4KM4DhTNZYn2ZXG41c8=;
	b=QR2jRGLsMbmLsA8QmrNxbq8Powge6xcV9QtQa0WRWzHVBfyZafCqJTnxw9B2Z7fmAQ03+e
	HoF83z8eE9kR8ezCh9K7EiNWAqrUW2bUt+Pj060ZvKnmOLuip8UMw8mw3iLnpu76bv3WVF
	YhrN+KE2KuFurhONP5SLtqMuQNC0/js=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-614-TVqv4VKbN8C-HyCCfvzIYQ-1; Thu, 09 Nov 2023 03:28:46 -0500
X-MC-Unique: TVqv4VKbN8C-HyCCfvzIYQ-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com [10.11.54.8])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 1F93C101A53B;
	Thu,  9 Nov 2023 08:28:46 +0000 (UTC)
Received: from localhost (unknown [10.72.120.3])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 3AC79C12911;
	Thu,  9 Nov 2023 08:28:44 +0000 (UTC)
From: Ming Lei <ming.lei@redhat.com>
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org,
	Christoph Hellwig <hch@lst.de>,
	Ed Tsai <ed.tsai@mediatek.com>,
	Ming Lei <ming.lei@redhat.com>
Subject: [PATCH V2 1/2] block: don't call into iov_iter_revert if nothing is left
Date: Thu,  9 Nov 2023 16:28:20 +0800
Message-ID: <20231109082827.2276696-2-ming.lei@redhat.com>
In-Reply-To: <20231109082827.2276696-1-ming.lei@redhat.com>
References: <20231109082827.2276696-1-ming.lei@redhat.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.8

Most of times all pages are just added to bio, and nothing is left, so
not necessary to call into iov_iter_revert().

Same with block size alignment handling.

Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 block/bio.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/block/bio.c b/block/bio.c
index 816d412c06e9..09a5e71a0372 100644
--- a/block/bio.c
+++ b/block/bio.c
@@ -1262,8 +1262,11 @@ static int __bio_iov_iter_get_pages(struct bio *bio, struct iov_iter *iter)
 
 	if (bio->bi_bdev) {
 		size_t trim = size & (bdev_logical_block_size(bio->bi_bdev) - 1);
-		iov_iter_revert(iter, trim);
-		size -= trim;
+
+		if (trim) {
+			iov_iter_revert(iter, trim);
+			size -= trim;
+		}
 	}
 
 	if (unlikely(!size)) {
@@ -1286,7 +1289,8 @@ static int __bio_iov_iter_get_pages(struct bio *bio, struct iov_iter *iter)
 		offset = 0;
 	}
 
-	iov_iter_revert(iter, left);
+	if (left)
+		iov_iter_revert(iter, left);
 out:
 	while (i < nr_pages)
 		bio_release_page(bio, pages[i++]);
-- 
2.41.0


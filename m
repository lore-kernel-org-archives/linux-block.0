Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 112CD12E40
	for <linux-block@vger.kernel.org>; Tue,  7 Nov 2023 10:01:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bEO6nd0w"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B09B10A
	for <linux-block@vger.kernel.org>; Tue,  7 Nov 2023 02:01:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1699351309;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=lOOzVOZOsr8b8ekJ9HOherZxUE3aEEPAis2UCqVhs0g=;
	b=bEO6nd0wJVcHTPWi9CeoYJ6hV8oAWhwM9DcbzbH0OwStwzgqbx2FK8DT4zvJ2vwpmrCr4x
	804aQgU9tjpb24eBBnDQNRKSYulrRvtgX96RU2vH0B3zkY5FTLV9JKEIGTxZErvYP2R+yq
	5KhiOZAzmd6Zh5O/8fd8TAY15ECMxdU=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-308-hPBFCb9RMFOY4PVN3HOqDw-1; Tue, 07 Nov 2023 05:01:47 -0500
X-MC-Unique: hPBFCb9RMFOY4PVN3HOqDw-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com [10.11.54.9])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id A038F185A7A2;
	Tue,  7 Nov 2023 10:01:47 +0000 (UTC)
Received: from localhost (unknown [10.72.120.4])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 93940492BE8;
	Tue,  7 Nov 2023 10:01:46 +0000 (UTC)
From: Ming Lei <ming.lei@redhat.com>
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org,
	Ming Lei <ming.lei@redhat.com>,
	Ed Tsai <ed.tsai@mediatek.com>
Subject: [PATCH] block: try to make aligned bio in case of big chunk IO
Date: Tue,  7 Nov 2023 18:01:40 +0800
Message-ID: <20231107100140.2084870-1-ming.lei@redhat.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.9

In case of big chunk sequential IO, bio's size is often not aligned with
this queue's max request size because of multipage bvec, then small sized
bio can be made by bio split, so try to align bio with max io size if
it isn't the last one.

Ed Tsai reported this way improves 64MB read/write by > 15%~25% in
Antutu V10 Storage Test.

Reported-by: Ed Tsai <ed.tsai@mediatek.com>
Closes: https://lore.kernel.org/linux-block/20231025092255.27930-1-ed.tsai@mediatek.com/
Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 block/bio.c | 57 +++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 57 insertions(+)

diff --git a/block/bio.c b/block/bio.c
index 816d412c06e9..749b6283dab9 100644
--- a/block/bio.c
+++ b/block/bio.c
@@ -1294,6 +1294,47 @@ static int __bio_iov_iter_get_pages(struct bio *bio, struct iov_iter *iter)
 	return ret;
 }
 
+/* should only be called before submission */
+static void bio_shrink(struct bio *bio, unsigned bytes)
+{
+	unsigned int size = bio->bi_iter.bi_size;
+	int idx;
+
+	if (bytes >= size)
+		return;
+
+	WARN_ON_ONCE(bio_flagged(bio, BIO_CLONED));
+
+	idx = bio->bi_vcnt - 1;
+	bio->bi_iter.bi_size -= bytes;
+	while (bytes > 0) {
+		struct bio_vec *bv = &bio->bi_io_vec[idx];
+		unsigned int len = min_t(unsigned, bv->bv_len, bytes);
+
+		bytes -= len;
+		bv->bv_len -= len;
+		if (!bv->bv_len) {
+			bio_release_page(bio, bv->bv_page);
+			idx--;
+		}
+	}
+	WARN_ON_ONCE(idx < 0);
+	bio->bi_vcnt = idx + 1;
+}
+
+static unsigned bio_align_with_io_size(struct bio *bio)
+{
+	struct request_queue *q = bdev_get_queue(bio->bi_bdev);
+	unsigned int size = bio->bi_iter.bi_size;
+	unsigned int trim = size & ((queue_max_sectors(q) << 9) - 1);
+
+	if (trim && trim != size) {
+		bio_shrink(bio, trim);
+		return trim;
+	}
+	return 0;
+}
+
 /**
  * bio_iov_iter_get_pages - add user or kernel pages to a bio
  * @bio: bio to add pages to
@@ -1333,6 +1374,22 @@ int bio_iov_iter_get_pages(struct bio *bio, struct iov_iter *iter)
 		ret = __bio_iov_iter_get_pages(bio, iter);
 	} while (!ret && iov_iter_count(iter) && !bio_full(bio, 0));
 
+
+	/*
+	 * If we still have data and bio is full, this bio size may not be
+	 * aligned with max io size, small bio can be caused by split, try
+	 * to avoid this situation by aligning bio with max io size.
+	 *
+	 * Big chunk of sequential IO workload can benefit from this way.
+	 */
+	if (!ret && iov_iter_count(iter) && bio->bi_bdev &&
+			bio_op(bio) != REQ_OP_ZONE_APPEND) {
+		unsigned trim = bio_align_with_io_size(bio);
+
+		if (trim)
+			iov_iter_revert(iter, trim);
+	}
+
 	return bio->bi_vcnt ? 0 : ret;
 }
 EXPORT_SYMBOL_GPL(bio_iov_iter_get_pages);
-- 
2.41.0


Received: from mail-il1-f231.google.com (mail-il1-f231.google.com [209.85.166.231])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF05934E751
	for <linux-block@vger.kernel.org>; Thu,  6 Nov 2025 17:17:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.231
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762449428; cv=none; b=alkXwRfmSPKNQGYxQaRROE3WhOYs47StETOvCFHynECXewIm8RZn+FECUFC+DCnkj3jv5n8bvIkJ1EhIfhvCmsAiT9kqU6CYoyB7nSUNTp6hd5aQ77iWRZqce/2SrKE0kSO2+A7r2kQkANnfpOTCxSjGQ52SFHdZ6WGpZpmXUQo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762449428; c=relaxed/simple;
	bh=OBV5Wvf7Pf20YICHZs8rawC+9onihr9HjuRkLnqfYV4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RzMj2EhaJiPCR+bTetwDhwGo89pkNeWiw0pjl/RLpNsRkSYxfyIiYV5hQPglTZQCracAT3FR/Ri8mS73+yO3NYGOH6956ZVQDouGxm3S/35yoGzbFwWR62MhmGyy2qPGkvNfhQ9q+3RB0hhaYEaNGl1BJvY7FXyAr7LvEnG+dXY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=Goh0CI3z; arc=none smtp.client-ip=209.85.166.231
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="Goh0CI3z"
Received: by mail-il1-f231.google.com with SMTP id e9e14a558f8ab-43346a2d9d7so549475ab.3
        for <linux-block@vger.kernel.org>; Thu, 06 Nov 2025 09:17:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1762449425; x=1763054225; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IB1zx0ug02eNzGM3pa1SYRczl09y5Mp94LC3eOoPIeo=;
        b=Goh0CI3zkM4IOSL9nJI4JIR2jxS6Y9YB0kE/V3bp0/Hge2nAsu0oi7R6ObzSqgp7y9
         uGuEfjvr5YGbjgKndGkW+yayIj9zVNBipblQf93xMh46pIZvCHX4LHfEx+OtAeg8lEWR
         5wtMmPksr2gmmqqrsKDCuraDwu+Rp/HFroSyTSn5SwgVaqPlBGi6PuiJtIWgnaw/3T8N
         HYB9mEzZbHG3jUPtJBlj3sClEDpm4P7VI0J8Dkd1H2Jy+nKrhgEF93SKo92JrM82/syZ
         7QDDY9oUGRq737Tj1vNL7LhWo65AgetWnXpEOySkQrKzj/+1SUjCkJ+12QRNMDmzaGQ6
         8OJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762449425; x=1763054225;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=IB1zx0ug02eNzGM3pa1SYRczl09y5Mp94LC3eOoPIeo=;
        b=L0FsUGzwkU/z3SJOtoqk1mfU5e8UlrgRbUbVYUi5BcrllIWw1DQwBHOjlXJQl4Gktm
         aPf9626nK1e614F01k0ubMoQCqR4R9e8fSt4l7bYyT1IERFumTRC2t2yLd8e9CH5mf7v
         u2WYEQJhki0tN3sgzfWgBuRyfPQVUF2+99UrmLd5hJgG2ue9RK8IwXgJ+2NOJsPBNWGK
         DSCrT66l5cv2Lf2jpPlJtd8QgrrcJwUVewP1irs3tFj+4l8gV0m6RFgW/z5OjYE5e7SL
         Bd1BVO4owUuMPtHjBk32ckMuRgD6y+MHh1b0y0mbfoV0W5t1JMdyWylB4wHKDJe9prin
         4VkQ==
X-Gm-Message-State: AOJu0YzY7VmYpUWMzL0QXk8Ss5DjgES2X9TVEpWBXmpJ0SF4FN4eQLEm
	Q54hvSIGlYJLDr/Tn0w5rK6kBYHJOX9E4/ZmQ8VEweXcgOXJfmWQlmOMHFZwH3531yDK/1lVvfK
	1bDpjhX9dSbg/lUWOveWCxR6vKittDNIVMxDO
X-Gm-Gg: ASbGncuz7qMvz7ak2/KDfWE1eceB7wKlKPPBbjj7e09BF3lwU14t7NlyAgMw9dDAcZQ
	ODSdhSHdS4G9CnTyM/+tf0u8iYG0uXoiZg0+x2o+HwHQlCs3PbkwFBkMywoe5OgnDaGwxIxw04R
	gUbm6jd9WMRx0W9PyzmEJA04M2ITkqvWS9lZ8lDNrGxrqtX/OtSWkt/mWFblLrvvY+X87dTtdAL
	jlwj/LyNdQbP7UrxL24yJqSq2FJVk+TmD2X1uvnr/r0TdC5+N+j55GT6sjSlHwnfuoV/Nogt3uz
	aH7OJ4aD69oRan7+ywKu+zGgYARYXrvuUlMkvPXwGhSw7uBmgvRZsJX6zWwDppRl+zSkUOquXnR
	WULJWj2rYerFQTzgKMxhLhddy7pGLa4U=
X-Google-Smtp-Source: AGHT+IE3SOPR3RvvTYbgxmQWXBVVJ3yDbMy/iZny5RZkVIcJY2XztktIO9465VGyzSGLf0729xvn39bTVg5V
X-Received: by 2002:a05:6e02:1d85:b0:433:5c6b:4b72 with SMTP id e9e14a558f8ab-4335f49a8c0mr835205ab.6.1762449425552;
        Thu, 06 Nov 2025 09:17:05 -0800 (PST)
Received: from c7-smtp-2023.dev.purestorage.com ([208.88.159.128])
        by smtp-relay.gmail.com with ESMTPS id e9e14a558f8ab-4334f4b46basm2221115ab.19.2025.11.06.09.17.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Nov 2025 09:17:05 -0800 (PST)
X-Relaying-Domain: purestorage.com
Received: from dev-csander.dev.purestorage.com (dev-csander.dev.purestorage.com [10.7.70.37])
	by c7-smtp-2023.dev.purestorage.com (Postfix) with ESMTP id 3C217340315;
	Thu,  6 Nov 2025 10:17:05 -0700 (MST)
Received: by dev-csander.dev.purestorage.com (Postfix, from userid 1557716354)
	id 3922EE401BC; Thu,  6 Nov 2025 10:17:05 -0700 (MST)
From: Caleb Sander Mateos <csander@purestorage.com>
To: Ming Lei <ming.lei@redhat.com>,
	Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Caleb Sander Mateos <csander@purestorage.com>
Subject: [PATCH v3 2/2] ublk: use rq_for_each_segment() for user copy
Date: Thu,  6 Nov 2025 10:16:47 -0700
Message-ID: <20251106171647.2590074-3-csander@purestorage.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20251106171647.2590074-1-csander@purestorage.com>
References: <20251106171647.2590074-1-csander@purestorage.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

ublk_advance_io_iter() and ublk_copy_io_pages() currently open-code the
iteration over the request's bvecs. Switch to the rq_for_each_segment()
macro provided by blk-mq to avoid reaching into the bio internals and
simplify the code.

Suggested-by: Ming Lei <ming.lei@redhat.com>
Signed-off-by: Caleb Sander Mateos <csander@purestorage.com>
---
 drivers/block/ublk_drv.c | 70 +++++++++++-----------------------------
 1 file changed, 19 insertions(+), 51 deletions(-)

diff --git a/drivers/block/ublk_drv.c b/drivers/block/ublk_drv.c
index 40eee3e15a4c..5cf288809226 100644
--- a/drivers/block/ublk_drv.c
+++ b/drivers/block/ublk_drv.c
@@ -911,26 +911,33 @@ static const struct block_device_operations ub_fops = {
 	.open =		ublk_open,
 	.free_disk =	ublk_free_disk,
 	.report_zones =	ublk_report_zones,
 };
 
-struct ublk_io_iter {
-	struct bio *bio;
-	struct bvec_iter iter;
-};
-
-/* return how many bytes are copied */
-static size_t ublk_copy_io_pages(struct ublk_io_iter *data,
-		struct iov_iter *uiter, int dir)
+/*
+ * Copy data between request pages and io_iter, and 'offset'
+ * is the start point of linear offset of request.
+ */
+static size_t ublk_copy_user_pages(const struct request *req,
+		unsigned offset, struct iov_iter *uiter, int dir)
 {
+	struct req_iterator iter;
+	struct bio_vec bv;
 	size_t done = 0;
 
-	for (;;) {
-		struct bio_vec bv = bio_iter_iovec(data->bio, data->iter);
-		void *bv_buf = bvec_kmap_local(&bv);
+	rq_for_each_segment(bv, req, iter) {
+		void *bv_buf;
 		size_t copied;
 
+		if (offset >= bv.bv_len) {
+			offset -= bv.bv_len;
+			continue;
+		}
+
+		bv.bv_offset += offset;
+		bv.bv_len -= offset;
+		bv_buf = bvec_kmap_local(&bv);
 		if (dir == ITER_DEST)
 			copied = copy_to_iter(bv_buf, bv.bv_len, uiter);
 		else
 			copied = copy_from_iter(bv_buf, bv.bv_len, uiter);
 
@@ -938,54 +945,15 @@ static size_t ublk_copy_io_pages(struct ublk_io_iter *data,
 
 		done += copied;
 		if (copied < bv.bv_len)
 			break;
 
-		/* advance bio */
-		bio_advance_iter_single(data->bio, &data->iter, copied);
-		if (!data->iter.bi_size) {
-			data->bio = data->bio->bi_next;
-			if (data->bio == NULL)
-				break;
-			data->iter = data->bio->bi_iter;
-		}
+		offset = 0;
 	}
 	return done;
 }
 
-static bool ublk_advance_io_iter(const struct request *req,
-		struct ublk_io_iter *iter, unsigned int offset)
-{
-	struct bio *bio = req->bio;
-
-	for_each_bio(bio) {
-		if (bio->bi_iter.bi_size > offset) {
-			iter->bio = bio;
-			iter->iter = bio->bi_iter;
-			bio_advance_iter(iter->bio, &iter->iter, offset);
-			return true;
-		}
-		offset -= bio->bi_iter.bi_size;
-	}
-	return false;
-}
-
-/*
- * Copy data between request pages and io_iter, and 'offset'
- * is the start point of linear offset of request.
- */
-static size_t ublk_copy_user_pages(const struct request *req,
-		unsigned offset, struct iov_iter *uiter, int dir)
-{
-	struct ublk_io_iter iter;
-
-	if (!ublk_advance_io_iter(req, &iter, offset))
-		return 0;
-
-	return ublk_copy_io_pages(&iter, uiter, dir);
-}
-
 static inline bool ublk_need_map_req(const struct request *req)
 {
 	return ublk_rq_has_data(req) && req_op(req) == REQ_OP_WRITE;
 }
 
-- 
2.45.2


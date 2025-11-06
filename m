Received: from mail-oa1-f104.google.com (mail-oa1-f104.google.com [209.85.160.104])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4866B34E755
	for <linux-block@vger.kernel.org>; Thu,  6 Nov 2025 17:17:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.104
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762449428; cv=none; b=suUC/MsZdEdCye629TGKc8MBMtENDlzEeZW49JWeKtRWuj/qsHGlG0hiv/tsj5Q4MxzKFO2lhYK9pxvLxzTKarbMHV6GL6eN+IpUEQZ/WQKxNUo48ZyhWi27X2j8CCH27p6soSw65O2N9Ho6voOykdboQHodClJXaQbqcLqpZP4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762449428; c=relaxed/simple;
	bh=wBafmD1PayfZCiZJCkVQ0+F0gMQwd6p1jXlMnZn5YmQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=incCivFAmb741E+mSGqhVI9BE2VRnkVtytaC0gPDqkzzfkiijVTsJBf9HLi7hzr9tqwn8at4+onMjr+dFJr6PzNHmt2MNi5kI9APlGKU1IQ8v6Rfz0V39drDY1KlfjXoDCvJBc9dIuf0bnL0cHdnWNDdP0ARZGJlg5/ekII5kPc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=S5NW2k5B; arc=none smtp.client-ip=209.85.160.104
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="S5NW2k5B"
Received: by mail-oa1-f104.google.com with SMTP id 586e51a60fabf-3c942034ccbso97696fac.3
        for <linux-block@vger.kernel.org>; Thu, 06 Nov 2025 09:17:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1762449425; x=1763054225; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+oSFiObM7RAEo/WrdtTuQmJtpLuHs/NBmatOtwNMwHs=;
        b=S5NW2k5BQTXtxHm1P0qt78yiYHxfPO1VFgrTS06j3vOALzVYEMfm55BbCEqKfRG/qi
         eeeWMXNkcQbGVQ+/iETnRuEpOClWahB+eEvFfHwPW/hL6vZ936djU+OOPf9ns+9WTxfo
         8p4Xi8yeesWtOFBCMqTZ7FDOV3twBpIBhoCaEeaBKqL8fPqhWVGKyTT4RZ8L//MG6W8k
         vhMG3gfzuf/uXzh+87kF6YvUiAGrSQjEhRoAxeAhssusUHnVhBWDb7lSL4xtIZ3blUlg
         ZaZR4R1B88Tkku2Awg1C5JmTyK9slAwdB7EaBkqJwxBa69hTRp8dZKkXJaWnkwBrytLG
         l2KQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762449425; x=1763054225;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=+oSFiObM7RAEo/WrdtTuQmJtpLuHs/NBmatOtwNMwHs=;
        b=mVqSbJ1GbY+j5UHNnZuM+cgkjDdAqMY7CdZqF8/bPTh+qrAHqaxAtn/AQ/BErf05W5
         eIO4Bpqe+Q0HDeBSWDjW8qHwzCfbJAFWBrNvahXXs+ZkI3N4UmEE6fLnDYIWYoWG6xO7
         kl9tIZPccPrXIUIHIJSml2i9N4jtkAm3nplM1n67frXpMPYo5hwEG0ranNQeVDc2ntTs
         OJtucD/+5MCuOvHF3jWuxQoXMpZeN84LvHtJJTBHfPqEmK0PO5zzUMBGYMi4BcG63KVd
         e/4rrUtTElanbwI+1/nCmaD1EnT67W2zsvbMv6Q0jfjpdWc105t7bthD7Jy6AdgUZNOo
         r40Q==
X-Gm-Message-State: AOJu0YyQ8sMzihn6EhP5GwP728pJaNQbBmg7omWFzNRtJfQav71VbP4X
	ahDStkBZ8ZwdDSMGw+uemfl4a7wSnMkSYoz79BQYBeODkmxb0RpXKzFtci7HrIMYzABmhP8y/p4
	s8iI/RL8xjDSswtvKf31VulEutxPATi+76Rie
X-Gm-Gg: ASbGnctKg8+ux2+so9QHae0CRL+r9CKSkWvPf0XOt8HsJX9+2c0RmWvMfLGfMT5f5OR
	oRzL7pAviOdrkW6CHMfvT37KjqpcSxa72pgEExt/h3KzqTGEKb+ynpLzQve89DKZrDSpO7oHHtV
	myLbSbqdVzDLQZ4Fm+lDZIhZNQ0PfcB6+wbV12+azsxX3OLRIhS8AvrGVP2N/vZ4Jqp1V4vrSRV
	UWGeBG83wE/qE8PupOoeW8VUxqs0dgGa6H82/cizkRWya6kVhhUVGmU4cJMVFxNgBm8vZZ85iCS
	jGlKomuxjw+0YaWDyKZX8McsSywRWEuQzbSobytCuhnptqkMFaMR1Ed7riysCkXbeFx4TBHltaA
	A8BdZqaSIX4foz6774lAuy7V7+NsXF4w=
X-Google-Smtp-Source: AGHT+IHVbMUymvX0FalFWXCotYOJ6nfVMyYq924TTcFbfvd6YhEKMWH5Rm8Y1TNKoPo+9ypajR5CPkvh41o+
X-Received: by 2002:a05:6830:924:b0:7c6:cf87:88ae with SMTP id 46e09a7af769-7c6efef3bd5mr164068a34.4.1762449425146;
        Thu, 06 Nov 2025 09:17:05 -0800 (PST)
Received: from c7-smtp-2023.dev.purestorage.com ([208.88.159.128])
        by smtp-relay.gmail.com with ESMTPS id 46e09a7af769-7c6f0f0f226sm9389a34.2.2025.11.06.09.17.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Nov 2025 09:17:05 -0800 (PST)
X-Relaying-Domain: purestorage.com
Received: from dev-csander.dev.purestorage.com (dev-csander.dev.purestorage.com [10.7.70.37])
	by c7-smtp-2023.dev.purestorage.com (Postfix) with ESMTP id 9C45D340410;
	Thu,  6 Nov 2025 10:17:04 -0700 (MST)
Received: by dev-csander.dev.purestorage.com (Postfix, from userid 1557716354)
	id 9817DE401BC; Thu,  6 Nov 2025 10:17:04 -0700 (MST)
From: Caleb Sander Mateos <csander@purestorage.com>
To: Ming Lei <ming.lei@redhat.com>,
	Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Caleb Sander Mateos <csander@purestorage.com>
Subject: [PATCH v3 1/2] ublk: use copy_{to,from}_iter() for user copy
Date: Thu,  6 Nov 2025 10:16:46 -0700
Message-ID: <20251106171647.2590074-2-csander@purestorage.com>
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

ublk_copy_user_pages()/ublk_copy_io_pages() currently uses
iov_iter_get_pages2() to extract the pages from the iov_iter and
memcpy()s between the bvec_iter and the iov_iter's pages one at a time.
Switch to using copy_to_iter()/copy_from_iter() instead. This avoids the
user page reference count increments and decrements and needing to split
the memcpy() at user page boundaries. It also simplifies the code
considerably.
Ming reports a 40% throughput improvement when issuing I/O to the
selftests null ublk server with zero-copy disabled.

Signed-off-by: Caleb Sander Mateos <csander@purestorage.com>
Reviewed-by: Ming Lei <ming.lei@redhat.com>
---
 drivers/block/ublk_drv.c | 62 +++++++++-------------------------------
 1 file changed, 14 insertions(+), 48 deletions(-)

diff --git a/drivers/block/ublk_drv.c b/drivers/block/ublk_drv.c
index 97cc4bc0a6ce..40eee3e15a4c 100644
--- a/drivers/block/ublk_drv.c
+++ b/drivers/block/ublk_drv.c
@@ -911,58 +911,47 @@ static const struct block_device_operations ub_fops = {
 	.open =		ublk_open,
 	.free_disk =	ublk_free_disk,
 	.report_zones =	ublk_report_zones,
 };
 
-#define UBLK_MAX_PIN_PAGES	32
-
 struct ublk_io_iter {
-	struct page *pages[UBLK_MAX_PIN_PAGES];
 	struct bio *bio;
 	struct bvec_iter iter;
 };
 
-/* return how many pages are copied */
-static void ublk_copy_io_pages(struct ublk_io_iter *data,
-		size_t total, size_t pg_off, int dir)
+/* return how many bytes are copied */
+static size_t ublk_copy_io_pages(struct ublk_io_iter *data,
+		struct iov_iter *uiter, int dir)
 {
-	unsigned done = 0;
-	unsigned pg_idx = 0;
+	size_t done = 0;
 
-	while (done < total) {
+	for (;;) {
 		struct bio_vec bv = bio_iter_iovec(data->bio, data->iter);
-		unsigned int bytes = min3(bv.bv_len, (unsigned)total - done,
-				(unsigned)(PAGE_SIZE - pg_off));
 		void *bv_buf = bvec_kmap_local(&bv);
-		void *pg_buf = kmap_local_page(data->pages[pg_idx]);
+		size_t copied;
 
 		if (dir == ITER_DEST)
-			memcpy(pg_buf + pg_off, bv_buf, bytes);
+			copied = copy_to_iter(bv_buf, bv.bv_len, uiter);
 		else
-			memcpy(bv_buf, pg_buf + pg_off, bytes);
+			copied = copy_from_iter(bv_buf, bv.bv_len, uiter);
 
-		kunmap_local(pg_buf);
 		kunmap_local(bv_buf);
 
-		/* advance page array */
-		pg_off += bytes;
-		if (pg_off == PAGE_SIZE) {
-			pg_idx += 1;
-			pg_off = 0;
-		}
-
-		done += bytes;
+		done += copied;
+		if (copied < bv.bv_len)
+			break;
 
 		/* advance bio */
-		bio_advance_iter_single(data->bio, &data->iter, bytes);
+		bio_advance_iter_single(data->bio, &data->iter, copied);
 		if (!data->iter.bi_size) {
 			data->bio = data->bio->bi_next;
 			if (data->bio == NULL)
 				break;
 			data->iter = data->bio->bi_iter;
 		}
 	}
+	return done;
 }
 
 static bool ublk_advance_io_iter(const struct request *req,
 		struct ublk_io_iter *iter, unsigned int offset)
 {
@@ -986,38 +975,15 @@ static bool ublk_advance_io_iter(const struct request *req,
  */
 static size_t ublk_copy_user_pages(const struct request *req,
 		unsigned offset, struct iov_iter *uiter, int dir)
 {
 	struct ublk_io_iter iter;
-	size_t done = 0;
 
 	if (!ublk_advance_io_iter(req, &iter, offset))
 		return 0;
 
-	while (iov_iter_count(uiter) && iter.bio) {
-		unsigned nr_pages;
-		ssize_t len;
-		size_t off;
-		int i;
-
-		len = iov_iter_get_pages2(uiter, iter.pages,
-				iov_iter_count(uiter),
-				UBLK_MAX_PIN_PAGES, &off);
-		if (len <= 0)
-			return done;
-
-		ublk_copy_io_pages(&iter, len, off, dir);
-		nr_pages = DIV_ROUND_UP(len + off, PAGE_SIZE);
-		for (i = 0; i < nr_pages; i++) {
-			if (dir == ITER_DEST)
-				set_page_dirty(iter.pages[i]);
-			put_page(iter.pages[i]);
-		}
-		done += len;
-	}
-
-	return done;
+	return ublk_copy_io_pages(&iter, uiter, dir);
 }
 
 static inline bool ublk_need_map_req(const struct request *req)
 {
 	return ublk_rq_has_data(req) && req_op(req) == REQ_OP_WRITE;
-- 
2.45.2


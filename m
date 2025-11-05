Received: from mail-wm1-f101.google.com (mail-wm1-f101.google.com [209.85.128.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 311E330CDB9
	for <linux-block@vger.kernel.org>; Wed,  5 Nov 2025 20:28:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762374516; cv=none; b=WMD3zSlRv+vJsXV946nEu2G8JvTvYAamximFUT+GCvRCGiuil65Wv/7tPNzsNPubyFCrQp+UTK3cHQ4Y9K4Pwb+lDwu8HOVDwGEvsNV0WcCJ83zxlzQhgrr2Y5j3vKnxkcrncHzifk6IXYrpLQc0Slk3lCR5mmNWM22kAYZyKNg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762374516; c=relaxed/simple;
	bh=y7cph3TN+LG3pXaIQbG7EKhMI9WouvmH01KqS9mjU2M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GMwLHk3e7mGfW6M+sgWX7dskihQjPUNcFpd2JkMuJdSgSmQjkVi+Nc+ZskKX8F7Dr9jamlrbRNaTHj8nn1vBMEcAEUKbl7Xi/1DAfFvMO6EAyz+vhq6AbwL7Y62GO7Y3HwFHjbEZVBevR9LaI48SRKvdPAxBxKVYoZpj8THl/Nw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=TFoQ0lgY; arc=none smtp.client-ip=209.85.128.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="TFoQ0lgY"
Received: by mail-wm1-f101.google.com with SMTP id 5b1f17b1804b1-472cbd003feso38735e9.3
        for <linux-block@vger.kernel.org>; Wed, 05 Nov 2025 12:28:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1762374512; x=1762979312; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jvk9JvTk/zngD9H7iDECFvgJx6bX0wcaTFOZurY55Sw=;
        b=TFoQ0lgYJykNJISZ9sT4UT90UfWRTplZwC3cnwhTeJWkauqvO+NLuQoDIdCtfIP9/p
         BkpEm9aGa3z8MSRmDVeF+zcvPvV+iVBfRFOp0rdkiItA4jV3p3A4suX4BQ/CkJzv6Ddl
         CnY3OgJkIrKugsryQEEBkBbBI+5N684MiO6A1egdUmeaGTE24HBCZlJU22HmIr1zAqow
         22qUCchQwyqnc1p0QJ2dt4DpujpbXqEP8QM3t7VUBLNrWDYjjIzukMLF4ITLU5TbFDXj
         CFap2CUFMO/RRuYm8k/JVCMXWbDsJPxfT062YW6Jr/0320BrrfyRHlbNpdkdoO0Fiqp3
         OF3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762374512; x=1762979312;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jvk9JvTk/zngD9H7iDECFvgJx6bX0wcaTFOZurY55Sw=;
        b=doN4Gdp10+KaSzIjKNWa6K2qKzfKjXg62J7vN1NCZMZ/rCVf2SANMojnMn3O95iy6a
         B6RoYFfUdkZVNzrBmddHOGNdhZ0pC16ufCY/lnrsxr4mR3shrc1yzvwbblDIID/ROn98
         xGBgByJRtlJ3uEc4+8Z0RgE+hv4DRsI6XtWFOaOwSZsDW+DhQNuv30tshqAms9DIrHSC
         y3LfGilj3SYvzRoTnSDwyNdlb4xQwYz1vMzj6hcWhhhGBJ5q5du7hCkxc0uq3k363Nk5
         FUpkSFLcPTSEqUOURwKUi5hcWR69IgrEdDsIS7PpFWTDjxU4GxagmkTD3S+qE0LkgNJm
         T3FA==
X-Gm-Message-State: AOJu0YzEgZ3LPUJcRA1dfP1C87TDV335bzu7JSvSj1ZKfAucoVZWGM3t
	ZvdLmevNPwD+09c+AALfli3OkNDm9pXIHM9bnDs0UjjIZSccb7SqVz1Vr4vkVIAOJJDoUo1VmV8
	X64BrDFRx/vU1Gn8w77J3vL1KRtFFdLK7CjdILxnkoo2kCrBkub1V
X-Gm-Gg: ASbGncsgGyoMt9HSKVRb3zqemw8DvOzeSjfYCU0JH3t7PsjnA3FFT0ZeGsRG27NClOv
	JGKpImYUwfnJRhLY88aCz0vKlFWEQhXSBvKfjgnoXM1/TuUoYXthrUn6C7YsOHvqnnopv8+zqfI
	2YInA7UElosd2zfqk0Pp7lAUCTljw3YQlwsx75FYBuMocGVehJDm4ZgWdTCJwCPbL1m3Ax1Nw7A
	ja7J1YXxvx9RC6wBGwW6sHORC5Q484GgvH+DjWW4VNBLwhhNym5uDdiB79IfGM07MraYjye7SXj
	avc/4U9BDOxIJ7HFOBnxwT4VonKqHKwcVYkRK27A+sJ38h8mwNFzF+aAeLgBYeAXsLHUIcnw7lf
	Py0zjOIzVMIjvGKFs
X-Google-Smtp-Source: AGHT+IE4XWhmeoD7+ZfhKtJxniWegM5tVl5BSUxfYAckBqExLj8aQDOpGX57QEZndaxwC4e8NdZt+dAGIElM
X-Received: by 2002:a05:600c:358d:b0:477:598d:65e7 with SMTP id 5b1f17b1804b1-4775ce1e88emr25079535e9.4.1762374512322;
        Wed, 05 Nov 2025 12:28:32 -0800 (PST)
Received: from c7-smtp-2023.dev.purestorage.com ([2620:125:9017:12:36:3:5:0])
        by smtp-relay.gmail.com with ESMTPS id ffacd0b85a97d-429eb435628sm24245f8f.21.2025.11.05.12.28.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Nov 2025 12:28:32 -0800 (PST)
X-Relaying-Domain: purestorage.com
Received: from dev-csander.dev.purestorage.com (unknown [IPv6:2620:125:9007:640:ffff::1199])
	by c7-smtp-2023.dev.purestorage.com (Postfix) with ESMTP id 5F136340505;
	Wed,  5 Nov 2025 13:28:30 -0700 (MST)
Received: by dev-csander.dev.purestorage.com (Postfix, from userid 1557716354)
	id 7F1B1E413BB; Wed,  5 Nov 2025 13:28:30 -0700 (MST)
From: Caleb Sander Mateos <csander@purestorage.com>
To: Ming Lei <ming.lei@redhat.com>,
	Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Caleb Sander Mateos <csander@purestorage.com>
Subject: [PATCH v2 1/2] ublk: use copy_{to,from}_iter() for user copy
Date: Wed,  5 Nov 2025 13:28:22 -0700
Message-ID: <20251105202823.2198194-2-csander@purestorage.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20251105202823.2198194-1-csander@purestorage.com>
References: <20251105202823.2198194-1-csander@purestorage.com>
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


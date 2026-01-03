Received: from mail-pl1-f228.google.com (mail-pl1-f228.google.com [209.85.214.228])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3487F1EDA2C
	for <linux-block@vger.kernel.org>; Sat,  3 Jan 2026 00:45:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.228
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767401136; cv=none; b=BvGT+r5qptQeb0wAAB5LcB8XXgO51a/KacMZ3Bifb8pCPqfO12xcfC1FT8+XIyfhn27BmDnYM+CdgoEM5f9veixqEwL8eeruVuclyHPVGbsdkaAohJYKBxr1OhrjARoHY0BnLgbHFCcqv5FINjfeDv0lHQYqLbTkQxJR0LVldD0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767401136; c=relaxed/simple;
	bh=RgRQXPGgkBOFh+I3IU1dh10q8VHov+arOD4uOXzU9rg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=p2xuzhueNUYhtTrUkJkmTEOeoOrjo1BhGWq/NBQvS6QoJzCKW2TITSBAbbBBZ9l4aYH/h0x03globAf3SYfeDlTh1PsdWRFCrUdCiKQTWKpi6Z5F/LUnu5uTEX/QIa8qcqqfR6sD+7Xu8hwe5rPoeismr2L4uEK6iGtqKa4hJGA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=WpOtjxt4; arc=none smtp.client-ip=209.85.214.228
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="WpOtjxt4"
Received: by mail-pl1-f228.google.com with SMTP id d9443c01a7336-2a08c65fceeso24837355ad.2
        for <linux-block@vger.kernel.org>; Fri, 02 Jan 2026 16:45:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1767401133; x=1768005933; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=czj0Xu0INr5Vy2ifFNe60pRb7rtoAzjqp2XCOa9c0II=;
        b=WpOtjxt4tfrrotLRrvuCFONjo1IQG5bmSH8zbWvvOji5XxHUmTzYDDPE854qVYAb22
         hHhE0zcxYOrn1IcuW2TPhUn+p3PMFEN9yqc3J40u4ojecoIj1iwVn2khIVPBxD4s3Aq4
         pEHem79pQ+ENPGH5mSwt30RvcFcutwFI52wwxePrIU472inoknlMZKycSW7ZixykkkTv
         mxlFx0QFmDyMf7wXr2qvp5Vtv0dhwXFVIdTLC9psUTS5qsHNa1ji7YsCF+SQRnmG/GPn
         nCaNJA3E7+wzrcVBM9pYEGv/Q6pJKQxcfH2BSCQt1fJchb+6ma8aYzCvuH3IyHGxSzT7
         tRPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767401133; x=1768005933;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=czj0Xu0INr5Vy2ifFNe60pRb7rtoAzjqp2XCOa9c0II=;
        b=J86hRBwevWgsoAEOvEvU7iKr3KGH9/Djal79I5U4Pr79j8e7qaKrNd14xOhwB4wwSo
         QIdm6iSSNLucwIb6DfFirKKGG7tZCGdGob19ugYOjjrtfoKe64Z3C8jUYgYr5hNROJu2
         Mm9SJWxJvedh6+0DfYdk57+unT1HPjiVQLPT1nw6AHhVJbPWk7YZD/A89TZsigydQZ08
         y3cqlgpFkR9uN19SoEqGgZaFq+AraSXhsWWFDm4Zfqe9nMQDCRQGnXgpGUbq9LLWAAsL
         bok2uWyPE6HuXpna0IGhF466BLZQDhimF9yDHkkCdhr8Na76QnPr5/phkKflOoPkfSEJ
         ZxsQ==
X-Gm-Message-State: AOJu0Yy4/n6YB81Vw9uOUNYZKK7NI1PmLchckM8Ki2SoA00aWgOkeHNo
	ggF1UDr7MdUH4pnugQJ1Bm7iA7/a7sQfcU2goOKAYcbcRSnWmNkl9guez2tWwcJM34uBvw+nd6W
	t+gC58oh60SFlHCFLUWBBEcIiFikqhOPhs1Zn
X-Gm-Gg: AY/fxX4/1UYvXwgWx0I9ORu78fpJAiUeC7N5tUyeV4lnGTVbdvTeQbzd3QXHmh1oNcs
	u75Mr5UpQLUgnIQT4Huf/Ihce8BAB00t7B4LmcWUbZnbu/CdG0RMQOHIDCdJJK070+8mDOQWpyW
	+Nu9C0wLzNmN4FlldUwBeQA8wGnlnHW+asJdNbL5qubqUVLuvrseFtMOBJrw6WbRNhTUZ7mUFoC
	g0e+NUiEozFmeASveloDjozlT5gVFSsgJMblimJdV+Is1YtMrbhSsc7g+6AW2VT7fWqZG4l9j3j
	BPxfPqQtAuoDNUlO9QB8YXdHtOtVjJXfsfyln6up+7eAZonobHPulo1pFdpeXsOTU2v0J9/sxHP
	I57m/jxzXEPFb/+A7CP6H3oe/KxDqlHo4MGsAVUouRA==
X-Google-Smtp-Source: AGHT+IEzI2YDnQAtUpCUAyA6e8pluyG9Ja7Ny0SdrKIl/+tDZsFmLNITLlBY3bzENXifGoIeFNQS6g468aAz
X-Received: by 2002:a05:7022:264a:b0:11b:862d:8031 with SMTP id a92af1059eb24-121721380fcmr16129506c88.0.1767401133187;
        Fri, 02 Jan 2026 16:45:33 -0800 (PST)
Received: from c7-smtp-2023.dev.purestorage.com ([208.88.159.129])
        by smtp-relay.gmail.com with ESMTPS id a92af1059eb24-1217253e933sm9026569c88.8.2026.01.02.16.45.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Jan 2026 16:45:33 -0800 (PST)
X-Relaying-Domain: purestorage.com
Received: from dev-csander.dev.purestorage.com (dev-csander.dev.purestorage.com [10.49.34.222])
	by c7-smtp-2023.dev.purestorage.com (Postfix) with ESMTP id B920C3402DF;
	Fri,  2 Jan 2026 17:45:32 -0700 (MST)
Received: by dev-csander.dev.purestorage.com (Postfix, from userid 1557716354)
	id B47DAE4426F; Fri,  2 Jan 2026 17:45:32 -0700 (MST)
From: Caleb Sander Mateos <csander@purestorage.com>
To: Ming Lei <ming.lei@redhat.com>,
	Jens Axboe <axboe@kernel.dk>,
	Shuah Khan <shuah@kernel.org>
Cc: linux-block@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Stanley Zhang <stazhang@purestorage.com>,
	Uday Shankar <ushankar@purestorage.com>,
	Caleb Sander Mateos <csander@purestorage.com>
Subject: [PATCH v2 05/19] ublk: add ublk_copy_user_bvec() helper
Date: Fri,  2 Jan 2026 17:45:15 -0700
Message-ID: <20260103004529.1582405-6-csander@purestorage.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20260103004529.1582405-1-csander@purestorage.com>
References: <20260103004529.1582405-1-csander@purestorage.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Factor a helper function ublk_copy_user_bvec() out of
ublk_copy_user_pages(). It will be used for copying integrity data too.

Signed-off-by: Caleb Sander Mateos <csander@purestorage.com>
---
 drivers/block/ublk_drv.c | 52 +++++++++++++++++++++++-----------------
 1 file changed, 30 insertions(+), 22 deletions(-)

diff --git a/drivers/block/ublk_drv.c b/drivers/block/ublk_drv.c
index 51469e0627ff..811a125a5b04 100644
--- a/drivers/block/ublk_drv.c
+++ b/drivers/block/ublk_drv.c
@@ -1025,10 +1025,39 @@ static const struct block_device_operations ub_fops = {
 	.open =		ublk_open,
 	.free_disk =	ublk_free_disk,
 	.report_zones =	ublk_report_zones,
 };
 
+static bool ublk_copy_user_bvec(const struct bio_vec *bv, unsigned *offset,
+				struct iov_iter *uiter, int dir, size_t *done)
+{
+	unsigned len;
+	void *bv_buf;
+	size_t copied;
+
+	if (*offset >= bv->bv_len) {
+		*offset -= bv->bv_len;
+		return true;
+	}
+
+	len = bv->bv_len - *offset;
+	bv_buf = kmap_local_page(bv->bv_page) + bv->bv_offset + *offset;
+	if (dir == ITER_DEST)
+		copied = copy_to_iter(bv_buf, len, uiter);
+	else
+		copied = copy_from_iter(bv_buf, len, uiter);
+
+	kunmap_local(bv_buf);
+
+	*done += copied;
+	if (copied < len)
+		return false;
+
+	*offset = 0;
+	return true;
+}
+
 /*
  * Copy data between request pages and io_iter, and 'offset'
  * is the start point of linear offset of request.
  */
 static size_t ublk_copy_user_pages(const struct request *req,
@@ -1037,33 +1066,12 @@ static size_t ublk_copy_user_pages(const struct request *req,
 	struct req_iterator iter;
 	struct bio_vec bv;
 	size_t done = 0;
 
 	rq_for_each_segment(bv, req, iter) {
-		unsigned len;
-		void *bv_buf;
-		size_t copied;
-
-		if (offset >= bv.bv_len) {
-			offset -= bv.bv_len;
-			continue;
-		}
-
-		len = bv.bv_len - offset;
-		bv_buf = kmap_local_page(bv.bv_page) + bv.bv_offset + offset;
-		if (dir == ITER_DEST)
-			copied = copy_to_iter(bv_buf, len, uiter);
-		else
-			copied = copy_from_iter(bv_buf, len, uiter);
-
-		kunmap_local(bv_buf);
-
-		done += copied;
-		if (copied < len)
+		if (!ublk_copy_user_bvec(&bv, &offset, uiter, dir, &done))
 			break;
-
-		offset = 0;
 	}
 	return done;
 }
 
 static inline bool ublk_need_map_req(const struct request *req)
-- 
2.45.2


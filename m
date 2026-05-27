Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE5472949E0
	for <linux-block@vger.kernel.org>; Wed, 27 May 2026 04:49:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779857377; cv=none; b=fxOT4gZRtArR+kmYowmQzmiWFZz+kmVGLAs4/9Nsf2omOu56Vawqcbf7D58OA/YbEqANKJY4T89M7EzGPdzYnBARLTpDj3JDgaVeC+iAzu+Z8WaNVP6AhLRzOrKiZiL9D17mwJPAvy32BYgONHv9AcVAn0u8kLI1TdL5uLzzXEM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779857377; c=relaxed/simple;
	bh=wWeEghQAe5NXkXvNqKfo8YuljpN08ui3FSM1U5zjH2s=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=tvMfQhQr9v3/31VqpHOQ9IdGnfYe2dklZINhCZfK2RY0KFchlTUF3oY4cszNOvd+BfMPuMUkW90UOHAwhqP9We6NJ6VxVqc7/T0r//OcucA4iJLoET162Hkfhv3hlRywFUMujE+mRHZYdicrcy6QIEV9TEWFJDkU/XoKvcAg5ss=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=oYmN9KAc; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oYmN9KAc"
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-2bccb978bd9so69481785ad.0
        for <linux-block@vger.kernel.org>; Tue, 26 May 2026 21:49:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779857375; x=1780462175; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ksx7IvMYJ9ZmDJ5vSxSBhghEVgteTDF7e1+UXliPhXE=;
        b=oYmN9KAco9y0jI+d1iIxLi+hYplj66NwbmkF9+luWbR1ZC4R2BCZcbhJ5xhVXNBhVG
         0QxdhbnRDrn7EqG+PPWFYTwDm/BtrC2WOgCrUKbHNLa1NZJ7JQ6dSzrFeBpjBvIybV2t
         SioxPYsgVBZMelTbpl3+A6VD1trz4FtUsfmO7Ei7wWSE6jDQT3E1twEUMO1dGHO0FyGf
         M7t97HMuf74UaIFIjXbUaQaqSuDwwrmc00RjPT5EqCf2gjLw7ELV18I8vUF0KUr2NVgG
         DwQZVnf7HqNfoC/9MUZYiKd3VZKGc32rN3DfZ/+kPnKJlxBx6GWSe5AsgUw+/iy+nhkM
         ZobA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779857375; x=1780462175;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=ksx7IvMYJ9ZmDJ5vSxSBhghEVgteTDF7e1+UXliPhXE=;
        b=AoZMF/h+m3E7gMOI6RAEdYsoIen7QU59CAWPwdAdJKLJRyfbHhqWX6BPb/TlLKuleb
         gLWLahcY5FvcpJ6GESmk2f4XIjvJv1Pqd37o7AyierPcmNPVP9zvQ0Yeupaci/bFPc5V
         OL8Aj4f6tJ5lQtPbWmr68qGU0xIE7gsqhq8WEKkfuPyPawbS69JNYwm6hMKNqmBADL8t
         U0XOWowcOLHJFAJrg5oePY3TTcinlpDnEDarZEnf20zN5z62O4AhZDyqXlMKAnGFJM6w
         Zm4RN7YAeY/lbektLG5Z2BMkP92SuU78JZm48CEIZFlD3cCa627r9Vw7Hl+lphSDw4KN
         ZCqg==
X-Forwarded-Encrypted: i=1; AFNElJ9xZkG7A+teIfMGGX3JVGVfoLare0GUaEzdsF+wR3oF94OxxufCHHoPT5eAfxvzyTrVGOFMQSKZFYjt8w==@vger.kernel.org
X-Gm-Message-State: AOJu0Yw80X6v7sN6T4mzjoo7sFf8xQpMndHl9TG5hueU+iUwKZCcCJZo
	DlFJ5RVB1XlF7oMzSa+9vbcUjjY3vRkMWpu6g5snlQSuf4b/3vN/IvsXZPYmTyTn
X-Gm-Gg: Acq92OEIeZbB+E8y7WJZ0hLAnxzADjrjmdtZC1S/dv3mFonyDAzidxqBtUQ2Dem1Mno
	q1zerr1TmhjfkwvCOtVjg4zaqr4BBM8Xj0WyUAG1b1mWMunTZai70+rUhwC7i42LDOCp9q+8Oo1
	WkYHm39ckMUYjYjxY6asm7acIGyAFcKzNKwFpNZWqgCRGjlSb4WlC9DwmN+zxdchwIKMAkSxKJY
	U6Lhur951aiv3xAqpxfF+69u9MxEzVvjoXKcU6YAzvPZS6h3kkERrUVoV7xynYz6y43uEHfA7Kx
	y0LUi+u1w3oa+wqmJQsc88Osr62nw07N2gzJ2+IEQD/AkpOkQGLFtEP2MyuAVxZZDSBF54ECJ6T
	SrbPNOzd7Iys+OOHZqAWFpEecRgTC4Nlizl2W7aER97GYt1bBn5yA77zJPh8iu5cGko8mYCKrWD
	P/BbzAwrFgiVDFEwmb8ruKg99bq5lWE9/Ngw==
X-Received: by 2002:a17:902:e88b:b0:2bc:dc1c:438e with SMTP id d9443c01a7336-2bea22202cdmr238827805ad.11.1779857375174;
        Tue, 26 May 2026 21:49:35 -0700 (PDT)
Received: from [127.0.0.1] ([116.80.91.208])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2beb58dba7bsm135704105ad.66.2026.05.26.21.49.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 May 2026 21:49:34 -0700 (PDT)
From: Cunlong Li <shenxiaogll@gmail.com>
Date: Wed, 27 May 2026 12:49:25 +0800
Subject: [PATCH v2 2/2] zram: drop unused bio parameter from write helpers
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260527-zram-v2-2-2fb84b054b5c@gmail.com>
References: <20260527-zram-v2-0-2fb84b054b5c@gmail.com>
In-Reply-To: <20260527-zram-v2-0-2fb84b054b5c@gmail.com>
To: Minchan Kim <minchan@kernel.org>, 
 Sergey Senozhatsky <senozhatsky@chromium.org>, Jens Axboe <axboe@kernel.dk>, 
 Andrew Morton <akpm@linux-foundation.org>
Cc: Christoph Hellwig <hch@lst.de>, linux-block@vger.kernel.org, 
 linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
 Cunlong Li <shenxiaogll@gmail.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1779857366; l=1967;
 i=shenxiaogll@gmail.com; s=20260517; h=from:subject:message-id;
 bh=wWeEghQAe5NXkXvNqKfo8YuljpN08ui3FSM1U5zjH2s=;
 b=p1wzwgJ3gwvvVn04ePPF6uh4LDB/aFn6+9vSP6I90FUu4ui1uDqy8TlmNZy2nWAdU2iw4W1Ky
 Jfp1gcsQY9vA3sSfO0yTYLUEuIiWUpg0W6toLaFhTRFvUW+rMPu1R3x
X-Developer-Key: i=shenxiaogll@gmail.com; a=ed25519;
 pk=SKFifnqPdsvsjuhUiq+Y9vtCdhyZ/LrRcfYn8eRq6AE=

After the previous fix, zram_bvec_write_partial() always passes NULL
to zram_read_page() and no longer needs the parent bio.  Mirror the
read side (zram_bvec_read_partial() has not taken a bio since commit
4e3c87b9421d ("zram: fix synchronous reads")) and drop the parameter
from zram_bvec_write_partial() and zram_bvec_write().

No functional change.

Signed-off-by: Cunlong Li <shenxiaogll@gmail.com>
---
 drivers/block/zram/zram_drv.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/block/zram/zram_drv.c b/drivers/block/zram/zram_drv.c
index b23a8bbb687c..66347915a2cc 100644
--- a/drivers/block/zram/zram_drv.c
+++ b/drivers/block/zram/zram_drv.c
@@ -2325,7 +2325,7 @@ static int zram_write_page(struct zram *zram, struct page *page, u32 index)
  * This is a partial IO. Read the full page before writing the changes.
  */
 static int zram_bvec_write_partial(struct zram *zram, struct bio_vec *bvec,
-				   u32 index, int offset, struct bio *bio)
+				   u32 index, int offset)
 {
 	struct page *page = alloc_page(GFP_NOIO);
 	int ret;
@@ -2343,10 +2343,10 @@ static int zram_bvec_write_partial(struct zram *zram, struct bio_vec *bvec,
 }
 
 static int zram_bvec_write(struct zram *zram, struct bio_vec *bvec,
-			   u32 index, int offset, struct bio *bio)
+			   u32 index, int offset)
 {
 	if (is_partial_io(bvec))
-		return zram_bvec_write_partial(zram, bvec, index, offset, bio);
+		return zram_bvec_write_partial(zram, bvec, index, offset);
 	return zram_write_page(zram, bvec->bv_page, index);
 }
 
@@ -2743,7 +2743,7 @@ static void zram_bio_write(struct zram *zram, struct bio *bio)
 
 		bv.bv_len = min_t(u32, bv.bv_len, PAGE_SIZE - offset);
 
-		if (zram_bvec_write(zram, &bv, index, offset, bio) < 0) {
+		if (zram_bvec_write(zram, &bv, index, offset) < 0) {
 			atomic64_inc(&zram->stats.failed_writes);
 			bio->bi_status = BLK_STS_IOERR;
 			break;

-- 
2.30.2


Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46EA421D3E4
	for <linux-block@vger.kernel.org>; Sun, 15 Mar 2026 17:09:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773594544; cv=none; b=g3I65BfQuCySYnaRRANoBz8jt6CtSzD7hBgjPBV1W+PxqwrxyWrSGiK/EVIzU+LwcdjKf9BGrHL7hiPqRxoPCD+5uSHMFrlk7zez4bYG+vOu+U3TtKT8ryEqFSihIKF8ii7hNQ52wbTyzkbhPnzrGKzDubbNVPiqr80IgSI9xy0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773594544; c=relaxed/simple;
	bh=Zd/yIir7WuWtKgHm5JFcyIWY6SLsFUgIOacxHmWO+G0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=X4hm9oL8xFZOg/rpMeudumZ/XqTziPbVVifTMFBh4SFFK5wkiznP9iKM04yhCeQclNgE259bJ0rbJYfAr7N6Hj0JmSM7g6NOfqwYKzjiJ+TPBzUA9hQfE7Nbp0j1jmxKt26l6vtehgINe7rScAzYE4G1oAEV9XRXakbuZA/073g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FQDZ2L8k; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FQDZ2L8k"
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-4852e9ca034so34333565e9.2
        for <linux-block@vger.kernel.org>; Sun, 15 Mar 2026 10:09:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773594542; x=1774199342; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=eddOQ8NKTvmZfl+PDr+OCxcWOuafPTZ0v2Dm+b9uti8=;
        b=FQDZ2L8k7mqR8aOCwTC7Ljol5DpnW+wtGAgeK9tO0JleB71GAX2RwgrnpNBgFpYaNL
         TC+icV53x6RAIT/gYYPNgoCaXno5lAW13lRmSfGqAvd90/yB0Tv+X6JujEMzZHglqxF+
         Roa3HYVkSHrl7NH6f+7+zDYcURWlTVYLjQHDLpRCuYLMOAurGJhy6nJElvpwDBspRWb+
         AfQPfHgA5A6eQ86SkgEvZ+lY4xL99szW2U5TyKSA1BrCdkxqXESTBE4H8CDO4c26TALo
         o5CmrZ/mWdxKZLvbEf7owMmBZ1gB9ncDyA6l2nufbIxyX7/VnnDOOAlAg9pG2znv6Lsb
         jnCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773594542; x=1774199342;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eddOQ8NKTvmZfl+PDr+OCxcWOuafPTZ0v2Dm+b9uti8=;
        b=gcn4DgkENUk9KpDDKs+t0HHanZA/jR+ce0936lwotYIwFW6t3jEaXEkdKt9zbNLGqF
         OcStqw07dxPQSxXsJCBfxDbWkONkkFQFI4YcdYxbjkaM97TikBoe5EC0hywsl9Df5MNj
         PPUv3wDDpBQ8Yyr4tqUtgEh49DSxQBLs8c7MRIZi5x1DXi7euvyBPALvc67EK9GgB3k2
         3zquIfsqQtWVlF6RT8boMlCBIeOsqJP6MiFJWjnnwZowe7D23i5lDxKx3JiXiYraMnPe
         sgOJF0/eZ2s5W2BfPL40954+XSQdEGBY19Mc8UR3TlK3W6/b0fZtrM+aRGLgiD0K6gfH
         TEfg==
X-Gm-Message-State: AOJu0YzlxJDoe+NuX72ukmYFzJx6jrVDNm0Xv7leaameBMMtQt689s5I
	dJ3htVysejFxBa4EBitulOpv3JqxggTWGT4zLOfER7Yv0K746TCtwWJhMGb1C3ARF+Q=
X-Gm-Gg: ATEYQzwG6BoGeSfG/1cs4zpzP5j4G4TYqiQhSl+O/cmwK39g9nzuiZJOcvPko7YbLKf
	n6mtn5J9WKPBxzo9vx/AyYln8UNyZ/dy83v7hl/fKTTTjMiw0HJ/8UdwlWKGLXpLmwW7rnv47YI
	jRRi9CuvOlxjZtAXdswskxPSwRzMCA/6Sa+upbrkufHA8gC7vsHdY8SGRglCqvO9DbjliBiCqk8
	DJmkaIYuHmUJq1xXkPd83UO7W9zylFur/vg0UVdFp+rOla5F/VOn7TN5DzzoDkiD8QSTYiUxamf
	fGuf5QIfEYchr2W4BOHYZ7fqP5fuhChhWcPe/Sih72ozv93BzJuiJ7ire8w90HcJ/+mHJW4Nh6s
	xqLrxVyoxnKYsRj36GAuWNlNDWhtntqqlVXUTZedonZO7CGcA1hI2Y7hYCdwEzEwYkLekdIjVTS
	bVYEFqDVVtR5oiMAabDUtS893cjHh4x/nQfI36fxk/zzgDT1sKYS0RSM/zQloGlx0xZjHepHAn7
	f9vocPdG4gwdpt8X5KvjiQctRH8Ow==
X-Received: by 2002:a05:600c:1e8c:b0:483:7783:537b with SMTP id 5b1f17b1804b1-4855670b73cmr167396025e9.24.1773594541553;
        Sun, 15 Mar 2026 10:09:01 -0700 (PDT)
Received: from DESKTOP-TILNSD1.localdomain ([139.47.104.103])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48541b7f3cdsm528821365e9.14.2026.03.15.10.09.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 15 Mar 2026 10:09:00 -0700 (PDT)
From: Kit Dallege <xaum.io@gmail.com>
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2] block: add missing kernel-doc for memcpy_from_bvec() and memcpy_to_bvec()
Date: Sun, 15 Mar 2026 18:08:51 +0100
Message-ID: <20260315170851.65489-1-xaum.io@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Document the @to parameter for memcpy_from_bvec() and the @from
parameter for memcpy_to_bvec() that were missing from the kernel-doc
comments.

Assisted-by: Claude:claude-opus-4-6
Signed-off-by: Kit Dallege <xaum.io@gmail.com>
---
 include/linux/bvec.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/include/linux/bvec.h b/include/linux/bvec.h
index 06fb60471aaf..3cf51889c6d4 100644
--- a/include/linux/bvec.h
+++ b/include/linux/bvec.h
@@ -256,6 +256,7 @@ static inline void *bvec_kmap_local(struct bio_vec *bvec)
 
 /**
  * memcpy_from_bvec - copy data from a bvec
+ * @to: destination buffer
  * @bvec: bvec to copy from
  *
  * Must be called on single-page bvecs only.
@@ -268,6 +269,7 @@ static inline void memcpy_from_bvec(char *to, struct bio_vec *bvec)
 /**
  * memcpy_to_bvec - copy data to a bvec
  * @bvec: bvec to copy to
+ * @from: source buffer
  *
  * Must be called on single-page bvecs only.
  */
-- 
2.53.0


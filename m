Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 354C321ABA2
	for <linux-block@vger.kernel.org>; Tue, 23 Sep 2025 00:34:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758587651; cv=none; b=rFBfAX2nm5CtWGhhjQLC2ISv/h6dlC/o3nmuiR3qwC2+Q+AMy4yXUVLsl3m2KjltTp3pGkA9g2QCldnDc/e41Uqh8Z426+GWkZxvsL57D0VqhSaYUdQgjJKO3Ta5915tP/9gig5ZdZ/d+Avr9UWAyM3sp3G3mm4f9AMOAWwXU7g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758587651; c=relaxed/simple;
	bh=6gl5Z+JZLYv55qqXi1LyVpN6JlxHo4rap/E6cwLJcX8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=j/ocHnnLHngy6ZfevgdQMeMyqhWbQspzvjz+Z1Xj8GM0JO5Emfw+pu8X3UGYR+wVvs3nqw0B3hB+x6gC/6YnpoYokn1yp8RcV/tbKB1bdR3S25IQ2XdI1vBjM/a4fDkaJ7nrTfF15YXUZnfmiiu3L3Xkr1miEosh2qWG9D6tYhE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VQg1+N+I; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VQg1+N+I"
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-77f169d8153so2739594b3a.3
        for <linux-block@vger.kernel.org>; Mon, 22 Sep 2025 17:34:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758587649; x=1759192449; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dfDhWqoAEKFVOf/mlnVW8HkSqt5eAKrI9BC9iX0QNTA=;
        b=VQg1+N+I6wgsWicFvuceUi3taXEX7Cl0HfJPJE38vcy02wS6sCakS/hxZtj8R+zidX
         9pgie9tLnptq1T5yuBaDarZ/b7b+TIhnoHx4zjaPPWBoAFHeDpO2D0j4kFAi3npX1JUS
         y9EryXy8qmfWMgFUSAyQhXlIY8jAHFMSQwzhgvoyswQN2yWBHYmCAzO00VvAHfXb9oFB
         8Ak0f1xuLZc9UC5RM2f5Y/1Ga1jWp+0oeiIZLQG6xbtUd0T7HeauNFMbKKEoB5Yq9YBF
         ufJN43/LEqAn98LrbQoSaAfc1C/miwwebzbhWiVrIlT2Ztwt8YS/U7quNL0yOUPB+lqJ
         CASg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758587649; x=1759192449;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dfDhWqoAEKFVOf/mlnVW8HkSqt5eAKrI9BC9iX0QNTA=;
        b=E2du3xyLy7M2k0jvGLthhbYi5XR1Ca2DGMaB/gWiAKqeOROBWSRY3CBzQNjsgeaKGi
         3g5xeZNdgj7xNQcXJmDmGxYgzulkinspL4v7CUyniNpwEsd6F1I36gsfrPyphw9qCZ8W
         f3SJTw8bsPEggV3V2Iy+v74mYU/kcSrxLgdZlcxxvKP+MjHXdLjXy9eqsaWmjYO25aSZ
         RW2rw7WpfWhw8ocUJEkITaYAcKnnXMgJPR2xKkGW32i+2v75taCgu1TMZ3km2r/3iN3N
         y3lmE4ot+Okigk08urvdrvulo7VpOa3uI3QcikxNKqdyrMzOt0mWgE6mJWa8Nl/0kplp
         wokg==
X-Forwarded-Encrypted: i=1; AJvYcCUiSjzsvYiFDtRfqrF5OKZBNR81SnWJKz847PJjtOBHS7R/jwis0PxFRbwFXokbWpSwmCRZ1UB66JY5QA==@vger.kernel.org
X-Gm-Message-State: AOJu0YyXQodbgRvyM78pBl6udpfnNCcAj7QaFWes0OXuV2QWBByj6Sxh
	JpngV4MjOEIaCmRF6C3iW+pyFxAngt/GsZbfz7R+cUoi7C2DYyerOu+t
X-Gm-Gg: ASbGncsKhcv0zunRVBic+hbbu8FSTs1LqMRyJaiwg+br+2mNhShW8zo5FxRo3f4wtuI
	EzYLQ+WlMvYzO9drurAb5JJ3PlKb7q8NWFr3Up1Lht0DBIjqjJlat0DIw7CTPdgol6KRcfoNWfQ
	soj/lDP7HgXc/Y1CfHA7De+/iVnj2Ori2XOq+DFImdBLcVmEG5FDiPmEFEoseKYaaN7TejMrQiT
	wHBNydGcpyLf46wtdNLiDj5OBHA4Pwgnpgxuy9h5v4cmjTYidU8nS1O2UbpAP6e3VViDkl7eLUt
	Og2jHnfbceGxnYCvjO2OT+TqYUcp84qiEnuz9QCYhwT4QjbhmE4Iq7tU/Ya9lO2o8TBXvtlY2Zz
	2HBwnZVbcMFjxHVELgGlyV5ywid2EZEwF3cqP8MfyK3MNLnVJ
X-Google-Smtp-Source: AGHT+IHwN6QET28Com0mnDzTsPnGxiZ9CeU+qh1qBSs7SYJ7KF36Ej3bcT5nNRqK/1il2tMZr28MWQ==
X-Received: by 2002:a05:6a00:4fc6:b0:77f:5357:2c07 with SMTP id d2e1a72fcca58-77f53b64b19mr919389b3a.27.1758587649243;
        Mon, 22 Sep 2025 17:34:09 -0700 (PDT)
Received: from localhost ([2a03:2880:ff:1::])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-77f4fd7223esm1127430b3a.103.2025.09.22.17.34.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Sep 2025 17:34:08 -0700 (PDT)
From: Joanne Koong <joannelkoong@gmail.com>
To: brauner@kernel.org,
	miklos@szeredi.hu
Cc: djwong@kernel.org,
	hch@infradead.org,
	linux-block@vger.kernel.org,
	gfs2@lists.linux.dev,
	linux-fsdevel@vger.kernel.org,
	linux-xfs@vger.kernel.org,
	linux-doc@vger.kernel.org,
	hsiangkao@linux.alibaba.com,
	kernel-team@meta.com
Subject: [PATCH v4 12/15] iomap: make iomap_read_folio() a void return
Date: Mon, 22 Sep 2025 17:23:50 -0700
Message-ID: <20250923002353.2961514-13-joannelkoong@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20250923002353.2961514-1-joannelkoong@gmail.com>
References: <20250923002353.2961514-1-joannelkoong@gmail.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

No errors are propagated in iomap_read_folio(). Change
iomap_read_folio() to a void return to make this clearer to callers.

Signed-off-by: Joanne Koong <joannelkoong@gmail.com>
Reviewed-by: "Darrick J. Wong" <djwong@kernel.org>
---
 fs/iomap/buffered-io.c | 9 +--------
 include/linux/iomap.h  | 2 +-
 2 files changed, 2 insertions(+), 9 deletions(-)

diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
index ed2acbcb81b8..9376aadb2071 100644
--- a/fs/iomap/buffered-io.c
+++ b/fs/iomap/buffered-io.c
@@ -450,7 +450,7 @@ static int iomap_read_folio_iter(struct iomap_iter *iter,
 	return 0;
 }
 
-int iomap_read_folio(const struct iomap_ops *ops,
+void iomap_read_folio(const struct iomap_ops *ops,
 		struct iomap_read_folio_ctx *ctx)
 {
 	struct folio *folio = ctx->cur_folio;
@@ -481,13 +481,6 @@ int iomap_read_folio(const struct iomap_ops *ops,
 
 	if (!folio_owned)
 		folio_unlock(folio);
-
-	/*
-	 * Just like mpage_readahead and block_read_full_folio, we always
-	 * return 0 and just set the folio error flag on errors.  This
-	 * should be cleaned up throughout the stack eventually.
-	 */
-	return 0;
 }
 EXPORT_SYMBOL_GPL(iomap_read_folio);
 
diff --git a/include/linux/iomap.h b/include/linux/iomap.h
index c1a7613bca6e..f76e9b46595a 100644
--- a/include/linux/iomap.h
+++ b/include/linux/iomap.h
@@ -338,7 +338,7 @@ static inline bool iomap_want_unshare_iter(const struct iomap_iter *iter)
 ssize_t iomap_file_buffered_write(struct kiocb *iocb, struct iov_iter *from,
 		const struct iomap_ops *ops,
 		const struct iomap_write_ops *write_ops, void *private);
-int iomap_read_folio(const struct iomap_ops *ops,
+void iomap_read_folio(const struct iomap_ops *ops,
 		struct iomap_read_folio_ctx *ctx);
 void iomap_readahead(const struct iomap_ops *ops,
 		struct iomap_read_folio_ctx *ctx);
-- 
2.47.3


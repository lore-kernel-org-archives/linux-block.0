Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D90F6351C06
	for <linux-block@vger.kernel.org>; Wed,  7 Oct 2026 01:32:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791336758; cv=none; b=NlZoKVztxf2TrYXbEfLNBHqPotsBOwnXCUBkvcyF2zwRM3GrrVJiQ/VR8RJjKpkGXG3fVQUrKLuWEcMByAuZBI6QeLVkz+w+5DCmNti8w5RE4/7sg3a0xe4SPGVW1zwf+e4MV8bRVIMMsNfCK9y4SgINDrGWLAVCE2IHehvPPos=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791336758; c=relaxed/simple;
	bh=zkmmP/s3oaEnM5CZp4fq/TPO4woTgg6h/01Z24jsq/o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QHHDhg/Ua9vO5UEvKLaaR9BUyewqexEGu/v1K4j+raKrBLFzDsXq1e5n9vpymkc84kf0dlLuAWFVmb0RuhKgAo32cpLmT5LAyxz9tu9Ax2ClmAjGSnuZcbuMgiBdiX9veBw7vvdQZc5c9KACmA/wGXXgkJlsposM+a/zy9rG9cI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CRlH75US; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CRlH75US"
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-4a180fbeef5so678235e9.1
        for <linux-block@vger.kernel.org>; Tue, 06 Oct 2026 18:32:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791336754; x=1791941554; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=vy1zLQ9YKYGfqugQgTKt/AfV3rhwVDXY3KU8gp6bN10=;
        b=CRlH75US8oKos3okZ/GQ+5N6xYnevgjyVe5DtiWbW4oF9Ry/Gq21dOFvVgKVsrH/rz
         PwzGinq1WiPIJvHiImryW9+/xVNZPuUWh+B2XhiNH5ZKbC6OJfPYfBCtf02Fnx4UP8gm
         Uxy6nwhailq1lTMmJTj80B3F/elx7keV2nLPs1J1RMPNwhkGkGi3UCQCXoawqabt63YK
         eDT18cJlpKGeqkAo97KfI58vjg+Sw8NY4nRYhWx9Q/c9OP5MPpkNnZ6J5+FbKWLRKWiJ
         72BRXbEKTchEkkghRuEFcFF/mynBzvHWFf0G+XO4CWEo3JHjTeCYZch2RbfkwGTSgjDZ
         eoeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791336754; x=1791941554;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=vy1zLQ9YKYGfqugQgTKt/AfV3rhwVDXY3KU8gp6bN10=;
        b=niKVKimOabEqNKfdnskfPNaAxm4/K/BJClbGJc1SwHR+6bWhRe504x1U3U7UY+UnO1
         RrHBCCpJ5t4pdYWlPVuOOCXkh9QSVIrT10Z0v+b5Hd3IUJ58RLRH0SK5+DKPbjkryxsY
         6rnpt4WwUM354dDobpd07hTjGZ3I8FeFZCaEVZJuufm2xehEysoXhOyxaQVcPQyGup9B
         cafU8bJ++4PaZL80c68BhGtbHkFXQwT7Cz9Xu3ca/frPadJXxlYD/Gd9YYPEUQAu/e1m
         i1CVYY92/ruHIJY0FF4quM7Cy7D6MT+7iz0iCYBOoVuLFQyQ/HYSUvguaKXTgK08yBsu
         0xRQ==
X-Gm-Message-State: AFuF++kCDHipkxq2gWEtLQQGaSSn3rdW33wT/lrO7NzjU2HWpgyjJZNV
	hPEIuHJ9/+3sFCr2quo3W/oy+pCR+AN0p36MuG+BKRP9PEYeW5VRuQ4t4kO8EA==
X-Gm-Gg: AYBFou39php1q93gAR2fF01z8oOR11hUFVHHaqWsTXS96Cjr3JfbyxpDYyzakXGUoM3
	+vFK7c4Qgjddp28w6SofJEd7KhBzWXT+6vdIO6uHn4VU9tVjDjXwDvz3S6cuxAmKcaii3iLt2I2
	Qv5LUcfw0uyPKAglqGI/ChnCoFcu/cse6nALWpCmF/jqQOGOsApLqwtdDj372lwyY/aLzNWBga/
	ca+8QifEJmyKO0EGgYubCtHtkNJYYFCMRkavuxiogyt63CNbop2vsXzrUixuNeiWO/vNsZoFp5i
	R2Clmp7Ke/4rZrgPjauBwWid4Zf0oYWs6s6l10/qvJrYp+H85nvUNTyK30Kxa15hruWSrNMe3XX
	rcRoZT8VJwrWQ5tvmxWk7zDAuLvCJN8tJKwuAJ57e2BLkkYYmKGYvymNfx9AOwso4xMeFwkAE01
	1FmRYmB0l9uiQbVhciOObKibVOt9+NGSwVmoKOVskPDxEYsuGA46A1auViBwEhsJ4mVPH/dQgJB
	7HZs6Vu296sixQA+a+v9pjA9IuG0Gbl8ss2uRyaXEG77XiNxq+W7cJTJz9vQ8KzCcOFHbZADtHv
X-Received: by 2002:a05:600c:3b99:b0:4a0:1c10:1372 with SMTP id 5b1f17b1804b1-4a1806501eamr8969125e9.27.1791336754109;
        Tue, 06 Oct 2026 18:32:34 -0700 (PDT)
Received: from 127.mynet ([2a01:4b00:bd21:4f00:7cc6:d3ca:494:116c])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a17f6538b7sm21183615e9.13.2026.10.06.18.32.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Oct 2026 18:32:33 -0700 (PDT)
From: Pavel Begunkov <asml.silence@gmail.com>
To: linux-block@vger.kernel.org
Cc: asml.silence@gmail.com,
	linux-kernel@vger.kernel.org,
	linux-media@vger.kernel.org,
	dri-devel@lists.freedesktop.org,
	linaro-mm-sig@lists.linaro.org,
	linux-nvme@lists.infradead.org,
	linux-fsdevel@vger.kernel.org,
	io-uring@vger.kernel.org,
	Christoph Hellwig <hch@lst.de>,
	Sumit Semwal <sumit.semwal@linaro.org>,
	=?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
	Keith Busch <kbusch@kernel.org>,
	Sagi Grimberg <sagi@grimberg.me>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	Jan Kara <jack@suse.cz>,
	Andrew Morton <akpm@linux-foundation.org>,
	Jens Axboe <axboe@kernel.dk>,
	Nitesh Shetty <nj.shetty@samsung.com>,
	Kanchan Joshi <joshi.k@samsung.com>,
	Anuj Gupta <anuj20.g@samsung.com>,
	Tushar Gohad <tushar.gohad@intel.com>,
	William Power <william.power@intel.com>,
	Matthew Brost <matthew.brost@intel.com>,
	Alasdair Kergon <agk@redhat.com>,
	Mike Snitzer <snitzer@kernel.org>,
	Mikulas Patocka <mpatocka@redhat.com>,
	Benjamin Marzinski <bmarzins@redhat.com>,
	dm-devel@lists.linux.dev
Subject: [PATCH v8 12/13] io_uring/rsrc: add regbuf import flags
Date: Wed,  7 Oct 2026 02:31:55 +0100
Message-ID: <4a4bfd9b4e444ecf9025e85b5cf0f864aa45c139.1791336002.git.asml.silence@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <cover.1791336002.git.asml.silence@gmail.com>
References: <cover.1791336002.git.asml.silence@gmail.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

We'll have special registered buffer types that can't be used with all
opcodes and need special handling. Add separate flags to control
registered buffer import, which will be used to specify what kind of
buffers the caller can handle.

Signed-off-by: Pavel Begunkov <asml.silence@gmail.com>
---
 io_uring/rsrc.c |  8 ++++----
 io_uring/rsrc.h | 24 ++++++++++++++++++++----
 2 files changed, 24 insertions(+), 8 deletions(-)

diff --git a/io_uring/rsrc.c b/io_uring/rsrc.c
index 6930a6897b41..6e4fe70b316f 100644
--- a/io_uring/rsrc.c
+++ b/io_uring/rsrc.c
@@ -1315,9 +1315,9 @@ inline struct io_rsrc_node *io_find_buf_node(struct io_kiocb *req,
 	return NULL;
 }
 
-int io_import_reg_buf(struct io_kiocb *req, struct iov_iter *iter,
+int __io_import_reg_buf(struct io_kiocb *req, struct iov_iter *iter,
 			u64 buf_addr, size_t len, int ddir,
-			unsigned issue_flags)
+			unsigned issue_flags, unsigned import_flags)
 {
 	struct io_rsrc_node *node;
 
@@ -1731,9 +1731,9 @@ static int io_kern_bvec_size(struct iovec *iov, unsigned nr_iovs,
 	return 0;
 }
 
-int io_import_reg_vec(int ddir, struct iov_iter *iter,
+int __io_import_reg_vec(int ddir, struct iov_iter *iter,
 			struct io_kiocb *req, struct iou_vec *vec,
-			unsigned nr_iovs, unsigned issue_flags)
+			unsigned nr_iovs, unsigned issue_flags, unsigned import_flags)
 {
 	struct io_rsrc_node *node;
 	struct io_mapped_ubuf *imu;
diff --git a/io_uring/rsrc.h b/io_uring/rsrc.h
index 73d7b1ebf0b6..351995b61e68 100644
--- a/io_uring/rsrc.h
+++ b/io_uring/rsrc.h
@@ -62,12 +62,28 @@ int io_rsrc_data_alloc(struct io_rsrc_data *data, unsigned nr);
 
 struct io_rsrc_node *io_find_buf_node(struct io_kiocb *req,
 				      unsigned issue_flags);
-int io_import_reg_buf(struct io_kiocb *req, struct iov_iter *iter,
+int __io_import_reg_buf(struct io_kiocb *req, struct iov_iter *iter,
 			u64 buf_addr, size_t len, int ddir,
-			unsigned issue_flags);
-int io_import_reg_vec(int ddir, struct iov_iter *iter,
+			unsigned issue_flags, unsigned import_flags);
+int __io_import_reg_vec(int ddir, struct iov_iter *iter,
 			struct io_kiocb *req, struct iou_vec *vec,
-			unsigned nr_iovs, unsigned issue_flags);
+			unsigned nr_iovs, unsigned issue_flags,
+			unsigned import_flags);
+
+static inline int io_import_reg_buf(struct io_kiocb *req, struct iov_iter *iter,
+				    u64 buf_addr, size_t len, int ddir,
+				    unsigned issue_flags)
+{
+	return __io_import_reg_buf(req, iter, buf_addr, len, ddir, issue_flags, 0);
+}
+
+static inline int io_import_reg_vec(int ddir, struct iov_iter *iter,
+				    struct io_kiocb *req, struct iou_vec *vec,
+				    unsigned nr_iovs, unsigned issue_flags)
+{
+	return __io_import_reg_vec(ddir, iter, req, vec, nr_iovs, issue_flags, 0);
+}
+
 int io_prep_reg_iovec(struct io_kiocb *req, struct iou_vec *iv,
 			const struct iovec __user *uvec, size_t uvec_segs);
 
-- 
2.54.0


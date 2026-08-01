Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61DCC337105
	for <linux-block@vger.kernel.org>; Sat,  1 Aug 2026 15:52:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785599532; cv=none; b=evvzy4XHyG6RmrIaczd+CULZeKqb2Pc/AD5TwXX/IZsT2i+2VXGoeQKsRju7Cpmjua7GhZQ1GShgG8pTqxugc/1Y+o3FuZvJO0zNqL5o6Q+AIFx4aHJciex6SminAU1N2bCwBl4K2Zcg5nB8XexhZus4+mn9FqdLdUfvmOnzxK0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785599532; c=relaxed/simple;
	bh=7qlj+n0xMTYMM8wbxh5YbBlihhCnKaVVIBe7eTfypEw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sDuBiL4H2+KK5xlgdEMlBWMFu/AuJLbun3PDlF9WFEwSrwTCsKwm8npeGTQQpBB1AH9ZKDc57EyZDSWWmFom6oBgLMw9mzartWjTZ4rBr9a+j0G3iMHEVh09otym5l+nxXlAQ49S4zQ3sg9J9SxJqJqwjB/RVefAIySCJfQO6Jk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Y3I/+/QG; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Y3I/+/QG"
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-2d02b4c3601so23016565ad.3
        for <linux-block@vger.kernel.org>; Sat, 01 Aug 2026 08:52:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785599530; x=1786204330; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=4DE9iwPHyfteVjhRD5r56Chvjj2EVxXiQr3A0KjARNc=;
        b=Y3I/+/QGz8AWLgiulI6sUP9MyxA5O8wTFT0Aqgz4KW0m6qhl6x+ZLnO71suTdlTGdL
         30EuWjpibEb2nl9zRLU4yq3gzjepyvdUEaTbQvlPp802+I+wvljk97/Vrw/PmKgUe4A/
         /V9jOTpHfI1LzbzXk46hMvnO2z9Lktfnp14lpg+52yW/qg5HkRQcfCJpcdnmbQXDjgyd
         pSeaK26w50qa5Py2luzzQvkhjCwe1d6oXA2nIW2SSAuk8qu9Lc9BJup38LOQzfvZX5SP
         4dD/sJGrHPjCyq53HOohqHToRnY9hYKQd5Wruu+3oPcPw/wPJOa698VNHJ7zTCjE2Qiz
         nlcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785599530; x=1786204330;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=4DE9iwPHyfteVjhRD5r56Chvjj2EVxXiQr3A0KjARNc=;
        b=CvoC/odQp3wQasUjnFRqeeXr++LYHbP8M5KaDcVc3smAxSgn9ZW82yYrWPBF8nhguA
         xuJuIn/vEVStzisyNMRHImRS+1WhosPZ5U7eSYvXOsMvPEQhqxKgRqX3hUywAuAAybTu
         5DW3QboiWV4byrEJLYsdWkNxIXgb+9qV0Fdz+s+tBbjFmbGqwFIay8QqZ4QlAQbUZkTu
         keMd48ZVK59oGkBPn2s57LDg3wXHizfj50ltN+kwrP/zPSG1nX2l4i5rx6Y4yNmZT22k
         cXUo6I0JU5RMzQETuni8krT+Nhf5Q5+UKZ2DKqLy3J8M8sSFGi0/xdalzk+RUEJJetZE
         b4yA==
X-Forwarded-Encrypted: i=1; AHgh+RqApcn4OtzXD6hF7M9X+tV6jWfM1e/Q9KaQJHs8dACt0qMpAmJoaSuZrmSJZ4EM18jFvM+nyfE4L7RySg==@vger.kernel.org
X-Gm-Message-State: AOJu0YyqfEDdUN1EWfNmiBGVpR7D+X0VHDXTjqu2dlqAA9Dp6hB1cROc
	lYp8fBkhVwD7mUZUrE8i0bZAAjTQt4zJ9KyLW15xCUIr9KckixiM4yDz
X-Gm-Gg: AR+sD12M4/6vCAPOd+Tjc+WtiBiUsTbtoyGydE8aoyP/csazSzFrtnvUCSFBi53K9G5
	EGd5r0fIp/zZgQJQ+0lrsG28llQQroeTWYPw+YJnogcSzk9beX3QYevn0GYgsbXfY+X29KOmZhY
	DLcoCkYHmQixm/W9NoctKRKOH7dHMbWAlNDrcv95ahEEP2bIfm/mHb+DvvUcNViZJX7wdXIPL4B
	EhtP0XZqQ1KTAuSHVCeSJzI2Lxwq5Eej6yxW0oPLAZ6Qo6IJ3PyFZJRNqcMCcKze+To6iqops41
	UDOFbAVZDT7uMBg30bOF8QR0ZJ+nVHvk4Ft+5XRoEb264ou53WCvkn3PMyzn+smFrv1N0qgn9Xt
	RibwjUKIu3b+QW3tU6LSRzaShaBPLYN58qo3Zv6aj2tEMnswBHsw6nZvz8re/RGSp67ovQNq3DX
	dE63SDQi/aWblMXe+B9yj6aRvNj76TkbyyjRdGiy1sZywGooC32YNj9bxISGbC/wpfFjlPjHSGY
	da9Ngp3rxqICYjBGhUW/EHCo0VQvnDnKXlEBGbF58Odm9A=
X-Received: by 2002:a17:903:1aa6:b0:2cf:32bc:9722 with SMTP id d9443c01a7336-2d0524671d5mr36849685ad.34.1785599529680;
        Sat, 01 Aug 2026 08:52:09 -0700 (PDT)
Received: from 127.net ([2620:10d:c092:600::1:61d0])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2d04b12202bsm18287605ad.66.2026.08.01.08.51.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 01 Aug 2026 08:52:09 -0700 (PDT)
From: Pavel Begunkov <asml.silence@gmail.com>
To: Jens Axboe <axboe@kernel.dk>,
	Keith Busch <kbusch@kernel.org>,
	Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>,
	linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-nvme@lists.infradead.org,
	linux-fsdevel@vger.kernel.org,
	io-uring@vger.kernel.org,
	linux-media@vger.kernel.org,
	dri-devel@lists.freedesktop.org,
	linaro-mm-sig@lists.linaro.org
Cc: asml.silence@gmail.com,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Sumit Semwal <sumit.semwal@linaro.org>,
	=?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
	Nitesh Shetty <nj.shetty@samsung.com>,
	Kanchan Joshi <joshi.k@samsung.com>,
	Anuj Gupta <anuj20.g@samsung.com>,
	Tushar Gohad <tushar.gohad@intel.com>,
	William Power <william.power@intel.com>,
	Phil Cayton <phil.cayton@intel.com>,
	Jason Gunthorpe <jgg@nvidia.com>,
	Damien Le Moal <dlemoal@kernel.org>,
	Alasdair Kergon <agk@redhat.com>,
	Mike Snitzer <snitzer@kernel.org>,
	Mikulas Patocka <mpatocka@redhat.com>,
	Benjamin Marzinski <bmarzins@redhat.com>,
	Vishal Verma <vishal.l.verma@intel.com>,
	David Sterba <dsterba@suse.com>,
	Ilya Dryomov <idryomov@gmail.com>,
	dm-devel@lists.linux.dev,
	nvdimm@lists.linux.dev,
	linux-btrfs@vger.kernel.org,
	ceph-devel@vger.kernel.org
Subject: [PATCH v5 15/16] io_uring/rsrc: add regbuf import flags
Date: Sat,  1 Aug 2026 16:46:27 +0100
Message-ID: <ddd0458a78fd1666fb109993668afb01d35bd155.1785596451.git.asml.silence@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <cover.1785596451.git.asml.silence@gmail.com>
References: <cover.1785596451.git.asml.silence@gmail.com>
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
index f041b0db77af..fcdc4edd2858 100644
--- a/io_uring/rsrc.c
+++ b/io_uring/rsrc.c
@@ -1245,9 +1245,9 @@ inline struct io_rsrc_node *io_find_buf_node(struct io_kiocb *req,
 	return NULL;
 }
 
-int io_import_reg_buf(struct io_kiocb *req, struct iov_iter *iter,
+int __io_import_reg_buf(struct io_kiocb *req, struct iov_iter *iter,
 			u64 buf_addr, size_t len, int ddir,
-			unsigned issue_flags)
+			unsigned issue_flags, unsigned import_flags)
 {
 	struct io_rsrc_node *node;
 
@@ -1656,9 +1656,9 @@ static int io_kern_bvec_size(struct iovec *iov, unsigned nr_iovs,
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
index 83aa86e6f320..f12abaf63270 100644
--- a/io_uring/rsrc.h
+++ b/io_uring/rsrc.h
@@ -65,12 +65,28 @@ int io_rsrc_data_alloc(struct io_rsrc_data *data, unsigned nr);
 
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


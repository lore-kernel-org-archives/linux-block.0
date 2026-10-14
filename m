Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86B2F502570
	for <linux-block@vger.kernel.org>; Wed, 14 Oct 2026 11:02:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791975774; cv=none; b=uNd1o1anK56kb7e1nUcOKEgdFkpVYNzjGzpBiu2B9abPCnLfukEAS8XA46lkZnBGRQVZd9RpoIJBXC64e29Vj1KsPlZhclfrB9liz+MRNociNlUom41MzkobOy3F3YunqZZSuChx6M3FNBghjdQbQ2egXp30m3TUGeZen7mVjAY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791975774; c=relaxed/simple;
	bh=r60ha7f86tSXOy7awDRSeceZcMhT0AOlgJWaxT3jtGs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gX1S/os8SOKwHc23dGZTWef1j7baAN7Q1Fq3zkL8mB6GCXVjNMW9C9eJSwWLqEner+Z3mHP+CwbG4fwZH1GSMSnSVI7d8mPRGNUJE11WSbRXZMf49w/ETOeoQm41FfjskedQCaJxxW3ullyGe9zaVzYSSzDoTUvaNh17oI17oKA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ec2J/9XW; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ec2J/9XW"
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-4a0213948d3so24333135e9.2
        for <linux-block@vger.kernel.org>; Wed, 14 Oct 2026 04:02:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791975762; x=1792580562; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ays4SVba18pfRPB/Hpqu6QDaxGmpKJaoA/2lD097Khk=;
        b=ec2J/9XWQns9tj6FMC0xey6hE+ChJX7QMWPnnNC7ck9YAiDfM4dCYfGC6PGN7ASton
         nGvx8FSUjPxR0wkhYfPj0/Dsbdedi0x0PmmFkimO9rEEA3FoIph8o+wg3EGhp1ImbFz4
         Bhlqj6cUD9Ra0r+nlzXuM0ofwOuKMVJMycpHCtyNDKF6HPylhF8jl9c812YN1970grG8
         REu40iu1vOL7XzqQto+JHM1Xc6laDsEY0vfM/QX3uELyezwGFtN0e3Vg8aoagLyEsVVj
         TOpRkqKEB0cisgogZoA77w2SUi8berzjTITZmgHXbkVsEZRWfLXIhkjjJ1rRkbR8qMWv
         oipg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791975762; x=1792580562;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=ays4SVba18pfRPB/Hpqu6QDaxGmpKJaoA/2lD097Khk=;
        b=IShuUn5NH5xD8kYzqBQq4jUUj6pEFwYcfnB8ASYE59pvzpmmUut7ld2CAZNGl7vVZI
         +OHJXBvfAKLmtABUwp1clV+0D5x6KOVyqHUdrY625wUxAeC4v0Y7uY6nDra+nRBl6iKo
         B9aeu1B1UI7lAFaHme1OPOgjH7Jf4KV72d74zEKCOSNgkdLvyfo5ZqcVMLGmPg6jYuPJ
         iz1TIilwg0GVPo7fCjJjH8KlXViFkH8LQc++xO0+6sQPDMG0EJGCC1dQROrv2hp7y4H7
         8cHh/jW4mRrY3ulwQi7l1ObIO6Ah2IJxvNkS+a4LYrR0Bhd5jHdxPoyUSexJ9JURptyI
         P77g==
X-Gm-Message-State: AFq9FYKGGsXKBrPgsVkdEpopFpzOBRRjtMlZb4cp8KP2GEJ84seMXm82
	sMcDcaie5h82ZHFeA5vsk8nhF9qQNwaoLIiWKwZLMd72dCbOduH/UZvSWYNHsw==
X-Gm-Gg: AYBFou3TXLaMN/SvNhjnAVAlgG6G+JdJwtv9VlC/ZLzEhuKbc6Egz2pzc4uUig+blkl
	U3nyKeLlClj7irfZs5RVJCy4sZjQeqPxaJ8/Ft0Ie3rhSlLyuArgE24RBM86VD51uUL7ZN2PqTq
	VIaPihRQsGam164of1TWPluOURm6T+YROgLW21jcW+C8ZHhzaQUYo4QnkPkhQhsean87DdZPd4G
	670gSDic8RyxL8e6TDVDrnLviCFuI9IwbpFcKsbMDOg5AhkzFvT8Ukj3ydd8wI8GjtxZwYBa5Co
	ffMY7VDDeA7vhKfS9vCc9Ybe4vdGG+tUobH2+BI3N/CzMZM6sbQ5bQisoiy9aKZ+Bs2qOU2Jr1O
	nMT9ye8M1WVg8W6rfAO7YoFIPy+u8y00O3PDdfUkzlzIKeS0IdClcGGrH8ZCkvJTJ7VEv6fhEZE
	3m9p/Wo/b7ghfx/mKJoRewl4eoDeaBqqc0NdwhiNgMVtQ1HceRUpGo217XHET0Q7XoPq0cxhj5v
	8wmIPtFaZtxAlqN0IOVV/lynEKPPF+6ES2bjanDrJv6/b4NOta24wOFExYQwMsvP7gdVEbVycPp
X-Received: by 2002:a05:600c:154c:b0:49f:ce78:3562 with SMTP id 5b1f17b1804b1-4a18e4a9159mr329602185e9.19.1791975762395;
        Wed, 14 Oct 2026 04:02:42 -0700 (PDT)
Received: from 127.mynet ([2a01:4b00:bd21:4f00:7cc6:d3ca:494:116c])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a1b45eb78csm38078845e9.2.2026.10.14.04.02.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Oct 2026 04:02:39 -0700 (PDT)
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
Subject: [PATCH v11 12/13] io_uring/rsrc: add regbuf import flags
Date: Wed, 14 Oct 2026 12:02:10 +0100
Message-ID: <eb798e045bc245ebb7b0b42ba09a34b92f8b216f.1791975048.git.asml.silence@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <cover.1791975048.git.asml.silence@gmail.com>
References: <cover.1791975048.git.asml.silence@gmail.com>
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
index 532866a1e9b9..f42d201738cd 100644
--- a/io_uring/rsrc.c
+++ b/io_uring/rsrc.c
@@ -1317,9 +1317,9 @@ inline struct io_rsrc_node *io_find_buf_node(struct io_kiocb *req,
 	return NULL;
 }
 
-int io_import_reg_buf(struct io_kiocb *req, struct iov_iter *iter,
+int __io_import_reg_buf(struct io_kiocb *req, struct iov_iter *iter,
 			u64 buf_addr, size_t len, int ddir,
-			unsigned issue_flags)
+			unsigned issue_flags, unsigned import_flags)
 {
 	struct io_rsrc_node *node;
 
@@ -1733,9 +1733,9 @@ static int io_kern_bvec_size(struct iovec *iov, unsigned nr_iovs,
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


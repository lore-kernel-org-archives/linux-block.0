Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7419C37F727
	for <linux-block@vger.kernel.org>; Wed, 29 Apr 2026 15:26:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777476413; cv=none; b=QDpuqdbXooWWj3rqzJ0I1slCbgmr5sL67RjWxT92N2ubrKyJv6VPurm/emFg4YdznnN5ctfAxKLo38Xo4u72yK4Dg1UP8W1dE6wM74GSQkZVzqhM2hciJUb3NCiiH2Y+gec/6Ots4kvaGbEfteKDy9aSZgx/7xeeEEqWyguqzDo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777476413; c=relaxed/simple;
	bh=DL12ZWqeJwgmWM4073U0nNO7Rud8B90RO8c36PxK6lA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AKV2OxL4qPMbh/Hab8n37J5fGlATqc1JpZvyLidfIG4sSufFim9YM/PYEK60s4AwDghgcmcR+Br84P/w2iTlqZyFEF0Gr7HWYGy4v5cvH3rqkcFQdzuSM0Ttn7LZVzOcmAyRPwue6bbo46Xb46vQTj95+FmrTqLtHEX44dVvlZU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EevxMA7L; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EevxMA7L"
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-43d64313c39so9755829f8f.3
        for <linux-block@vger.kernel.org>; Wed, 29 Apr 2026 08:26:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777476409; x=1778081209; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Pdajlfqb0Mkqw7FfTkWcBSlkNtUxKMEiU4sOjeajLqA=;
        b=EevxMA7LPtKpXQoHdd237w6Vc8pJbzdxm6cjW6PNSoDJlLosPzx0qIFsRDgPYNbdG7
         mexMEQ4B7y3zWxfct269nOC9bu4er8Y6GvfmyrrJRneIVajWkRzJhh1B0Y8Rak9y6l8U
         JBBZfSuG7lH+3EHCHD3CbnDANBUEW90SUEboSu1+/E8aF9lElvHqUuTUTUWwSCv0jTek
         eB4W4U2CzXvdYQJ0yK9hi/Fd/NnwU9NR9zcOpQpDQbD7Ksp9i/dB9dfdeVbtLEAivF1p
         rPNP2fBYkQWVm+FyjgRqQaI8WlJvCVhPpVCW/tZ0pIGGuC7zB+WQvEfLOHlCqhvGkBt3
         yoHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777476409; x=1778081209;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Pdajlfqb0Mkqw7FfTkWcBSlkNtUxKMEiU4sOjeajLqA=;
        b=nYOJK+2eD6fPH3mgvr50lKlEm1t9KQTX2ED8jT17uyZtUwOOm193hSlxoOaRYStBmv
         +dCo5lSh/gntOf2w8pobqnUEcEbViE4YoxZc+E2+NinyOJj8Kf0RX9ZDIwUgJtvLuLXb
         QbtirNSy9k4mniYHYKye6gu4fjqQ1Zik3VI87nV7fgRNuEA/rhB8ZDnPSTCqqIFkNA20
         qi/0muQQiLiei7vmWGLqJrYcB26IdLDJqu2nDgLtyhCZKLU2VkoZrbqLOj2V01Upsnwf
         EyatkBpfB5JwULBzBeSAcJ0WNpRJsXxm1T4aKeGseUKWGMUHVFexb9CF7XjtGX9oEz1w
         zcLg==
X-Forwarded-Encrypted: i=1; AFNElJ8G51jq0FzkSYWOk+1p69AoW2a4BMRTOtyaplyw7hfVeXKz5fIexJm9u/bdEFIUb30aeHtTZ/MvYbXXAQ==@vger.kernel.org
X-Gm-Message-State: AOJu0Yzg6hsYMORtVmpjlrqXd8741qQDyoUretc7jg00Q+PKTPrxkC4S
	szcOiqiCh+Csu1+RRMSFnKnE9MdA7qpGpBB675mInSjEQ0JVhSdyJr2H
X-Gm-Gg: AeBDies+MtfMY8zOZ8bIKNPRE9vvcXdsww5IKfPdJduZzWz3InYN8LTgvwa58gj5lUm
	shFOjTagzF1AjkXIVrDpqkZI92nCTWH9Q1urXquGGgSF9DOPnesgNz0OxJ6+5wHG3VkDvVcv2gD
	ggB66HBQ4EyalrR+EIiIvUV8N2tpNwPY8lT3uikc5d+RMwK6jbBrxb/OlyqmcTF6mamRm5qIMKB
	5FryoCO++ntGLFaQFoXVB9G3yPSrsa+/siZBksp2TOyyf0Yg6pG9XSjLt6BJb93UU4KmmT4nHg5
	O5SfODfgG2HGSbwIQGdB6AJkMJ7TNGNfs5U9XIis4dfgNgU84jJdarSpKlmdim5jJmd5cf3v5sb
	Tv32adzYHlfWqxYJSUPtLmOtyTj0tUIhMTCCVmlxQwIxBvV/yfmU6QZmTKqGGTqfEUNQa48W7Md
	otoF1JeIB4rF83VzEoScahSsu/UshVkfRPGGlnWurAJI6htB6k3mrtpxlb0ZPZy24gKwLGAbSLl
	WWybIqWNTF1nd+odGj76KVfNjX+B361XPFUTBlT/61f
X-Received: by 2002:a05:6000:2002:b0:43f:e9ee:5610 with SMTP id ffacd0b85a97d-44790d12be0mr7198547f8f.43.1777476408973;
        Wed, 29 Apr 2026 08:26:48 -0700 (PDT)
Received: from 127.0.0.1localhost ([82.132.184.31])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-447b76e5c22sm6382951f8f.28.2026.04.29.08.26.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Apr 2026 08:26:48 -0700 (PDT)
From: Pavel Begunkov <asml.silence@gmail.com>
To: Jens Axboe <axboe@kernel.dk>,
	Keith Busch <kbusch@kernel.org>,
	Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Sumit Semwal <sumit.semwal@linaro.org>,
	=?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
	linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-nvme@lists.infradead.org,
	linux-fsdevel@vger.kernel.org,
	io-uring@vger.kernel.org,
	linux-media@vger.kernel.org,
	dri-devel@lists.freedesktop.org,
	linaro-mm-sig@lists.linaro.org
Cc: asml.silence@gmail.com,
	Nitesh Shetty <nj.shetty@samsung.com>,
	Kanchan Joshi <joshi.k@samsung.com>,
	Anuj Gupta <anuj20.g@samsung.com>,
	Tushar Gohad <tushar.gohad@intel.com>,
	William Power <william.power@intel.com>,
	Phil Cayton <phil.cayton@intel.com>,
	Jason Gunthorpe <jgg@nvidia.com>
Subject: [PATCH v3 06/10] block: forward create_dmabuf_token to drivers
Date: Wed, 29 Apr 2026 16:25:52 +0100
Message-ID: <559756c5e22dcfa183080a979de039910d1b896d.1777475843.git.asml.silence@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <cover.1777475843.git.asml.silence@gmail.com>
References: <cover.1777475843.git.asml.silence@gmail.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add a trivial implementation of the create_dmabuf_token call for
block devices that forwards the call to a new blk-mq callback if it's
available.

Signed-off-by: Pavel Begunkov <asml.silence@gmail.com>
---
 block/fops.c           | 14 ++++++++++++++
 include/linux/blk-mq.h |  9 +++++++++
 2 files changed, 23 insertions(+)

diff --git a/block/fops.c b/block/fops.c
index 713a3ba3f457..3d8a48a7d645 100644
--- a/block/fops.c
+++ b/block/fops.c
@@ -951,6 +951,19 @@ static int blkdev_mmap_prepare(struct vm_area_desc *desc)
 	return generic_file_mmap_prepare(desc);
 }
 
+static int blkdev_create_dmabuf_token(struct file *file,
+				      struct io_dmabuf_token *token)
+{
+	struct request_queue *q = bdev_get_queue(file_bdev(file));
+
+	if (!(file->f_flags & O_DIRECT))
+		return -EINVAL;
+	if (!q->mq_ops || !q->mq_ops->create_dmabuf_token)
+		return -EINVAL;
+
+	return q->mq_ops->create_dmabuf_token(q, token);
+}
+
 const struct file_operations def_blk_fops = {
 	.open		= blkdev_open,
 	.release	= blkdev_release,
@@ -969,6 +982,7 @@ const struct file_operations def_blk_fops = {
 	.fallocate	= blkdev_fallocate,
 	.uring_cmd	= blkdev_uring_cmd,
 	.fop_flags	= FOP_BUFFER_RASYNC,
+	.create_dmabuf_token = blkdev_create_dmabuf_token,
 };
 
 static __init int blkdev_init(void)
diff --git a/include/linux/blk-mq.h b/include/linux/blk-mq.h
index 18a2388ba581..ee31fb3ada10 100644
--- a/include/linux/blk-mq.h
+++ b/include/linux/blk-mq.h
@@ -15,6 +15,8 @@ struct blk_mq_tags;
 struct blk_flush_queue;
 struct io_comp_batch;
 
+struct io_dmabuf_token;
+
 #define BLKDEV_MIN_RQ	4
 #define BLKDEV_DEFAULT_RQ	128
 
@@ -684,6 +686,13 @@ struct blk_mq_ops {
 	 */
 	void (*show_rq)(struct seq_file *m, struct request *rq);
 #endif
+
+	/**
+	 * @create_dma_token: Create a dma token, which will be using to map
+	 * a dmabuf for IO requests.
+	 */
+	int (*create_dmabuf_token)(struct request_queue *,
+				   struct io_dmabuf_token *token);
 };
 
 /* Keep hctx_flag_name[] in sync with the definitions below */
-- 
2.53.0


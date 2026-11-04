Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.49
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793751557;
	b=sgTpqy3HtDA9Rkm4Whr3x81kK93lpzrCrKBKUanBEohttsTEv2fvc0vTIHwBVYSAQO7f
	 Om3Wvwyl52chQi0n2/XE8UD9huvKwLFAp3bPLP2iJYHnQAoVsGBU/tDZFVx9pkkU552jt
	 aGm68rLjJkORK/yad6478zjmnuXkoK9qKd/iWKxxFvTZ1DbshUyB3iQj8Zb4qDFKoEu6Y
	 R4eIL/vpetfFF/aEWZAP9OzO99WXOjDEHoIjdGH+SuB7k+xwRAe5gO8Rfe1HJz9aic3g9
	 btHlVxtr+PqrCObPkJaiKlKSag9HL27UkC5INiJHTZtlqGDUPGwNnp93RZl/oLblYQg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793751557;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=hxI6oNEf2EvFWjGeDFQYrrcpmAnzoeBTieQsEmlXNt0=;
	b=xffrOi2T68VWuyDzmgd/WR/3lvsQPlrBhSswUPKfLZevZUvKB2F/rwB5g2CZWdSEA9ox
	 zWh78r2DQB8cJHtzC5tLEuDG3iFUy7OddBjoUWHruw1EWkWN/RDXp1xympohE53rfUsCN
	 0l4bKKnCd0WCxhMd+hxUKPXOoA0VkWwkI/l3Q4TXT/ljjHrs2cFRPynFQRNQuIJmXq6Yx
	 i3mKD/kzKl8QjNzTlZmV0zKlGKx84+PAjAER+2Fsjj/KQnA6FW55h2FjQpqFFqNBR1qdp
	 PMaIzQrTvt8Cxy+9AYlX6FoLWQOSp0SO7WS/p9Pan5OzomJzEtSlv8HT2yGuX2X7Ldg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=tRuoCViD;
	arc=none smtp.remote-ip=209.85.221.49
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4EDB606A32D
	for <linux-block@vger.kernel.org>; Wed,  4 Nov 2026 00:19:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E4EDB606A32D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=tRuoCViD
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-48e20ed3b9dso106027f8f.2
        for <linux-block@vger.kernel.org>; Tue, 03 Nov 2026 16:19:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793751555; x=1794356355; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=hxI6oNEf2EvFWjGeDFQYrrcpmAnzoeBTieQsEmlXNt0=;
        b=tRuoCViDiz1iXYAGfLXl4R7y+RpayZrjfUA/EIamwmY7fg2tTWVGnvqmEJ6GzuXb0n
         L9q8v7usrCBqH5nyZDGX3z5SVn8+UF5iEWXHYkpiDZZkH6OMnjwQ1ejQfNwV7dFEy5jR
         DSP46baP6aBJKObk8ZJZHOyfFAhX8L5VsVcCNcqNk/mFdWI5qCvSP6bBvypVKaDv4xi/
         8c6dTf5zVxiHwLo6vGHS2EpUHkAVNBNV783B22uCwCuIUaqIQOFbFClcmBQ+gvX4CByQ
         U8Cb/QdTzUTQVtsrQ+rA+9i1ftqGQQFxCenLkBm5DlCh+HED1O+6CcYoZVfCg0pv/4IE
         DN4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793751555; x=1794356355;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=hxI6oNEf2EvFWjGeDFQYrrcpmAnzoeBTieQsEmlXNt0=;
        b=TXs/MxVGIKGNkzvE+46rU4ouF3wC0NLCbfnnZXxLLEQrOejhP45qTy17EUFg4svCI3
         efsR9NDNGEqgtR3aBNx6WoFREQg1biLJS6B0vRO7zzQUYNH6mRqkbzHE6ZlXq2IYut8h
         L2MrtIKr9YDWCsP59kLr1q+GYK8jy0+Yc10oVaddZFMww2tkLh1UPwxPVoXpuR0KiT/K
         w6W5o+vl3wNo1mXXDNEtwxJTb1MgZuifgIt2ArYeJ+5B8MkyHg+cQHus6qQGJEDrMlBI
         G1lX/D5Cf2vITjEQzt7ZEIpRSo4nQuVt54ggaFO7/AyswmhvfYNi2S6f4XwF/+gYlAyI
         5Y8Q==
X-Gm-Message-State: APuU4Z/ittBdH/naTxwixn+tlSbbJA+UEzAheh7z0t4fP97ISH2YnXsC
	dqafVZotO+rI+y8oAViBQfieycfjsal5mgslCNYMeU2tpAmyGfy9Vl6O+OMNPw==
X-Gm-Gg: AYBFou0DJhPsR/TJcv0mGPlrCjEG//ZocqU7rz0ARYs6Uk6NM7+ixzjQIj3o/dZ+54R
	u7ewyxllZmK7fh0l8JcZyV/14/yuiWRb8R7W1saKXSKjOjmYZ9rBWdMOLXccrBdACP5qyqaqATw
	ct+SEpDWNoHtoxA5tH7H1ZijiO0dNsKALGiReBdWWZQ17m3QZTbVqFc6BTYHp9g4WSutyRaPV83
	mfuDdUnVRPeNcZsGTrH6CcY/hYsjlCI3BJNs3NjhyytF0K7YKeedIp6AZlrDDutZCr5R8u2UdJZ
	MNF7jvfsR1fwYvt5QVsZTwbBDXEFJCNUXBvfec1yt1+8ATcv3bJSSNphW0Pp16Iiq4lPAZzVWxi
	9RAnX7CGJbk0nWJTvE6gbt+nEG6Gjzy12vrQ5H/OO0CcLhHstD5KpQajDw7WLVwnaR18L7ludub
	4kuWUgScXw55adHEkb7xQT80nFRCf2zNK8A0tpHoDu3Uj5SgAdlmsEeWno7KyHtk079PeZPbAdW
	I+pxmDWqcjHSbpeclOvMiZHhttl/dtTUXKi3KvNWhNBfKUF/SZQBMHekapn1C4RFySJdaQ6klfp
	U+btmgelIv7Gi+KlbHrsp3PQfSBO+t9fZk1kApqCR2fDYDWzDiOY91kR36Ax8tjZ8aXgnpwKHwG
	6tZmA0Q9Qo48sABr22+J9F4J/3UikSlg=
X-Received: by 2002:a05:6000:4027:b0:48d:fbdd:4132 with SMTP id ffacd0b85a97d-48e6e4f540bmr31194343f8f.18.1793751555202;
        Tue, 03 Nov 2026 16:19:15 -0800 (PST)
Received: from 127.mynet ([2a01:4b00:bd21:4f00:7cc6:d3ca:494:116c])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48feda1fb0esm676676f8f.49.2026.11.03.16.19.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Nov 2026 16:19:13 -0800 (PST)
From: Pavel Begunkov <asml.silence@gmail.com>
To: linux-block@vger.kernel.org,
	io-uring@vger.kernel.org
Cc: Sumit Semwal <sumit.semwal@linaro.org>,
	=?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
	Philipp Stanner <phasta@kernel.org>,
	linux-media@vger.kernel.org,
	dri-devel@lists.freedesktop.org,
	linaro-mm-sig@lists.linaro.org,
	Pavel Begunkov <asml.silence@gmail.com>,
	Jens Axboe <axboe@kernel.dk>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	Jan Kara <jack@suse.cz>,
	linux-fsdevel@vger.kernel.org,
	Nitesh Shetty <nj.shetty@samsung.com>,
	Kanchan Joshi <joshi.k@samsung.com>,
	Anuj Gupta <anuj20.g@samsung.com>
Subject: [PATCH 1/5] dma-buf-io: add tags for sharing ctx b/w files
Date: Wed,  4 Nov 2026 00:18:57 +0000
Message-ID: <9fc301319428c6c47fa183ff90d60abcca8ea63b.1793751001.git.asml.silence@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <cover.1793751001.git.asml.silence@gmail.com>
References: <cover.1793751001.git.asml.silence@gmail.com>
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Post: <mailto:linux-block@vger.kernel.org>
List-Help: <mailto:linux-block+help@vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-block+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Currently, it's only allowed to pass a ctx to the file it was registered
with, which is enforced on the io_uring side. Going forward we want to
support filesystems and not just block device files, and it'd be too
limiting.

Add a dma-buf-io tag to all files. We're going to save a tag of the file
passed during registration and later use to reject files which tags
don't match. A tag should be set for a file by the importer subsystem
implementing ->init_dma_buf_io_ctx on creation and should be unique for
this instance of the subsystem. For simplicity, we're going to use
pointers for which we're going to use pointers, e.g. gendisk for block
files and superblock for filesystems.

This patch adds a new field in struct file to keep a tag, but it can be
then be switched to a new f_op method.

Signed-off-by: Pavel Begunkov <asml.silence@gmail.com>
---
 drivers/dma-buf/dma-buf-io.c |  3 +++
 include/linux/dma-buf-io.h   | 22 ++++++++++++++++++++++
 include/linux/fs.h           |  6 ++++++
 3 files changed, 31 insertions(+)

diff --git a/drivers/dma-buf/dma-buf-io.c b/drivers/dma-buf/dma-buf-io.c
index 8440151de860..60dc58fc0c23 100644
--- a/drivers/dma-buf/dma-buf-io.c
+++ b/drivers/dma-buf/dma-buf-io.c
@@ -166,12 +166,15 @@ int dma_buf_io_ctx_create(struct file *file,
 
 	if (!file->f_op->init_dma_buf_io_ctx)
 		return -EOPNOTSUPP;
+	if (WARN_ON(!file->f_dma_io_tag))
+		return -EFAULT;
 
 	ctx = kzalloc_obj(*ctx);
 	if (!ctx)
 		return -ENOMEM;
 	ctx->dir = dir;
 	ctx->dmabuf = dmabuf;
+	ctx->importer_tag = file->f_dma_io_tag;
 	get_dma_buf(dmabuf);
 
 	ret = file->f_op->init_dma_buf_io_ctx(file, ctx);
diff --git a/include/linux/dma-buf-io.h b/include/linux/dma-buf-io.h
index d9f27650a851..299edf0baaf3 100644
--- a/include/linux/dma-buf-io.h
+++ b/include/linux/dma-buf-io.h
@@ -48,10 +48,32 @@ struct dma_buf_io_ctx {
 	enum dma_data_direction			dir;
 	bool					is_dead;
 
+	/*
+	 * Tags represent an instance of the subsystem the dma-buf I/O
+	 * context is bound to, the set of underlying devices and subsystem
+	 * specific map / context structure representations. Remember the
+	 * registration file's tag (see struct file::f_dma_io_tag) and use
+	 * it to filter out files that don't share it.
+	 */
+	unsigned long				importer_tag;
+
 	void					*dev_priv;
 	const struct dma_buf_io_ops		*dev_ops;
 };
 
+/**
+ * dma_buf_io_file_compatible - Check compatibility b/w context and file.
+ * @ctx:	[in]	dma-buf I/O context
+ * @file:	[in]	file
+ *
+ * Returns true if the context can be used to issue I/O to the given file.
+ */
+static inline bool dma_buf_io_file_compatible(const struct dma_buf_io_ctx *ctx,
+					      const struct file *file)
+{
+	return file->f_dma_io_tag == ctx->importer_tag;
+}
+
 int dma_buf_io_ctx_create(struct file *file,
 			   struct dma_buf *dmabuf,
 			   enum dma_data_direction dir,
diff --git a/include/linux/fs.h b/include/linux/fs.h
index 99caef43ff3c..a9bb63cf6f9d 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -1293,6 +1293,12 @@ struct file {
 		freeptr_t		f_freeptr;
 	};
 	file_ref_t			f_ref;
+
+	/*
+	 * A tag representing the underlying subsystem for dma-buf I/O.
+	 * See struct dma_buf_io_ctx::importer_tag.
+	 */
+	unsigned long			f_dma_io_tag;
 	/* --- cacheline 3 boundary (192 bytes) --- */
 } __randomize_layout
   __attribute__((aligned(4)));	/* lest something weird decides that 2 is OK */
-- 
2.54.0


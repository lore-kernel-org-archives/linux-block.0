Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.47
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793751568;
	b=NDr6OThWeNAhy1SIt6qOopNryWtknun5O7z1qguWQr8uGEpvPgzSIK2UMKWHvMSAY3vJ
	 akW37TudzwmOP3JcmlvWgvBOH30RxVX8rzp0DZdwUdYP0DWqEhQD+hopfzkaaEznbzHEc
	 DHrVdV+ymhhbrzhyH0Rouyg3FVc3Gk7EGLtfiEmYZNog6EV2dBmKLk+KLK/NrkH4WY+C2
	 5Bm/j1e89477vUtGtrUu/w4APwqh87eSpMkDeoviQjSPlIu2RkH/x0zKh+ZGA0c41lDeK
	 UJXZJpEzbllcbtutY8YZQjO2fgq8rpTLcSe9wbiQC0+pPviMwcDkNSi6GYoeEz4bPzA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793751568;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=GGAHJoXoaHYDS7ZVcS4Ysy1Ws2W94TVdrbuzvKnZ5Q4=;
	b=lz1LZRMh2QKOZi17B6y0kVvBsMIAQrAkxZESrt8ob7mauJOr9+4hYfnUSysrNmYX5Ohn
	 aDGxV8gIuHKOVB0SNaZynEWt5ul5wcF6+muf5hPUpFHEA8VjSMbMq3NwQwK2dDhnT3Yn0
	 Yycq6/53y64xuzj68Yhe5ONSYqIFPmxms/lA/WYRkf7FY4D4oICjeDECQQoWWuDwz+2It
	 SFsjz0ZZLubp9J01e140DXBEvBDly10rR/vhV8R7VyCwUNTfZ6f8OVu6v4D6zHn4NGjGH
	 RFzNo5K03bM0lmt9EiQFZ4om8x0qVhD2lqFb40YlKfiJZE3jJyYEKBIAdfLkdgLUv0A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="aqcmbjj/";
	arc=none smtp.remote-ip=209.85.221.47
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFA30606A328
	for <linux-block@vger.kernel.org>; Wed,  4 Nov 2026 00:19:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DFA30606A328
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=aqcmbjj/
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-48e20edd106so90941f8f.1
        for <linux-block@vger.kernel.org>; Tue, 03 Nov 2026 16:19:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793751566; x=1794356366; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=GGAHJoXoaHYDS7ZVcS4Ysy1Ws2W94TVdrbuzvKnZ5Q4=;
        b=aqcmbjj/IWzOkhPn945GltKgVAuWp1ceWZ4PcwlLjSUgP3pgLCeRJUSh0ZCERqiyBX
         BRUEwzA5Z8xgKIav5x8qMnG0g6orgm0+fafeQJR5uALlpITJemgYZ0F1WH87wHcFvnBU
         iOXxLrnLQwkdRO6nlEteWgXYV4Cv8LIP1HVaxL/mqH5vQt8+NxjuAL3gDJaGtaeRBNWb
         e8y0Zv3LmzgJgaHpG2wmrWPuYxkySs/xPswkQ12biHoWXbmGl6Os11AgxGOZb6W563OH
         dl/j7z99E03O0iXUVwWY/60ifcs1WdhHNDnyeOd7gotcaX3uexLytaLZamiZsZMwyWoK
         20SQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793751566; x=1794356366;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=GGAHJoXoaHYDS7ZVcS4Ysy1Ws2W94TVdrbuzvKnZ5Q4=;
        b=CB5Wr2yskOz0pl4IHiNmWsnh47TnO9LNXe0hwFvFzawqKWdmD3k/2k6tnY/yybw2Mu
         POamHcXTJ7nnM9a8sUCIgzJmQCMd7KrAzoPQJt1vmeCjseu7IxaohOHMYy7V5VOry8k7
         wmCjjFscORpg6UdGzBadHAtIbH0hxte2IuqjtX37fytybBhMzIpRSWuG4p0yZ3xXr/QN
         1QP98n+9Yagmvsyj7ANuUZGb6M9nEvarIoUT6cZ/Pzjt/DqjO1RpPfto9ydPJZWcI29U
         piZI74JFvx+47rQ5MCHxw7ts5v1yGUMqIJoH1l3mAtE2JMgtuDVnhVvEz2hVjyFGXbId
         18zw==
X-Gm-Message-State: APuU4Z8cS5vOSZwFXOhNVcAIVF1R+mlap2m9+jYTWYFKhkdSiSRA1R1R
	CAogzTc6apWIUUHEv7jcJn2sUyFIQzu6XmnlF0htGlOL7LMwb/lqJM+wTV5rpA==
X-Gm-Gg: AYBFou2HWL4Yy5BECOLRMvW8hkvgrEEujS0ge2n4qnLysyKyKAdNITUhEJl5aVpBSuA
	m+L9b+tAyeqz1jwdZBeXYnxC/5RBzCLzIJglfVxXEV02ucnpq9RlaUW4gbTcyq4SbJRJ46a5zxb
	KvwwqDKtvmtOEfrLOBCYBOrSiHhhTs+UyUAvcyWvg5KBtYEHN7CITj4PrT4lxB5U/mDWx5XY+DF
	Vw60CJZq+oLD2DlIja84JmJBvTJ0L7jZMwAnqHlZGGOv321wmFQl+jBO2EvhpUayN93XahNwVUv
	ty0VbdRs4zHUFLASQ6rJlXfS7D6BxPURSYCV7cEwp7ZIfuDJkQ9lpOUsyzGDhoOP42pf+lkjZDC
	N8Sy2h6HwsickMZf2HnYFYyVNNV2oQ/bZlvyhTIqK+A9lMwXuJ7y+AF2qYZaJw51b3MmNraz3wA
	8rlenLqryCvkPxIzYK2dSoQQTu11DuNyOJb9MmcppMULONLac/Y1Xr5DBO4MLriMUs315Bfgb+C
	8Pf4GW/LnHyp15LZvcGIkUOeq+fqa8n9bwIOahLnoi4ZnZ+33Qw7cc2J9Ngw/3XoGiiIGuGRcpf
	bVk4lG2tj2viuLzqtY/0t+foqDZ/I8LrBh0pkRzS2hR6jixLTp8QnP5+/LPCNBcuuyiJpH3pEPx
	gd9gAjcYQxbYbwJb3y5Ihm5NAZFTMVVc=
X-Received: by 2002:a05:6000:4a13:b0:48b:9d2:1a6a with SMTP id ffacd0b85a97d-48e6e2b9ce9mr32274342f8f.1.1793751566267;
        Tue, 03 Nov 2026 16:19:26 -0800 (PST)
Received: from 127.mynet ([2a01:4b00:bd21:4f00:7cc6:d3ca:494:116c])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48feda1fb0esm676676f8f.49.2026.11.03.16.19.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Nov 2026 16:19:24 -0800 (PST)
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
Subject: [PATCH 4/5] io_uring/dma-buf: switch to tag file filtering
Date: Wed,  4 Nov 2026 00:19:00 +0000
Message-ID: <7165ab453cc680276b88f47f9ae89bc4967543cd.1793751001.git.asml.silence@gmail.com>
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

Instead of enforcing that a dma-buf-io ctx is used only with the
registered file, allow sharing using tags.

Fixes: 62e4bf5b25d44 ("io_uring/rsrc: add dmabuf backed registered buffers")
Signed-off-by: Pavel Begunkov <asml.silence@gmail.com>
---
 io_uring/dma-buf.c | 3 +--
 io_uring/dma-buf.h | 6 ++----
 2 files changed, 3 insertions(+), 6 deletions(-)

diff --git a/io_uring/dma-buf.c b/io_uring/dma-buf.c
index 6f1d21c0f558..f25749f7da22 100644
--- a/io_uring/dma-buf.c
+++ b/io_uring/dma-buf.c
@@ -4,7 +4,6 @@ static inline void io_release_dmabuf(void *priv)
 {
 	struct io_buf_dma *bd = io_priv_to_dmabuf(priv);
 
-	fput(bd->target_file);
 	dma_buf_io_ctx_release(bd->ctx);
 	kfree(bd);
 }
@@ -52,13 +51,13 @@ int __io_register_dmabuf(struct io_ring_ctx *ctx,
 	if (ret)
 		goto err;
 
-	bd->target_file = target_file;
 	imu->len = dmabuf->size;
 	imu->release = io_release_dmabuf;
 	imu->priv = bd;
 	imu->flags = IO_REGBUF_F_DMABUF;
 	imu->dir = IO_BUF_DEST | IO_BUF_SOURCE;
 	dma_buf_put(dmabuf);
+	fput(target_file);
 	return 0;
 err:
 	kfree(bd);
diff --git a/io_uring/dma-buf.h b/io_uring/dma-buf.h
index a97412ebbb3f..9bd7c8c64397 100644
--- a/io_uring/dma-buf.h
+++ b/io_uring/dma-buf.h
@@ -9,7 +9,6 @@
 
 struct io_buf_dma {
 	struct dma_buf_io_ctx		*ctx;
-	struct file			*target_file;
 };
 
 static inline struct io_buf_dma *io_priv_to_dmabuf(void *data)
@@ -63,11 +62,10 @@ static inline int io_import_dmabuf_map(struct io_kiocb *req,
 				struct io_mapped_ubuf *imu,
 				size_t len, size_t offset)
 {
-	struct io_buf_dma *bd = io_buf_to_dmabuf(imu);
-
 	if (!IS_ENABLED(CONFIG_DMA_SHARED_BUFFER))
 		return -EOPNOTSUPP;
-	if (req->file != bd->target_file)
+	if (unlikely(!dma_buf_io_file_compatible(io_buf_to_dmabuf(imu)->ctx,
+						 req->file)))
 		return -EBADF;
 	req->flags |= REQ_F_DMABUF;
 	iov_iter_dmabuf_map(iter, ddir, NULL, offset, len);
-- 
2.54.0


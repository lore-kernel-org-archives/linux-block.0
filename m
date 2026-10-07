Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C80633587DE
	for <linux-block@vger.kernel.org>; Wed,  7 Oct 2026 01:43:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791337411; cv=none; b=XuGcsPoWBtDLCk4OTaajSN+D7JbX21tq29rgVPybwjYfDCQ6YwSchWSibKXlaV8kPNhEz9PwzZGh2oVrQO/bSI/U4VIupJEBfg0nNYh7dUFw1VhudtZ1RtGJslOZvLrb6hejFwYx3ljzOFWDu2toXXjZt5Jaf4ir0yDOAZbMHlc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791337411; c=relaxed/simple;
	bh=sZSKKXCePxitJxwkXP2zXOFTkw2i/N+YLyO84coSzgs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DihlX6tsLcTP3IU5wxZoEiwp3MR7/deFYXJG1GnODIii8w8OQ5lf+aOH903BjCVd5RbYABvyDcPZ1qQMgrUEklJAgCg9nIKHyWDLQEKQau/d4I7bALDiMzxlepyZKosFKQWASrNyXJfxWI0RLFup6MEoipIlFxAyuimJafA5oXY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=i0mCfzRz; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="i0mCfzRz"
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-4a02718da81so10913845e9.1
        for <linux-block@vger.kernel.org>; Tue, 06 Oct 2026 18:43:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791337408; x=1791942208; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=PKjZvbLAs20rdhF/f8LJ7mlj5bzqJB3zMFv/Fdm/dPM=;
        b=i0mCfzRzmqfW6J831riZkb5XykprHAqrwGBVDP+PlPdfkwZPl14Rr9hlnNkmM1MHmU
         W7Bypdwk2b3vsowqx1ZsUFdKVCo/1qCGjSojul9QV3CZqNp5uJJ0Xrmf2n+eEuWnuuXk
         PnYGkQqcNyqtukRc+qPbGbTOiVWVaK7N0OpVIzU6xJWsjLdk3nPbg102fHC1NdeOBs0Y
         GAxsHFfKwy8zEQ2/i4I468JP7vBjmUu0I5JTIYiJG29+kqOtTl3Q6dKsPmCU6HczbmW1
         jXVdKuxWZ02YHa8JFd5tCnbEcfMXcEwZvNY9XQXdx6ubuQn39DXDQowgdFR9+HfLACRY
         fXRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791337408; x=1791942208;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=PKjZvbLAs20rdhF/f8LJ7mlj5bzqJB3zMFv/Fdm/dPM=;
        b=GrrYsO5kyWcpy5RLy4wtCBlfL0gEzdtsNlMdhPv9JbGfkYgRtMV2wq2pbHqdnr3Ezw
         UeEWWi5mWIza3ztwlfsbIv2/zmqzO438kDd3bjMWUxHrBHDyXb+pfC/6tRZRDt4CBfR6
         2rzqCIHL43IiqEE4yNz5TQ2D81W9IMrgqF6yFufCl6G6lI/yrTFwXXA8tRtLxeTN6oh+
         lmXUom4hIy1v/Uy0cMxqO2Vh5UgoX1MmylBTzwqtn0cwcO3NM6iv2sYeQSqa5oUR74j+
         aIQiXC3oG/AZunQBQ9Co3Sc0RkeTv6nfFxblgAn+kR65MmEQb7NOPZ0nExFZ69gsYhA2
         MIXg==
X-Gm-Message-State: AFuF++nOUGv5Zb+S5hMUgPy6NNm1vf31b6iBOyY8HIoK7HoLZ7p+ZIRX
	A7gUQ3yDNx+/5llCu9GJkPuNbjM26yVw3w3DwlXQRicJqjxH0ZnWvn3gWRVoRg==
X-Gm-Gg: AYBFou13iUh/+LNztHcBg+vKYoNcRVgpO3Or1u2uZD3Y//eKHs5fk2l/9LlsutH4VR8
	Q2LHOQyGafrMLw815Rtw1oVZPow/miKqrgb+4BTqKWWRVwiPAkU2aoWtWcfsW3rUBohU8VEKM2s
	0sUD5JtBkKEccruWVRGS44NjbMb2WCpb9+efLX43CeX/Uf9uJBhYXsuzwQkfCFDOqgEcsWtnd4S
	7SpeAsC2QLeOlmvBtJA7L+eoTY8XEeRndr3iY7KrJ973aY/JL3J4qLqkQFekT5Tep0HcmW7poxJ
	GXeBB96KE0p8h26nhJPy7KRF3DSzKqPc068TiAtjw6wRXvGHxg1kosXPq5voFcMBJgN5PDuBxFo
	fcboYMNoW4TKdFmxQ0VwnyHKRz/tZWyX1HR/Ap1SY0iEOb1raeKZEr31pm/x1QrDuWh87NSmsoA
	Q+ka4pSjtOsjEYIEjpj/rwGsXzCDFqiGt1fFYe1awjuo4ysyY1962uDWQuSGY7GXwl/twuw4ox7
	+kykFLdd+nfpkftq2gpkcfZB1djAtogpdchegg2pUx6h8Voh9rLI9yiPi/M5d0PEpfuF30sXVkM
X-Received: by 2002:a05:600c:1911:b0:4a1:78c5:79f5 with SMTP id 5b1f17b1804b1-4a180455696mr7216955e9.33.1791337408104;
        Tue, 06 Oct 2026 18:43:28 -0700 (PDT)
Received: from 127.mynet ([2a01:4b00:bd21:4f00:7cc6:d3ca:494:116c])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a17f653d7csm26423895e9.14.2026.10.06.18.43.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Oct 2026 18:43:27 -0700 (PDT)
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
Subject: [PATCH v9 11/13] io_uring/rsrc: add uncloneable regbuf flag
Date: Wed,  7 Oct 2026 02:42:54 +0100
Message-ID: <e46bb4ba345595eb920f2e14077f7f3d3b044d0f.1791336930.git.asml.silence@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <cover.1791336930.git.asml.silence@gmail.com>
References: <cover.1791336930.git.asml.silence@gmail.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

It's hard to implement cloning if the internal structure needs to be
mutable and/or relies on other ring resources. In preparation to such
buffer types, add a flag indicating that the buffer can't be cloned. It
might be possible to add cloning in the future for them, but that would
likely need reallocating the structure and reacquiring resources in case
by case manner.

Signed-off-by: Pavel Begunkov <asml.silence@gmail.com>
---
 io_uring/rsrc.c | 5 +++++
 io_uring/rsrc.h | 3 ++-
 2 files changed, 7 insertions(+), 1 deletion(-)

diff --git a/io_uring/rsrc.c b/io_uring/rsrc.c
index 77e6929f665d..6930a6897b41 100644
--- a/io_uring/rsrc.c
+++ b/io_uring/rsrc.c
@@ -1456,6 +1456,11 @@ static int io_clone_buffers(struct io_ring_ctx *ctx, struct io_ring_ctx *src_ctx
 		if (!src_node) {
 			dst_node = NULL;
 		} else {
+			if (src_node->buf->flags & IO_REGBUF_F_UNCLONEABLE) {
+				io_rsrc_data_free(ctx, &data);
+				return -EOPNOTSUPP;
+			}
+
 			dst_node = io_rsrc_node_alloc(ctx, IORING_RSRC_BUFFER);
 			if (!dst_node) {
 				io_rsrc_data_free(ctx, &data);
diff --git a/io_uring/rsrc.h b/io_uring/rsrc.h
index 9ef88383b363..73d7b1ebf0b6 100644
--- a/io_uring/rsrc.h
+++ b/io_uring/rsrc.h
@@ -26,7 +26,8 @@ struct io_rsrc_node {
 };
 
 enum {
-	IO_REGBUF_F_KBUF		= 1,
+	IO_REGBUF_F_KBUF		= 1 << 0,
+	IO_REGBUF_F_UNCLONEABLE		= 1 << 1,
 };
 
 struct io_mapped_ubuf {
-- 
2.54.0


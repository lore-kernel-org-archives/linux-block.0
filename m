Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.47
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793751565;
	b=AGW+/EPKFwezOAnk/SrvOTGV6Ix+moDcCGBLzWgDP1x0zSkfmd7hXg8duvCEu2QuHBrw
	 BNnZu2JfMOoP6/nxG0p6gr8/+OTR3Anc4BxuZHSJ8s85e1NB/irMuOi+ubldeCmoWOxeg
	 jpiMok1S+Vk192DuTCmpu93pIj/YKV/WGrhALn6pkoVe9gGL6A/9kNWG7uV4TIWUhfb01
	 sgSQGdXv/Ve9Uvl4egPqiJChssVnJUhvQCMgWo+u6c+C/Sn1zd7AHJ+FJU07/Ir8Ov9w4
	 hHCKw1OrtKvGVrgVceXqwJJuQA/d/ziC1mviz8I1Q+7QULyC8Bf7+d+HNdkWHD3x5Ew==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793751565;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=XVYAkQiJxcRVRCy/m307F8zyGYSwmQhGdJmr4iFyUcg=;
	b=tdu/3CKX71tiyIShNNp5TznKLZjrCSVdAEMtqL41mwV8KJ6xJMGarVde7o5KoeZSB1Uu
	 SrNTNOk2IwJxi9Wv504Ya/sCkfH61G+omyDWWussgq9nzF5F6kToDRdoybxwpmmY5bi9N
	 2mPuTUFEvnohsAL0EgkBzgXpZxPbdxoeCmvFDZhC7X2ce0gSgJDKm026aJst0GEAQo2BI
	 JCRNcYCK36oXDJXPRGEg6lqefqhsGF7OP6FyCx17dRLGrM6J72EfBjQ8X1HVJX2G97HMT
	 xXBiHQ69tsdNASrkUsdiREuQn8oGbYHrMTKMk80D3xURIbrGbI0yTpbUJva+a9tIJeA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ubHDxxZj;
	arc=none smtp.remote-ip=209.85.221.47
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDF22606A329
	for <linux-block@vger.kernel.org>; Wed,  4 Nov 2026 00:19:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org EDF22606A329
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ubHDxxZj
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-48e20ed3b9dso106095f8f.2
        for <linux-block@vger.kernel.org>; Tue, 03 Nov 2026 16:19:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793751563; x=1794356363; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=XVYAkQiJxcRVRCy/m307F8zyGYSwmQhGdJmr4iFyUcg=;
        b=ubHDxxZj7rU5XinezEEZWcKP0nRzW3AwNFt5hy58vHf3T1o4Qx1PHGZgNPVDniG8gJ
         cYrsILGN1FBWy75lXmZUSYF3+AN1Svm3edvlRj2Sxu5EvSyHtoggU6vLH51eJDpSrK5T
         10IoJBC2S484EOwmf/KQCB6+54VFFbrgZ/QOXvI6pNj6dVEo+8UhDLxVI0YHlToXNxFO
         5cHnvS/z+1Nc7tzErbZvOKmbxwNteSUlofkVUMWJClgZQsUpoO59CNT/sTHvpf33zI6e
         ysaZEPYfcdyEJZ5k1dWEusf3nj78SP6JNirFZ7APQYBR6SUmK9u9klK1nv8jERrTOeux
         A3PA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793751563; x=1794356363;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=XVYAkQiJxcRVRCy/m307F8zyGYSwmQhGdJmr4iFyUcg=;
        b=cO5chPnU0e2uYOpm8UY6bJGVARijzQf7zCZ4c2piT4wtCTVAI4X3/tCWYOqVT3wHp3
         JkCr25ZcGChm5k2TOrGRNMbYI5vYsQazzMY90XmWBYveXdI9b7PlE0bYSAeVGRPM5I/x
         KkQbHNeQcY2ecov6MGVTXcp07ROoRMJh3xTL52m+ILGcWVQ/tbDSPSG3J60ZeJmQGRAH
         QJVosZbvBrwPv1Md+UaLecDrm3EvpOIERlRnUVpQnbEYx9fu31kSi0E2d9f6DIknh5d/
         WIWGcjYSoKZOz6kelu2ZfMfPUaaSQ0wOVTjeAgKpS5kXllPdf+n6WgeqedxAou0uPsNB
         5ueQ==
X-Gm-Message-State: APuU4Z+bFWzFNaNs3ifag9d+KBaeP6bLHoe4ONB16LrK5YheBVsqJnBD
	eK6d9mhkDBK27nJQ+2Xx6vxgKOipZ18bNm8WNvhc8ZHaEuNavBNMf+7VIdHPWg==
X-Gm-Gg: AYBFou3+KKwMF0Yhb4p1iAft2/5WGrKJ0peCZgk6X14VP/sJqO2Now1fCo2CHIqvdbf
	x8J9Zy77fVTIeDDYYwFijISHD/52ZrO/4ngslP9Lp+IWYlspGU0THR6Ulhv8OAIZzmRfyaP7XuT
	qXwMGtk4B7pgk3faNZSTvIwHdpEtnAj5bgMSTOfBQxCcNRTmL+yFZBZCNSVpqRD5WuDLETRI713
	5ofmoMmHDlYLwvfPer4lGm9ghIWluE7TM9E5j2ocRXEohc4FZ7As7Hiq3z18ONLaegXoiiTDccm
	Pw3WAVeF1zZPxM7vCR44BD+jttlgrhCTYWbk/o8aYQz2dV+MMIKK7N/qqwxewNwVyy7y9/ylFZc
	dQevQ5SYH0yjxx2U7GHEWfb18LwczGCj+rV7I633zAxBWAKLxYOOFAaELLz07YI+O67I4oazdch
	b7EErhI4yzh6uFbUSKMsKup+DmuP9FT5VmY3+EEEv/IrJh35fvT/0UH+9UuxDgVGwXovQ8B4Lix
	r8h9LhOXdGvCO9B01fMJDSsP6pgG4+HjVZ4SSBvg8eQE+A4N6d8YYnjn3/K9X9a1rjTkt91LX30
	3Ii0taFXoDVSP+ds5xHUGLTthNlMdY0M5OInO1FYfR0WwoZOeN4fcq28KyXbqGAjGXa3Gbp/T3c
	Yn8rj5qCjq6PLC7a3ePzI3J1Pq4MgRLE=
X-Received: by 2002:a5d:59c4:0:b0:48e:3085:425f with SMTP id ffacd0b85a97d-48e6e2dbbdamr34641010f8f.2.1793751563267;
        Tue, 03 Nov 2026 16:19:23 -0800 (PST)
Received: from 127.mynet ([2a01:4b00:bd21:4f00:7cc6:d3ca:494:116c])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48feda1fb0esm676676f8f.49.2026.11.03.16.19.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Nov 2026 16:19:21 -0800 (PST)
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
Subject: [PATCH 3/5] io_uring: add data to dma-buf convertion helpers
Date: Wed,  4 Nov 2026 00:18:59 +0000
Message-ID: <e9e74cb1d6e46f62e29b0934fa9c1e7f2d2c1e3b.1793751001.git.asml.silence@gmail.com>
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

struct io_buf_dma is stored as void * in registered buffers, and it's
casted in multiple places. It's inconvenient as void* casts can't be
type checked, so wrap all of them into helpers and keep casting
centralised. No functional changes.

Fixes: 62e4bf5b25d44 ("io_uring/rsrc: add dmabuf backed registered buffers")
Signed-off-by: Pavel Begunkov <asml.silence@gmail.com>
---
 io_uring/dma-buf.c |  2 +-
 io_uring/dma-buf.h | 14 ++++++++++++--
 2 files changed, 13 insertions(+), 3 deletions(-)

diff --git a/io_uring/dma-buf.c b/io_uring/dma-buf.c
index 132e3d0d7023..6f1d21c0f558 100644
--- a/io_uring/dma-buf.c
+++ b/io_uring/dma-buf.c
@@ -2,7 +2,7 @@
 
 static inline void io_release_dmabuf(void *priv)
 {
-	struct io_buf_dma *bd = priv;
+	struct io_buf_dma *bd = io_priv_to_dmabuf(priv);
 
 	fput(bd->target_file);
 	dma_buf_io_ctx_release(bd->ctx);
diff --git a/io_uring/dma-buf.h b/io_uring/dma-buf.h
index 534c06b6879f..a97412ebbb3f 100644
--- a/io_uring/dma-buf.h
+++ b/io_uring/dma-buf.h
@@ -12,6 +12,16 @@ struct io_buf_dma {
 	struct file			*target_file;
 };
 
+static inline struct io_buf_dma *io_priv_to_dmabuf(void *data)
+{
+	return data;
+}
+
+static inline struct io_buf_dma *io_buf_to_dmabuf(struct io_mapped_ubuf *imu)
+{
+	return io_priv_to_dmabuf(imu->priv);
+}
+
 int __io_register_dmabuf(struct io_ring_ctx *ctx,
 			struct io_uring_regbuf_desc *desc,
 			struct io_mapped_ubuf *imu);
@@ -39,7 +49,7 @@ static inline int io_attach_dmabuf_map(struct io_kiocb *req,
 	if (!IS_ENABLED(CONFIG_DMA_SHARED_BUFFER))
 		return -EOPNOTSUPP;
 
-	bd = req->buf_node->buf->priv;
+	bd = io_buf_to_dmabuf(req->buf_node->buf);
 	map = dma_buf_io_get_map(bd->ctx, nowait);
 	if (unlikely(IS_ERR(map)))
 		return PTR_ERR(map);
@@ -53,7 +63,7 @@ static inline int io_import_dmabuf_map(struct io_kiocb *req,
 				struct io_mapped_ubuf *imu,
 				size_t len, size_t offset)
 {
-	struct io_buf_dma *bd = imu->priv;
+	struct io_buf_dma *bd = io_buf_to_dmabuf(imu);
 
 	if (!IS_ENABLED(CONFIG_DMA_SHARED_BUFFER))
 		return -EOPNOTSUPP;
-- 
2.54.0


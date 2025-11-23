Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8C1127A460
	for <linux-block@vger.kernel.org>; Sun, 23 Nov 2025 22:51:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763938305; cv=none; b=AN/V59IamLYnXo0HigyUtRz8iBG3V7jODzf5xcxhAEMEI3QwAmmVrxw9nBPAjHPCduZGKG2Kiu3SUDRMuea8vXrs1XCp8b2JRUH0cXV4Wno5r8IrIPHBdNGhbEuGproXvSDJL4GWg5vTAqJ3wz44fX7FvTxYKAUVlDjHDoX38nE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763938305; c=relaxed/simple;
	bh=TaA27OxA1hBFyRB5sQEZB6XkCgdFpDueoKtHtp+vFGM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GjBZDDw24ZL5cXvQlrGzEdZfA+bVSFZkJstQyg/lPX2fQkBZlEdI752gwa6KqEBwBVeGcZwGGJmeiDUHQmwufYHqT44QB8+y9DyNn+5oE7VOyxQ3VoBzdN+rTh6kbqPKae51aw8UaC6QAKewUya2KmeU5pki/E8n9Z2FZickLQY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ftiNcTx1; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ftiNcTx1"
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-42b2dc17965so3606906f8f.3
        for <linux-block@vger.kernel.org>; Sun, 23 Nov 2025 14:51:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763938301; x=1764543101; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PR8DhyhbmfM3XR45v/DX3VtwAUQ7pza2V3aAfSC4t8o=;
        b=ftiNcTx13YdP4WuIFjBYEQY9qh3Zw5EizPLOwUI0Oo29LmHJH65J9m5pF9tilsgK4R
         Rahz3xxfxLMMQwK14JXW532fLPTYPEwkK3ER1iCLC6qfx/26ECwO0Rv2iU494tZ7Nj+n
         kNNDxSdI9r705Qgcb7Msyeau1ATIy0ChwWxeIzgVQRW8cVAikB/9IKpzTRZmBmDB6vW6
         fkxIN2vlVHGp7KWT88WoGGAU7COpoAKtaSOaDVh5PRcaok/AAmVbDQqger9TwVxKz6/X
         Xn6IB6EtTFeqJLZ6w5szBwq5njjyzULzOsqBp2lw4WThiqTSW1xjDSUFxEnTbVJOKv58
         oC2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763938301; x=1764543101;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=PR8DhyhbmfM3XR45v/DX3VtwAUQ7pza2V3aAfSC4t8o=;
        b=husvzu83uhh0EEBUbd8RGxzpi9z5BM1XGhK1e9neKz7tbZg2S/IqqjyrcS/UnY3eS8
         fa4X/5Wb0yo6zv1iFdN1eI7Ca3vASX4wXPeq+nXcy0A2DAI8VyysNk7sPk8gj1rx9M0Y
         TMrNjlXY/vsZYqv+4y4cQToic2/GYLEKMbzurfUwbt4R4xsJ82M0vbpToy/GZR0WBdzm
         WnxHqU0mN0S4WKSEWVJ4d+CM6Ha1Dq7KM4IEIyaUl6DxMpibhgd3fEYK1BG1YfzuEeYf
         pLUqAYvTV3JFMGp2sXqZ2do1Wplsy2gqLsj6D44kStpGM7DnN8iIPTwVXEVj/RZOJgE+
         Sz/Q==
X-Gm-Message-State: AOJu0YySi7/08+BVphMAMKnYguhRRC3tGPjLukfus38dVb0t83E3yHaA
	ifU21UNBVluJtXh6BzUUvwZGJ2Xhuja7d89L2avV7H11pJ4OOPYE5mQr3dfMdA==
X-Gm-Gg: ASbGncv6s6k8SLzPzYALo6iB/lcmhQIs0Kcad2sGnyR8PjQHDtZHbrOJP1tuNiyIkpX
	/vup9Y5QRLNmBnNaOhN6BhKoynHXqDFm4f1PgcLr5UIK4a7LBv2WcDaMtk6fPrQpOKnNWfvICte
	PKIrJc5G9AbEqWZbAQk8Nm38M6Qc906eiW5n03ErIS+p4WJt+qW58pnkckyv42hsHvpGHZFIQBH
	0VNdukXFLDDMYaUPRbHIehw5ZKO3PjBkWnjUQYpvOTbpLulnoH1p7qYNbVA3y7Lj4nN1WoGC3YD
	M6ArV++s82fnHFt96tdWeagJvp/THHI3457fZVBw1gaUEwa5t46nXn3UlWKCDKP/wmDfYtiKjFV
	RYwWEWpuRUPEoN7S+37zHIU2IZdxCrvhfL4pI30gTKhx2Cma33jx9ntacbq1F6QkX90mjfVrTdv
	iFTfWyJ3RIYQvf8A==
X-Google-Smtp-Source: AGHT+IF2fkOx1psmIiI8t6n1UVP6WxxL86e2rgF4bc5zvWBkXEsJkKhYvtgfzcrreOJ89mrZR3pH7Q==
X-Received: by 2002:a05:6000:40da:b0:42b:47da:c316 with SMTP id ffacd0b85a97d-42cc1cc30c2mr10114899f8f.26.1763938301503;
        Sun, 23 Nov 2025 14:51:41 -0800 (PST)
Received: from 127.mynet ([2a01:4b00:bd21:4f00:7cc6:d3ca:494:116c])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-42cb7fb9190sm24849064f8f.33.2025.11.23.14.51.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 23 Nov 2025 14:51:40 -0800 (PST)
From: Pavel Begunkov <asml.silence@gmail.com>
To: linux-block@vger.kernel.org,
	io-uring@vger.kernel.org
Cc: Vishal Verma <vishal1.verma@intel.com>,
	tushar.gohad@intel.com,
	Keith Busch <kbusch@kernel.org>,
	Jens Axboe <axboe@kernel.dk>,
	Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Sumit Semwal <sumit.semwal@linaro.org>,
	=?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
	Pavel Begunkov <asml.silence@gmail.com>,
	linux-kernel@vger.kernel.org,
	linux-nvme@lists.infradead.org,
	linux-fsdevel@vger.kernel.org,
	linux-media@vger.kernel.org,
	dri-devel@lists.freedesktop.org,
	linaro-mm-sig@lists.linaro.org
Subject: [RFC v2 01/11] file: add callback for pre-mapping dmabuf
Date: Sun, 23 Nov 2025 22:51:21 +0000
Message-ID: <74d689540fa200fe37f1a930165357a92fe9e68c.1763725387.git.asml.silence@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <cover.1763725387.git.asml.silence@gmail.com>
References: <cover.1763725387.git.asml.silence@gmail.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add a file callback that maps a dmabuf for the given file and returns
an opaque token of type struct dma_token representing the mapping. The
implementation details are hidden from the caller, and the implementors
are normally expected to extend the structure.

The callback callers will be able to pass the token with an IO request,
which implemented in following patches as a new iterator type. The user
should release the token once it's not needed by calling the provided
release callback via appropriate helpers.

Signed-off-by: Pavel Begunkov <asml.silence@gmail.com>
---
 include/linux/dma_token.h | 35 +++++++++++++++++++++++++++++++++++
 include/linux/fs.h        |  4 ++++
 2 files changed, 39 insertions(+)
 create mode 100644 include/linux/dma_token.h

diff --git a/include/linux/dma_token.h b/include/linux/dma_token.h
new file mode 100644
index 000000000000..9194b34282c2
--- /dev/null
+++ b/include/linux/dma_token.h
@@ -0,0 +1,35 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef _LINUX_DMA_TOKEN_H
+#define _LINUX_DMA_TOKEN_H
+
+#include <linux/dma-buf.h>
+
+struct dma_token_params {
+	struct dma_buf			*dmabuf;
+	enum dma_data_direction		dir;
+};
+
+struct dma_token {
+	void (*release)(struct dma_token *);
+};
+
+static inline void dma_token_release(struct dma_token *token)
+{
+	token->release(token);
+}
+
+static inline struct dma_token *
+dma_token_create(struct file *file, struct dma_token_params *params)
+{
+	struct dma_token *res;
+
+	if (!file->f_op->dma_map)
+		return ERR_PTR(-EOPNOTSUPP);
+	res = file->f_op->dma_map(file, params);
+
+	WARN_ON_ONCE(!IS_ERR(res) && !res->release);
+
+	return res;
+}
+
+#endif
diff --git a/include/linux/fs.h b/include/linux/fs.h
index c895146c1444..0ce9a53fabec 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -2262,6 +2262,8 @@ struct dir_context {
 struct iov_iter;
 struct io_uring_cmd;
 struct offset_ctx;
+struct dma_token;
+struct dma_token_params;
 
 typedef unsigned int __bitwise fop_flags_t;
 
@@ -2309,6 +2311,8 @@ struct file_operations {
 	int (*uring_cmd_iopoll)(struct io_uring_cmd *, struct io_comp_batch *,
 				unsigned int poll_flags);
 	int (*mmap_prepare)(struct vm_area_desc *);
+	struct dma_token *(*dma_map)(struct file *,
+				     struct dma_token_params *);
 } __randomize_layout;
 
 /* Supports async buffered reads */
-- 
2.52.0


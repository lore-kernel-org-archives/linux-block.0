Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AF5C37F00D
	for <linux-block@vger.kernel.org>; Wed, 29 Apr 2026 15:26:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777476387; cv=none; b=OGyIcf7T5PawvXbSgJcFIXqtPbRWLk+viObBv5BcXfjhKCnS7yDiUYyPQuPRPei4wo1+b7lZQqIqRjftZ6gg8BSe0iDrTrgCJqyD7LIvsZelz/brcEEN4RPQbl9FMCNS369iqJsDYdrv8vFf4JYU+9SydQopBkuEATO3Dou4dUM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777476387; c=relaxed/simple;
	bh=dwXXUn2/AXYocQMBrxdXlK4QY//00n+FpUG8ksJYzZ4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=F/CgsZBXttdgqBRuFIGRvhXxvTZX+KSgGE6jDmJ9DIbBMpQIf2ZcB6jO37DS1dau7sfSnrXlmTy6GFR9ncoNvdiNukhRd3VuZ+NqLDvKqSP9xTzcppZg82xBfL6W7VsTxWsLV79COmZXvA3zNpuTREBcirQ+Wvec5KB7ceZ5OE4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Q//38A29; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Q//38A29"
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-488a88aeec9so154032685e9.2
        for <linux-block@vger.kernel.org>; Wed, 29 Apr 2026 08:26:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777476383; x=1778081183; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Bz5U140iikgjy9qkhQv9ANNAasoYi2fY/CedhAQlGZc=;
        b=Q//38A29BIyAwvgVfxuarwdkkCIkYkoEgnlCZ1ZWTVC9bBGBlbwjWMLO+PCyW3pZb3
         /pU/BZg1FEtUrImeH+eXGiGHqna2ZvIWgk+L6yR86y2B0VdaVlYkeMunR7khoFxE4S8J
         0FNUd76MGFcBRZ5OxoP4ajvEzZZMXCSTkGLykLqyP0Ab+gFIXaGbWxh2fVbPdhx2Z9ZJ
         KEn1sba+9jRPPUOBVsvW0+1xOMEdWejyHJKwKElkTfsdDWcEYtTzEgQw3k+6VtHwcQUk
         tNSQwq6YhbSfLlBF0fbYnD0bGUK6JS4s8nem1hUMV56iM3cdlycEqDt4GJcUEtO5p6XO
         1Mlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777476383; x=1778081183;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Bz5U140iikgjy9qkhQv9ANNAasoYi2fY/CedhAQlGZc=;
        b=IeYRkxcBr8uL+p0DFbarLSFca6o6P4ahSwatftHEvzRsYnht9gmxvdl/4358moY0Sh
         BtJi4nYBG2e0kDaK2PMXlSw/luwEpDxdi51Z4EX3+xBfYZHBd4zOm3sBQJ4+Vr6YlWyM
         cVWYPuUsn7Cr/e2SxTyf4X+VAX042t3TYx47PgqcjqX35sAyKT4OdMKmW43ThiIPKNDM
         h3ujujrmCGwX9U1Q9/9TlDLxbv1kUdnm6RgAPc57bfpmZQRuj0LbUOmv/zuz78D6s91i
         6+Z2rgqXhsSQ7IKfAWiLd71tNOjUECFo7wTTVrBqfhRwom9vFfQD5YS70e+6kOn3fBOs
         dy1Q==
X-Forwarded-Encrypted: i=1; AFNElJ+mkOfCwfCXvjFqIkIDS7mwlw7eMnAvAHl/y20xtdALH1++hk24lofoTuFHJ5Cgkn2Zxx0qDxL1DLoeuw==@vger.kernel.org
X-Gm-Message-State: AOJu0YxWBND+i8ob/DWCHumj63veWTFqbj65uA1iknMHH5qBPUa2XbIw
	N93os78Ew3iJr424vU76WJkP8DY7l23+Jskg57OltDpLnhPFzNhsUYId
X-Gm-Gg: AeBDieuCHXF7eeAQSk7B5L2qVU18sdY5gKGVNEAMbZI/9Pz1HDc+UR42QkHjbpqxQGa
	6qPpFAXh5r5Tm7VyW4U9U8KglwutY6MAuMnxFynsQU8X6Hz4LCclP512nBsdManCBHOOjXcUXRB
	DFteIl9Ku5mx8Zfg/3GAp3teucpIB7HrOZ3XStilYxvmg5kRyc/+eqphckjmH9cUrjWloh1pXfB
	IJ0VGXVNvGcb5HHfAUl/Td52Rsays2b3StoZqam/czH85H8eKIASict70ZCKWMptrefw4IfShVc
	PEWV0EPGQTxelKM3Y51VU+rgfMp7n3CZmE4I5GjlPTSv8ZgcfwZE9le1bDtB0aJC9xmCPcE6bTN
	YfpOF5/w8se8FwpIoxu9u5+HxL3LE2u+eUSTbg8UuIbOMwV8rzx5lrWNmhxUWFI670jMxuUI4Z1
	VLJjJq9rT0KTOQruTc7fICbRAcenlAPuWha2z6Kc0bqpSIWKgwjYmIFaPXuECS1aEQtQb8RrfXx
	Wh8LkTUjlKJqkNqSziL4ApOXwsXjq5+sRRROopfLjab
X-Received: by 2002:a05:600c:3b13:b0:48a:52ee:5776 with SMTP id 5b1f17b1804b1-48a77ae049fmr129049305e9.11.1777476382406;
        Wed, 29 Apr 2026 08:26:22 -0700 (PDT)
Received: from 127.0.0.1localhost ([82.132.184.31])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-447b76e5c22sm6382951f8f.28.2026.04.29.08.26.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Apr 2026 08:26:21 -0700 (PDT)
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
Subject: [PATCH v3 01/10] file: add callback for creating long-term dmabuf maps
Date: Wed, 29 Apr 2026 16:25:47 +0100
Message-ID: <ae941457cf6cacb9d4c16b6ec904da9ef7fed97f.1777475843.git.asml.silence@gmail.com>
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

Introduce a new file callback that allows creating long-term dma
mapping. All necessary information together with a dmabuf will be passed
in the second argument of type struct io_dmabuf_token, which will be
defined in following patches.

Signed-off-by: Pavel Begunkov <asml.silence@gmail.com>
---
 include/linux/fs.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/include/linux/fs.h b/include/linux/fs.h
index b5b01bb22d12..c5558aab4628 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -1920,6 +1920,7 @@ struct dir_context {
 
 struct io_uring_cmd;
 struct offset_ctx;
+struct io_dmabuf_token;
 
 typedef unsigned int __bitwise fop_flags_t;
 
@@ -1967,6 +1968,7 @@ struct file_operations {
 	int (*uring_cmd_iopoll)(struct io_uring_cmd *, struct io_comp_batch *,
 				unsigned int poll_flags);
 	int (*mmap_prepare)(struct vm_area_desc *);
+	int (*create_dmabuf_token)(struct file *, struct io_dmabuf_token *);
 } __randomize_layout;
 
 /* Supports async buffered reads */
-- 
2.53.0


Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71F9D318156
	for <linux-block@vger.kernel.org>; Mon,  3 Nov 2025 16:37:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762187878; cv=none; b=U2DycJpEjTNyUHjTglpX3yaYp5Y2JsRVM73C5r2Wtd6XIRVYe0qDHGSe8/my8U2BOYNAOTm5JeDYYMKWthbT7jDen8yxyiK2C8zP6rv4tfnxFU124wX7ULgsyADjoJJxZ6w28oWxHheCY4BjRfthcSz9FhauTXQtdDqVbgYrx+A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762187878; c=relaxed/simple;
	bh=/RxgV6GAH6nY0rXVs+txNdzsVeVssdpXirByBf12lhc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gJpAFIZpchYP4U1tlp9MZhsD/P22CRhONBQTdkor3a5ESenkadOaUGbouf+itqXT6FVwLgstNn1m6dsOayGXDMs6hxygVY5dw9vW/5ESzXK8HLgzjJ2RxjYATrYIwXKaBwTd0awiZBPyQbqN6p0dp2wBvCNmcRq9TQcgjCqntAo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mKLhAAW/; arc=none smtp.client-ip=209.85.216.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mKLhAAW/"
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-3401314d845so6072984a91.1
        for <linux-block@vger.kernel.org>; Mon, 03 Nov 2025 08:37:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762187873; x=1762792673; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3dK/8sGZIswEav0IUiwDZwm9zq0rJ+LZHDAICuhXs0I=;
        b=mKLhAAW/yCu07piNY6FX8/jhybjhJ1R8eFmjNDiHryiLluC7Ur+3VCgji+gLIEkEm3
         4Clz44KVrBP199YoDaRREEdn3k6uhpo40mrA24MrzVsyUfooz4Abkjq17jsqsJ1SF4iG
         gcfpBvriE9yx2lQkBbk5wINE44+nyYylnD+/AafdTYpFF9WKNiR6kiYXhZTAzcu3zO2I
         R1fHxF+fkRJsEFVsyBQHaWK0r3CnPiCuaqV9QYpd4581PM/7LZOrCd+Z1hRnCfd/ylDX
         ks9juwkNLpj+lPt9u2I4QqeYpBOI8nZWUrIIvxJNSL0zTlhlQ2zK9ryy+Sjf5oIaLcTM
         dWIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762187873; x=1762792673;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3dK/8sGZIswEav0IUiwDZwm9zq0rJ+LZHDAICuhXs0I=;
        b=cYETQxNx2ATuDEIkfPcwUmcZdRIS7hCuCgf7xtu2J3O46usiwvzKEPWIdzDWEJ16Uc
         nT9ns3p2OFpGL9VFJadOCXDvG4vn59g8Dt2XoQZzfsBG7xzXApr1QB4j/5NGrteGDWm4
         2z1Mz6j/OewzkEiIQ6cSn/KgDc+Jil/KHJKYEdlv8pbP6w/Jk5Rwp557n3zH3D6ypRUS
         /N++yxyL2/sC8RoZDRmZKMxTwxTZsQdg6XQKZbybK9pDdt4g8WQSbLNve72QOspU+iuT
         4K58iSFNLlhG4trUo+2qu90CL7CfAvYHkSInPCArrpL9TYbITdwKMjJgYcWQuwf4x66k
         lToQ==
X-Forwarded-Encrypted: i=1; AJvYcCXjYLKTaKcZR3c0T3NIR27fXgCaiCgafC94/iKSYDKL6qnFWw1x7kS+pC7SxVLrZO6s2SkJvdQJGJH0FA==@vger.kernel.org
X-Gm-Message-State: AOJu0YzsIPqmUnV5fG4YXVKkiUZ11bDEgqGM1E/R8M2eCIdazfDyGBQT
	Ed3SSR6zD/dFwpeKeIYFFpfUwudpTmvqrni4uHl+XrQQEoEhWnvVgl4u
X-Gm-Gg: ASbGncuPsV6tCYTvTfLtPw2MPp3EQZPMmjz0OgdP+awGyGjrKTD0df1HSgtCJw/QbQp
	GGhaDG45vRBFSM3ceahTPGUkWGCWdrGfES0Ow/uOLIqvyiR+7gBlI/eCN8ka5bBmbzypHbIyY61
	T27unBIdD8w3HsuJpObZ89L9UgRq90zyezVcki9EABi0Uih3kfFHQBUyNdpXZwMlSjUKTrZ9zH6
	0a1PPkIsyQYXLWbzteOzQbd9Dh/UBzwhx48FryGLFf2pdCwgS0tDXdAQNcUJNMpNsUyCLJjQH6p
	UyR+Ewf+raLbRuTgjqbKJt0RqANZRW+Bro9KmwDpxEixWXedzuwScekCLN538teBIuTdhzwNOTg
	pgywLuLCPCqJt4WpFmANY9rePSONrTG7vJioE8OKweWadCiHcVbCq/tx/iwnGCzNH9Bn9HdV0kn
	TMmmCz3EEpy1AKXmeDpIGfe/6ivXc=
X-Google-Smtp-Source: AGHT+IHOoUBY/CseGu1rYOaQtYc2Ta6dcd2TXqQsNF64ItkhFWSiHDGtUgBH1/myNfNr7IGUnHaDXg==
X-Received: by 2002:a17:90b:3952:b0:340:dd2c:a3f5 with SMTP id 98e67ed59e1d1-340dd2ca68dmr9568119a91.3.1762187872654;
        Mon, 03 Nov 2025 08:37:52 -0800 (PST)
Received: from monty-pavel.. ([120.245.115.90])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3407ec24330sm6853704a91.2.2025.11.03.08.37.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Nov 2025 08:37:52 -0800 (PST)
From: Yongpeng Yang <yangyongpeng.storage@gmail.com>
To: Namjae Jeon <linkinjeon@kernel.org>,
	Sungjong Seo <sj1557.seo@samsung.com>,
	OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>,
	Jan Kara <jack@suse.cz>,
	Carlos Maiolino <cem@kernel.org>,
	Jens Axboe <axboe@kernel.dk>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	Christoph Hellwig <hch@infradead.org>
Cc: linux-xfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-block@vger.kernel.org,
	stable@vger.kernel.org,
	Matthew Wilcox <willy@infradead.org>,
	"Darrick J . Wong" <djwong@kernel.org>,
	Yongpeng Yang <yangyongpeng@xiaomi.com>
Subject: [PATCH v4 5/5] block: add __must_check attribute to sb_min_blocksize()
Date: Tue,  4 Nov 2025 00:36:18 +0800
Message-ID: <20251103163617.151045-6-yangyongpeng.storage@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251103163617.151045-2-yangyongpeng.storage@gmail.com>
References: <20251103163617.151045-2-yangyongpeng.storage@gmail.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Yongpeng Yang <yangyongpeng@xiaomi.com>

When sb_min_blocksize() returns 0 and the return value is not checked,
it may lead to a situation where sb->s_blocksize is 0 when
accessing the filesystem super block. After commit a64e5a596067bd
("bdev: add back PAGE_SIZE block size validation for
sb_set_blocksize()"), this becomes more likely to happen when the
block device’s logical_block_size is larger than PAGE_SIZE and the
filesystem is unformatted. Add the __must_check attribute to ensure
callers always check the return value.

Suggested-by: Matthew Wilcox <willy@infradead.org>
Signed-off-by: Yongpeng Yang <yangyongpeng@xiaomi.com>
---
 block/bdev.c       | 2 +-
 include/linux/fs.h | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/block/bdev.c b/block/bdev.c
index 810707cca970..638f0cd458ae 100644
--- a/block/bdev.c
+++ b/block/bdev.c
@@ -231,7 +231,7 @@ int sb_set_blocksize(struct super_block *sb, int size)
 
 EXPORT_SYMBOL(sb_set_blocksize);
 
-int sb_min_blocksize(struct super_block *sb, int size)
+int __must_check sb_min_blocksize(struct super_block *sb, int size)
 {
 	int minsize = bdev_logical_block_size(sb->s_bdev);
 	if (size < minsize)
diff --git a/include/linux/fs.h b/include/linux/fs.h
index c895146c1444..26d4ca0f859a 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -3424,7 +3424,7 @@ extern void inode_sb_list_add(struct inode *inode);
 extern void inode_add_lru(struct inode *inode);
 
 extern int sb_set_blocksize(struct super_block *, int);
-extern int sb_min_blocksize(struct super_block *, int);
+extern int __must_check sb_min_blocksize(struct super_block *, int);
 
 int generic_file_mmap(struct file *, struct vm_area_struct *);
 int generic_file_mmap_prepare(struct vm_area_desc *desc);
-- 
2.43.0


Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B62B31A567
	for <linux-block@vger.kernel.org>; Mon,  3 Nov 2025 16:48:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762188515; cv=none; b=uJn6Qc5oRrzcU/wPE8E4HkJEZDyFeubuhehxA1H+WlzUFPPBgVSHPXR6iFuEzpJefSHIoHTzi4NYe09rUDALNWNAr5R7/xiReSqlJObxbY2xdeMkKe08iQlIQ9kF4QjOJqPy2TSUylE9WJMTd9HCrg7w4vjUlzLCPswGjEc/65o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762188515; c=relaxed/simple;
	bh=803fn53SStK4wXIjz1Zh8Pjere+o4fW/LFg6pbNfZr4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rbx+ShdeeA3zQ0COhpS21VtKrTE7Yfsy3N9dzAPXxcl/TypqgCD0WoMDjNyHvZgvn765Bioyv4RDwz7Is69QOUrMvYVyHhhYNmQ7VFSPg4a9A+UOuuGH6jDIlIq0qqyQ89yS29AetV1/Q09fJokvd7uyczEGLdEHYpQFV4Rd+VU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lp8hcZGP; arc=none smtp.client-ip=209.85.216.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lp8hcZGP"
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-340c1c05feeso1867790a91.1
        for <linux-block@vger.kernel.org>; Mon, 03 Nov 2025 08:48:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762188514; x=1762793314; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fzqCA84hItOJG3LR9jcLPhJDx5yJuZqijNb5+VhOfn8=;
        b=lp8hcZGPz+GkJKken6C15fPLZREvTVkJW19yNwr1DbOlGJOtpyM8astG6yzrWD0xVB
         0M+7ZDbhZieiSq0WzgUorNZaRNahE7Rszjwfjf8vDvauErcAMrLhGVUQvndg02K1bkCP
         ND6s3geYE9Pifing3lNZo3jQ3nC3afZAPvSCgzrDwhve7szV4Liw/pVRx926bzQ7FVtg
         7iwPs3NyFIFToL40zh04ZWYW27TustU4mEAj+X6FGfEvUZFGXGEUwSppLDGwuRUdrr50
         YZS5CKc5dZTbPb1IK0mrnfimbYcq6RLPIE45det+aPwqXc1lgIgx9uyvi0zTBQ9JzL4D
         VazQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762188514; x=1762793314;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fzqCA84hItOJG3LR9jcLPhJDx5yJuZqijNb5+VhOfn8=;
        b=IwF/jzgrMtas0WO9pibRUgYjGc3nf/sX9/25IQQJA7Mm+a8KI0eijK6Xr130SSFun1
         kVQSCiZwftoLvZPLIJtoDLafLgDKsCdsePRweRNScy+yL+VvIteL3LiXhUrWa5Z0bLfn
         xbXvsbwep248xqSh0jJVxGKQsXm0BcPMDZv5Kg4IZT6wWPrTE/LX1g3kH+m6l/aiIKJs
         8SelI4OLZuZGly6viNb88EA4rFTxKzApHMtdGsBJzJDGHmYb35Wj9fBmFBj1zQOmD1G9
         QmWcARoYCkbJnxcaO7y3rwJYaNxrsKIGgAyhYKPllSN+euYDo1gbudgR/BjRvkXvvKFJ
         X7Eg==
X-Forwarded-Encrypted: i=1; AJvYcCVDs/Dt/RUbgyqf9nk7WQzSasKXMrLpaPTxCBfwRGcoFcb3+TmHYENrLJC1i3EUd4ihrBvTwrJe7OoEGQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YzkqStQevKXryptoSZBIODRjZxp0wtJw981XMDVeulPupEiugfb
	4U0VPSTYj32quGPR6cG77+rB1dEd4WPbcteuKV3O7Gwnl4JHp0+rYOk+
X-Gm-Gg: ASbGnctQ+yrsyh+Gp8vgCueGL73QzpsCDExYpS74vEFS01pA9dcTOqyOQzFTo+zJ1Dr
	R1YA/iCXUhq66dbQDzotzRn9H/GzPFowEqO3/erSPjGKWI9yV6I5FqVFCAZ6Pv789hV5wMCSV2j
	SvrzZLZcZ5m7byc3hMMhR7tdaaWHFxL4M0wwLJDP1OBwzcaGWJs+Abp5ZK1+CZD9M12KDWorR/d
	t6FBrMbG4vsuzIbzrtgy5e8cQlRVSurPVuzR/gw0QjvReFAU1P0itIlVZHx5ADi8YHRSBDbaAph
	f2XQHwyIAbLXV75IftQ5TIXioH8M8AOGQPlspmg+gTnLq9082KvZE9vlKWBHTt5g5zQSQTWGz1m
	tAwE8Tm21OaZUoMt4Ud4C5Ri3Nz2AZ5OycuWLrbweAUZlD5rTjS0iHH0jKPIFknJu1Aq9qASTEw
	TDkJAM1bEX/TjWphvnIgpR
X-Google-Smtp-Source: AGHT+IEKGMkG8LSM8k5x2jtLV6ot/I3WeKc2wYyKsbkf6hGph6RyW15e3Nzs5v2jxgF/0uRopdPS1g==
X-Received: by 2002:a17:90b:1c0a:b0:32e:7270:9499 with SMTP id 98e67ed59e1d1-34082eded6bmr17634572a91.0.1762188513382;
        Mon, 03 Nov 2025 08:48:33 -0800 (PST)
Received: from monty-pavel.. ([2409:8a00:79b4:1a90:e46b:b524:f579:242b])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-34159a15b6fsm1607264a91.18.2025.11.03.08.48.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Nov 2025 08:48:33 -0800 (PST)
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
Subject: [PATCH v5 5/5] block: add __must_check attribute to sb_min_blocksize()
Date: Tue,  4 Nov 2025 00:47:23 +0800
Message-ID: <20251103164722.151563-6-yangyongpeng.storage@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251103164722.151563-2-yangyongpeng.storage@gmail.com>
References: <20251103164722.151563-2-yangyongpeng.storage@gmail.com>
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

Cc: <stable@vger.kernel.org> # v6.15
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


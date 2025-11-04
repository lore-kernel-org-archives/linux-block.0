Received: from mail-pg1-f181.google.com (mail-pg1-f181.google.com [209.85.215.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25C072D2387
	for <linux-block@vger.kernel.org>; Tue,  4 Nov 2025 12:51:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762260675; cv=none; b=OyymDqqt5AQCjTcRFT51Zl1JcxCJYozqj3gzmCvMSUHyiSVwSRPFxk9VFfPxn8ruAL0LRNHZHxXYKl8+4yjhNPaeAFr75dyxNcCt+5yd04Rb1NZ+VZ4Dg5vk1mnQChBr9oQrfcWrDDYBrncC2DNNUxCiB/uQDfQAPVrIkiBcNIU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762260675; c=relaxed/simple;
	bh=s3yhfECKQACggkqiSvS6yFm+dl+Idqcymxv/EyA77Zk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=uCwJ+tmFUtH/5+xOdO1TRZtiJZqoCS3QlOCYi7fcw146MU+gEch31So3cIxBQ7CuZXt5T0Jk5sPHfEuD2oIr68lK2Vce9iwK4VQ9SlomuxUHMhAhJRBHTJoo/3RPfEqyUypr5US77yA7DV+0XPcLU7Vh8RaLryub/Umn2pVAeBI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Gzrcw1E7; arc=none smtp.client-ip=209.85.215.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Gzrcw1E7"
Received: by mail-pg1-f181.google.com with SMTP id 41be03b00d2f7-b996c8db896so2545519a12.3
        for <linux-block@vger.kernel.org>; Tue, 04 Nov 2025 04:51:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762260673; x=1762865473; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WH7uti94Ifpss7uaEo1ftZ9XWOLDmVeeF5wLRCtaeDE=;
        b=Gzrcw1E7d5y2aoJUnTcshd60F4LWfOQ63t/EsqrvDyfK2Ewh8Wf8pjc/kpCJfHIpwf
         /Rz89C9Ym9ixt/lO8+h3JC04JG7VOy+EaEpt4t0LfphzoJgeFhPgmjXagu6fmSibZKDW
         t4dVVY1MLBP3ao8Er9udkSX66StWVpJBOIH/r2s/sy5JNWw22RFlsVgapeaWWoWIMnP7
         g9hzuMDLaB/DX/l8uJa0S5U1l70CIAEx5DMEAD98CiEmdlDeHn0okSeFIi4NhZgfBrQ9
         ie21cqAQBHOF5XxjXZDJIKqauKNVWYHN3BIBpbIwYcRVneanBSJPbQcojXrQGnaJBd0p
         LqJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762260673; x=1762865473;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WH7uti94Ifpss7uaEo1ftZ9XWOLDmVeeF5wLRCtaeDE=;
        b=BgIk5Odafq3/bQHIFM+Gxcazid6a9hTHclC3t9768zIBy+NtFfgJ61ZiiGlTg4+MSw
         lBa9sKi6VbtgiX7/Av92CDD/oGHyIGbMsPrdOp803OmPuk5gH9yOw3pZrIX4cSANN0y+
         hcLvutFbD7Pek1RIaVgHkaB58X6WwvqI0Hu6pedGjNMericeKS0jxBYyAmDKLg70mdVg
         7i87UDDspcyvqxlgWtYBA2gmBzd8wQBMVKQS0na372HO0v2gqU0JHNBMfhGV21n12ftE
         GxrZi87rjleJ/0idbH4EkXhg/84BWT3WSkrz1WUK10bpfDzjxSmIejHX5HEF+XpGZZal
         rljg==
X-Forwarded-Encrypted: i=1; AJvYcCXBVJ7PTFopCqnKa9pycjQD9h7dwq/8tzNFjDP4BJ4P9UzX42RzXwPkcbiKAmBYIZ/thyK9jtABg2aNww==@vger.kernel.org
X-Gm-Message-State: AOJu0YytSKoauhCdoZ696/5v8LM7ikBqv1hezM+TiNgcVtNrZ9De48JE
	r9VRVQrj0EZpfpGxXBb+WF5pjhqFzBoR1dPPxJv/H43wxGlPTYzIGoiY
X-Gm-Gg: ASbGncsA+7YMLWSewHsRIp/oKVhagWRe1bgXBliLBPE6xY2mWzPcG7rvsm+XUlinH50
	ygybsyXma8LeIFZCo8c9JCRteBMEn1kDGg409byLMl8DjcKgFXRdzU34nC5/Gm4BgFfDdb0yB6d
	C8unU5pzyk3kBCXtPoFXlkOF3htMpEBaRUbUiCAftoO4rEn50EDDunyrFeyyTMz/+dWn+HXt+DL
	iQcXcaWj5o+faD7RHFI3iKKRu7U32YTBgGo6Xf5zCR7vfS9hoxHKwCl5Jw8HaelC5MYHU54srH2
	8yW0eZWODyE27CQoXZgk6hF05/7KlfFotPcX00E/+Z0hNxT7uFPyik5gvPpm0ZBRijXQGQgGblS
	Tpdbq4wLmyL8EbOxmGdCOlub3jRcYdlL8HyCyQYfQQX1CFBQpuYPPIZ0+gQA49bzR3LqHmTwDOQ
	NiXhO4sZJEt770I08zJPT73iQPChnomjy+ILU/v2At6Tqj1zM=
X-Google-Smtp-Source: AGHT+IFyV0Z4aoh1hb5I/IbU1UarLZfuiNquenj/qB2Rx0uGFDeOr6CMSuEHHdT/4+TY88jlIMdvbA==
X-Received: by 2002:a05:6a21:8981:b0:34f:1c92:762 with SMTP id adf61e73a8af0-34f1c92f840mr640906637.19.1762260673189;
        Tue, 04 Nov 2025 04:51:13 -0800 (PST)
Received: from xiaomi-ThinkCentre-M760t.mioffice.cn ([43.224.245.241])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7acd6d026dcsm2860710b3a.70.2025.11.04.04.51.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Nov 2025 04:51:13 -0800 (PST)
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
	Yongpeng Yang <yangyongpeng@xiaomi.com>,
	Christoph Hellwig <hch@lst.de>
Subject: [PATCH v6 5/5] block: add __must_check attribute to sb_min_blocksize()
Date: Tue,  4 Nov 2025 20:50:10 +0800
Message-ID: <20251104125009.2111925-6-yangyongpeng.storage@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251104125009.2111925-2-yangyongpeng.storage@gmail.com>
References: <20251104125009.2111925-2-yangyongpeng.storage@gmail.com>
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
Reviewed-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Jan Kara <jack@suse.cz>
Signed-off-by: Yongpeng Yang <yangyongpeng@xiaomi.com>
---
 block/bdev.c       | 2 +-
 include/linux/fs.h | 4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)

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
index c895146c1444..3ea98c6cce81 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -3423,8 +3423,8 @@ static inline void remove_inode_hash(struct inode *inode)
 extern void inode_sb_list_add(struct inode *inode);
 extern void inode_add_lru(struct inode *inode);
 
-extern int sb_set_blocksize(struct super_block *, int);
-extern int sb_min_blocksize(struct super_block *, int);
+int sb_set_blocksize(struct super_block *sb, int size);
+int __must_check sb_min_blocksize(struct super_block *sb, int size);
 
 int generic_file_mmap(struct file *, struct vm_area_struct *);
 int generic_file_mmap_prepare(struct vm_area_desc *desc);
-- 
2.43.0


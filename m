Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E236B3191BE
	for <linux-block@vger.kernel.org>; Mon,  3 Nov 2025 16:37:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762187855; cv=none; b=bQsoDEjxiEWL6vfaFCVF0gVXv9mxJLuZBk8t+T4liez4gnfy3kpKQxsXFqaH6K8EJEsFAWNpYWYWqJtgcQ1xzjM4iokekTmKuB5emauIWQQwlwOfZcKxrMyswTJMk+spQp1KZIUiv9XEoDA+M9+e2TSzKFgQl4T9dLMLEf6klG8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762187855; c=relaxed/simple;
	bh=nWCX9Xn/+IKfnehkSs57lbJDTkS9u5nAvInJtc9YeA4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=G+lpLjSiT63W7uKYlS7TUCwaNj6G4a6PaL/6QxjJCDpi6QrWqOJyPje2APBaG+FDjRgwFvToOto7B8qIeyLBO895C/YpRa+n/cGscRzNTezGVid19RcpnYNo0AOGZWz8E38Fg7v94qOLm1+qU6VbReryYmkSlbHeobtvfZ+/WBk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VZQUmVUb; arc=none smtp.client-ip=209.85.216.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VZQUmVUb"
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-33255011eafso3878055a91.1
        for <linux-block@vger.kernel.org>; Mon, 03 Nov 2025 08:37:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762187853; x=1762792653; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+UbgPj8GVBWuehInulfgB6O/0NvS5woL/wIoY+Rh1do=;
        b=VZQUmVUbFLd8tjP14YlfkEj+BnVA0HkZGG1iVrcvoAVDds/l82FT4TOF95wMpFst0e
         /g6xGi6MxUMmJz5h/bI23XRQ86NmhJ3qEuOxDODdvzg6AXg6ZoJaM4oxszUScRTVWrsz
         e9bkzUs/18yEut2/k5hfEsP6233MTakx9aAkCovRdMWVDmqh4kUDgRHDiC2CHoKPr9fT
         VeuqTRbh0IzebF+QI2dMfZj6pO9xKOFJwVy5IbQeDtTitIm2GN3MoidrFpft8Vrfolcw
         oIacMBKWdqJzpgAYJVrRZZXdDjMhNSc41ZViFRnk8FFQGPmekmuam6WtA1UskCcR8DDb
         ACzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762187853; x=1762792653;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+UbgPj8GVBWuehInulfgB6O/0NvS5woL/wIoY+Rh1do=;
        b=FvNkDsvTbMRYe6o59xGEGZ2P3oWaml9+IvUCtRdd+KtqtV+szKPNqrAYWVm11ViV7l
         y0SxY/ojJNiyM06kRvLubutk9WPmY4aeEyWX6VbY+VIqP8rXmXAVe8jbw6dxUkctarem
         jgvY6CvW0ui+xU+KIp7QGgZTUSrdfy84r7iP0mLhTGbFHbHwJ6io3h7lie2k+cfH9yQZ
         ADaABMZD2bc1bOVmNt/KBOm3F2LHahGJ78dMyZy4JUP7Mj3tTMSFhof+1BBIvOnQKC/f
         4yP58br75mWt/9nOMbUpv+Oo4te1LC5VVc4Ww4Qz2kCIUDRPiWVphSh/JWR/aJMN/BWB
         FI8A==
X-Forwarded-Encrypted: i=1; AJvYcCU20H3kK9EKKd/vpXlQtYY/IRhaI9/cEELruy4YpC2vZXfnbewjbm11bNMdNOjBcUytPK5JUh4IJ7tkdw==@vger.kernel.org
X-Gm-Message-State: AOJu0YyL8ku6ZW8aCF+gCoWVqvRn3Cu+/Wtn4hxCxA5LQFgomTfmyMRu
	vH8elsfIIcKxvsPWlBOsVbaaOQhWq2ULan9aOcQH+HYqjNiem5AC7L2J
X-Gm-Gg: ASbGncvTyEnf4JsKWi6DNF4Z/8bXxVf8QeEGb1VyWrYZDrWkHJk0ZX4EXwWtBXP473I
	38aBD8Oe5HvpptumEGZ8abME4CmED7OlJRwjvlFtZw09Ldkf/8dqAeTuKGMiFCoork5yXgPwype
	k4WvcOrJqVKLT+4clF1l+VE57sbKF14KWeZx94Kk5RYb9ZouA7H2a7xkd5S8BHHe/RigEnAfus0
	4EZJGjx86sV5YCJPHbY4C+Oh6FZEgom8NODtx/hA3KZ25cS0J6QV6NgVDcbmf35IdneNkzdVR6O
	pah3wMvkLBYHTer0WxLXT0GgWyOuvzba2mS/qMvrYTtqktmG83E6CMOZWVsjcfp6O6KolyaKoyB
	ykwUlW/YAiM8BfGRqq23rzePMOFZmHD7nrPsQydQLW88KJNbaIYLHl5zTu+JoLRQ4ABUgYrVlOY
	f8a4Z9FlsMeuV9nDLj5vAuO+e6124=
X-Google-Smtp-Source: AGHT+IEASkA8V+7jhpM5M1UBN9y/LaIZ3ZfddiwA+afwhpAeDYCIo8Ch8f4X0rxhFH+DrE1jj0TzUw==
X-Received: by 2002:a17:90b:48c1:b0:340:c060:4d44 with SMTP id 98e67ed59e1d1-340c0604eccmr10391621a91.14.1762187853008;
        Mon, 03 Nov 2025 08:37:33 -0800 (PST)
Received: from monty-pavel.. ([120.245.115.90])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3407ec24330sm6853704a91.2.2025.11.03.08.37.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Nov 2025 08:37:32 -0800 (PST)
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
Subject: [PATCH v4 3/5] isofs: check the return value of sb_min_blocksize() in isofs_fill_super
Date: Tue,  4 Nov 2025 00:36:16 +0800
Message-ID: <20251103163617.151045-4-yangyongpeng.storage@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251103163617.151045-2-yangyongpeng.storage@gmail.com>
References: <20251103163617.151045-2-yangyongpeng.storage@gmail.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Yongpeng Yang <yangyongpeng@xiaomi.com>

sb_min_blocksize() may return 0. Check its return value to avoid
opt->blocksize and sb->s_blocksize is 0.

Cc: <stable@vger.kernel.org> # v6.15
Fixes: 1b17a46c9243e9 ("isofs: convert isofs to use the new mount API")
Reviewed-by: Jan Kara <jack@suse.cz>
Signed-off-by: Yongpeng Yang <yangyongpeng@xiaomi.com>
---
 fs/isofs/inode.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/fs/isofs/inode.c b/fs/isofs/inode.c
index 6f0e6b19383c..ad3143d4066b 100644
--- a/fs/isofs/inode.c
+++ b/fs/isofs/inode.c
@@ -610,6 +610,11 @@ static int isofs_fill_super(struct super_block *s, struct fs_context *fc)
 		goto out_freesbi;
 	}
 	opt->blocksize = sb_min_blocksize(s, opt->blocksize);
+	if (!opt->blocksize) {
+		printk(KERN_ERR
+		       "ISOFS: unable to set blocksize\n");
+		goto out_freesbi;
+	}
 
 	sbi->s_high_sierra = 0; /* default is iso9660 */
 	sbi->s_session = opt->session;
-- 
2.43.0


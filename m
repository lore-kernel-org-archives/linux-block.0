Received: from mail-pg1-f173.google.com (mail-pg1-f173.google.com [209.85.215.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5D9131B138
	for <linux-block@vger.kernel.org>; Mon,  3 Nov 2025 16:48:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762188501; cv=none; b=SdiJdTt8N7Mia+rnSpT0e04gt37v6+uwcYeABaj4X8+vXnDkONyfOyH6sHq+Rue1zF2BAbCnRitEQYTp0w+PKagEGCtHVIl84sorNaEA8BRQ3smUduMq/Tig/G54zEPLRrXEVdec170Okp4ePFsSuGZnSDTDzbsKgOiw5mTt1/Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762188501; c=relaxed/simple;
	bh=nWCX9Xn/+IKfnehkSs57lbJDTkS9u5nAvInJtc9YeA4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=A3Hj0XrN+H61XVPKAwWSg99fuFLG5OCm3opWyDnWgq8MgszKA3PgV8B8kTcVPG1mAh2KQowXo4KgTFlV0fYyqPDtQJA7VAZWGxOa/TOtS5/6QoqHKenEPOIVGV4I1pNBrrOuPR89gDYNKCDzkU42Eka8Iom5BGZ9rX5NiXjWQrc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XUJzfOx8; arc=none smtp.client-ip=209.85.215.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XUJzfOx8"
Received: by mail-pg1-f173.google.com with SMTP id 41be03b00d2f7-b679450ecb6so3481228a12.2
        for <linux-block@vger.kernel.org>; Mon, 03 Nov 2025 08:48:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762188499; x=1762793299; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+UbgPj8GVBWuehInulfgB6O/0NvS5woL/wIoY+Rh1do=;
        b=XUJzfOx8Rgk5EhTJsTuTJ8g4wGWIrb+B4Nmb45rywAwTzwQIrfocseKtTizDCxZTY6
         OckdhFdR7IXuyxayuxEJ25i/58c8bzqNhk/cSlg4rEncYfw0MIAx2R9BnB4OPPzTl3nP
         jjGmwTPnFUe22OKF+KKyU8LUw2cNLQJygRO9/lb+o0O0nc0K4d1KINAD89hYqRqLAF0f
         TtoCH/Et525wmvJJaBOQ+Bi/vILYpTnV36pwd7Ptu0r/Joqx0015mIF3o5/qgf4foXhv
         9BUURVdB+XGf6Tv/tz6XxgU+jjx58r7MyZtOVg8pYGBmsPEOccZXnSVjLey4Ba54xNdC
         LSfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762188499; x=1762793299;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+UbgPj8GVBWuehInulfgB6O/0NvS5woL/wIoY+Rh1do=;
        b=TuL86YwzaQZ2rbvnKK5/g7ZYxlYsDGWxyiztYxhsrBcio8p7cNgQVyzfKIyZBroyY9
         oRaQT+HPl0DZGQWaoVwU8+XjFVX/0WOU8If8yGRUXH5/3ViokAikVXxM6xQcm74TUzao
         JqzlPPjCeDzKwx6joMPyW2MiSE2bamPrQNlAhaOjbkMjmDWyLR51R3Rwce1yKF8BiGEV
         k5KZKdGQjl8KYBApXuTJHsEdTQKRtb4z4XpLNifvYfLhkTYI085n1sq+gi7kA5uPZRqY
         /jbSxcTSmrtarfAe50tpV17rJvWwiskEbanOI/Vy/WK9Plj7otWerg8TR/89z7STz9Bo
         t/Mw==
X-Forwarded-Encrypted: i=1; AJvYcCU35X6+fRW6gXKVyL2jNAyWeXPoDVKgmJF4tzyM9tT7siGCEcaINj1B++5WgGPgHJsKdcgHCtcRvwDFnA==@vger.kernel.org
X-Gm-Message-State: AOJu0YydLMdBQ55mkAzFizchovWYjoeKfvFMOwTcMVmOGQL19GTk26TQ
	vmjFY8cW65wIRhImT+0qeqfK7ZNZLGQtMMEN3C2nkxCzN2Lvs27vv9PN
X-Gm-Gg: ASbGncvNlKQjno8FtEzhA7sMRGmZt5aR+0y0vE4VxeU7WQMc+lw61wQfFdmQ+js4cm8
	MNE6EcDE8zlk7R8S50MUYQWxZ0Q+2XL4VNNn/y3wIZNLui5tShTy+FHfoS0jd95YaIxrqygTtJq
	yaQ2Ps455eHc54nMK5Mj+fHTNgdNnd328GV4x9g97XQ4p+ZQNe5yjcyL5ZHqitt+pwexgpIxzMr
	ybEHbGG+Az2gaDOxgDbn0GJ48sraT5KrfCNNblp5lp7cPcl+LgvQYzNGO4mcNzgq9QgADih7sf1
	rq6Ug08SVllRnkSt98vrrJ1rKbbMAPxhuaMcBSBCKYy6B9HXFypmIs5PVYR8iUukHdRUkJw531U
	J8UdD6hI3JnF9OKTnwvIX3OU8o5Xbpm3s22PMgfC6l6f6/xOKPferq706ozVM47RyoehTXfUTiT
	/y4glitz9Ykpj2hPtxcv7s
X-Google-Smtp-Source: AGHT+IEyuTHSlueto2QQ6kf1+GNae44GAu5fq+5W3NoVv8SuS2FAXtOnrUjUNMsA9RRKaWGorvWX3A==
X-Received: by 2002:a17:903:4b04:b0:295:4d76:95fa with SMTP id d9443c01a7336-2954d7698c5mr99114655ad.60.1762188499151;
        Mon, 03 Nov 2025 08:48:19 -0800 (PST)
Received: from monty-pavel.. ([2409:8a00:79b4:1a90:e46b:b524:f579:242b])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-34159a15b6fsm1607264a91.18.2025.11.03.08.48.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Nov 2025 08:48:18 -0800 (PST)
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
Subject: [PATCH v5 3/5] isofs: check the return value of sb_min_blocksize() in isofs_fill_super
Date: Tue,  4 Nov 2025 00:47:21 +0800
Message-ID: <20251103164722.151563-4-yangyongpeng.storage@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251103164722.151563-2-yangyongpeng.storage@gmail.com>
References: <20251103164722.151563-2-yangyongpeng.storage@gmail.com>
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


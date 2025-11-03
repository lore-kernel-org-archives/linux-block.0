Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9227A3168F5
	for <linux-block@vger.kernel.org>; Mon,  3 Nov 2025 16:37:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762187844; cv=none; b=aoDDNpoxzGOrdVuoYTTM/REX98zHGoSunwLlBs+incM3JcY4vAC8ZJIyTd+B/vulCk/wu7sPxomseO68yrLfyS2ETt0WJSA2SMw2zZMc8HmfgYr+QgmCF58cSR/GA5B5nxE5BtPJ881DdhYTUOTkULJGh1oSmrkrHv9AR8xTUn4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762187844; c=relaxed/simple;
	bh=wJjmntvfExnlICRxK102abAFvivMt90fKAxX98hdlYk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Uqft9bALyHfhnM29n405HFdT5JlavQUR7DIhkjYxjbQlGunWTW/WH8tmCHIkYQIyLz6Ukiw0LICIQFlnbwPB2IzQnpv4y6L4JCowOYNKxbouc+o79VOoVbUnyDwMatZzzhzz4HeHWVgYNzZPPJwOctkS811ci5OfLIPn9RZWLPw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=V9Xh9GEq; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="V9Xh9GEq"
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-78af3fe5b17so4347365b3a.2
        for <linux-block@vger.kernel.org>; Mon, 03 Nov 2025 08:37:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762187842; x=1762792642; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RqJ5gNa1nUUGBUXHUrJf6QlrVR0rCRb3Pp7Ymbcprkc=;
        b=V9Xh9GEqqakLENJv++F44TPZ6hs4GdYcXT+kdy11SDPwcY5sh8xJLitGOpmCtW8JDr
         XgXLIGp9vDzDFUwwTpZ9lesxspeUbb4xtz7rQpOA3E8Hb53ijuSEmtzUL1WUMVf7nvXI
         cznb0gCHxb98GYaWQWVdF7b7stGWR9ZMa6CJTApPDpqC5kwUbF3wSz3xWKr84P2sWdS5
         9wWbQY6Wzd5q10MATigfea4EHH70mPWtlC82+ik/TUhToHOdX1ljggAyq78S+lfxwnTW
         QTGRgKHCXEcW1V2kj4LgfIbUb683rfXk+oV1lKY/7kDkjnxRBKucT27jSsbvhxD62gsW
         IAlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762187842; x=1762792642;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RqJ5gNa1nUUGBUXHUrJf6QlrVR0rCRb3Pp7Ymbcprkc=;
        b=LYGTGOJmJpJw/oFb+z1T2h7GDsTMMH4bfv67ubV4HdSyuSzTM2TIEQyyl3pWOfXup4
         8Ijku72aS/oAeFYP+xC4CGS4mFUBZEKu1WZpJqqzYf29h7apkRXwSJUsmo8Q2rRs8A0w
         FnPTux4Mgwcvs0iMTRvF3TOmBQbVnIyR7BBBLT9b17yBqjUMWwo/qt0fkMjAfGCh1Ayg
         oBFfxRh45xpGyj+QXiRrxT+WQ4v+Q2PBfILYDGz13dSdYpaxsrx+w0yeLVIJNvdyCfiy
         V8NBXKfCkAkbfimulUrgARqE5ydyIEshBDNqCczr/Afi/q3qKmSKX1qM3yg2STKtoAem
         53rA==
X-Forwarded-Encrypted: i=1; AJvYcCWwUWJD7/zMg2fuTfaZWHKCzmBpUdAom3rGBs86vGimm5xjR/fQEesP0K49xC6XQdDUgaQyvZaFPGkl+g==@vger.kernel.org
X-Gm-Message-State: AOJu0YxfVr5pPojEcVqe5dWHRvcAl37sMz7icb2LAg+dMUTXOx9UDjVf
	uokq8okAzZrHOcWT3Xde18nYVXDglcTAeX6zr5sqE1xrVq2innkgmOph
X-Gm-Gg: ASbGncuJSIvzMcbkRXtxj/w62wYc1MKRY0+dl/ag1lwrFfRt1517kfe0CgFLoZrbZ4I
	Ab4A4fdg0MAmPSujOQgzDeuAYy2zs3E5BH+tR3sUVuKm6jq/M64kHD6j1K8J1J1dM4xl7RE2sVx
	6FnjJb8w1owtq/2IPvH8u+l9ClZzYphpoNid+EcEZN+sHnUewJTwQrHVmqohbRxskKAFMgJ8GCT
	W9IvQ7n4Cs7RdjponmmIpxqtnlpvKw3Zx2g2sj2TFdNa3DjmDJ0R3+Y0r9GMHsaG/Xkra3cSC7A
	CaMj5D95uimR//0xBw0LZt4KxDwyHBUotc3HKIcoRLZ9a6uZd+qEcqmKIxJ/rhLM5QS9y41xQs7
	E29tHRrHsutW8N9h88S/Jc+pE1HcMU1zBM6QE//OrjSLkk4ixEvg4Y/pp8ch9LQp+PWAA1Q67ER
	G6M8X+pFH0KXY6NLHgyptmqBIDVfQ=
X-Google-Smtp-Source: AGHT+IG+w7iJAzmb9LjCnbErWEAX7LNvJkcpla1jAFDM+Y4gmMZZU0oJMClikIddg63gu998oSNJwA==
X-Received: by 2002:a05:6a20:939f:b0:246:d43a:3856 with SMTP id adf61e73a8af0-348ca565705mr15735758637.22.1762187841867;
        Mon, 03 Nov 2025 08:37:21 -0800 (PST)
Received: from monty-pavel.. ([120.245.115.90])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3407ec24330sm6853704a91.2.2025.11.03.08.37.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Nov 2025 08:37:21 -0800 (PST)
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
Subject: [PATCH v4 2/5] exfat: check return value of sb_min_blocksize in exfat_read_boot_sector
Date: Tue,  4 Nov 2025 00:36:15 +0800
Message-ID: <20251103163617.151045-3-yangyongpeng.storage@gmail.com>
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
accessing the filesystem super block when sb->s_blocksize is 0.

Cc: <stable@vger.kernel.org> # v6.15
Fixes: 719c1e1829166d ("exfat: add super block operations")
Signed-off-by: Yongpeng Yang <yangyongpeng@xiaomi.com>
---
 fs/exfat/super.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/fs/exfat/super.c b/fs/exfat/super.c
index 7f9592856bf7..74d451f732c7 100644
--- a/fs/exfat/super.c
+++ b/fs/exfat/super.c
@@ -433,7 +433,10 @@ static int exfat_read_boot_sector(struct super_block *sb)
 	struct exfat_sb_info *sbi = EXFAT_SB(sb);
 
 	/* set block size to read super block */
-	sb_min_blocksize(sb, 512);
+	if (!sb_min_blocksize(sb, 512)) {
+		exfat_err(sb, "unable to set blocksize");
+		return -EINVAL;
+	}
 
 	/* read boot sector */
 	sbi->boot_bh = sb_bread(sb, 0);
-- 
2.43.0


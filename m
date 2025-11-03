Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEED73164B7
	for <linux-block@vger.kernel.org>; Mon,  3 Nov 2025 16:48:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762188495; cv=none; b=FiBhwKLmqxOClgfKOaOyUd3IfKMAr/cW3aw7jqeaWi0aCZpUtGxd4AKukWnPexVU9cW6tiwge+akzqP7CQFVgn4ZVYFxi395V4J4zSi8Hxctm23rfYOBGW2yIpEJwBzJNzoqSakHTJNu5fLSVqHecW3c6V50cVS6OeR7MW4ok6E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762188495; c=relaxed/simple;
	bh=wJjmntvfExnlICRxK102abAFvivMt90fKAxX98hdlYk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qBiHPZkLGo+KHBVhTjDTz9oR+K40QB9gnRQUyk6tK70SEj3jVJm+RgAqjlu5etjs8DYPIdJYTjF3BLJPkD4atp2psm8zkb78to7hgtOKB0x8B/G4+4klNk1KnX461okB6vLJSgU7IPaZWqxklYUEHnSzVexcYqHYSUNnyIQJfso=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mly6Z4mD; arc=none smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mly6Z4mD"
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-3402942e79cso6520575a91.2
        for <linux-block@vger.kernel.org>; Mon, 03 Nov 2025 08:48:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762188493; x=1762793293; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RqJ5gNa1nUUGBUXHUrJf6QlrVR0rCRb3Pp7Ymbcprkc=;
        b=mly6Z4mDv830e117Wb/WZgDoDqVTOArVC6L+MlO0OvVQ4iuT+wrIJAOhFpJFqEBmbS
         DHTEMhiowsYxbYlyyX1TDHQwSgpNwQ3nIln6fkTLmcWJ62oAFyNANcIYG7I775kPBGYv
         qjGlZTVGqan2l5/Z7tAFhODGqtTLvbjd7mYxk0cuGo3l2B3P/8DXWrlURCi8GhvUcPq5
         WAjp++Bll1OlWSGJOHrvXSzQz4gJGCFedWfa9jt+O7aGVUZNsCIvQsq+f7hMt+j8y9zF
         bqsiJmweBjT2QCUNi/dBfmURYpF01wzFBPD3VRPMhOuOI8PKOEXwZ5j826K7qJFqul4B
         ym3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762188493; x=1762793293;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RqJ5gNa1nUUGBUXHUrJf6QlrVR0rCRb3Pp7Ymbcprkc=;
        b=l4+vtX1BECKpJVoYu+P3YE1L9VGq+5aPpaOAN/azy4wD+a3bu0e8wiJKwu0J+zCWHN
         3lY/l060AgXKvZ9eue9CnaG1mYXwrgeXSfRsM97NbxeDtikFFiAT+zwOx/Oo36+qTIeq
         aqy1rnywbqIZodDyIZYZrh5FqS/W7FLFB+2IwoaB0ej5JLf/CgmtxhvT5HB8IsLDGWGB
         klOBsJHxH4fozv0gsvTYFcjNToDwhIWpOCWQYIY6JZ37qppyjPt9uLJh0GKTLmiAL6Sw
         EAZICVMZcRYcMcQyOOSVc0zPKzM2neXukclx0bxjH2UeM8bh8fFRnRkoZ71IKkmEsVRR
         fRyQ==
X-Forwarded-Encrypted: i=1; AJvYcCUAJN6cGVV9vLz5Lb3+3yydQKuJ1J6L09/OxFAqcvIPGrzcMp7tNEIQcCYpGTCbBLWxsBzzRxdcxDW1dQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YyptfLnz0dQztOEIJxstWkDkppuIi7N+AWmsdAk8IWr8k7Y8MCT
	md3GpAidfh+T141VLg7DbHGNXMlxFz3TQY6r8IjR1UZ7FNW5KyikwLh/
X-Gm-Gg: ASbGncs1kV7cBwhN+aHfgQpgvpkXLJFi6E5Z+nVMy+p/ToS46oexQ3WwFNyrexYNu0I
	cc2TNpQX7c8pJWNcAMZB6bxASk9uyRanp/Krl2II8BDlxWB1ZK41ZCPwIn/g4icciOl2eYcRSFG
	VunW5EQhLN3CBXFurK9BEXIyRwA91U03IFnYKB6A7NW1KbXf7rimkfnOT6T/Fhm3R1bT+lahevF
	h+sgxv32XIxA6v32G1/w3pn8MgwAlqKcEUAb8iYiXgTFW+dFXrhSE5HgyhuWemEXPo5ch4CNx2I
	orR8C94ayMw8w55ZAkBAbtXdBsKxIsz0sIyMizOFftB4gXJjqDwIRKbnCOm9AUVLaYAA6u70nJj
	MyZWmRlg2uGuGTD9wYyVKyCLGz6iB8YmF9L/cuOgXfSprqU+0of4BOEHTrV8U/1hWQ+XPuSLtxs
	eayJp+P0xgIF/sPvSH93usL4E/esVE4w8OTxkGe9WueA==
X-Google-Smtp-Source: AGHT+IHyVbpQ031khovVH+RdF5IYFXxXooq/uMJcv6MssOTN24pCbmD2Np+fsrwq7RaQP1KpB2eDcw==
X-Received: by 2002:a17:90b:3c52:b0:338:3789:2e7b with SMTP id 98e67ed59e1d1-34082fd9099mr17153531a91.13.1762188493051;
        Mon, 03 Nov 2025 08:48:13 -0800 (PST)
Received: from monty-pavel.. ([2409:8a00:79b4:1a90:e46b:b524:f579:242b])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-34159a15b6fsm1607264a91.18.2025.11.03.08.48.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Nov 2025 08:48:12 -0800 (PST)
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
Subject: [PATCH v5 2/5] exfat: check return value of sb_min_blocksize in exfat_read_boot_sector
Date: Tue,  4 Nov 2025 00:47:20 +0800
Message-ID: <20251103164722.151563-3-yangyongpeng.storage@gmail.com>
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


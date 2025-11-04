Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A59022E5439
	for <linux-block@vger.kernel.org>; Tue,  4 Nov 2025 12:50:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762260656; cv=none; b=i+fxCZZkEpVmSkzN0qoT3ric3qX7+Z33Jm8MS69D/nf4Qe0Ym4pWQ/D/X2DtfRacRWBpQlzjeVp4FlphkHKdsRRL9Nj8wYqz0agiPtAz7VIFHSYTaCLtgPJfHmLG+UlvrU1a5PfaLJUp5S4hpuU7s2tcuBgUHq+b8J0qOfSqy80=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762260656; c=relaxed/simple;
	bh=WmtRZhDWkgJIzqTmohBXn31bc3c2KAlmHgsg5WATPKs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XPxXnLVYExvuJY/DtRz+Jij6KhEhLDYKdg0EO/ZrY7opuTRO/EpC7SfJLl+7H8k68m/1f2Zf2iWXdvkNfAqr/dSWrhOYFJhKnvB1i0Ibf3YY8zETueWW+Siva2zc7knRPBs3z8FALCe0kmE33exkID4K91j7FrrsslhnTZRC2Os=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IonmIC4L; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IonmIC4L"
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-781206cce18so5848075b3a.0
        for <linux-block@vger.kernel.org>; Tue, 04 Nov 2025 04:50:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762260653; x=1762865453; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ENGYR35a4dVgm7srDfRUWeoMwLvmN51DMzCkTe+nydE=;
        b=IonmIC4LhN1XzPTkIv8HigOViYXPokTfsztF7j9wSpyOwjWz3r9up6tbmwkDz+ddq/
         MyUVPriJjEjAkPOBz/7nwAPHo4QTJcburF0aBIGHXEv0cjF+769y4DplVvCyBbjC8SSJ
         SSvvhbPEtpGWiuP5uFNSHsBha/nS/Sio/DF3b49qf50jhaih6OJRZZBF5DiHzeQrV+VW
         Vg9hqiJuYJfnKoXyWuudeFXrXq6utP50pFtXlfYM286upkugh6X1OM26ITR6jKZfsEQK
         daj+CBBaP0u3gJO3oGGyqlJTTF5xSd3m1jUQ0usAB8kKDRYhrqx9rTeOmvzOPr+HtVgc
         2UtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762260653; x=1762865453;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ENGYR35a4dVgm7srDfRUWeoMwLvmN51DMzCkTe+nydE=;
        b=pvCwg5UnHGW0jdduaAcpPCjPOQyngMcw3iZdRFufa28X/kcaQTZfouPkLuXNB4z29u
         6gzy+teYTfz2/jZoyTPLq5rqpBWfaCuqyRp9raU7KHokUqlRQwIlm4vv7NSseesYqBx2
         +P8PUe/mOaRMwwRxkLGHE4kS9IuOwN/bbDh9/eLr+lDYbj3GBHxQNOngPE7zZbzkjXH1
         2d2nsx2D687K2NEKTfgtcu0Mkgk/GXkbS6SOAQ2A6G9ANaWb8IWpENVxwuzosgNsAV2P
         8BN5s2ie8dDD+5b6sFu0MOr9SSUccHVKx66RyNM0eSMjkNArcgkWE7l2TjLXcS5FGSXS
         8Ahg==
X-Forwarded-Encrypted: i=1; AJvYcCUGe6GJJWRGJ7RZ5PV2J5XLSMuCpw+7v08GbYJSCBkBSzAnYBhMGuej41+sbInE4L5QSuyYsPuJ9EGDlQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YwvEwlII8tJ2HGL2LyLliG3MefyFnYyM8hnxKYdgUxx/qQIO7/m
	2yTLeZMsrFBUHWuRkXaO7edxgqneAaZGGd6278ulB9mJ3SHc9lLR8vLb
X-Gm-Gg: ASbGncuHcULiE3YJmf4BJqd5sQVFXZXH8rgwO23ImYJul6Y9yMbHlAZ+DQbZWkmPFna
	P43HurnoeyYel+U7ikc8lWNaEhnzF7DUYirKujWWmEwL/zVeiz5M3wJCMdnN6bGi6zJWiXpdqOK
	HAlzg8KK38xPzs+LR+wR5DIdMd0dyZf5jkZvKvx1RkcySkDas3yLXejSoDgjz8nBrFgfQObO1BP
	RyaWW1oSqzEkEuwKmQziK6enxq7vzha5m/l8i/jJo+1N/p6foBqL1AAVZrXDJsg3weSDIo0DI/C
	A1XQxSAzl1ICckjovDKcLn0b8spZ32s+bfZvg2/Tfiv9VqIyj8nsZXCPCo4Vp+tnIn1TKYWaDfM
	Tv8jGlth6gF8eOrnHtb582Q9KLOcDNnjEuoA/mfb8lkX7zZC1IB5+P5x5QJC3+qhdnNdIkgMWUj
	nIJpPu/PxfTAFepzRCGaUE95jdgyC7tlL8NfR3HchFOtIULDA=
X-Google-Smtp-Source: AGHT+IF9GGj6LSoxr/C7fblJY9vEfziJTCbSQQeza2nw0zDMlzuQfM4TKJWECjNFJLSbFRIBSCyjKA==
X-Received: by 2002:a05:6a00:4188:b0:7ad:8299:6155 with SMTP id d2e1a72fcca58-7ad82997336mr1106651b3a.2.1762260652783;
        Tue, 04 Nov 2025 04:50:52 -0800 (PST)
Received: from xiaomi-ThinkCentre-M760t.mioffice.cn ([43.224.245.241])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7acd6d026dcsm2860710b3a.70.2025.11.04.04.50.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Nov 2025 04:50:52 -0800 (PST)
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
Subject: [PATCH v6 2/5] exfat: check return value of sb_min_blocksize in exfat_read_boot_sector
Date: Tue,  4 Nov 2025 20:50:07 +0800
Message-ID: <20251104125009.2111925-3-yangyongpeng.storage@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251104125009.2111925-2-yangyongpeng.storage@gmail.com>
References: <20251104125009.2111925-2-yangyongpeng.storage@gmail.com>
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
Reviewed-by: Christoph Hellwig <hch@lst.de>
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


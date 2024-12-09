Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D43C0153BFC;
	Mon,  9 Dec 2024 16:57:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733763468; cv=none; b=hRtSnEoVxo5cZDhRpBH98M93ay1mE7Gv1h8YNj8jtNR4gGbNoYtytRgaryHBT7hdleClZ/ifWf2rcqK80mnpGUBQMHj/b2aPJuJyi/5aQp83BOQaNYUKn/zDvlNxPMvT5yFgxwDqRZZ9fVxntXUg0yA7RRzXC+FjMWNqe6PMtw4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733763468; c=relaxed/simple;
	bh=o73P0u9wkOskRPgIGm239nyVo3oCprnaYIYczJzZ2bQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JH5lRNNHBUhRmhd2k1Ec05TraEgjCMpssW6RJ92yWzQB8X4IlQ8O8+UBleB7a9tlqVhFAYbPlQPKqDtXliNArEM3ehPvqAO2PyFFHu1299ZRxk3h/hXNTOdXjm5elc1RnPC3cor4LRE6phZ6yHzEHNboKuSB0YDeNSix6Gdkf7I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KQOUEAq5; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KQOUEAq5"
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-725ad59ad72so3183673b3a.2;
        Mon, 09 Dec 2024 08:57:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733763466; x=1734368266; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:reply-to:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to;
        bh=sUP+2JyKnLRQco8QsCJe4ce6gkYVIGp7F338G8iPtHg=;
        b=KQOUEAq5KJCGoew+Ng+S+2PA9fmvr2sHX0DX154tUgwXhOq2YQKQ4yGGS7U6AwCLRk
         jWH7erumn7Nl7Aspfx23opOnitVe4cm3sRUS8J9x2TFAcZKJPJG2MBZMB+9GEd3ySqTd
         ePtUO65Bn6u3z94RvVx+SpoTdNrLk6uM5wcBtonKBa7UOcWLqS5wmm82IanlXH2ygPq4
         Az4ToMGVVxOnjRQQMoJUfcqpGlIIKCQU2P8bjW2jSI7ZbR/YOxIZZ/akiwtsKchHPrzy
         vA1+/FeK4Rhu9gKKO6QAYS5T9/H/FNfgbiEI9OhSU2FyzS0JCaPCap85yOHBKwkIQKAc
         zIPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733763466; x=1734368266;
        h=content-transfer-encoding:mime-version:reply-to:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=sUP+2JyKnLRQco8QsCJe4ce6gkYVIGp7F338G8iPtHg=;
        b=TikSqwZF5MscpF0f8IZ2L9UBdXT/KL3itylf3ckCT31OFKnRNZWfLoaA8JA2vxvejm
         yhynmhDNfzhWME6+bN9/d4njjJPpjrXFq7FMzGfHcMGgE044Y9Ky/runu49/WNb7y7zn
         6g3myrKj8QZvPqZcUEyk2lcslYEPLtPbmi9TBwyePBATKmR+mao8M0PFkUjyfAH+vt4a
         eBviV0WeN8lE3yDtdzh8aYgbO3oMiZFYhb3LEkOeQPq9o6MSqtK7m+vwb7KF5oPu5XR2
         Yrz59vXzbw+ocqk+DhCy2csk5mxZi/+uxttYNkntZ0lq20B730ZwQmPOpm+UTsdpILZ3
         MujA==
X-Forwarded-Encrypted: i=1; AJvYcCU5vb7pIFRzqBu3xHhkIVaI5Ba3Sl5mNB1vhOWSA6oCS9t39guhAGfaHY0S03xZzbxyTBKjjQAzhdPuST7s@vger.kernel.org, AJvYcCUYdcEMUj6zCMl4dwhSgC5hscduckIpMcFzgIO7G40tN0LcP9ghhQPgPVlJCn8yMnuzgw0QmPVMKmyP/w==@vger.kernel.org, AJvYcCXk2tBx664d0PJ62mGw0010PiyVV8uyBBh+RdiK24xSaueCjmEIuEaB5Lx0frkwXgYmn8zdyEAm@vger.kernel.org
X-Gm-Message-State: AOJu0Yx8jOVYjuk8e7ybOGF3iBPC7ti1PJntowhcTRsmmRlPW29E6uID
	4IB8Iq9CRNYVebjpoVNxIZp6Q2ZbJImp4CE2SdWcF4b2Ku6rttQiMcIODIKekPpgHg==
X-Gm-Gg: ASbGncs35upb5W7t7WOLTLPuOULj32+SXsByluTeiwLAfk6B2L/o4KpvfyPL3tjg7WH
	mYVssM3wo8017deqD8wIV1b3BYXJSmxW06c+BINTQ24owP5geuedS/q1bCBKuIt0PwElLBZ4PWG
	BGZbamYoMYTXWjCigm3jEUmAhhOTgJHMsyDZC8muYwYJSLiLtoq/TM9YXMghlar9eKcRAjRZGae
	yuEyyHYHJ7cwqd3nTHXX+kjJcTA/2Ri/XpXYUixsig3qeHH7Ktdo33mMP4QbdPF+bsglEQ=
X-Google-Smtp-Source: AGHT+IFU9XNL4TYYMN57+MI1JthzbOjTs3oeXC9tvV2S1ujsyt7L/AjZO37t5fVZBxfj6fd+QgbvFA==
X-Received: by 2002:a05:6a21:e88:b0:1e1:a6a6:848 with SMTP id adf61e73a8af0-1e1a6a60975mr9194204637.25.1733763466179;
        Mon, 09 Dec 2024 08:57:46 -0800 (PST)
Received: from KASONG-MC4.tencent.com ([106.37.120.120])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7273c7f3f1fsm514201b3a.13.2024.12.09.08.57.43
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 09 Dec 2024 08:57:45 -0800 (PST)
From: Kairui Song <ryncsn@gmail.com>
To: linux-mm@kvack.org
Cc: Minchan Kim <minchan@kernel.org>,
	Sergey Senozhatsky <senozhatsky@chromium.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Kairui Song <kasong@tencent.com>,
	Desheng Wu <deshengwu@tencent.com>,
	stable@vger.kernel.org
Subject: [PATCH v2 1/2] zram: refuse to use zero sized block device as backing device
Date: Tue, 10 Dec 2024 00:57:15 +0800
Message-ID: <20241209165717.94215-2-ryncsn@gmail.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241209165717.94215-1-ryncsn@gmail.com>
References: <20241209165717.94215-1-ryncsn@gmail.com>
Reply-To: Kairui Song <kasong@tencent.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Kairui Song <kasong@tencent.com>

Setting a zero sized block device as backing device is pointless, and
one can easily create a recursive loop by setting the uninitialized
ZRAM device itself as its own backing device by (zram0 is uninitialized):

    echo /dev/zram0 > /sys/block/zram0/backing_dev

It's definitely a wrong config, and the module will pin itself,
kernel should refuse doing so in the first place.

By refusing to use zero sized device we avoided misuse cases
including this one above.

Fixes: 013bf95a83ec ("zram: add interface to specif backing device")
Reported-by: Desheng Wu <deshengwu@tencent.com>
Signed-off-by: Kairui Song <kasong@tencent.com>
Reviewed-by: Sergey Senozhatsky <senozhatsky@chromium.org>
Cc: stable@vger.kernel.org
---
 drivers/block/zram/zram_drv.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/block/zram/zram_drv.c b/drivers/block/zram/zram_drv.c
index 3dee026988dc..e86cc3d2f4d2 100644
--- a/drivers/block/zram/zram_drv.c
+++ b/drivers/block/zram/zram_drv.c
@@ -614,6 +614,12 @@ static ssize_t backing_dev_store(struct device *dev,
 	}
 
 	nr_pages = i_size_read(inode) >> PAGE_SHIFT;
+	/* Refuse to use zero sized device (also prevents self reference) */
+	if (!nr_pages) {
+		err = -EINVAL;
+		goto out;
+	}
+
 	bitmap_sz = BITS_TO_LONGS(nr_pages) * sizeof(long);
 	bitmap = kvzalloc(bitmap_sz, GFP_KERNEL);
 	if (!bitmap) {
-- 
2.47.1


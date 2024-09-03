Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A08A81A265F;
	Tue,  3 Sep 2024 07:39:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725349194; cv=none; b=FrmB68oSxxHDgwsOMTs+S+tEJB19GMfYP7l4fHHB0877a0+PvpjZpByf38r90QG1yUOAZMU5MKywq8YD0mtSRylQ3Hgf+MN0AlleK+IRlGWHimZK4ff0jHQt+v/1RvtfAEWCS97M145utn6CNxKt4h0keNQnWs/gMf95NQ2DTc8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725349194; c=relaxed/simple;
	bh=EiDLNxwKKnkMZFwsHE4Bymy8MpvE+0z9hJ7RekH0o/A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=vEfTKCtueBVd3FRPpYzHtsgTMqH1zO7/oIeRAgf/PxAq3SIXTra/302g/cdHNws3MGnzOYLiuBJ2NDeA+f58ZODSv1FBDCUU1i+lJwx/DxUafTadW7Tz7GLnVUHxvREplwOXCvOnYFOeWJqZ28Y6cOm1lN+LAZPSKY2GS8Q4oDc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lAd9WzEj; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lAd9WzEj"
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-374c1963cb6so1593769f8f.3;
        Tue, 03 Sep 2024 00:39:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725349191; x=1725953991; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PRm0/Vzd+IBZOxPnWEkylbsM0RpYW4Qu1xiihj16RO4=;
        b=lAd9WzEjDVxBMoO67b4U5EvD/OJBs/e9Ji38vPY9NM5oFyLDPDI36Le4eMo54M3nCD
         WZzz7ce1j+UtSozZ0q54zjTJxHGEMeFXkfE+wb//6vOVNbAsWMd5eurfhVhwxn6q6VMs
         JihTfhdUrX0jNbGeXFm3KXMzyCwzxUcEo/DrZnlCZHL/f6pHsAIB3DgkyUISjbaF0wjc
         OQZNIl89kT4ElsnILE9up813UPriKNyV6DmzsigWzvod0gS7Yk0bQVs2JB/vRk6yaFVS
         xkPyEnWbZtwEDclrm1Y6yaX+tPFg92S9JhsB/ffkBs7iSi+ssxmfVpOQHuJjmqBlbbB6
         f97Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725349191; x=1725953991;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PRm0/Vzd+IBZOxPnWEkylbsM0RpYW4Qu1xiihj16RO4=;
        b=HyW2iGSQkWtAPWHvhz3oftUVrpkOQj6/Y45Bbwve+z74UqNwTeJTzxYqwnjxlFS7ls
         2XW4KgB5oRgieckT2IB954bIuHkZrvguiKaBMmBdOpNZ5TMb9YnpOSp9VKxLJzdmRymQ
         agT2RWR1f4P7PiZSNuiykc+vXBtrizyxNsK8om1JxQZL8F1H18RBJQqtDYOcvEq1HDTJ
         HsOlIe0D199K/vzTFb8Z6Clma2mA551ApOn6yuyBlnW6lIHW/nqx+zGH78UX9KyeLsdC
         K/2RgsZhEi30vkHwaiYv2uqnk5TbHZBNiBi3KoX1i1Ch/k16yoiXHisQ9nsUShNdVFsK
         5VvQ==
X-Forwarded-Encrypted: i=1; AJvYcCUKobXTWSpZ63OEWQnkXQm3XsqGKjKdfaGCXwlk+7LvoixiH0OIiYIkkOmqY6B2fCRWMHjD3ukZBfZVyQ==@vger.kernel.org, AJvYcCVsOdEvR0o5ZRkJtR7nI6y/t2dXSJH7M6GEbg7MzjidMp2eOG2d7RdbI5L7rEewZkW4sn/CfbumTbcSyV2A@vger.kernel.org
X-Gm-Message-State: AOJu0Yw7+NZa9yG+pDT0WDKM5hLfSiNwScAvFfI3RdRjZHn3KJPJLzGu
	ZL/b+BRMt7pQrqzhjF5V8UwfF43qGxQqJVNFDWfDB6Aimca2Kgy5f9a1owKB
X-Google-Smtp-Source: AGHT+IEkhJxHZslU7i3GPmf9dlYG+9TiaVCh1DfIEYsncTTtGxTEAlnbV8hwvqFkwhaiIRKz3azZQA==
X-Received: by 2002:a5d:42d0:0:b0:374:c080:ee94 with SMTP id ffacd0b85a97d-374c080f085mr5372487f8f.27.1725349190766;
        Tue, 03 Sep 2024 00:39:50 -0700 (PDT)
Received: from fedora-thinkpad.lan (net-109-116-17-225.cust.vodafonedsl.it. [109.116.17.225])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-374c03595fcsm8342356f8f.98.2024.09.03.00.39.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Sep 2024 00:39:50 -0700 (PDT)
From: Luca Stefani <luca.stefani.ge1@gmail.com>
To: 
Cc: Luca Stefani <luca.stefani.ge1@gmail.com>,
	Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] block: Export blk_alloc_discard_bio
Date: Tue,  3 Sep 2024 09:39:14 +0200
Message-ID: <20240903073915.989741-1-luca.stefani.ge1@gmail.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <Zta6RR1gXPi7cRH3@infradead.org>
References: <Zta6RR1gXPi7cRH3@infradead.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The fs trim loops over ranges and sends discard requests, some ranges
can be large so it's all transparently handled by blkdev_issue_discard()
and processed in smaller chunks.

To support cancellation (or suspend) requests we need to insert checks
into the the loop, exporting the symbol allows to reimplement
such loop with the desired behavior.

Signed-off-by: Luca Stefani <luca.stefani.ge1@gmail.com>
---
 block/blk-lib.c        | 1 +
 include/linux/blkdev.h | 2 ++
 2 files changed, 3 insertions(+)

diff --git a/block/blk-lib.c b/block/blk-lib.c
index 4c9f20a689f7..ebaef47d8ce7 100644
--- a/block/blk-lib.c
+++ b/block/blk-lib.c
@@ -59,6 +59,7 @@ struct bio *blk_alloc_discard_bio(struct block_device *bdev,
 	cond_resched();
 	return bio;
 }
+EXPORT_SYMBOL_GPL(blk_alloc_discard_bio);
 
 int __blkdev_issue_discard(struct block_device *bdev, sector_t sector,
 		sector_t nr_sects, gfp_t gfp_mask, struct bio **biop)
diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index b7664d593486..f3631044d905 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -1088,6 +1088,8 @@ static inline long nr_blockdev_pages(void)
 
 extern void blk_io_schedule(void);
 
+struct bio *blk_alloc_discard_bio(struct block_device *bdev,
+		sector_t *sector, sector_t *nr_sects, gfp_t gfp_mask);
 int blkdev_issue_discard(struct block_device *bdev, sector_t sector,
 		sector_t nr_sects, gfp_t gfp_mask);
 int __blkdev_issue_discard(struct block_device *bdev, sector_t sector,
-- 
2.46.0


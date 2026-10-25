Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.175
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792944698;
	b=UcihoxBBSxtUZLjg3KFvsijj6xu8hNSa1IluB0lWMpOBCNmhvBQIPWASnucyed4EcEt2
	 om+CSamhe8BcToGPlzAsyBAjLazQhEmgt3I2OBuY687LP9uRYaXCRBHk7X/OUQ5z3eb1m
	 vZcKXdqM6BnmRYEymWyD6hzY+1FLHcy5P9q279kBZrOtcZCW0Jk3L3Eo1AIK4CZdiqmGm
	 nQzbzLL/ME2wYi8zjjca0FZv9An1GlpsOyibSg2kjN3nPZ+efYzHt7znxa3wq7paBSIC1
	 cIsD9lS9eC00kEa1fzaQ0R2KSkClw4rxFhv5TsdPkyWYIeEW1FnjAxsgwYEdgzrbCyA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792944698;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:MIME-Version:Content-Transfer-Encoding;
	bh=C3I09PsOwanE3onBdlLxzkDeS22ydCPmlVESj5Ag388=;
	b=Fc4qcgjFdnFbFZdLov9X8IrU39m7hZCuIYdT5Oowi09+bXPVGkXbBAH1VqoMO6gYmfzX
	 bBd1ez5VyHP1dDmXPhWlpoJ0ixB8GF238Hwb+3CkpMSKuVEaqFxUL8AOdiMXXbIHSuBJV
	 hPOPBK5sMLfyn6gOzOeHPnMkfIutLSb0lVm60Y2SK+wJKKFsfANa/Ps8+8pO4kYAVZNqZ
	 nC6E6B8T5t7sh1cT49y7BqfSoa0Fuy+xKMHvmVPoVyPRURhjj3Bd0ArD/T9MEvgtc/u2t
	 6FeUMKp29JG2kpXIph0ibF+PMcI/dU4VHWJqfJ+ByZIPZGWxsV0Q8Lz8dgV7x2RqAVg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=GVAD+nPJ;
	arc=none smtp.remote-ip=74.125.82.175
Received: from mail-dy1-f175.google.com (mail-dy1-f175.google.com [74.125.82.175])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 964AB606A31B
	for <linux-block@vger.kernel.org>; Sun, 25 Oct 2026 16:11:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 964AB606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=GVAD+nPJ
Received: by mail-dy1-f175.google.com with SMTP id 5a478bee46e88-35b2c599f43so618636eec.0
        for <linux-block@vger.kernel.org>; Sun, 25 Oct 2026 09:11:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792944697; x=1793549497; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=C3I09PsOwanE3onBdlLxzkDeS22ydCPmlVESj5Ag388=;
        b=GVAD+nPJOfMo9DCQIvYeywyeLpqGlYy29jJLpo3vSlsjq6LFbec0XUy5tJEr5mOzhK
         BXs3rTgavPoB6t7mjCPVb263H9sZBGnWIjjWYBSF7ItCyvub/GTRLi705GP7cCdyS8Qs
         S8vzpnklLjPGeCMZz2a+GGkRqgUWoZVFM3673f6KEmrxNPSheotQwlwOe/PHSCvn+fyW
         uDYlXpVfrlp5mqz6JBQgFBQmOHwkxk1a1dWykxPIpJuMXNbbG7MZ9x/s9J1i8EhNFnDj
         7HybPN8vdSpNxgCduBjK1WkEY+y4tRG/7VtlUWHLCI8S1rbz6HCdNskaXWwrTb/62U/g
         YBqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792944697; x=1793549497;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=C3I09PsOwanE3onBdlLxzkDeS22ydCPmlVESj5Ag388=;
        b=zrU5lDvoAFC2HOx0rPxxm2mdvT6UvBV+UpcNAsCH4D39PjUOvRWM720PpcflWD1lY2
         0TGT5pkrgXYnhjNEoFQW6aJ3PA1g8UQ8orq5iLXmaPcyIzrNnoSFUwGqkIJA0V2znMtL
         So3EwbVLvAF75qdxSRLogwLxDJ2FTVp8N58pCRY16mz7QlspTcj7XHVXvhWEunsJkn+b
         OJ9fFWO3xR36/Ogrso7c7bdQ56WAFCRFeLEA3Bf2kyEd0aOexxgDdEx3dqIaZkoH7a/p
         NlFz1x1tiI9126PXg9C5BlXU409RpjSvh+pG7k1MBzb25pDftNUqkuvD1fc5bmhNTWXP
         3w+A==
X-Gm-Message-State: AFq9FYLMrHWI7FNUvcSZe0JVb2FCFfofyHtUGplglJESeGEk5sYgf/D5
	E7xRCnOe41m45yfGFt75GlWQGX7hSuMK6fNxDVjxAqu2v+xuG1i3anxh
X-Gm-Gg: AYBFou1G7hJAWQ3T6wpC3SpkAnDfxeLH2/EBgEnI+zGkInyeUZltfw99u06Sry5YnC6
	psqlIuFO/smLyPzGdgGDjWUhtHwLGxI6NuFrLybwrBUndSnOY9ujo4MGYhn+AWus1r8llUc5yYC
	u+hJnJIAjs9IW4hOXwsC6sRKFFxSamTYT3TyXzF3BlVQ7um4UnwDAzfZlcXDDzTWqOPPrKgVSGl
	HgwY1uojkkL9xEdu+ezuofx1vhtsqdfy42WwQwRdIfWRAC+3pYNOMXeGKe7AxWpTbEUCUxv1Tj6
	USjGBCdhZiqEYpgsrULAzSWmAHPJJWgxGfdIx492yxa5Q6UNALAQyj6gnXtI0cPJ7TVkodgy+KS
	2sgY3qltFHnqXueJvVoRoE0ufA4wFx6WaLJivgF3VnMm9iKH0cr2m0BLzBCzNFEihpNxmOWzHSH
	VnLTC2D61m9cKIbE6u31mEZXd2vXUHTUK1p3bq2iixd7QpGWRI6TRsppI3yvlR0d0VoHu0ISe52
	ser79fTQxcB5Dx1Nsolqzu4+RhlBmWAfqEajX/5Q3CV1STJrtXmcSza5MPMsFFHo650mEF9
X-Received: by 2002:a05:7301:2f31:b0:369:d8e1:7bad with SMTP id 5a478bee46e88-369e84d7714mr6866504eec.34.1792944696530;
        Sun, 25 Oct 2026 09:11:36 -0700 (PDT)
Received: from asahi.tail4da9e3.ts.net ([218.48.198.193])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-369e8daa3a8sm21919868eec.16.2026.10.25.09.11.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 25 Oct 2026 09:11:36 -0700 (PDT)
From: "Baek Kyu, Kim" <pocj8ur4in@gmail.com>
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	"Baek Kyu, Kim" <pocj8ur4in@gmail.com>
Subject: [PATCH] null_blk: reset cache state before device setup
Date: Mon, 26 Oct 2026 01:11:33 +0900
Message-ID: <20261025161133.59344-1-pocj8ur4in@gmail.com>
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Post: <mailto:linux-block@vger.kernel.org>
List-Help: <mailto:linux-block+help@vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-block+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The CACHE flag belongs to nullb_device, which outlives each powered-on
nullb instance. Power-off discards the runtime cache but leaves the flag
set. If cache_size changes from 1 to 0 before the next power-on, the
queue advertises write-through while new page writes still go into the
cache tree. A completed write can then disappear at the next power-off.

Clear CACHE before creating the new instance. The existing cache_size
setup sets it again when the new instance needs a cache.

Signed-off-by: Baek Kyu, Kim <pocj8ur4in@gmail.com>
---
Tested under ARM64 QEMU/KVM through configfs and the null_blk block device.
After changing cache_size from 1 to 0, a 4 KiB direct write to a new page
read back immediately on both kernels. After a power cycle, the baseline
lost the pattern while the kernel with this CACHE change retained all 4 KiB.
Both queues advertised write-through.

 drivers/block/null_blk/main.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/block/null_blk/main.c b/drivers/block/null_blk/main.c
index 6beb1f5b71ac..ec0d7ba4d938 100644
--- a/drivers/block/null_blk/main.c
+++ b/drivers/block/null_blk/main.c
@@ -1976,6 +1976,7 @@ static int null_add_dev(struct nullb_device *dev)
 	rv = null_validate_conf(dev);
 	if (rv)
 		return rv;
+	clear_bit(NULLB_DEV_FL_CACHE, &dev->flags);
 
 	nullb = kzalloc_node(sizeof(*nullb), GFP_KERNEL, dev->home_node);
 	if (!nullb) {

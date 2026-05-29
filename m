Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A23993A9619
	for <linux-block@vger.kernel.org>; Fri, 29 May 2026 08:53:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780044824; cv=none; b=E45o+imyz3n1O8C/m4JMSm0tJn5zE7yxpNWk0cgvyf9xvV8DMDG8K1IdAMOrNk4n7UwLR3LqmwmwVe17em/v/exXknnvJGyfj8NdmTSS4ifSsjpKDgel1ccLlzr23vNDZPC+MpSmVEDtgibmJ+Iej9j5v+jsl9glOQ25BFvp7M8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780044824; c=relaxed/simple;
	bh=FyoHFrGRRI+aMqGck5x5ii339plHkAlI7euqWoBRry0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=kCX4yufq+yloXSGRJncqAF7eGdAfbjjxkzsColHTzrDDmr8gB9/cexrIQkGwGFbGxUohMYY8jqx5dcNPzWiqbemJevFUvAga0pcB9T3nSlV97BgKWK5yjeuENvJXxbVMiYqKdXqvgGCq0YVC7Vv1vZo9y743yYtqxqjzOcaRIGs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aSVB7Sfe; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aSVB7Sfe"
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-490426d72f7so68305395e9.3
        for <linux-block@vger.kernel.org>; Fri, 29 May 2026 01:53:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780044818; x=1780649618; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=2R3/HY+TZwDP536xdY5FCSiiUr5tHBZfz6LP9l2pe1g=;
        b=aSVB7Sfe35R4QxQ1xTmw1BTV1sk/8MzCzJfMGmrQ6b/C6wOUMDRwMKhh3SkdNRqsGU
         r4TX8OSfoa/BrYm/t3qCIn/jS76W/HTgjz9IlWs9jKxZFUCGv1xnq8SqREMBz5Q8ODsw
         Rt5yI/H7jOBmnKiv1B8Ehlx5mz0+10LGPUVc/8+GOYIRXo0mxiZrcjd6RwxZTICy6mJb
         iaviRjKcB5WO9xRgqYccuVZA4r3Tht1OFX7Z3TnN4zxdp1mSwZxCrbMHqURQQfwpRcJZ
         6+Fb1YTQ1EZYw6SMMMbGgfOwjGdxPtCPpn9Ymjga7/Bw5KxVXQXfU+ichOtMhfsWJTWL
         pXaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780044818; x=1780649618;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2R3/HY+TZwDP536xdY5FCSiiUr5tHBZfz6LP9l2pe1g=;
        b=aVzRdV91J3bQ+Y7dp1mFSMy8sTfFq8gVwCCPTNg09Mo3rRVGU1tTdgCMrP+KNs/Bml
         1444/ZN20ZwY7DUtHdfdu0IruoQX5smlaUQTJQVjcU2U3Bjh8NqRiB0wkWBT025/cDdS
         qlO0J+OSV+R/+tZ45zN98cGMJlxhuhFOmxlrXfDcYe5WznHoDKFYqOeKWNwtmR/jAz7X
         mqKIJee0W2mmnq8nZZQlI35J6zVZbHG39qzmyLqraaNh91dNn+pRDInK8oEZ3sKklXhd
         /UIgJEDJjL2SI8dUftfHcbJrBQ/sNsgBmCph4zR9pguSlLI0LHWTpvHq4rkupDGavKeb
         fxTA==
X-Forwarded-Encrypted: i=1; AFNElJ81ymuWIdcRen/1VQ2j5Rdq0ovIVbIsMAqGxZpmml797G0TTozDguxeB17VrFbSzP8vjQEC899Y3NVhog==@vger.kernel.org
X-Gm-Message-State: AOJu0Yx33AHmAzptl/+eVGuDl5dL8GsKJ7qrmwI56RFOjs884UqbVm++
	lTtCtUTg3BotndiT0p7DzbfFsv9f7cLh95WPOuJhc4jDRVIPwo0l6e4i
X-Gm-Gg: Acq92OFlcJZqLLFaXOey3bogWGsVR7oO+FXTAb+R9Va2b/MEMpOyA0Z8oiN6zbhBxkb
	Lt5IxdXW4hdcLrRtgo/CxrZo8jh7IJg6vO4twEA9HRbyEVpJ43f8k7XkNMlga8RuD/oxnhCbUwU
	urYtTKZnO2DXEWWi6nq6uYBuFCsbAXyh2L447jrqXeFYcyRN6tEpy4IMnZuZkAFft6GFk5CsAmv
	AByxJ217zqZUXzmV3Kv4uVVWJH+3A/lvthFjXMjTXFP2a/S8ETMQ/l33wisYiR2twAQUbZe1qyB
	wCFQ0p46Ifww6llvk0sJZK6ps42Z9nL5JIlSWN8+8FLCBDW6+3LCOoCHn06cxu67snytq1PBTF3
	1YMZhSIqrw+O5IT8EfKiteWbyGccKUErh28q1dLGwSOHg83Lht144lyu2Q2gc3o8TPtvFhAowTA
	TfPHpIeTa03ySPB3b2+zlPHU36M1KTCEEhVIci56F2XA==
X-Received: by 2002:a05:600c:6a8b:b0:490:778:4fec with SMTP id 5b1f17b1804b1-4909c0d3a70mr21125185e9.33.1780044817504;
        Fri, 29 May 2026 01:53:37 -0700 (PDT)
Received: from x1.tail0e71db.ts.net ([46.140.7.198])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4909dff2a80sm29453685e9.3.2026.05.29.01.53.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 May 2026 01:53:36 -0700 (PDT)
From: Ruslan Valiyev <linuxoid@gmail.com>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>,
	Jens Axboe <axboe@kernel.dk>,
	Kanchan Joshi <joshi.k@samsung.com>,
	Anuj Gupta <anuj20.g@samsung.com>,
	Keith Busch <kbusch@kernel.org>,
	linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	kernel test robot <lkp@intel.com>,
	"kernelci . org bot" <bot@kernelci.org>,
	Ruslan Valiyev <linuxoid@gmail.com>
Subject: [PATCH 6.12.y] block: make bio_integrity_map_user() static inline
Date: Fri, 29 May 2026 10:53:34 +0200
Message-ID: <20260529085334.937482-1-linuxoid@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jens Axboe <axboe@kernel.dk>

If CONFIG_BLK_DEV_INTEGRITY isn't set, then the dummy helper must be
static inline to avoid complaints about the function being unused.

Fixes: fe8f4ca7107e ("block: modify bio_integrity_map_user to accept iov_iter as argument")
Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202411300229.y7h60mDg-lkp@intel.com/
Signed-off-by: Jens Axboe <axboe@kernel.dk>
(cherry picked from commit 546d191427cf5cf3215529744c2ea8558f0279db)

The same build break is now reported on stable-rc/linux-6.12.y by KernelCI.

Verified the upstream cherry-pick applies cleanly on top of 97928cc88900a
(Linux 6.12.92-rc1) and that block/bdev.o + block/fops.o compile cleanly
afterwards with i386_defconfig (which leaves CONFIG_BLK_DEV_INTEGRITY
unset). Without the fix both files trip:

  include/linux/bio-integrity.h:101:12: error: 'bio_integrity_map_user' defined but not used [-Werror=unused-function]

Reported-by: kernelci.org bot <bot@kernelci.org>
Closes: https://lore.kernel.org/all/178000554419.7114.5687032601791586484@330cfa3079ca/
Closes: https://lore.kernel.org/all/178000194591.7095.11275948264529325340@330cfa3079ca/
Signed-off-by: Ruslan Valiyev <linuxoid@gmail.com>
---
 include/linux/bio-integrity.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/bio-integrity.h b/include/linux/bio-integrity.h
index be91479b2c42d..53f6dbd2816e0 100644
--- a/include/linux/bio-integrity.h
+++ b/include/linux/bio-integrity.h
@@ -98,7 +98,7 @@ static inline void bioset_integrity_free(struct bio_set *bs)
 {
 }
 
-static int bio_integrity_map_user(struct bio *bio, struct iov_iter *iter)
+static inline int bio_integrity_map_user(struct bio *bio, struct iov_iter *iter)
 {
 	return -EINVAL;
 }

base-commit: 97928cc88900a9fb07a4dddbd1db19eb0ce55c56
-- 
2.43.0


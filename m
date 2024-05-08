Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6D237F7CC
	for <linux-block@vger.kernel.org>; Wed,  8 May 2024 07:43:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715154207; cv=none; b=a8iPzIA+jRhPwXZUe3dSEAwQwndqICWe5kSJ9J6vXSU4sCtl03RtevulX3g2Mk27qnotfHddRIWXDVRe/o1notKqQd/IGB88sl9HGdPOHQMPrC7W+RQvXcRyoUnJK7M3TMyl0yK701KPHUWD5yP3+uBJNkgeFQn8/9UapMGGAmA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715154207; c=relaxed/simple;
	bh=0QKD/VRLqE4UJhTMThwx4W0GPaxzgatlvvK+3EE9Gd0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BSfPD5NTAKyeCcKD8ubXUL+JudfjopAiunfn2QEmeaThn18o8l1zzGvVWGkQoJuzJ2tEUqLCpP+PD+zNB3PoaaT7vhtSGyqL4HtUE2rOymIYeVVs73+4yDew0PYe12evhu3HHd41gRT6a4hoa3K/UiZpC/CCEtFEJ99U2Eh6jfM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=UGL7O0Si; arc=none smtp.client-ip=209.85.216.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="UGL7O0Si"
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-2b4952a1aecso2722587a91.3
        for <linux-block@vger.kernel.org>; Wed, 08 May 2024 00:43:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1715154205; x=1715759005; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ow2rUHFnrcYhlTotFbBj4Gwxyq4hSnuB9nn9e+mMxIY=;
        b=UGL7O0SiV6EoBU3l0lP0gPA1waybDambjYpwsSAgQUqgoCrPnL+Ua8eE+bWKvouG31
         jUfZDMHyVx1ImFpR4VjxdHwJ5Ix+Y2rebf/zuV8BTXY5pdk7JPvmq5SPjZ5CyaZXMjDO
         5P76Sb+vvENpJ4XFgtgxGNZl9S5SDghCRGGKQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715154205; x=1715759005;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ow2rUHFnrcYhlTotFbBj4Gwxyq4hSnuB9nn9e+mMxIY=;
        b=eXBv8HsdfWmkUxjbBkUbq78gEv/As3Pczoc7Zse2J5ZxMSOqitJkRFAHqSRW3ZWtgg
         AiFJ+QXRoWKDUoF47QY8j+VvXYpUrVra81tVGEbMVV9XSDhUfJ+EQyiW6b93LK3oh0Ib
         jcQUwQejoDExd+sGJviPUCWJyF84O3tPuU2hWR3ZbFCGhV8cJjixgHnKP0DToOFTMUrt
         gc4bXAbblrn/j63k8fAVRXy/BNgrrtDwX2QHRr5kGpPjy8Ixy+bOv4+h6mludK3aZ/AC
         3tbYBixQ3pfx26/bkogINOsmfSxSA++uR06swwV/2XWUmoaO2413kWbdDd9M9aS827v3
         W5jw==
X-Forwarded-Encrypted: i=1; AJvYcCV3bMORLi4VZ1za9VwEO9q3dr1riUzyc39lzjLfyTvr27CJWNASAgQess2flPttxPO82pACaIe4XgjylVEugLehvYAr0jeLCrAuSd4=
X-Gm-Message-State: AOJu0Yzh57caipaXbieAMHWfW1MAX0lb0arzxCepkvrhzn34jqYQPmje
	ucEaJxU+tHub0x0zUjLCqvwQwZJlpZPnh+QhtTjJwAqM6EqZA5uPMNpOTcswcg==
X-Google-Smtp-Source: AGHT+IE1GlyzbHlgtHh03vLzDAXZBLlDXZN7nerQilU82pSz8k6bsqpHgAvqZzQ1IEihysz0KtfQbA==
X-Received: by 2002:a17:90a:440f:b0:2ae:e1e0:3d8f with SMTP id 98e67ed59e1d1-2b6163a22cdmr1679910a91.2.1715154205219;
        Wed, 08 May 2024 00:43:25 -0700 (PDT)
Received: from tigerii.tok.corp.google.com ([2401:fa00:8f:203:ad4d:5f6c:6699:2da4])
        by smtp.gmail.com with ESMTPSA id l5-20020a17090aec0500b002b328adaa40sm780011pjy.17.2024.05.08.00.43.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 May 2024 00:43:24 -0700 (PDT)
From: Sergey Senozhatsky <senozhatsky@chromium.org>
To: Andrew Morton <akpm@linux-foundation.org>,
	Minchan Kim <minchan@kernel.org>
Cc: linux-kernel@vger.kernel.org,
	linux-block@vger.kernel.org,
	Sergey Senozhatsky <senozhatsky@chromium.org>
Subject: [PATCHv3 19/19] Documentation/zram: add documentation for algorithm parameters
Date: Wed,  8 May 2024 16:42:12 +0900
Message-ID: <20240508074223.652784-20-senozhatsky@chromium.org>
X-Mailer: git-send-email 2.45.0.rc1.225.g2a3ae87e7f-goog
In-Reply-To: <20240508074223.652784-1-senozhatsky@chromium.org>
References: <20240508074223.652784-1-senozhatsky@chromium.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Document brief description of compression algorithms' parameters:
compression level and pre-trained dictionary.

Signed-off-by: Sergey Senozhatsky <senozhatsky@chromium.org>
---
 Documentation/admin-guide/blockdev/zram.rst | 38 ++++++++++++++++-----
 1 file changed, 29 insertions(+), 9 deletions(-)

diff --git a/Documentation/admin-guide/blockdev/zram.rst b/Documentation/admin-guide/blockdev/zram.rst
index 091e8bb38887..58d79f9099e3 100644
--- a/Documentation/admin-guide/blockdev/zram.rst
+++ b/Documentation/admin-guide/blockdev/zram.rst
@@ -102,15 +102,26 @@ Examples::
 	#select lzo compression algorithm
 	echo lzo > /sys/block/zram0/comp_algorithm
 
-For the time being, the `comp_algorithm` content does not necessarily
-show every compression algorithm supported by the kernel. We keep this
-list primarily to simplify device configuration and one can configure
-a new device with a compression algorithm that is not listed in
-`comp_algorithm`. The thing is that, internally, ZRAM uses Crypto API
-and, if some of the algorithms were built as modules, it's impossible
-to list all of them using, for instance, /proc/crypto or any other
-method. This, however, has an advantage of permitting the usage of
-custom crypto compression modules (implementing S/W or H/W compression).
+For the time being, the `comp_algorithm` content shows only compression
+algorithms that are supported by zram.
+
+It is also possible to pass algorithm specific configuration parameters::
+
+	#set compression level to 8
+	echo "zstd level=8" > /sys/block/zram0/comp_algorithm
+
+Note that `comp_algorithm` also supports `algo=name` format::
+
+	#set compression level to 8
+	echo "algo=zstd level=8" > /sys/block/zram0/comp_algorithm
+
+Certain compression algorithms support pre-trained dictionaries, which
+significantly change algorithms' characteristics. In order to configure
+compression algorithm to use external pre-trained dictionary, pass full
+path to the dictionary along with other parameters::
+
+	#pass path to pre-trained dictionary
+	echo "algo=zstd dict=/etc/dictioary" > /sys/block/zram0/comp_algorithm
 
 4) Set Disksize
 ===============
@@ -442,6 +453,15 @@ configuration:::
 	#select deflate recompression algorithm, priority 2
 	echo "algo=deflate priority=2" > /sys/block/zramX/recomp_algorithm
 
+The `recomp_algorithm` also supports algorithm configuration parameters, e.g.
+compression level and pre-trained dircionary::
+
+	#pass compression level
+	echo "algo=zstd level=8" > /sys/block/zramX/recomp_algorithm
+
+	#pass path to pre-trained dictionary
+	echo "algo=zstd dict=/etc/dictioary" > /sys/block/zramX/recomp_algorithm
+
 Another device attribute that CONFIG_ZRAM_MULTI_COMP enables is recompress,
 which controls recompression.
 
-- 
2.45.0.rc1.225.g2a3ae87e7f-goog


Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB673763F7
	for <linux-block@vger.kernel.org>; Wed, 15 May 2024 07:17:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715757469; cv=none; b=KazZC1BwTv4SGHvoKKAqw0o741wu8oCrhgOV/wtJ3zAh3LD1o02Ypq9vEFqlARkKUsqm3fkX8eFMvei/H2tsRvIoW/aR2ouSvbHGHiGcy50kuWpTb1dDF66x1pHvOUznYj6xQbT+zN+2Zhp/UTAqCJt0if+PBp/U7RI54C0mqjI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715757469; c=relaxed/simple;
	bh=0QKD/VRLqE4UJhTMThwx4W0GPaxzgatlvvK+3EE9Gd0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ictz6hF1GcdpUj9PRkuzQX6jmRtVoFxCkqHAqI7beLai8ojoEvnWrh3uqAfgvRTc9unZ8FdWu/rp2fagtY3VRuFrfNO+uykk5q+6N0PHn0cIGsgTKc2r7rHe36SZGWCQzvpr1ElfDfOVJa/XEsHguYHIpQ3BmamfbQ0s1UyEsas=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=YHQzgsw2; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="YHQzgsw2"
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-1f082d92864so16529405ad.1
        for <linux-block@vger.kernel.org>; Wed, 15 May 2024 00:17:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1715757467; x=1716362267; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ow2rUHFnrcYhlTotFbBj4Gwxyq4hSnuB9nn9e+mMxIY=;
        b=YHQzgsw2miaw+A94pdrS9zbw6+Yen4uDKAHCSsd+5Pv/WyQAA41PeR3hs1rChZ6Yc9
         CPSflOIuyfyGCdPWV0kx5WKzNQ/E8BsOREcSthOX/Vb58PcCkQ7RNy/on1u5NRyRWuxV
         10TMPfYFcNtQe4w9M+ZBzIRuCTEv6/IFvkLd8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715757467; x=1716362267;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ow2rUHFnrcYhlTotFbBj4Gwxyq4hSnuB9nn9e+mMxIY=;
        b=sC/h1lwiQSR9khnnv6VZ4BK3jNhh9I42jGVJ8D1Q7pJaBezsOTAwjqcorCiFcPNyhO
         AI76sBkQVbKZCOf1/4cFBzQL2S7JsICvkn/p7wzYXsFNXz4/LtrpVGY0sqSUEcJf/Tqb
         cYMWoFg4Uvoyefuzn3huqWrgNvdzEB3ATge5iBVGBX7g/BmQ2+Aqfl9+sX/fchA8cMYY
         spSDqeNvUXmaXUH57uqFWuMWCOE4KWX769Q3gBZbg6rpB8V6SAMbeSpMisZMm22hBJfU
         9vpNg4x4ytJK5ozr21AcjjHPxnH/UxNuOV14k4BlHWpqSfm73GuPqROkam2o+w5q8CXD
         ttxg==
X-Forwarded-Encrypted: i=1; AJvYcCVWPTEiDd9fk3SbX4y3BbtX/01yrTSQrlkpz4S8pJkG/+Sp7eE1EJ2FAdBMUGPWpz6+EVdRuXpWQYUaUZSi2RZxawbwhHcGsO40fkk=
X-Gm-Message-State: AOJu0Ywnt7aic8ahKEJw28o2/mjAhhLuwoIBIt0RQLW0GnmO7Nl0pMrU
	Sxox5B6/XuZs6uaaNBZQIss1QcGMsSv3ehE8bpKGOap6NSSa+NNiWE8nVCia5w==
X-Google-Smtp-Source: AGHT+IFUXSL8PagKambUAn3JNk1vaS0WDwvdWErdRIsdpbLz+NRveFk3xgU/oe2NPDEqLe4EoIXhzg==
X-Received: by 2002:a17:903:984:b0:1eb:7746:4248 with SMTP id d9443c01a7336-1ef440495abmr176201825ad.54.1715757466991;
        Wed, 15 May 2024 00:17:46 -0700 (PDT)
Received: from tigerii.tok.corp.google.com ([2401:fa00:8f:203:111d:a618:3172:cd5b])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1ef0c136d53sm110941605ad.254.2024.05.15.00.17.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 May 2024 00:17:46 -0700 (PDT)
From: Sergey Senozhatsky <senozhatsky@chromium.org>
To: Andrew Morton <akpm@linux-foundation.org>,
	Minchan Kim <minchan@kernel.org>
Cc: linux-kernel@vger.kernel.org,
	linux-block@vger.kernel.org,
	Sergey Senozhatsky <senozhatsky@chromium.org>
Subject: [PATCHv4 21/21] Documentation/zram: add documentation for algorithm parameters
Date: Wed, 15 May 2024 16:12:58 +0900
Message-ID: <20240515071645.1788128-22-senozhatsky@chromium.org>
X-Mailer: git-send-email 2.45.0.rc1.225.g2a3ae87e7f-goog
In-Reply-To: <20240515071645.1788128-1-senozhatsky@chromium.org>
References: <20240515071645.1788128-1-senozhatsky@chromium.org>
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


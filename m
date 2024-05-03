Received: from mail-oa1-f43.google.com (mail-oa1-f43.google.com [209.85.160.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 871FA153BF6
	for <linux-block@vger.kernel.org>; Fri,  3 May 2024 09:19:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714727950; cv=none; b=erj9Zhh1nPQob/3jNDk5xtF/E7njA8VfAxfg2GMxiSVBGZTbStPu936ssr+WkpIqlfUDUCi48ZrfYUsIII06NyYvi1QXz/4HteOWtt3Qp+yCqo17G5BCFgXrnzFwAtO8iWXSoJmsDXFByrx+s6u+tnWXsdpHFAn5efm+2uqjgIo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714727950; c=relaxed/simple;
	bh=0QKD/VRLqE4UJhTMThwx4W0GPaxzgatlvvK+3EE9Gd0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ElMue4yRihoYqS/RqVtelBCaaWL9yJrtsj2McOWIk0a60MLntmGFvKMCQPnAxlnvRqgVTjiru8ydHbINWxSngK+Kfr/4Rr1e9dfSBYk+L0DiO52wl8vuxSjmPeicHm9q/Vy4kiuXraAz2FK1gg6t2seyPtNd6wPbdVf2vJSj5nM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=IHOz0KbR; arc=none smtp.client-ip=209.85.160.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="IHOz0KbR"
Received: by mail-oa1-f43.google.com with SMTP id 586e51a60fabf-23e7f487ca6so100979fac.0
        for <linux-block@vger.kernel.org>; Fri, 03 May 2024 02:19:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1714727948; x=1715332748; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ow2rUHFnrcYhlTotFbBj4Gwxyq4hSnuB9nn9e+mMxIY=;
        b=IHOz0KbRsCWDmyk62A8DSzaWNbCFkXUEHz7oF0LP+WFTA/3tZYHrLdsPPsQZE3T3DJ
         RqpuzC4c/zAin4Jdd5j4mTZi0AZyVWEOcRynU0KWu6zjVlw1S6d8KXOMxHoUZzbmX3ap
         FaeyM8UlIekF3evU/I46w9C+sTX631q4Jto8s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714727948; x=1715332748;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ow2rUHFnrcYhlTotFbBj4Gwxyq4hSnuB9nn9e+mMxIY=;
        b=J01ROut+tCL9jX/w3rIX5GSjX6R6bAjSL37rsffee1jAONZA6w5+PWCaL7gJ1dCcog
         of5iX9S0q+esCUg3H9qYNR0SCwbUtYOVy/WTYqcOv04S2XFIjeBEVC6MaDs1aclUfTn/
         nJvvcx5u8G/BPIWQxbVR0q+3Yzyt99rMA1G8bz91T8yK5TqOpVROF2cbQ/7e7arlWMWW
         dZ3ycYz4qGPDLmdOq5PjQCWwj6lcdYDYXW/c/7TvTzsWazFhoVWJ8RLOnTr60ebzQkZE
         raqBQE8oSNIK7+HB/s5pzrBa1pDDhRnIK3+JFblJF/TzknPxUj53fYxzqbNHvK9aWPDO
         rncg==
X-Forwarded-Encrypted: i=1; AJvYcCVxYSk0KZ7MZzhmHKAxk9WQUydiiZD/PU5OwBn/OI5BT6M44QKvU7g9m8Txm6+Jut1GqQDSNAqO9Ulgt3wTYdkLDLi88N17PxMtSdg=
X-Gm-Message-State: AOJu0YwhK7nOJDzvP1Qf4BJ8KLhu95ozCzxTbkTlB4FIhFonTxPQyc4b
	TtUAfSeXbLku3/pJibdZLQNndjPg/IHIIOTaRqNeE7QaQsy5TToVYws9mZJGB775CTuAMhJdWlw
	=
X-Google-Smtp-Source: AGHT+IFh54usQd29tLvgBlBuW5xhaTflCGP1cxkIKo9T2fan/lx76Q1QQ5HqlGXP71ctFVnUWzGFvA==
X-Received: by 2002:a05:6871:7821:b0:22e:d0e3:925f with SMTP id oy33-20020a056871782100b0022ed0e3925fmr2523349oac.1.1714727948591;
        Fri, 03 May 2024 02:19:08 -0700 (PDT)
Received: from tigerii.tok.corp.google.com ([2401:fa00:8f:203:dc60:24a3:e365:f27c])
        by smtp.gmail.com with ESMTPSA id j6-20020aa78d06000000b006ecec1f4b08sm2621938pfe.118.2024.05.03.02.19.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 May 2024 02:19:08 -0700 (PDT)
From: Sergey Senozhatsky <senozhatsky@chromium.org>
To: Andrew Morton <akpm@linux-foundation.org>,
	Minchan Kim <minchan@kernel.org>
Cc: linux-kernel@vger.kernel.org,
	linux-block@vger.kernel.org,
	Sergey Senozhatsky <senozhatsky@chromium.org>
Subject: [PATCH 14/14] Documentation/zram: add documentation for algorithm parameters
Date: Fri,  3 May 2024 18:17:39 +0900
Message-ID: <20240503091823.3616962-15-senozhatsky@chromium.org>
X-Mailer: git-send-email 2.45.0.rc1.225.g2a3ae87e7f-goog
In-Reply-To: <20240503091823.3616962-1-senozhatsky@chromium.org>
References: <20240503091823.3616962-1-senozhatsky@chromium.org>
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


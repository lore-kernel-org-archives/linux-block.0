Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A6E636C9E4
	for <linux-block@vger.kernel.org>; Wed, 11 Mar 2026 08:43:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773218619; cv=none; b=XeTZTy02mOvkUmdGnmS5aUQvvnW6f1OHOvksHg5uJuCLE7ToL1hbW5mwcRV9NQWFLxD9JM0O5cKXj9mJbpMPzRNsmzi9aQKp6jJQXA6S9tCvJlourcvyMyoTYZunS6Fpq4tOryxqNNZAvrjs50fMAP63DfuR6ykMGyhES7yT3qk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773218619; c=relaxed/simple;
	bh=4GdkpkmoILpeNPDZWzVXn3rcOVAicbXDwsaZgv8SpBI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sPiLx4SRKYQSHQsLvvgF9DRyxKpdFhCjQu3WCpEA1Vhd8F5+Q9zy/IafZsH2QUo7/kjbcyQqsdDl5zvu6lZVJE0yyOa6npM2uTwFTKadFw8mi37GedL4Lp+KEq7jO73eX1ZsxVEYXhYgXmi5VdgbteerYrfjDSwd0rZhHlP0D/I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=ejtGMg2z; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="ejtGMg2z"
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-2adff872068so66311135ad.1
        for <linux-block@vger.kernel.org>; Wed, 11 Mar 2026 01:43:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1773218617; x=1773823417; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hu2NPW1VMt+KIrVk6gGv755cbgHa3Z7HVZzLA8AeCrE=;
        b=ejtGMg2zSH1W89JLraR9TFMYbnka9UqnjFscB9wTzX6O4yl+jGhFLA6/0/kQzDfOKs
         vFibhQH3rwO31LpSwKcqoulPBL19T4D7WJyTpEbOPn7LcCiH0hvuLPX0uM5P6xVern9C
         1lTcWprI3sXp8w8h+4gZyV9qFLGUoXA2UCw/s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773218617; x=1773823417;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=hu2NPW1VMt+KIrVk6gGv755cbgHa3Z7HVZzLA8AeCrE=;
        b=IQ3HCP2ScIOiutu1amBP9Vt+DlGQTm8f0w3PNzBnaneE04iGeMwZ8N2WzHA/mvxQ6x
         AZSDLD6pv6ehYBI8GCuhKlZJwOS+GVLMib7LGFnjUzwRKp7sroA/SiFb7D0cL3SUWlz0
         FCX42BVidX2HEEUATTdQXa1HYEpNVOVehUy9WBBZ/3v/PMIJIZcCHuCiMiAIQ1YGhZNF
         rJXn0xqTHGYEm8spznCdMq+NJ3QggwNFeZQPl88MZqE8YxJZOohHy44Vxx3+HYHP70Ap
         gyRHXP9SqEa46ka4ugVPN9l+GmHXgWvYoF7FCdW8H2efKHvnUmjt8sV9JbOK8eCJGKww
         LfOA==
X-Forwarded-Encrypted: i=1; AJvYcCVDds0P1RPxbmtEnlEkOTFIsOfm9XMyXmeNQrqbkywr3x+BkbvATtt/C/8Oa8tHUchgiGX4yU0sgvIIsQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YwWd6K1Jui65u+CgPzgDACXInbJIcBaH2qiIUbBz9biBcUO5A0d
	tcS9JfpXVbC74ARssor29XmNa2V0/NlOJqIrVhmQqNWZu6K637zA7qw4pvtGRSvosfZm0BjGRD/
	6zH8=
X-Gm-Gg: ATEYQzxmiuwcC6KUb8fDKsyKf6/752dsUXm5wHM/dVOeds56Yk/v+uu+R6jymLvl6d8
	JQrVNxB7aEI33rrPAyKb3fxaFL65Eu2L7jKoPS8rnlnMt37WEDA6BnGPTUAKeMjjNCCySnI0IzB
	zFEkL+dAEJJpl6VbHEFpQ03iX8OImf31vKLPQaCWne+LsO9ieRvK7QpKgG/aZOn5TxMD64D/jns
	I5ZgvL6CY2j8yodt44d9LLctcDqg2GfDH76I11uQdLi1J04WvF1jV1ngWxMHC9yICgvvDKb9JCB
	11gXmAHWM02hqQ8wFlMqrtMV4vF5bjf/P/eE24dN/iP7weM+M5KH17rsaszN2i5+Cf3iMjmW3NL
	TpBOlkAP+6AvxUkI1V9IQrsTYIA1UUpsLU86jn+g6KUeSvAQ+3ZIV1Fo67AwhMTd2IWia/oip+V
	db5hjhbgLCnJnSCyLmtc3cAVWMuH25hdDX9zteX8zZBTagU48rJFXmIRL0ayd67/t3E8h9B26lh
	iX5XSHwomH5Yw==
X-Received: by 2002:a17:902:e74f:b0:2ad:ab2c:d258 with SMTP id d9443c01a7336-2aeae7c8c56mr19757175ad.14.1773218616859;
        Wed, 11 Mar 2026 01:43:36 -0700 (PDT)
Received: from tigerii.tok.corp.google.com ([2a00:79e0:2031:6:93a4:8281:fe98:426a])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2aeae261077sm16062035ad.40.2026.03.11.01.43.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Mar 2026 01:43:36 -0700 (PDT)
From: Sergey Senozhatsky <senozhatsky@chromium.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Minchan Kim <minchan@kernel.org>,
	Brian Geffon <bgeffon@google.com>,
	linux-block@vger.kernel.org,
	linux-mm@kvack.org,
	Sergey Senozhatsky <senozhatsky@chromium.org>
Subject: [PATCH v2 4/6] zram: update recompression documentation
Date: Wed, 11 Mar 2026 17:42:47 +0900
Message-ID: <20260311084312.1766036-5-senozhatsky@chromium.org>
X-Mailer: git-send-email 2.53.0.473.g4a7958ca14-goog
In-Reply-To: <20260311084312.1766036-1-senozhatsky@chromium.org>
References: <20260311084312.1766036-1-senozhatsky@chromium.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Emphasize usage of the `priority` parameter for recompression
and explain why `algo` parameter can lead to unexpected behavior
and thus is not recommended.

Signed-off-by: Sergey Senozhatsky <senozhatsky@chromium.org>
---
 Documentation/admin-guide/blockdev/zram.rst | 40 ++++++++++-----------
 1 file changed, 18 insertions(+), 22 deletions(-)

diff --git a/Documentation/admin-guide/blockdev/zram.rst b/Documentation/admin-guide/blockdev/zram.rst
index 451fa00d3004..967b58c3aad2 100644
--- a/Documentation/admin-guide/blockdev/zram.rst
+++ b/Documentation/admin-guide/blockdev/zram.rst
@@ -462,7 +462,7 @@ know it via /sys/block/zram0/bd_stat's 3rd column.
 recompression
 -------------
 
-With CONFIG_ZRAM_MULTI_COMP, zram can recompress pages using alternative
+With `CONFIG_ZRAM_MULTI_COMP`, zram can recompress pages using alternative
 (secondary) compression algorithms. The basic idea is that alternative
 compression algorithm can provide better compression ratio at a price of
 (potentially) slower compression/decompression speeds. Alternative compression
@@ -471,7 +471,7 @@ that default algorithm failed to compress). Another application is idle pages
 recompression - pages that are cold and sit in the memory can be recompressed
 using more effective algorithm and, hence, reduce zsmalloc memory usage.
 
-With CONFIG_ZRAM_MULTI_COMP, zram supports up to 4 compression algorithms:
+With `CONFIG_ZRAM_MULTI_COMP`, zram supports up to 4 compression algorithms:
 one primary and up to 3 secondary ones. Primary zram compressor is explained
 in "3) Select compression algorithm", secondary algorithms are configured
 using recomp_algorithm device attribute.
@@ -495,34 +495,43 @@ configuration:::
 	#select deflate recompression algorithm, priority 2
 	echo "algo=deflate priority=2" > /sys/block/zramX/recomp_algorithm
 
-Another device attribute that CONFIG_ZRAM_MULTI_COMP enables is recompress,
+Another device attribute that `CONFIG_ZRAM_MULTI_COMP` enables is `recompress`,
 which controls recompression.
 
 Examples:::
 
 	#IDLE pages recompression is activated by `idle` mode
-	echo "type=idle" > /sys/block/zramX/recompress
+	echo "type=idle priority=1" > /sys/block/zramX/recompress
 
 	#HUGE pages recompression is activated by `huge` mode
-	echo "type=huge" > /sys/block/zram0/recompress
+	echo "type=huge priority=2" > /sys/block/zram0/recompress
 
 	#HUGE_IDLE pages recompression is activated by `huge_idle` mode
-	echo "type=huge_idle" > /sys/block/zramX/recompress
+	echo "type=huge_idle priority=1" > /sys/block/zramX/recompress
 
 The number of idle pages can be significant, so user-space can pass a size
 threshold (in bytes) to the recompress knob: zram will recompress only pages
 of equal or greater size:::
 
 	#recompress all pages larger than 3000 bytes
-	echo "threshold=3000" > /sys/block/zramX/recompress
+	echo "threshold=3000 priority=1" > /sys/block/zramX/recompress
 
 	#recompress idle pages larger than 2000 bytes
-	echo "type=idle threshold=2000" > /sys/block/zramX/recompress
+	echo "type=idle threshold=2000 priority=1" > \
+		/sys/block/zramX/recompress
 
 It is also possible to limit the number of pages zram re-compression will
 attempt to recompress:::
 
-	echo "type=huge_idle max_pages=42" > /sys/block/zramX/recompress
+	echo "type=huge_idle priority=1 max_pages=42" > \
+		/sys/block/zramX/recompress
+
+It is advised to always specify `priority` parameter.  While it is also
+possible to specify `algo` parameter, so that `zram` will use algorithm's
+name to determine the priority, it is not recommended, since it can lead to
+unexpected results when the same algorithm is configured with different
+priorities (e.g. different parameters).  `priority` is the only way to
+guarantee that the expected algorithm will be used.
 
 During re-compression for every page, that matches re-compression criteria,
 ZRAM iterates the list of registered alternative compression algorithms in
@@ -533,19 +542,6 @@ no secondary algorithms left to try. If none of the secondary algorithms can
 successfully re-compressed the page such a page is marked as incompressible,
 so ZRAM will not attempt to re-compress it in the future.
 
-This re-compression behaviour, when it iterates through the list of
-registered compression algorithms, increases our chances of finding the
-algorithm that successfully compresses a particular page. Sometimes, however,
-it is convenient (and sometimes even necessary) to limit recompression to
-only one particular algorithm so that it will not try any other algorithms.
-This can be achieved by providing a `algo` or `priority` parameter:::
-
-	#use zstd algorithm only (if registered)
-	echo "type=huge algo=zstd" > /sys/block/zramX/recompress
-
-	#use zstd algorithm only (if zstd was registered under priority 1)
-	echo "type=huge priority=1" > /sys/block/zramX/recompress
-
 memory tracking
 ===============
 
-- 
2.53.0.473.g4a7958ca14-goog


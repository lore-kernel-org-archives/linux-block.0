Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81BF336EA83
	for <linux-block@vger.kernel.org>; Fri, 27 Feb 2026 08:21:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772180514; cv=none; b=On7KPBAIjX/I45t3pN3+TLTRT7NTRg80HTDvEGaSVzniSe2UlBgYOkUfXBk0H6Zws2JZ0bUCAySeIK2xlShx2CuSvgrH22pPcDwgpN1kDI9nC4UJKZhadf6kTugOCrQhcS9ljJustrXnc3zo3pu1ZyGLfZ+EmH4/7FC3HIrudrc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772180514; c=relaxed/simple;
	bh=4GdkpkmoILpeNPDZWzVXn3rcOVAicbXDwsaZgv8SpBI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NoqG3v1gFBsgkMX7OLohLSCO0ddUQjFMQSPGhY0ylE1t+T8oK/MNz5m56xFSBkKT3Q4EiVZy43lf6+fkXF1ccvjy7HmTt5uT4wQTIjnDzFEqxjlRQdJE7Njztr1asxXpF4Rluwfw0MfjUe58g7X0ziPYXhHYwwXs8hkd7ggHkDc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=XeOySJ6Z; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="XeOySJ6Z"
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-2aaf43014d0so14313655ad.2
        for <linux-block@vger.kernel.org>; Fri, 27 Feb 2026 00:21:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1772180512; x=1772785312; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hu2NPW1VMt+KIrVk6gGv755cbgHa3Z7HVZzLA8AeCrE=;
        b=XeOySJ6ZsvI4Pp13a4t8MiqMXGiMDWyjJ2ds3rR+mxD8X1ghjKAlHf44q+jrXCPkmc
         bzn6OgJCKzFkQ75ACo1KftNxvy72bkIxRBDCbV25hpccv+FXdAlPw9epgj75+uxngrZB
         ynu9OzhpA81XqptO6pacHbT9mVU20f1IIjOJw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772180512; x=1772785312;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=hu2NPW1VMt+KIrVk6gGv755cbgHa3Z7HVZzLA8AeCrE=;
        b=kYDTYGRfqsZpZXwV6pQ3+M26iHfHzjOAZytFoJhb9XcdcK8y72GOLL9YOcuMdgDiEV
         cMkk0JMrBsnfmxlZEoDnUof2AKSZRSIWPz5B4gC5YHn0k1h6t0SKboHxImSBvCx533Nz
         /05MHxHR5/6VGU2DcRfTbDSxw702gA5VX2R3ZyLeO7v9kvW/G7jqtJpPst9qJWe1VWnW
         4UY2LilNAeQlihB1lylOrh1I4p5r8//rZ01Rz3yAL/fGbN7NdW8YNwVtljxzr6L4887i
         WF99VyuQuGrjfTc5B6fzSNWlZ347R5Shs0lgqqMJRP/0r6kWywdTedcBb8AkP3WljmLp
         uHYQ==
X-Forwarded-Encrypted: i=1; AJvYcCUb9Szi/aJQ6Q/CABFCkSx3rfkeS3do2zBnVEf31X8lSRWn9ETPIrIUA0dyY2Vy2Gvn4BHOAK6es1fA2g==@vger.kernel.org
X-Gm-Message-State: AOJu0Yzn6y7Pyk5dBKSCjfV78CK35/is4A5JuAxS8afsc7xpAyyseUNN
	sL+dlr0xTs8uBUUUqgg4b0hVkOnE3MIfdTsrG54RuKreqWk8tdZttIfooMoPCmZpmg==
X-Gm-Gg: ATEYQzydG5DXXHNwBVvw62PAvXluon2nf0qTq5B5D7wguMDOjbTs75qGfMV4HzIVJQn
	PjF/97U8mVDyK4X7fRS8Id6F4Lhkfw5fmDUwXxUNt3ibLaeMFE7355p4wnMNJ1nB8na+xWfJ4U8
	Cx5htN93QCdMHKVWbbQF3FYA55m7cTEc7WVuoYsD+/xGFBtvepchas+sZ17kt5yz8D2xhYgyy+B
	+PGBzcPVOsCSvvyGZaQYdqWeRRxl7m1FRn+EILOv7LnDey+dWlGB5c9KJXl4fBiVLUvbsWLNsyW
	D0lliGFCU535ybHbV0jO7yjPuGcrzRUhRt9e+TvdbTNEjgya7ZZLHVEo9UStR10onjlOUx+kesJ
	AYvC8+OT3sqeWUWbQLCzyTUZMyfrVeG2W5YGY+PVthE3bslT1cJiMfE0ZZLJDLg5ZRi6Z8NOebm
	O6Gx55GHS5y+h4jYk+htnBouDid7Yp9CnbdyVi+CnNVrO8yqhDUe0RxMHdAl48thYX5l0wTesLe
	ikdX/v44t5ljw==
X-Received: by 2002:a17:902:da8f:b0:2ad:a9a9:4bde with SMTP id d9443c01a7336-2ae2e4b55f6mr20599095ad.40.1772180511746;
        Fri, 27 Feb 2026 00:21:51 -0800 (PST)
Received: from tigerii.tok.corp.google.com ([2a00:79e0:2031:6:280f:e47e:6718:7698])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2adfb69fa4fsm48796025ad.45.2026.02.27.00.21.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Feb 2026 00:21:51 -0800 (PST)
From: Sergey Senozhatsky <senozhatsky@chromium.org>
To: Andrew Morton <akpm@linux-foundation.org>,
	Minchan Kim <minchan@kernel.org>
Cc: linux-kernel@vger.kernel.org,
	linux-block@vger.kernel.org,
	linux-mm@kvack.org,
	Brian Geffon <bgeffon@google.com>,
	Sergey Senozhatsky <senozhatsky@chromium.org>
Subject: [PATCH 4/5] zram: update recompression documentation
Date: Fri, 27 Feb 2026 17:21:10 +0900
Message-ID: <0d9bdbb19a4a1511e8c73d1e91227c47912a8009.1772180459.git.senozhatsky@chromium.org>
X-Mailer: git-send-email 2.53.0.473.g4a7958ca14-goog
In-Reply-To: <8a5d53d19a8dbd51d7d81d153676895163e0735e.1772180459.git.senozhatsky@chromium.org>
References: <8a5d53d19a8dbd51d7d81d153676895163e0735e.1772180459.git.senozhatsky@chromium.org>
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


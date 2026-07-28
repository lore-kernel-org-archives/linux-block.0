Received: from mail-pj2-f1.google.com (mail-pj2-f1.google.com [74.125.227.129])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C90840F74E
	for <linux-block@vger.kernel.org>; Tue, 28 Jul 2026 09:30:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.129
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785231020; cv=none; b=O+DsY2fruBa3//Z+Wq8GOiAd/wzAwsnsUlrwjk2lDxa9sF9fr0ujRJkC6Gv5Enq123rZSJm21OYwlK3W5b6UUksj/rMJVyuqWvFMtN1zoyMrA5EM12ytu8r9h405Bz3fETgufLEK92dZiGWBkY0UICOThMzLAtkMeuoLJv/Rx0I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785231020; c=relaxed/simple;
	bh=U/6msz6jpRBce7oIqvZKAd8mA9LkvtnjS4xe5LJkXaM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EzWMh2gLQQ5D5qVrynJ5/PzrkGovR9U36LgIgSE8LXNnIBDd6m/booe6lQCbVkyhUaEJR1l413yjeBetybCCQscROrH6NH2Nzs8YFaCcLkW09NjTYbYkeEgNwqIXrBOV2JGWGx9O9vvkTZiZquTFCgeXo3bOs8tdz75X7f3MPb0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XYHXE3zj; arc=none smtp.client-ip=74.125.227.129
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XYHXE3zj"
Received: by mail-pj2-f1.google.com with SMTP id d9443c01a7336-2cabf1f1051so11282315ad.0
        for <linux-block@vger.kernel.org>; Tue, 28 Jul 2026 02:30:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785231019; x=1785835819; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=JdUI5Gagd28mYaBC5Oq0wlI6BJHjCVxD5IqouGfzIgw=;
        b=XYHXE3zjy8Sjv8PE/8tVWdpUhjuZzsUZcRTBC5qN6mzVYwgoSRitI/x9TNofZOI0G5
         bpQE/5wVfDpDnSSNALywTLcnCZYFlnvey5oOPQI1fMaNS7EvipuJyqcjmE/1vy/nMNxc
         5WrvvkdRylDsnknGFJFaOcr3ZQOBnrIne3vfALjTmjFWPrGkK961378dixTnqc8E2KbA
         Ceok0uajvLBdyjzryRP7i34n9htv4I5OvFymBdOdjLkZYInEjYN+jTHZsysy97aOJfR7
         nLHLWV6tjyMxfTJ4PSn+4GoyNdHbR/KeEfj7pCYISahK1EDSZBwNANRJTUceZkllwiqv
         CvsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785231019; x=1785835819;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=JdUI5Gagd28mYaBC5Oq0wlI6BJHjCVxD5IqouGfzIgw=;
        b=bO96GN7a9iFEkn/Tmeg1guVTq00EKl88AQY5lytcQPNW3ZBESAd2vUWk+NJsfnS7Dk
         Y7gzbh3M2NiWxypNBYGRbCFpH/hAivJe5+NBaXKgiVRuUtIJg2Ofg83zf0eFqYNojXVQ
         5sCUiDkdtNObArL+S3YyQGaygMbaM3j/4YIGVjVDy0cYwWrarvCTdt4kFu6td4V+XOgH
         RGi81DQwTJV85dw2M7SY8QmHAF9LwlBJ+1QepnzQr3JzMhkZrZvK8tn1cAjNe4mscFBF
         S8gxlcSEvcicrIAQjxUw0b0YAvz5Z257MpIAX5gixs260YbhpH8qe5tJfwy1CWWKZeC+
         0mjg==
X-Forwarded-Encrypted: i=1; AHgh+RrMfIX8kvX9lBKEUZCwO3CrMYujMx9tRCNxj623fZzxNlmLfXbB/Ol2mscomznHOk0kI4higA3o/hOI4w==@vger.kernel.org
X-Gm-Message-State: AOJu0YwR3avgE8foXjkIFY5LbP474Jo9tBHYjoV8s8lkCjIAbLBnCOX3
	0nQVh6SKQV5lQYdaoKxAa6waEZymfhhwgvTD+ZW0HYzKni/HnCVrhlpL
X-Gm-Gg: AR+sD13hmYk1/oTBhz2FMjNyiWn446/wR+fmMOZw5XA/U39mL4anuo4DSimn4C1Gs55
	05K3QX+dXGU0qx2HPp29IiVZeiqVGSols26uAdzrTkG0BHHKYE0g2IKd2bGiekR0TFr3uJ6jb2p
	dZDkg1HaCAMssCZNzzAMdUIQMGFU0K2I6DAY1q98Ylghrme4FYnhSbmOTHq9lgxgtbJp/t7ZMUm
	6R/ZNcv0HuoNRgPpFM5uqMoHA8yc5jpg7hjbye9ptRxQovFsudfoUO0rYxFAmHrlIYfXy8U58pZ
	EljOi8op1IagO85UxTV48OCdDB2QYeQCTrOHQIkWqoMIczioy9PNQeNpBKWqPN8msoPgWbHZGdE
	DnZjdNsIPnOxFMutrPe0oPTQRwVQ/k9xe+t8CWIMUiyHVKc6qVYsX+wBySfIjlZPM2u0Ij5eYHw
	DLk8AVYNGjarOIfIJss342w237evdn4kL/Wq5Jrs2ZyxIPlZ8NhIXxOcw2wQ==
X-Received: by 2002:a17:902:d4c3:b0:2c8:2808:3ec9 with SMTP id d9443c01a7336-2d015abd8f9mr19817535ad.12.1785231018844;
        Tue, 28 Jul 2026 02:30:18 -0700 (PDT)
Received: from HAOQINHUANG-MC0.tencent.com ([43.132.141.21])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2cfde7f4b01sm49151225ad.71.2026.07.28.02.30.16
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 28 Jul 2026 02:30:18 -0700 (PDT)
From: Haoqin Huang <haoqinhuang7@gmail.com>
To: Minchan Kim <minchan@kernel.org>,
	Sergey Senozhatsky <senozhatsky@chromium.org>
Cc: Jens Axboe <axboe@kernel.dk>,
	Nick Terrell <terrelln@fb.com>,
	David Sterba <dsterba@suse.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-kernel@vger.kernel.org,
	linux-block@vger.kernel.org,
	Haoqin Huang <haoqinhuang@tencent.com>,
	Rongwei Wang <zigiwang@tencent.com>
Subject: [PATCH v2 3/5] zstd: move ZSTD_MAX_CLEVEL to zstd_lib.h
Date: Tue, 28 Jul 2026 17:29:33 +0800
Message-ID: <20260728092935.31139-3-haoqinhuang7@gmail.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20260728092935.31139-1-haoqinhuang7@gmail.com>
References: <20260627070216.13511-1-haoqinhuang7@gmail.com>
 <20260728092935.31139-1-haoqinhuang7@gmail.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Haoqin Huang <haoqinhuang@tencent.com>

Move ZSTD_MAX_CLEVEL from lib/zstd/compress/clevels.h to
include/linux/zstd_lib.h so that external users (e.g. the zram
zstd backend) can reference it alongside ZSTD_TARGETLENGTH_MAX
to define a valid level range.

Signed-off-by: Haoqin Huang <haoqinhuang@tencent.com>
Signed-off-by: Rongwei Wang <zigiwang@tencent.com>
---
 include/linux/zstd_lib.h    | 1 +
 lib/zstd/compress/clevels.h | 2 --
 2 files changed, 1 insertion(+), 2 deletions(-)

diff --git a/include/linux/zstd_lib.h b/include/linux/zstd_lib.h
index e295d4125dde..f4b26844e53a 100644
--- a/include/linux/zstd_lib.h
+++ b/include/linux/zstd_lib.h
@@ -1241,6 +1241,7 @@ ZSTDLIB_API size_t ZSTD_sizeof_DDict(const ZSTD_DDict* ddict);
 #define ZSTD_SEARCHLOG_MIN        1
 #define ZSTD_MINMATCH_MAX         7   /* only for ZSTD_fast, other strategies are limited to 6 */
 #define ZSTD_MINMATCH_MIN         3   /* only for ZSTD_btopt+, faster strategies are limited to 4 */
+#define ZSTD_MAX_CLEVEL		22
 #define ZSTD_TARGETLENGTH_MAX    ZSTD_BLOCKSIZE_MAX
 #define ZSTD_TARGETLENGTH_MIN     0   /* note : comparing this constant to an unsigned results in a tautological test */
 #define ZSTD_STRATEGY_MIN        ZSTD_fast
diff --git a/lib/zstd/compress/clevels.h b/lib/zstd/compress/clevels.h
index 6ab8be6532ef..06565e064456 100644
--- a/lib/zstd/compress/clevels.h
+++ b/lib/zstd/compress/clevels.h
@@ -17,8 +17,6 @@
 
 /*-=====  Pre-defined compression levels  =====-*/
 
-#define ZSTD_MAX_CLEVEL     22
-
 __attribute__((__unused__))
 
 static const ZSTD_compressionParameters ZSTD_defaultCParameters[4][ZSTD_MAX_CLEVEL+1] = {
-- 
2.43.7


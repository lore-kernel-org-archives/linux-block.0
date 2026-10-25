Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.42
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792894729;
	b=0HLp6xMgS8bh/ge9+Abmu5/9EIWyxTgsbk81c0jSQDzN++fHC3A9v08sNXdfyxo7oe1P
	 eq5broR6JOF+1TfFrbfmU1AROJws/KGuE+s7RwVk4ait33NU3Z0g0NyWzKz9rnjvTtjtZ
	 ZzltSORdyCM4Di8ya4HCTJhfWeDDIJYZLCZa9ulkIe+HPu18bxNjnnDCcVjsOY47o7VTa
	 VxQ/U5IbS41q5ED2lHntpdr+jfyopQEyMzrxhUgxnZ7PXl3++Q9B3jRVQSC8dJiDFuMjt
	 wYMUzG4a9XDoe2G5Njih8RhRhBHLYYJSJay5QeHrwJnQj9y7+eX/PdH5kqDBI/WEMfg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792894729;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=NBoVZyDPXGY96HrSU5SgYmE9fzVyxsjGoqNqHA/swwo=;
	b=p9Fc+VNEbmpr+KyWsEWmOZMhOBfhP6NS/FYWlV9YjdIdvppYJVzhRAvICyElbxcckrNz
	 j3NLQTLueNx3Ofr1e8nVKY/FHBQ3yz5y715OPDe10ZsNcN9/Rtn8Q8KIlc++5jP8qOQTm
	 awCGNiT9fVOYQvwe912jgR2BKDwHA21gihvXti/GZwbU5i73hLsI/uIH13UW1xAnqKati
	 NRw6jtxfseqgzGM6sfv1U8guESXNSgrCpOiK++b7dfTwDhRDwT7aVVv6NFz7c6q/DOcJx
	 cz2XYFj7CgLlcAQ5ixoKexFTjnkM3nmaXsNQDIk9j1TKOh9/VPVueNjnplc254q0MOQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=chromium.org;
	spf=pass smtp.mailfrom=chromium.org;
	dkim=pass header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=OZWr6MtV;
	arc=none smtp.remote-ip=74.125.82.42
Received: from mail-dl1-f42.google.com (mail-dl1-f42.google.com [74.125.82.42])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A30C9606A32E
	for <linux-block@vger.kernel.org>; Sun, 25 Oct 2026 02:18:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A30C9606A32E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=OZWr6MtV
Received: by mail-dl1-f42.google.com with SMTP id a92af1059eb24-1517bda04a0so2097423c88.0
        for <linux-block@vger.kernel.org>; Sat, 24 Oct 2026 19:18:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1792894728; x=1793499528; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=NBoVZyDPXGY96HrSU5SgYmE9fzVyxsjGoqNqHA/swwo=;
        b=OZWr6MtVxYIekC6jpt4qnYPVPmMpV48f5xrif0uULFSdKg99waiKjeBz/xpENBPIv5
         JecxjBxMhE7P2PilFyu93gWg2dQZmy47Qo1j/uhvXiK4zuR3mekgNeGHCF1rSu21bjVo
         vyBeJunqxL8o1zuMD2Mzw5D3tFb7kAOgnFwVQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792894728; x=1793499528;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=NBoVZyDPXGY96HrSU5SgYmE9fzVyxsjGoqNqHA/swwo=;
        b=gjVZd2YlSDfCFNi0EbRhM1us13f5b1qQC8KLteFHKB5XYwp/Dxr+r1j7wa6zBYD/Fw
         GjX9/F56vqLrfHUWWipNgg5P/Dcl+i4yvJbd51Wc5h27uUgswY1HRUmEeymKCfIIF3Y7
         AhyaUtZ5tzBSkoOSy0CYcF2zaZ3XoW9T1JkF+a5NNmBSUDk284e3YyrAqV9sFVJHnlxa
         GP42BLVKGv9VJqD4xUjyQQSMYLwBYiCdDaLj2RF4Ry4LOn95RbuUDTxA47UPLZCY8JMS
         7DbBNeuS/njJX8HNsyBswx9wl07zJuoiJFHGL2WdtEnjwKKDpAj4aQxYbJVcwyFzoEZo
         gRUg==
X-Forwarded-Encrypted: i=1; AKwUvBz85Koud0wspgnJFwyI2BD8FZEIYjUhtkwXIcJvJ8w/NVKNY6MPQvC/tFWmARrPef1SfJp9SKSAspvs3g==@vger.kernel.org
X-Gm-Message-State: AFq9FYILj7x0syryt0ECpuLdbj3inpQkrY7x7yBryPLCZZnHXjFlHIRX
	r+R9Hu0/bcmJ0WCsoBNABGT0frZvEztxDm5Pxx7xI86X/FrjLc+fKEJsRLTz3aH3ig==
X-Gm-Gg: AYBFou25RiAAMQfb2/XMN3hQ8Sa28D16sj+SvQqBB7ig+nQItIfOPGHT9Kvgnbro1yX
	iLbXZm5gJJhRgl8TvCEE/sTAtvB3xqo1TBLcR5LaNxUHOmBtIzdBDLry5mirjmmbp8m4l5NMW1E
	laEpmUv8rNLXSWeKXlJm9Nep/9lwzlAkiJMySx+s/IVh/DcP+CdIHIn+weFN7a63QlSqozWb5Si
	K/qp7JaeAF+FFjT9jqCYHclK94vXq/14rpOKeIfL3PUi5qjFnxL8sgPt7QgSFCpLl3YUWAkFMeT
	d0g1L9/NUoJiyRg9KzYnzQPxlrzQ56Ud7exA16M6vL2sz95jCiCi9ePDIAh/jd3PCN3Tp9pNCY0
	svEqK7tOtI14UEdwi1rbEOCFzpzyAzKKGFOQ6EO6sHgl/Aq7Ggy7T08C17ywQlnSZ9DehHzdV+T
	tsselD9T+CYXo1xC5/kuLrpEbdH1TAVsAuPvHCZUX5NMhFprnHe2dxCqdKQfTXs6N9RJoRC+5Z7
	ZzpAVRMdWMxyuuFSHVDNI8XLEg+L6Cs2Vocy0NOW7nIZO9xcf6qAnVZTf7VQNpw98BUW9GNRdIV
	39869dLG4TS79Y0l2yZOn4iFx4PaOl31Xh3OeA9e6zP7
X-Received: by 2002:a05:7022:ea9c:b0:18d:c38c:bcc9 with SMTP id a92af1059eb24-199290fe50amr4386210c88.3.1792894727665;
        Sat, 24 Oct 2026 19:18:47 -0700 (PDT)
Received: from tigeriii.tok.corp.google.com ([2a00:79e0:2031:6:9f87:66fc:8c85:11bb])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1989ff2ee5asm10387242c88.8.2026.10.24.19.18.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 24 Oct 2026 19:18:47 -0700 (PDT)
From: Sergey Senozhatsky <senozhatsky@chromium.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Brian Geffon <bgeffon@google.com>,
	Barry Song <baohua@kernel.org>,
	Bo Zhang <zhangbo0325@gmail.com>,
	Minchan Kim <minchan@kernel.org>,
	Richard Chang <richardycc@google.com>,
	linux-kernel@vger.kernel.org,
	linux-block@vger.kernel.org,
	linux-mm@kvack.org,
	Sergey Senozhatsky <senozhatsky@chromium.org>
Subject: [PATCH v7 01/15] zram: prefix backends printk-s
Date: Sun, 25 Oct 2026 11:18:17 +0900
Message-ID: <20261025021839.1542805-2-senozhatsky@chromium.org>
X-Mailer: git-send-email 2.56.0.257.gf7497c7d27-goog
In-Reply-To: <20261025021839.1542805-1-senozhatsky@chromium.org>
References: <20261025021839.1542805-1-senozhatsky@chromium.org>
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

Currently, zram backends prefix printk-s with their names, which may
look a little confusing, e.g. "zstd: alloc size 408128".  Prefix
backend names with "zram:" so it's clear that the message is coming
from a zram backend.

Signed-off-by: Sergey Senozhatsky <senozhatsky@chromium.org>
---
 drivers/block/zram/backend_842.c     | 2 +-
 drivers/block/zram/backend_deflate.c | 2 +-
 drivers/block/zram/backend_lz4.c     | 2 +-
 drivers/block/zram/backend_lz4hc.c   | 2 +-
 drivers/block/zram/backend_lzo.c     | 2 +-
 drivers/block/zram/backend_lzorle.c  | 2 +-
 drivers/block/zram/backend_zstd.c    | 2 +-
 7 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/block/zram/backend_842.c b/drivers/block/zram/backend_842.c
index 3846a04c69d7..56ffda201727 100644
--- a/drivers/block/zram/backend_842.c
+++ b/drivers/block/zram/backend_842.c
@@ -1,6 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0-or-later
 
-#define pr_fmt(fmt) "842: " fmt
+#define pr_fmt(fmt) "zram: 842: " fmt
 
 #include <linux/kernel.h>
 #include <linux/slab.h>
diff --git a/drivers/block/zram/backend_deflate.c b/drivers/block/zram/backend_deflate.c
index f71b11bcac78..20685aca9bdc 100644
--- a/drivers/block/zram/backend_deflate.c
+++ b/drivers/block/zram/backend_deflate.c
@@ -1,6 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0-or-later
 
-#define pr_fmt(fmt) "deflate: " fmt
+#define pr_fmt(fmt) "zram: deflate: " fmt
 
 #include <linux/kernel.h>
 #include <linux/slab.h>
diff --git a/drivers/block/zram/backend_lz4.c b/drivers/block/zram/backend_lz4.c
index 1e4ad31d39a6..158fd8b5e8a9 100644
--- a/drivers/block/zram/backend_lz4.c
+++ b/drivers/block/zram/backend_lz4.c
@@ -1,6 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0-or-later
 
-#define pr_fmt(fmt) "lz4: " fmt
+#define pr_fmt(fmt) "zram: lz4: " fmt
 
 #include <linux/kernel.h>
 #include <linux/lz4.h>
diff --git a/drivers/block/zram/backend_lz4hc.c b/drivers/block/zram/backend_lz4hc.c
index d8aa01bb258f..5c009835a684 100644
--- a/drivers/block/zram/backend_lz4hc.c
+++ b/drivers/block/zram/backend_lz4hc.c
@@ -1,6 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0-or-later
 
-#define pr_fmt(fmt) "lz4hc: " fmt
+#define pr_fmt(fmt) "zram: lz4hc: " fmt
 
 #include <linux/kernel.h>
 #include <linux/lz4.h>
diff --git a/drivers/block/zram/backend_lzo.c b/drivers/block/zram/backend_lzo.c
index d83f92cf757c..78538479c511 100644
--- a/drivers/block/zram/backend_lzo.c
+++ b/drivers/block/zram/backend_lzo.c
@@ -1,6 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0-or-later
 
-#define pr_fmt(fmt) "lzo: " fmt
+#define pr_fmt(fmt) "zram: lzo: " fmt
 
 #include <linux/kernel.h>
 #include <linux/slab.h>
diff --git a/drivers/block/zram/backend_lzorle.c b/drivers/block/zram/backend_lzorle.c
index 1b120d062c92..011787f1430b 100644
--- a/drivers/block/zram/backend_lzorle.c
+++ b/drivers/block/zram/backend_lzorle.c
@@ -1,6 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0-or-later
 
-#define pr_fmt(fmt) "lzo-rle: " fmt
+#define pr_fmt(fmt) "zram: lzo-rle: " fmt
 
 #include <linux/kernel.h>
 #include <linux/slab.h>
diff --git a/drivers/block/zram/backend_zstd.c b/drivers/block/zram/backend_zstd.c
index 08da3810cffd..127976b5455b 100644
--- a/drivers/block/zram/backend_zstd.c
+++ b/drivers/block/zram/backend_zstd.c
@@ -1,6 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0-or-later
 
-#define pr_fmt(fmt) "zstd: " fmt
+#define pr_fmt(fmt) "zram: zstd: " fmt
 
 #include <linux/kernel.h>
 #include <linux/slab.h>
-- 
2.56.0.257.gf7497c7d27-goog


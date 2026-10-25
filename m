Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.43
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792894738;
	b=JiGfseLI3Z5WmAZIm0aNKhtHQFRmOrgsxykZIIqiL+524XYw53bJwtpHVgUfBVGsJLFT
	 LWJ/EwKt5tBlLSKQbvTmmfvubJplnkuBHBp2vb+8XQ5J2hNngzx5534hPAsFU+2u3nF5n
	 K3UhvBn05ZkR5IhRnI7rzzmgEjlYXGyaYZInqghjew2viMlriSfk8EMp0ZqgsTW/t5r6e
	 BoZh8X2brt4e3cn9S6eKVEcfdxOIgOr2dmp6K/1nURNgPBj9E7NKtSjgcRNeQpQsLHXhl
	 prlSR78fsXHa/MusPHEVIsuCCqVUuzaDYWiHNcdhelJ/fejQJFfPzg5VGM6g4cO07wg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792894738;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=l+1W8fCH2YVVqsp80PGoTHVKE1lHVqXbpp8Ot3nWXz4=;
	b=Al83qPsjA7DNPjnId04RZgH4LzY0D3OdRY/4B9fokb+pgZHdBsy3bzTUvIR3xaMQt/SM
	 Kr472H3f5nQWZimk72NNw1BQKVHhBVXbhlMfSAnSE4lBeY+QviVAauzCJheDYWLbupC3T
	 uUXfH7BKkpKNPJ6MfeYNO0YGS1sim3om/OAng16SUT/kFPFMT9T3ZRg0Q1up18d37siFv
	 SYgU1yNDb6iDpf3yeE0FXSqsRDfIwR/LtuxPCcVciSZEu8sUXG35i7vsyzEiBRkdDH5Vx
	 +My8bKoAYfhQpNL8y8OEff0rrnuapYFj7NR1AYFXf8VbZvCz2qcQhevmaVbY2k6PJwA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=chromium.org;
	spf=pass smtp.mailfrom=chromium.org;
	dkim=pass header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=dKuzwXoM;
	arc=none smtp.remote-ip=74.125.82.43
Received: from mail-dl1-f43.google.com (mail-dl1-f43.google.com [74.125.82.43])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBE83606A31A
	for <linux-block@vger.kernel.org>; Sun, 25 Oct 2026 02:18:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BBE83606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=dKuzwXoM
Received: by mail-dl1-f43.google.com with SMTP id a92af1059eb24-188406bb948so1552212c88.1
        for <linux-block@vger.kernel.org>; Sat, 24 Oct 2026 19:18:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1792894737; x=1793499537; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=l+1W8fCH2YVVqsp80PGoTHVKE1lHVqXbpp8Ot3nWXz4=;
        b=dKuzwXoMRhNTEPPA+DYqc/ej4+W59qzyYx6sCUclzvqZgeB66RYor4i/D94aeKEqzH
         4IoO0wWaPdG/H4Mf4fyWOQlFaVVdtbPFYrB3V4vj9VPbZ37MZu4X3HaBELqaT08oMbkY
         drddQU9yy++6qH+dp5MZXklSkL+kdlD8YdeN0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792894737; x=1793499537;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=l+1W8fCH2YVVqsp80PGoTHVKE1lHVqXbpp8Ot3nWXz4=;
        b=1aGlQT2Do/4hza4coldoGUqtdUes4Qp6wRtHrDdSSKcOhtaA1iVpGV9VN96LZB04rC
         AqdOI7wiHOjywwWyxy9zm2qIYqMRqPZ5rkt/IFmyAX82/VzuQFok+340Hgz6B7U+YTE/
         pJ9m+0K3IerzV1tD67lq5YgvTzHW0iRyptVzhfbG57hKpabGLumeVsP3pBxdv9K4GgT4
         A4AKMiwD1Qp22C3nSpAKXClMXqxsAyei2AHG4nysnjwZqnvP4NKNCd2zYrmhk+GVNCmR
         nEpLGW59NPZcWK8qo5rFPKE+4GIGrY3Gr4yN8RVHGg8eGQXLisDxgxp8uHD0J9iwOv/W
         G65w==
X-Forwarded-Encrypted: i=1; AKwUvBxuj7a/sehfMUmRwGl25RzMB1iRgHVkmlkIx9J7THd0p3RSI+7h6BwnWN6j43UmeQ9QJ49xoYhxMMvGSg==@vger.kernel.org
X-Gm-Message-State: AFq9FYJrZuEt/l+AFFgojyKvDnbMvIEUSQAByZJ+OXqXghVKpLn89Hrj
	VbI2I7na726wLDdH7+822Qs2yA80G7lKF3aFd/st57vrcpFEGN1vTJBSiTk8v6hJVw==
X-Gm-Gg: AYBFou0JdnEP3MMXIIPvRJRKw3t+Ns0AqW9GiBCuuTC1c9EIv0/GIvtRU8OB15nH1Qo
	+aBeB58bQm3t/18hyFVX/7QNTDX31QPtco9uPAweqagEo5q5GP3HkNrOPt+YKFZLwYhFKEh2ZES
	iS4tzaosfeWahCujw306FZIVzh2a05fBjKLi0zhjM4l6OJkNTX8rFHrS+s7hpFmafWNLbJofI3D
	+IKs7DAx8h2Pe8S+hWBKL9ah+tB7FIoyLuRbv8fvWqt2KcC7NfBI7ZAXHuvcmDmivfOMN6MSvBp
	moO7afSlfLHEF/A7HevE7mXUCtEEiT7+XyK0mtg8R1Ie58a2QCRfB6O+CPUo+1QfiX+3K1b4c8B
	GRGt6GsP7MziWr9xS6a8HkUmADL4pvA3Y7YP3Lo2tzWrdurdLfxCuCM2k0tJewnt2mW7T4+neXn
	FC11ZpS8L806r2xV+/66B2S3w5WJoXBudiPx2o3Lfg5TbiLOABTKAvw0Rlj+5ekEhlkn42e3kU6
	jLX9ZPTsDr4WAusyK6dgXaK0wu9wLpZK62412p9o4H1PuMXerk+ZK6/cz8mE1N4TcZgF5p/Hbz1
	4pqTvw83H8SPF+mq7MtUAGJ6gbeXzYpE0Flmyd8IpfTvrQ==
X-Received: by 2002:a05:701b:204a:20b0:14d:c7ae:85df with SMTP id a92af1059eb24-1993505df63mr4347970c88.12.1792894736742;
        Sat, 24 Oct 2026 19:18:56 -0700 (PDT)
Received: from tigeriii.tok.corp.google.com ([2a00:79e0:2031:6:9f87:66fc:8c85:11bb])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1989ff2ee5asm10387242c88.8.2026.10.24.19.18.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 24 Oct 2026 19:18:56 -0700 (PDT)
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
Subject: [PATCH v7 05/15] zram: remove stale WARN_ON() from zram_read_page()
Date: Sun, 25 Oct 2026 11:18:21 +0900
Message-ID: <20261025021839.1542805-6-senozhatsky@chromium.org>
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

The zram_read_page() WARN_ON() is not accurate anymore, because, in
theory, async read from bdev can return -EIO or -ENOMEM.  We report
errors to upper layers via bi_status, so upper layers printk errors.

Signed-off-by: Sergey Senozhatsky <senozhatsky@chromium.org>
---
 drivers/block/zram/zram_drv.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/drivers/block/zram/zram_drv.c b/drivers/block/zram/zram_drv.c
index 2affac25db5d..beae16f22777 100644
--- a/drivers/block/zram/zram_drv.c
+++ b/drivers/block/zram/zram_drv.c
@@ -2204,10 +2204,6 @@ static int zram_read_page(struct zram *zram, struct page *page,
 		ret = read_from_bdev(zram, page, index, blk_idx, parent);
 	}
 
-	/* Should NEVER happen. Return bio error if it does. */
-	if (WARN_ON(ret < 0))
-		pr_err("Decompression failed! err=%d, page=%lu\n", ret, index);
-
 	return ret;
 }
 
-- 
2.56.0.257.gf7497c7d27-goog


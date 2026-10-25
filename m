Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.54
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792894731;
	b=gHos4AiCe8DEifphUvS2kjRODlXLKaNFwNFbZsdeDBEtF4/3kWue+lVZDa6vaHcUUnDG
	 twDdRjilDa2R7CAMLhFeX175W5ZCCo1Z2mwHGsxZoH0NImuzLr7MMrRRYVa3fcGuOBLBj
	 AvKm9y8919liuwlLU7HCqBypxMpeJFl78+ikxPcdIJmyUE1zvKl22SWXm1UM7Ps+k3vu2
	 fObqG1huSiI7JAoeRHjkDxxKOMYw7nxgvP8i16Btpdv5yA4sXISKhLEdLvQ/qzRmy0j+H
	 N5NL0JfDZUth6jJ9AM9ZIhDyCsA1oar8fTxgrbWWiGZrkLs/9E7R4SSPlJ8l/S36v0g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792894731;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=hbo8DF5QYQnx8DfVRTkAJCVVYmLZodegAu826PeFH2k=;
	b=lvoxz1warqGV03+3wnCHdvhL8iuAoCWbz9AZJzZXseyipG+/mQsiJNwN9ia+cb2STn4i
	 nezlLihHcHX+PKo5cAJv11vm3wgx4JR+btF7jsYfx+d0YBHfHOmMXK0bbDC6xOaENB6CC
	 b6FxOlB6v/plHx5kTJLWzvPgJFjDsJ3f6eWUoryfSdB46EKCzflF19AYxRQgNMzf/ocrd
	 Ep2YOZ+V4WhkiBddUDGUPtAiVGNG/c5V96OS5tGGVeXsjGvNpfpfdWrN1EK9rWBE0aJJ2
	 jgbTsg5cDFWVHwO5zRhsnvtVqLKIC5wMZ2WVvmYJZVU0Ter/jra62XVnz0ZJpaSwBnA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=chromium.org;
	spf=pass smtp.mailfrom=chromium.org;
	dkim=pass header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=cvG1s5gb;
	arc=none smtp.remote-ip=74.125.82.54
Received: from mail-dl1-f54.google.com (mail-dl1-f54.google.com [74.125.82.54])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0E4D606A31B
	for <linux-block@vger.kernel.org>; Sun, 25 Oct 2026 02:18:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org F0E4D606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=cvG1s5gb
Received: by mail-dl1-f54.google.com with SMTP id a92af1059eb24-18cdcfc05ffso2323887c88.1
        for <linux-block@vger.kernel.org>; Sat, 24 Oct 2026 19:18:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1792894730; x=1793499530; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=hbo8DF5QYQnx8DfVRTkAJCVVYmLZodegAu826PeFH2k=;
        b=cvG1s5gbfHiVD5G8moVge/qTjD1uhQvvde/bfVQ2hd+sO06P45fqfuPcqTSbedsFxs
         ML8dp4JOatssx4Yx6iNj27SlePfi1sPwSkyX97LReByV3XAQklQJeulbUqw3PVNGQxrQ
         n4lNru1pMxmv2b1uJMCbAWnhBufkQ5riaHOyk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792894730; x=1793499530;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=hbo8DF5QYQnx8DfVRTkAJCVVYmLZodegAu826PeFH2k=;
        b=pqMFQJaFT2ZzbaLrTLhwIf2Tkfr1XVFKDHbd6ED8Idwj/UOHzr2sNBTbj8YwfOxPuI
         wCO1BZ3PCpapGU+uLMO07DwvK+ZVjn3I1/Uisd0LCepSWtvUYZ+u7y6ne4VMfv5LQLlA
         4KkJnb+6AQz+VzNfCZHBkSuO4GYdrgH3yTf6SNOtqPtgsEYVpceLan5RrBY524XhhO4I
         yJYTz4mObmdOtfmGMyuZa3LI/uI8pMbFe/NMdted/rs04zz+UuBZsBRdMEXQVhTwKmcY
         c6loPFNkjZ5zX3eY+iSb3K76sYy2UbV1e8s4v17OuKO7IeTb2ar/i7QrsecuRtwvf9+D
         br4A==
X-Forwarded-Encrypted: i=1; AKwUvByBLQ3W/+D5N1chr6MLlYs9Nxlk6aF2xKDrgAdFP8M7OjoljwHVuWsRd2YEhuVR0ZVq9XCR4uRh7W2U0w==@vger.kernel.org
X-Gm-Message-State: AFq9FYJgNuzX8K+4JanY1dlbQbSEvWq7k70h4Ymu18IPQsPVvKIPcOX8
	wMPKqWBaIGtjWO6wo1W1EPbqu7yQZr3X4inwadTYAP0dpdTNkwQyRw7OV8Vb9BuC7w==
X-Gm-Gg: AYBFou2QTZ0yMX3E8JNE8YieWksYGMbWJ/flxTn8v2Fci3jPqeN5e2b4CSGTucm2/Wa
	JhxMuYPHin3RPSEU38x07p0bbCHzEfT/1bHsGfxhYU9hHl4yG3r6C1KYwjUAhQqeIDil7nKssxY
	EPAJjK4Jj+MtLbgqCP4Ek+/36pEIr/lSv4lUdTSOwqFSs/PLO1ljDbR0gCYFa1JAZ9iO+t4c7UZ
	HUiWoyOKRXKgLvMomGoUHPwYa//Nu59OgWrHH0LOP8JjAyGMCXsKN2+G+4SCJY8DaMyM4GYX8GE
	SOxHFlwarTteI62ERSrhgWFk9325OdPxLy7IXSXHbzeOsq4t6Pyb9xOsFOi1AAkqd48SGXM8dqD
	Edh+h6cKn5tM9K2n56VBmJiJmYzO9SPxiJ2d/9CG2FBBbI0Icjb8CIuBqCPN2vmQGa0gm0FZ3bA
	dOhw4BNqXHiNAveNAXs7dGynHQlw3W1mw+snUj+clsXD+M3RpRsopO6vkHNgnkA3r5F+w3aE6mg
	b+SE7fE8uZuRziGKeFs2W4rpJvTzSsxntamYGe9omZI1a2DXeu2SIlIXxEwvQrIp2YcFrxdHV3z
	pGomHqE87F472A6q4QHvaTqThbiHj0durbk2VabOuxdgPV7uxjONmlWC+kHhlRydd/xet7zPNcq
	S/sH11P3Lb6hyzPEcZQ==
X-Received: by 2002:a05:7022:3b8b:b0:169:9f67:a91b with SMTP id a92af1059eb24-1993505df87mr5872389c88.12.1792894729886;
        Sat, 24 Oct 2026 19:18:49 -0700 (PDT)
Received: from tigeriii.tok.corp.google.com ([2a00:79e0:2031:6:9f87:66fc:8c85:11bb])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1989ff2ee5asm10387242c88.8.2026.10.24.19.18.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 24 Oct 2026 19:18:49 -0700 (PDT)
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
Subject: [PATCH v7 02/15] zram: remove debugfs entry on init failure
Date: Sun, 25 Oct 2026 11:18:18 +0900
Message-ID: <20261025021839.1542805-3-senozhatsky@chromium.org>
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

Do not leak the debugfs entry when zram_init() fails to register
the block device.

Signed-off-by: Sergey Senozhatsky <senozhatsky@chromium.org>
---
 drivers/block/zram/zram_drv.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/block/zram/zram_drv.c b/drivers/block/zram/zram_drv.c
index ab064c84b092..593fa4ae47c4 100644
--- a/drivers/block/zram/zram_drv.c
+++ b/drivers/block/zram/zram_drv.c
@@ -3297,6 +3297,7 @@ static int __init zram_init(void)
 	if (zram_major <= 0) {
 		pr_err("Unable to get major number\n");
 		class_unregister(&zram_control_class);
+		zram_debugfs_destroy();
 		cpuhp_remove_multi_state(CPUHP_ZCOMP_PREPARE);
 		return -EBUSY;
 	}
-- 
2.56.0.257.gf7497c7d27-goog


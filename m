Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3706340D9D
	for <linux-block@vger.kernel.org>; Wed, 19 Nov 2025 09:48:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763545693; cv=none; b=VeqT8grh1Q1ZhMBer5fkCJPt6pA5U7ACIW/dzzj2wCiWVhL5m5rTWgt+FDI4yDOk28n4HYN1rckOpgvXsSy1BBvfZcm4EjtSTA60RPhOQsZLmjosyIqFHVoJg0U25QKmVn5A7XluYaJAggsL2ANQsGioA+APTxPIL8CXGBSN4jc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763545693; c=relaxed/simple;
	bh=vAd+3nFOGqPBN/hLmGZx9SCqyEXhmBj5gwaU72ZUovM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RgVsZjuCs604ij0gjOrEjfNjCSSkRcNPEKXOt8O8Wn/zAjUmylbK7W4EnemLOmgtRAARscAXCcc9RU/1z0zh59SlfpjLWKwfkhsHA9fcjbS/C7Qg+rKOPYUK2XKTntjazTk9UtxW2JsxrBmVzoGL5lp6PBqQ9DYJtCeiH0olK6k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=UTOgA6sM; arc=none smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="UTOgA6sM"
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-3434700be69so8767020a91.1
        for <linux-block@vger.kernel.org>; Wed, 19 Nov 2025 01:48:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1763545690; x=1764150490; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UR0dfDTMswpSQF4eXghISgANheYUVrX89n8U4+Wjn9M=;
        b=UTOgA6sMrvsnq7vJMO3s6Rj02kNAhb0P+EMyfY6Tu3fs++n/g443gcHvC0ujDPLgdy
         4B7VcJdbwqdmXe0jP/KmLkWbGINwbEblOB0jIE8BdIXj8oz/kbZWE87/958Xg09ZVtpa
         GNBSBrmiNYul1hLHlh8u413AosDPrN3hfK7nM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763545690; x=1764150490;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=UR0dfDTMswpSQF4eXghISgANheYUVrX89n8U4+Wjn9M=;
        b=HEWGWQ62j0O1LGdMb1bmSXsyW1UVVPQmyeYcfqWIZYJvjW0bm0HA5GCVsHqQA9ZHZU
         4O6MwoNxwy3WPGfikxQmZkE46cASGS2OER+/Gu9lAv6/osdEqP5EoqYQwu4k3NffcKw8
         xQBLD9hDRR0eL5jWq26LRnSMjEE538+hbbE/LGH9tWiLQ/LQbT8/BgpHU9Srxhe+vjay
         mW41Z2ShvfaK322d1G6q9SvlXg/bBvOl3RkEceIarA62NaMx+V/EW+yJaJgd0qahCTdv
         RNPfhNC5vZ5IsXIh4BXC8UrAmbm1LFrvuL8KGMr9bQe2hDkaJmMC/UNBOdnSEIh6VU2+
         pZgQ==
X-Forwarded-Encrypted: i=1; AJvYcCUnmbKP0V2YJyDcyUGbbpDONfT4QNCs/b+9DL5YC7eB+lW9YpCEwR2aP755Gpg6wSlwmHeY14OU4IoGvA==@vger.kernel.org
X-Gm-Message-State: AOJu0YzYjtAMwIGJzWbOJkNGY+jOcSSDXmUJxb0TII2wSHnpNwRJoAtS
	4K2UqIWss5mQR6dlsjz7K2wpQncaiZ4oZmPXoh2DornRJKyoSEs3kT9A/pX573TOCA==
X-Gm-Gg: ASbGncse7IwoFNcYxIHdVHswbonJYCe3b0A/cPlU3a2ExQmolBkw8sUc2I+dkr2vBAe
	v9bkmmGDExAsVep6IRt8W9nCHK+XwMgWs1Gk1XZydeGoxFiRfNoriJOtSt6oCH8FkQKktzJ655g
	4CMs285eJsfJYMjtJGBtOvfVG2wYbir3j0vTh2qBFLHx17bMDSX4VrGdqAqd61amXpPAQMK6oaK
	12tMVyjsBQlP98xtiVM1YECdh4H9qEL6J4esp2xbqalX26S4EGPHgLBaLQC7U3mCUlyKgi57CZw
	cwk4ZZHmKLn0FOWXcuoq+WkjCr51Ax30O8duKyMsIoYVHKHuuX75aXl2AGgJyK9r+wrOL3Afcx2
	S3kmMIdZNyVJTR10KEzC0pNrWr1iAXhgKHenmzmZNhxLDrmFORgU1/zT818DvZEq7UeUyTlUHPl
	1PoFEEdMr0aYByARmPmKS6RrA7Nfrj+qz7p0Y=
X-Google-Smtp-Source: AGHT+IHe+ohlC0g/VEJ6nhinde8VQVU5BW1Ybldi/0rC52KS8PPwT3oJOJ8dI3Qwu8BJFpXqTOPhQQ==
X-Received: by 2002:a17:90b:1c06:b0:341:ae23:85fd with SMTP id 98e67ed59e1d1-343f9ea58damr25110607a91.11.1763545690022;
        Wed, 19 Nov 2025 01:48:10 -0800 (PST)
Received: from tigerii.tok.corp.google.com ([2401:fa00:8f:203:5505:c63:fd70:efb])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-345bbfc8d8esm2209498a91.2.2025.11.19.01.48.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Nov 2025 01:48:09 -0800 (PST)
From: Sergey Senozhatsky <senozhatsky@chromium.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Minchan Kim <minchan@kernel.org>,
	Yuwen Chen <ywen.chen@foxmail.com>,
	Richard Chang <richardycc@google.com>,
	Brian Geffon <bgeffon@google.com>,
	Fengyu Lian <licayy@outlook.com>,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	linux-block@vger.kernel.org,
	Sergey Senozhatsky <senozhatsky@chromium.org>
Subject: [PATCH] zram: fixup "introduce writeback bio batching support"
Date: Wed, 19 Nov 2025 18:46:53 +0900
Message-ID: <20251119094715.2447022-1-senozhatsky@chromium.org>
X-Mailer: git-send-email 2.52.0.rc1.455.g30608eb744-goog
In-Reply-To: <20251118181235.4F5C4C2BCB5@smtp.kernel.org>
References: <20251118181235.4F5C4C2BCB5@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Dan Carpenter reported a missing NULL check.

Signed-off-by: Sergey Senozhatsky <senozhatsky@chromium.org>
---
 drivers/block/zram/zram_drv.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/block/zram/zram_drv.c b/drivers/block/zram/zram_drv.c
index ea06f4d7b623..61b30c671a56 100644
--- a/drivers/block/zram/zram_drv.c
+++ b/drivers/block/zram/zram_drv.c
@@ -760,6 +760,9 @@ static void release_wb_req(struct zram_wb_req *req)
 
 static void release_wb_ctl(struct zram_wb_ctl *wb_ctl)
 {
+	if (!wb_ctl)
+		return;
+
 	/* We should never have inflight requests at this point */
 	WARN_ON(!list_empty(&wb_ctl->inflight_reqs));
 
-- 
2.52.0.rc1.455.g30608eb744-goog


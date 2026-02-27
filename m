Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9971A37A48D
	for <linux-block@vger.kernel.org>; Fri, 27 Feb 2026 08:21:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772180511; cv=none; b=jamKZIQesZdJToQVN/6xA9JptBaWgYReUbWFj2nOK1afA6SK3VZCuBwXBNUkHGX/2kIJQ6wodciMIFsdNDKYAZLKid2DIO2AVpMf4RHR1HqYp0VjBX9o3q7jPiUEW5FXakoFbEqTBPZbnH9xlItIeu0vQWzKK3Y5+z8VQHKmCeY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772180511; c=relaxed/simple;
	bh=PJqkS04aD9CY/XEV2okgNctMe1u6Z05FGUQvcfQngKk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TMR7LQzSErElmwB473B9/Q2WPFJaDSotVIvESIjADZC306l92RaMSZCBk3qY1c5uWU/YCBV7Sl6AFqhipe1w3+J/V8WlEpXgVcJCKsRl07CvuVNK3EnO7olCMavyD1UMRTgUSNBhAlfXBEDodiDHiQtnDZTt+nwQEoYd8juJUkY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=eDmSgGKp; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="eDmSgGKp"
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-2ad21f437eeso13347785ad.0
        for <linux-block@vger.kernel.org>; Fri, 27 Feb 2026 00:21:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1772180510; x=1772785310; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kstHbIwiV9VI/ZIuMCRHTYCFnv0sGQ9axw2LL0ura2M=;
        b=eDmSgGKpHDJVcajf8fRVHpqA47HBaJux3FnVKIIDX7xN/wnhhJXmrkl+16B/zX3Ray
         NCHG6jp4g41xOxPE+uvPeLFTg+8IimDN68Duzub53vcwNSIcy+WOsAS8m9++mJ52cBkb
         LtW5KkUwybogUrTmWrpH3jP/nW/CIxKQxOUHg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772180510; x=1772785310;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=kstHbIwiV9VI/ZIuMCRHTYCFnv0sGQ9axw2LL0ura2M=;
        b=E8gK8FK388joVXQJz2sUwRlu82ep6CT5O6tL5UIAK1XPttBR0hVy58MJLtAgKRcznY
         nRa7EiyyFrgwJb9hac3Bh7MQIjEWUBj8jylbnwfSNIMhqIbOOR/qGvNBpA7cH1KYwFuI
         +D5A3tKFK4yEnNYUNm9xZcoQVjRp1dYwO0VJGZxRalrpfW8X/U5GkH5I0D+pCxCu3Nxn
         hEcsymMMYT3ymZVlat2T+GBuMxakby5lxSRxc2lmO86NJ2El4QG9Y7OeF80MR0rEmJZp
         eaWLqy1PakAcFHAcedoWX7i/xExDb3RMT0QqE0pcnCCFINMh/3AGHDv8AvEWGDfCy0xu
         HDXg==
X-Forwarded-Encrypted: i=1; AJvYcCWLU82ASLXp7A9Btr0vMqwSHa16WZUerfpmAN82BeNpf54SyzcRHXe5/5feZA4K44nSc4vG7VSFBywH1w==@vger.kernel.org
X-Gm-Message-State: AOJu0YzYFFHTJ3ZiNVumw7PGW0LlnhIsQyEshBKVpuIEM3xS4XYq7SU+
	Y5dXiTNaMewo0IdGU8fnDSchLr1rBq687IEzcqUQGw35Qa07mm4IuwMZDtBX61lPrg==
X-Gm-Gg: ATEYQzz++rFViWLphngzserimxWr8Y2WghdVtIDze32m2tSaQl4xszQGMCBFZB6daFe
	URvSIB86t/PBpTv0zPhQLQYcawHPpVSFIlQUe6stAA1yym2liPMK4IVd+2ox8YwK8cprL6W9BTq
	LVw5GXl511mMW0GQdRorshcPDiZqoDpQWNdCMmcK+zKqvtK16GSLyfJlFXb+figW3NAmjVhdDxs
	nxBKG+/eEfIkkTuZhNpzBNLUKcE+i8eSYyB7EvANErsbfVPliDGhB3IPSBYCngRlY+4k2IdohlQ
	54pUUJkU+MhzdtzJ+BQDWx35Onhk/1B25UjZeKi4h9Xc6UQoV/ZQ/nZ7zsCiqBhs68vPiSHAnbL
	oevCXogFzhbuphec2tSNEpS1tOUXtyTrl16T7zDCWkNr84WNxaVZNAsVp94Exgq0jqcrpCYyfzh
	hhZYf/5jntOHoWnWMIqhx0iWutoccohDKJwe3jDw0rx5f8hHLvXdpp765qa6naloViwYL0wfa/h
	dqJUzlMBKC+Iw==
X-Received: by 2002:a17:903:40c9:b0:2aa:d320:e965 with SMTP id d9443c01a7336-2ae2bad7ab0mr20498815ad.21.1772180510059;
        Fri, 27 Feb 2026 00:21:50 -0800 (PST)
Received: from tigerii.tok.corp.google.com ([2a00:79e0:2031:6:280f:e47e:6718:7698])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2adfb69fa4fsm48796025ad.45.2026.02.27.00.21.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Feb 2026 00:21:49 -0800 (PST)
From: Sergey Senozhatsky <senozhatsky@chromium.org>
To: Andrew Morton <akpm@linux-foundation.org>,
	Minchan Kim <minchan@kernel.org>
Cc: linux-kernel@vger.kernel.org,
	linux-block@vger.kernel.org,
	linux-mm@kvack.org,
	Brian Geffon <bgeffon@google.com>,
	Sergey Senozhatsky <senozhatsky@chromium.org>
Subject: [PATCH 3/5] zram: recompression priority param should override algo
Date: Fri, 27 Feb 2026 17:21:09 +0900
Message-ID: <831636c74ca6d72317de02d96585cc6833d082e6.1772180459.git.senozhatsky@chromium.org>
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

Recompression algorithm lookup by name is ambiguous and
can lead to unexpected results.  The problem is that
the system can configure the same algorithm but with
different parameters (compression level, C/D-dicts, etc.)
multiple times:

    [zstd clevel=3] [zstd clevel=8 dict=/etc/dict]

making it impossible to distinguish compressors by name.
It is advised to always use "priority".  Additionally,
override "algo" with "priority", when both params are
provided.

Suggested-by: Minchan Kim <minchan@kernel.org>
Signed-off-by: Sergey Senozhatsky <senozhatsky@chromium.org>
---
 drivers/block/zram/zram_drv.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/block/zram/zram_drv.c b/drivers/block/zram/zram_drv.c
index 6ca5a76c3865..118b0b277e37 100644
--- a/drivers/block/zram/zram_drv.c
+++ b/drivers/block/zram/zram_drv.c
@@ -2594,6 +2594,16 @@ static ssize_t recompress_store(struct device *dev,
 			if (ret)
 				return ret;
 
+			/*
+			 * "priority" overrides "algo".
+			 *
+			 * We can have several algorithms configured with
+			 * different params (compression/acceleration level,
+			 * C/D-dict, etc.) but under the same name.
+			 *
+			 * "algorithm" name lookup is ambiguous.
+			 */
+			algo = NULL;
 			prio_max = min(prio + 1, ZRAM_MAX_COMPS);
 			continue;
 		}
-- 
2.53.0.473.g4a7958ca14-goog


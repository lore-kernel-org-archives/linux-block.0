Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE40A470133
	for <linux-block@vger.kernel.org>; Tue, 13 Oct 2026 03:52:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791863539; cv=none; b=JD9NFgtXPiD/PsVXudLtwEWq4Uc0H+h1RYREwrfSiI4V7vQGcXCwKzRSj9U7gYE8KQmL/iOP2NTDuDm40krEjHjcdObN9eC/7UTEaXsJHNirqUQ3keSFwghOCPxjBdCk3Xtfze72TgWoif2HAIU/7K3feEf6NRRvorbSELin75A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791863539; c=relaxed/simple;
	bh=nMuXVhYe39gJuCALMb5O3ireZIWC6v81e/BXOQPu0jk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oNbEXOMtmTZfptYzTDUohRLpjpkphcrxNSeLJwGKkx0XZPDl9BS0n3BugcQztP3RdYtgxs2zW4Xw+w5tfM/RtR97LLb1nijGJ1SdmY1iZoEa1Uvbc8xm2w6+K9TgTdLqZD8XGyHFbOj1JxkyaezdTZGqEvj5EE7+QSzSAtSgYO4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=DwlJzmZG; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="DwlJzmZG"
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-8917c712f32so1039529b3a.2
        for <linux-block@vger.kernel.org>; Mon, 12 Oct 2026 20:52:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1791863538; x=1792468338; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=bA1flR9Lu8v82O37oxNarBOltKmvw8qroUoydC4mNOA=;
        b=DwlJzmZGMWY3HRhKCJdem60xcuNmtaaX9Pci+ZBMWrdjnYGoVdY6T756lux+0Iljro
         8sH97kAwJTlxG0LjpG0/iANCtXr3E3k+pFdGmNMSf+6vFDCKZSXnhiDV1gSMQ1MJtYt8
         rgOXwsNszrMIprw7pfMhegQ8oAAdTQRs8vtIY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791863538; x=1792468338;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=bA1flR9Lu8v82O37oxNarBOltKmvw8qroUoydC4mNOA=;
        b=bOAHrgn64tQoQd2pbwKPLbnTrFIfHlSiIKuiNOjATgtDIwiudQuLZxanrTavUfQBhA
         iJFwQzWefVtMNh5lB6NKe2Yg8pSHc/az6yBgsXlfUXbfWMhWgyg8TCQv3cdK4ZiIEvQF
         LA3Mdv0Gjr1/Ke5yHVpUDZwtZsq7jicT5WDITMwSMJ89XrXMH6xzuC7/RYYrOj4AY8aL
         QolybjqYrr7tqeol/B+xc2SZ+MHmNv+vSWlo2+xOwy/UrqsRSAWBTRtIbLuEmzmH1EHE
         9ZiSIvwWIxRiY/2XMg5UYR6qxzp8QWhtVPUU4uI5uB40cfuUTG4QzrihQrkaJBlYJzxj
         KNhg==
X-Forwarded-Encrypted: i=1; AKwUvBzkASg1gunwK88mTq7Dh9ZzJHnYPkZXGWPhQ6APgbGyrVcCskqBOzi++E9RK70Mt/FQTHsKF5JsNM1UQA==@vger.kernel.org
X-Gm-Message-State: AFq9FYK2Ox/UbGiTRkRzYS+MBs2yB122FNPyesbcgG4E+9Spj8vSG+6w
	yL7+o9Na0qIlznlMgFKRkOpL8jpbz7knMA/5BGm6RSpwCVXiGJyD8bsthtUU1jPYJtVtOQwvZb6
	CVHg=
X-Gm-Gg: AYBFou1TTA2PgoSXLrcsOQWDAepvQZsKTfYqXF9w1NvS1Zz5grgtqj1X500J3QHszJI
	Zby5W5zbdEbOaPcK9L7n4mOanC16NMfcI+uyDCSbLepN/YqLZjhO2WNc1KM73Ftr0xmYJSS2dCl
	VRfOBG6fSM5DCpp4k0KlDjWVZ6lbX28qqsgZ3U/kArXtmTXZr9rRwmwk9Vw6CCr8O9v9VJ1vnMd
	/8I4mrFVS+zPIqSkAkBb1L5aE9MUIzKpu+otKSHIemXr8w/L89stwinBlDTGrMCwgkOz2+14Cr+
	HjfB/jcag5+3/fT63Hk3Dc+tUanJOA/3z4EWqNDBTvbjlljHLKBGJemby0f7iy0wcpwk+zbPq89
	AwNqtJ/FhRGZ+wrJ5zPMafgZUNYk94XWMGubpdHx5nwdi/0ViEhy6Kd3/V8f4IfkwoifF/yqg9X
	M3kzxB3/cKkcXMujqk71mpOMMTXIdVkNMjq9F2HBgBJ8pOB9FUEz4VoSosHmU1YbjbxMu4wWmju
	ngen6xnDxMkgTF0A8wEv4PB7JdAxNhd2hgSy7lwdQJZkpMOvhak8gOnzLYkYg==
X-Received: by 2002:a05:6a00:99f:b0:886:61e5:cfbd with SMTP id d2e1a72fcca58-897c79d7cc1mr9570153b3a.45.1791863538092;
        Mon, 12 Oct 2026 20:52:18 -0700 (PDT)
Received: from tigeriii.tok.corp.google.com ([2a00:79e0:2031:6:476:d384:7c2e:1579])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-896c41bbb27sm4326818b3a.40.2026.10.12.20.52.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Oct 2026 20:52:17 -0700 (PDT)
From: Sergey Senozhatsky <senozhatsky@chromium.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Brian Geffon <bgeffon@google.com>,
	Minchan Kim <minchan@kernel.org>,
	Richard Chang <richardycc@google.com>,
	linux-kernel@vger.kernel.org,
	linux-block@vger.kernel.org,
	linux-mm@kvack.org,
	Sergey Senozhatsky <senozhatsky@chromium.org>
Subject: [PATCH v3 03/11] zram: zstd: do not allocate empty C/D-dictionaries
Date: Tue, 13 Oct 2026 12:50:50 +0900
Message-ID: <20261013035201.2809924-4-senozhatsky@chromium.org>
X-Mailer: git-send-email 2.56.0.385.gd3acb90ef8-goog
In-Reply-To: <20261013035201.2809924-1-senozhatsky@chromium.org>
References: <20261013035201.2809924-1-senozhatsky@chromium.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Do not zstd_create_cdict_byreference() / zstd_create_ddict_byreference()
C/D dictionaries when no dictionary was provided in the first place,
because zstd still allocates internal memory for such calls (~96 KB at
default level 3, and ~160 KB at levels 9+ on x86_64).

Signed-off-by: Sergey Senozhatsky <senozhatsky@chromium.org>
---
 drivers/block/zram/backend_zstd.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/block/zram/backend_zstd.c b/drivers/block/zram/backend_zstd.c
index 127976b5455b..b367049f131d 100644
--- a/drivers/block/zram/backend_zstd.c
+++ b/drivers/block/zram/backend_zstd.c
@@ -76,6 +76,9 @@ static int zstd_setup_params(struct zcomp_params *params)
 	prm = zstd_get_cparams(params->level, PAGE_SIZE,
 			       params->dict_sz);
 
+	if (!params->dict || !params->dict_sz)
+		return 0;
+
 	zp->cdict = zstd_create_cdict_byreference(params->dict,
 						  params->dict_sz,
 						  prm,
-- 
2.56.0.385.gd3acb90ef8-goog


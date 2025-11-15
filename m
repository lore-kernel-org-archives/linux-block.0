Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51F4513A244
	for <linux-block@vger.kernel.org>; Sat, 15 Nov 2025 02:35:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763174110; cv=none; b=puW/JnFVMBQdYq6EI0xkB5KmnvQkI1qyvaN4tHQvnXjPngqlSbCa0UAAYCZ14iS7PbuHH1X/OLOkXspXjFUgoC6HowaYdffWvjFzf0AVVJtxCYjOAuYZe82NJbLeP6Iz/cCDPgIrdVliCvfbF6h0U6EJvNu+A23wmMQwpvsMg28=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763174110; c=relaxed/simple;
	bh=3gu/Lt+2RDWE54kpBmJj0bCUrtvnlOmSE4DBon4d+6E=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=SX5PLmkUoWQk+pdaqGIuymkQ2eCceS+FV6NuQcfr7fKKKUvJmGkiny75oLlTHW3Os7kVzcpemicU2gj/g1jV1o1n00GgzMtURjr5pdF5S8CUhIry3j8YzVm5ixOE30IMIH/fcwlD89O9lwM7jF9qwjdVNJPF2f/BOOZ7qZ+5Wl4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=arkMzSxW; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="arkMzSxW"
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-297f35be2ffso38376145ad.2
        for <linux-block@vger.kernel.org>; Fri, 14 Nov 2025 18:35:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1763174105; x=1763778905; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=bvGwPC/29enE/uDNSsqwLmFNQ1QdSQel3u5hnxMC1QA=;
        b=arkMzSxWdkH4TdawRnCD/1K/VUheh2/EAELyBIB/EkvgB9OsfA0zihqLlSsM9p0oRj
         i45w+HNSl2IqXwcef0oTbPcSVzT9pZIv/vYqZhlmJ2VZwNuVBZCDesq0+SdE05vSs2Cf
         Dxlt3TgOX0+WJSn5DiqwBZCwaFJ7p0d8h1QzA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763174105; x=1763778905;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bvGwPC/29enE/uDNSsqwLmFNQ1QdSQel3u5hnxMC1QA=;
        b=JCrM4DAW1KgIn2eTTDzWNAwbQ4bucfdoQCzpCB4zlaa535D9vll4VoohEcE1tjcHeI
         9PYf9RlGaskzd81GRDvKFezU1KSes0tnwn+gB2sZFBQ8SgXodFn0Y/2wsGWCYndpHWjl
         ZIvXCbQ8Dj+P27p1pJKymVNJfifTq3oI2dURISH1Xah53JznlpQOIWGoBqiPV/IQZ+5u
         crBLKOrU9XXTr6hwe2nMyJCHHowqYaS1Ob2VIFjNvN98q7x9fZtyl3HjJASPgyKVgcIB
         7IlY7hkVVVR35XXQGBSyBX+lZzAdhyBmYXrKu4JCRXZYTptX0i9CqrtlTISO7rk0HCmp
         vQaQ==
X-Forwarded-Encrypted: i=1; AJvYcCUSBC0eALtnaRq5EXGmG+GZRD/4nmBYWR5chXfUew0q7Bfs+FxxUjqN7TOF1Qt4T7y5IqoNyC3rZgRoQg==@vger.kernel.org
X-Gm-Message-State: AOJu0YzEfaa+6Ypo0BResmBDcIS/acezbUR+cccg7RNeJIVBWMmnoHVV
	JC7LryW/ElgGDtXhWJBthYGDEPowB5TO6OO40cSuWeorIt+0gEe1V06T6pPo/FHX4w==
X-Gm-Gg: ASbGncs5+RKobrs67gQ3LIj8J3DU7hkqJNWbZP9g3Fa3eHIGsiGtnL+mFRbSXEMYtSG
	WXYO8ygJcZ4031DOQrftSoc5oTpRHbKkUDzqFdesOptlfBpXxxJE38WdrB9vLLEBb71oB4h2ZKh
	Z7nJDFb+D6bqh3V9eNbvDNCIK8actYMonfIeczg0iQ3VB41myEoiFZyKJEK7SFXBtt0IacY5yl6
	bR/0b5MiWPeankgwUb6QqQuz7ZgjeeFFw4slpXAQCVaItL234dmJ7Vn983Kno4q0y8YxZpe8Ht8
	eLeCcelOEALVvh9apsZLMuSLZ2YT9d4bC4NWNEedQSVc8YbhNVQu4feRRqpmH+hrGQiLh4ywiIL
	VXO441BWArxzvKrOluJR/KmBVzSdhr+RSqIc1O61phwy4U51lv7uKMJZ9oU5gZdxHj05vWQXXwt
	r/OhZc8c+bP/JEV8tZPRCZebsayQsDZjQVPj+4qw==
X-Google-Smtp-Source: AGHT+IEtm5GlISBRItBssRqjjMdpT5JTRyYu+xENZW+2fV+/0mSOGCmWTuVBcIzHooQpUVRS/VwIXw==
X-Received: by 2002:a17:903:1aed:b0:295:3eb5:6de1 with SMTP id d9443c01a7336-2986a7414d6mr53788275ad.34.1763174104609;
        Fri, 14 Nov 2025 18:35:04 -0800 (PST)
Received: from tigerii.tok.corp.google.com ([2401:fa00:8f:203:b069:973b:b865:16a1])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2985c2b1088sm68641555ad.57.2025.11.14.18.35.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Nov 2025 18:35:04 -0800 (PST)
From: Sergey Senozhatsky <senozhatsky@chromium.org>
To: Andrew Morton <akpm@linux-foundation.org>,
	Minchan Kim <minchan@kernel.org>,
	Yuwen Chen <ywen.chen@foxmail.com>,
	Richard Chang <richardycc@google.com>
Cc: Brian Geffon <bgeffon@google.com>,
	Fengyu Lian <licayy@outlook.com>,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	linux-block@vger.kernel.org,
	Sergey Senozhatsky <senozhatsky@chromium.org>
Subject: [PATCHv3 0/4] zram: introduce writeback bio batching
Date: Sat, 15 Nov 2025 11:34:43 +0900
Message-ID: <20251115023447.495417-1-senozhatsky@chromium.org>
X-Mailer: git-send-email 2.52.0.rc1.455.g30608eb744-goog
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This is a rework of Yuwen's patch [1] that adds writeback bio
batching support to zram, which can improve throughput of
writeback operation.

[1] https://lore.kernel.org/linux-block/tencent_0FBBFC8AE0B97BC63B5D47CE1FF2BABFDA09@qq.com/

v2->v3:
- addressed Minchan's feedback
  - changed GFP flags, dropped SYNC req, minor code tweaks.

Sergey Senozhatsky (3):
  zram: add writeback batch size device attr
  zram: take write lock in wb limit store handlers
  zram: drop wb_limit_lock

Yuwen Chen (1):
  zram: introduce writeback bio batching support

 drivers/block/zram/zram_drv.c | 410 +++++++++++++++++++++++++++-------
 drivers/block/zram/zram_drv.h |   2 +-
 2 files changed, 325 insertions(+), 87 deletions(-)

--
2.52.0.rc1.455.g30608eb744-goog


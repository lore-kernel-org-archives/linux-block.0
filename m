Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16DCC2EB5AF
	for <linux-block@vger.kernel.org>; Wed, 11 Mar 2026 08:43:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773218612; cv=none; b=CSSgLNs78mHHxY5Mvhpm9vi1sAxN14D8xi2varmUP0xWL/oPV0EiLoJZFSS2/B1VLpdxdNkQCQ0OYJ3VdUFdpu8ld2MdyPLgrAeFG5CRISAR4kk9dIBZThZ/m3l321HA/L8TMg9yfrgBUO6rl3c88CXUZPNlTIiFA5apfWqpfFU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773218612; c=relaxed/simple;
	bh=uhO80YwklIGIjzARD8SpbJOSpzKveHSago3z2tLqEtY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=RgGKA2VWsfNKjclbEHGn2QP7fkepUucbH46vXOlH7SLRrSaTeGhDIDeyJE3AeWrkZgS3Xjxbp08c3hBxETzZe5sNH5SgWfKeURpXzPtTFWXNFuWNSytpRmsi3F3JH2WLIdsWTyMM/0qFhdWPh3hs9ZwufwPaxqSpZ1HXe7in4H0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=ka1ulveN; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="ka1ulveN"
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-2a9296b3926so107454225ad.1
        for <linux-block@vger.kernel.org>; Wed, 11 Mar 2026 01:43:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1773218610; x=1773823410; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=LeDMkbax8m50ldc7k8TQfgLLao3Zaj4KnHyl4VPdUU4=;
        b=ka1ulveNtdsg9yUFHMYLRaQbfDT6zGAmhNpcPnsiyHv/GG9z8pVVidZA1/sDw3YOKY
         0uh4Brf60fiSBx+/SCHVMAfQ/jbj11v0l0OVBDdtt0XpNrU82M52khV7ve7E6y/5AidZ
         foUAPt5VZaQQLZc8xeE1uIZIL6J+axR4ySHEA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773218610; x=1773823410;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LeDMkbax8m50ldc7k8TQfgLLao3Zaj4KnHyl4VPdUU4=;
        b=HJ0S7JIpTkPX18+Z0zSyEGWJ4/9JysqhAEJeIgOw9Hf9f8d/91r6ZXvpsuMq2BOVrZ
         f7UUmLW/DBS9cfH87hhZlT1Y5b37RugoTkoyXH0qPKSCIXJJUjAwzJ2G6yE4KTXazxkM
         4HGR6kb8WefT/TyBNl7YQbtkRndy2GnzyEnbf8abcWZgmtvTCxwfKgugPYVWd8JHQiuD
         vpLsjT7RB1HvGMbn5Iv3MgNFGaFjqUPIc5NA9M7Vd+vRGUzrjP85eEzKRn9DqnG1aLY0
         vmMcyOu56q1KWVtO5QC1xAW2mWcKt4o/3K0WHM+ih08jCfzk8hHMq/hHoESLq+SewwMK
         opzg==
X-Forwarded-Encrypted: i=1; AJvYcCUEHFg5eUN4yAvaNA9vNnxiTU6Nb7hLMVc1y6/Vkqfncvi9M0TZYtTw3akYoYkENe3qrtgucG839mxKuA==@vger.kernel.org
X-Gm-Message-State: AOJu0Yxzvw7csOCl3MHWzor6T9pyt6DsXBp5TydlMC44Kkz61g4gJ2O8
	oAG0wbidm/HSBQ8XGnpJWbN0hMprfEzMXWCAJnyLCvVwyg8mImSGe+wG/KaBJkw52w==
X-Gm-Gg: ATEYQzwwkRuxMS2z78DVTbXSJgtpas02Ptw0IUztpF2G5tPqG4tTx8yNXNWpar8Jg4L
	Wy3HQDpScRsfTitRZk9h09vtEFMzLdn7vEOzS7/5yUGF1qw2SWnODE3hgPbUElW3JSEHQoYhqJD
	K0Odnsz6sig4nCsW4rXkZTxmqREnV3aH+jVI1Y8sa6qXjuyhprXxROa10eisNSOFzvsJvd0wnSN
	VSfvqL13mGJGbihP2/8aEj+vCugZ9BE3ivwYdqrAUyqakFol86gzi2JV0RPi0AO4KTtOJwGeRVc
	r66KUzmL03rTpLThC+c9LdrWjF/qC1WOHEpKnVTklmaJvn35vNGoHbQ2cmFf+7/CCFGVbKhSUi+
	dFO3uU8GAgtPuEG2QRQTPd2yJyBssVT3r7kmu4xveqaGN6XNxH2xWMko4pmAbIq7AHaxXSPqkH0
	lIZbDRexTbC7cYlm5wZTWLXeFEwwWLjoiF5w7ahORB6g2b7jPVwnS3N/VQ1Cji4eKt/pu9NORmc
	f1n38RR3Uaiyg==
X-Received: by 2002:a17:902:f651:b0:2ae:3a77:a1f4 with SMTP id d9443c01a7336-2aeae7d8956mr21121285ad.24.1773218610440;
        Wed, 11 Mar 2026 01:43:30 -0700 (PDT)
Received: from tigerii.tok.corp.google.com ([2a00:79e0:2031:6:93a4:8281:fe98:426a])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2aeae261077sm16062035ad.40.2026.03.11.01.43.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Mar 2026 01:43:29 -0700 (PDT)
From: Sergey Senozhatsky <senozhatsky@chromium.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Minchan Kim <minchan@kernel.org>,
	Brian Geffon <bgeffon@google.com>,
	linux-block@vger.kernel.org,
	linux-mm@kvack.org,
	Sergey Senozhatsky <senozhatsky@chromium.org>
Subject: [PATCH v2 0/6] zram: recompression cleanups and tweaks
Date: Wed, 11 Mar 2026 17:42:43 +0900
Message-ID: <20260311084312.1766036-1-senozhatsky@chromium.org>
X-Mailer: git-send-email 2.53.0.473.g4a7958ca14-goog
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series is a somewhat random mix of fixups,
recompression cleanups and improvements partly based
on internal conversations.  A few patches in the series
remove unexpected or confusing behaviour, e.g. auto
correction of bad priority= param for recompression,
which should have always been just an error.  Then it
also removes "chain recompression" which has a tricky,
unexpected and confusing behaviour at times.  We also
unify and harden the handling of algo/priority params.
There is also an addition of missing device lock in
algorithm_params_store() which previously permitted
modification of algo params while the device is active.

Sergey Senozhatsky (6):
  zram: do not permit params change after init
  zram: do not autocorrect bad recompression parameters
  zram: drop ->num_active_comps
  zram: update recompression documentation
  zram: remove chained recompression
  zram: unify and harden algo/priority params handling

 Documentation/admin-guide/blockdev/zram.rst |  49 ++---
 drivers/block/zram/zram_drv.c               | 214 ++++++++++----------
 drivers/block/zram/zram_drv.h               |   1 -
 3 files changed, 123 insertions(+), 141 deletions(-)

-- 
2.53.0.473.g4a7958ca14-goog


Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 849082EC0B2
	for <linux-block@vger.kernel.org>; Tue, 18 Nov 2025 07:30:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763451015; cv=none; b=RSCjj47u2qlDaPLwuWJyoUJ1xEO2cy9DU5o0bhqelqxN8Tm6GQV3i/3WkHPD2isElgrs17qSvC+j+mTt+2oLJvMDfXKFhG8mY7YoFJK9Gk6gTf+hNQBxA25oIE3cmGKMQoZ+Mv/fpWKWIuY3TA8SVBU4SroHbsuiEcd7Kyl2tg8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763451015; c=relaxed/simple;
	bh=xI+KnSUq3dJUITftvI7gVy3dzy9DTDVvFkokev4h/ig=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=NIj5B66DPqnY+dUiGnQ/DU6T1xCZhSiEPjT+aw484zo1PGryINzAAJemUk0e2RE3Fd11OJssoYSO3cQ0VlLE6ByrhDXPLtgKthLJMu4Dq5KBjIMQJG6g/0/F0MinQA484sAkE7/kK10/ITRvSdsM5ZhF1upaIlnAtexU4YJSnJc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=UfdGSSem; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="UfdGSSem"
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-29568d93e87so46319025ad.2
        for <linux-block@vger.kernel.org>; Mon, 17 Nov 2025 23:30:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1763451013; x=1764055813; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=aEgVdiPNMHoJflPqef6CyPpb7lp1/FKP7uAVKsdFjfo=;
        b=UfdGSSemwYDzX2jMaZhLnQUO6mluvpYmuV7Pf7ho1MDyzdrIOx8N7gZK5CBZkBKifx
         MJTztBgNeS4lU0+aw3DtCLsAnJOaRVEOLH4Oh11CHsee+Gl19ddX1eybK42pFA0fY6Bc
         RFDHmF2tAaXcAcQlrpgC9FnheQ4hPGFiOffX0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763451013; x=1764055813;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aEgVdiPNMHoJflPqef6CyPpb7lp1/FKP7uAVKsdFjfo=;
        b=FB1zGioFGCmxxnGhq3fcTZWp+grDjFtvqHXzBzGmiUXeU9OVaB6gMCuv694JYhRwq4
         bqWIxrrz6w34c3U2pGDgmiezwBzkG/V4iXlMkOsGWRDMWr6tWV4FtGMd8QVwEWI8UK4l
         RNIEaCghplnY4ZbHp9r1sPjUTciSmSqwa2PckUoOUXy46YL5ACAIeTlvjQZvsmqGTj7N
         SLd32sMk4N65jNmMaCB0qKEPR0WV1bOW3XdI9JhDgIaJEzo+hehM0+pMoOfHgRzF9RyU
         zhXQqv6pJW6qZDz1n1Se80kAkPLrFz/lMulEenrekSFE1eg2hZzpoFGfmEq8Ld07KUp7
         3kcA==
X-Forwarded-Encrypted: i=1; AJvYcCVwIl7TwUMa7tm8uutLowrcUsXj/GK6od01nX9v9S3yKUwkYSamf6eeTDrtRpbX5J9guvEqP+LHdrHXOg==@vger.kernel.org
X-Gm-Message-State: AOJu0Yy/grLCw6m3sUsEKdS1WqXyvTDPEy6vOgjkzmfCvayS3ukGTWSI
	SNyHatO9oowiRgi7DAULL8iG6uGP+iTPezRvlO0kbKTFA33+6ZJFHMUpm1GB3qNOLA==
X-Gm-Gg: ASbGncvwuNDg8YpPItz3a/xdJt8HYus5ONuXJHXoeRoITRNjRPeBPJyEg77wFvI9GZ3
	8rXJYwX2iRne5DD4sRcatQ2PWB/5IXzXSqWZAJNA7bO4/wlprLpfMjFdWGooubXEwrEg+dCRXlY
	5DQdwj7UVdNHa1wylD8gSsaUqMkSirBn89DlNp8N7X6t7XHBOjRSmf+ZIRCeBAyLQGIzXuKGvgZ
	N60TMmu5k5cr+xh/nyXfLvL0B8In/lbH9zY4FOqPfRSmjzw5p5tXU9XoSBsrXjsly2hMP7tOAfG
	Xy/dcRBU5LIwdGcqRVjre+2AoJA8dgFTzUyHfZILyc7h7Ylq90xLq+DhMUYqHAA1ZBYzAor6fUQ
	HPS81zgU9pBq/Ww1uDKMaatPaJDjKl+HClW1a6UMF3WNveVCNmJt6C+pgkCYAyv18ccMHVV0oko
	tzilL4SDo7icKUcTypJITpMTbbzHU=
X-Google-Smtp-Source: AGHT+IHvAN5FTpEAwX09VrPesluOzEdDPyr2GSk8K5mW0HnLaxO7WVj+e+6ZUNER2RJm3RrwKyj1IA==
X-Received: by 2002:a17:902:ecc3:b0:295:7454:34fd with SMTP id d9443c01a7336-2986a73b7d9mr191714615ad.39.1763451012710;
        Mon, 17 Nov 2025 23:30:12 -0800 (PST)
Received: from tigerii.tok.corp.google.com ([2401:fa00:8f:203:beba:22fc:d89b:ce14])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2985c2568ccsm163926215ad.50.2025.11.17.23.30.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Nov 2025 23:30:12 -0800 (PST)
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
Subject: [PATCHv4 0/6] zram: introduce writeback bio batching
Date: Tue, 18 Nov 2025 16:29:54 +0900
Message-ID: <20251118073000.1928107-1-senozhatsky@chromium.org>
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

v3 -> v4:
- fixed bdev block id leak (Yuwen)
- fixed missing pps index assignment (Yuwen)
- fixed preliminary wb IO completion slot release
- we now use bit 0 for writeback as well
- access bdev read slot block id under slot lock
- some other cleanups

Sergey Senozhatsky (5):
  zram: add writeback batch size device attr
  zram: take write lock in wb limit store handlers
  zram: drop wb_limit_lock
  zram: rework bdev block allocation
  zram: read slot block idx under slot lock

Yuwen Chen (1):
  zram: introduce writeback bio batching support

 drivers/block/zram/zram_drv.c | 452 ++++++++++++++++++++++++++--------
 drivers/block/zram/zram_drv.h |   2 +-
 2 files changed, 348 insertions(+), 106 deletions(-)

--
2.52.0.rc1.455.g30608eb744-goog


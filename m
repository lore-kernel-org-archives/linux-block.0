Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4438B206F23
	for <linux-block@vger.kernel.org>; Sun, 27 Jul 2025 17:40:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753638007; cv=none; b=bC5OilUBJeX8I5RyJbfNvgztzrcAgscm3P6iCjj2QrcatrpVM0EWzRqBKDIk+Q9X/AFLBjbCUlCZ+sNl/GHCiupPXxmJSaBTqQ7t/h3SY5fbuvCyceiKS3Tw8Ze95+Cq5e4vKKXSf7JkND/hITIt2Rsv84j5i7UIRXDefi1oKwo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753638007; c=relaxed/simple;
	bh=HeWFhWARDDSo7OBCk+ie/Wy96a9ghaPf6RUL7+HYQwo=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=BmiDDuqjmV9wDARB6dNIhOg/lEup6cH0/HJXtU6w0upac3c39AeKCLr336iKDlWsP7jBI3iGC3+9uWLlpsYJ7wOsx6Ec3xnYYRbXI+d3QXJjB5wzqp6rzlTK+qIT0HWxWj30BQnpqa9YCne8mBZxEk4LnNPljOkyf6LG/Yw3ipU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=shopee.com; spf=pass smtp.mailfrom=shopee.com; dkim=pass (2048-bit key) header.d=shopee.com header.i=@shopee.com header.b=PuEmoe0c; arc=none smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=shopee.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shopee.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=shopee.com header.i=@shopee.com header.b="PuEmoe0c"
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-313910f392dso2686610a91.2
        for <linux-block@vger.kernel.org>; Sun, 27 Jul 2025 10:40:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shopee.com; s=shopee.com; t=1753638005; x=1754242805; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=LS23ubGPWgljW/O2InkVofzyPwGDMqbidiBz0qrKrLk=;
        b=PuEmoe0cu4VcT7oNaJjs9Fp7IIKaRw+RYxP3M9k5UtuOG40EPBXzu9Cpw37fMfeEkB
         QWXNz+6GJBPYGjGHs/H/TVeXbOs9GO03qe5AoIMep+pOlJVIAW0Iqu8Qp6SV43IWNNdp
         7nBryPHP0JNxBvA8oh3Ar8JTremDV0Gh7FM1HT1Gsi+YvTYYleAfDl5pcU3gJ7qftNU4
         +G7wGBAP10EjiiXvRUFegbtEDPh/oLIEMIo49emy1zduVsHN5bOWXiq3xAl0l8qyyIa8
         6xtPgW50Piy/pvUTqtLU0UfatPTXUY9SK5A8whwrI3i6fgr21rQFH2UhjRyDJIre1SIf
         qVOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753638005; x=1754242805;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LS23ubGPWgljW/O2InkVofzyPwGDMqbidiBz0qrKrLk=;
        b=pIzdYoqFkJbX8GkOVBZcnLRxUmlKfj0dzWQ9IgXurfisw1JV9S5fRNRGqQ4db5n6yu
         c31E9R34K2FN7kz3tMRvS5g6Qg60X+Vu4sEfr4qK43Eq5z6o+0heBN2SiPXvaPGMXsBt
         uhzhraZhaMnbQYS6dO/bqOHGq7SSVGP2+uZSWlDXYfAN8KvoSm4MzZxVSQIy9kqmviFj
         eehoXHgWmhxvyd82s4s36zokpEdVsL2DeYt4MLvMnM8Yg2e4O4gYAo4c7DbMDRm8mYQZ
         YBoXweGxQRMtQnovyw2dtdiKALlDJep1VmV1w0GLUX8dDA11BgZYZfLyFwTEZEnkrqew
         hKrw==
X-Gm-Message-State: AOJu0YxxFwX4i1MTTxifgM2zkFcDIS4H8+P/1iSl40Y9prBa7m5tBQ4z
	qlpvga1Q+NJ5hBxh2V46i90Zzah0ZQJcV/0E4DepyubLK5tstsHLlrORmkSUtsxI7wQ=
X-Gm-Gg: ASbGncvAc6sgz+pcBBGFpq41VB8kJkrmFU8f08N5s70oFsEghPrS5YhcAE8OppzUDUC
	l0cNb94HkHfSyiNOvkM+XmCihO1SdHV+AS7mOBdQkATDLcucsgAnxYkAjiLbuXIGYhw7BXMjjxb
	T6UWwtsTbmeJnpNexHS3Kvlg1BRUODEFnDTqsSIEtTx5e2mIgGyGp5Hliez0IseC4Xhr2vHMPIC
	gzlp3YQWSI2t81sev6tuaXLcfvkkSxlLLlhOMI/W4R5dkgJPSm+0nIsyUh9/1Dx9fLO5UiW1+Vi
	L3nimnrv2SjnMBpE2LimY+K4vyUh0h3Ju9QmuZTnj+QMjzTJVro7x3ORh45Kf9C+nqWgzJiR6ZM
	tan1V/G4=
X-Google-Smtp-Source: AGHT+IGO1oq9IdEAlEt5/esto5f6vZRRYoJ7wmisC7FH0HIEyeSwOgI87SEWn1JY8r3di9EVph9OdQ==
X-Received: by 2002:a17:90b:2b86:b0:311:f99e:7f57 with SMTP id 98e67ed59e1d1-31e77a008a9mr11323342a91.23.1753638005462;
        Sun, 27 Jul 2025 10:40:05 -0700 (PDT)
Received: from localhost.localdomain ([143.92.64.18])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-31e8350b724sm3924224a91.23.2025.07.27.10.40.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 27 Jul 2025 10:40:04 -0700 (PDT)
From: Tang Yizhou <yizhou.tang@shopee.com>
X-Google-Original-From: Tang Yizhou
To: axboe@kernel.dk,
	hch@lst.de,
	jack@suse.cz
Cc: linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	tangyeechou@gmail.com,
	Tang Yizhou <yizhou.tang@shopee.com>
Subject: [PATCH v3 0/3] Optimize wbt and update its comments and doc
Date: Mon, 28 Jul 2025 01:39:56 +0800
Message-Id: <20250727173959.160835-1-yizhou.tang@shopee.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Tang Yizhou <yizhou.tang@shopee.com>

Some minor optimizations and updates of comments and doc for wbt.

v3:
Fix a typo: change 'cur_win_nsec' to 'curr_win_nsec'.

v2:
Patch #1: Pick up Jan and Kuai's Reviewed-by tag.
Patch #2: Pick up Jan's Reviewed-by tag.
Patch #3: Take Jan and Kuai's advice. Change the name to
'curr_win_nsec'.

Tang Yizhou (3):
  blk-wbt: Optimize wbt_done() for non-throttled writes
  blk-wbt: Eliminate ambiguity in the comments of struct rq_wb
  blk-wbt: doc: Update the doc of the wbt_lat_usec interface

 Documentation/ABI/stable/sysfs-block |  2 +-
 block/blk-wbt.c                      | 15 ++++++++-------
 2 files changed, 9 insertions(+), 8 deletions(-)

-- 
2.25.1


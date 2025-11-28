Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com [209.85.215.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 641372E54D3
	for <linux-block@vger.kernel.org>; Fri, 28 Nov 2025 08:32:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764318761; cv=none; b=P9J6V5HRv1ubnjMQ20DsG+GUSD5cXvoFOdi9ld+V+GYPzrKeoDLh8bPyIFEeP0BYn7kq3Q+AV9Jf1ZOb53YQrSKS1fuE4Ha+6LkpXH7FnD70zAG2Lr8buv+puu7VUSmBWVnBI2x+P8BUujhDgCkWEaZMkc8ZWjD5SEvY6l2F54E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764318761; c=relaxed/simple;
	bh=nXmk28ARgCcn+VciidQA11ELnwMOW79oTG8rwah+rkY=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Qx/7DrKzqm9rI+mLJmHD9CDbizCd1Keq4r8EahR3P4AysGyvhg3kjgV9/qlL64Actu7tit8HtY5ygtme04+2WTsiX3Vj4tO5tXU9HzIaa4mgcugKyQw3WXI1wjvPC4h08R2xEiKrzCP5Ow4pk6lnELvAeuBR2naCY9qA7h1IODc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WbSTKMTh; arc=none smtp.client-ip=209.85.215.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WbSTKMTh"
Received: by mail-pg1-f180.google.com with SMTP id 41be03b00d2f7-bc09b3d3afeso941991a12.0
        for <linux-block@vger.kernel.org>; Fri, 28 Nov 2025 00:32:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764318758; x=1764923558; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=NqrU9sAvwHlZJQNnImTr6s/wIfO8kcl//WUqMA/q7Cw=;
        b=WbSTKMThxlm/4xPvDvVSdATelz6yqeTOs+IvgJZWQDyb709cyNDzAvJaCuE/WHUfr8
         f1EXuQjx9KklKfe6IGC9GxwbPNiUhFRhtPViJU5n1/wswvK2qvWEKT15ugysJsOxNyOV
         0uqD9V9m04Yc9KgtA+FDS8Mvu/cCw1m4aFP6z6xpnXqkwCvAyLykLEave5F5K6paV0r5
         RH2U9jLSGQzsV3JqjgNJOo8b3jqGoP/3QTiNs6/CVY5odXzqsztNSE+auBZPLLZQWGtm
         b3SYZJ7/TkhkqFqTAMHpaoTfjrZBGaxDBSXuJVI40X+Q/WhUsDScuEMwNUyzoUgxeTWP
         AhLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764318758; x=1764923558;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NqrU9sAvwHlZJQNnImTr6s/wIfO8kcl//WUqMA/q7Cw=;
        b=cWGp0ETr0BNT3PVQJcf62CA3S/GUBZh9WOaSxUHHdOwH2+an3d7PZhhoCayhRLOtwk
         62QpDpqbklwxZKUvrCCg4ariCC4vhz0nTBFLyWnzIvGvNdG+5pZweAE3s37NHdrMZ6mq
         nXRDukRbtLpvCoKH9t1RdvpSUFQj2i+ukCPH02TXxoyQF5c13X+u+xErYQ9Lac38nPoX
         +FLFw0RaBywXGY6ARWrdZk3Bc5Eg3zO/kdS0hTb7+grSaD6Ha2ZV3Rf9BcXj28Id1WIb
         j9UbLSsAIgBjD/gJ4ZZuT+oxdJew+i0w3uB6P3Cm2X7OfkWhEP41f8rvzj/ULWnqzFdM
         8oHA==
X-Gm-Message-State: AOJu0YxbUwbw20uXcLrBSsH3G+T0TxCEPe/Zh/qHcua1qMsAdbukWHBl
	FM6njKRGbHEig3RRiozue24zvp1nbiog0/OT4BFtlYQaTsySHYTvXxGa
X-Gm-Gg: ASbGncunJUxp0xPbJPY+R6DoQURLmuVR39chM2NllS9vKCSgqlTr4dV3FCZ6miPPZDN
	GYCisglPLDjRKNkCJbzfYS0jn4DprIjI7ad/EOCWMdoA1q4DFrq1ICWUHqh44aEdcnGJOBpbAZO
	R+1m7ld39cVfD8JAM+99cViSAX4/6xCxN26RAjp6Uct1x5zog/2SVUhn09KPtAOlTLhuT9DLO7b
	dWxzOC6kHc4a0q25LCvQxHcH2g6TxmAeIJFJw2jZzCx4PM7E1wqLSROcPA/eqHozk6HY+9GpEpu
	RrOyhqkyRe1HEwFbQvQOCoyjgrfn49dV5I6MD3ZW1ixfGwrPrtlS8H6o8wETmZfL/OjAl0SEMOc
	/jRhkaKdxTL3U8mh+7DkTl5YcPGClqKiwy0ofi1XiYgfP+3pNtH2f9QPV9cbwNbUAxMcE3Mceq/
	kSdlXIA84yINYXgy4jxk+Cov/4gg==
X-Google-Smtp-Source: AGHT+IHdakmTE4ccsFNQ1yLU+VXJurH34ar1nC0le8zm5bpThSihG4vDxPqEawqzf6sYQkBphfQIBA==
X-Received: by 2002:a05:7022:ebc2:b0:11a:e610:ee32 with SMTP id a92af1059eb24-11c9d85f282mr16086363c88.25.1764318757636;
        Fri, 28 Nov 2025 00:32:37 -0800 (PST)
Received: from localhost.localdomain ([104.128.72.44])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-11dcaed5f6bsm20941371c88.1.2025.11.28.00.32.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Nov 2025 00:32:37 -0800 (PST)
From: zhangshida <starzhangzsd@gmail.com>
X-Google-Original-From: zhangshida <zhangshida@kylinos.cn>
To: Johannes.Thumshirn@wdc.com,
	hch@infradead.org,
	gruenba@redhat.com,
	ming.lei@redhat.com,
	siangkao@linux.alibaba.com
Cc: linux-block@vger.kernel.org,
	linux-bcache@vger.kernel.org,
	nvdimm@lists.linux.dev,
	virtualization@lists.linux.dev,
	linux-nvme@lists.infradead.org,
	gfs2@lists.linux.dev,
	ntfs3@lists.linux.dev,
	linux-xfs@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	zhangshida@kylinos.cn,
	starzhangzsd@gmail.com
Subject: [PATCH v2 00/12] Fix bio chain related issues
Date: Fri, 28 Nov 2025 16:32:07 +0800
Message-Id: <20251128083219.2332407-1-zhangshida@kylinos.cn>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Shida Zhang <zhangshida@kylinos.cn>

Hi all,

While investigating another problem [mentioned in v1], we identified
some buggy code in the bio chain handling logic. This series addresses
those issues and performs related code cleanup.

Patches 1-4 fix incorrect usage of bio_chain_endio().
Patches 5-12 clean up repetitive code patterns in bio chain handling.

v2:
- Added fix for bcache.
- Added BUG_ON() in bio_chain_endio().
- Enhanced commit messages for each patch

v1:
https://lore.kernel.org/all/20251121081748.1443507-1-zhangshida@kylinos.cn/


Shida Zhang (12):
  block: fix incorrect logic in bio_chain_endio
  block: prevent race condition on bi_status in __bio_chain_endio
  md: bcache: fix improper use of bi_end_io
  block: prohibit calls to bio_chain_endio
  block: export bio_chain_and_submit
  gfs2: Replace the repetitive bio chaining code patterns
  xfs: Replace the repetitive bio chaining code patterns
  block: Replace the repetitive bio chaining code patterns
  fs/ntfs3: Replace the repetitive bio chaining code patterns
  zram: Replace the repetitive bio chaining code patterns
  nvdimm: Replace the repetitive bio chaining code patterns
  nvmet: use bio_chain_and_submit to simplify bio chaining

 block/bio.c                       | 15 ++++++++++++---
 drivers/block/zram/zram_drv.c     |  3 +--
 drivers/md/bcache/request.c       |  6 +++---
 drivers/nvdimm/nd_virtio.c        |  3 +--
 drivers/nvme/target/io-cmd-bdev.c |  3 +--
 fs/gfs2/lops.c                    |  3 +--
 fs/ntfs3/fsntfs.c                 | 12 ++----------
 fs/squashfs/block.c               |  3 +--
 fs/xfs/xfs_bio_io.c               |  3 +--
 fs/xfs/xfs_buf.c                  |  3 +--
 fs/xfs/xfs_log.c                  |  3 +--
 11 files changed, 25 insertions(+), 32 deletions(-)

-- 
2.34.1


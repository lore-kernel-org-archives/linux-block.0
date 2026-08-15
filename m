Received: from mail-pj2-f3.google.com (mail-pj2-f3.google.com [74.125.227.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 536DE3403EC
	for <linux-block@vger.kernel.org>; Sat, 15 Aug 2026 09:07:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786784822; cv=none; b=PmPjmMC1qoSkb+854OkJRyd0VpkFIStQNWYafUKNoptKzPl6vAZc3GBSdp+lsplkX70X7kW4iLT5U1UpE52iXe4/t/XUzNLNV1eoISWqHnqWrZTYZyt/SzFG3In+RjG0fIa/O59VfWLd96XvuStCgX5kHau0gsstyyxKNE4+4DQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786784822; c=relaxed/simple;
	bh=wAiFwujyIjterOkwZFCo7R721Gkn7VU2TRwqe0C9g/o=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=D6MstbkpLnpJ+9p1zOSL4aFD4sWlr0visVUCK3wTQ9XTKjRlgXYLoZfrx3tyJ/Gnm0GQrbbj5zf9TNLEbGsxmko/mb4DDpANKJHIO2lfF04LugaOPAVXQ7uUxIEQljL1WraxrEYfgbTai2lY7o+C5MXMTro0PcSbNczGNAyekyw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cQIFL1CY; arc=none smtp.client-ip=74.125.227.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cQIFL1CY"
Received: by mail-pj2-f3.google.com with SMTP id d9443c01a7336-2ca4f02483cso2358995ad.1
        for <linux-block@vger.kernel.org>; Sat, 15 Aug 2026 02:07:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786784821; x=1787389621; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=J3MBy4u760QCW0mvzUP5qVWLRhrqqvCOKuIcB/tU0/o=;
        b=cQIFL1CYeOQyUSnOnYDnh7k6/75ra6U3Pr7pXcONCbKWHTM8tQ96sdsn2lqsk03tgH
         IJ0EO+fUJmy4+UPzyD9m/KyRVUduKfHIJ3hUN6Nyfb0ytZ7JrOL0Y4hOP2fcHgTcWKay
         eFLGA3YMnjj5eZ5AeSWE8cxQUcVCCDYsXMWfNW3b7sqh9cyr50sgXTQBLHtdgo6JD8Ub
         9TiuewEo/3DV8Fk5+9vXp+Zt31j8MdRoyFEGUwUsmC+iLh7jHgc2OiW+yRAsxlIQUteD
         eGpq//i5LbTRSKeOdOi+CSOEiA3bqTxLW+qkaakXnI/6eD5k9FQ55zTo3fxkox7t4Qqh
         s8bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786784821; x=1787389621;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=J3MBy4u760QCW0mvzUP5qVWLRhrqqvCOKuIcB/tU0/o=;
        b=AXg64PBKAT1unmsf5WXC+o16maUWuVRD8fofZXb6wVq6axpYU1rCzn6C8exUq3tnBN
         w2WhDrD1I6kAneMkg0nwfYoNefY9Y5GbIVjik2euGdM1dGVdsxDBJpYHcCmNoOoj+CMZ
         iOFa1HgPTn13idWxaVyAt5Npr9zlWbOarZZyRgS/ut9td0S2gnIV+NA4UrexguQspfHN
         GiEBSUIxgP5M6x+Ytl9up5fCOQmkBehA/J5be0fUmCyhv2FLAgWpCqz5TavZm/NMxLty
         UGw5Kc4e2DTjX734WCzp96WQOKt6aeP0lcYtE14ALGENtJpl6/KdpoZBUrA0NZlxO4uQ
         t+ZA==
X-Forwarded-Encrypted: i=1; AHgh+RpnwscrJ+ztofRVMq2Vojt6dmQK2hU5JlGHHpGddxw6rSf+f6aTyeAo00EuB/HlWg9Ik9f+UP9SdnElKw==@vger.kernel.org
X-Gm-Message-State: AOJu0Yy4MjlOMQW+tWBbiCZXIVR7evsrY6tfl/QYteikYMCmbDJeDLto
	5bGGlqoa1aV5/Jz4W9N9KkrAVJdTCuF+ayUkkz9RfVw9cZc6K2eFcw8f
X-Gm-Gg: AR+sD11TIlvoPJC4/3vTnZez0mSsbM4f8kZfzac/dphKMcmgn/fDgr6CU7TrhqAxqTy
	p3G7zOJkOVhYl3ZkfZFEAeGv0aXJWItcIHkOFNCLXWEo3duvlEO7zGSmThZwKTZcP+0W8Ze4ZCW
	MQNsRDUWO/TIGCS4Itcv5ZD6Fdvt8TmGrBTFx97tQBtLC6B+rj529E9dAxZMZSj0SonB8e7rkrq
	gIqpfhKuhA3GROL6qdKfjG9xYgknVWimTweiZjqdVQtL3is+uC0BRI4QmkYvZ2rs6S3JQFmT/Xp
	PNQwglhNJk3Qtk+C8auAx8nzgplnqLIG/BrD3Qfu8YRfKearmyD7B3OHSqJZqWy0CALXlBda2Bi
	3B5I5yLb9wUR+IMEGNS8f0zWmxCWIezEw6JkLevXbqOdmE2OFR+1q1k0JI3/8oE8ad152GeLyJu
	DgN7FAkwOt+ZmvGVYV6tC786/EKc/+dKl/6gmquteChuUE2gc2xr3W4hO0fFe3+blOeQ==
X-Received: by 2002:a17:90b:574d:b0:38e:5828:a446 with SMTP id 98e67ed59e1d1-3933b1091eemr9809868a91.19.1786784820512;
        Sat, 15 Aug 2026 02:07:00 -0700 (PDT)
Received: from localhost.localdomain ([61.8.202.166])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-394eaca2959sm5587140a91.9.2026.08.15.02.06.57
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sat, 15 Aug 2026 02:07:00 -0700 (PDT)
From: Zhenxian Ma <mzx199711@gmail.com>
To: Jens Axboe <axboe@kernel.dk>
Cc: Christoph Hellwig <hch@infradead.org>,
	linux-block@vger.kernel.org,
	Zhenxian Ma <mazhenxian@xiaohongshu.com>
Subject: [PATCH v2 0/2] block: avoid redundant flushes for O_DSYNC direct writes 
Date: Sat, 15 Aug 2026 17:06:51 +0800
Message-Id: <cover.1786782832.git.mzx199711@gmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20260812130335.60354-1-mzx199711@gmail.com>
References: <20260812130335.60354-1-mzx199711@gmail.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series removes redundant cache flushes on the O_DIRECT | O_DSYNC
write path to a block device, following Christoph's review of v1.

  Patch 1 skips generic_write_sync() when the direct write was already
  made durable by REQ_FUA.

  Patch 2 stops setting REQ_FUA on synchronous O_DSYNC direct writes to
  devices without FUA support, relying on generic_write_sync() instead
  and avoiding per-bio POSTFLUSH emulation.  Asynchronous writes keep
  REQ_FUA, since they cannot fall back to generic_write_sync().

Changes since v1
[https://lore.kernel.org/linux-block/20260812130335.60354-1-mzx199711@gmail.com/]:

  - Split into two patches per Christoph's suggestion.
  - Patch 1 tracks need_sync (default false) instead of dio_fua_done.
  - Added Patch 2 for the no-FUA case; asynchronous submitters stay at
    parity with mainline.

Tested on Linux 7.2.0-rc7 with a Seagate ST20000NM007D (fua=1), 4 KiB
O_DSYNC direct writes, mainline vs this series:

  Sequential: 119.7 -> 7497.0 IOPS
  Random:     156.1 ->  666.4 IOPS

On a loop device without FUA there was no regression, and async
O_DSYNC direct writes were verified durable with fio verify=crc32c
(262144 IOs, no errors).

Zhenxian Ma (2):
  block: skip redundant flush for O_DSYNC direct writes
  block: only use REQ_FUA for direct writes if the device supports it

 block/fops.c | 40 +++++++++++++++++++++++++++++++++-------
 1 file changed, 33 insertions(+), 7 deletions(-)

-- 
2.43.5


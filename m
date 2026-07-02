Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59FE728C84A
	for <linux-block@vger.kernel.org>; Thu,  2 Jul 2026 13:27:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782998871; cv=none; b=WgF7TA2G34DARTELjxGM/1Mn6EfF/TtJopQsUseEH07XPx9baBoihnRzHU0JKDI6vXKD3s4ud2nuwERaVUKcUkLu+Wz3A9RzAwV8B7F0cBiEsR62CqMXQwmwoOcuxwEhIBsQcoAwRKif4VCDuiSwTJojJBxrnYqsegWyQHJc2Wc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782998871; c=relaxed/simple;
	bh=Sy4woLduZ93mBRKiCVRpKo96qDpJgdXF4R6s3yNDdOc=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=g4Ei/ridi4TmmFWFzZAvEi4I8jk1DEAD8pFzgFXCzkjorHZTemQ8Mw6PAxLaFUcN1+Ave4sZ6bxPVeR+OlTZQPPUSNgNgxAHgu6aLz2rO1vkY3ApzfmsuIwlQE3xaf5wSWJ1XUS0+lv3kq4Fi+2EU7svRF2f1UAKWGvbev3UKCY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FdA0amKp; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FdA0amKp"
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-2caa57a41cdso6862815ad.1
        for <linux-block@vger.kernel.org>; Thu, 02 Jul 2026 06:27:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782998869; x=1783603669; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=2brz68KIUrvnUXDRZhZcSKkriGFiqUe/zDtHBqOYYf8=;
        b=FdA0amKpZPAS8fhr4nO1TDMEZ1SU4wbSKfoE7/n3yS7lcVQJNdn7Ch7gMe2QFL5hQB
         BJPUDSHSBZ5KbqoEr3VdZ6fzuFH7Bf+lSvbOu2ZgwUpjtmlybvjiQjdMbxINfC4MO/iF
         ExBxB4PZSZhAdg1PbzE5QEPyEQCkCkZgNfa6aKlOQWcm0O7a7dnnrNh0uLQqOJFCyWhX
         1BNyt0wdQ/GU5yxrZ31pDurcBn/eQoacnKywmTAKqy+oNpXBSqbTUjTFHv88VbUHdFDT
         Oc1EACOUrkrIsb1pPkXlLoDm4RrNy9hXYaiMGD3N4GyasZ6SSruB/Krgbfq7I/od2ONo
         9e9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782998869; x=1783603669;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2brz68KIUrvnUXDRZhZcSKkriGFiqUe/zDtHBqOYYf8=;
        b=S3ja3Y90N+FCO8nqONhikAV7agfcaXdyvY1EQPROg6m6rlGhsrgypbFU598ECMa1A/
         fINO0vX+Yzw6/5OzCndwTbqEa2iK5liWIXf3orpKKEmsrfHHs+ACUNTpN/yE8jTUBOK1
         IJHrZ3pRH6nOr4e8+Q1NjN4+tcn9ErYHbQ/EcSvXzrhTCAb5xAhxYA2ssmc284pDkKFk
         W6uKhSw43RpDtOquCEGjKhnxMJ0qOgvlGDivfBxLurwxlsCDAzb8klT8zlQ6AOA1OmcT
         4tMU3w8SGV6k4whKAfUJF4DEXNDw0e/V4E1xiWKAdl0ZaUW5N3hyNj7ytt9+rRYFs9aQ
         sxJg==
X-Forwarded-Encrypted: i=1; AHgh+Rrg/aJcHRaEl45lu0otNWNvIRbL8kA02/NjyWvAv0qa0rd0AI5ESgypOBUDgtSei0IxBtxZuRjn+hOtlA==@vger.kernel.org
X-Gm-Message-State: AOJu0YxkXd3DpTg7P1Hz3sDi9tyhwUBAkQeKJjTI6sykXtBmftxNL8l/
	APD6bZm3afYi6x6JXuvWWlXToSZ6G417tzF8TY6I1SOWQu8Y12/DgAS5
X-Gm-Gg: AfdE7ckvSOitiQ4yMj7q8F5CjHXP5o0LPecal5dRYfMOAQFLMBH/MT3pNAlzS5SbxTD
	Ae/xD5w/HEG/5LoqbzPJvGJOUAN5NK++UovdUnrWj1qG2rlqpZYVHuvln/d+aHsKK8CVzvdFpL3
	LKme9uf3OaqJyT+ADPC8lEe+vRE2IoAuGujOwPV/FiC2WwSRcBv44nh9crDzoHfjlT5swVVtyI0
	+Az645zVP4UAxo6khbIHVcxZyAdvQQ1tI/Lf82grLe/jLBiprpSYA8mSdtXqZye/fn6yxo7M9RP
	76u7L+GbgZBqLLtZoYq+SEKmP3zznVuo3Xj8mMl94fdIpmM/b9UBfGs5sN4Mw2c2yCZtcPAo9hV
	v5egkhuXGBFQhl5fX44HAts+j8mqgbomRgUWgsVJ/zfxWfZdRdBnBhEIlRM7XkyrfYRX2o1hykF
	3U
X-Received: by 2002:a17:902:e811:b0:2c1:d49c:8396 with SMTP id d9443c01a7336-2ca7e6736e0mr64079565ad.1.1782998869411;
        Thu, 02 Jul 2026 06:27:49 -0700 (PDT)
Received: from n37-098-250.byted.org ([240e:83:200::330])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ca9a8dae49sm13617755ad.10.2026.07.02.06.27.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Jul 2026 06:27:49 -0700 (PDT)
From: Diangang Li <diangangli@gmail.com>
To: axboe@kernel.dk
Cc: linux-kernel@vger.kernel.org,
	linux-block@vger.kernel.org,
	Diangang Li <lidiangang@bytedance.com>
Subject: [RFC 0/1] block: export I/O latency histograms
Date: Thu,  2 Jul 2026 21:27:11 +0800
Message-Id: <20260702132712.2255703-1-diangangli@gmail.com>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Diangang Li <lidiangang@bytedance.com>

Hi,

The existing block I/O statistics count completed I/Os and accumulate the
time spent in each operation group. That works for average latency, but
not for the tail. Once the time is folded into a single total, userspace
cannot tell whether a device saw a steady stream of moderate I/Os or a
small number of very slow ones.

This RFC adds cumulative latency histograms for block devices and
partitions. The new accounting is in the same completion paths as the
existing I/O statistics and uses the same operation groups: read, write,
discard, and flush.

Two proc files are added:

  /proc/disk_lat_buckets
        bucket upper bounds, in microseconds

  /proc/disk_lat_hists
        cumulative histogram counters

/proc/disk_lat_hists follows the shape of /proc/diskstats. Each
reported device or partition has four consecutive lines, in read,
write, discard, flush order. Each line starts with the major number,
minor number, and device name, followed by the bucket counters.
Userspace can sample the file twice and compute interval histograms and
percentiles from the deltas.

eBPF is useful for targeted debugging, but it is not a good match for
this interface. These counters are block accounting data, tied to the
same accounting points as diskstats and readable without a resident
userspace collector.

The histogram storage is per block_device and optional. If allocation
fails, bd_lat_hist remains NULL and regular I/O statistics keep working.
The record side uses per-cpu counters.

The current bucket table has 24 upper bounds, from 10 us to 8 seconds,
which gives 25 counters. That covers both fast NVMe devices and slow
disks without making the per-device state too large.

Fio tests on NVMe and HDD devices did not show a consistent performance
regression, and confirmed that histogram deltas match the corresponding
diskstats completion counters.

Diangang Li (1):
  block: export I/O latency histograms

 Documentation/ABI/testing/procfs-diskstats |  25 ++++
 block/Makefile                             |   2 +-
 block/bdev.c                               |   2 +
 block/blk-core.c                           |   4 +-
 block/blk-flush.c                          |   5 +-
 block/blk-mq.c                             |   4 +-
 block/blk.h                                |   7 +
 block/disk-lat-hist.c                      | 158 +++++++++++++++++++++
 block/genhd.c                              |  10 ++
 include/linux/blk_types.h                  |   1 +
 10 files changed, 213 insertions(+), 5 deletions(-)
 create mode 100644 block/disk-lat-hist.c

-- 
2.39.5


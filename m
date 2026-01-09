Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7854331D72B
	for <linux-block@vger.kernel.org>; Fri,  9 Jan 2026 08:31:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767947502; cv=none; b=BbTrHE0mzfcTAsWXsAnTfPmhNxJTSVQ+pG/of/b1n2qFlAZDTEJGGuRt9bJWTbBghO5IO0KFYLTPKJkzVWlPHOWr804TN4yMK+Z4PFlclpPNjyKoMavWw4IDd9/GFQ2e6IWcm+Cnwks5RU2h80j8r5xwrjHJxztG1VpVwZSQFiY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767947502; c=relaxed/simple;
	bh=GTtO/f6Gg1BUQZcIDWwRLdPXbDYINj8mhDCa9OsjIT4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=mxUqsllvMNX/Y6rmcUUgb2dapyb+ED/+ALZ6Ny19g7ZpW+Xd8KnaBwBemAROI9nWLE1GRHmUb8/4OIJDbaExF1pNa33FjnbDNgiTrndrFb/qq5ecPOlaznL6ottVVlnTdNCW024clCb6Ia+PgXtHRCSwROLsT2+Ua82o/M/evs0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=h5FXvsPY; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="h5FXvsPY"
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-29f1bc40b35so46954735ad.2
        for <linux-block@vger.kernel.org>; Fri, 09 Jan 2026 00:31:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767947498; x=1768552298; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Yi575HxEPqYdzs3ik6olGUPaDRMTDb+C8GKNLy0BrpI=;
        b=h5FXvsPYHKqLkHD3C7cE64abRwBS0/vSZeXgW11prS/WlI2oYTA6IQ4MMjS+BMxxDn
         TUgvew1l+4QcfWexpJtUFn3ixFyeayTqR4mdSkmDuajQF/vzz3MGNYa5/yHYdZvNe1U5
         mm1tQo9kNdfxC+qbS0c09xOt0dn6NCkkKsXddFPQduRdfwJl+EzgISQc9d8fsCpO0cEp
         k2wSxiVzsPErklltYZHuFzbMKtfcgSyZ6w2ZS8UziP7gOMZp9rEfhvjOYM2RRKvZwHNG
         RWOEfdFoVGcBp8RNmV4iDzaSl0AVauUjpWHGvablkQoaG59etHt2naRaSbwRF7rMspNz
         1uFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767947498; x=1768552298;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Yi575HxEPqYdzs3ik6olGUPaDRMTDb+C8GKNLy0BrpI=;
        b=p5mw3KI423sl3cQbnucVqO69p5qxlPXHYz8pfdyrtcxCcX1MccJBC3b23qkoHDFYnH
         kAEsaBeh/4oyhPOrOCMCcp8NRHcVrgcQmY+hc4phFHGkt07ksIEEuRXJ7p7Dqvuw6mD7
         VNHcbGZH6Gvwaop3uHWlSn5BWhumXMgmktylCbQie2Grrx11Tr3QatyqlQjaKbgaNzBg
         hXOyYzEth2fShfUWhGHafotDXrVomeNDEsvQEfhMC4Ac0vY3HRUz6oXXUSyCoDJwKroq
         sqoldAyW7gb4Nuj56vn1f+cm4E9TfxPe/zpjHE1DuvvGnaE9pTDRQYOAUyKIfBAUNTxA
         B1bA==
X-Gm-Message-State: AOJu0YxBAnaa17Y6/DasRIPiy/hwGyUIl53ONVpQ/0yaPOGG/v+7haPV
	mrVN2NwOB8iM/9kqHNSt5aVyKU/U+gq8VZccbl2elu8ODImErTnqm/i/
X-Gm-Gg: AY/fxX4k1YZgxSphGwZXuhXbOZ4X+KNQIWdPkrj2paOU8Woss8tv8uVRD+AvzoYnQdU
	UxepVPCnjxZh1xpJbyra1O5arJfbv79fJdmEAusDmkolgL61cD9IDnx9k7UWbZuJWRFs3HWMLUo
	IsKk5IpWw3GYprqm2RplE5tbvmU0TkvOTs1k0UUTdv5YefhrDHQ4+AfsJ2f+4s3lhWdXkoj1HT8
	5C6me/FejY+ERVsMmePes0QyM4DeFuIy1vXNPmVpoPLCoQfAI5Meoo39pRPEJY1kIqH11dw+HyF
	TsLN1G00UvLa+yH9LTfbTskDotTMG0ghlkWmSgSa+GBydyJnaWj/ThBr8S3/XZlw9u8c7dfecgS
	O7SVdRT1iRlKw20JwIXoCYvMVBnx/issJLky2xxlqV01SgUSgIclgaWBi9s8WaECsjzafMoUrvU
	a8xhOlhx6cbDfVlGjJGb3NRXNmLrDwz8lVJcwMvOsExmk=
X-Google-Smtp-Source: AGHT+IEA9vFPUsUgsZQ7c06U37ax/UVHT0vzORq7l720noPVJNq7+H3JQw9qKDIWz6oNqgVKYDpWaw==
X-Received: by 2002:a17:903:1b68:b0:2a3:e7fe:646e with SMTP id d9443c01a7336-2a3ee413991mr93535125ad.5.1767947498187;
        Fri, 09 Jan 2026 00:31:38 -0800 (PST)
Received: from L9HW65VV5R.bytedance.net ([101.126.56.83])
        by smtp.googlemail.com with ESMTPSA id d9443c01a7336-2a3e3cc793fsm99474095ad.72.2026.01.09.00.31.35
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Fri, 09 Jan 2026 00:31:37 -0800 (PST)
From: Diangang Li <diangangli@gmail.com>
X-Google-Original-From: Diangang Li <lidiangang@bytedance.com>
To: axboe@kernel.dk
Cc: linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	changfengnan@bytedance.com,
	Diangang Li <lidiangang@bytedance.com>
Subject: [RFC 0/1] block: export windowed IO P99 latency
Date: Fri,  9 Jan 2026 16:31:25 +0800
Message-Id: <20260109083126.15052-1-lidiangang@bytedance.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Production environments occasionally run into elevated tail latencies. The
source can be the underlying device, but it can also be higher in the
stack (filesystem contention/journaling, memory reclaim, writeback, etc.).
Existing block IO statistics only provide throughput and average latency,
which fail to capture the critical tail end of the latency distribution
that often causes user-visible performance problems.

This patch adds windowed P99 latency tracking for block IO operations,
exposing the 99th percentile latency in /proc/diskstats and
/sys/block/<dev>/stat. System administrators can now monitor tail latency
trends over time using tools like iostat, enabling quick validation or
elimination of disk hardware as the source of latency issues.

Implementation uses per-CPU sliced ring histograms (21 buckets, 8us..~8s
range) with minimal overhead. P99 values are computed by aggregating
recent 1-second slices when reading statistics, reported in microseconds
using bucket midpoints.

The added work on the IO path is intentionally small (bucket selection and
a per-CPU counter update, with occasional per-slice reset), and in our
testing it does not have a measurable impact on IO performance.

Diangang Li (1):
  block: export windowed IO P99 latency

 block/blk-core.c          |  5 ++-
 block/blk-flush.c         |  6 ++-
 block/blk-mq.c            |  5 ++-
 block/genhd.c             | 50 ++++++++++++++++++++++++-
 include/linux/part_stat.h | 79 +++++++++++++++++++++++++++++++++++++++
 5 files changed, 139 insertions(+), 6 deletions(-)

-- 
2.39.5


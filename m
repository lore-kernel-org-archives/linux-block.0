Received: from mail-io1-f41.google.com (mail-io1-f41.google.com [209.85.166.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA8CE2D05F
	for <linux-block@vger.kernel.org>; Thu, 18 Jan 2024 18:05:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705601152; cv=none; b=La/nhbnVNfDk39V4pVGNzLiy0NGHpzyq49n6voSTVWQPzEt1yptELu7kR/9U87OlU0ddQtklKhRvBr1DFrYO/KX6Y4j3+X0edGYOsy+S2p382fwFrLTCbMfwD3BSCgzAqYZGts55y0jDL2oC1en31Exu/MV/V4RketfDFBagN8c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705601152; c=relaxed/simple;
	bh=FO+mo98ANuEDRJg6mWiQTJZIzfyjgUhRtRO3Ea4b1ng=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=hOjas87ar534WgZTBbT6jlG8CYoVGqpLK8r8zYmAcq3o+KTEMpHZ1HwNOvUXD4vumreRlGH6fR4gwAN22nQxD+nyGNO5ZO6pjuGoGwPYG5E/BXAGi83jRl8UAalukocLQbbM0nuNm9XIschTpEp2pOrTeIHUwlGd3HJGCbhHpgE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=wRxQJX2x; arc=none smtp.client-ip=209.85.166.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="wRxQJX2x"
Received: by mail-io1-f41.google.com with SMTP id ca18e2360f4ac-7bed82030faso72335939f.1
        for <linux-block@vger.kernel.org>; Thu, 18 Jan 2024 10:05:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1705601148; x=1706205948; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=SKrnJEoJSszBQgaQIhZD5/Njnz7/ayUPWmuGIoLr9YM=;
        b=wRxQJX2x/vUXHV/n1VtZ/H9cL90D3SiZFTKyzw95UisMv6iHLbQcuhK5yAOBdO9RfA
         CyrTX5au6p4Gp+ogoynxbRjDKIo2EhuyPvxiZRlJh4wl8sssR6MOAq/lsAM2qdsuWr+B
         oyyXohzGLK+3ZywteO4lWs4vqMZUUL3G/ebJ6sllj3pFzZSAwwoKd5tgeUFLTabkmegc
         aNddLjcisQp48LELq3wqZYpH3O8CGOyVJ26YVncIfAAQ+ZYGFDE0mmMrXjc5TwGpnOM8
         5kr1fh4ho4637JokyoTBGqMeU4RsqvNe/btNkm+f3SbBLe7D+SsGnfcBgGYXbldRWj91
         iF+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705601148; x=1706205948;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SKrnJEoJSszBQgaQIhZD5/Njnz7/ayUPWmuGIoLr9YM=;
        b=HjHOY751ecEqcSfjRcz0pDoKfZJvpjo1ezpHTIfy7rd577o2QdH2K++9/klYs/cf2T
         gSHCc4/qZcdhswBSzQ0gFZpVF50H6q8vZKX27h2XMX6513DeDHM/3FgrMCDmNAeKjLMB
         tg7EnDVpi8dHwnYduuvsyQRIhFVzfA8cMO5NlFyi1Xhw6tNHqGWgexKN3ymMap44crNu
         roYWav1/H/6+dAr5OF/6PIGt7d6h+zpnsuMf4HHsiiZzSoUYAppS5p4j6zotQN4hLegw
         P/T8vzxNJOQO6QHMg//hbIJNYX+VOYWRiFkgRcrOyzgdNEHtFC80MsQhasCG54eIScx5
         HXiQ==
X-Gm-Message-State: AOJu0Yx8u4/nNqX1baiZxyrcBCzoO65+seJxrrtIV7ZAdqdU4qmKFZTN
	HXc0j+Fh3YL4JYwRzEAxMR1MtdCcYCPsKKEZmEaBhc10av/zEsqmpQS8DrG+u6qukoSXmVB/ok0
	FrGI=
X-Google-Smtp-Source: AGHT+IGXZOnuC06CrF9aefQJ1vS9d/W69ypSjXsOMN82guztVPt/AxNHIEJdc7A/dtc//ggv4+mSWQ==
X-Received: by 2002:a05:6e02:1a4a:b0:360:968d:bf98 with SMTP id u10-20020a056e021a4a00b00360968dbf98mr52834ilv.1.1705601148698;
        Thu, 18 Jan 2024 10:05:48 -0800 (PST)
Received: from localhost.localdomain ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id bq7-20020a056e02238700b0036088147a06sm4981873ilb.1.2024.01.18.10.05.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Jan 2024 10:05:47 -0800 (PST)
From: Jens Axboe <axboe@kernel.dk>
To: linux-block@vger.kernel.org
Cc: bvanassche@acm.org
Subject: [PATCHSET RFC 0/2] mq-deadline scalability improvements
Date: Thu, 18 Jan 2024 11:04:55 -0700
Message-ID: <20240118180541.930783-1-axboe@kernel.dk>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi,

It's no secret that mq-deadline doesn't scale very well - it was
originally done as a proof-of-concept conversion from deadline, when the
blk-mq multiqueue layer was written. In the single queue world, the
queue lock protected the IO scheduler as well, and mq-deadline simply
adopted an internal dd->lock to fill the place of that.

While mq-deadline works under blk-mq and doesn't suffer any scaling on
that side, as soon as request insertion or dispatch is done, we're
hitting the per-queue dd->lock quite intensely. On a basic test box
with 16 cores / 32 threads, running a number of IO intensive threads
on either null_blk (single hw queue) or nvme0n1 (many hw queues) shows
this quite easily:

Device		QD	Jobs	IOPS	Lock contention
=======================================================
null_blk	4	32	1090K	92%
nvme0n1		4	32	1070K	94%

which looks pretty miserable, most of the time is spent contending on
the queue lock.

This RFC patchset attempts to address that by:

1) Serializing dispatch of requests. If we fail dispatching, rely on
   the next completion to dispatch the next one. This could potentially
   reduce the overall depth achieved on the device side, however even
   for the heavily contended test I'm running here, no observable
   change is seen. This is patch 1.

2) Serialize request insertion, using internal per-cpu lists to
   temporarily store requests until insertion can proceed. This is
   patch 2.

With that in place, the same test case now does:

Device		QD	Jobs	IOPS	Contention	Diff
=============================================================
null_blk	4	32	2250K	28%		+106%
nvme0n1		4	32	2560K	23%		+112%

and while that doesn't completely eliminate the lock contention, it's
oodles better than what it was before. The throughput increase shows
that nicely, with more than 100% improvement for both cases.

 block/mq-deadline.c | 146 ++++++++++++++++++++++++++++++++++++++++----
  1 file changed, 133 insertions(+), 13 deletions(-)

-- 
Jens Axboe


Received: from mail-pg1-f171.google.com (mail-pg1-f171.google.com [209.85.215.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D491316D9D0
	for <linux-block@vger.kernel.org>; Mon, 22 Jul 2024 13:52:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721656326; cv=none; b=bGnoTEkmqxxpliblfZQg0WSGcHdo2fUyB/kEmCN18uQGs6NEOUSmjbz71OuNuLiLOFaAXXF6iPJ+j5gQ5MA3RgTFiegqk+iAkMdANDwlWZfK+TFmFSKEo1jQX/JkcgmwhV/GsSm2vg/58fuUSpYMqSecYUVt4XjbfEsXcs43kFE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721656326; c=relaxed/simple;
	bh=oslvVjlL9bBAKgAZAmJYTp/sRU6Pd4qruSleAFmI0cY=;
	h=Message-ID:Date:MIME-Version:To:From:Subject:Cc:Content-Type; b=o7w7uUVAZmq77tqQ/ca3XTGFN99Gn6zCndtc8bb//RPUe30r/KWxQ/l5YiCfCngcYOHZi1BPvYeTpH0AZ3a3Ug3EcGcJUDamCXObpJ/toSQtTAav/i3fLXhA/9yUodgORSX3Deh5goVb22JlXj9JVVp46iUoWFhTV7JVgs1jdI4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=zGocYcYW; arc=none smtp.client-ip=209.85.215.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="zGocYcYW"
Received: by mail-pg1-f171.google.com with SMTP id 41be03b00d2f7-7a20ab5997eso94725a12.2
        for <linux-block@vger.kernel.org>; Mon, 22 Jul 2024 06:52:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1721656322; x=1722261122; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:subject:from:to:content-language
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FnwrOq4JX1x44i2N6FR6eZ3sfwu4QJiy3eMq/H6ePlM=;
        b=zGocYcYWxgGlm9Qbs6hC1NbcAINsFFAWEtJzj8+OzJYOD4yeh2/aRgz/yIt2al7qNp
         pOucoxpLqeem+LGaJP4b6hJ+ty9CBC7wFKYGCH8ro/4xTTR4JHK/qG9EQFJeLvU1eVwl
         6w7g2+Z1pYIda8u/+CXu8dgaO7aqfs8KLPE15halwAd5GWWmk8z7wd1IEDd7kboAmbBj
         Yshf3RyrDmnayBMhPxiozq6DFZ40FFTLxZxpxLUonIXVgZHK8TNVIKqbPAQ9JELrPbsE
         cjoGF8cOL6ddDO6+qPX5gOH141EITq5n321lppl+yYSGSnklVuRjs+KT6ehhIwWT2S5G
         n+BQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721656322; x=1722261122;
        h=content-transfer-encoding:cc:subject:from:to:content-language
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=FnwrOq4JX1x44i2N6FR6eZ3sfwu4QJiy3eMq/H6ePlM=;
        b=Wp49HRCE8JjZR5yaeJyCIafA4QbHmA6hItubqYQtgNptBzan+QhB8jXpt+lRJ7qrOW
         EsQPCAXgKPwCS1T5TWXyi2mN94dq7EcHFFB3j3pAosIh2k13UsvMvH+fXU25kIhtBem6
         RGkRbZJDmhvzoOsYdBpp9Nfw6H5KRw8gF2CbSxH8xDTo3zlED8mr6SHWVmI3o/7Q3xtw
         QQgtthmmUwqN5pyBHuetFNXfKSKjxQ4c8e2cCXIOBE8Xthy/Diuge/JzeXYdqs/k8OKe
         VdB1Af3nLHyxYsFXtYAUrRRiL8RjzRsXF/5QfWGEjjMm46X++JgixVHed23KpgPBvcwM
         3Z5Q==
X-Gm-Message-State: AOJu0YxQgnVWZ06MRmze+zs19N/c1v9JfNjBluZZiOuhTdh5kH/Z5cLF
	AoHGumEbd+Pg5dYnfh/72b8k73QXVjnbm5cd5pOiAAASmcrW4rVROHYo+E6uOqco8LyJYHoSX1+
	upGI=
X-Google-Smtp-Source: AGHT+IGaK2a+XeeCW+SqU2aG/QPxLLrWQxYWI0uf0DiPyUbuDCRZXncakzITEfckWaZPCm1BjRqjcw==
X-Received: by 2002:a05:6a21:e89:b0:1be:c3fc:1ccf with SMTP id adf61e73a8af0-1c42285ddefmr7193309637.2.1721656321739;
        Mon, 22 Jul 2024 06:52:01 -0700 (PDT)
Received: from [192.168.1.150] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2ccf7c76fe7sm6997279a91.33.2024.07.22.06.52.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 22 Jul 2024 06:52:01 -0700 (PDT)
Message-ID: <5e4f743c-9919-4c9d-92cd-2bfabb4ff35e@kernel.dk>
Date: Mon, 22 Jul 2024 07:52:00 -0600
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: Linus Torvalds <torvalds@linux-foundation.org>
From: Jens Axboe <axboe@kernel.dk>
Subject: [GIT PULL] Block integrity mapping updates
Cc: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Linus,

Set of cleanups and fixes for the block integrity support. Sent
separately from the main block changes from last week, as they depended
on later fixes in the 6.10-rc cycle.

Please pull!


The following changes since commit 98d34c087249d39838874b83e17671e7d5eb1ca7:

  xen-blkfront: fix sector_size propagation to the block layer (2024-07-02 08:58:12 -0600)

are available in the Git repository at:

  git://git.kernel.dk/linux.git tags/for-6.11/block-post-20240722

for you to fetch changes up to 74cc150282e41c6c0704cd305c9a4392dc64ef4d:

  block: don't free the integrity payload in bio_integrity_unmap_free_user (2024-07-03 10:21:16 -0600)

----------------------------------------------------------------
for-6.11/block-post-20240722

----------------------------------------------------------------
Christoph Hellwig (6):
      block: split integrity support out of bio.h
      block: also return bio_integrity_payload * from stubs
      block: don't call bio_uninit from bio_endio
      block: call bio_integrity_unmap_free_user from blk_rq_unmap_user
      block: don't free submitter owned integrity payload on I/O completion
      block: don't free the integrity payload in bio_integrity_unmap_free_user

Jens Axboe (1):
      Merge tag 'v6.10-rc6' into for-6.11/block-post

 block/bio-integrity.c         |  87 +++++++------------
 block/bio.c                   |  16 +++-
 block/blk-map.c               |   3 +
 block/blk.h                   |  14 ++-
 block/bounce.c                |   2 +-
 drivers/md/dm.c               |   1 +
 drivers/nvme/host/ioctl.c     |  16 ++--
 drivers/scsi/sd.c             |   3 +-
 include/linux/bio-integrity.h | 152 +++++++++++++++++++++++++++++++++
 include/linux/bio.h           | 156 ----------------------------------
 include/linux/blk-integrity.h |   1 +
 11 files changed, 222 insertions(+), 229 deletions(-)

-- 
Jens Axboe


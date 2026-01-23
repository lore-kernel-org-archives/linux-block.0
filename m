Received: from mail-ot1-f50.google.com (mail-ot1-f50.google.com [209.85.210.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C42DD2F6920
	for <linux-block@vger.kernel.org>; Fri, 23 Jan 2026 11:53:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769169224; cv=none; b=l59M0KdeBSwJeA/nnS0MRnhGJKSC4HnAvfnwTyRfZmiH2aaGRTbyiFxm4P/1aTzvGlO7COJdJmSHFgYuBRCKQmMWJqlCIzDaM2PJzOwW5OtymkSwWcXUWLYIJarZP5jn8Mei9FSGzB9PLccW1hdW0TvyzpqKLU84Fx3fgW3wDp4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769169224; c=relaxed/simple;
	bh=5l3A3XhX9Nn3ssGUAGDL2RxHcuLY1Q77Bh/eLpmu4EQ=;
	h=Message-ID:Date:MIME-Version:To:Cc:From:Subject:Content-Type; b=sXjndrJdTHfhzMyJ8ShsE4Ywz4RzBeTW0bqF+rC3XZqEilzkLdcMXnTx2r0LzwCDYSnWr79i6XEoPLlioF727eihK6Sznc1ob5SzHFL9Lq9yd6soUZFbgdA0z++ClY4BU0uJENBHMuDj59/q7FnLmGHfILoRXBlYWRQaPo/PsKs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=Vrt0DS8m; arc=none smtp.client-ip=209.85.210.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="Vrt0DS8m"
Received: by mail-ot1-f50.google.com with SMTP id 46e09a7af769-7cfcebf1725so1534213a34.1
        for <linux-block@vger.kernel.org>; Fri, 23 Jan 2026 03:53:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1769169219; x=1769774019; darn=vger.kernel.org;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=q1bfelIcGj9bPg/ihS4pbXaq7rSK0ZKcJSkeEsJlxbE=;
        b=Vrt0DS8mLviaSNfWYB/qeyWJCBGqZzKdn4tu24Qqa6eeM/l0WgAzKCAMxEr2YO6CjS
         hMQ+cgwuxK08BoSf0AULEkHlYm58s4juD0KQKkVxOc5vuSyhYFFTe9od25LLD2Vt6xBW
         vYC5vmUfkVLDB2A/wzR8fI1R6WRCloPA+APjlLHbppq6feyihRWs4+IlTcvH9HC6ipOC
         qekKXhYmmZzeqkzjABNqlTRePVxwIpwDznM/YK99YMSGISOmtrmb7gbW+BZl9WSeAalb
         KnZ6rCnAZuNTZUfYdB7H5uJv/8LLArDotzt/dggvCQOvywogR/4GImbedMotdc30Xjoi
         BXEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769169219; x=1769774019;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=q1bfelIcGj9bPg/ihS4pbXaq7rSK0ZKcJSkeEsJlxbE=;
        b=XLug5eOmLF+rXugN8xfABqzDjggyCCI8OanRMfymo9JbPNKI+5kI0+EIqkluT39491
         PG+PKqgGKcFy4WQzGmb6turL6F/MK0N1C9rs3k9AsUpUZ/4/LhO1Ch5Abnf9+9ZsJZZB
         JqGPXmDD/SPCK2If+bfgnzcMS626OzJqzABY9dU4gWqQ93aQTfaVmptYKVAzYbpFiSKQ
         G1Y1iL8UYvqkc8f49n19UStbbzaiOkLRG7GNfndRxzbUF1VelzJlEtT/+Sdsvi1QSmQv
         DVaNdGVLNQe9LMMx+gd8se/KgOnIABLryB6YZDBBL9BKJ7TPFV+HWWH0eBx64JVvvmPb
         KsFA==
X-Gm-Message-State: AOJu0Yx6ZdtCeK9M64PxHqcJk3sYUtI44pPnpWfr1vo4g7as6YmoYqJQ
	gbD1xPKLQQaIInSXI1zNGL8GjBZFA0qRQNcJNTK8GeXzUMhnhK6WGjR+s7fomk+bNSI6BHFPtnf
	MByvF7hQ=
X-Gm-Gg: AZuq6aKdzRU2LeeKkFetRYCWsmrIuhBdTdtpNYV/uRo+UYEWfOl3ouB5hECa9iPhKhs
	Eivh8a5HAOkm8e2ETa1rgxmXIWC7eLm9ex+LRvmeXhXohBA1yykI4ltnRNYEclWw3FhgvcYO14p
	ZCew1grzNTJVNITTweqGG15LZIC8G77XpaU/2zXDRy9OK6abCBjS1E/bJX/a+vnjMazo53cXcqu
	bLs/Vjxb2IYhXIBCbICAf9R7amm2Ctf+lSYgJ+9Dv10PFQ92+HQ3uuueTb5XOsGsxvunM2gSZTe
	xv8u2TCycwPbfNZJA70xetstaD5HAKTYHrI9Nqt1eGzCwM04oz4/SAzz0VPrb9rnXVNh0m4aw1R
	zwyn7pqAM2oUTE2RyVFQeUKNozJV9VH1k2BazcEU3peSfqIuKRUjlbYJVA87KLSMTqQxhKZxioU
	M3iD2Re3bpNXoIXnEqaQh+llF7hZJFAf61k23Nh9KGTBzNqLLDY6qlWHqf1siB5GEkNzgakw==
X-Received: by 2002:a05:6830:81d4:b0:7d1:4d5a:29fb with SMTP id 46e09a7af769-7d15a64cf35mr1655312a34.38.1769169218706;
        Fri, 23 Jan 2026 03:53:38 -0800 (PST)
Received: from [192.168.1.150] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7d15b346e03sm1665238a34.1.2026.01.23.03.53.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 23 Jan 2026 03:53:38 -0800 (PST)
Message-ID: <361664fa-25d6-48e9-9e7d-6cf7437cc9ce@kernel.dk>
Date: Fri, 23 Jan 2026 04:53:37 -0700
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
From: Jens Axboe <axboe@kernel.dk>
Subject: [GIT PULL] Block fixes for 6.19-rc7
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Linus,

Set of fixes for block that should go into this kernel releae. This pull
request contains:

- Set of selftest fixes for ublk

- Fix for a pid mismatch in ublk, comparing PIDs in different
  namespaces if run inside a namespace.

- Fix for a regression added in this release with polling, where the
  nvme tcp connect code would spin forever.

- Zoned device error path fix.

- Tweak the blkzoned uapi additions from this kernel release, making
  them more easily discoverable.

- Fix for a regression in bcache with bio endio handling added in this
  release.

Pleae pull!


The following changes since commit ec19ed2b3e2af8ec5380400cdee9cb6560144506:

  rnbd-clt: fix refcount underflow in device unmap path (2026-01-15 07:22:09 -0700)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/axboe/linux.git tags/block-6.19-20260122

for you to fetch changes up to 3ef825dfd4e487d6f92b23ee2df2455814583ef4:

  bcache: use bio cloning for detached device requests (2026-01-22 07:24:50 -0700)

----------------------------------------------------------------
block-6.19-20260122

----------------------------------------------------------------
Bart Van Assche (1):
      block: Fix an error path in disk_update_zone_resources()

Christoph Hellwig (1):
      block: make the new blkzoned UAPI constants discoverable

Ming Lei (4):
      selftests/ublk: fix IO thread idle check
      selftests/ublk: fix error handling for starting device
      selftests/ublk: fix garbage output in foreground mode
      blk-mq: use BLK_POLL_ONESHOT for synchronous poll completion

Seamus Connor (1):
      ublk: fix ublksrv pid handling for pid namespaces

Shida Zhang (1):
      bcache: use bio cloning for detached device requests

 block/blk-mq.c                       |  2 +-
 block/blk-zoned.c                    |  1 +
 drivers/block/ublk_drv.c             | 39 +++++++++++++++---
 drivers/md/bcache/bcache.h           |  9 ++++
 drivers/md/bcache/request.c          | 79 ++++++++++++++++--------------------
 drivers/md/bcache/super.c            | 12 +++++-
 include/uapi/linux/blkzoned.h        |  6 ++-
 tools/testing/selftests/ublk/kublk.c | 11 +++--
 8 files changed, 101 insertions(+), 58 deletions(-)

-- 
Jens Axboe


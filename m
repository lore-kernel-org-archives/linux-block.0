Received: from mail-pg1-f175.google.com (mail-pg1-f175.google.com [209.85.215.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFA712EE268
	for <linux-block@vger.kernel.org>; Fri, 10 Oct 2025 13:27:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760102847; cv=none; b=EiluN5IJJLkaIxrVgJklkpdUKqdiW7qjJvXQy3oEHgKFdqZgLNfzndGYgl9QaaIu8eDKEPoAGfYlr/FeXvOJVwSx7GRndsnACQYs2APm4980kaZcRq2/78/6xEj9g7IcXNJ0vvtm/JKhzCD9SSEzycauq40xmLps0grUg+PS/UQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760102847; c=relaxed/simple;
	bh=0yc6D3vjvR4a/YEsJwrRIbnzPYVlgGfc3L8srTpdrUA=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:Content-Type; b=PWu64RG4Y9Xk2s9bY4LhqJohWTE/4wp0jIFLJaWhMbmRcRYzkgHpucT+GAshckXpHPAyyPYkvw9xKWwsRXoaBt/LdvtNwRebV4zUUFLLkT04+RoimQHLzPeiCHjxUqv9SCYNWoea5596OkWJ2RQ3Edn5V/DjJ170U/MI1RZ+kcQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=DOr8Q2KG; arc=none smtp.client-ip=209.85.215.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="DOr8Q2KG"
Received: by mail-pg1-f175.google.com with SMTP id 41be03b00d2f7-b555ab7fabaso1877325a12.0
        for <linux-block@vger.kernel.org>; Fri, 10 Oct 2025 06:27:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1760102844; x=1760707644; darn=vger.kernel.org;
        h=content-transfer-encoding:content-language:cc:to:subject:from
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/jlWosQmjec+nqg20x9i79hN9RxJ9JzoJwEaSszOlzo=;
        b=DOr8Q2KG7eThr8bjixo+vwBx4ayvbWUT85kYOWrMZ/WZXMUH1BYs6mNMKA8MM4GiBn
         /nUnkr7QO32MssTevICg38T2g4Yv24ETRqAIQoZK51dhuIdexAUzWl/Q2pX/B+TvohTU
         xxFNMe/3Ug9cMXcvvJM7czUGjGFz89r9LLO3Sr/Ft1mo0G5J9GHyXMH7zyxfAmuUog1w
         ad6/UuRT6izjbKS6VNjfQte3Ci1bOwDSlAef7nEEiibMMn7p/czVO/2coly1hKQMti19
         b2oMwJP6KdZUFsAufAXKE6N0eNxp7l3z/ENG/phZ5R4FMUCcqQseI6lSQC3eYUcFjGUx
         xVNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760102844; x=1760707644;
        h=content-transfer-encoding:content-language:cc:to:subject:from
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=/jlWosQmjec+nqg20x9i79hN9RxJ9JzoJwEaSszOlzo=;
        b=OEKBYqFSW4EVHFlynmQf0qguYKv48lXhQ7C0+Bcs8x37K2Ks3YQarIMZdR16z/2rBZ
         XA5H85sV7QBHyYgzcICvFHBSzosIQOwiEHvus/OwCunidqfjojRcGO5EWpZN3dPfRTXg
         EuXSgCxX14wCTtsS/YG+VUsT3386ARLkWxqF4hvjXFoCEUAPLwmocmbgKXSS69XBz1mG
         35n/Lesw2vk4q7g+x1qUrm05RKw2/IrY8PsSWtlGbC6tb6/NwXYvQAI8QeKp1wAYQenW
         K6e5yb08FU2tEX4hypKpae9ex6MfcAe1egs9LZgUFgDqNBqdnhtPpqiSFM4an4WNX2GR
         rt5g==
X-Gm-Message-State: AOJu0YxSr5gsMl8YyGMn5hRUmyl0fx4R0LNzphjNRqerDMS8aYMlA4ZB
	RYExtBZ9U83TLbB75T4fKlZKEvRTc2Ujbyh+0CL3W2+aEJkvBK9fXtabXzgHg5qa9yL0fONYdJS
	DsVG1fF0=
X-Gm-Gg: ASbGncvUEu2CrUm1Bgr0lpTOjqH0fymSB6Ght9n75TfDVMOj8Ua/HwY78pHsqji2x6X
	mc6SkfsqA5NctTRgZdm1l+7YMGg/RNPZpxRKgqFqyI2FbEx2FfApCTPQ3yDQn5yOpdfLkfvTso8
	YFIh+2XRYkwWEc7M7G9H6vm4LL+Lk7Jnksj3908sX33KpS9AJ1+2mVtvQzuiYBIhgTso77AuLyR
	hCuU1QBkIBXARvRKfY7tnuoUl6maXgv/jkAlziURGXsW9L5WmE5kxoLnxVWIWWW9BeQ5p9GZAki
	DRVHhBiDzFlzdu85GQ/P5AONjQ9nYIyBOzczYDhAKSIYadN67e4eg2pSwNpS+VEqT3zVGbEjHrD
	CpTiWbDXKPH0ck3U47otuoxKYsYq+eHk/D6n9VedqfXL6gZcnpfZ4Jhh923fk
X-Google-Smtp-Source: AGHT+IHWufZTpIGGR6RejZDyo77IoEnYcSIj34he3RY3lanrmj1KQbuaSVvsNx9s3J8Isa7KFdz+RQ==
X-Received: by 2002:a17:903:138a:b0:268:b8a:5a26 with SMTP id d9443c01a7336-2902741cd15mr148167145ad.54.1760102843722;
        Fri, 10 Oct 2025 06:27:23 -0700 (PDT)
Received: from [192.168.1.150] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29034f894c8sm57481765ad.122.2025.10.10.06.27.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 10 Oct 2025 06:27:23 -0700 (PDT)
Message-ID: <7358f984-58f4-4750-9213-64be0a5de371@kernel.dk>
Date: Fri, 10 Oct 2025 07:27:22 -0600
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Jens Axboe <axboe@kernel.dk>
Subject: [GIT PULL] Block fixes for 6.18-rc1
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Linus,

Set of fixes for block that should go into the 6.18-rc1 kernel release.
This pull request contains:

- Don't include __GFP_NOWARN for loop worker allocation, as it already
  uses GFP_NOWAIT which has __GFP_NOWARN set already.

- Small series cleaning up the recent bio_iov_iter_get_pages() changes.

- loop fix for leaking the backing reference file, if validation fails.

- Update of a comment pertaining to disk/partition stat locking.

Please pull!


The following changes since commit e1b1d03ceec343362524318c076b110066ffe305:

  Merge tag 'for-6.18/block-20250929' of git://git.kernel.org/pub/scm/linux/kernel/git/axboe/linux (2025-10-02 10:16:56 -0700)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/axboe/linux.git tags/block-6.18-20251009

for you to fetch changes up to 455281c0ef4e2cabdfe2e8b83fa6010d5210811c:

  loop: remove redundant __GFP_NOWARN flag (2025-10-08 06:27:53 -0600)

----------------------------------------------------------------
block-6.18-20251009

----------------------------------------------------------------
Christoph Hellwig (4):
      block: remove bio_iov_iter_get_pages
      block: rename bio_iov_iter_get_pages_aligned to bio_iov_iter_get_pages
      iomap: open code bio_iov_iter_get_bdev_pages
      block: move bio_iov_iter_get_bdev_pages to block/fops.c

Li Chen (1):
      loop: fix backing file reference leak on validation error

Pedro Demarchi Gomes (1):
      loop: remove redundant __GFP_NOWARN flag

Tang Yizhou (1):
      block: Update a comment of disk statistics

 block/bio.c               |  5 ++---
 block/blk-map.c           |  6 +++++-
 block/fops.c              | 13 ++++++++++---
 drivers/block/loop.c      | 10 +++++++---
 fs/iomap/direct-io.c      |  3 ++-
 include/linux/bio.h       |  7 +------
 include/linux/blkdev.h    |  7 -------
 include/linux/part_stat.h |  4 ++--
 8 files changed, 29 insertions(+), 26 deletions(-)

-- 
Jens Axboe


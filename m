Received: from mail-qv1-f53.google.com (mail-qv1-f53.google.com [209.85.219.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C46572D6E71
	for <linux-block@vger.kernel.org>; Fri, 17 Oct 2025 10:26:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760696789; cv=none; b=bVoe8H4Jy8ys1X8ykDY8gGi08J6jMZ2outqsylRvc9WDU8FzTnqzDq10bUaDVc+Jj4pl9BrqXXD8j9kMBzfbaxNfmDhqXVPfFzBHyGy4faM+ZLF9d3rzUoYoKJp5zBtzCF2TgtNzWz11YVAnwh5nvGNevzqSKDQy/saIYO0inAY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760696789; c=relaxed/simple;
	bh=qOjqUlcWXkeuTXUcJJoKz+DAqhADXdI8AExdrTIoxh4=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:Content-Type; b=OdUkYaJxyNSVjvno2lJ5HwFiyEgLxOUER62fwsus1kO0+ZuI8DUpBFfvx9mF5+oJ+mdqct317AS5Fns9w0IeuHRC9e59zo/ThQAzO0V9ZLNCSzuQdXG14HGZGy+L4q0R8b47DLoTSXABS0rRpzTtS8KXzFk4kRgqfWGFsDj5ks8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=BmbRbiKl; arc=none smtp.client-ip=209.85.219.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="BmbRbiKl"
Received: by mail-qv1-f53.google.com with SMTP id 6a1803df08f44-87c1a760df5so32322016d6.1
        for <linux-block@vger.kernel.org>; Fri, 17 Oct 2025 03:26:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1760696785; x=1761301585; darn=vger.kernel.org;
        h=content-transfer-encoding:content-language:cc:to:subject:from
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6TgMafxjRq0oy0uUU6fp3ywn8H1fr7KuB4B6zdZk4M0=;
        b=BmbRbiKlMUo3Ay4hkR7QYK7Nc03UjzIIVstLiazU1Si7YBTqCnx3eyUFFzeWSUISzC
         ghMZxbjlVeaJN1vHcYxvvv7Scw/RmM7yUvcmudeSxiAMvq1JNyIX29SJQIIjig+0cBGv
         oVdeXgBu58sndDs17y1vE+Ys5JDyJgL/3LyjRx5i9uwyH3c8NYRvEZ6nr04eOiJaO+o/
         ox00p4o2psA6aKbL/kfpKOFnQ4EXj/j0h5SQl/ubiv9mceKSJdt+hFwCTPwCqhI96l7E
         MORh3JBxJ0F/3j+JdJyfcn5m1BtJoCQrK4ltrGCiklkyJ9aczTBRcbdKi/Me50UrtPqM
         02Pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760696785; x=1761301585;
        h=content-transfer-encoding:content-language:cc:to:subject:from
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=6TgMafxjRq0oy0uUU6fp3ywn8H1fr7KuB4B6zdZk4M0=;
        b=Tmu9R6R5NCfHOokJWMklM3c5gHyTIG9efAbxskt2SM8buBHl/cGAxgvilM+pMkbuSY
         bTVZ0NwFW6vZ82sftyyguHuuDUeXO5JKf4VpP40Hh0WOCDTwW9qC6zNHGB8ZEmJ+qVLQ
         xTsmlv+DT9ty2ixe2YTM+GNw2PwSxXcn3a3e7Ov66RWAJDwkbHkA3X3h+1zG8nXR8e+q
         mKU2lrI9XYjETux9oRZ5jufcfo0s+qa9mDLLQ50wd+bWcZWf5reREZcHg+YyKQdQs9kY
         l8UdzZpINAJjm3EDyRp6MkOWCjf0mV0E2+fYNJx2grLRkYSaKl8tJQHbEPu2SXisx1Dq
         dYYQ==
X-Gm-Message-State: AOJu0YxUutM+V4+GiTuefYpjsFmex7JROkVL02P1M/BdZIxpKD3prUXO
	4lGi/6ZZ8v1PwPL/HrEdsHZUct1NOHUqRh0/rheXeSZJr9v30x0RMSCX3w8hgUHdtfjXf7vu95d
	7JV1cASc=
X-Gm-Gg: ASbGncte4YphdD4UgEJKJ51Bvl57NTghXoBGhKoCN7M5RSxujlPr9KCaJExyuud8TPO
	2vGVzy1bH5Sw16F3wICKKQTbwagOBNRw3E93UKAQQHOIBJ8YW+nDDUYT966+ebdNF0pWgb6BLlG
	5nvkak65FW/vstkFbaWTaBLH0eY2qweREUeNY/Rh2v/xCijHzQTpAXpcfEmyHy5gL7JJutZsCDC
	KFg3YG/4tUbezHrz5LnqO3wQ9gVtCMgYuEidoNKSdRW+sw3n53gtI+bgc42Od8iygkcumbnxkO4
	Y0Obao2gWoc1Wwktnz8Z+decs85HuTclFIHeFY6s0S1AgovifUtTVYno78aKqijtNXYDSAxKOyw
	NKRq4j1ReXnsx8nkaBSmADT61CcYxaygB+aVQb5cCJ4S+ikjzd2vy+xVmHi3zK+tUMYEYcduNlR
	VRxxFO+rkyrV0b2LRJ+3B61UxCeB/Rq4IyuswaC40=
X-Google-Smtp-Source: AGHT+IHA9kQHmr8gJBb2GLqlPQFDpIDA1LLoN7mYIThsRF6DphvfH2JelROn1knvhdIIVeFY3qHIvg==
X-Received: by 2002:a05:6214:8006:b0:87c:20f5:84db with SMTP id 6a1803df08f44-87c20f586d4mr34748296d6.15.1760696785543;
        Fri, 17 Oct 2025 03:26:25 -0700 (PDT)
Received: from [192.168.158.66] (syn-024-169-078-030.biz.spectrum.com. [24.169.78.30])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-87c0121c0adsm61037626d6.18.2025.10.17.03.26.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 17 Oct 2025 03:26:24 -0700 (PDT)
Message-ID: <f771a6b5-c524-4b69-ad07-bcb77cb3e334@kernel.dk>
Date: Fri, 17 Oct 2025 04:26:24 -0600
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Jens Axboe <axboe@kernel.dk>
Subject: [GIT PULL] Block fixes for 6.18-rc2
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Linus,

Set of fixes for block that should go into the 6.18 kernel release. This
pull request contains:

- NVMe pull request via Keith
	- iostats accounting fixed on multipath retries (Amit)
	- secure concatenation response fixup (Martin)
	- tls partial record fixup (Wilfred)

- Fix for a lockdep reported issue with the elevator lock and blk group
  frozen operations.

- Fix for a regression in this merge window, where updating
  'nr_requests' would not do the right thing for queues with shared
  tags.

Please pull!


The following changes since commit 455281c0ef4e2cabdfe2e8b83fa6010d5210811c:

  loop: remove redundant __GFP_NOWARN flag (2025-10-08 06:27:53 -0600)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/axboe/linux.git tags/block-6.18-20251016

for you to fetch changes up to f0624c6646435c1b56652193cce3e34062d50e3f:

  Merge tag 'nvme-6.18-2025-10-16' of git://git.infradead.org/nvme into block-6.18 (2025-10-16 13:25:40 -0600)

----------------------------------------------------------------
block-6.18-20251016

----------------------------------------------------------------
Amit Chaudhary (1):
      nvme-multipath: Skip nr_active increments in RETRY disposition

Jens Axboe (1):
      Merge tag 'nvme-6.18-2025-10-16' of git://git.infradead.org/nvme into block-6.18

Martin George (1):
      nvme-auth: update sc_c in host response

Ming Lei (1):
      block: Remove elevator_lock usage from blkg_conf frozen operations

Wilfred Mallawa (1):
      nvme/tcp: handle tls partially sent records in write_space()

Yu Kuai (1):
      blk-mq: fix stale tag depth for shared sched tags in blk_mq_update_nr_requests()

 block/blk-cgroup.c            | 13 ++++---------
 block/blk-mq-sched.c          |  2 +-
 block/blk-mq-tag.c            |  5 +++--
 block/blk-mq.c                |  2 +-
 block/blk-mq.h                |  3 ++-
 drivers/nvme/host/auth.c      |  6 +++++-
 drivers/nvme/host/multipath.c |  6 ++++--
 drivers/nvme/host/tcp.c       |  3 +++
 8 files changed, 23 insertions(+), 17 deletions(-)

-- 
Jens Axboe


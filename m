Received: from mail-io1-f48.google.com (mail-io1-f48.google.com [209.85.166.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E37E62E718F
	for <linux-block@vger.kernel.org>; Fri, 31 Oct 2025 17:04:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761930254; cv=none; b=e9SeuBppbZTFUzWqerz+9UQ/z/wRbH1h9tCjwlP4JlpQQOABPtOtywWqeefZKBGgd0ql1RbQgqAgGh4vut7D4yCyrBFDHHikCF/9nJikTH1cfh/1yRPLiAaLKfYV+UDFjDcx11vjyHb7NWheSlSaehMkqTB+XvvEk4SEaJZgk6I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761930254; c=relaxed/simple;
	bh=HWDVbpqeaBkJyA3VWcTc2b7lwz3yCd/4hq5AVMzKPNE=;
	h=Message-ID:Date:MIME-Version:To:Cc:From:Subject:Content-Type; b=Zs0yfz3db8+663d5iez0q48Njlm9sUNowE5IzDJjtHLfmcDzhc63ICLHtIUKGhAQhzIYI0PRy9Qg3TMlFeSU3lGktl+xrsNar3lZafk+wJaz0R21lmE/1rlyMXbTRL4sh8fIuupkWYYyMAM0/Q47+zU4bwlUUlL50HhlPcrtCGA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=XmPv8vG5; arc=none smtp.client-ip=209.85.166.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="XmPv8vG5"
Received: by mail-io1-f48.google.com with SMTP id ca18e2360f4ac-93e7ece3025so109304939f.1
        for <linux-block@vger.kernel.org>; Fri, 31 Oct 2025 10:04:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1761930250; x=1762535050; darn=vger.kernel.org;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=g3g7S5qD8Jzc1eHgDYcIRwL/BJkxLdQR17azMzznU7o=;
        b=XmPv8vG5AFkfqKn+sPmBkai1y9fcvm5zcmQRGVEW4IuFfGxjhH0EQGvGYlOQ+oR5zP
         j34N67T1TjA88HqlI5iw/K0jQjcysc7gg9XqPwWuYhXbFIDAmFAauTdLD4FPDWBjV7/D
         hdTArLk+vlb/2ou27sds2rTCEHnGd5PdJQ6dy+JUHWUOXayvto5BexHRhU1XYawOhV6/
         EXWOWa7AorQzqT4BcA6RXr7wMWbKZeiZC0OYq6IaKFbjC4Ds3Oy6+D5w/aJn0kV7o19t
         YSLiJjY/EwnIJ5pkvXY1LJhejjmQ1YRwhjhwzLYWwLSxZnOuujETOFcOhsbCQxRPDkjt
         ZZCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761930250; x=1762535050;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=g3g7S5qD8Jzc1eHgDYcIRwL/BJkxLdQR17azMzznU7o=;
        b=fWgZ6SVVKDfk3iJuA0CLE7k9Z1wqd6f5xWamyr1OaaX/QrdLIY9Uv+FehaX4gAcL7Z
         Hq5wlxZ7PiBzFyqxXZJueM8vlZC7I+FNokpxTO/mR9HTrAPINaZTLx43PPlxrieNJgbI
         lyLP7Omj8BLvay6cyoX7ZD5E5hfvz34C4nQFTI2z5Tq0pot2ODawtPTVO0Xx7/h6l2pt
         0g4SytNwxi0gZhzj3mZVsckwh6sf8VXX3zJ0fqupX6WBFmv5RPhsbYmnsAW8zr6vufl3
         9URx0+E8v9R3YXiNxzabXtXJ9kD+bohMCPQjj4ms18nnBZ+2JPVuC35mMa6rA0MuTHFh
         VERg==
X-Gm-Message-State: AOJu0Yxf4StG3WMqffhWJ/te7+ww/xe0Pt/XMBf/3uTm8BLSEZMOIYXH
	H1rfpb+21kxLT4NJ1ufBIzqrYshJHY/FHouRB2g4B6pFEDvS9Lhx14BD8R+ReaX3syDwC8Hqdg2
	n5irA
X-Gm-Gg: ASbGncsHFN2V+pLeWugFh7SBzUSVg/TlQxaHfxxXzdBXcvHkMU9GWahju+yaVdJlEFw
	GhKhMoV3z6uPtrSdbAtvJJcmYKj/falyQSz79771x5e1eMPWYl+JuyaYPCzSRhSbr1hoPWcgsJr
	rcMDmPJnfT+z4+JIFwaX4d9hWeiroB9sdWdq9+EYiidkqzJ1IYGXLfXSe6iTU5nEXtZvStWvejd
	Z9hchxkE4zBngYtsZH9kn4+/QKZeZiyc5tfIgA8pDnOr71+5Hl0LDnDhniX5M7Rfl4oICF79e7e
	MElSTA5EdITdkogHuURjV5H/biEaRjO9FMWynuxgsUjGfL5o9FIkkdbXIx96+LHLSwZKnOVNf0k
	BVEu6VztWSfRAWsiV7Lo9j07w4vh6DYbPgQWbfJg3h2BqSXseBbqrzxtcU728hRC2CC7rRCGbAx
	pXuAYVhBs=
X-Google-Smtp-Source: AGHT+IFcrZwmY12x7qHQCX9935YadBlItn1iFjU3UIq0umWrt41CYVUAOOo183AwI8cfNoMGK7wK0Q==
X-Received: by 2002:a05:6e02:23c6:b0:433:100c:58f4 with SMTP id e9e14a558f8ab-433100c59d1mr48109415ab.14.1761930249611;
        Fri, 31 Oct 2025 10:04:09 -0700 (PDT)
Received: from [192.168.1.116] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-5b6a55b1b27sm884115173.41.2025.10.31.10.04.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 31 Oct 2025 10:04:08 -0700 (PDT)
Message-ID: <abdcc067-2eab-422b-abb3-bb4ce8793c1b@kernel.dk>
Date: Fri, 31 Oct 2025 11:04:07 -0600
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
Subject: [GIT PULL] Block fixes for 6.18-rc4
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Linus,

A few fixes for block that should go into the 6.18 kernel release. This
pull request contains:

- Fix blk-crypto reporting EIO when EINVAL is the correct error code.

- Two bug fixes for the block zone support.

- NVME pull request via Keith
	- Target side authentication fixup
	- Peer-to-peer metadata fixup

- null_blk DMA alignment fix.

Please pull!


The following changes since commit 4c8cf6bd28d6fea23819f082ddc8063fd6fa963a:

  block: require LBA dma_alignment when using PI (2025-10-22 10:02:54 -0600)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/axboe/linux.git tags/block-6.18-20251031

for you to fetch changes up to 0d92a3eaa6726e64a18db74ece806c2c021aaac3:

  null_blk: set dma alignment to logical block size (2025-10-31 09:03:12 -0600)

----------------------------------------------------------------
block-6.18-20251031

----------------------------------------------------------------
Carlos Llamas (1):
      blk-crypto: use BLK_STS_INVAL for alignment errors

Damien Le Moal (2):
      block: fix op_is_zone_mgmt() to handle REQ_OP_ZONE_RESET_ALL
      block: make REQ_OP_ZONE_OPEN a write operation

Hannes Reinecke (1):
      nvmet-auth: update sc_c in host response

Hans Holmberg (1):
      null_blk: set dma alignment to logical block size

Jens Axboe (1):
      Merge tag 'nvme-6.18-2025-10-30' of git://git.infradead.org/nvme into block-6.18

Keith Busch (1):
      nvme-pci: use blk_map_iter for p2p metadata

 block/blk-crypto.c            |  2 +-
 drivers/block/null_blk/main.c |  1 +
 drivers/nvme/host/pci.c       | 13 ++++++++++---
 drivers/nvme/target/auth.c    |  5 +++--
 include/linux/blk_types.h     | 11 ++++++-----
 5 files changed, 21 insertions(+), 11 deletions(-)

-- 
Jens Axboe


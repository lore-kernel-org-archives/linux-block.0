Received: from mail-il1-f170.google.com (mail-il1-f170.google.com [209.85.166.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2DA528D826
	for <linux-block@vger.kernel.org>; Thu, 22 May 2025 19:58:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747943899; cv=none; b=LghV+ZQVdZGQO2MeZuF9bWMFHcutw8dhWYCQE1McAYjQsdCBnMrkNepiEtcAe53hqf9l2BJsWPZRaf4d+jvLayWdxBLCOs43BOCe0t35IFP5y9yAwKj5/RZsUOPmM7d8CJVrh/a7VVllWI5la2LKMIaII4VNbP0j4sCPG6SqpaY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747943899; c=relaxed/simple;
	bh=gZwB8MhJRtEe60JzpHJf12+knf2Ne87Vu2L7yyaRlAw=;
	h=Message-ID:Date:MIME-Version:To:Cc:From:Subject:Content-Type; b=jfkue7K5Ln8z8b4z63JXQYFR4gDRuYf1Sw6IcFAl1kwvXUl4I0PMYGK8c8edg64Xlo5p9d1n3HazwQf/vOMhOiosikIiUB6QCf8+g8KLIeSXvX2u3MLooPZrjisVDkMuQabFkZNTGuVrv8KvktFcd2R0Jl9krrKssV32i6Rxymo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=jWYkqZ7E; arc=none smtp.client-ip=209.85.166.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="jWYkqZ7E"
Received: by mail-il1-f170.google.com with SMTP id e9e14a558f8ab-3dc7294716cso33364535ab.2
        for <linux-block@vger.kernel.org>; Thu, 22 May 2025 12:58:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1747943895; x=1748548695; darn=vger.kernel.org;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EgJeP5+FHbRFCko8KxAI0xgC+raIxMxB16S+tU3+sf8=;
        b=jWYkqZ7E1f2BTpkHp6laaA3I8mWyVcE/+E1ebu1Mjxqcnye+ZBKMdZ2P/pBLt6l/+J
         BpBhF/osxB7ZmJfytXp1fBeGxigUCoLTDpDNy21DkBf9UQQosDEcYfEiIbpm/yeOODgN
         vN0gWMtp632TAsMsDee+l3GqoDIwUq0hKBNzuJV0lbRN7ZH5r3WjBQRohMMK+rWEjZHi
         gfka6GIiwuCXQlehZWbE5FHaN+sS8nGxicOyr9cHLwQd8+SXYzYkVuYVxcagAqAqPHB/
         pKg+ZsZlYo0JfgDfqyz1Trl3qDHp03keGUmAkNZFgoR70L74UkeO1BF1JFIp6vJ8WpBv
         CY2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747943895; x=1748548695;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=EgJeP5+FHbRFCko8KxAI0xgC+raIxMxB16S+tU3+sf8=;
        b=hLdw6/pSE5HkQaTCuiZEoMXO+NHxFFP6T1wcbtiaNfEKu987d6jXwtqGVw8ngYm585
         8Y0yhtmbF7fkM3GHycdqQQR7DK1j9yC1FZ0d5i2lbGFfpLg2SVHOOQYpoFZAh9hKvy6x
         YnPgHp01G1VEWiUg6ZzKHFj/52w+PyIjsxv2XSqiAlTpIffM01IfmCBRtRqNRj/SAivo
         xP3PhxWZG2zDmfNJedPJY8qn4eedRXNyHAXDlQO/gTS99GVKxi83/8SYSH8Cjb3uUYBj
         kA0pQ1qz0Um/Q51Klqb7+3YWTg7aGVKzSnPXdCLaF6boJnO+Kkpedo1dWpbMyFaKPKUQ
         lGlg==
X-Gm-Message-State: AOJu0YyKYLkpFXyruF0pjn7wXjYSzzrG037kZw54X78JHf9Y/5VsxdF8
	itLOcSKHjgbDaSVYSuaPMZ+ZFGA8QEY7IDE5UVi3INts6ayWjeoqCrxJDlJJiMol6vtl7R3oYjq
	aS7dA
X-Gm-Gg: ASbGnctKSoPuFgv7P8B51XSmuxje9/MUUiWJ8ftGOPA85YPUwZBSplBqzpWEvq+GM4t
	2bXUAxaRoVxstyvDt16KHOFeZRFpzTy8tLH3M7cRQXgAwDVGcT0QMnktaQDTmggRKWv0iKKZ3Nn
	rG0LbZGJhxbuzGPiOUOi9zBeZ9xRz+LdKpii7XJmfpJmUpRYkxh86bJKv3wp30rOrHXC/TJ/43A
	TjrqGjwAyYQpug0zIci6YiRxDH8bRqWtDMltd7LGDzHbl63s5nTseCoJ1SrA9/qzTOXWHGe3nyX
	oXvzRHNL/XlYlheFUpO5p4RXosXzCgWdfyMEi1pwFPO5CIzeL6nhLBVP2Q==
X-Google-Smtp-Source: AGHT+IF5X23PM5iUggcCli7OOmk0AQrDxn5osG5AqtL8HlWg0BKp2IREMYUlDcKuglCNbrUVdCmjqA==
X-Received: by 2002:a05:6e02:1527:b0:3dc:8667:3426 with SMTP id e9e14a558f8ab-3dc8667364cmr77249625ab.17.1747943895618;
        Thu, 22 May 2025 12:58:15 -0700 (PDT)
Received: from [192.168.1.116] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4fbcc3b1a96sm3336768173.51.2025.05.22.12.58.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 22 May 2025 12:58:14 -0700 (PDT)
Message-ID: <75e87d71-b83f-40b1-9f60-dc3747fc5fc0@kernel.dk>
Date: Thu, 22 May 2025 13:58:14 -0600
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
Subject: [GIT PULL] Block fixes for 6.15-final
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Linus,

Two fixes for block that should go into the 6.15 kernel release. Both
introduced in this cycle.

- Fix for a regression with setting up loop on a file system without
  ->write_iter().

- Fix for an nvme sysfs regression.

Please pull!


The following changes since commit dd24f87f65c957f30e605e44961d2fd53a44c780:

  ublk: fix dead loop when canceling io command (2025-05-15 10:53:41 -0600)

are available in the Git repository at:

  git://git.kernel.dk/linux.git tags/block-6.15-20250522

for you to fetch changes up to 115c011f5db7e5f1a1f4404a8f5b5c87a3534362:

  Merge tag 'nvme-6.15-2025-05-22' of git://git.infradead.org/nvme into block-6.15 (2025-05-22 09:25:47 -0600)

----------------------------------------------------------------
block-6.15-20250522

----------------------------------------------------------------
Christoph Hellwig (1):
      loop: don't require ->write_iter for writable files in loop_configure

Jens Axboe (1):
      Merge tag 'nvme-6.15-2025-05-22' of git://git.infradead.org/nvme into block-6.15

Nilay Shroff (1):
      nvme: avoid creating multipath sysfs group under namespace path devices

 drivers/block/loop.c      |  3 ---
 drivers/nvme/host/sysfs.c | 28 ++++++++++++++++++++++++++++
 2 files changed, 28 insertions(+), 3 deletions(-)

-- 
Jens Axboe


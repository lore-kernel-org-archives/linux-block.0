Received: from mail-io1-f51.google.com (mail-io1-f51.google.com [209.85.166.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AA5F21A10
	for <linux-block@vger.kernel.org>; Fri, 26 Jan 2024 18:27:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706293658; cv=none; b=GMtbg3AJWmiasChWM2pOAGPTqxbtVDvqoYtlkSIvqpXN64XKlHMdcyHFEEPLxUe42QJkUjJKKLQ4FU0HW7MFxLAPfjKNQ40Dp+yQQTX1fO9xZRpRK0w0LwREZMwugGcmOLDpGoh91AlE7No/Po5RkeaDVAgYa5YSBMs2XgjcAHU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706293658; c=relaxed/simple;
	bh=TssHySQoazP9bfUOr0ETgyH/h1+IqHTE7XfNsxNvHyA=;
	h=Message-ID:Date:MIME-Version:To:Cc:From:Subject:Content-Type; b=bHt6TWg96RZZAfbBew9YhlLwTdDek15zMdP4cQvgV5YmyqdETxfCNMyX7dX44742gy28mZx2gV5c/3v6O3IKju0qjYs2a5lLGc8dSUQrAdjsqd2G13AdJKlEaOCR30AabtCji8NR6L/2++JoqSiUx+ckfeOQMJFiiSEh7EM1Vrg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=ePL0/ykv; arc=none smtp.client-ip=209.85.166.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="ePL0/ykv"
Received: by mail-io1-f51.google.com with SMTP id ca18e2360f4ac-7bf3283c18dso11397239f.0
        for <linux-block@vger.kernel.org>; Fri, 26 Jan 2024 10:27:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1706293655; x=1706898455; darn=vger.kernel.org;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SGkvZhBOAA3F1x6oUVR/4q6M7jB6COdpX/cGJHtbVhs=;
        b=ePL0/ykvi0/y24MYOJfO0yciaG949mjA8smRwcYkGN5EOPWzqPf2bMPro57xvchI2/
         Qc+10EmLlCIm2l+1VKQcNdlX4yRzfTFbR6iPkbNRBCaNhFSNjCyKMfP+OfzmDYey8J8f
         5SOEsqnB1QeWRT9RgJ4wUOdk5mKf4VVoxKsEeQB9c2vOWcBVMKn2wIyOxGhuT1qb5QF3
         p4p3CGS9Hn9TqpVYuOT4hDci78jKBg+kmKGgSeuZEvqomWPNSjiU2mdyaNzQPQzmEd+a
         YhgTUGZI4MSOFmAjDdOK/7yC9CLCC4LQWKqyWRAJG14+MPTn4HH3U5X32RF5V5CYRqeH
         CiMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706293655; x=1706898455;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=SGkvZhBOAA3F1x6oUVR/4q6M7jB6COdpX/cGJHtbVhs=;
        b=BiHh9Q5MD/nCYv6Doic/3MQ0bxgpDdGFLeNJpBORkLlXGVwDKN2+rI7ZZYw3aTiIkK
         iOKdGLb/s2AEECpKsmD/0PityADJ6TnWuc+MCH1Nl9Hcw1PLvJJteTZMI4m5TMnErCbL
         mcASYlCpobrBFFiZq9tZC54QQCVZcbXB8KMXPWI1EpG2yI6CjH9UAIa8hFCN6vCUqy/s
         WubipASUDVU1HXu37EsPlmSj16y8Q66M49N4EXmwysVmIOdIU/BXJG3EVThFt95XKd8R
         v0zEj0W5/RgLVlGxV5DarAQUP4681AXWDJjOaq3ahrQs/ngOwIOWzC+jkB59PtQZXEis
         NQ/g==
X-Gm-Message-State: AOJu0YwHkBY3qGk5E7H2p5csuhsPGvn+CCjfI76zIqpaEphtjNTanPa/
	bDK238dfuTtksnfeq5A8GGsKmmTvtKiOaOjCtXTT5fzsSZojin2Ibiyb8Bd0MGSqjUz+T2Kg/+0
	L7uA=
X-Google-Smtp-Source: AGHT+IGNNfKHOWd1rxgUlKWQPtm2K5EaAiBqic67KtpVXeZbsIKixPaaJan5rgZOCRUIy9au9CCGbQ==
X-Received: by 2002:a05:6e02:1988:b0:360:2a3:7e5f with SMTP id g8-20020a056e02198800b0036002a37e5fmr299355ilf.2.1706293654980;
        Fri, 26 Jan 2024 10:27:34 -0800 (PST)
Received: from [192.168.1.116] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id bu14-20020a056e02350e00b00362b4ff5d48sm197765ilb.79.2024.01.26.10.27.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 26 Jan 2024 10:27:34 -0800 (PST)
Message-ID: <4d6d8fc5-669c-4b9e-ba54-0d72444ed1da@kernel.dk>
Date: Fri, 26 Jan 2024 11:27:33 -0700
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
Subject: [GIT PULL] Block fixes for 6.8-rc2
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Linus,

Just a few simple fixes that should go into the 6.8 kernel release:

- RCU warning fix for md (Mikulas)

- Fix for an aoe issue that lockdep rightfully complained about (Maksim)

- Fix for an error code change in partitioning that caused a regression
  with some tools (Li)

- Fix for a data direction warning with bi-direction commands
  (Christian)

Please pull!


The following changes since commit 6613476e225e090cc9aad49be7fa504e290dd33d:

  Linux 6.8-rc1 (2024-01-21 14:11:32 -0800)

are available in the Git repository at:

  git://git.kernel.dk/linux.git tags/block-6.8-2024-01-26

for you to fetch changes up to 5af2c3f44e004b5618ebef34ac30bd3511babb27:

  Merge tag 'md-6.8-20240126' of https://git.kernel.org/pub/scm/linux/kernel/git/song/md into block-6.8 (2024-01-25 17:03:54 -0700)

----------------------------------------------------------------
block-6.8-2024-01-26

----------------------------------------------------------------
Christian A. Ehrhardt (1):
      block: Fix WARNING in _copy_from_iter

Jens Axboe (1):
      Merge tag 'md-6.8-20240126' of https://git.kernel.org/pub/scm/linux/kernel/git/song/md into block-6.8

Li Lingfeng (1):
      block: Move checking GENHD_FL_NO_PART to bdev_add_partition()

Maksim Kiselev (1):
      aoe: avoid potential deadlock at set_capacity

Mikulas Patocka (1):
      md: fix a suspicious RCU usage warning

 block/blk-map.c            | 13 ++++++++++---
 block/ioctl.c              |  2 --
 block/partitions/core.c    |  5 +++++
 drivers/block/aoe/aoeblk.c |  5 ++++-
 drivers/md/raid1.c         |  2 +-
 5 files changed, 20 insertions(+), 7 deletions(-)

-- 
Jens Axboe


Received: from mail-io1-f48.google.com (mail-io1-f48.google.com [209.85.166.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B13AB188A22
	for <linux-block@vger.kernel.org>; Fri, 23 Aug 2024 15:11:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724425908; cv=none; b=qvlEj9nU1IQqsNraBwbqCKXpmabPMkieEzSZzN3hdLTTNF8F2zlXy0Hxkzty798GaIdo2gp016ITFc2tVPPDL3e/GfBmXGeERrAntDLVScGKSwlCiv10K676rEzpunCtNYAjDvUT7whdxG82IDSggkZgSIvvPblaZTnR/gMCWFA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724425908; c=relaxed/simple;
	bh=/5UoJ7a51NKn/Gy/v6AXTJgYThVdCEQims3fVopnUPk=;
	h=Message-ID:Date:MIME-Version:To:Cc:From:Subject:Content-Type; b=T3OaoTgWxwhCTfG6iyhF8ahFeLUblxChoIcPd84dbuGBvDzsLkjvVBiSEOxmoqidy6VW18m0z2tJ8XR72doxTpM696a8Seo0mcdJModG5JOCYVcyQu/u8pmbCSXOSOPK/N/HnrCDTuKJ5cvHGgpI+JyE3yTCqbCMeNC+B2SU2xs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=P1BGUcKL; arc=none smtp.client-ip=209.85.166.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="P1BGUcKL"
Received: by mail-io1-f48.google.com with SMTP id ca18e2360f4ac-81f96eaa02aso117059939f.2
        for <linux-block@vger.kernel.org>; Fri, 23 Aug 2024 08:11:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1724425906; x=1725030706; darn=vger.kernel.org;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aKVn2JpymVfeZzhR9ZvEns4Pd0QYr9G0LckoRQfu6dw=;
        b=P1BGUcKLgaDoKaMnWeFKvWIH2p4XVbngJH9TKFTIBRMKpZOf5YUwjiXRP4SFplRLU5
         KMTQXM9epieUyhkyKGotOOJ7h5BxlI1hrGi0PyBSyLY7HWDIru/i108yE9BeFK6axHuG
         XbUPicxvek81tu/xRO4qVAMlpv4QWju9I0101S6Ca9xotwMiHjf8cvMkZPk7r3nkx7fw
         9zPp1AkuB4dXjZCJNPwE5BobRpju0ohiqQPz0A6xBwbj8OpX4PJijxo9mez2oW3RCQt+
         1fqVAL3mu02EMQ6fP4aVVp9i2Xvf6VbT12HN/kn2PRCjrLPim7ZrpCF8G4jjUO/qVM//
         n9AA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724425906; x=1725030706;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=aKVn2JpymVfeZzhR9ZvEns4Pd0QYr9G0LckoRQfu6dw=;
        b=niQ18FEoq760hLAA9H0IOfyCWydqUOqRwVhfvomerUMx+iCzgESJ/Lsng1hY/h/U5Q
         t3Yuuc8/deQJrW08FkWJTAFRT2LfKHvVR69FMRRSPsaOYzI5MjNjlrqGBCKwlTApYGhc
         7M/2jhzNz7YmgPnwkcVt8UwSznT+pEfAkNLZjTlSXl7UZEr6KcyGdZnlEYMHakE1SVAo
         fpIsay2y8hUN7yV6mVLESXJ6dtNxvf0DfGwl7lpDiby5LqHFn+tK3RUK5eKxPKjWF8gj
         X6W4wgXYHkhNgGgysamuHfJAfy8LvkNfHLJUKl386Hd8kLfSK6TGa08NGOgnKQckSI43
         KiBw==
X-Gm-Message-State: AOJu0Yza6y9mkDiI4kuozxIT2bz5axAkvbRIxQLZfuPkKEleZTPu+bIV
	2lb7TM3uTkg50DK1zQeHuZvZHoF31t0Ij291P7/rWm3JbC6r8eL2sUXcs1knmfE=
X-Google-Smtp-Source: AGHT+IHUzLOWFh1SVC/wI3WqUR6S7TP5xo9DKXWtd6lWiMfJP2pRW2Q2hd/HPVwOZ2B7dsuH9Vfh2g==
X-Received: by 2002:a6b:d206:0:b0:825:2c2c:bd8f with SMTP id ca18e2360f4ac-8278736184cmr291775939f.14.1724425905692;
        Fri, 23 Aug 2024 08:11:45 -0700 (PDT)
Received: from [192.168.1.116] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4ce70f5caccsm970873173.67.2024.08.23.08.11.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 23 Aug 2024 08:11:45 -0700 (PDT)
Message-ID: <05edba4c-e219-46b9-8bb9-c4d71f859869@kernel.dk>
Date: Fri, 23 Aug 2024 09:11:45 -0600
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
Subject: [GIT PULL] Block fixes for 6.11-rc5
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Linus,

Some block fixes that should go into the 6.11 kernel release:

- NVMe pull request via Keith
	- Remove unused struct field (Nilay)
	- Fix fabrics keep-alive teardown order (Ming)

- Write zeroes fixes (John)

Please pull!


The following changes since commit b313a8c835516bdda85025500be866ac8a74e022:

  block: Fix lockdep warning in blk_mq_mark_tag_wait (2024-08-15 19:25:03 -0600)

are available in the Git repository at:

  git://git.kernel.dk/linux.git tags/block-6.11-20240823

for you to fetch changes up to e6b09a173870720e4d4c6fd755803970015ac043:

  Merge tag 'nvme-6.11-2024-08-22' of git://git.infradead.org/nvme into block-6.11 (2024-08-22 16:20:24 -0600)

----------------------------------------------------------------
block-6.11-20240823

----------------------------------------------------------------
Jens Axboe (1):
      Merge tag 'nvme-6.11-2024-08-22' of git://git.infradead.org/nvme into block-6.11

John Garry (2):
      block: Read max write zeroes once for __blkdev_issue_write_zeroes()
      block: Drop NULL check in bdev_write_zeroes_sectors()

Ming Lei (1):
      nvme: move stopping keep-alive into nvme_uninit_ctrl()

Nilay Shroff (1):
      nvme: Remove unused field

 block/blk-lib.c          | 25 ++++++++++++++++++-------
 drivers/nvme/host/core.c |  2 +-
 drivers/nvme/host/nvme.h |  1 -
 include/linux/blkdev.h   |  7 +------
 4 files changed, 20 insertions(+), 15 deletions(-)

-- 
Jens Axboe


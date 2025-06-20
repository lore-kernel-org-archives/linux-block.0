Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC3721E0E0B
	for <linux-block@vger.kernel.org>; Fri, 20 Jun 2025 03:55:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750391739; cv=none; b=V8ZPQpu+szyneBPdGse4gohdXaJjhxCXoImcwVPA0kQMfNnJnu0651aBqQSaJEXGNPfb2ua3GhvySDwKOlaD8YHMspkc2xCmUi/ukhL5IcxGXvbH9Ugh0tETi3sGIx6mPvOmwnatSe9CRjlZ1O24O5h/oNo5rKyyTOqCDxY9tgI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750391739; c=relaxed/simple;
	bh=rCU1mN2vICb2b3rWuK89l0AZv5Hkf5xOFkqO0Ea0/Ko=;
	h=Message-ID:Date:MIME-Version:To:Cc:From:Subject:Content-Type; b=UOZGw8nBbq5WvGdZvgmgwz27+gfcqlHy2D+yOkAdgUpUbVE3gG/O5fr2WwTWfeIAl6jDg8pgWGDIetCG2TW4Rp7DkZ6gHNVMhll+rJB9N3/MJZuZarXNCCE2oeORjf/JqUlFAjTzh7TkG6ezCCv1qihD49MoZaFOoXLPD34ryCc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=1McUUiPi; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="1McUUiPi"
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-235a3dd4f0dso8609265ad.0
        for <linux-block@vger.kernel.org>; Thu, 19 Jun 2025 20:55:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1750391736; x=1750996536; darn=vger.kernel.org;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=niFqmKVrQ0ECb/xK7vWbFCMZOG6VwB9/fcSUYAnx/Lo=;
        b=1McUUiPiWy1CrFx8hDot45VO9IKoErojR9NwlyFYzIjA2O2LwcSifnry5400g6bG95
         yA+VvawFpkMl0YOscwikcSUgQ7VE8b9ULieuDS202WJ8avpZ86vHbMMalj2ONfCmgNe2
         mOc5UD3G1kvKGsao6/h24pgyciMGHNwH8QU6HCyBe2xnPvJcfRvPLUYJCBCSSHKklC2s
         ZQ+T1lryunDrh0u2CyeR1mwnnsqapLCqGrckdxtH+zvpf/3hfqnr8euwYOjVNcNDl4eI
         3PsdTOGDwIdK8dKnKnDUstZcUzt8Csx38AHL8j2PU+h/7g85U2I9fnwDf7mhQDwTx2ws
         BP3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750391736; x=1750996536;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=niFqmKVrQ0ECb/xK7vWbFCMZOG6VwB9/fcSUYAnx/Lo=;
        b=ZRYyHiYC1nNq/YzwiL/LH97mpCe+j3da90ehx+J0XoO4sofLzVH6xesyc3+qqfN1Tf
         eiqxfadOQP0tyQQHiGLUvrwv5b6H4JihpXRlAnmhs8Gmc/fLtPeVhzrRe6tZSAnABi6f
         MGV0D2srs7weSCXh4gmUDu+Gkg/T7M9bj614Ph+5S4J5usV6wVfJUwrHSMUbbK8Km5vS
         D1GA904bpBDI2Hhvj++Ee9t1X0LXEPZUF/IfQ/yFFF1fgIUhfE/WHYEfVYOaJqsrzul8
         Wtkl3exfJtL/IroSc9O8Qv/5vrlao7uZ+9qW9rkyuCjgXvB6gd9fRZXLPceJE8zmfWqp
         GjuQ==
X-Gm-Message-State: AOJu0Yxt6CoT50FLWvLDa3jDu8bN+BEUwIrCE+zHTZpbzZyltRY0YVto
	DuZeZLorhma+h6flGzl0Huh5dkDmgVGaCgQwXIyixxzm74E6/1Nu+Tit8XS4mh45HudGYWREt+C
	sy/Sm
X-Gm-Gg: ASbGncsIf4+De3m09f7Ruoon8rWRpGJGzyVZPyoGlWWggdLyaDoDK1tpaMQQjmdHio6
	o32u2m2fmqp2/kUWKOrzDJFi2x0hipabPm/T5TOVS+aS3yuaZJFIb3dZA/yVCS3Qcm8dgYorrZX
	PCAs7l4JpCLxZmEBvZjmjJPdiQ0w7InnND8BCZq28cMFg02dnPaPRjAzBdIeagn9Ww7XPhme1YZ
	cZYxPkggkz3QaOfxcNCHeLi8ummntYUqSC82OxZC8RTmsMt7riBsgRYr8UGtY5CiZfnm9DGBWw+
	ftMawcUSkU1W4W7UGvRUHf0nHrK+Bgr0AWgXp2N52TOV4904S5ig4UsdRcKtPziUi3dsTy9nagr
	iK8aWj35Lp0NdxL+G6fYitXBu03yYElPOM3AcReM=
X-Google-Smtp-Source: AGHT+IFksuVtBRMMme8ykW5/EtJ8j63YB3MKeiECXmgSey9VeI5AwUcaGM7mWrZeCIi2aQlTdy4UjQ==
X-Received: by 2002:a17:903:11c4:b0:235:f45f:ed49 with SMTP id d9443c01a7336-237d986fc49mr22614695ad.33.1750391735990;
        Thu, 19 Jun 2025 20:55:35 -0700 (PDT)
Received: from [192.168.11.150] (157-131-30-234.fiber.static.sonic.net. [157.131.30.234])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3158a318733sm3147318a91.38.2025.06.19.20.55.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 19 Jun 2025 20:55:35 -0700 (PDT)
Message-ID: <e61a5bf9-4f23-46c2-89c9-a0567f92df94@kernel.dk>
Date: Thu, 19 Jun 2025 21:55:34 -0600
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
Subject: [GIT PULL] Block fixes for 6.16-rc3
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Linus,

Set of fixes for block that should go into the 6.16-rc3 kernel release.
This pull request contains:

- Two fixes for aoe which fixes issues dating back to when this driver
  was converted to blk-mq.

- Fix for ublk, checking for valid queue depth and count values before
  setting up a device.

Please pull!


The following changes since commit 9ce6c9875f3e995be5fd720b65835291f8a609b1:

  nvme: always punt polled uring_cmd end_io work to task_work (2025-06-13 15:18:34 -0600)

are available in the Git repository at:

  git://git.kernel.dk/linux.git tags/block-6.16-20250619

for you to fetch changes up to 8c8472855884355caf3d8e0c50adf825f83454b2:

  ublk: santizize the arguments from userspace when adding a device (2025-06-19 07:53:24 -0600)

----------------------------------------------------------------
block-6.16-20250619

----------------------------------------------------------------
Justin Sanders (2):
      aoe: clean device rq_list in aoedev_downdev()
      aoe: defer rexmit timer downdev work to workqueue

Ronnie Sahlberg (1):
      ublk: santizize the arguments from userspace when adding a device

 drivers/block/aoe/aoe.h    |  1 +
 drivers/block/aoe/aoecmd.c |  8 ++++++--
 drivers/block/aoe/aoedev.c | 13 ++++++++++++-
 drivers/block/ublk_drv.c   |  3 +++
 4 files changed, 22 insertions(+), 3 deletions(-)

-- 
Jens Axboe


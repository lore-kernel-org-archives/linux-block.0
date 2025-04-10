Received: from mail-io1-f44.google.com (mail-io1-f44.google.com [209.85.166.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37FDE2857CE
	for <linux-block@vger.kernel.org>; Thu, 10 Apr 2025 13:26:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744291604; cv=none; b=nm2IF1j8soLkFwt/B29Rj+U3383g4GVWLUvJNpt/+n2kkOG6cplPEK+ypWgS4tLsCd4elH503I6dU9qPVO2VDorHlQKc3LU95KROmI2zmnipGWV+ll6zyMuPaECaDZiizN98y26wOLqA2z0yaIKY1JJXMUuFi104vKMT5nzJAsc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744291604; c=relaxed/simple;
	bh=zwbrBD5KQlijoV4ev9+McY9FXPr68czUUJIzYOBP6EA=;
	h=Message-ID:Date:MIME-Version:To:Cc:From:Subject:Content-Type; b=tFMyChn0Git8yq7fhnGICNvRz56FqMgF2JkTo5bSL+o2ia2ZQb/+xf0NfVawim4wwr4+nuPXaL65z6EIh8IvFCRuOx9S/MvI8UYO9l0HYHzeSIepMo8k78Ou+nkBH9oZkHT9NstL4/Hi2tUKON8mKUW7Bbz3+k8ywIpVOhITy+0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=XlMOZs/p; arc=none smtp.client-ip=209.85.166.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="XlMOZs/p"
Received: by mail-io1-f44.google.com with SMTP id ca18e2360f4ac-85b3f92c8f8so82135939f.1
        for <linux-block@vger.kernel.org>; Thu, 10 Apr 2025 06:26:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1744291601; x=1744896401; darn=vger.kernel.org;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qHXMwPPE0RfllucupJw94GBV5BHuAhKkX3l6/FCtzRQ=;
        b=XlMOZs/pZ1Xeu+RiC/MU+YNSdjk4nsvvy7xujZQIaroP61hUEwkPhEbCPEqaetibu/
         3fCypJ7rgQ7nVclCNo4w0AyA98J7SYjZXcuHbAgr5hMOpF+kYHWU160RkLJZ+mSLSiJS
         uxkiQrvKLKy3ptuYpIwpGZ6xM+uOhR7sz8puPjphxVjMP/iU2bvF9F29Hxr7JpnB1CjH
         iDIQ+WIPgw0Lkp6wu/M4B1+YltKtU0/R1kZsMqpd7062KKSrF4KSeY2hWORYWish/NR4
         tBjAGFK+GCsrCFOrz1yxJk+ydp8zvsz1FS1uc1LI9rzWXr109QGP7GfMJlsh3lkufFF5
         HdoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744291601; x=1744896401;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=qHXMwPPE0RfllucupJw94GBV5BHuAhKkX3l6/FCtzRQ=;
        b=Nxxvapqxm9bOg+2rp7/p0dKaCxuKuXMZuaow6heiNBuaJPSxy801EvjhcPDixPvp40
         Egr94cjxW+yTTbq64Jg10zdrStL51+f4HSBe4DeCeyKn9/hiU8ZC05VGjEUtrw0/EhvB
         526j50mu3J/PXmII+3Jf4F7FelpG5/uw7oD33xQsy5RQcJHGqWQa/0sSs2rFmU4Z7CF5
         6G8uMvMNXik2UPVFsfQlCbsIlYqZY0hwxQH1OGeQu+NjXnkLT2lPTB1LvfKetfSBHwYn
         GigACesFg3yzp+NQDiUj6f8/3kkWu1WTv11Mz7o2vflJdocY4k1XJTSo8q9ji5Q8Q+Es
         cMcQ==
X-Gm-Message-State: AOJu0YxpEkNm4kQ5hyfa+Wt1PAARb/stro9n/Afd985ZVD+D31ZGUlJu
	o99ph58x5mMeCJu/Xq5ZBEkk+PaYqXCvreVBICDqv9IJOeg1Tek/n0Vr9zZvpZPFp/DxvHJmDyL
	q
X-Gm-Gg: ASbGnctgMkzvHC6WHzuknEpYcfdWmDGbzQCkPlQDc281/DH4ZG4sc9kSNY+pzAsmrRv
	mYjRL3sj78G8R1xCa5IslBe5ZjMB/7jKnrLMoEBXinPxhaDhKYQICahXAAtq5btWGy/Ga4933co
	QMNkvrLZhN+XKU+pVOlqhOmceuIXnsH7XT4qoKjzGf2rHHAUeVMgQDf5rwvcwZ4BWvz8tbEvrJQ
	WtAExha1S+p9VaStTGXQ4gG0EK3OfaY/3LDW7P9DRP+QpANWQt6luy7nYiHaMnN2Wa7z9LGocZu
	RxUDa9TXcV5AIOutQMzOzLel22lTUuWr2Zy3
X-Google-Smtp-Source: AGHT+IGxav0h3on0TD5TcE/e910nroasZdJaipiR2TBzQGejjWSz+M5kdOgqLjY/AJgp5/oyT5/7lw==
X-Received: by 2002:a05:6602:3798:b0:85b:58b0:7ac9 with SMTP id ca18e2360f4ac-8616ee22690mr282676539f.10.1744291601233;
        Thu, 10 Apr 2025 06:26:41 -0700 (PDT)
Received: from [192.168.1.116] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4f505d18887sm751804173.57.2025.04.10.06.26.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 10 Apr 2025 06:26:40 -0700 (PDT)
Message-ID: <d33ce0e7-23e6-423e-9c5d-0899d99515b4@kernel.dk>
Date: Thu, 10 Apr 2025 07:26:40 -0600
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
Subject: [GIT PULL] Block fixes for 6.15-rc2
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Linus,

A few fixes/cleanups for block that should go into the 6.15 kernel
release. This pull request contains:

- Add a missing ublk selftest script, from test additions added last
  week.

- Two fixes for ublk error recovery and reissue.

- Cleanup of ublk argument passing.

Please pull!


The following changes since commit 06a22366d6a11ca8ed03c738171822ac9b714cfd:

  Merge tag 'v6.15rc-part2-ksmbd-server-fixes' of git://git.samba.org/ksmbd (2025-04-03 16:18:06 -0700)

are available in the Git repository at:

  git://git.kernel.dk/linux.git tags/block-6.15-20250410

for you to fetch changes up to 843c6cec1af85f05971b7baf3704801895e77d76:

  ublk: pass ublksrv_ctrl_cmd * instead of io_uring_cmd * (2025-04-09 07:58:04 -0600)

----------------------------------------------------------------
block-6.15-20250410

----------------------------------------------------------------
Caleb Sander Mateos (1):
      ublk: pass ublksrv_ctrl_cmd * instead of io_uring_cmd *

Ming Lei (3):
      selftests: ublk: fix test_stripe_04
      ublk: fix handling recovery & reissue in ublk_abort_queue()
      ublk: don't fail request for recovery & reissue in case of ubq->canceling

 drivers/block/ublk_drv.c                       | 85 +++++++++++++++-----------
 tools/testing/selftests/ublk/test_stripe_04.sh | 24 ++++++++
 2 files changed, 74 insertions(+), 35 deletions(-)
 create mode 100755 tools/testing/selftests/ublk/test_stripe_04.sh

-- 
Jens Axboe


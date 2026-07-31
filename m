Received: from mail-oi2-f3.google.com (mail-oi2-f3.google.com [74.125.231.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B83D489880
	for <linux-block@vger.kernel.org>; Fri, 31 Jul 2026 21:44:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.231.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785534297; cv=none; b=Lql4DGDofe7rng+46FH/hH0IlX0EEzQD3ksSGEK0FDhbnmAluiiM/3wWK7GC/5GcWFKKBFfV5p76JJpXUkJxx05/eWHhjz9vlbjesPjTGvhr6KWdwRoJ0i8Muw2PXUnGxs3/8keBvSJR6oLsMs+YO7KPeWfZvO42xBOJYRpZ+04=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785534297; c=relaxed/simple;
	bh=LBsU9qSTHyxX2Zfost1BHHlNllNlzDSUvfDWS4dRymo=;
	h=Message-ID:Date:MIME-Version:To:Cc:From:Subject:Content-Type; b=BsIFTxBdsgwHW2QPeBg7mqapLDKruEfHB09jDh2Wye76/J47zPjJlPtRUw/68YkF+FSabVqNThKB/n2NvFiosw/wM+kjxog1LepY1MxHHlK/m3lHu/XBIZ6MOJHvQINU6mITEuEg0YShDMbNKWN635VOhIeIJs4CvYPosHYf1HY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20251104.gappssmtp.com header.i=@kernel-dk.20251104.gappssmtp.com header.b=cN3hvVfb; arc=none smtp.client-ip=74.125.231.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20251104.gappssmtp.com header.i=@kernel-dk.20251104.gappssmtp.com header.b="cN3hvVfb"
Received: by mail-oi2-f3.google.com with SMTP id 5614622812f47-495e3c6a1f1so556859b6e.1
        for <linux-block@vger.kernel.org>; Fri, 31 Jul 2026 14:44:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20251104.gappssmtp.com; s=20251104; t=1785534294; x=1786139094; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:subject:from:cc:to
         :content-language:user-agent:mime-version:date:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=ZR9IJnV/w7nW4x37TDhqtZ+xAcCwQ659xPH4LbW4/xs=;
        b=cN3hvVfbYevE1LpuVukE7Z5j+jRbP/z973eskatQBW73l7dd+bVVpN2tKN4A/4EkZB
         EC1roSoWeMd7wUUr3hKPCwG6IKtH1YRgzFkns0s0GVobImqH9Pl1XGZvMhTujPekpNTL
         opE7V3YpDXykzf5adsDscZASXB2L+CJXTXVm0GmaSQIyKfamr8MwwiCC5Ol8y0V+uuzs
         Fl1ICCy5/Eii7ymHrGN2Yv2oQ7SnrBR0gJ/m/8yUPoAepPb5gK2lPiXLTfv0bbveXtLc
         I8fxjth1vQQ8X1ZiAP7eskxCNKPaLGUgcQdMyE+jONbHI1bmRdWr3REp6E+WrtiA9W+4
         WeTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785534294; x=1786139094;
        h=content-transfer-encoding:content-type:subject:from:cc:to
         :content-language:user-agent:mime-version:date:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ZR9IJnV/w7nW4x37TDhqtZ+xAcCwQ659xPH4LbW4/xs=;
        b=YYPOVWjT1f7+O9GVn/npq5C1iUxA6vbWPQr0INmyY2wXD5A3+0X0hxdouHzzHa6It7
         PTfBmm+8jAr30kr9Zd848WaH1AUHPM0qce/pCfciZ0WdUf0dvaym8PibJh3LhyU4kEfO
         zxavS2neFUUkid6N9B9MQsMFZFR98eko9HHZUP5yGfvd4+Ipo6twhfgeI5vW9J38V0j9
         3jlN+VR1NwYFeA9D7zdt3KsJwa7L3EQ3yqzC0NfKkVuN8z5rU1UGWF6+FHIOSQslBcDM
         faWK95rTOTfRxEN7sCNwtGjo6rPV8ij2b0TUGMwApZ0uEcDzMGXlSJ7jhjK5G6mInxA3
         vYfQ==
X-Gm-Message-State: AOJu0YyLHWDILI7cQzum0R4pGSfgeFrT0b8Zx/uNMaFzajVkS+z+I2B7
	DIICUweBncxTAjkwwbfqt8yDaeEf3BkxrFiL5HHWCyQmlEsi3tRcOkHdo7mcxQS0Ed/x/WJkFR4
	2vekyloym3Ai+
X-Gm-Gg: AR+sD11JIxTmOG9KMlqATC7WxDJDdXuGslqDzGJxQfZtjHv1Lmg1r4KAYEMMvLRdhII
	1qyeMc7KzxnDctIhI34j2fXqwRNmX/5Id14jevPKLBaeuqBGeIfX31+iFF1ytx73b++3+LBHpnt
	X1/OFTsZJ2JF1Ie/SZZb04KU/zVGQHg6A4BNAopENLPASEQs9ZVCSATj7WwtGl1yjmeHK3a9z6C
	/dMAnlXwwrP1Zy3jh2cZz5FAznXGf4bNqJQqWdT8kA3Kpb1+/lJv0+Avh2IA1dJ0TrMmVJOijq3
	Suj90k2mJGey750Ekn3Yse4/r6cK29SigrOF/NqpW6ZOBeUP0s8czhFa2/NgRhaiuDSaa2pDQ5O
	+AFn0yTuBcih8b6TVuD7fOMzIhqAyWDIQ+ZdYpvdFY3IBwkjfQq1oKHADqDJ3S7EnepRr8rUwaZ
	RlgPttKJenb/t+OM9kWXVit5XhKauuG3NdMDp34q5HnLoexXPOyXKXWuqnq1XyYJhTbbTd52N7L
	VVUMGP3FISebzNxy/bsRV35wg5kctfHeVEK64PWaU2DTQ==
X-Received: by 2002:a05:6808:4481:b0:492:8920:81ca with SMTP id 5614622812f47-4af5e031e79mr3580701b6e.5.1785534294253;
        Fri, 31 Jul 2026 14:44:54 -0700 (PDT)
Received: from [192.168.1.102] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-4af58ce0a1bsm1570693b6e.2.2026.07.31.14.44.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 31 Jul 2026 14:44:53 -0700 (PDT)
Message-ID: <8a90f8b1-1b86-4fb5-aa5a-8d292aec8e70@kernel.dk>
Date: Fri, 31 Jul 2026 15:44:52 -0600
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
Subject: [GIT PULL] Block fixes for 7.2-rc6
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Linus,

A few fixes for block that should go into this release. This pull
request contains:

- Set of fixes for s390/dasd, via Stefan.

- Fix for a missing stop of the timeout timer, if a disk has never been
  added.

- Clear kernel owned fields on ublk setup by default.

Please pull!


The following changes since commit 093fbffe03f5c1bb9c10a9e5aa65b23250844403:

  MAINTAINERS: update my email address (2026-07-21 06:24:43 -0600)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/axboe/linux.git tags/block-7.2-20260731

for you to fetch changes up to 7f40b346462f563a0d6e841a77b5163d2a882a04:

  s390/dasd: Fix undersized format-check buffer (2026-07-31 08:28:08 -0600)

----------------------------------------------------------------
block-7.2-20260731

----------------------------------------------------------------
Chao Shi (1):
      block: stop the timeout timer when releasing a never added disk

Jan Höppner (1):
      s390/dasd: Fix potential NULL pointer dereference

Ming Lei (1):
      ublk: reset kernel-owned dev_info fields in ublk_ctrl_add_dev()

Stefan Haberland (2):
      s390/dasd: Fix path verification interrupted by concurrent dasd_sleep_on_immediatly
      s390/dasd: Fix undersized format-check buffer

 block/genhd.c                   | 12 ++++++++----
 drivers/block/ublk_drv.c        |  9 +++++++++
 drivers/s390/block/dasd.c       | 14 +++++++++++++-
 drivers/s390/block/dasd_eckd.c  | 11 +++++++----
 drivers/s390/block/dasd_ioctl.c |  2 +-
 5 files changed, 38 insertions(+), 10 deletions(-)

-- 
Jens Axboe


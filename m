Received: from mail-pg1-f175.google.com (mail-pg1-f175.google.com [209.85.215.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA1CD1CDA0F
	for <linux-block@vger.kernel.org>; Fri,  1 Nov 2024 18:12:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730484732; cv=none; b=YG+CoMXyFbMeCbrDwRWsVj9sJFI2kkRVvLZrnzfsnrye5cBFs6Inz6EAmWKirQXIQO+66oNH5U+oCTiOJ3VMQFeuTMCT36oEZX/hkKXqh0t4+2E2ZkbZZv69S2gBJRm0P3KN5icaO29mRVXhfJ2jCMnZDKSp6Lw3bmci6XcXXQc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730484732; c=relaxed/simple;
	bh=8OFnClMOLuCkbg7EgguxwKcpDE8E3Y+j3c7j4iNuVGw=;
	h=Message-ID:Date:MIME-Version:To:Cc:From:Subject:Content-Type; b=u0+HfpHIeOhd6Z5k526tcrYd/BOvOph2b3z1tE59p9V6j7Im8EWOxWzNthCBLHWhWB9GMBssF+LeNxxx0VAvOGsMdK4T2yMuW21O54snJ7S8b+KRXG2Sppp50csxMynpzlGUNLOrMGa2LJD34mVTxI6WVmJa4upODrQouUUsaFs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=dBDjnvbZ; arc=none smtp.client-ip=209.85.215.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="dBDjnvbZ"
Received: by mail-pg1-f175.google.com with SMTP id 41be03b00d2f7-7eae96e6624so1721015a12.2
        for <linux-block@vger.kernel.org>; Fri, 01 Nov 2024 11:12:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1730484730; x=1731089530; darn=vger.kernel.org;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=d2pMutuKMwNelqHlEPwtSSsX2VzPk7ZhscxhiYniPG0=;
        b=dBDjnvbZpsLc2RlMOB3bV/D2EjMHsQpCRb5nV2y9jfP/z1gNQr8GwEuKkZVx9dINE5
         vg7Vq1Is67p2/Zn1twYwXTnNHpug/wprnxHfQXl+zZBhSCxXpCy/u9bkJ3F4PhihhRBk
         Wul+No0euiSoYJrMAwSjsLEIz9FGK9+KsLaE4yfeJAijFAAP5NRaZTULDbDhzbN3w0z+
         hlPH0J61yl2NBpiWI7TIhhiOg4A4KfjFrKYpWwVcMoYdnu+ZkfuPb7tSWjkvt2N4sTwo
         C0S7I8dTWj7eFkNcEiIaz+qWj0mGP4PjjLb0loW2AmVSpKfS4Sh+Jte+CEFk9wh+Wznp
         vcJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730484730; x=1731089530;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=d2pMutuKMwNelqHlEPwtSSsX2VzPk7ZhscxhiYniPG0=;
        b=P3BvgflWErcTMC1Eu0m5xwPIMV5Rw4Drh4WDpSS44gPafou0gqLcLXbFN4wutaBFp8
         0lOxYU6JOuYkvsvfWP0ZHuwjAvRfzOIS65iOVej3hPHxutXG8BwMfEJLW08fo1VIDZ/l
         pMQE4m+ubjQy30A44QKUX2Muds7I9/VeK0fO/jFu3biJEF9/9kov5qcoz3Ni59i62QO2
         5G8OyL5ArbwXa2eqWJ1jqLkkf5b2rPShi9dRKfd2bYhbLywLfQxPondBRgvxToKljO1o
         IUU5+67aeFQuBgFnlNuXr0UZnc8eVc+McRwRcTzReabhL8Y6ctStJahTe42RvrT7HNra
         RVPg==
X-Gm-Message-State: AOJu0YysiGvL7iTcQ4t2RQSrJDr8b9uc2v+6RnThm9JrzbhVSQkBOzlc
	B0aWX9lGlWYqWMdvB/CEWrhr8Bc+No5f92f8Y6Z7EU4dF5M9youBUClGLP0bfaJg4uEOUVci4HS
	kyRg=
X-Google-Smtp-Source: AGHT+IEluut+AEoPWYm1PPT/MhkeLQzqzFhbhyFv2z75L6JqOhJ881Vwvo54wxwPuxCeG6OHpnODHg==
X-Received: by 2002:a17:90a:ce87:b0:2e2:e31a:220e with SMTP id 98e67ed59e1d1-2e8f104c92emr24270578a91.8.1730484730001;
        Fri, 01 Nov 2024 11:12:10 -0700 (PDT)
Received: from [192.168.1.150] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-211056efbd5sm24075355ad.2.2024.11.01.11.12.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 01 Nov 2024 11:12:09 -0700 (PDT)
Message-ID: <89bedd77-813e-4b5d-9ee6-87c97bd9b3ba@kernel.dk>
Date: Fri, 1 Nov 2024 12:12:08 -0600
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
Subject: [GIT PULL] Block fixes for 6.12-rc6
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Linus,

A few fixes for the 6.12-rc6 kernel release:

- Fixup for a recent blk_rq_map_user_bvec() patch

- NVMe pull request via Keith
	- Spec compliant identification fix (Keith)
	- Module parameter to enable backward compatibility on unusual
	  namespace formats (Keith)
	- Target double free fix when using keys (Vitaliy)
	- Passthrough command error handling fix (Keith)

Please pull!


The following changes since commit 2ff949441802a8d076d9013c7761f63e8ae5a9bd:

  block: fix sanity checks in blk_rq_map_user_bvec (2024-10-23 17:02:48 -0600)

are available in the Git repository at:

  git://git.kernel.dk/linux.git tags/block-6.12-20241101

for you to fetch changes up to d0c6cc6c6a6164a853e86206309b5a5bc5e3e72b:

  Merge tag 'nvme-6.12-2024-10-31' of git://git.infradead.org/nvme into block-6.12 (2024-10-31 09:10:07 -0600)

----------------------------------------------------------------
block-6.12-20241101

----------------------------------------------------------------
Christoph Hellwig (1):
      block: fix queue limits checks in blk_rq_map_user_bvec for real

Jens Axboe (1):
      Merge tag 'nvme-6.12-2024-10-31' of git://git.infradead.org/nvme into block-6.12

Keith Busch (3):
      nvme: enhance cns version checking
      nvme: module parameter to disable pi with offsets
      nvme: re-fix error-handling for io_uring nvme-passthrough

Vitaliy Shevtsov (1):
      nvmet-auth: assign dh_key to NULL after kfree_sensitive

 block/blk-map.c            | 56 ++++++++++++++--------------------------------
 drivers/nvme/host/core.c   | 56 ++++++++++++++++++++++++++++++++++------------
 drivers/nvme/host/ioctl.c  |  7 ++++--
 drivers/nvme/target/auth.c |  1 +
 4 files changed, 65 insertions(+), 55 deletions(-)

-- 
Jens Axboe


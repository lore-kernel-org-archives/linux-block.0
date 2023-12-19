Received: from mail-qk1-f174.google.com (mail-qk1-f174.google.com [209.85.222.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD1BE38DEE
	for <linux-block@vger.kernel.org>; Tue, 19 Dec 2023 19:02:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Received: by mail-qk1-f174.google.com with SMTP id af79cd13be357-78106c385a1so45316585a.0
        for <linux-block@vger.kernel.org>; Tue, 19 Dec 2023 11:02:44 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703012564; x=1703617364;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=x4iCHu487DrUvkwW6bG9cAsMRconccXVIOvhrOrRamE=;
        b=OmC3wf4FQvnx0BAucbBCaC6og957EvK4n8A7cJHL8X6+FOBg0TxRtkRvPHxslwAfWe
         enUjMGEFSQFDawaICWqPMlFZwfFPSjnF7qlCucfqqsaxct5Da7Ly0DXpum67dwBID8lm
         5NFH6/8Rkd/cFiR6ZFQVixG4U1a5hkaPrdUDpreh7tfs3G2JUWEvKfOpBsQUm8Ngx7Qv
         pkZKMHSqUm4Osqkx/8mczdd5QVQv24OE8ilD2dmHezhHPg6qmbCXrtSTKkveS7krA63C
         VHQQvB+g5YbQtri/94qQ7n3SUL9TcFR/7WTnRDueR67uvWl8NKQwy5bM9h34gMbb64Hg
         7LLA==
X-Gm-Message-State: AOJu0Yxf6od39UCEDMl3JkNtf2tiVlWWcssA5NvTn0DPPsRze8kC2a3t
	PEuFO2okvFrhLwWklHtdj30i5WWBPiydbFGigQ==
X-Google-Smtp-Source: AGHT+IG9HWuvBqo/LN1xgysZ5IfSprn2G/Wkcrdw7arTHCTtSwMWMGoZI0pqDH4Ty8cDdzKUNekXKg==
X-Received: by 2002:a05:620a:146d:b0:77f:878:b58 with SMTP id j13-20020a05620a146d00b0077f08780b58mr22105537qkl.153.1703012563855;
        Tue, 19 Dec 2023 11:02:43 -0800 (PST)
Received: from localhost (pool-68-160-141-91.bstnma.fios.verizon.net. [68.160.141.91])
        by smtp.gmail.com with ESMTPSA id i10-20020a05620a248a00b007810854dd46sm380970qkn.61.2023.12.19.11.02.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Dec 2023 11:02:43 -0800 (PST)
Date: Tue, 19 Dec 2023 14:02:42 -0500
From: Mike Snitzer <snitzer@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: dm-devel@lists.linux.dev, linux-block@vger.kernel.org,
	Alasdair G Kergon <agk@redhat.com>,
	Benjamin Marzinski <bmarzins@redhat.com>,
	Mikulas Patocka <mpatocka@redhat.com>, Yu Kuai <yukuai3@huawei.com>
Subject: [git pull] device mapper fixes for 6.7-rc7
Message-ID: <ZYHo0kWJ/abSbCRF@redhat.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Linus,

The following changes since commit ceb6a6f023fd3e8b07761ed900352ef574010bcb:

  Linux 6.7-rc6 (2023-12-17 15:19:28 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/device-mapper/linux-dm.git tags/dm-6.7/dm-fixes-3

for you to fetch changes up to 5d6f447b07d5432686ba69183af6e96ac58069c9:

  MAINTAINERS: remove stale info for DEVICE-MAPPER (2023-12-18 13:11:05 -0500)

Please pull, thanks.
Mike

----------------------------------------------------------------
- DM raid target (and MD raid) fix for reconfig_mutex MD deadlock that
  should have been merged along with recent v6.7-rc6 MD fixes (see MD
  related commits: f2d87a759f68^..b39113349de6)

- DM integrity target fix to avoid modifying immutable biovec in the
  integrity_metadata() edge case where kmalloc fails.

- Fix drivers/md/Kconfig so DM_AUDIT depends on BLK_DEV_DM.

- Update DM entry in MAINTAINERS to remove stale info.
-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEJfWUX4UqZ4x1O2wixSPxCi2dA1oFAmWB5+4ACgkQxSPxCi2d
A1oNCQf9GsB0h6BzCXNR334yz82N6dBCVD6FvOUaBY0oUFC8Fsb4x3uI6X7U6isz
7+ZdFvxXq2DWYctUdW9UnEG6O04dJkswdFh2xUGN09GBgUd14BHu/ElZsRKxhWYw
n4BmJsBrRiGKrG4Jl0KIMjxiVeQUsUWPYUb2GpZ3wXRJotXBPhOGyXBbl8KRz9zF
XLgYjtbpeSQSjlDl7Id85LB3SD7YqIG2OnxhEpVf+dGttr94+8MITbkgdzBPpKuj
e0YULwAZlvHFvTdp/9TtjaBNvKH6oPtfMmpDGQDJjqmTa+ImqM2rV2aHCTsXZAM/
1OQWqgbX9J2BeWqUUhH6iA9Xk7ra5A==
=L/z8
-----END PGP SIGNATURE-----

----------------------------------------------------------------
Mike Snitzer (2):
      dm audit: fix Kconfig so DM_AUDIT depends on BLK_DEV_DM
      MAINTAINERS: remove stale info for DEVICE-MAPPER

Mikulas Patocka (1):
      dm-integrity: don't modify bio's immutable bio_vec in integrity_metadata()

Yu Kuai (1):
      dm-raid: delay flushing event_work() after reconfig_mutex is released

 MAINTAINERS               |  2 --
 drivers/md/Kconfig        |  1 +
 drivers/md/dm-integrity.c | 11 ++++++-----
 drivers/md/dm-raid.c      |  3 +++
 drivers/md/md.c           | 11 ++++++++---
 5 files changed, 18 insertions(+), 10 deletions(-)

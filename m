Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com [209.85.160.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5C2B1CD2A
	for <linux-block@vger.kernel.org>; Tue, 21 May 2024 15:51:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716306694; cv=none; b=Haa1VmhWakUiUA9n8u5Qli4XnnnLBb+qeD72lQ66dm1Luz7lBEu4Pgukrwfh7WfI4ju7lqtafj5qF/UiWsa5XWwtqFku6qJbY9m3hR43+5NjFXYlLHQ6bouiFz1PXoiQLDf6u+Gq0NiyqL5QV+FUJ4HAxqMzkegucJI0rb7w7zI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716306694; c=relaxed/simple;
	bh=iSpfOIx0o9dbEGDiBN2NtB9eIseJUfY/7UsdMGG8muM=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=tX+r1HpFck9yI13ywJ16+e3Rs4/phBNG36WTGjLT3eIZoY2RNZYUTwMqmB0rqRvXKL8e5K5ioA4tsCAYseblzs2YqyFr9wiBoiirbQjP3+vaRMOdykJ/nLAKJ4Dusc8Mt0hYYFXpzre27B2Qe0ISebulvjqrifGPATJ+HjQFy8k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=none smtp.mailfrom=snitzer.net; arc=none smtp.client-ip=209.85.160.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=snitzer.net
Received: by mail-qt1-f178.google.com with SMTP id d75a77b69052e-43d2277d7e1so15473421cf.1
        for <linux-block@vger.kernel.org>; Tue, 21 May 2024 08:51:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716306692; x=1716911492;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3De1QFzgbPPwSmcZozXuROE2g1GOTCX6cTHGr9CUkjA=;
        b=X31k6oTVwRXC+1iNImqEZsdxdwP1xztANUec0FYqrv0E2SLIizc+MIy2G4Zq0W0Zrf
         FYyy8qE2gC55WDuYdRD4WeW0JTwvG7+ZgkxKLwu8SfZkdgwBcGYYchR2xDmqcie7Oi3b
         arpp5Ir+Dx6BzVasBVMXS7SBw94vnW4ZbZHMmgWGD7Az7uP3XlJaCQmUK/pcrfUCsQIL
         F/F8qPXk+cKthSW/nc0Ej4evsgjwOa7m3qHV5PLf/PbbkNZsX5bmDMp3y8533UYvpqyK
         tv0TciWlTLa8pmGf7V+dgkkiN84ao3eHNd1gBtdMqb/UmKWPOvWp83fpaM4LpdwoHF0B
         sFQA==
X-Forwarded-Encrypted: i=1; AJvYcCWRmHto0Do5ElRDQgBr3xzpq33d4bVFheFCFfZyXDV67I9Se49xQ0akv1Xd5zhdmXOJq06+f8nMt4+vOCpuU5jHaIbRC6MReOVr7z4=
X-Gm-Message-State: AOJu0YxrqMsxGGA/sT1X7001P+1CeIChPevTY4mFamYSXRA0SSqwD3q5
	z4PKdwkbIkVlQjW77airk7+GzMSPaC8wD/bpV+hURMGX+/0GdDQSZ6Bb6f9rtZA=
X-Google-Smtp-Source: AGHT+IHUEOPrgKJ6HbohQiTwSikK/8/E5PDHZvUKNBZxMqMWsSsJbzf+Kk/nlbrlqu6UwI3Ps6L4dQ==
X-Received: by 2002:ac8:5916:0:b0:43e:3c19:a2dd with SMTP id d75a77b69052e-43e3c19a722mr216079541cf.46.1716306691772;
        Tue, 21 May 2024 08:51:31 -0700 (PDT)
Received: from localhost (pool-68-160-141-91.bstnma.fios.verizon.net. [68.160.141.91])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-43e251233c6sm104502741cf.84.2024.05.21.08.51.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 May 2024 08:51:31 -0700 (PDT)
Date: Tue, 21 May 2024 11:51:30 -0400
From: Mike Snitzer <snitzer@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: dm-devel@lists.linux.dev, linux-block@vger.kernel.org,
	Alasdair G Kergon <agk@redhat.com>,
	Mikulas Patocka <mpatocka@redhat.com>,
	Benjamin Marzinski <bmarzins@redhat.com>,
	Christoph Hellwig <hch@lst.de>, Theodore Ts'o <tytso@mit.edu>
Subject: [git pull] device mapper fixes for 6.10-rc1
Message-ID: <ZkzDAsx_7FvmFbSX@kernel.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Linus,

The following changes since commit 8b21ac87d550acc4f6207764fed0cf6f0e3966cd:

  dm-delay: remove timer_lock (2024-05-09 09:10:58 -0400)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/device-mapper/linux-dm.git tags/for-6.10/dm-fixes

for you to fetch changes up to 825d8bbd2f32cb229c3b6653bd454832c3c20acb:

  dm: always manage discard support in terms of max_hw_discard_sectors (2024-05-20 15:51:19 -0400)

Please pull, thanks.
Mike

----------------------------------------------------------------
- Fix DM discard regressions due to DM core switching over to using
  queue_limits_set() without DM core and targets first being updated
  to set (and stack) discard limits in terms of max_hw_discard_sectors
  and not max_discard_sectors.

- Fix stable@ DM integrity discard support to set device's
  discard_granularity limit to the device's logical block size.
-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEJfWUX4UqZ4x1O2wixSPxCi2dA1oFAmZMv3kACgkQxSPxCi2d
A1pX2gf+NjaTP+6otMJ44sYwUGHuWtgwDy7NcoTiF4RvLQjjrUh8Lgm2p3i4evFs
4AzMNXy5V6/mEx/AZb7sjCtPkIGOykkBud3+jhStohQKvXEJQcYtwACNv151NW2c
Fw2tcPZbPKH8P8UkDkegLaCu+4DotYjhuw44dfHFVZ95Wlhcm2UmcjWQEf/LtYW0
Si2FE0z2n1yi1mY6cExuL0bJ+LaMrXRQzHE3ZPaPRn4PFNUTY1juKsHYbgyL7cZ+
xQM1W/KBrKzDztCJGKH4Cl86L3kNPRkiQ7BQ/2Wtse20o10EGT0+lPvevCNcPNpi
gbjAo7OPy9WPA9N/AR8Wfj06YQFaGA==
=Pp+x
-----END PGP SIGNATURE-----

----------------------------------------------------------------
Mike Snitzer (1):
      dm: always manage discard support in terms of max_hw_discard_sectors

Mikulas Patocka (1):
      dm-integrity: set discard_granularity to logical block size

 drivers/md/dm-cache-target.c | 5 ++---
 drivers/md/dm-clone-target.c | 4 ++--
 drivers/md/dm-integrity.c    | 1 +
 drivers/md/dm-log-writes.c   | 2 +-
 drivers/md/dm-snap.c         | 2 +-
 drivers/md/dm-target.c       | 1 -
 drivers/md/dm-thin.c         | 4 ++--
 drivers/md/dm-zero.c         | 1 -
 drivers/md/dm-zoned-target.c | 1 -
 drivers/md/dm.c              | 2 +-
 10 files changed, 10 insertions(+), 13 deletions(-)

Received: from mail-qk1-f170.google.com (mail-qk1-f170.google.com [209.85.222.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F31122329
	for <linux-block@vger.kernel.org>; Fri, 23 Feb 2024 17:17:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708708663; cv=none; b=RVPiOp/i8YKvz/gxcgjFwkgLduTJSay4RRKC5SQE6FiyPY/hizUVvZ8yUZpbuANoYR2+f53s68xy9CyUnVpPZO5OcmM0oUlpHLLMwuVvoSveuneYkNe1CiBNZgjHWvqUjUgXgmY/i4HcBfmorbvP8Mphezx7u4QLDJG53v8f/LQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708708663; c=relaxed/simple;
	bh=uUh/WyYIbYsAfpy4+L2U+5AEMxonwfCxCyyaq0K7Xfk=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=NAcXYQiCv9wH6ncXR9IDVurTMVL6ddHZba15p593cA0QHie7pp5aIpW/ubHi4Gp6J3utQl7EqzBxVJsvj63/fB6hukW7T2y+4Nm1hvXdYYHhAUYpQ7fDHB4xeM8/S0FVj8a05amjYbx6BVtp7YqqzWAU4R7dH7K7LoaB5bTThwE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=redhat.com; arc=none smtp.client-ip=209.85.222.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Received: by mail-qk1-f170.google.com with SMTP id af79cd13be357-787a8cc7d95so102015485a.0
        for <linux-block@vger.kernel.org>; Fri, 23 Feb 2024 09:17:40 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708708659; x=1709313459;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7d5bEzl4Pfk/hPSxARER9ZRkgxcRli8GERqXAK0ZBGo=;
        b=BgqP2YANgrg6BRS4XgxBWiRkCcTH/9GtWDCJx7C/PpBbitw4b/Ydq1I+4vDDwnXcY5
         +4mX0N4iwt1leLwMazH/KOg39E1s3hqmhsnkY1R2bEo+1mW+ZCUis/XnvGODZcMK56Al
         EmpKrqSV4FUEDgS6gEg/Zga967wCeHq5YZf91JNSqz9W0VYyAieuyIB8SDHAulFzCEsF
         ZtXKqowxmmVm3H8DGHydHn3FSh2RSk+fWfaTUaoE3d4+c8yOxo0a5DQln4WoE87O/fjY
         31/uRDvwESe3qkfZK9OGNIwSsyfcEX0jOi88s+yNDjuzGnAAL5ug49sbdf/rDfUAUiem
         oJgw==
X-Forwarded-Encrypted: i=1; AJvYcCWWCKeh+T9TllgBwNMy54BDe73m4A9SLDxJtrgKi2hAyoR8/atO97CjUjs+lD6dbkLuqaRMUw9IKzWJzH5GToUW8ip69MHNrDze/mo=
X-Gm-Message-State: AOJu0Yw+OlnECYRuy+45r2YZk4rX1ifZB9Y6G2uNTSJSwCr21LrdA2NL
	Y2haooFZSFUSf30e59bHzuerbVzqef3r8o7Vztvj44pXM4K6NJjZAABe8oUj1g==
X-Google-Smtp-Source: AGHT+IF5G0gsP29p/juoIFVDXB5cyHaaiyFCO/QrSTWgfFcIFkXe8vBN5FaTxKZTDDbYfaAi2puOVg==
X-Received: by 2002:a05:620a:f88:b0:787:a9af:d6b8 with SMTP id b8-20020a05620a0f8800b00787a9afd6b8mr659327qkn.8.1708708659302;
        Fri, 23 Feb 2024 09:17:39 -0800 (PST)
Received: from localhost (pool-68-160-141-91.bstnma.fios.verizon.net. [68.160.141.91])
        by smtp.gmail.com with ESMTPSA id v9-20020ae9e309000000b007877cc523f3sm3585957qkf.127.2024.02.23.09.17.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Feb 2024 09:17:38 -0800 (PST)
Date: Fri, 23 Feb 2024 12:17:37 -0500
From: Mike Snitzer <snitzer@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: dm-devel@lists.linux.dev, linux-block@vger.kernel.org,
	Alasdair G Kergon <agk@redhat.com>,
	Benjamin Marzinski <bmarzins@redhat.com>,
	Mikulas Patocka <mpatocka@redhat.com>
Subject: [git pull] device mapper fixes for 6.8-rc6
Message-ID: <ZdjTMZRwZ_9GjCmc@redhat.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Linus,

The following changes since commit 54be6c6c5ae8e0d93a6c4641cb7528eb0b6ba478:

  Linux 6.8-rc3 (2024-02-04 12:20:36 +0000)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/device-mapper/linux-dm.git tags/for-6.8/dm-fixes-2

for you to fetch changes up to 0e0c50e85a364bb7f1c52c84affe7f9e88c57da7:

  dm-crypt, dm-integrity, dm-verity: bump target version (2024-02-20 13:35:47 -0500)

Please pull, thanks.
Mike

----------------------------------------------------------------
- Stable fixes for 3 DM targets (integrity, verity and crypt) to
  address systemic failure that can occur if user provided pages map
  to the same block.

- Fix DM crypt to not allow modifying data that being encrypted for
  authenticated encryption.

- Fix DM crypt and verity targets to align their respective bvec_iter
  struct members to avoid the need for byte level access (due to
  __packed attribute) that is costly on some arches (like RISC).
-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEJfWUX4UqZ4x1O2wixSPxCi2dA1oFAmXY0iwACgkQxSPxCi2d
A1oG3Qf/WE0T5qyBnDZ7irhvJmSLVx4oAwzB0PmMtELZ3Tkyn7BBAxq1Q2I2UT3x
r90d1uy/pz6Y+kZkAPZjYuYLctukEa1swpfFe0Sn01dBrbgGU/p2vi3fkF+ZK6/t
n5EN8S5dkf6rIDmp8R56iP8mP4OEultYjLugxc6ROohFgHZicoqv+Pye9kHp0Y19
HSW2eueag/s2nMa9HKjIEd3+NBgmGb0qMMf3M6CXpRLNi/f/cyHbPzq83+eW3gcg
jl480w5YHk2nOUSqrO8UfIaP4BpD3SEXQxVqIzdkVX4cEBO4yRcBNrQpsT89GsXj
sg5zinkq3g7SThEpQWdpkeZMR/6q/A==
=n0nQ
-----END PGP SIGNATURE-----

----------------------------------------------------------------
Mike Snitzer (1):
      dm-crypt, dm-integrity, dm-verity: bump target version

Mikulas Patocka (5):
      dm-integrity: recheck the integrity tag after a failure
      dm-verity: recheck the hash after a failure
      dm-crypt: don't modify the data when using authenticated encryption
      dm-crypt: recheck the integrity tag after a failure
      dm-verity, dm-crypt: align "struct bvec_iter" correctly

 drivers/md/dm-crypt.c         | 101 ++++++++++++++++++++++++++++++++++--------
 drivers/md/dm-integrity.c     |  95 ++++++++++++++++++++++++++++++++++-----
 drivers/md/dm-verity-target.c |  88 +++++++++++++++++++++++++++++++++---
 drivers/md/dm-verity.h        |  10 ++++-
 4 files changed, 256 insertions(+), 38 deletions(-)

Received: from mail-qt1-f179.google.com (mail-qt1-f179.google.com [209.85.160.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6672E2208F
	for <linux-block@vger.kernel.org>; Fri, 22 Mar 2024 16:33:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711125182; cv=none; b=BnE/u8FuxjUI6Htrgqxhl46Sbg3Yzcxn9JLuUeqwT5ZT3QtcmZi4Zy/68oiYZxohQaHxdlusWZeju9rraT+Co2+tYfW6wHtXKl/On3RBdmC2b6iJw2s7AHt421VaxhJxQbODs0yWIWIdxg8jLiOpMK983zOiaL50boRePRGE0os=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711125182; c=relaxed/simple;
	bh=1YOBaOS/9+FpcJyjxsfbUi2uhACDhvLW15v/P0oRqJc=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=iObFmI/WH4MPCVuFELNtZ0/Yqk1eUK+jv/FwSoK0UYUrpzt+9lDKvjACt4BXwTl/36aBspO8bbeBb1diHJM7Ur0DhE2mzYNVU9fkJjZ6Z5L+yu4yDD1iQVfKHTouLSqeNEPIh7jbF4+RDgTd6xYUQjqTZ+44ud4xzN2Ueh8EeZY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=redhat.com; arc=none smtp.client-ip=209.85.160.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Received: by mail-qt1-f179.google.com with SMTP id d75a77b69052e-430baec7bb5so30792421cf.0
        for <linux-block@vger.kernel.org>; Fri, 22 Mar 2024 09:33:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711125179; x=1711729979;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Pe6sLbeyNnbWwdi9Jx7VYnaU+Q8mhmGjLKvIm2EWpVs=;
        b=KtbaTRd9ikwRgFOh1XBmhURWL7fiXeoIB3HCEKsMSQ/qcdHB3h5EbQ5GJvMTEkWfws
         9aHzt8en6IBqBlIQGR2Rf3FRUgKPmZLrKU0UkMQynbx7euwSdXVGwL8vqiV1lQYgmT/t
         OsmAV9cIyiFkbOGbdYsnyYPjT/o7+537OrmIpiqf6E1fykH4nxYJcxR8L6oot+Byn88k
         EWgO6f6qDIlJmPNAp/GRULoTta6ETfEBpaYi+BFvwZcoVrSxfxWGCaoWhbkinqD6VN3D
         VDNZKaSJYMDJpSGzZbyIsJM9rw1kIt8bg4OG+yR76XSPw+YvLG/mIWeZFj0n8OwyWZHl
         W7Xg==
X-Forwarded-Encrypted: i=1; AJvYcCXoPuYsPZcTW94A6EU/TyxYII6yDDf5y0Pz/LSD3MO5DAs7m3Mt1Yhs2Il4eUIe0B/MbCCLdEf2Fx2gAcUfnjSln3si/h5W5DH1ido=
X-Gm-Message-State: AOJu0Yy+3sQVO815jeF5YCH2u4tDCg85jWPYAN0rrVep6CTi27n/sRXI
	yo/a4xmHSKhdXgHK5NiKUShKIVlMUTVzVIWXiRlB7+Rwl9ALBRAI49GEL4nBkQ==
X-Google-Smtp-Source: AGHT+IHr/6Phb0OzoSoqJmTZ46bgoA+ruY2dbZk5loQJfKPWqfZZBWglpcEvX1sYsyIQBr3j/FPwOQ==
X-Received: by 2002:a05:622a:341:b0:431:3963:14a9 with SMTP id r1-20020a05622a034100b00431396314a9mr73938qtw.31.1711125179415;
        Fri, 22 Mar 2024 09:32:59 -0700 (PDT)
Received: from localhost (pool-68-160-141-91.bstnma.fios.verizon.net. [68.160.141.91])
        by smtp.gmail.com with ESMTPSA id jx1-20020a05622a810100b00430b74c1661sm985864qtb.97.2024.03.22.09.32.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Mar 2024 09:32:59 -0700 (PDT)
Date: Fri, 22 Mar 2024 12:32:58 -0400
From: Mike Snitzer <snitzer@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: dm-devel@lists.linux.dev, linux-block@vger.kernel.org,
	Alasdair G Kergon <agk@redhat.com>,
	Mikulas Patocka <mpatocka@redhat.com>,
	Benjamin Marzinski <bmarzins@redhat.com>
Subject: [git pull] device mapper fixes for 6.9-rc1
Message-ID: <Zf2yuk3U49ztCwdp@redhat.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Linus,

The following changes since commit 277100b3d5fefacba4f5ff18e2e52a9553eb6e3f:

  Merge tag 'block-6.9-20240315' of git://git.kernel.dk/linux (2024-03-15 14:55:50 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/device-mapper/linux-dm.git tags/for-6.9/dm-fixes

for you to fetch changes up to b4d78cfeb30476239cf08f4f40afc095c173d6e3:

  dm-integrity: align the outgoing bio in integrity_recheck (2024-03-21 13:19:10 -0400)

Please pull, thanks.
Mike

----------------------------------------------------------------
- Fix a memory leak in DM integrity recheck code that was added during
  the 6.9 merge. Also fix the recheck code to ensure it issues bios
  with proper alignment.

- Fix DM snapshot's dm_exception_table_exit() to schedule while
  handling an large exception table during snapshot device shutdown.
-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEJfWUX4UqZ4x1O2wixSPxCi2dA1oFAmX9seYACgkQxSPxCi2d
A1oKMwgA2xYlw4JooN7PIvGb7IiIfzXfdVmmtTiHBzuvhAOg7f014UbUoubnNz0z
DogzvWVX4Svieh60EYVaaHdWWJWBQnNLO5qJCEmt4sMYXU9pnpJnfWCQiP3EHKL5
8fVsoCeEK1Eh+eYghG7731zSaqqavwTYm3rlzcuq5hPa+cW6b2OgxzUJybEfsXhi
9Y5lc7LUEuLuSRAnL/Msg4Rmo6eR45GOmY9EcULx0hf/plJrho9J5cp07KJ5ViXK
ciYTGy3bkoVxKufepdINaKZyI2/3PEDZm2cTfidubhSj33Zgce2c7oJz+1F9Q9wf
bixaB+mI2pMVwFzllrkxnl8yIGgoAw==
=D74z
-----END PGP SIGNATURE-----

----------------------------------------------------------------
Mikulas Patocka (3):
      dm-integrity: fix a memory leak when rechecking the data
      dm snapshot: fix lockup in dm_exception_table_exit
      dm-integrity: align the outgoing bio in integrity_recheck

 drivers/md/dm-integrity.c | 20 ++++++++++++++------
 drivers/md/dm-snap.c      |  4 +++-
 2 files changed, 17 insertions(+), 7 deletions(-)

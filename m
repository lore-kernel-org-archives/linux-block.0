Received: from mail-oi1-f179.google.com (mail-oi1-f179.google.com [209.85.167.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED17E135A50
	for <linux-block@vger.kernel.org>; Fri, 29 Mar 2024 14:20:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711722026; cv=none; b=Ak0Pn6Z9EfaQ5F9xJ2jwLKnYxhTEZhT9xu6QmAwkt4jQP063g5BfresG4pnfr66p+4boaZG6oFHR4UE3xfjfTJEileM9r6AAu1NHvQ6NOlKGKr1xMY58JYCCZzuLzHBmPPM8Ss5Y7IwDHd4VUW1MR9wKpIIyX88W4YwSs6ppGOg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711722026; c=relaxed/simple;
	bh=wIqcItp3TZSxSQIu3lQo1+x7c8g8/iqdkFQJw8MxJec=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=jrPSiUR1bc8XOYLn5wzCSJDUKZtkSuBksTgIYZ0gWwXdRT/hnD0/GN4uDdF68/F4kiLzOiLiQ3fMWm2Sh8jeyWOITweDkfIrLghC4hJEAZhrSQauZRcu+FYSYLyPJ1jKPv3qhfPV4E1hIWhvIrn0VcjbUwJR6baaGuaw0E7UwYE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=redhat.com; arc=none smtp.client-ip=209.85.167.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Received: by mail-oi1-f179.google.com with SMTP id 5614622812f47-3c3e6b6fcbdso708968b6e.2
        for <linux-block@vger.kernel.org>; Fri, 29 Mar 2024 07:20:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711722024; x=1712326824;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=n5Pe0hzSzMNAPl2hWGBkg9DigkDiMKnl2M8tW4nsDWg=;
        b=GSfiInjn4wn1m+EFxLt5n52ICuqp85uUhnu8zyZWhF7jNSa2+3rG6kqsHMXoCPkUTU
         84sZcFPm0ohabQuoNvMZwFaRjhRZOJys7EAl3NKPrWVjbM3iZQWUeJcMYxddBsF44TVs
         hgd2c3jy//nvtCA+feqwEudsMDSZjdC0l6XPA0DfxXz/wQKDoAKPn/NnUrYoKQ+R9WAH
         2jFelWT5TkF7jfop0PRf0oMJKvgA/1KGIvHayylzhh9C1G7iuaTK59MHLws0E4xyhCK1
         urRW3mkVRdLqb6saNpUjkdcIQYG4fdteuW4Bb01/JpgaLiQI+tSNfQ/MKA86E+FPFbol
         8Fnw==
X-Forwarded-Encrypted: i=1; AJvYcCU5JEVT0FLWHsEfYHfgBE1sfeSF0wgydjVYagkkdGfd3JJv81LgFGxrCldaH7QhwbBh5NJ2x+p5cur+YRY8aFBZJQvx0QynEF6oR5g=
X-Gm-Message-State: AOJu0YwOKse/JNZCXJTOfCtE3/3sJTKMV6/6J2/j35Ry1IRYQb6YQ13r
	42aPSUivc3jHHPcWPJWPNxKfDDGGku27Lbi5+FJbltM7gnlnanynmnTeau3CCQ==
X-Google-Smtp-Source: AGHT+IFMBJLXrQwid/701zOEqkvHUyFciXE9pt18JMhClmz7yIxaE4V07KuzPmFb/Ujq0k9kxhmuoQ==
X-Received: by 2002:a05:6808:1509:b0:3c3:d03c:a612 with SMTP id u9-20020a056808150900b003c3d03ca612mr2790182oiw.1.1711722024107;
        Fri, 29 Mar 2024 07:20:24 -0700 (PDT)
Received: from localhost (pool-68-160-141-91.bstnma.fios.verizon.net. [68.160.141.91])
        by smtp.gmail.com with ESMTPSA id 6-20020ad45ba6000000b0069694dab3f8sm1686878qvq.39.2024.03.29.07.20.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Mar 2024 07:20:23 -0700 (PDT)
Date: Fri, 29 Mar 2024 10:20:22 -0400
From: Mike Snitzer <snitzer@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: dm-devel@lists.linux.dev, linux-block@vger.kernel.org,
	Alasdair G Kergon <agk@redhat.com>,
	Mikulas Patocka <mpatocka@redhat.com>,
	Benjamin Marzinski <bmarzins@redhat.com>,
	Kuan-Wei Chiu <visitorckw@gmail.com>,
	Ken Raeburn <raeburn@redhat.com>, Arnd Bergmann <arnd@arndb.de>
Subject: [git pull] device mapper fixes for 6.9-rc2
Message-ID: <ZgbOJlMv2nYOEbWe@redhat.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Linus,

The following changes since commit 4cece764965020c22cff7665b18a012006359095:

  Linux 6.9-rc1 (2024-03-24 14:10:05 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/device-mapper/linux-dm.git tags/for-6.9/dm-fixes-2

for you to fetch changes up to 8e91c2342351e0f5ef6c0a704384a7f6fc70c3b2:

  dm integrity: fix out-of-range warning (2024-03-29 09:48:07 -0400)

Please pull, thanks.
Mike

----------------------------------------------------------------
- Fix MAINTAINERS to not include M: dm-devel for DM entries.

- Fix DM vdo's murmurhash to use proper byteswapping methods.

- Fix DM integrity clang warning about comparison out-of-range.
-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEJfWUX4UqZ4x1O2wixSPxCi2dA1oFAmYGzUoACgkQxSPxCi2d
A1roewf/V6P7fvYKJlAFQ3nhpOy09KSY8G1UofjrfTmqVG329jAzOWoEq5umivPY
TLWJ0kJ1Wst0+U61u+lho0RnYd3ZHQU3pMrl5Lq9B5yCeZcZIPYxhEBhBsRJtSV7
m04aaF8Lox5ofhPfNwrhUmJyTa7ZKtkz2MCk4TaT3qNkamzE0ToYjJduERzA1FU7
x8fEg/D8CrPVn5tbTf6G2u3T2iMJXu1mzR3bj3C8CEGN4QPtRc9c54s2FL4o0mOS
c/i7VDSSDk/NujY65vY2u0P3hNZKEUcv00M7LezYA6hwhZdINTS4K4oOtPaZUYaN
FsjMHiyE5echCCv6FvE+ztFGo4H30w==
=U7Wa
-----END PGP SIGNATURE-----

----------------------------------------------------------------
Arnd Bergmann (1):
      dm integrity: fix out-of-range warning

Ken Raeburn (1):
      dm vdo murmurhash3: use kernel byteswapping routines instead of GCC ones

Kuan-Wei Chiu (1):
      MAINTAINERS: Remove incorrect M: tag for dm-devel@lists.linux.dev

 MAINTAINERS                     |  2 --
 drivers/md/dm-integrity.c       |  2 +-
 drivers/md/dm-vdo/murmurhash3.c | 33 ++++++++-------------------------
 3 files changed, 9 insertions(+), 28 deletions(-)

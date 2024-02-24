Received: from mail-qk1-f174.google.com (mail-qk1-f174.google.com [209.85.222.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D06B4642A
	for <linux-block@vger.kernel.org>; Sat, 24 Feb 2024 16:05:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708790760; cv=none; b=bBYlLZR5rwisgWBSl+I5HFAY+ZYMY6YPeOEdPW6+aRZ5gw1Y5+oVDXoAeWEE8a44rG4t2Ynhpzza834o4z0Aa5uLA22L2tZpAEa/OijzgfiIIWRqxYXRqLt+NuJVz7k3V+nlMhqA/qFAA4bk+a2ICENUtOmYRsziJXJkXfFVnCc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708790760; c=relaxed/simple;
	bh=E59Ge2iof5touRWs6VPVO6mhrKT3Lkb/h6XiZDAiOCo=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=eGoHHwPKZ89Pj9zGwTOfx+ZN7B3JnBOrzxbIp1qKQa7KstaJH1Lof5ThAlLkO6KQJ+w3jIDrhyzA+3IQivy1OeM+iIYTZU1D9hdm9DRLOghbZV3J1uzkg08o6AL6/8vpxA64jeqR9B5ah9uNFJP+4KlYIx67qVUSgG9u7VCf/wM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=redhat.com; arc=none smtp.client-ip=209.85.222.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Received: by mail-qk1-f174.google.com with SMTP id af79cd13be357-785bdb57dfaso105238885a.1
        for <linux-block@vger.kernel.org>; Sat, 24 Feb 2024 08:05:57 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708790756; x=1709395556;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1xgfDfdFhOROV3arv9/Dp8sUl3kpSHJJYA7cwc0URRY=;
        b=JKxMKXdZTFkDRxqY1RsKqYNo/j3IHJEXplMafZ9r7GXbK6RSEVBg0akjyZGSFXO/l/
         pDxXkLeqQdtWtr5+jwGZiNFCp/ou/Q8gu3NjIPxbTiMYuK78H2tJRTAJWibVrP0Vg+jW
         sQHswRjfQZ4XlnG/Re7HBkKTO+p7/YheAzMzxGdRSAWSE6WSJlZidFxAtz5KEI0RLUyV
         FMMOm+JClzxCvj9TQRTfea9u+OoaIRXiWY18ExCeIbPyHCJVEp+VjKfgrBj+RA+ON2Kd
         cAoYFLHWbEt3lweR9XaYrSwrW2ov49JUEjPc2f9Y4uu39AUYVd96gj5BeaBoanLVPFhz
         rMzQ==
X-Forwarded-Encrypted: i=1; AJvYcCXHnQWpRan+I/wLazfexfgy1ImYDfrfUjuzSWEHGcrYb24QQyVcvuTxtAHjI12UqB7Nn+eHuSViIYri5ue9uwmHGc+BwFB3fT1x04Q=
X-Gm-Message-State: AOJu0Yz9FWhFp2w6cnyiu1Yq7a2XGvpOPDQbPshz5MAuZkzI4N6yy4BH
	mIp1H4kQwKXfxS4XQPYQiM6aYzzTOEsUhAdxjAYK7/seKWxfSvyP9hnODZo7kA==
X-Google-Smtp-Source: AGHT+IFlY3V9dD4ZOCgndCWM7fAJphAAD9qoawkqEXjWLsdnhS2+O0oxz9RzLRekhSvnxdcKqsxjqQ==
X-Received: by 2002:a05:620a:2086:b0:787:b5c2:6aa8 with SMTP id e6-20020a05620a208600b00787b5c26aa8mr4069839qka.30.1708790756453;
        Sat, 24 Feb 2024 08:05:56 -0800 (PST)
Received: from localhost (pool-68-160-141-91.bstnma.fios.verizon.net. [68.160.141.91])
        by smtp.gmail.com with ESMTPSA id c20-20020a37e114000000b007872affb7d9sm709203qkm.45.2024.02.24.08.05.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 24 Feb 2024 08:05:55 -0800 (PST)
Date: Sat, 24 Feb 2024 11:05:54 -0500
From: Mike Snitzer <snitzer@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: dm-devel@lists.linux.dev, linux-block@vger.kernel.org,
	Alasdair G Kergon <agk@redhat.com>,
	Benjamin Marzinski <bmarzins@redhat.com>,
	Mikulas Patocka <mpatocka@redhat.com>,
	Arnd Bergmann <arnd@arndb.de>
Subject: [git pull] device mapper fix for 6.8-rc6
Message-ID: <ZdoT4rC0f5MkY6NQ@redhat.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Linus,

A fix for changes from yesterday's DM pull request.

The following changes since commit 0e0c50e85a364bb7f1c52c84affe7f9e88c57da7:

  dm-crypt, dm-integrity, dm-verity: bump target version (2024-02-20 13:35:47 -0500)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/device-mapper/linux-dm.git tags/for-6.8/dm-fix-3

for you to fetch changes up to 66ad2fbcdbeab0edfd40c5d94f32f053b98c2320:

  dm-integrity, dm-verity: reduce stack usage for recheck (2024-02-24 10:53:57 -0500)

Please pull, thanks.
Mike

----------------------------------------------------------------
- Fix DM integrity and verity targets to not use excessive stack when
  they recheck in the error path.
-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEJfWUX4UqZ4x1O2wixSPxCi2dA1oFAmXaEswACgkQxSPxCi2d
A1oT2Qf/c1opgjRUe+yY/v7nWf4paufSj2O4LYAy/qQBU7IS9CcXQPzi/pKlfEo8
60OZfa5gfrCAla79se7hHI/mxReq7CI5nFvYDyqQ1JZQ/djG/4cN/oWf5fQ12pon
/ET1IzaZ+Mom+5wDBeQBLoQwXTA1ru5Bi1OiUe9Ed3wzadZQQks5s65fPnc0emGJ
ClyaXiiCt4Dy36E5GmuPpmPB4ZJ57SwcnFWDFIeCHEbIQk36APkZ22z7lqGObjw2
ANO1l59k6ojzmaXLi9pw/J/o/qyfNR0MpeI7SpmtJzhSZKeGKsUX2GlJ9QBhViJp
XL/+7MbSRJ43IY1lomoHZm1vxe0aPg==
=sQPX
-----END PGP SIGNATURE-----

----------------------------------------------------------------
Arnd Bergmann (1):
      dm-integrity, dm-verity: reduce stack usage for recheck

 drivers/md/dm-integrity.c     | 10 ++++------
 drivers/md/dm-verity-target.c |  4 ++--
 2 files changed, 6 insertions(+), 8 deletions(-)

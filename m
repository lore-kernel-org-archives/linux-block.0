Received: from mail-yb1-f174.google.com (mail-yb1-f174.google.com [209.85.219.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A58F55B1E7
	for <linux-block@vger.kernel.org>; Mon, 11 Mar 2024 18:37:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710182241; cv=none; b=io1imwpmaaVliHZ5Jo3cWBuwj77WzxqbXQUmyHxclTDa7pc2ZVVK84Njz4/72MCcAKzyy3+7lwtxt0knpxnDc0/+H1U0zUXdtLxgnrQnDi2u4MkODXNNM7dp5Mt1gtUHe0pGPe0AHVtqqL9Hamc4w7vIp96YjP5Y9VaGk2i4T+c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710182241; c=relaxed/simple;
	bh=YnELaeyF85Ph7jkmYDe0QnxDuiDqYb1PHVXPKbd7E2k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jJyi4/zFuSvjZvFJu2dJkCDhvZhvnpHEe4jegbAyww+ZZckao0k9+Fx16qsYjLkq4TUoGdeCblZj+bQ834L9V2peejD49rmocdhiHtZ3v+ULujDoB9kMUlaxbfEBw3mcmhfkfF2phGEFPvcdQjStVFPP+JA9jHyuwgcAXfiMKRc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=redhat.com; arc=none smtp.client-ip=209.85.219.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Received: by mail-yb1-f174.google.com with SMTP id 3f1490d57ef6-db4364ecd6aso3264685276.2
        for <linux-block@vger.kernel.org>; Mon, 11 Mar 2024 11:37:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710182238; x=1710787038;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=q2ly2QVCqjo3ja3OmJ6MNsfASrOsaZ8rTUdYYRkUi3U=;
        b=ls3EQkmvrG0Or0APUadGloZH8eIYzXXrVnM1Yhmam3Lls4dqt7tdrKJIgK/Y8ZDyet
         zVARkECVQn5wiBCjZGiR79x68YM6DkWy4Oth4Pdp+pIeyD2dLOVeGijzVcIrJ0IntGrE
         hv16KAixXTX2QKnJqeChuO40ICT0E0cAxcBlwkHTos3qzzrZofTk8L9u7TlzPkwjgMDi
         uXCOeCiPYisv5r8hkN6f2JLGlXRTyznU/CR3dyZrX/5NeyXBJKBquAixTGZV0IYsQd+A
         zJkoIdWNnolS2gGwQ/KyONQY0Kdm5q0dh0LZdoV/4h/vZHrqaKGB4JHyfmtqJv+cmbvF
         bSAQ==
X-Forwarded-Encrypted: i=1; AJvYcCXjAnpCGrsRRtB1NWVMbQtUGqpFMMUerxuLnaWLTyuF4IDZEuk6ujlyngpKCj62KJjkBhY8UrAdaooT/WLB5bMN2qpVVxdLz70kmNY=
X-Gm-Message-State: AOJu0Ywbj6YOgfUcco2ApHj4QR5o8eSf5gGamN08wffJqUyOIccRc2Oh
	7mzswPuhqWNhvXSkSvuGOKRP+lyjRBaCTGp6XCAzoYfBgCjzDA04EAnCBDBWAQ==
X-Google-Smtp-Source: AGHT+IELFJOzjpMAwsaZJWBQdV3DaC06F/mYUoDElMGd2Jeys0SfgEtKGMwW6Y/dNKAMSRPI66taAg==
X-Received: by 2002:a25:41d0:0:b0:dcb:e432:cb06 with SMTP id o199-20020a2541d0000000b00dcbe432cb06mr4097437yba.29.1710182238586;
        Mon, 11 Mar 2024 11:37:18 -0700 (PDT)
Received: from localhost (pool-68-160-141-91.bstnma.fios.verizon.net. [68.160.141.91])
        by smtp.gmail.com with ESMTPSA id 18-20020ac85652000000b0042f1e47e652sm2948830qtt.79.2024.03.11.11.37.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Mar 2024 11:37:18 -0700 (PDT)
Date: Mon, 11 Mar 2024 14:37:17 -0400
From: Mike Snitzer <snitzer@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: dm-devel@lists.linux.dev, linux-block@vger.kernel.org,
	Alasdair G Kergon <agk@redhat.com>,
	Mikulas Patocka <mpatocka@redhat.com>,
	Benjamin Marzinski <bmarzins@redhat.com>, Tejun Heo <tj@kernel.org>
Subject: [git pull] device mapper changes to switch to BH workqueue for 6.9
Message-ID: <Ze9PXaiOHXiKFjT2@redhat.com>
References: <Ze9OCmWb-9LX5t8W@redhat.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Ze9OCmWb-9LX5t8W@redhat.com>

Hi Linus,

The following changes since commit c6df327501b9dc064a419f25daf99eebdf8fc815:

  Merge remote-tracking branch 'tejun/for-6.9' into dm-6.9-bh-wq (2024-03-02 10:29:40 -0500)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/device-mapper/linux-dm.git tags/for-6.9/dm-bh-wq

for you to fetch changes up to c375b223338828f29aed76625b33be6d3a21f8af:

  dm-verity: Convert from tasklet to BH workqueue (2024-03-02 10:30:36 -0500)

Please pull, thanks.
Mike

----------------------------------------------------------------
- Convert the DM verity and crypt targets from (ab)using tasklets to
  using BH workqueues.  These changes were coordinated with Tejun and
  are based ontop of DM's 6.9 changes and Tejun's 6.9 workqueue tree.
-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEJfWUX4UqZ4x1O2wixSPxCi2dA1oFAmXqBRAACgkQxSPxCi2d
A1pAIAf+PKFi4KlNvJlJehKzCMBxofFUK+DMxePqbhHudN1v6z2Q0lMbsa0wpCly
eql2SQQPRhqI4j7WhhpY6uXPpxZ9TKrDsIFiOTka6kZBwIlVafMDwtb+16/PVSHa
le7ngtCaY4EFu0aPpVV8oW5TGJSgmGsv+KvgZ/Op+ugmbOKAraMvVaGb89xh6WQN
ngUoLqEgF0br79UWKYJ2YtjsgK1h2Ra+Nu8eh/FV3dAOtnJtNJ5Ph0MLz35dGQvv
0djeDy/DGmWKeNxUdqQPzgguPG84P5Pfg6xbZa7bqqv4ujQOp2YIX4dxkjM2w2Aj
III+WJ5XHaLOE1JutwZCVyuabNApMA==
=MSmO
-----END PGP SIGNATURE-----

----------------------------------------------------------------
Tejun Heo (2):
      dm-crypt: Convert from tasklet to BH workqueue
      dm-verity: Convert from tasklet to BH workqueue

 drivers/md/dm-crypt.c         |  6 +++-
 drivers/md/dm-verity-target.c | 64 ++++++++++++++++++++++++++++---------------
 drivers/md/dm-verity.h        |  5 ++--
 3 files changed, 50 insertions(+), 25 deletions(-)

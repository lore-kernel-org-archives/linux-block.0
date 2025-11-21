Received: from mail-io1-f51.google.com (mail-io1-f51.google.com [209.85.166.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B3872FF151
	for <linux-block@vger.kernel.org>; Fri, 21 Nov 2025 17:37:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763746673; cv=none; b=FjH7inBLOCsx2QsbX872uGAUUP1lckyYg2rTOwxfp/4vTrEefbbMI39vpaxvoZXPfbbzHaDKUeOBZPAody3bYyc0bccMWLu+MJPbW5tUSifw2O4CuW0B/bKSMLeAsGQYL5ltcA2CKaIqfOdgkuY4u7faPfV5U2lalEqjSH2Lp2c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763746673; c=relaxed/simple;
	bh=oaKwenlhQ663aIq28j+DN4A4eommCeEuQnnKWfxrbjc=;
	h=Message-ID:Date:MIME-Version:To:Cc:From:Subject:Content-Type; b=N1S38eJbo34SFX+A9QrempH7D+05xzq1EgcE08kbLcvXC7wlQzk4r729zxv6g38t+KtXRAjeEjiKHya56MDzGSLN3cSzN0CPcWu3jyr1yXSubMC5EcBfBRVyYQuTqgxWUDnQsSF978omUhho8K/6Exu3gZjuNB2An7CLYP/hKrc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=p+jNYd/N; arc=none smtp.client-ip=209.85.166.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="p+jNYd/N"
Received: by mail-io1-f51.google.com with SMTP id ca18e2360f4ac-949033fb2a9so93061539f.2
        for <linux-block@vger.kernel.org>; Fri, 21 Nov 2025 09:37:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1763746669; x=1764351469; darn=vger.kernel.org;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=r9O8+TRgh6YjRg3YhY2jzcW3Zh4MceFMqHSzU5iw8CI=;
        b=p+jNYd/N+jsyY+F8/y2DTS3k5C8ZCorYUlpJ7zHHKX5hF85oZgQkJF4zyVFKnucNd1
         5K6AQWbzg/tBO6DqH4ONDh7mL04I7MlLk4hR64uaFyq+SMsyTtPJr0rRyILR4bW8QBNA
         4LfTqKJjdSjw8GZyoKMzPZ+/lJwPubXP9BJ+qvP3O3KmyRTIrEpHNs8tp5H3V9xzJ2N7
         JOqDt6ejKGNwcWtFmUep6wncW0tnp8nafHCDF5PPfUM7vxlvPldpOpCGBzh3NA/i5wi8
         73XtuYlZO5u6088fAt08gEQqpGPzoUBWApPFQul19EKuQ0YTk446z9iUfBu9CEGAJ/4b
         GNAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763746669; x=1764351469;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=r9O8+TRgh6YjRg3YhY2jzcW3Zh4MceFMqHSzU5iw8CI=;
        b=fpWp75tZ++hPHv3zeM1kP5rhys/20R8GrbMoEakmFruzh15pVbCMxvzzMYSsF/V4T/
         UDjAFmPL1acdP4n38dkcMbCzXkWbadzXWgHp3Eq0YqV8jvptjYojZr8IC/GjPg8noaJ3
         2MrOuTH3meKBjtIGQlJB6JFInvackwOi4+SCCeOgR9+uid8hY9SmxjX3/GqjkmqcHxcF
         15pDnqgxXXEZLGS+uvvaSANf9SIgVOrup0476uQu8aXsTNlI7+A+x+lx/MIowhQQ7WIx
         yAucDiCgeQyvG45tLaslyAdMUolaPaWYkDHyXHwPo2u91Efjd/GJ9pR3FphU0pxJUHhm
         sI5g==
X-Gm-Message-State: AOJu0YzP+XM2FAN0jYCT986mH9iIhZFll0RPNfKk87y7spSgyIwWAfGL
	hnU1wOpYkgEPBD0LqsR4D8tS0JFaQtlA1nDj5S/Fgp6zjRju1yg6cl/6RpXgrl1MwGWgh5NMnbd
	iaUke
X-Gm-Gg: ASbGnct/OUJ4fSfMo8XsMgGTZmrHR8ef9J6HToYTrTFLQWDKGSsCt3B81IgaSHvltQ2
	hU7AVPeYz6bZRWiVeATC+zXGWbDlBrIyZ8wPSk5c+GYeHWXN0TvzPtlrzNVFsSA555dtJ1ygxYg
	dgHlIaJCVlutqYog17kmRruA6+PTaZbTQ9Bb2SgkdkH+n7boGiFeYg06+Ibnd/Q4jR0aWyVRtg4
	qBd+mbT3w8g/9WfCkPkk5soQnzCF4jQ57TYQs/sSoqaN2wHG2pT8RBWS/4AWPyaVJj71vJ5y0jg
	k95wQCI+Re5KI1CN6UEGeJNZVQUsGbESwE55m8vRJSGyNN/xaPhUvAEv+LS7HGY3O/pC5bayJ9q
	t5TJviJeTciBxRYZhW7gPtzT+HIbFJZYDXZB5gz3u9k0PMgTmZHmy/ZEuHUPh+nDGJc1D0kIAWd
	v2FuCtrA==
X-Google-Smtp-Source: AGHT+IEtefbV5uYr4o8QrADs/8ZImYnYXH/3FWdG6/u8Yo8vFqoLjo0H5B/IH6DiffN5Crfir9PKWg==
X-Received: by 2002:a05:6638:ec3:b0:5b7:1753:3abc with SMTP id 8926c6da1cb9f-5b967a7b335mr1414459173.11.1763746668811;
        Fri, 21 Nov 2025 09:37:48 -0800 (PST)
Received: from [192.168.1.96] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-5b954b48b75sm2331713173.48.2025.11.21.09.37.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 21 Nov 2025 09:37:48 -0800 (PST)
Message-ID: <fd17309a-fe4d-4862-aa93-e84bf455f639@kernel.dk>
Date: Fri, 21 Nov 2025 10:37:47 -0700
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
Subject: [GIT PULL] Block fixes for 6.18-rc7
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Linus,

Set of block changes that should go into the 6.18 kernel release. This
pull request contains:

- NVMe pull request via Keith
	- Admin queue use-after-free fix (Keith)
	- Target authentication fix (Alistar)
	- Multipath lockdeup fix (Shin'ichiro)
	- FC transport teardown fixes (Ewan)

Please pull!


The following changes since commit 8f05967b022d255412640670915475ac4cdc10e9:

  MAINTAINERS: correct git location for block layer tree (2025-11-03 08:55:12 -0700)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/axboe/linux.git tags/block-6.18-20251120

for you to fetch changes up to 49c2d5941c89060342c65997de91859e5830dee5:

  Merge tag 'nvme-6.18-2025-11-20' of git://git.infradead.org/nvme into block-6.18 (2025-11-20 08:39:17 -0700)

----------------------------------------------------------------
block-6.18-20251120

----------------------------------------------------------------
Alistair Francis (1):
      nvmet-auth: update sc_c in target host hash calculation

Ewan D. Milne (2):
      nvme: nvme-fc: move tagset removal to nvme_fc_delete_ctrl()
      nvme: nvme-fc: Ensure ->ioerr_work is cancelled in nvme_fc_delete_ctrl()

Jens Axboe (1):
      Merge tag 'nvme-6.18-2025-11-20' of git://git.infradead.org/nvme into block-6.18

Keith Busch (1):
      nvme: fix admin request_queue lifetime

Shin'ichiro Kawasaki (1):
      nvme-multipath: fix lockdep WARN due to partition scan work

 drivers/nvme/host/core.c               |  3 ++-
 drivers/nvme/host/fc.c                 | 15 ++++++++-------
 drivers/nvme/host/multipath.c          |  2 +-
 drivers/nvme/target/auth.c             |  4 ++--
 drivers/nvme/target/fabrics-cmd-auth.c |  1 +
 drivers/nvme/target/nvmet.h            |  1 +
 6 files changed, 15 insertions(+), 11 deletions(-)

-- 
Jens Axboe


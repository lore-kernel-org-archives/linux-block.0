Received: from mail-oa1-f48.google.com (mail-oa1-f48.google.com [209.85.160.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BEB0200A6
	for <linux-block@vger.kernel.org>; Mon, 11 Mar 2024 18:31:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710181902; cv=none; b=jD28tbfu/gxqWLoLo5+9VtYQCyvqai5AdJIpqk0sgIOOtQIVRXr7cjDqvVsAkw+uoch9SgjyTzvuc4Dn5Ae4KzxNWs3LjZ5yXYlH2XrQR1FjcDPoOXfmBEZQj+lqVgII4eXJPain8uOlOcrw0QymeF3qw32YB4tnmhy5Mbbt8u8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710181902; c=relaxed/simple;
	bh=wng8NQM9nVVOZR5i7bah2DwklbhQVDLTcKi8F7BAD9c=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=huuysL+063qfEFVBGO8i6/v46gxTZg//Fytx/Mk/pWf0WxSWS7mwC/xvLaDQ8UxEVgQMXUwUMScQo4qEwEr/Gtz9KglVcLIrDfb18jCPiwlNr/5PdtA5IFmN3jVVcLFAEpllDUKs67pilLBBvG10kwURt3uHvBt/wzeO0TgkbGw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=redhat.com; arc=none smtp.client-ip=209.85.160.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Received: by mail-oa1-f48.google.com with SMTP id 586e51a60fabf-21fb368b468so3211299fac.0
        for <linux-block@vger.kernel.org>; Mon, 11 Mar 2024 11:31:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710181900; x=1710786700;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=61k/P7ymJsb2jESIDw3SfNET98/8UN55RrF7YkCOCew=;
        b=LlneKYCaAD/gwu3mVUjSQGZDCURr6qih+cg3R9T0rEbMG/+65b8xt01eGBzWyR37pe
         HbcAGhvUfn8ulEflibgoxn5PCVWNjl64B7YIugPzhJaHjSrJxQibPC7PXC3vC1fyS6QK
         ECdAAmT0x5QbOhwVWAHssVDaViiCJJwH0T6es8cQrTOS0K2nYVmR9BPoPTD2ZiTYGiOV
         q7xVzMITK7S3ntKNv4Mq1T01N+5ylJeEdaMr9twbG4PLdc0exDUzkNA3UnhJELXFrUz8
         +00u/Dt3l9yd0QekHnRFNxAYvMVwVV4NDdVknBuwMpgyXBGwusmlA/40tZyStd9xdpuN
         tz2w==
X-Forwarded-Encrypted: i=1; AJvYcCUHkR0fQbNWWe1h7ukKkmtpv+guQQ4wxtBW3OPg4/Ua+yA1h4XpQO/YEmPQY556AfxXy9lQYTd28FcWxZ3LcJ2JFt5cGeZ0Pd3X8tc=
X-Gm-Message-State: AOJu0YxHRHBsguBwItIL78xbGtJILWJ9chS/euuxe9hffy0t6XzqLALe
	lr5SHjqVj0ErF1dxiDHncGtyu21QZP1CVxjJN6o8eLpN9vnL3uCgJwWnhbOr+g==
X-Google-Smtp-Source: AGHT+IHnTWJpmVgSM1v/FzA8Qg424Mh3WdBtXuasCAlti1Nx5aRSGpW/Syr4eySFRkvY1yYi9sW2yQ==
X-Received: by 2002:a05:6870:2186:b0:21f:c801:cecf with SMTP id l6-20020a056870218600b0021fc801cecfmr7575363oae.16.1710181900269;
        Mon, 11 Mar 2024 11:31:40 -0700 (PDT)
Received: from localhost (pool-68-160-141-91.bstnma.fios.verizon.net. [68.160.141.91])
        by smtp.gmail.com with ESMTPSA id qp27-20020a05620a389b00b00788712ca95esm898265qkn.13.2024.03.11.11.31.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Mar 2024 11:31:39 -0700 (PDT)
Date: Mon, 11 Mar 2024 14:31:38 -0400
From: Mike Snitzer <snitzer@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: dm-devel@lists.linux.dev, linux-block@vger.kernel.org,
	Alasdair G Kergon <agk@redhat.com>,
	Mikulas Patocka <mpatocka@redhat.com>,
	Benjamin Marzinski <bmarzins@redhat.com>,
	Christoph Hellwig <hch@lst.de>, Fan Wu <wufan@linux.microsoft.com>,
	Hongyu Jin <hongyu.jin@unisoc.com>, Lizhe <sensor1010@163.com>,
	Ming Lei <ming.lei@redhat.com>
Subject: [git pull] device mapper changes for 6.9
Message-ID: <Ze9OCmWb-9LX5t8W@redhat.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Linus,

Please note there will be 2 additional DM pull requests that will follow
this one (for BH workqueue changes and the VDO dm target).

The following changes since commit 0e0c50e85a364bb7f1c52c84affe7f9e88c57da7:

  dm-crypt, dm-integrity, dm-verity: bump target version (2024-02-20 13:35:47 -0500)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/device-mapper/linux-dm.git tags/for-6.9/dm-changes

for you to fetch changes up to 8f28e6d4fe7440fb2c309e71bfcba961f6ad5a18:

  dm: call the resume method on internal suspend (2024-03-11 13:58:37 -0400)

Please pull, thanks.
Mike

----------------------------------------------------------------
- Fix DM core's IO submission (which include dm-io and dm-bufio) such
  that a bio's IO priority is propagated. Work focused on enabling
  both DM crypt and verity targets to retain the appropriate IO
  priority.

- Fix DM raid reshape logic to not allow an empty flush bio to be
  requeued due to false concern about the bio, which doesn't have a
  data payload, accessing beyond the end of the device.

- Fix DM core's internal resume so that it properly calls both presume
  and resume methods, which fixes the potential for a postsuspend and
  resume imbalance.

- Update DM verity target to set DM_TARGET_SINGLETON flag because it
  doesn't make sense to have a DM table with a mix of targets that
  include dm-verity.

- Small cleanups in DM crypt, thin, and integrity targets.

- Fix references to dm-devel mailing list to use latest list address.
-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEJfWUX4UqZ4x1O2wixSPxCi2dA1oFAmXvSCgACgkQxSPxCi2d
A1oSBAgAvCjWJghtJeUfLQ5crmb1yR3aOETtdTyjPyfoxNoc/BkbixdYc/Ze01fM
exi0UqDY02FYW0OG/ZGF/UU0amayar3narNLkF8a7NqJcsLQaPtHXsqKzkPib8/Z
VWyV69ZAmv63oTn74hNrlehAcRHAx54YxOz8q4rGl1Cg8aMkx5R5IoJDdpgCvDnl
daBPBKT4waMXHScQtBZ7A9+7VIBK16MWzvp3uLIE5GQcoJfjW/K+MQxze57Fb7OE
gu0hBJILkFjiOlT4L4OJecsqOw9poZldJ1miPDAQGUsASRsq3jAR8+61eu/CwxG4
l/vXrZ+Iua9V4ipRLa0gIKFOQLBwOQ==
=sm51
-----END PGP SIGNATURE-----

----------------------------------------------------------------
Christoph Hellwig (2):
      dm-integrity: set max_integrity_segments in dm_integrity_io_hints
      dm: set the correct discard_sectors limit

Fan Wu (1):
      dm verity: set DM_TARGET_SINGLETON feature flag

Hongyu Jin (4):
      dm io: Support IO priority
      dm bufio: Support IO priority
      dm verity: Fix IO priority lost when reading FEC and hash
      dm crypt: Fix IO priority lost when queuing write bios

Lizhe (1):
      dm crypt: remove redundant state settings after waking up

Mike Snitzer (3):
      dm thin: add braces around conditional code that spans lines
      dm ioctl: update DM_DRIVER_EMAIL to new dm-devel mailing list
      dm: update relevant MODULE_AUTHOR entries to latest dm-devel mailing list

Mikulas Patocka (1):
      dm: call the resume method on internal suspend

Ming Lei (1):
      dm raid: fix false positive for requeue needed during reshape

 drivers/md/dm-bio-prison-v1.c                 |  2 +-
 drivers/md/dm-bufio.c                         | 76 +++++++++++++++++++--------
 drivers/md/dm-cache-policy-smq.c              |  2 +-
 drivers/md/dm-cache-target.c                  |  5 +-
 drivers/md/dm-clone-target.c                  |  3 +-
 drivers/md/dm-crypt.c                         |  2 +-
 drivers/md/dm-dust.c                          |  2 +-
 drivers/md/dm-ebs-target.c                    |  2 +-
 drivers/md/dm-flakey.c                        |  2 +-
 drivers/md/dm-integrity.c                     | 14 ++---
 drivers/md/dm-io.c                            | 23 ++++----
 drivers/md/dm-ioctl.c                         |  2 +-
 drivers/md/dm-kcopyd.c                        |  4 +-
 drivers/md/dm-log-userspace-base.c            |  2 +-
 drivers/md/dm-log-writes.c                    |  2 +-
 drivers/md/dm-log.c                           |  6 +--
 drivers/md/dm-mpath.c                         |  2 +-
 drivers/md/dm-ps-round-robin.c                |  2 +-
 drivers/md/dm-raid.c                          |  8 +--
 drivers/md/dm-raid1.c                         |  6 +--
 drivers/md/dm-region-hash.c                   |  2 +-
 drivers/md/dm-snap-persistent.c               |  4 +-
 drivers/md/dm-snap.c                          |  2 +-
 drivers/md/dm-thin.c                          | 27 ++++++----
 drivers/md/dm-verity-fec.c                    | 21 ++++----
 drivers/md/dm-verity-target.c                 | 23 +++++---
 drivers/md/dm-writecache.c                    | 10 ++--
 drivers/md/dm.c                               | 29 +++++++---
 drivers/md/persistent-data/dm-block-manager.c |  2 +-
 include/linux/dm-bufio.h                      |  7 +++
 include/linux/dm-io.h                         |  3 +-
 31 files changed, 185 insertions(+), 112 deletions(-)

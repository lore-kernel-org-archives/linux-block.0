Received: from mail-ot1-f52.google.com (mail-ot1-f52.google.com [209.85.210.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFA8140DFC5
	for <linux-block@vger.kernel.org>; Fri,  1 May 2026 01:49:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777600191; cv=none; b=KnxAnTC03iIHN7qT/q7jXSNF4xBnah1mJTr3mf0pcrRcqdooNHJdMAX+wgR99fY4JRwqH+jGiSDvTVxJTji7AU+hh/iUHCTMM2/TjTQy3bZNK2j7uCbuIMhxmQ6wc5N63ppIPzJu4J4JpOPR76foe2FaHhFExua8M1Cd0HTo3OI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777600191; c=relaxed/simple;
	bh=DtcmzMOSDQyoKoHVaONzmMF/8yUdldk2V4ge9CCqbYk=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:Content-Type; b=J8TUA6vKkLyNux3UD8tFyZCyA9emycawedWo+n4wb5yhfXbMvn/q14GF6Xph35HZPvj6LwvzpqFwCpvSIkOzpvKMPmxjQecHpNV0PQGfVP6tCikeIgTu3gsEN84ppmjr/EbFkQ2OwFvUlJ+nrGOWmNRDRe+D9Xa2oGqLakgik2E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20251104.gappssmtp.com header.i=@kernel-dk.20251104.gappssmtp.com header.b=GEi/OuD9; arc=none smtp.client-ip=209.85.210.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20251104.gappssmtp.com header.i=@kernel-dk.20251104.gappssmtp.com header.b="GEi/OuD9"
Received: by mail-ot1-f52.google.com with SMTP id 46e09a7af769-7dcd689829eso1394249a34.3
        for <linux-block@vger.kernel.org>; Thu, 30 Apr 2026 18:49:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20251104.gappssmtp.com; s=20251104; t=1777600188; x=1778204988; darn=vger.kernel.org;
        h=content-transfer-encoding:content-language:cc:to:subject:from
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=g0NadobsOJURcksu6caN+g9FfxV++/d5xSzrG3QbT5g=;
        b=GEi/OuD9R1ZN/wao+YuVAi5TcKVdSoFX0bxeKfV8Hp2dhIGcYUxY9GBB8DpalLcxT0
         PeKqsNfECJtWrh4OPzpY6s1MZS3fk3pjBazA9FGGQGmXzWLWWChuIDq1HzM8LqEdJt66
         e7CB5Qn2MLLLvTswMc2VFotM/Qrw8VhVB62TShGitj4yWJayK/E5/Bs8Edpdx2cQSDze
         WyRTgSI073hZOhCnMEdCGBlZVxsgAHbBLvcY11ZHCfxTgOA8aI85AY9YI69/95t9W3SM
         +EQ9YmzIjDJOBgKcUETTSAitUSaG3fIqQeMbRBuUwwlVWMTEDp8CXnJPHZtv9GAXd8BT
         7Ndw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777600188; x=1778204988;
        h=content-transfer-encoding:content-language:cc:to:subject:from
         :user-agent:mime-version:date:message-id:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=g0NadobsOJURcksu6caN+g9FfxV++/d5xSzrG3QbT5g=;
        b=l8o9q6NMWAcfljx7IxJKBsuR1yD6QRedlfsBv3x/Bo/F6WpTZR5tNp3dTZccQquPLJ
         /Wqmvklp4DL06mn50Vdx87BWALl3hkTmFKd3BagWnzdvQpTxBTKyHb9rjJ0JC5N5lw+z
         tuYZHQ5UZEJhOuaWnL5ZYynu1F6XbOoi/XBV+JXkInh9jpsq4JJ0nlYY7HCO6V0BHOyf
         /N6QsshAeSsSrs6VclBYULYQbtpXdKJvIYjsBv292a4ZZpbEtJcFX0/wcI+oPOxvbMV5
         pUXMuBn2JcfhR2oK2Ghc25PyefCrew4SPHoca0JLvbIzQd8RHvCgDuwYWnYOEe4Oajgd
         34IQ==
X-Gm-Message-State: AOJu0YweUNLVypzOk64mEAdyi8wCUxmGhVteo1iZRR6xj7XXPzGpgSWG
	0L/miJj9oiH70RdvBjAri4thscoRgA+XKOYMiYjyYJd5V6UMfN7arwhOgaHUNXiqNmFfEWCspm8
	uqR5m
X-Gm-Gg: AeBDievB+jHqvhALrNt8HdJvz7D5uwwnV1/3oZgs7EhqA2c3ywtR7l2YwYpEI6h9P1Y
	i5J1xYJ0oYoz9R5cWRAb3wO6EcVyJhouNJUwVrJ+Izy2WV+YaMMMVxJXKeLLVafBMSumaYEMKxN
	4vRR3edJAG71PaWhrV7rm+uYWZZol11RkZHyh7iSPiBcOto1hfP8RBHtHunFM3c6xP74eODdcIE
	DGJhQdNRktaw1GEB7Q/7jw61JoLdXehbBdoqdwwTP3jzRlD4p/ksh/S/jwxML/S2//CrSFpwtLx
	IriDjx7PUy5xSIqa14n9K1k5W+Y57o/WW9c6jTT9lEcsY8vhVXWlPfhaoJIDBg4IptI90IT4WqF
	48jVa1msYS4vvhASVSp1ZFeZT7d66dB94uBdRzC3VydCP1PcXRYGXwxEM4ic20BOfwBeNIuypIU
	QOm90Zr+mtx2B9DwmjyqaSRKgaiOyPP+DxVHfJd9gt4TNVc2ri7QSM0G313Oun+f0UczUK/VClA
	6uElWFLDg6URHCqeFgBMvRoGuCHAXg=
X-Received: by 2002:a05:6830:490f:b0:7dc:a256:5e2e with SMTP id 46e09a7af769-7debdc3fc16mr2940344a34.1.1777600188592;
        Thu, 30 Apr 2026 18:49:48 -0700 (PDT)
Received: from [192.168.1.150] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7decac2633bsm1086062a34.16.2026.04.30.18.49.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 30 Apr 2026 18:49:47 -0700 (PDT)
Message-ID: <8549b9c4-487f-4d3e-8b23-8e83297d11be@kernel.dk>
Date: Thu, 30 Apr 2026 19:49:46 -0600
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Jens Axboe <axboe@kernel.dk>
Subject: [GIT PULL] Block fixes for 7.1-rc2
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Linus,

Set of fixes for block that should go into the 7.1 kernel release. This
is a bit larger than usual at -rc2 time, mostly because the nvme PR was
delayed last week, and hence it didn't make -rc1. This pull request
contains:

- MD pull request via Yu:
     - Fix a raid5 UAF on IO across the reshape position.
	- Avoid failing RAID1/RAID10 devices for invalid IO errors.
	- Fix RAID10 divide-by-zero when far_copies is zero.
	- Restore bitmap grow through sysfs.
	- Use mddev_is_dm() instead of open-coding gendisk checks.
	- Use ATTRIBUTE_GROUPS() for md default sysfs attributes.
	- Replace open-coded wait loops with wait_event helpers.

- NVMe pull request via Keith:
	- Target data transfer size configuation (Aurelien)
	- Enable P2P for RDMA (Shivaji Kant)
	- TCP target updates (Maurizio, Alistair, Chaitanya,
	  Shivam Kumar)
	- TCP host updates (Alistair, Chaitanya)
	- Authentication updates (Alistair, Daniel, Chris Leech)
	- Multipath fixes (John Garry)
	- New quirks (Alan Cui, Tao Jiang)
	- Apple driver fix (Fedor Pchelkin)
	- PCI admin doorbell update fix (Keith)

- Properly propagate CDROM read-only state to the block layer

Please pull!


The following changes since commit 254f49634ee16a731174d2ae34bc50bd5f45e731:

  Linux 7.1-rc1 (2026-04-26 14:19:00 -0700)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/axboe/linux.git tags/block-7.1-20260430

for you to fetch changes up to 7e36e03d192a5547757bd8f9d9052a60f64e6d17:

  Merge tag 'md-7.1-20260428' of https://git.kernel.org/pub/scm/linux/kernel/git/mdraid/linux into block-7.1 (2026-04-28 08:36:26 -0600)

----------------------------------------------------------------
block-7.1-20260430

----------------------------------------------------------------
Abd-Alrhman Masalkhi (5):
      md: replace wait loop with wait_event() in md_handle_request()
      md: use mddev_lock_nointr() in mddev_suspend_and_lock_nointr()
      md/raid1: replace wait loop with wait_event_idle() in raid1_write_request()
      md: use mddev_is_dm() instead of open-coding gendisk checks
      md: use ATTRIBUTE_GROUPS() for md default sysfs attributes

Alan Cui (1):
      nvme: add quirk NVME_QUIRK_IGNORE_DEV_SUBNQN for 144d:a808 (Samsung PM981/983/970 EVO Plus )

Alistair Francis (3):
      Revert "nvmet-tcp: Don't free SQ on authentication success"
      nvmet-tcp: Don't clear tls_key when freeing sq
      nvme-auth: Include SC_C in RVAL controller hash

Aurelien Aptel (1):
      nvmet: introduce new mdts configuration entry

Benjamin Marzinski (1):
      md/raid5: Fix UAF on IO across the reshape position

Chaitanya Kulkarni (3):
      nvmet-tcp: fix race between ICReq handling and queue teardown
      nvmet: avoid recursive nvmet-wq flush in nvmet_ctrl_free
      nvme-tcp: teardown circular locking fixes

Chris Leech (1):
      nvme-auth: Hash DH shared secret to create session key

Daan De Meyer (1):
      cdrom, scsi: sr: propagate read-only status to block layer via set_disk_ro()

Daniel Wagner (1):
      nvme: expose TLS mode

Fedor Pchelkin (1):
      nvme-apple: drop invalid put of admin queue reference count

Flavio Suligoi (1):
      nvme-core: fix parameter name in comment

Geliang Tang (1):
      nvme: add missing MODULE_ALIAS for fabrics transports

Jens Axboe (2):
      Merge tag 'nvme-7.1-2026-04-24' of git://git.infradead.org/nvme into block-7.1
      Merge tag 'md-7.1-20260428' of https://git.kernel.org/pub/scm/linux/kernel/git/mdraid/linux into block-7.1

John Garry (2):
      nvme-multipath: drop head pointer check in nvme_mpath_clear_current_path()
      nvme-multipath: put module reference when delayed removal work is canceled

Junrui Luo (1):
      md/raid10: fix divide-by-zero in setup_geo() with zero far_copies

Keith Busch (3):
      nvme: skip trace completion for host path errors
      nvme-pci: fix missed admin queue sq doorbell write
      md/raid1,raid10: don't fail devices for invalid IO errors

Maurizio Lombardi (2):
      nvmet-tcp: propagate nvmet_tcp_build_pdu_iovec() errors to its callers
      nvmet-tcp: remove redundant calls to nvmet_tcp_fatal_error()

Shivaji Kant (1):
      nvme: enable PCI P2PDMA support for RDMA transport

Shivam Kumar (1):
      nvmet-tcp: check INIT_FAILED before nvmet_req_uninit in digest error path

Tao Jiang (1):
      nvme-pci: add quirk for Memblaze Pblaze5 (0x1c5f:0x0555)

Xiao Ni (1):
      MAINTAINERS: Add Xiao Ni as md/raid reviewer

Yu Kuai (3):
      md: factor bitmap creation away from sysfs handling
      md/md-bitmap: split bitmap sysfs groups
      md/md-bitmap: add a none backend for bitmap grow

 MAINTAINERS                            |   1 +
 drivers/cdrom/cdrom.c                  |  73 ++++++++-----
 drivers/md/md-bitmap.c                 | 131 +++++++++++++++++++++---
 drivers/md/md-bitmap.h                 |   2 +-
 drivers/md/md-llbitmap.c               |   7 +-
 drivers/md/md.c                        | 182 ++++++++++++++++++---------------
 drivers/md/md.h                        |   6 +-
 drivers/md/raid1-10.c                  |   7 +-
 drivers/md/raid1.c                     |  15 +--
 drivers/md/raid10.c                    |   2 +
 drivers/md/raid5.c                     |   7 +-
 drivers/nvme/common/auth.c             |  94 +++++++++++++----
 drivers/nvme/host/apple.c              |   6 +-
 drivers/nvme/host/auth.c               |  16 +--
 drivers/nvme/host/core.c               |  16 ++-
 drivers/nvme/host/fc.c                 |   1 +
 drivers/nvme/host/multipath.c          |   4 -
 drivers/nvme/host/pci.c                |   5 +
 drivers/nvme/host/rdma.c               |   9 ++
 drivers/nvme/host/sysfs.c              |  19 ++++
 drivers/nvme/host/tcp.c                |  29 ++++--
 drivers/nvme/target/admin-cmd.c        |   8 +-
 drivers/nvme/target/auth.c             |  21 ++--
 drivers/nvme/target/configfs.c         |  27 +++++
 drivers/nvme/target/core.c             |  10 +-
 drivers/nvme/target/fabrics-cmd-auth.c |   9 +-
 drivers/nvme/target/nvmet.h            |  13 +++
 drivers/nvme/target/tcp.c              | 117 +++++++++++----------
 drivers/nvme/target/zns.c              |   6 +-
 drivers/scsi/sr.c                      |  11 +-
 drivers/scsi/sr.h                      |   1 -
 include/linux/cdrom.h                  |   1 +
 include/linux/nvme-auth.h              |   6 +-
 33 files changed, 587 insertions(+), 275 deletions(-)

-- 
Jens Axboe


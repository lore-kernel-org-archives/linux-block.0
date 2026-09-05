Received: from mail-oi1-f178.google.com (mail-oi1-f178.google.com [209.85.167.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 175D3399031
	for <linux-block@vger.kernel.org>; Sat,  5 Sep 2026 11:21:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788607276; cv=none; b=VIgvU8h3e6DJbKWcDbbDOCsFfeq9vV5xGUOa9ZfnNJKlqO38Yf1JRnMJsS/y4ttsqhCiWTG3HUtlREutkrDNCfg8ZmKIf/SvM00kScNE29dy3wKJlfOA4gy6n0kSvANpvDsIvrozXbU572/mgKKpMTjdydYWyaVW9e+smj5100g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788607276; c=relaxed/simple;
	bh=RfyuwMVEkIPCyjwkremVtQgiCOOr9UijVJJqJ7b2YF4=;
	h=Message-ID:Date:MIME-Version:To:Cc:From:Subject:Content-Type; b=E/ysuVm7LHoFu7qzyJaYDj97YXKEmxLA/nAKXyedT8bXKhtbeWAi6XXgxw5MTy73X48rqrFRqhYltIw+nqgjm7fqbl+IDFxzHZ6S3Wm9BV5rBTFdhP8xfj5bY8tkO1Z4KJqxf+j6yRszF4s3ZqbBwuO4elkl1UIomU+pwDWCTu0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20251104.gappssmtp.com header.i=@kernel-dk.20251104.gappssmtp.com header.b=HtJAM3Uk; arc=none smtp.client-ip=209.85.167.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20251104.gappssmtp.com header.i=@kernel-dk.20251104.gappssmtp.com header.b="HtJAM3Uk"
Received: by mail-oi1-f178.google.com with SMTP id 5614622812f47-4b1bf68b387so957525b6e.2
        for <linux-block@vger.kernel.org>; Sat, 05 Sep 2026 04:21:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20251104.gappssmtp.com; s=20251104; t=1788607270; x=1789212070; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:subject:from:cc:to
         :content-language:user-agent:mime-version:date:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=w6BsJWabD2hAm5XevES4IylNtR+GunCoFwlu4LcpNGw=;
        b=HtJAM3UkKAZ+UjsDMI6mwOlqcXmgmKXe31COWnjmiBng4gGuhXKTsDi6TEe+rwlgJI
         3kSwiNi8C7++/CjZfmZ7L5BkUcFM82we5Wkvl8Qf6/W3TsKw4aKbuvCFrcSS7W+SLUNB
         +9uhqGAD2q0wwD1di+FUq+XSEuX7toaB4y4vY1sy3CMhyPmOML2w7iwZm9Pfdo+DCp81
         Nt/z9nvRIG0ZavXvJw7HGAhs1LyMCKmMrEtQA4EEl3F2RSnnqwMjgiQtdAQcf7eDivdP
         jIzf52xDz/jkvHurhLZ5enBa2nPTyDiIy4F9YZXU8YfQWfTBRgyTgFq/fl22TIXuj0kX
         DTQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788607270; x=1789212070;
        h=content-transfer-encoding:content-type:subject:from:cc:to
         :content-language:user-agent:mime-version:date:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=w6BsJWabD2hAm5XevES4IylNtR+GunCoFwlu4LcpNGw=;
        b=odoQdgmvpG6RCFHPXz+7QrId7a34LCfTusY0Z6yQCl+YClGIDafMMW4f+pmthsfORy
         XXE0LsQwMnU3PvgWIS5w0/ju6zD6XHbSozZstYONBUz7t+7t7qVDPkOGp4LkVqfmBwiC
         LKkqgyzpb9xVlytFllIYLrW/L3kTPN0alLnAz1nEhiJ1XpI0sAaPXmRdwupN1UTif13Z
         zHPBXtzeQa1t/lbdtQwXX5C9dRF5L5W0u1Ynnpr8r525nhdxJepnNHXrkd1g6yaSV1XP
         zKWLdfi+iJlbLr6XCivsYmSnd74lVVuI7mGiQ9/p1NzQq49bYvmPrR8UY9AMo87ole5M
         j/Lg==
X-Gm-Message-State: AFuF++m1t4I96mrtqyZaSddRH6ldLA7K25kzEFzMRniL/N9Cz9D02F/O
	MDrNA1y3mRHc91qe1WBzPFa35he/qzZbvd3EYJmRcY9l6fBaY+spnH03+VG5Zq43Gl5Kg83Jj+e
	HzGR2+Qc=
X-Gm-Gg: AYBFou0lMRRtLrS4D/bsaj+MUgImoLQTxOjUdzOm5WXwGWD0HKF4SaK6Fs5415xcTzp
	6nIRdYfweROFt6JsNT6a/l7CeOlSTpsgQjqMIc5Odyq4lF4d/mjK7LvtLFlWxIQttP8p/xzJcSN
	I550Ss8nI05lcHy2sXz8Xp90KojS9dgS9t9e5oBfMkVGgOFizb2CauCHAKKvq8NNBG0lD/sFfce
	Eca5/yrSYySYwl8/Jpe+WpHLxhXEK1BtZZadiVDe7YI/DERqfjM5x1TSvs44gwZ/ds0fjCNSsK5
	gotjLUDw5b+FbtsiqPGAg7fFJz0r1r9buIOByg7z4POoGuPqc++I+qB05bGOqgQ4BcCExuOY74B
	3W2KNAdoYZdGg9Qtcj/UyWt8lzCcZR/79UoYZYJuX9BJo24MRaTutmUojYtZXw6H3B2fo8cV2t1
	5dC8hq3+F6pmNHby8FXqTdrJJ5dZSOE2TBiJzrfgtvFUvUcggJR5pxTijS31slF5Nvi+PuKKACX
	wlRrd2oFVQD1NvweN1k8NMr7il0UuqeVmJznvfLCe0O6AbFteOwBUBR1HcmxNtiP/Bg
X-Received: by 2002:a05:6808:13d5:b0:4b9:e5fa:8a11 with SMTP id 5614622812f47-4b9e5fa8db8mr5466021b6e.22.1788607270387;
        Sat, 05 Sep 2026 04:21:10 -0700 (PDT)
Received: from ?IPV6:2603:8080:db00:1767::15c4? ([2603:8080:db00:1767::15c4])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-4b971675f82sm4762297b6e.12.2026.09.05.04.21.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 05 Sep 2026 04:21:09 -0700 (PDT)
Message-ID: <fba0a84a-488f-43b7-b4da-0746180da780@kernel.dk>
Date: Sat, 5 Sep 2026 05:21:07 -0600
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
Subject: [GIT PULL] Block fixes for 7.3-rc2
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Linus,

Fixes for block that should go into the 7.3-rc2 kernel release. Mostly
NVMe fixes, but also other drivers fixes. This pull request contains:

- NVMe fixes via Keith:
	- nvme-tcp fixes for an out-of-bounds write on an over-long PDU
	- nvmet-tcp, nvmet-rdma and nvme-rdma leak and cleanup-ordering
	  fixes
	- FDP placement id array racy access fix
	- nvme-fc double free of fabrics options on nvme_add_ctrl()
	  failure, and a secret leak failure
	- Fault injection opcode filtering
	- stale namespace removal during scan
	- Various other smaller fixes and cleanups

- Flag zoned disks with GENHD_FL_NO_PART

- Save the page offset gaps in a cloned bio

- Fix dma_alignment for large or unreported limits in loop and zloop

- Clear VM_MAYWRITE on a read-only ublk char device mmap

Please pull!


The following changes since commit cee9395acd8043be0644b25c34bfa86623f2b935:

  Linux 7.3-rc1 (2026-08-30 13:34:40 -0700)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/axboe/linux.git tags/block-7.3-20260905

for you to fetch changes up to 00ef2248c5dae08548f7ceb6951b022f89905330:

  Merge tag 'nvme-7.3-2026-09-03' of git://git.infradead.org/nvme into block-7.3 (2026-09-03 19:48:07 -0600)

----------------------------------------------------------------
block-7.3-20260905

----------------------------------------------------------------
Chao Shi (1):
      nvme: skip the zoned limits update if the zone info query failed

Damien Le Moal (1):
      block: flag zoned disks with GENHD_FL_NO_PART

Jens Axboe (1):
      Merge tag 'nvme-7.3-2026-09-03' of git://git.infradead.org/nvme into block-7.3

Kanchan Joshi (2):
      nvme: set ns->head in nvme_alloc_ns_head
      nvme: fix racy access to FDP placement id array

Kanishka De Silva (1):
      ublk: clear VM_MAYWRITE on read-only ublk char device mmap

Kazuki Hanai (1):
      nvmet-auth: Synchronize timeout work during SQ teardown

Keith Busch (3):
      block: save page offset gaps in cloned bio
      loop, zloop: fix dma_alignment for large or unreported limits
      MAINTAINERS: update nvme entry

Mohamed Khalfella (4):
      nvme: add opcode filtering for fault injection
      nvme: remove stale namespaces by NSID range during scan
      nvme: print namespace IDs as unsigned 32bit value
      nvmet: print namespace IDs as unsigned 32bit value

Niklas Cassel (1):
      nvme-fc: fix double free of fabrics options when nvme_add_ctrl() fails

Randy Dunlap (1):
      nvme-tcp.h: drop kernel-doc comments, fix a few descriptions

Seokgyu Choi (1):
      nvmet: reject namespace enable without device path

Shivam Kumar (2):
      nvmet-tcp: fix out-of-bounds write when receiving an over-long PDU
      nvmet-tcp: reject unsolicited H2CData PDUs

Tristan Madani (1):
      nvme: add missing SRCU grace period in error path

Xixin Liu (3):
      nvme-rdma: fix -EIO cleanup order in queue_rq
      nvmet-rdma: fix queue leak when connect backlog is exceeded
      nvme-tcp: defer TLS inline send to io_work

Xu Rao (1):
      nvme-fabrics: fix DHCHAP secret leak on parse failure

Yehyeong Lee (2):
      nvme-tcp: check the data direction of a C2HData PDU
      nvme-tcp: return -EPROTO for a C2HData on a write

 .../fault-injection/nvme-fault-injection.rst       | 65 ++++++++++++++
 MAINTAINERS                                        |  2 +-
 block/bio.c                                        |  9 ++
 block/genhd.c                                      |  7 ++
 drivers/block/loop.c                               |  8 +-
 drivers/block/ublk_drv.c                           |  6 ++
 drivers/block/zloop.c                              |  8 +-
 drivers/nvme/host/core.c                           | 99 +++++++++++++---------
 drivers/nvme/host/fabrics.c                        |  2 +
 drivers/nvme/host/fault_inject.c                   | 14 ++-
 drivers/nvme/host/fc.c                             | 26 ++++--
 drivers/nvme/host/nvme.h                           |  2 +
 drivers/nvme/host/rdma.c                           | 18 ++--
 drivers/nvme/host/sysfs.c                          |  2 +-
 drivers/nvme/host/tcp.c                            | 12 +++
 drivers/nvme/host/zns.c                            |  4 +-
 drivers/nvme/target/auth.c                         |  6 ++
 drivers/nvme/target/configfs.c                     |  4 +-
 drivers/nvme/target/core.c                         |  9 +-
 drivers/nvme/target/nvmet.h                        |  2 +
 drivers/nvme/target/pr.c                           |  2 +-
 drivers/nvme/target/rdma.c                         | 15 ++--
 drivers/nvme/target/tcp.c                          | 10 +++
 include/linux/nvme-tcp.h                           | 18 ++--
 24 files changed, 260 insertions(+), 90 deletions(-)

-- 
Jens Axboe


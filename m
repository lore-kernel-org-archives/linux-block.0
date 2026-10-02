Received: from mail-oo2-f42.google.com (mail-oo2-f42.google.com [74.125.231.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 766E348643F
	for <linux-block@vger.kernel.org>; Fri,  2 Oct 2026 14:50:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.231.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790952616; cv=none; b=mzMEtAWAdIlwlOdIx7dc7JJD3NnU0rV0nqGlwP/NgjLV++HzIlOdzFnWc6sStUnrW4S3OWgYOhMxFvF/IdhnuggfXj5uVqq41RMKkth8GihCRgWUTbfDwRF/esZ4H1h4Oszie1ngd53BsRqBuKYtU3SfX2j04UU/NdjRkEk729g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790952616; c=relaxed/simple;
	bh=GoIGu+wB1q43xuG+LdcOwTO9LYFLXk1QZ5++plePqwU=;
	h=Message-ID:Date:MIME-Version:To:Cc:From:Subject:Content-Type; b=YI2i9AWSZgWGKpvS8Oc9UfCWvIbVGCj3/qfDFWgEPJ9nI1Z16YikjdpGmheaxB6HHMfz35E5efBsd+UK3o6Qa8hXzbi+NVGSHYuF2K6knwgIS2++CcPWmNygDvtNYGCyRVROkSSY4Evp/NhVQo4YGuCMhvTHjIuBYmj5fSyYth0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20251104.gappssmtp.com header.i=@kernel-dk.20251104.gappssmtp.com header.b=tOxvr6j3; arc=none smtp.client-ip=74.125.231.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20251104.gappssmtp.com header.i=@kernel-dk.20251104.gappssmtp.com header.b="tOxvr6j3"
Received: by mail-oo2-f42.google.com with SMTP id 46e09a7af769-81be5042c51so142398a34.1
        for <linux-block@vger.kernel.org>; Fri, 02 Oct 2026 07:50:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20251104.gappssmtp.com; s=20251104; t=1790952613; x=1791557413; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:subject:from:cc:to
         :content-language:user-agent:mime-version:date:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=iB5FlA1zvnKKRmCxed3WM+NQCuN6INMb+DWlDxqFuXY=;
        b=tOxvr6j361ju+oGq/amfwpdAD4GCQ8TYmZEY70AXFN/bXxHp0n5YwYtNVfi3ypeICb
         WQj2MlO5Qs6oCHd2pNCB7C9YOXzzCCKE0+dsnYShCZCpwzHzKqvPkF1TAIUega9BykpF
         ANT1N3bagvmmjVNuA/xJ0FUGtUeioQ5o/DhGq1WZG9eAimPBAq1WxOIAmsxJxTpxbYRI
         +xsRjubehd1TzYiTZ1qtsdSlKmXQ+FgHQtNf97OHbpgNBm9p+rVKjZG0jBwlLWIkh7Pc
         qeJfMdO5o6C5a32jQQDLZcmp50g584rZCbS+sftWdrivSzbSS7kRD8Tq6+nfQHWeuEJi
         xCnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790952613; x=1791557413;
        h=content-transfer-encoding:content-type:subject:from:cc:to
         :content-language:user-agent:mime-version:date:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=iB5FlA1zvnKKRmCxed3WM+NQCuN6INMb+DWlDxqFuXY=;
        b=nVdf2Div3c3L7E9xnriFLzCrupv3uEIRRurUZkV7Hs6f9VEdnqxE4q065xWKM50Sfr
         VCLANSajeK2va1t3qAXyIkiSyzerNKTpYR6b1o1+VSWFxizQn62Bm/2EDUFJtl9hNR0t
         AnklFghRlKddhnqlyCvZp0z/lJD0s4BjNfATYuWHOQytQslwsLpPgWY20UAXDzFnrmJn
         CtgOXkdtgC/pWm0jQMb6/UvlJQtXmsZ9lrQWOOCBMr8WzJSu/o/p538kZODCWtJzZeuz
         G+gaiOmAw0zT9YX8hEN4aRRqhOE7+OUDzkFsecikAwVKa1JrQIXiu/bbxMTTxxBC86Op
         zlrg==
X-Gm-Message-State: AFuF++m2qbgeRCzJTc/fmkDzpRbslyXAoJr11IIA9GX27DU6fUY0sFSX
	DBIhFAdRzNB3GbFZKuikxicQw2mhsNUI+zsNpphy4qjgfL97qaXGQXMLJ1iBfeQfsNGANbT7PwG
	XWknCtxM=
X-Gm-Gg: AYBFou0tbjy9BqhqI6iazwz7K3e1d3RP9JZyaCGLjwDgMQL+ekUlpBbO5F3+WMwfc5A
	59N3piRtowKFr0BMtc5UnM5u0jGGy6lhlAungQB1lSgASZjtLQwv3sKc00iO8nUSTMUmG9h93pz
	qz1vO0DFCpVT+KNfYwhUCC/k3aQ6gsk/cOlldVKqjRJZxxRoi+V/PIWnQstDsACC1WCPBHk7cZM
	EHitm7SkOgwBEnYMOyZzB0Pm1GTOYWtlSl7udCTdD0AvloN+FWF0/7itumKpTeLXgHdN6MX0LQu
	a/jB/PSUESlym9/SGd1puTxPx5NnMV1RgNatqHgYtHihDfFBlrRkqYgjo2mk0F780K/oBBjtELW
	zGyrQZMoZ6lmCjpVnLNb594WLS+3paR2vuRvW/FTi3PXUoyG3FOTLjbdoz75w5fStexqUChSEgh
	Q2/avpWmJf8aS7twakk6y2f7L0csog+imMP8g9fNqDwlogRz+Ty9IM+PKBKXkctrwOG0koDw654
	bpAov5k+h0gQSKRmaofUt+VTh7oDZzML/uuOvzjtuATWrwIlhau74c=
X-Received: by 2002:a05:6830:700d:b0:7f8:4ebe:2854 with SMTP id 46e09a7af769-8227f994594mr3444393a34.4.1790952613046;
        Fri, 02 Oct 2026 07:50:13 -0700 (PDT)
Received: from [192.168.2.38] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-82279d738bbsm3064215a34.15.2026.10.02.07.50.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 02 Oct 2026 07:50:12 -0700 (PDT)
Message-ID: <4fbdea09-538d-4be2-8492-bca0aa570e15@kernel.dk>
Date: Fri, 2 Oct 2026 08:50:11 -0600
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
Subject: [GIT PULL] Block fixes for 7.3-rc6
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Linus,

A set of block fixes for this week. Mostly NVMe via a pull from Keith,
but also a few core block and driver fixes. This pull request contains:

- NVMe fixes via Keith:
	- Fix an out-of-bounds write in nvmet_auth_challenge(), where
	  sizeof() on a void pointer undercounted the challenge header and
	  let a short AUTH_RECEIVE buffer pass the check
	- nvme-multipath fixes for an ANA log bounds check underflow, the
	  command effects log lifetime for multipath heads, and only
	  setting BLK_FEAT_ZONED after the zone info is known.
	- nvmet fixes for ns->enabled teardown ordering, rejecting I/O
	  after the percpu ns reference is killed, device path preservation
	  on allocation failure, and too-short SGL segments in pci-epf
	- nvme-tcp: revert the per-socket dynamic lockdep keys, and delay
	  the socket reclassification
	- A DMA pool alignment quirk for the Micron 4100AT
	- Controller state/reset race fixes, and -Wformat-security
	  workarounds

- blk-mq: set RQF_USE_SCHED when the operation is known, and allow
  cached requests to be used for flush operations

- Reject polled dio with user integrity metadata

- Save the IRQ state in blkg_tryget_closest()

- Set the zone write granularity in virtio_blk

- ublk selftest fixes

Please pull!


The following changes since commit 94b1a3ca9b8db3151f1416263704c159a9470da5:

  selftests: ublk: add batch IO cases to recover_03 (2026-09-10 20:19:21 -0600)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/axboe/linux.git tags/block-7.3-20261002

for you to fetch changes up to 684b413b5483f57c890c171b9400076a0143b918:

  virtio_blk: set the zone write granularity (2026-09-29 12:54:47 -0600)

----------------------------------------------------------------
block-7.3-20261002

----------------------------------------------------------------
Arnd Bergmann (3):
      drbd: remove unused drbd_nl_mcgrps[] array
      nvme: work around -Wformat-security warning
      nvme: work around all -Wformat-security warnings

Bean Huo (1):
      nvme-pci: add NVME_QUIRK_DMAPOOL_ALIGN_512 for Micron 4100AT

Daehyeon Ko (2):
      nvme-multipath: fix underflow in ANA log bounds checks
      nvmet: pci-epf: reject too-short SGL segments

Dirk Gouders (1):
      selftests: ublk: fix unused_result error

Eric Dumazet (1):
      nvme-tcp: delay nvme_tcp_reclassify_socket()

Guixin Liu (2):
      nvmet: copy the hostid into the ctrl before creating PR pc_refs
      nvme-multipath: set BLK_FEAT_ZONED only after the zone info is known

Hao Zhang (1):
      blk-cgroup: save IRQ state in blkg_tryget_closest()

Jens Axboe (1):
      Merge tag 'nvme-7.3-2026-09-25' of git://git.infradead.org/nvme into block-7.3

Julian Sun (1):
      nvmet: preserve device path on allocation failure

Keith Busch (2):
      blk-mq: set RQF_USE_SCHED when the operation is known
      blk-mq: allow cached requests to be used for flush operations

Maurizio Lombardi (2):
      nvme-fc: do not warn on controller removal race
      nvme: do not reset controllers in NVME_CTRL_NEW state

Niklas Cassel (1):
      virtio_blk: set the zone write granularity

Nilay Shroff (2):
      nvmet: defer setting ns->enabled to false in nvmet_ns_disable()
      nvmet: don't allow I/O admission after percpu ns reference is killed

Shin'ichiro Kawasaki (1):
      Revert "nvme-tcp: lockdep: use dynamic lockdep keys per socket instance"

Weiming Shi (1):
      nvmet-auth: fix out-of-bounds write in nvmet_auth_challenge()

Yang Xiuwei (1):
      block: reject polled dio with user integrity metadata

Yao Sang (1):
      nvme: fix command effects log lifetime for multipath heads

 block/blk-cgroup.c                     |  5 +--
 block/blk-mq.c                         | 63 ++++++++++++++++++++--------------
 block/fops.c                           |  5 +++
 block/mq-deadline.c                    |  2 +-
 drivers/block/drbd/drbd_nl_gen.c       |  4 ---
 drivers/block/virtio_blk.c             |  1 +
 drivers/nvme/host/core.c               | 63 +++++++++++++++-------------------
 drivers/nvme/host/fc.c                 |  2 +-
 drivers/nvme/host/multipath.c          | 19 +++++-----
 drivers/nvme/host/nvme.h               |  9 ++---
 drivers/nvme/host/pci.c                |  2 ++
 drivers/nvme/host/sysfs.c              |  4 +--
 drivers/nvme/host/tcp.c                | 39 +++++++--------------
 drivers/nvme/target/configfs.c         |  9 +++--
 drivers/nvme/target/core.c             | 33 +++++++++++-------
 drivers/nvme/target/fabrics-cmd-auth.c |  2 +-
 drivers/nvme/target/nvmet.h            |  2 ++
 drivers/nvme/target/pci-epf.c          |  3 ++
 tools/testing/selftests/ublk/kublk.c   |  2 +-
 19 files changed, 139 insertions(+), 130 deletions(-)

-- 
Jens Axboe


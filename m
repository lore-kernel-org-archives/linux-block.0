Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.161.45
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795187548;
	b=miZblUmO8W+GnLl8fpjwxGHrpiUqktD44nv5mwcYYMmhU1r+uQv1dSu87IbFpNRsN0Z7
	 RodUQsFqsIPQoYPHhC3p/788lQbBfzG/DzjrDxmCB39L0Q6IClS19DGYYOG+SnbYUgbZd
	 JjdQJ7EckEpOEsCCJp0XA47etJDdb7/Wn0lMrk+6pO3NmARnvftV2GJfiYZ6co47HWR6N
	 WBIjczpKgh3KSwAV4405Mh1kot8OoZfm6H9KQWFrk5ZE//h6qiwp26O45V5k/Eiaz5mUv
	 B0utQaGFgm7IAP4dBfB8fV2VSsiX1ylfoXXJTHAsizOWgkmvUKPX/LUNX9nwOad9k2g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795187548;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-ID:Date:
	 MIME-Version:User-Agent:Content-Language:To:Cc:From:Subject:
	 Content-Type:Content-Transfer-Encoding;
	bh=4/XB7/ii8GGwN2kt9dFulMXW5d5ELFSMNOsKrqySvhk=;
	b=bRAjESgyrYXUjveRjNQET13F2u3QM13ATmID1hfE8oZ2BKmoTFOP/hPWtqZOjuKdKMBF
	 oG395hWnSjM9FPqc1zXUaKSkKxiAhKRjfgwM/rwi1c7J3qmTh2vwxQ/W7Yox7NTdRMVyp
	 HA1IZmMYN3gby6T3aQwMcv6JXjLRJy22DLho+JOcAuAFpEwLBw81jUKmRXxzK298gaviU
	 rYOWF3wgZVQLLQenYvMrMdMcY3kE1o2y/PV/xe6ZUWLLwHPKiLH55YpVFd/S0PLkx1zIO
	 FjFr9e0TrS3cbdhu+KLui6/oCyAEkr7awMr0ikKaP4kM2bOys58voD1sFVZn/7kafog==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=kernel.dk;
	spf=pass smtp.mailfrom=kernel.dk;
	dkim=pass header.d=kernel-dk.20260707.gappssmtp.com header.i=@kernel-dk.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=MN7L8ldz;
	arc=none smtp.remote-ip=209.85.161.45
Received: from mail-oo1-f45.google.com (mail-oo1-f45.google.com [209.85.161.45])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 475A8606A33E
	for <linux-block@vger.kernel.org>; Fri, 20 Nov 2026 15:12:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 475A8606A33E
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20260707.gappssmtp.com header.i=@kernel-dk.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=MN7L8ldz
Received: by mail-oo1-f45.google.com with SMTP id 006d021491bc7-71ac9e15640so602973eaf.3
        for <linux-block@vger.kernel.org>; Fri, 20 Nov 2026 07:12:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20260707.gappssmtp.com; s=20260707; t=1795187547; x=1795792347; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:subject:from:cc:to
         :content-language:user-agent:mime-version:date:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=4/XB7/ii8GGwN2kt9dFulMXW5d5ELFSMNOsKrqySvhk=;
        b=MN7L8ldzdo2g7ovKK9sis/3/sLz3hTIOLLKtLCrdkEWP+muAg8XXeSHYQL7fbS8UhN
         b7/keyGcLkOcjCv89vXJ1LsUHPNaVAiP6xrGz3biIxt0bL8nOq6c1h9YIT3/VpvLzg83
         vH9BC1qwBHHLv87srxHKfoezDsOeH0Txw3q5UB0g18GJPK08wGz8hrZP1+1P3dQsEy9e
         6/wC+4Sm+vVRVzBuMHRUvGMYidOrgab+1LoqxBxOzn4IoE1Lg+MOSVlOiizIr1+BO6bW
         WiaGZ1d2FvS5LnS/Cg/rJp3vFgDq+ga52jO10xMVrGbuvOnl9Fs1dmUfpLDaeW28Ps+s
         bfIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795187547; x=1795792347;
        h=content-transfer-encoding:content-type:subject:from:cc:to
         :content-language:user-agent:mime-version:date:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=4/XB7/ii8GGwN2kt9dFulMXW5d5ELFSMNOsKrqySvhk=;
        b=bLvkG2e5UyIoHUzSDnm3ub4f8o3QZFHm49s35bVIOMPh+q7tAmVfEi/g03UHr8WIMM
         D+6GguchsMmbrxeel6AE9HVro2KMMbU52Bx586DxqGwKOIpUdkIKv1XflOZ5lzy7Anh/
         aJeACM2jKdj4MG3raSO5g8DSGf26da18bvuc1MBuKfJ/xraie64OVaZ7Cw6sDPz/Dx4K
         edDjRhrzM5TyZORpCx7+D6YjpMxZnM4EiXdBq3H48HV+uwA1xG31/XvAmcSWXzx8nRFX
         pURf/8sD70u/npNGacIhuPmqNFhx6dzomMiH0UI9WPPz8aSZnDMYF02ZbgdulTfjl3A8
         n/4A==
X-Gm-Message-State: APuU4Z9vCbrCKfZ8FI7sRxeYGo+50V/28FlDWsNljqXPX99FbgE2nt39
	Z9cR/RUMMI47pdfAXllmnaOizca53Q8ohtAbf3/NXmlQtOeWw/+EraQtr/nAMCIChNFCRTagFyG
	oFUOeB1o=
X-Gm-Gg: AYBFou1P1Tl308ynjy8PqtbLagY7ZihovrhqxE3NUpspUpci//aGT4H0LYggx84vSyR
	N3Q62mbuJae6Cj+8TjAO+Hk2fgGNwerEa3mwM6Irx4k1CD9P2ZyVrAjBR+BuksuLh4mYNlVJPls
	ioxuYOwUYsrAaCXLMZ346Xe/AsuVR5XYWgPAsMUI+haFiG0LciT7Va+HJ5kD0kU10xSHZs67/5C
	ghwbwYDYJaEFPTNZn43vuQanYsGBZGmIqBpBRhvzUDpC1vDqznU8EobD3W3wb+YGWUJm7R/p6WM
	W4hBvi2FYrB/tXCFDDxaLUOZk2d+8o5gSyW2G9/Hdg2d+wCrIolqqmpuZkSG5OGx23wR938KJci
	V8txz4jnnNCcTwi+5Dw3ttVE25lNGbuzqfoOrzLLwA2lc1XRu7MD3Krv1ugbedZWwqb3wTxGGXE
	CSeMP+ghU3GSux0u0o/0gq11CJ2DzTS5G35zjyaSmhUeNAKtszz0etNZGQKQLT1QwmV8Aii969K
	SSVut6OD8WbU8eAkCtkxuCHeSJK+/DfV1wlINDITcH8BRQNJ3ZsCj9IIsyJnGH8M7hCmTnNoOSN
	ekljRLdJEfsqFOaGQfXtShL/2rpF8FJOBwPhNmLLspuSWr9dRmHNHTsIAVLdi4busC90emGHdhe
	ztEACQX321xTsDaaeZjf9/WRuhypESuRqd8RXkb3aPBZ+pO3w
X-Received: by 2002:a05:6820:c2c4:10b0:71a:cf47:2b68 with SMTP id 006d021491bc7-71b39402640mr1813472eaf.20.1795187547032;
        Fri, 20 Nov 2026 07:12:27 -0800 (PST)
Received: from [192.168.0.102] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-8631681f30asm2207116a34.1.2026.11.20.07.12.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 20 Nov 2026 07:12:26 -0800 (PST)
Message-ID: <1ed7b839-af3c-4471-9c5a-b83fc1af3919@kernel.dk>
Date: Fri, 20 Nov 2026 08:12:25 -0700
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Post: <mailto:linux-block@vger.kernel.org>
List-Help: <mailto:linux-block+help@vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-block+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
From: Jens Axboe <axboe@kernel.dk>
Subject: [GIT PULL] block fixes for 7.4-rc4
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Linus,

block fixes for this week. This pull request contains:

- NVMe fixes via Keith:
  - nvme-tcp fixes for TLS record handling and waiting for an in-flight
    TLS handshake callback
  - Fix a deadlock on nvme_subsystems_lock in nvme_init_subsystem()
  - Fix a gendisk leak in nvme_alloc_ns()
  - Stop AEN work before ANA teardown
  - Remove namespaces in parallel
  - Various nvmet fixes for auth, the file backend, fc, tcp, loop, and
    connection failure rollback
  - sysfs input validation and kfree_sensitive() for DH-HMAC-CHAP
    secrets
  - Dead code removal

- Fix a 32-bit overflow in the blk-iocost donation weight calculation.

- ublk fixes: validate all parameters for zoned devices, and dispatch
  the next fetch after a batch failure.

- Fix a pm_only underflow when a runtime resume is retried after a
  failed one.

- nbd: reclassify sockets in the reconnect path too, to avoid lockdep
  false positives.

- Take quiesce_lock when removing a queue from the tag set, fixing a
  use-after-free in blk_mq_unquiesce_tagset().

- Allow error injection rules to delay bios, and reject unknown status
  tags.

Please pull!


The following changes since commit 7cc2dda4f7aaf596c1796184649007151ff98f8d:

  s390/dasd: Don't trust userspace-supplied result field in format check (2026-11-12 09:18:12 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/axboe/linux tags/block-7.4-20261119

for you to fetch changes up to 5a29cfaf51105039d156dd8a61d2783e8b653667:

  Documentation: block: document error injection delay feature (2026-11-18 09:06:32 -0700)

----------------------------------------------------------------
block-7.4-20261119

----------------------------------------------------------------
Alex Kazinsky (1):
      blk-iocost: Fix overflow in donation weight calculation

Andrew Stellman (1):
      nvmet: accept ANA group ID NVMET_MAX_ANAGRPS in configfs

Avi Weiss (1):
      nvme-tcp: wait for in-flight TLS handshake callback

Guilherme Giacomo Simoes (1):
      nbd: Reclassify sockets in the reconnect path

Guixin Liu (10):
      nvme-pci: remove write-only NVMEQ_DELETE_ERROR flag
      nvme-fc: remove dead seqno field in nvme_fc_queue
      nvme-auth: remove dead entry field in nvme_dhchap_queue_context
      nvme-fabrics: remove dead hostnqn already-assigned check
      nvme: drop unreachable "off" case in reconnect_delay_show()
      nvmet-fc: remove dead fields in nvmet_fc_ls_iod and nvmet_fc_tgt_queue
      nvmet: remove unreachable "pcie" entry from the address family map
      nvmet: passthru: remove unreachable break statements
      nvmet-pci-epf: don't drain the never-populated SQ list
      nvmet: use GFP_KERNEL for PR allocations

Jens Axboe (1):
      Merge tag 'nvme-7.4-2026-11-17' of git://git.infradead.org/nvme into block-7.4

Kyle Smith (1):
      nvme: Fix potential gendisk leak in nvme_alloc_ns

Mani Tofigh (2):
      nvme: fix deadlock on nvme_subsystems_lock in nvme_init_subsystem()
      blk-mq: take quiesce_lock when removing a queue from the tag set

Martin Belanger (3):
      nvme-tcp: use an aligned buffer for the TLS record type
      nvme-tcp: move the TLS record read loop into a helper
      nvme-tcp: consume TLS records without application data

Martin George (2):
      nvme-sysfs: use kfree_sensitive() for DH-HMAC-CHAP secrets
      nvme-fabrics: use kfree_sensitive() for the old DH-HMAC-CHAP secret

Md Haris Iqbal (3):
      block: Reject unknown status tags in error injection rules
      block: allow error injection rules to delay bios
      Documentation: block: document error injection delay feature

Platon Miller (1):
      nvme-pci: merge duplicate 1d97:2263 entries in nvme_id_table

Qiliang Yuan (1):
      nvme: remove namespaces in parallel

Shao Mingyin (15):
      nvmet: zero the entire Get Log Page transfer buffer
      nvmet: zns: return the namespace lookup error for Identify
      nvme: reject invalid reconnect_delay sysfs values
      ublk: validate all parameters for zoned devices
      ublk: dispatch the next fetch after a batch failure
      nvme-auth: use the parsed offset for the DH-CHAP key
      nvmet: handle short reads and writes in the file backend
      nvmet: use overflow-safe range checks in the file backend
      nvmet-auth: store the DH-CHAP key offset instead of hardcoding it
      nvme-loop: release the target request when SG setup fails
      nvmet-tcp: only wait for in-capsule data for inline SGLs
      nvme-tcp: require the R2T offset to match the data sent
      nvmet-fcloop: free the LS request when delivery fails
      nvmet-fc: reject duplicate queue IDs on Create Connection
      nvmet: roll back queue bindings on connection failure

Sreeraj S Kurup (3):
      nvmet: clean up DH group state on initialization failure
      nvmet: reject invalid write-protect feature values
      nvmet: synchronize DH-CHAP secret removal

Stanley Jhu (1):
      block: Keep RPM_ACTIVE in blk_pre_runtime_resume() when already active

Yaohan Li (1):
      nvme: stop asynchronous event work before ANA teardown

Yingjie Wang (1):
      nvme: avoid wrapping admin_timeout and io_timeout

Yuho Choi (1):
      nvme-pci: shut down the controller if disabling the HMB fails on suspend

 Documentation/ABI/stable/sysfs-nvme     |   3 +-
 Documentation/block/error-injection.rst |  39 +++++-
 block/blk-core.c                        |  14 +-
 block/blk-iocost.c                      |   3 +-
 block/blk-mq.c                          |   3 +
 block/blk-pm.c                          |  13 +-
 block/blk.h                             |   2 +-
 block/error-injection.c                 | 150 +++++++++++++++++---
 block/error-injection.h                 |   1 +
 drivers/block/nbd.c                     |   1 +
 drivers/block/ublk_drv.c                |  35 +++--
 drivers/nvme/common/auth.c              |   6 +-
 drivers/nvme/host/auth.c                |   1 -
 drivers/nvme/host/core.c                |  44 ++++--
 drivers/nvme/host/fabrics.c             |  10 +-
 drivers/nvme/host/fc.c                  |   1 -
 drivers/nvme/host/multipath.c           |   7 +
 drivers/nvme/host/nvme.h                |  13 +-
 drivers/nvme/host/pci.c                 |  35 ++---
 drivers/nvme/host/sysfs.c               |  17 +--
 drivers/nvme/host/tcp.c                 | 175 +++++++++++++++++++-----
 drivers/nvme/target/admin-cmd.c         |  52 +++++--
 drivers/nvme/target/auth.c              |  83 ++++++-----
 drivers/nvme/target/configfs.c          |   9 +-
 drivers/nvme/target/fabrics-cmd.c       |   3 +
 drivers/nvme/target/fc.c                |  16 ++-
 drivers/nvme/target/fcloop.c            |   2 +
 drivers/nvme/target/io-cmd-file.c       |  47 +++++--
 drivers/nvme/target/loop.c              |   1 +
 drivers/nvme/target/nvmet.h             |   2 +
 drivers/nvme/target/passthru.c          |   2 -
 drivers/nvme/target/pci-epf.c           |   2 -
 drivers/nvme/target/pr.c                |  10 +-
 drivers/nvme/target/tcp.c               |  42 ++++--
 drivers/nvme/target/zns.c               |   3 +-
 include/linux/blk-mq.h                  |   3 +-
 include/linux/blk_types.h               |   1 +
 37 files changed, 615 insertions(+), 236 deletions(-)

-- 
Jens Axboe


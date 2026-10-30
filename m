Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.175
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793368214;
	b=Qyi0Dt4OTdPcJ182fLRoI/7tZVVTqBax1uAkgbjnFL2i6oZOzoajPYqD04MlIm73Trnr
	 +LlSrVxiMlWdCBsvMYFCaauS/jDHe6BTQrcPEeo6+j1BG/48LFl40Inx5kZt68aER35F9
	 KPTIgAVF/Ydni3FhKR9xKkZ6vlrEqI1/g8Gf01QOcAdd2aVs+CFcT0XSgwBSHrY+Uc6nC
	 qhAKBd9Flo1Nm1jw1+6CKzZy8jYoJ+6Q2LqvWSZNRf4Me2RA8dxfUgjHxqxYC69KElhjB
	 4eE8qUKkA7GB3z1Fpprkkx+UiLxRFR6IezOPmNdPPmQPkr8E56J0dN3RwYNIiz3fgqQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793368214;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-ID:Date:
	 MIME-Version:User-Agent:Content-Language:To:Cc:From:Subject:
	 Content-Type:Content-Transfer-Encoding;
	bh=4+kZEoyi5rvv0STlWa1XknWaXqfHb7i0F9azHDXu1DU=;
	b=Z/ZVieVPtnsdSG3NuIDHizCGPwJ1wDMwmQzGWrUz7wT9EnnGRHyR/VCmVNaTQfXIAI9u
	 6sBuXJBEXfhJFT019rEUiroGIPa0dFSex9ico3k9q/Iynv/tFpo2TGGKn+22NgXTosaH0
	 CthP1la8VxQsnGdZrYwF9Lmonj+qjCL+qVFJNzBDLVAyKN0vco7DZ6UtigLm3HHChiMgH
	 OIMr+TdpxUoUEeAW82MyGXGY+Ove4xb8pNukgkXS3zwDZnZctgvHZj4M1gO7DGgZKgirV
	 ymSI+IFA2QvHgk9cQfoL2XKy8B95msU6B1uOs4IgmT/5G2WqKIrRQ4spgdQu6GkpWpg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=kernel.dk;
	spf=pass smtp.mailfrom=kernel.dk;
	dkim=pass header.d=kernel-dk.20260707.gappssmtp.com header.i=@kernel-dk.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=ii5VW7CP;
	arc=none smtp.remote-ip=74.125.82.175
Received: from mail-dy1-f175.google.com (mail-dy1-f175.google.com [74.125.82.175])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 901A1606A31A
	for <linux-block@vger.kernel.org>; Fri, 30 Oct 2026 13:50:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 901A1606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel-dk.20260707.gappssmtp.com header.i=@kernel-dk.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=ii5VW7CP
Received: by mail-dy1-f175.google.com with SMTP id 5a478bee46e88-36a18fc7a38so1857819eec.1
        for <linux-block@vger.kernel.org>; Fri, 30 Oct 2026 06:50:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20260707.gappssmtp.com; s=20260707; t=1793368213; x=1793973013; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:subject:from:cc:to
         :content-language:user-agent:mime-version:date:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=4+kZEoyi5rvv0STlWa1XknWaXqfHb7i0F9azHDXu1DU=;
        b=ii5VW7CPrYCTrCla9P+GsMln+cMKm5b7hA0yRPtWIic4NSAW7JOCVzakYt0+x0qATc
         3Qp6neDFlFenUk1VdjiPeLtGRi+eqZDcgJl08+2FyzB+7FOhz/p8wCzxIsEsrtHNk6lS
         8UQmQoGa4FB+pMIJmbdFCk82xITdbQtf8ZKHgbXaP+Yow01cs1/anHieMIi6OYfkcJyf
         nMUWj37ULBRsPIw2lbzYUinf3FwSmglZ8eixVhfxk01YKBArbTi16sAd82tPZOLX1/D6
         V9SG6hG1TzQ7u5NWooZKYoU9NoZEjY/4vIIap8nOf+p9ftDSP568248czjhVMrGU2h8k
         kkhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793368213; x=1793973013;
        h=content-transfer-encoding:content-type:subject:from:cc:to
         :content-language:user-agent:mime-version:date:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=4+kZEoyi5rvv0STlWa1XknWaXqfHb7i0F9azHDXu1DU=;
        b=euIPbiCa6d2piwy0BBzS+SD6FVQ1s8iUvTXkGI3KOXkDFg6C+IZPTXdnSRWGHC1Tut
         fDn/xtWNcb4dqkEmtdo9l1x11iB803laTAXpoTyySBvdQvmU/A3uR7ydQitxy1M+WwRM
         Qsv3bWLA2r2cNJpAHzHSHpypZuXcNqt6dZ0GGA0w9e2+J7eS5sLRmCF2wvZJF2bGYFgM
         rXQFfp4xYZAtfsRlaiBVahQN7ylYqFqemmDlaGO5gE0AAKIET5n4FQN8Rwip7PLjLU4S
         IpkDr8+lyWHDcKPVUghZ6PfcJrpErC3CaaGYBrk8NHMLiAeTuo7pqVkaWQluFYSqExen
         9uGQ==
X-Gm-Message-State: AFq9FYKsl/nh007yqOmwQQQtGrhL1qQVEuatKE8OivltERL00F+LFc+b
	6wdJWGpO4JWkM4cpyTo4wMuFjC28VsoBvEEadQWSYMWehzsY1CKKnc1WUaVrdED6oF4/MQ345hO
	uEvxpM/8=
X-Gm-Gg: AYBFou1S03rjCSocbktB/T75ilgR3sms8NivJiAWvRiW/twgEtt3Adw6i7cdEYKZrRt
	DdXSO6wCCEeUSSQf8tYQcjNHs4d3muL5JH3DUQT1zIpREd3uPGSMNDcfwabGtVeTWZLhpCuaxzf
	0CDlfDhLuTubkFLYx9ojoP8DCoxYWd9rXNejlue0qL7aklkdCT2CwNqmrC9wYgybMKuRcREnGZT
	v/kY64I0zENoOQ2/ke+Gl/gYKL8Viw7/XqOecnI5YJAQy7xDHDZNvqvZgd0DayU/ojVq4/L/VHW
	KPd5vVg10U6Sze1maC0XVEnH2IY74FMS8obJEtDjmhEjwnbKXxWFhdKAUdzvHqQp5hMA7nje9pu
	kV2brzy2atghrUWgq0Kad1mUwMjp0yh4oTZ/gTWcBR3vvm+2A9s59vaG1gGYkuz1aPzSMYibQ1x
	/T1fCC+2jl9iGm81t6TGWaL3KSdbIfC191LyoQsJ5OzjoO29vfmVP+fOwWHTBwqHVzDh21XHEmw
	xmSEFHYjE6imEQp4+hcb38J+g3wRFPhpcdCIsCIbWVdX1keBBUiKF7V36aREUI/cb+9jJW2TVOy
	rHe5SThQdRbc/0tOTdFcrKY8+NqOX0hZaRkcjAVxwOYhLC3Z5XRluPsx5/KApXACmi/9LZnp32O
	TWV2FqOMPqp+W
X-Received: by 2002:a05:693c:638e:20b0:369:f18f:34ab with SMTP id 5a478bee46e88-36a4235f6bamr3782374eec.11.1793368212508;
        Fri, 30 Oct 2026 06:50:12 -0700 (PDT)
Received: from [192.168.1.106] ([198.8.77.135])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-36a42669128sm8541458eec.3.2026.10.30.06.50.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 30 Oct 2026 06:50:10 -0700 (PDT)
Message-ID: <27b58e47-723b-4d67-a1f0-ccb8b0ae66a9@kernel.dk>
Date: Fri, 30 Oct 2026 07:50:09 -0600
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
Subject: [GIT PULL] block fixes for 7.4-rc1
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Linus,

Bigger than usual for an end-of-merge-window pull request, main reason
being that the MD side I had missed a pull on, and both NVMe and block
got a good pile of LLM driven fixes where some of them may as well just
go in now rather than wait a full cycle. This pull request contains:

- NVMe fixes via Keith:
  - nvme-tcp fallout from the parallel queue allocation: initialize
    pf_cache_lock and the header digest before requests are set up,
    and don't dereference a NULL queue->ctrl on reconnect
  - nvme-fabrics queue mapping fixes: reset io_queues on reconnect,
    limit each queue type to the online CPUs, and clear a poll map
    with no poll queues
  - nvme-tcp io_work priority inversion with send_mutex held (Seiji),
    error recovery on read_sock failure and skipping TLS control
    records while waiting for the ICResp (Martin B), TLS handshake
    timeout validation, and an address attribute race
  - nvme-rdma NULL metadata_sgl dereference with T10-PI
  - nvme-pci early boot hang with the quirks parameter
  - nvme-multipath ANA log bounds underflow, and an nvme-fc discovery
    reference leak
  - nvmet hardening: rdma inline SGL out-of-bounds write and short
    connect requests, fc use-after-free in LS create connection and
    teardown on admin queue failure, pci-epf transport error reporting
    and SGL length checks, zns NUMD wrap, fc stale read data, auth
    state and status fixes, ports list and qid_max locking, rdma
    double puts and irq-safe locking, and a double free on metadata
    SGL allocation failure
  - nvmet fixes from Josef: big discard length truncation, NULL derefs
    for PCI endpoint targets and debugfs host_traddr, stop listening
    when a tcp port is removed, and don't BUG() in nvme-loop when a
    scan runs beside a reset

- MD fixes via Yu Kuai:
  - raid5 validation: reject too few disks, invalid reshape disks, a
    per-device size below one chunk, and an inconsistent reshape state
    from the superblock instead of BUG(), plus journal payload size
    checks
  - raid5 error path and lifetime fixes: extra_page leak and NULL
    derefs in free_conf/setup_conf, draining released_stripes before
    destroying the cache, RCU for the big_stripe_tree lookup, and
    per-array io_unit slab names
  - md core: reject v0.90 arrays with too many devices, validate
    bblog_size, take reconfig_mutex when enabling PPL, fix the
    mddev->private NULL deref when stopping an array under IO, and
    don't hand out the array before mddev->kobj is added
  - raid10 missing barrier wakeup, raid0 device count validation, a
    bogus mddev_unlock() in lbs_store(), and shared helpers

- blk-mq fixes from Josef: don't trust the bio cookie in blk_mq_poll(),
  keep tag sharing fair after a queue update, don't bring back flags of
  a completed request from the timeout handler, honor a restarted
  timer, initialize the dma state for P2P, quiesce a queue joining a
  quiesced tag set, set up and exit hctxs under tag_list_lock, and free
  the tag bitmaps in the SRCU callback

- blk-cgroup and friends from Josef: keep the old blkg while
  reassociating a bio, free struct ioc after a grace period, don't
  truncate v1 iops limits, fix root io.stat on 32-bit, don't free a
  blkg with its punt work queued, flush iolatency enable_work after
  going offline, pass dead group I/O counts on and make reset_stats
  reset them, and don't enter reclaim under rq_qos_mutex

- Other core fixes from Josef: a disk use-after-free in sync_bdevs(),
  not losing the status of a failed flush request, 64-bit sector math
  for mac partitions, and applying the segment size to the integrity
  buffer

- blk-iocost: abort a weight transfer on invalid donation weights, and
  publish hweights as one atomic value

- Fix a NULL deref and use-after-free in __blk_crypto_evict_key(),
  reachable via dm-inlinecrypt

- Fix recursive i_rwsem locking in blkdev_write_iter(), from two fixes
  for the same race landing in the window

- Advance the iterator after copy-in for SG_DXFER_TO_FROM_DEV, fixing
  an infinite loop in blk_rq_map_user_iov()

- Check the open mode for LOOP_SET_STATUS in the compat ioctl

- rnbd-srv use-after-free and kobject fixes

- drbd timer and req_lock fixes

- zloop cleanups and error path fixes

- cdrom header and kernel-doc cleanups

Please pull!


The following changes since commit 330517c63aa9b48227b6ab45f01003effac77ae4:

  Merge tag 'char-misc-7.4-rc1' of git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/char-misc (2026-10-24 15:44:26 -1000)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/axboe/linux tags/block-7.4-20261029

for you to fetch changes up to c8c53d669d4e45b3a804013251a34387d7e11bfb:

  blk-crypto: fix NULL deref and UAF in __blk_crypto_evict_key() (2026-10-29 11:10:05 -0600)

----------------------------------------------------------------
block-7.4-20261029

----------------------------------------------------------------
Andrea Parri (4):
      nvmet-fc: only send read data for successful commands
      nvmet: zns: reject a NUMD whose byte count wraps
      nvmet: pci-epf: report transport errors in command completions
      nvmet: pci-epf: require SGLs to match the command data length

Andrew Stellman (1):
      nvmet-rdma: fix out-of-bounds write in nvmet_rdma_map_sgl_inline()

Avi Weiss (1):
      nvmet: prevent double-free after metadata SGL allocation failure

Baokun Li (1):
      blk-crypto: fix NULL deref and UAF in __blk_crypto_evict_key()

Cao Guanghui (2):
      md/raid5: track disks array size to fix extra_page leak on error paths
      md/raid5: fix NULL pointer dereference in raid5_free_percpu

Chandradhar Kumar (1):
      md/raid0: validate device count before allocating devlist

Chen Cheng (3):
      md/raid5: reject raid4/5 arrays with too few disks
      md/raid5: extract min_raid_disks()
      md/raid5: reject invalid reshape disks in raid5_run()

Chris Mason (6):
      nvmet-rdma: flush nvmet-wq on module exit
      nvmet-rdma: disable interrupts under rsp_wr_wait_lock
      nvmet-rdma: fix double puts after a failed RDMA WRITE
      nvmet: don't clear sq->ctrl for a Connect with sqsize 0
      rnbd-srv: fix use-after-free on two CLOSE messages
      rnbd-srv: publish the sess_dev at the end of OPEN

Christian Aurich Zanettini Martins (3):
      nvme-rdma: fix NULL metadata_sgl dereference with T10-PI
      nvme-tcp: fix request PDU size when header digest is enabled
      nvme-tcp: fix NULL queue->ctrl dereference on reconnect

Christoph Hellwig (4):
      zloop: remove a duplicate call to zloop_get_block_size
      zloop: share more code for opening a zone backing file
      zloop: fput file after failed zone init
      zloop: check that the zone backing file support ->{read,write}_iter

Daniel Wagner (4):
      nvme-tcp: initialize pf_cache_lock when allocating the controller
      nvme-fabrics: reset io_queues before computing the queue mapping
      nvme-fabrics: limit each queue type to the number of online CPUs
      nvme-fabrics: clear the poll map if no poll queues are mapped

Dominik Maier (1):
      loop: check for read-write open mode on LOOP_SET_STATUS in lo_compat_ioctl()

Guixin Liu (4):
      nvmet-fc: Tear down the association when the admin queue allocation fails
      nvme-tcp: Validate the queue state under the queue lock in the address attribute
      nvmet: Finish the blk plug when integrity allocation fails
      nvmet: Free the old negotiation state when restarting authentication

Jack Wang (1):
      md: fix mddev_unlock() called without holding lock in lbs_store()

Jens Axboe (2):
      Merge tag 'md-7.4-20261013' of https://git.kernel.org/pub/scm/linux/kernel/git/mdraid/linux into block-7.4
      Merge tag 'nvme-7.4-2026-10-28' of git://git.infradead.org/nvme into block-7.4

Josef Bacik (33):
      nvmet: don't truncate the length of big discards
      nvmet-auth: take only AUTH_Negotiate for a negotiation
      nvmet: fix NULL dereference of PCI endpoint targets
      nvmet-tcp: stop listening when a port is removed
      nvmet: fix NULL dereference in debugfs host_traddr
      nvmet-tcp: don't read a removed port at Connect time
      nvme-loop: don't BUG() if a scan runs beside a reset
      blk-cgroup: keep the old blkg while reassociating a bio
      blk-iocost: free struct ioc after a grace period
      blk-throttle: don't truncate the cgroup v1 iops limits
      blk-cgroup: fix root io.stat byte counts on 32-bit
      blk-cgroup: don't free a blkg with its punt work queued
      blk-iolatency: flush enable_work after going offline
      blk-throttle: pass the I/O counts of a dead group on
      blk-throttle: make blkio.reset_stats reset I/O counts
      block: don't enter reclaim under rq_qos_mutex
      block: fix use-after-free of the disk in sync_bdevs()
      block: don't lose the status of a failed flush request
      blk-mq: don't trust the cookie in blk_mq_poll()
      blk-mq: keep sharing tags fairly after a queue update
      blk-mq: don't bring back flags of a completed request
      blk-mq: don't forget a timer the driver has restarted
      blk-mq-dma: initialize the dma state for P2P, too
      blk-mq: quiesce a queue that joins a quiesced tag set
      blk-mq: exit the hctxs of a queue under tag_list_lock
      blk-mq: set up a queue under tag_list_lock
      block: partitions/mac: compute the sectors in 64 bits
      blk-mq: free the bitmaps of tags in the SRCU callback
      block: apply the segment size to the integrity buffer
      drbd: stop the start_resync timer of a dying device
      drbd: take req_lock to skip the initial sync as peer
      block/rnbd-srv: don't free the device on a sysfs error
      block/rnbd-srv: drop the sess_dev kobject unlocked

J?r?my Jean (1):
      md: reject v0.90 arrays with too many devices

Kunhai Dai (2):
      blk-iocost: abort weight transfer on invalid donation weights
      blk-iocost: publish hweights as one atomic value

Li Youhong (4):
      md: add rdev_record_write_error() helper
      md/raid1-10: add rdev_bb_block_sectors() helper
      md/raid1-10: share flush_bio_list between raid1 and raid10
      md/raid5: drain released_stripes before destroying the cache

Martin Belanger (2):
      nvme-tcp: start error recovery when read_sock fails
      nvme-tcp: skip TLS control records while waiting for the ICResp

Martin George (3):
      nvme-auth: update error log in nvme_auth_submit()
      nvme-multipath: avoid size_t underflow in ANA log bounds checks
      nvme-fc: fix reference leak in nvme_fc_nvme_discovery_store()

Martin Wilck (1):
      md/raid5: validate payload size before calculating payload_len

Maurizio Lombardi (2):
      nvme-pci: fix early boot hang with nvme.quirks parameter
      nvme-pci: increase quirks_param buffer size to 256 bytes

Nguyen Ngoc Thang (1):
      md: take reconfig_mutex when enabling PPL on an inactive array

Peng Fan (1):
      md/raid: use assign_bit() where applicable

Qing Zhang (1):
      nvmet: protect nvmet_ports_list with nvmet_config_sem

Randy Dunlap (1):
      cdrom: drop linux/fs.h from cdrom.h

Rongzheng Wang (1):
      nvmet: use the enabled transport when disabling a port

Sang-Hoon Choi (1):
      md/raid5: protect big_stripe_tree lookup with RCU

Seiji Nishikawa (1):
      nvme-tcp: fix io_work priority inversion when send_mutex is held

Shao Mingyin (1):
      nvmet-auth: fix error handling on CHALLENGE failure

TJ Adams (1):
      block: advance iterator after copy-in for SG_DXFER_TO_FROM_DEV

Weiming Shi (1):
      nvmet-rdma: reject short connection requests

Yehyeong Lee (1):
      nvmet-fc: fix use-after-free in nvmet_fc_ls_create_connection()

Yingjie Wang (2):
      nvmet-tcp: validate the TLS handshake timeout
      nvme-tcp: validate the TLS handshake timeout

Yogesh Gaur (3):
      md/raid5: don't BUG() on an inconsistent reshape state from the superblock
      md/raid5: give the io_unit slab caches per-array names
      md: don't hand out the array before md_alloc() has added mddev->kobj

Yu Zhang (1):
      nvmet: take subsys->lock while force-reconnecting in nvmet_subsys_attr_qid_max_store()

Yuchao Zhang (1):
      md: validate bblog_size when loading v1.x badblocks metadata

Yuehong Wu (1):
      block: fix kernel-doc warnings in blk-map.c and blk-mq-dma.c

Zhenxian Ma (1):
      block: fix recursive i_rwsem locking in blkdev_write_iter()

Zhihao Cheng (2):
      md/raid5: setup_conf: Fix null-ptr-def in error handling path
      md: Fix the null-ptr-deref of 'mddev->private' while submitting IO

Zizhi Wo (3):
      md/raid10: annotate lockless access to array_freeze_pending
      md/raid10: fix missing wakeup in wait_barrier_nolock
      md/raid5: reject a per-device size smaller than one chunk

 .../admin-guide/kernel-parameters.txt         |  10 +
 block/bdev.c                                  |  10 +
 block/blk-cgroup.c                            |  39 ++-
 block/blk-cgroup.h                            |   6 +-
 block/blk-crypto-fallback.c                   |   6 +
 block/blk-flush.c                             |   8 +-
 block/blk-iocost.c                            | 119 +++++--
 block/blk-iolatency.c                         |   6 +-
 block/blk-map.c                               |   2 +-
 block/blk-mq-dma.c                            |   7 +-
 block/blk-mq-tag.c                            |   8 +-
 block/blk-mq.c                                |  78 ++++-
 block/blk-throttle.c                          |  28 +-
 block/blk-timeout.c                           |   3 +-
 block/blk.h                                   |  14 +
 block/fops.c                                  |   2 -
 block/partitions/mac.c                        |   4 +-
 drivers/block/drbd/drbd_main.c                |   1 +
 drivers/block/drbd/drbd_receiver.c            |   2 +
 drivers/block/loop.c                          |   6 +-
 drivers/block/rnbd/rnbd-srv-sysfs.c           |  28 +-
 drivers/block/rnbd/rnbd-srv.c                 |  36 +-
 drivers/block/zloop.c                         |  80 +++--
 drivers/md/md.c                               |  72 ++--
 drivers/md/md.h                               |   7 +
 drivers/md/raid0.c                            |  16 +-
 drivers/md/raid1-10.c                         |  27 ++
 drivers/md/raid1.c                            |  42 +--
 drivers/md/raid10.c                           |  59 +---
 drivers/md/raid5-cache.c                      |  54 ++-
 drivers/md/raid5-ppl.c                        |  12 +-
 drivers/md/raid5.c                            | 106 ++++--
 drivers/md/raid5.h                            |   1 +
 drivers/nvme/host/auth.c                      |   6 +-
 drivers/nvme/host/fabrics.c                   |  30 +-
 drivers/nvme/host/fc.c                        |   7 +-
 drivers/nvme/host/pci.c                       |   4 +-
 drivers/nvme/host/rdma.c                      |   2 +-
 drivers/nvme/host/tcp.c                       | 309 ++++++++++++++----
 drivers/nvme/target/auth.c                    |   1 +
 drivers/nvme/target/configfs.c                |  26 +-
 drivers/nvme/target/core.c                    |  16 +-
 drivers/nvme/target/fabrics-cmd-auth.c        |  11 +-
 drivers/nvme/target/fabrics-cmd.c             |   3 +-
 drivers/nvme/target/fc.c                      |  18 +-
 drivers/nvme/target/io-cmd-bdev.c             |   8 +-
 drivers/nvme/target/loop.c                    |   2 -
 drivers/nvme/target/nvmet.h                   |   3 +-
 drivers/nvme/target/pci-epf.c                 |  30 +-
 drivers/nvme/target/rdma.c                    |  31 +-
 drivers/nvme/target/tcp.c                     |  33 +-
 drivers/nvme/target/zns.c                     |  12 +-
 include/linux/blk-mq.h                        |   6 +
 include/linux/blkdev.h                        |   9 +-
 include/linux/cdrom.h                         |   1 -
 include/trace/events/iocost.h                 |   7 +-
 tools/cgroup/iocost_monitor.py                |   7 +-
 57 files changed, 1062 insertions(+), 419 deletions(-)

-- 
Jens Axboe


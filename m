Received: from mail-oo1-f45.google.com (mail-oo1-f45.google.com [209.85.161.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D97144028EA
	for <linux-block@vger.kernel.org>; Mon, 15 Jun 2026 15:24:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781537067; cv=none; b=ZG9Q67wk3nlIen8JE9FIXdzEGxZrSR8ozo8boUFnDUd1vM252lMj2Kt2d3Cd1sfLLGmYRQrWethak4Fuq3gQCkzEBuCdjEFQGr3OAOa5tGnf6yispH3pCd4PxOc0zh/+7pL9b1W++XYEPAKKfU1hLklMhYMwaDvadByuksmO2NM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781537067; c=relaxed/simple;
	bh=iKSkBQfSe3LdCS1giEWjCdzKJFq3trCOsF0fekuMY74=;
	h=Message-ID:Date:MIME-Version:To:Cc:From:Subject:Content-Type; b=Wt0dNcgm5YXHMWvqYvXJo3/59dmAjeFhUOuokxw4h0cUvin3FmOnRGAPS9ML/Rhpcj2ZVVPtUgF6UIYi6NVRpOYiw41zAIadPT9E3qIXMpWNEeaaKNITxpbv1UN1GsCSpknXkPdOIJP84epbDb/ctE+B2v6wOSK3N3RErdlCutw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20251104.gappssmtp.com header.i=@kernel-dk.20251104.gappssmtp.com header.b=Ma28vtA5; arc=none smtp.client-ip=209.85.161.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20251104.gappssmtp.com header.i=@kernel-dk.20251104.gappssmtp.com header.b="Ma28vtA5"
Received: by mail-oo1-f45.google.com with SMTP id 006d021491bc7-69de16f5f79so1908262eaf.0
        for <linux-block@vger.kernel.org>; Mon, 15 Jun 2026 08:24:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20251104.gappssmtp.com; s=20251104; t=1781537064; x=1782141864; darn=vger.kernel.org;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rLs36ScuAOxtwQ8rqB7iub0iJlfcgNDnDmOKfsru6J8=;
        b=Ma28vtA51oHLYrubCxXV2Q8WKUwnTzHr4js6jbcSSAURjX9kgqKeIIH9+A83MWfAtf
         JLR/5BsqTQtmGXzB32aTdSVHXP8OmJPE39xvkkWCjAnlA/EVM09U5DxK5o5eY8iZWLDY
         rrzrjnHZCcnGacoKFrJo2em7jldT+ihyGFi+dOekuTx69kEhj0nsMGJQz4P2A+chuUTP
         H2+5Pqd7L4wFZHcce2LBl5ulFNCpsX3y7eFEYvx7NR35PvLxodugzxAbWF5YBbj2mALi
         kswN6TiSFuxlWXL50JyC09cauqOeoAw6Y54e3PW/wEpQ50zykMgHtmWe8Adp5NLKTgu2
         sKeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781537064; x=1782141864;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=rLs36ScuAOxtwQ8rqB7iub0iJlfcgNDnDmOKfsru6J8=;
        b=g1CSoGVq/aJr1lpw17sEUS4dBZQeXpUiuYnx03far8F8U04x+xrtgaNWxLxzHYoz9Q
         iAlIDsrpC1wxrLJEfFyylPMKlwiciFo9eDa/6e18GGS1EaCMZ1v8Zw04dsp88Baoda8Z
         RLTIL3HEx2nt0P+RX5Hl8wcLPAYtxJOEPW7IXO5uhbz5ILikcSsEZ+DwCImvNT5uRqek
         kS0NkJn7fgCHbRSuT+0aTphwA9/iYGIAQoaGuSKPATpI0MbQ+542MVLTkxTs0cC1nO/8
         KYdLu+gwSmqLujeCpPqxWQ/PUzvVWwi4/ugYOGD5AtlYdqlZobtYor/nBdZQBlJWM5HA
         IQuA==
X-Gm-Message-State: AOJu0Yy3w+XCwL4Fg1sx83N3atvSjM5B07ZPbU9O7QO8PI9BPXjeG25N
	owM6eqoo0tkQlB0k9tyP8qnIY3DonJow/BqqYoFDS8YKsr6HOTAujvva0RPNI9BYb2Gj4NuTXPT
	9/DU5ToQ=
X-Gm-Gg: Acq92OFsYJMMvJn9PoRM3fXx4zF9Wd3eI5wrsX62bFyxu3oETuUvY/W5WeiBlDwUKRe
	pzfz1fkYiKLH2xt2mDmwnBd1XPX66vxS2LdqlWSs7sszJX6/snHi7oLii162Ay97uvZ0Dj0uvOG
	Z4qCoYuk+6sZ3B/Xopd+XldrTKWM5hnVgGk0G5EvoGEetPXChWcpgXBaKTQ78yecFYrgD4wtzJO
	RDKZT2bqFB2LzkIs6Z8i1RZu2YR6OR74WZt3rQQHIKmhjZ8y+JI2S/QaVSkBqMr5Wi1sz9Oovi5
	5L9yhq2JTs7b6BpZXVxlQJ+DSGpkHqqYoPkNleAlfnyqBgI5ymCPsxa6D+nzTLcsVOsiKrjnEHo
	43TsuleCOVFW3sLp98b/y0onNfpilCMK40O/Z74SzqZZ4JmvEDs+ZOoYLWbsBLLgGghT5HH02ET
	1lAUnRxxzamWrvOxjPWsygIDo3nvOG4Sss82BRMGI7CqajoPF+KQ3Lo84DHdU5Grjc5Vjs0lkRT
	GiRGEikVeV+U15Zn4I=
X-Received: by 2002:a05:6820:4b94:b0:69e:30ea:1336 with SMTP id 006d021491bc7-69edc793377mr9022543eaf.50.1781537063625;
        Mon, 15 Jun 2026 08:24:23 -0700 (PDT)
Received: from [192.168.1.102] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-4430907570esm71763fac.18.2026.06.15.08.24.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 15 Jun 2026 08:24:23 -0700 (PDT)
Message-ID: <28f00610-4a45-47f5-9e08-468c31736090@kernel.dk>
Date: Mon, 15 Jun 2026 09:24:22 -0600
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
Subject: [GIT PULL] Block updates for 7.2
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Linus,

Here are the block updates queued up for the 7.2 merge window. This
contains:

- NVMe pull request via Keith:
       - Per-controller admin and IO timeout sysfs attributes, and
         letting the block layer set request timeouts (Maurizio,
         Maximilian)
       - Multipath passthrough iostats, and PCI P2PDMA enablement for
         multipath devices (Keith, Kiran)
       - A new diag sysfs attribute group exporting per-controller
         counters (retries, multipath failover, error counters, requeue
         and failure counts, reset and reconnect events) (Nilay)
       - FDP configuration validation and bounds check fixes (liuxixin)
       - Various nvmet fixes, including a pre-auth out-of-bounds read in
         the Discovery Get Log Page handler, auth payload bounds
         validation, and tcp error-path leak fixes (Bryam, Tianchu,
         Geliang)
       - nvme-tcp lockdep and workqueue fixes (Shin'ichiro, Kuniyuki,
         Eric)
       - Assorted other fixes and cleanups (John, Yao, Chao, Mateusz,
         Achkinazi, Wentao)

- MD pull request via Yu Kuai:
       - raid1/raid10 fixes for a deadlock in the read error recovery
         path, error-path detection and bio accounting with cloned bios,
         and an nr_pending leak in the REQ_ATOMIC bad-block error path
         (Abd-Alrhman)
       - PCI P2PDMA propagation from member devices to the RAID device
         (Kiran)
       - dm-raid bio requeue fix, and various smaller fixes and cleanups
         (Benjamin, Chen, Li, Thorsten)

- Enable Clang lock context analysis for the block layer, with the
  accompanying annotations across queue limits, the blk_holder_ops
  callbacks, crypto, cgroup, iocost, kyber and mq-deadline (Bart)

- Block status code infrastructure work: a tagged status table, a
  str_to_blk_op() helper, a bio_endio_status() helper, and on top of
  that a new configurable block-layer error injection facility (Christoph)

- DRBD netlink rework, replacing the genl_magic machinery with explicit
  netlink serialization and moving the DRBD UAPI headers to
  include/uapi/linux/ (Christoph Böhmwalder)

- bvec improvements: a bvec_folio() helper and making the bvec_iter
  helpers proper inline functions (Willy, Christoph)

- ublk cleanups and a canceling-flag fix for the disk-not-allocated
  case (Caleb, Ming)

- Partition handling fixes: bound the AIX pp_count scan, fix an of_node
  refcount leak, and replace __get_free_page() with kmalloc() (Bryam,
  Wentao, Mike)

- Convert numa_node to int in blk_mq_hw_ctx and ->init_request, and add
  WQ_PERCPU to the block workqueue users (Mateusz, Marco)

- Block statistics and tracing: propagate in-flight to the whole disk
  on partition IO, export passthrough stats, and a new
  block_rq_tag_wait tracepoint (Tang, Keith, Aaron)

- A round of removals, unexports and cleanups across bio, direct-io and
  the bvec helpers (Christoph)

- Various driver fixes (mtip32xx use-after-free, rbd snap_count
  validation and strscpy conversion, nbd socket lockdep reclassify,
  virtio-blk zone report clamp, floppy) and a batch of MAINTAINERS
  email/list updates (Coly, Li, Yu, Christoph Böhmwalder)

- Other little fixes and cleanups all over

Please pull!


The following changes since commit 7fd2df204f342fc17d1a0bfcd474b24232fb0f32:

  Linux 7.1-rc2 (2026-05-03 14:21:25 -0700)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/axboe/linux.git tags/for-7.2/block-20260615

for you to fetch changes up to c7c76f9232bd34835d821f14abdc5fafc17bc938:

  MAINTAINERS: Update Coly Li's email address (2026-06-13 09:29:02 -0600)

----------------------------------------------------------------
for-7.2/block-20260615

----------------------------------------------------------------
Aaron Tomlin (1):
      blk-mq: add tracepoint block_rq_tag_wait

Abd-Alrhman Masalkhi (5):
      md: skip redundant raid_disks update when value is unchanged
      md/raid1,raid10: fix deadlock in read error recovery path
      md/raid1,raid10: fix error-path detection with md_cloned_bio()
      md/raid1,raid10: fix bio accounting for split md cloned bios
      raid1: fix nr_pending leak in REQ_ATOMIC bad-block error path

Achkinazi, Igor (1):
      nvme-multipath: set BIO_REMAPPED on bios remapped to per-path namespace disks

Andreas Hindborg (1):
      rust: block: mq: align init_request numa_node arg with C signature

Bart Van Assche (14):
      block: Annotate the queue limits functions
      block/bdev: Annotate the blk_holder_ops callback functions
      block/cgroup: Split blkg_conf_prep()
      block/cgroup: Split blkg_conf_exit()
      block/cgroup: Improve lock context annotations
      block/blk-iocost: Combine two error paths in ioc_qos_write()
      block/cgroup: Inline blkg_conf_{open,close}_bdev_frozen()
      block/crypto: Annotate the crypto functions
      block/blk-iocost: Split ioc_rqos_throttle()
      block/blk-iocost: Inline iocg_lock() and iocg_unlock()
      block/blk-mq-debugfs: Improve lock context annotations
      block/Kyber: Make the lock context annotations compatible with Clang
      block/mq-deadline: Make the lock context annotations compatible with Clang
      block: Enable lock context analysis

Benjamin Marzinski (1):
      dm-raid: only requeue bios when dm is suspending

Bryam Vargas (2):
      nvmet: fix pre-auth out-of-bounds heap read in Discovery Get Log Page
      partitions: aix: bound the pp_count scan to the ppe array

Caleb Sander Mateos (4):
      blk-mq: introduce blk_rq_has_data()
      ublk: optimize ublk_rq_has_data()
      ublk: move ublk_req_build_flags() earlier
      ublk: factor out ublk_init_iod() helper

Chaitanya Kulkarni (1):
      block: clear BLK_FEAT_PCI_P2PDMA in blk_stack_limits() for non-supporting devices

Chao Shi (2):
      nvme: core: reject invalid LBA data size from Identify Namespace
      block: skip sync_blockdev() on surprise removal in bdev_mark_dead()

Chen Cheng (1):
      md/raid10: reset read_slot when reusing r10bio for discard

Christoph Böhmwalder (4):
      drbd: move UAPI headers to include/uapi/linux/
      drbd: replace genl_magic with explicit netlink serialization
      drbd: clean up UAPI headers
      MAINTAINERS: use new drbd-dev mailing list

Christoph Hellwig (18):
      block: remove zero_fill_bio_iter
      block: remove bio_copy_data_iter
      block: unexport blk_io_schedule
      block: unexport blk_status_to_str
      block: unexport bio_{set,check}_pages_dirty
      direct-io: remove IOCB_NOWAIT support
      block: don't set BIO_QUIET for BLK_STS_AGAIN
      block: mark biovec_init_pool static
      loop: cleanup lo_rw_aio
      nvme-tcp: cleanup nvme_tcp_init_iter
      bvec: make the bvec_iter helpers inline functions
      block: add a bio_endio_status helper
      md/raid1: cleanup handle_read_error
      md/raid1: move the exceed_read_errors condition out of fix_read_error
      block: add a macro to initialize the status table
      block: add a "tag" for block status codes
      block: add a str_to_blk_op helper
      block: add configurable error injection

Coly Li (1):
      MAINTAINERS: Update Coly Li's email address

David Laight (1):
      drivers/block/rbd: Use strscpy() to copy strings into arrays

Denis Arefev (1):
      block: Avoid mounting the bdev pseudo-filesystem in userspace

Eric Dumazet (1):
      nbd: Reclassify sockets to avoid lockdep circular dependency

Geliang Tang (2):
      nvmet-tcp: fix page fragment cache leak in error path
      nvmet-tcp: check return value of nvmet_tcp_set_queue_sock

Haoze Xie (1):
      rust: block: fix GenDisk cleanup paths

Jens Axboe (2):
      Merge tag 'md-7.2-20260531' of https://git.kernel.org/pub/scm/linux/kernel/git/mdraid/linux into for-7.2/block
      Merge tag 'nvme-7.2-2026-06-04' of git://git.infradead.org/nvme into for-7.2/block

John Garry (2):
      nvme: use DEFINE_SIMPLE_SYSFS_GROUP_VISIBLE for multipath_sysfs
      nvme-multipath: pass NS head to nvme_mpath_revalidate_paths()

Keith Busch (3):
      block: export passthrough stats enabled
      nvme: add support multipath passthrough iostats
      block: check bio split for unaligned bvec

Kiran Kumar Modukuri (2):
      md: propagate BLK_FEAT_PCI_P2PDMA from member devices to RAID device
      nvme-multipath: enable PCI P2PDMA for multipath devices

Kuniyuki Iwashima (1):
      nvme-tcp: Use WQ_PERCPU explicitly if wq_unbound is false.

Li Nan (1):
      MAINTAINERS: Update Li Nan's E-mail address

Marco Crivellari (1):
      block: Add WQ_PERCPU to alloc_workqueue users

Mateusz Nowicki (2):
      block: switch numa_node to int in blk_mq_hw_ctx and init_request
      nvme-pci: fix out-of-bounds access in nvme_setup_descriptor_pools

Matthew Wilcox (Oracle) (2):
      block: Add bvec_folio()
      block: Include bvec.h kernel-doc in the htmldocs

Maurizio Lombardi (7):
      nvme: remove redundant timeout argument from nvme_wait_freeze_timeout
      nvme: add sysfs attribute to change admin timeout per nvme controller
      nvme: add sysfs attribute to change IO timeout per controller
      nvme-core: align fabrics_q teardown with admin_q in nvme_free_ctrl
      nvmet-loop: do not alloc admin tag set during reset
      nvme-core: warn on allocating admin tag set with existing queue
      nvme-core: fix unsigned comparison warning in nvme_wait_freeze_timeout

Maximilian Heyne (1):
      nvme: Let the blocklayer set timeouts for requests

Michael Bommarito (1):
      virtio-blk: clamp zone report to the report buffer capacity

Mike Rapoport (Microsoft) (1):
      block: partitions: replace __get_free_page() with kmalloc()

Ming Lei (1):
      ublk: set canceling flag even when disk is not allocated

Nilay Shroff (9):
      nvme-multipath: fix flex array size in struct nvme_ns_head
      nvme: add diag attribute group under sysfs
      nvme: export command retry count via sysfs
      nvme: export multipath failover count via sysfs
      nvme: export command error counters via sysfs
      nvme: export I/O requeue count when no path is usable via sysfs
      nvme: export I/O failure count when no path is available via sysfs
      nvme: export controller reset event count via sysfs
      nvme: export controller reconnect event count via sysfs

Rosen Penev (1):
      rbd: check snap_count against RBD_MAX_SNAP_COUNT

Shin'ichiro Kawasaki (2):
      nvme-tcp: move nvme_tcp_reclassify_socket()
      nvme-tcp: lockdep: use dynamic lockdep keys per socket instance

Steven Feng (1):
      block: optimize I/O merge hot path with unlikely() hints

Tal Zussman (1):
      block: remove blkdev_write_begin() and blkdev_write_end()

Tang Yizhou (1):
      block: propagate in_flight to whole disk on partition I/O

Tao Cui (1):
      blk-throttle: schedule parent dispatch in tg_flush_bios()

Thorsten Blum (3):
      md/raid0: use str_plural helper in dump_zones
      block/partitions/acorn: use min in {riscix,linux}_partition
      n64cart: use strscpy in n64cart_probe

Tianchu Chen (1):
      nvmet-auth: validate reply message payload bounds against transfer length

Uwe Kleine-König (The Capable Hub) (1):
      floppy: Drop unused pnp driver data

Wentao Liang (2):
      block: partitions: fix of_node refcount leak in of_partition()
      nvme: target: rdma: fix ndev refcount leak on queue connect

Yao Sang (1):
      nvme: refresh multipath head zoned limits from path limits

Yu Kuai (2):
      MAINTAINERS: update Yu Kuai's email address
      block, bfq: release cgroup stats with bfq_group

Yuho Choi (1):
      mtip32xx: fix use-after-free on service thread failure

liuxixin (2):
      nvme: fix FDP fdpcidx bounds check
      nvme: validate FDP configuration descriptor sizes

liyouhong (1):
      nvme-multipath: require exact iopolicy names for module parameter

 Documentation/block/error-injection.rst            |   59 +
 Documentation/block/index.rst                      |    1 +
 Documentation/core-api/kernel-api.rst              |    1 +
 MAINTAINERS                                        |   10 +-
 block/Kconfig                                      |    8 +
 block/Makefile                                     |    3 +
 block/bdev.c                                       |   13 +-
 block/bfq-cgroup.c                                 |   54 +-
 block/bio.c                                        |   52 +-
 block/blk-cgroup.c                                 |   98 +-
 block/blk-cgroup.h                                 |   13 +-
 block/blk-core.c                                   |  104 +-
 block/blk-crypto-fallback.c                        |    9 +-
 block/blk-crypto-profile.c                         |    2 +
 block/blk-crypto.c                                 |    3 +-
 block/blk-iocost.c                                 |  306 ++-
 block/blk-iolatency.c                              |   19 +-
 block/blk-merge.c                                  |   17 +-
 block/blk-mq-debugfs.c                             |   24 +-
 block/blk-mq-tag.c                                 |    6 +
 block/blk-mq.c                                     |   43 +-
 block/blk-settings.c                               |    2 +
 block/blk-sysfs.c                                  |    5 +
 block/blk-throttle.c                               |   85 +-
 block/blk-zoned.c                                  |    2 +-
 block/blk.h                                        |   32 +
 block/bsg-lib.c                                    |    2 +-
 block/error-injection.c                            |  315 +++
 block/error-injection.h                            |   21 +
 block/fops.c                                       |   27 +-
 block/genhd.c                                      |    4 +
 block/kyber-iosched.c                              |    7 +-
 block/mq-deadline.c                                |   12 +-
 block/partitions/acorn.c                           |    5 +-
 block/partitions/aix.c                             |    9 +
 block/partitions/core.c                            |    6 +-
 block/partitions/of.c                              |    5 +-
 drivers/block/drbd/Makefile                        |    1 +
 drivers/block/drbd/drbd_buildtag.c                 |    2 +-
 .../linux => drivers/block/drbd}/drbd_config.h     |    0
 drivers/block/drbd/drbd_debugfs.c                  |    2 +-
 drivers/block/drbd/drbd_int.h                      |    6 +-
 drivers/block/drbd/drbd_main.c                     |    6 +-
 drivers/block/drbd/drbd_nl.c                       |  416 ++--
 drivers/block/drbd/drbd_nl_gen.c                   | 2606 ++++++++++++++++++++
 drivers/block/drbd/drbd_nl_gen.h                   |  395 +++
 drivers/block/drbd/drbd_proc.c                     |    2 +-
 drivers/block/floppy.c                             |    4 +-
 drivers/block/loop.c                               |   24 +-
 drivers/block/mtip32xx/mtip32xx.c                  |   19 +-
 drivers/block/n64cart.c                            |    3 +-
 drivers/block/nbd.c                                |   39 +-
 drivers/block/rbd.c                                |    9 +-
 drivers/block/ublk_drv.c                           |  174 +-
 drivers/block/virtio_blk.c                         |    2 +
 drivers/md/dm-raid.c                               |    6 +
 drivers/md/dm-rq.c                                 |    2 +-
 drivers/md/md.c                                    |   32 +-
 drivers/md/md.h                                    |    7 +
 drivers/md/raid0.c                                 |    4 +-
 drivers/md/raid1.c                                 |   64 +-
 drivers/md/raid10.c                                |   30 +-
 drivers/md/raid5.c                                 |    7 +-
 drivers/mmc/core/queue.c                           |    2 +-
 drivers/mtd/ubi/block.c                            |    2 +-
 drivers/nvme/host/apple.c                          |    4 +-
 drivers/nvme/host/core.c                           |   74 +-
 drivers/nvme/host/fc.c                             |    5 +-
 drivers/nvme/host/ioctl.c                          |    9 +
 drivers/nvme/host/multipath.c                      |  144 +-
 drivers/nvme/host/nvme.h                           |   21 +-
 drivers/nvme/host/pci.c                            |   16 +-
 drivers/nvme/host/rdma.c                           |    6 +-
 drivers/nvme/host/sysfs.c                          |  311 ++-
 drivers/nvme/host/tcp.c                            |  127 +-
 drivers/nvme/target/discovery.c                    |   23 +-
 drivers/nvme/target/fabrics-cmd-auth.c             |   15 +-
 drivers/nvme/target/loop.c                         |   33 +-
 drivers/nvme/target/rdma.c                         |    6 +-
 drivers/nvme/target/tcp.c                          |   11 +-
 drivers/scsi/scsi_lib.c                            |    2 +-
 fs/direct-io.c                                     |   15 +-
 include/linux/bio.h                                |   32 +-
 include/linux/blk-mq.h                             |   53 +-
 include/linux/blkdev.h                             |   28 +-
 include/linux/bvec.h                               |  112 +-
 include/linux/drbd_genl.h                          |  536 ----
 include/linux/drbd_genl_api.h                      |   56 -
 include/linux/genl_magic_func.h                    |  413 ----
 include/linux/genl_magic_struct.h                  |  272 --
 include/trace/events/block.h                       |   59 +
 include/{ => uapi}/linux/drbd.h                    |   73 +-
 include/uapi/linux/drbd_genl.h                     |  359 +++
 include/{ => uapi}/linux/drbd_limits.h             |   10 +-
 io_uring/rsrc.c                                    |    2 +-
 mm/page_io.c                                       |    4 +-
 rust/kernel/block/mq/gen_disk.rs                   |   20 +-
 rust/kernel/block/mq/operations.rs                 |    2 +-
 98 files changed, 5781 insertions(+), 2322 deletions(-)
 create mode 100644 Documentation/block/error-injection.rst
 create mode 100644 block/error-injection.c
 create mode 100644 block/error-injection.h
 rename {include/linux => drivers/block/drbd}/drbd_config.h (100%)
 create mode 100644 drivers/block/drbd/drbd_nl_gen.c
 create mode 100644 drivers/block/drbd/drbd_nl_gen.h
 delete mode 100644 include/linux/drbd_genl.h
 delete mode 100644 include/linux/drbd_genl_api.h
 delete mode 100644 include/linux/genl_magic_func.h
 delete mode 100644 include/linux/genl_magic_struct.h
 rename include/{ => uapi}/linux/drbd.h (85%)
 create mode 100644 include/uapi/linux/drbd_genl.h
 rename include/{ => uapi}/linux/drbd_limits.h (97%)

-- 
Jens Axboe


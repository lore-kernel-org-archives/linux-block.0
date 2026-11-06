Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.161.43
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793981233;
	b=f4j9GJSzzdKB3/hI+Pa184XneD1882ESi4lW7eBHR64b/OK3ZkpRZ4NUs6/QmqmAY8fc
	 RtWBbRhCkiT4Z7TEtAOit/FWbglXvSvE4EEmvGYEXl8/6lj+JfPZQkbjnc3SWd/jFDuDw
	 UqebPxQnyCyYRJjQ6D7IRvKZoEgrc8iNqAb5RwY6gtDL759zH0Mwbbs5lBgfj5jmq7q49
	 exN+FEqa5Mew4xMDEobqNloEbCM7KgRGRDjeOn4UGn2eZISjcNGlo0OW1Va9/NmoEJcTn
	 vLES6newP522T5OCkyDfDd1P6jD4/XEr0lNVJiZq7gM8ivpDPyI1krlaGfO6yzC/TcQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793981233;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-ID:Date:
	 MIME-Version:User-Agent:Content-Language:To:Cc:From:Subject:
	 Content-Type:Content-Transfer-Encoding;
	bh=HS+M47ZmXAnZn2/8wUACxZPDYYwy6/cX68E49FmHt90=;
	b=wSiePJbOlZ2mcBUl2O9McD/MHafOUQkhNerc0uU9GAjPLsBCAIC23mw+DFHIgmYYGiMS
	 TxOkuDfPhqwAGEDy5/XujEWsYSDsgWpVoaO09GE23mJl8gbSdFthzcNihxpyJHvwk5zdw
	 aa9LX6mS11/T0YyB+RvhVVal1Jx2MCDKiKLklJm29uBZfux/IxcmG5YX78TTOvlZpVhq+
	 hB97u2cu7O5FDP9lQaEoZMCSM6zI2KP/1C3owV3aSHPN62Jv3yqBGqvf3SYfYdUJzN7So
	 +RXKfb86MZqqv/NIvSMRqKZE6RjJ6Sq9VvbQSVRyRIFtc6lbpE03KHrEnnDbX4Vh7BQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=kernel.dk;
	spf=pass smtp.mailfrom=kernel.dk;
	dkim=pass header.d=kernel-dk.20260707.gappssmtp.com header.i=@kernel-dk.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=oIdjjQBY;
	arc=none smtp.remote-ip=209.85.161.43
Received: from mail-oo1-f43.google.com (mail-oo1-f43.google.com [209.85.161.43])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E712F606A32C
	for <linux-block@vger.kernel.org>; Fri,  6 Nov 2026 16:07:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E712F606A32C
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel-dk.20260707.gappssmtp.com header.i=@kernel-dk.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=oIdjjQBY
Received: by mail-oo1-f43.google.com with SMTP id 006d021491bc7-714d57774d8so477458eaf.1
        for <linux-block@vger.kernel.org>; Fri, 06 Nov 2026 08:07:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20260707.gappssmtp.com; s=20260707; t=1793981231; x=1794586031; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:subject:from:cc:to
         :content-language:user-agent:mime-version:date:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=HS+M47ZmXAnZn2/8wUACxZPDYYwy6/cX68E49FmHt90=;
        b=oIdjjQBYMqpn/b6TCcbql12M80yE7AQX+425DCZxsUTzaIamtxa7+StkkRMfjn+W+z
         6PflXcvlT7OFyGTbvdDitZkxGTEGLgnicSk3crDhz/ULWF8jOHH+3g2ZQVvI90+GRZGI
         FtkSrbjEVXJ94YXpfQe2AN8uCV3EPDEV2FVz6elR2Pj8gfEQcMz+DkLI/Iiy3d/QyLzA
         AMHeFOE6dX7yzGbbcbmnG39q2DFmgET/JyVJFs/DPOWG8slf0g05K9OugzvS4CTATDbN
         OoL8ksTLd97wFmyqhYzVxCZE7nDOYzbabacNDs4alNzdBvRG84paDZtzg12BXq7I9T4I
         qRYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793981231; x=1794586031;
        h=content-transfer-encoding:content-type:subject:from:cc:to
         :content-language:user-agent:mime-version:date:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=HS+M47ZmXAnZn2/8wUACxZPDYYwy6/cX68E49FmHt90=;
        b=x/tQajWUmt7ubuVvki6epZZ5FY2+VbCtZbTCXcUXvje9BpqjgAPLgbktoQ1E6YTxET
         q34jDiII7vApDVlEPY1gs2oNlie/eVn+tNIzgFXTa+aAbVAQ33toeSNJf0UB2uYbKs3P
         /aSrCHsCO9EzVpYwbgzNMwGVQ/o3T+QPXkulN9dH8B1Xb7N4UWJr7PDwClw2lvSlS5yF
         P4uISWPZCifbblr+uwDcvMDsr3W6XySglw4bMUZmo8VatdJ6W4xfUTDasIDB6q/9sas+
         Q3KWdX5mITfLeSHvHJT4V92u/RDshwnONFnOFbmI2ZPl+TFoOQLjxiLS9Bny/pvag3MO
         TyDg==
X-Gm-Message-State: APuU4Z8z4ssbZkgJiwILUcqdzrG7CyqJSs8BkLYLUU0XkWlPSk6quzSg
	ieSabf0dAVpxUozi5UUilvltxghjHnQMI702abtX2IkUF1fZGvdyJDfMlh/T05QyqgMVmknPsw0
	f/ZV4qUM=
X-Gm-Gg: AYBFou1OZtYRtWmdlHf6EYX5exACAVVlORVmOh6nRAdILnotiPXXYprNuZEsBITUMS/
	IbOzVuEVrYzTjXGLnOb50zU/es3+TG5992URG6xBQ5SaAKi3u3xdA5uAEL0mvwhtmkdSIo/Ncwk
	z3AYaPhPSdv8CIcGWV4JCAr7Rm74wQacbDPlAylXzg7XbbM9aJE+ExmVDVzD9CfHoXQt6oH8lZZ
	rDmfv4VhpnRgNStyDQ7rclsYQTmglRaumTC4yLygUUM1xSqSCUrz3swfRigq2jaRuIQ1QHkT2Zn
	0ZCFlbs6+khERbZBluHwSUB9Lwf5fZpEvFYioe9bOti++W21g14v90QeHrHwjkz4b3xM4Q6yhrR
	fBPiePKfUIQa/yirdaETrks+VOC7vGSrrzj5/Hw3hFIljy2X/2EzyMzY/pqpqHxTClVjjqAdAlR
	rVG7eR0sstgqBHsHuaBxwDkvTHIrEuwBTeGxIPBquzpwRXL3SrKg1Hcj5C4P6S7OFM82xc692xK
	+ZF+V5C8lr3atYJtxjLIqT5yJpXLAQZjIPBjJSZPJGW/TvE0Kd8ckJqAuJbHhq8teNW1OOJd1Gc
	DIA7NwCueTTy4pY+v9+BVMhkSm/MBL9zIPSHMTL/RYyHDtxCO4FxZAFimNWgD/8+9cvDE8eSwtD
	X6qVmTgj6Xg==
X-Received: by 2002:a05:6820:4481:b0:716:cea0:28da with SMTP id 006d021491bc7-716e78a25efmr1964736eaf.31.1793981230663;
        Fri, 06 Nov 2026 08:07:10 -0800 (PST)
Received: from [192.168.2.38] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-716e9fa704dsm2119698eaf.4.2026.11.06.08.07.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 06 Nov 2026 08:07:08 -0800 (PST)
Message-ID: <d25cc9fb-590d-4f57-925b-b91f00da2672@kernel.dk>
Date: Fri, 6 Nov 2026 09:07:07 -0700
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
Subject: [GIT PULL] block fixes for 7.4-rc2
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Linus,

Block fixes for this week. Mostly NVMe via Keith, with a handful of
core and driver fixes. This pull request contains:

- NVMe fixes via Keith:
  - nvme-tcp use-after-free in nvme_tcp_free_ctrl() on a failed
    connect, and the nvme-rdma counterpart of the NULL queue->ctrl on
    reconnect
  - nvmet-rdma iWARP disconnect and device removal fixes
  - nvmet-tcp: ask for the TLS record type on every receive, and
    bound the connections accepted per work run so a connect flood
    can't hold up port removal; nvmet-auth keep the old keys if the
    new ones fail to decode; nvme-loop delete the controller if a
    reset fails
  - nvmet-auth reject incomplete DHCHAP messages, and a keep-alive
    timeout overflow
  - nvmet locking and bounds fixes for tbkas reconnects and the
    traddr/trsvcid configfs writes, don't leak stale memory in the
    ANA log page, and cache the passthru reference across
    queue_response
  - Wait for SRCU readers before splicing the namespace list, with a
    new list_splice_init_srcu() helper, and drop an extra grace
    period in nvmet_ns_disable()
  - Unregister when pr_register() is given a zero new key, and don't
    drop the cdev reference twice on cdev_device_add() failure
  - Quirks for the ADATA XPG GAMMIX S70 BLADE and KIOXIA XG10d
  - Various smaller fixes and cleanups

- blk-mq: end the request if getting a keyslot fails, which left the
  in-flight count and zone write plug stuck, reset the queue state on
  scheduler teardown so requests don't stall in software queues, and
  fix an out-of-bounds read in blk_mq_free_rqs() after a failed
  nr_hw_queues update

- Only serialize elevator switches of the same queue

- dma-buf bio fixes: don't use the bvec fast path for them, and only
  fail the ones that need block layer PI

- Reject GPT entries with starting_lba > ending_lba

- Return the soft block size for compat BLKBSZGET, report the correct
  discard alignment in sysfs, and account the flush sequence latency
  only once in iocost

- virtio_blk fixes: synchronous quiesce in freeze, freeze the virtqueue
  layout at probe time, clamp max_segments to the ring size, and fix
  zone append sector reporting in batched completion

- null_blk zone fixes and a cache state reset

- zloop fixes

- ublk DEL_DEV_ASYNC permission check, and 32-bit selftest build

Please pull!


The following changes since commit 6628e7d4c6b25c8d18f1345e3a20d21829aae7e4:

  Linux 7.4-rc1 (2026-11-01 13:26:31 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/axboe/linux tags/block-7.4-20261106

for you to fetch changes up to 28f7d31c2aeb350df9a0116093fade0a840fb4ce:

  Merge tag 'nvme-7.4-2026-11-05' of git://git.infradead.org/nvme into block-7.4 (2026-11-05 13:47:13 -0700)

----------------------------------------------------------------
block-7.4-20261106

----------------------------------------------------------------
Anuj Gupta (1):
      block: don't use the bvec fast path for dma-buf bios

Avi Weiss (1):
      block: report the correct discard alignment in sysfs

Baek Kyu, Kim (1):
      null_blk: reset cache state before device setup

Chris Mason (4):
      nvmet-rdma: disconnect only established queues
      nvmet-rdma: take a device off the list last
      nvmet-rdma: queue the release work under the mutex
      nvmet-rdma: disconnect a queue on device removal

Christian Aurich Zanettini Martins (2):
      nvme-tcp: fix use-after-free in nvme_tcp_free_ctrl()
      nvme-rdma: fix NULL queue->ctrl dereference on reconnect

Christoph Hellwig (1):
      zloop: fix block size query

Christophe JAILLET (1):
      nvmet: pci-epf: Constify struct pci_epf_ops

Cong Zhang (1):
      virtio_blk: use synchronous quiesce in virtblk_freeze_priv()

Daejun Park (1):
      nvme: unregister when pr_register() is given a zero new key

Ewan D. Milne (1):
      nvmet: don't return memory contents beyond valid data when reading ANA log page

Guixin Liu (1):
      nvmet-rdma: remove dead allocated field in nvmet_rdma_rsp

Hugo Deco (1):
      nvme-pci: add NO_FUA quirk for ADATA XPG GAMMIX S70 BLADE

Hungyu Lin (1):
      block: Return the soft block size for compat BLKBSZGET

James Fantin-Hardesty (1):
      nvmet: fix arbitration burst field mask

Jarkko Sakkinen (1):
      nvme-keyring: Add a missing key_put() call to nvme_tls_key_lookup()

Jens Axboe (1):
      Merge tag 'nvme-7.4-2026-11-05' of git://git.infradead.org/nvme into block-7.4

Jianan Huang (1):
      blk-mq: reset queue state on scheduler teardown

Josef Bacik (5):
      blk-mq: end the request if getting a keyslot fails
      nvme-loop: delete the controller if a reset fails
      nvmet-tcp: ask for the TLS record type on every receive
      nvmet-auth: keep the old keys if the new ones fail
      nvmet-tcp: limit the connections accepted per work run

J?r?my Jean (1):
      nvmet-auth: reject incomplete DHCHAP messages

Krystian Kaniewski (1):
      blk-mq: fix out-of-bounds read in blk_mq_free_rqs

Kyle Bader (1):
      block: only fail dma-buf bios that need block layer PI

Laveesh Bansal (1):
      block: only serialize elevator switches of the same queue

Niklas Cassel (3):
      null_blk: fix opening closed zones at the active zone limit
      null_blk: don't finish zones to set them read-only or offline
      null_blk: clean up setting zones read-only or offline

Nilay Shroff (1):
      nvmet: cache passthru reference in __nvmet_req_complete()

Qiliang Yuan (3):
      nvmet: drop the extra RCU grace period in nvmet_ns_disable()
      srcu: Add list_splice_init_srcu()
      nvme: wait for SRCU readers before splicing the namespace list

Sasha Levin (2):
      selftests: ublk: fix the build and file offsets on 32-bit
      nvme-pci: add NVME_QUIRK_DMAPOOL_ALIGN_512 for KIOXIA XG10d

Sergii Ushakov (1):
      virtio-blk: clamp max_segments to virtqueue ring size

Shao Mingyin (6):
      virtio-blk: Fix zone append sector reporting in batched completion
      zloop: fix the error code in the blk_mq_alloc_disk message
      zloop: reject mismatched conventional zone files on restore
      nvmet: take subsys->lock when forcing reconnects for tbkas
      nvmet: bound the traddr and trsvcid configfs writes
      nvmet: drop the redundant auth check in nvmet_parse_io_cmd()

Sreeraj S Kurup (1):
      nvmet: use appropriate types for authentication payload lengths

Yingjie Wang (1):
      nvmet: reject keep-alive timeouts that would overflow

Yitang Yang (1):
      ublk: add missing DEL_DEV_ASYNC to unprivileged permission check

Yunye Zhao (1):
      virtio_blk: freeze the virtqueue layout at probe time

Yuqiang Sun (1):
      nvme: Do not drop the cdev reference twice when cdev_device_add() fails

Zhe Liu (1):
      blk-iocost: account flush sequence latency only once

Zizhi Wo (1):
      block: partitions: reject GPT entries with starting_lba > ending_lba

 block/blk-iocost.c                     |   3 +
 block/blk-mq-sched.c                   |   6 +-
 block/blk-mq.c                         |  26 ++++---
 block/blk.h                            |   2 +
 block/elevator.c                       |  32 ++++----
 block/fops.c                           |   2 -
 block/genhd.c                          |   2 +-
 block/ioctl.c                          |   4 +-
 block/partitions/efi.c                 |   1 +
 drivers/block/null_blk/main.c          |   1 +
 drivers/block/null_blk/zoned.c         |  63 ++++++++++-----
 drivers/block/ublk_drv.c               |   1 +
 drivers/block/virtio_blk.c             | 101 ++++++++++++++++++++-----
 drivers/block/zloop.c                  |   7 +-
 drivers/nvme/common/keyring.c          |   1 +
 drivers/nvme/host/core.c               |  23 ++++--
 drivers/nvme/host/multipath.c          |   2 -
 drivers/nvme/host/nvme.h               |   8 ++
 drivers/nvme/host/pci.c                |   4 +
 drivers/nvme/host/pr.c                 |   8 +-
 drivers/nvme/host/rdma.c               |   7 +-
 drivers/nvme/host/tcp.c                |  10 +--
 drivers/nvme/target/admin-cmd.c        |  20 ++++-
 drivers/nvme/target/auth.c             |  69 +++++++----------
 drivers/nvme/target/configfs.c         |   6 +-
 drivers/nvme/target/core.c             |  27 ++++---
 drivers/nvme/target/fabrics-cmd-auth.c |  10 +--
 drivers/nvme/target/loop.c             |   5 +-
 drivers/nvme/target/nvmet.h            |  32 ++++++--
 drivers/nvme/target/pci-epf.c          |   2 +-
 drivers/nvme/target/rdma.c             |  56 +++++++++-----
 drivers/nvme/target/tcp.c              |  13 +++-
 include/linux/blkdev.h                 |   4 +-
 include/linux/srcu.h                   |  36 +++++++++
 tools/testing/selftests/ublk/Makefile  |   1 +
 tools/testing/selftests/ublk/batch.c   |   6 +-
 tools/testing/selftests/ublk/ctrl.c    |   2 +-
 tools/testing/selftests/ublk/kublk.c   |   2 +-
 38 files changed, 420 insertions(+), 185 deletions(-)

-- 
Jens Axboe


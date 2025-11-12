Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BBC4DDC3
	for <linux-block@vger.kernel.org>; Wed, 12 Nov 2025 09:38:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762940314; cv=none; b=V0zFZqco82WSsslETY0gIw2+gV/YXKbUqQ7YKOksCFQfV3CPrQRYYe7Gr5zYp55bPAn53TbUGDh5h2Ic0ouO/afqFgkakT/RGEnDd+lQz3qY0ZXjbygez95MFOnLQPY3UOIQro6gw19kXr50ix9dMjDHTjn7nEZ0DboSDsSVhZI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762940314; c=relaxed/simple;
	bh=zGkYHmRY2RxrEHjtycAWwPq/fpSnzkrNTMAN//b/tb0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=pVYF6ckh34ZIzKVtORTxmPL8TB4gIX6+VIB3N8mn0e+0DQoqXw32SM6T2Y0zCcuKnZJsZhn1Xh1fyT6tvrCaPSSrfzlYtxVsaChsy6WIPIe5Wiv0pD5SI25DdIs8+LeXmrCuY+tzW9xed5fekcJWSSnfiuU9aX35mmpNULcitFs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=BL6qLP10; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BL6qLP10"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1762940312;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=5WbxxG0dnT4vIibZaHgY7ZFn8Il4xX+GcJZ1QN8kGvw=;
	b=BL6qLP10eXImLHKUAFBEREW4aU0o6ylhPkpFubjYZNLRclT9qd/N7tZBjTnjHAeEBovw9S
	FW8iSFRCqna6Zyy0eF2y+2BxTOkD6nkHBB4bzBlozkGbncxZOhaGH8qlsw2BybSKM/mLdy
	jJIcW6Sb2qkS1KBMOm59qn3RKSTKgGI=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-686-xQEeYchIPiOhy5_q2jnmaA-1; Wed,
 12 Nov 2025 04:38:30 -0500
X-MC-Unique: xQEeYchIPiOhy5_q2jnmaA-1
X-Mimecast-MFC-AGG-ID: xQEeYchIPiOhy5_q2jnmaA_1762940309
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 910B8180035D;
	Wed, 12 Nov 2025 09:38:29 +0000 (UTC)
Received: from localhost (unknown [10.72.116.179])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 6A0AA30044E0;
	Wed, 12 Nov 2025 09:38:28 +0000 (UTC)
From: Ming Lei <ming.lei@redhat.com>
To: Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org
Cc: Caleb Sander Mateos <csander@purestorage.com>,
	Uday Shankar <ushankar@purestorage.com>,
	Ming Lei <ming.lei@redhat.com>
Subject: [PATCH V3 00/27] ublk: add UBLK_F_BATCH_IO
Date: Wed, 12 Nov 2025 17:37:38 +0800
Message-ID: <20251112093808.2134129-1-ming.lei@redhat.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

Hello,

This patchset adds UBLK_F_BATCH_IO feature for communicating between kernel and ublk
server in batching way:

- Per-queue vs Per-I/O: Commands operate on queues rather than individual I/Os

- Batch processing: Multiple I/Os are handled in single operation

- Multishot commands: Use io_uring multishot for reducing submission overhead

- Flexible task assignment: Any task can handle any I/O (no per-I/O daemons)

- Better load balancing: Tasks can adjust their workload dynamically

- help for future optimizations:
	- blk-mq batch tags free
  	- support io-poll
	- per-task batch for avoiding per-io lock
	- fetch command priority

- simplify command cancel process with per-queue lock

selftest are provided.


Performance test result(IOPS):

- page copy

tools/testing/selftests/ublk//kublk add -t null -q 16 [-b]

- zero copy(--auto_zc)
tools/testing/selftests/ublk//kublk add -t null -q 16 --auto_zc [-b]

- IO test
taskset -c 0-31 fio/t/io_uring -p0 -n $JOBS -r 30 /dev/ublkb0

1) 16 jobs IO
- page copy:  			37.77M vs. 42.40M(BATCH_IO), +12%
- zero copy(--auto_zc): 42.83M vs. 44.43M(BATCH_IO), +3.7%


2) single job IO
- page copy:  			2.54M vs. 2.6M(BATCH_IO),   +2.3%
- zero copy(--auto_zc): 3.13M vs. 3.35M(BATCH_IO),  +7%


V3:
	- rebase on for-6.19/block
	- use blk_mq_end_request_batch() to free requests in batch, only for
	  page copy
	- fix one IO hang issue because of memory barrier order, comments on
	the memory barrier pairing
	- add NUMA ware kfifo_alloc_node()
	- fix one build warning reported by 0-DAY CI
	- selftests improvement & fix

V2:
	- ublk_config_io_buf() vs. __ublk_fetch() order
	- code style clean
	- use READ_ONCE() to cache sqe data because sqe copy becomes
	  conditional recently
	- don't use sqe->len for UBLK_U_IO_PREP_IO_CMDS &
	  UBLK_U_IO_COMMIT_IO_CMDS
	- fix one build warning
	- fix build_user_data()
	- run performance analysis, and find one bug in
	  io_uring_cmd_buffer_select(), fix is posted already

Ming Lei (27):
  kfifo: add kfifo_alloc_node() helper for NUMA awareness
  ublk: add parameter `struct io_uring_cmd *` to
    ublk_prep_auto_buf_reg()
  ublk: add `union ublk_io_buf` with improved naming
  ublk: refactor auto buffer register in ublk_dispatch_req()
  ublk: pass const pointer to ublk_queue_is_zoned()
  ublk: add helper of __ublk_fetch()
  ublk: define ublk_ch_batch_io_fops for the coming feature F_BATCH_IO
  ublk: prepare for not tracking task context for command batch
  ublk: add new batch command UBLK_U_IO_PREP_IO_CMDS &
    UBLK_U_IO_COMMIT_IO_CMDS
  ublk: handle UBLK_U_IO_PREP_IO_CMDS
  ublk: handle UBLK_U_IO_COMMIT_IO_CMDS
  ublk: add io events fifo structure
  ublk: add batch I/O dispatch infrastructure
  ublk: add UBLK_U_IO_FETCH_IO_CMDS for batch I/O processing
  ublk: abort requests filled in event kfifo
  ublk: add new feature UBLK_F_BATCH_IO
  ublk: document feature UBLK_F_BATCH_IO
  ublk: implement batch request completion via
    blk_mq_end_request_batch()
  selftests: ublk: fix user_data truncation for tgt_data >= 256
  selftests: ublk: replace assert() with ublk_assert()
  selftests: ublk: add ublk_io_buf_idx() for returning io buffer index
  selftests: ublk: add batch buffer management infrastructure
  selftests: ublk: handle UBLK_U_IO_PREP_IO_CMDS
  selftests: ublk: handle UBLK_U_IO_COMMIT_IO_CMDS
  selftests: ublk: handle UBLK_U_IO_FETCH_IO_CMDS
  selftests: ublk: add --batch/-b for enabling F_BATCH_IO
  selftests: ublk: support arbitrary threads/queues combination

 Documentation/block/ublk.rst                  |   60 +-
 drivers/block/ublk_drv.c                      | 1288 +++++++++++++++--
 include/linux/kfifo.h                         |   27 +
 include/uapi/linux/ublk_cmd.h                 |   91 ++
 lib/kfifo.c                                   |   13 +-
 tools/testing/selftests/ublk/Makefile         |    7 +-
 tools/testing/selftests/ublk/batch.c          |  609 ++++++++
 tools/testing/selftests/ublk/common.c         |    2 +-
 tools/testing/selftests/ublk/file_backed.c    |   11 +-
 tools/testing/selftests/ublk/kublk.c          |  143 +-
 tools/testing/selftests/ublk/kublk.h          |  195 ++-
 tools/testing/selftests/ublk/null.c           |   18 +-
 tools/testing/selftests/ublk/stripe.c         |   17 +-
 .../testing/selftests/ublk/test_generic_14.sh |   32 +
 .../testing/selftests/ublk/test_generic_15.sh |   30 +
 .../testing/selftests/ublk/test_generic_16.sh |   30 +
 .../testing/selftests/ublk/test_stress_06.sh  |   45 +
 .../testing/selftests/ublk/test_stress_07.sh  |   44 +
 tools/testing/selftests/ublk/utils.h          |   64 +
 19 files changed, 2551 insertions(+), 175 deletions(-)
 create mode 100644 tools/testing/selftests/ublk/batch.c
 create mode 100755 tools/testing/selftests/ublk/test_generic_14.sh
 create mode 100755 tools/testing/selftests/ublk/test_generic_15.sh
 create mode 100755 tools/testing/selftests/ublk/test_generic_16.sh
 create mode 100755 tools/testing/selftests/ublk/test_stress_06.sh
 create mode 100755 tools/testing/selftests/ublk/test_stress_07.sh

-- 
2.47.0


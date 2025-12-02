Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE2962FD7CA
	for <linux-block@vger.kernel.org>; Tue,  2 Dec 2025 12:19:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764677986; cv=none; b=aHys2Gj35CbbkZmaBPAOiwznwdzDFv8z6wyp6YunY/P6QEfbm96evMqbzWwsILT4PcChCeLeSJWeKTxKujsI5/FrC/mrF/eFqoNmB3q9+8mkK2JJrfquJMOF2iMFrl5F5DvsVFjVZq8DjhPIkMg7seQ6NL7EomI2Z6CCb0UsqUk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764677986; c=relaxed/simple;
	bh=QIURsIU9SD+fdopYld5PlPecFdUN6vOAxaNRScusI9Q=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=KHYRG/Z9hJtNynYW6MEevPDzbqQUSxnt5ZDu+sQh9I8oP1eEpb2NQ/0fZVwa4GqGcvM5fZoRzzNbpIhsQGHCWnDI9XMy9NtqAYaXNTRtxO0Goo6vzEN1i6L+QQxcGJwRWtxLxC6xW6QbGe/cWHDOFuDIQOykQhzi3OOO4drNbuw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Xn6rHQJA; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Xn6rHQJA"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1764677983;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=vh8TDFwarMSieRT8PFGT8DusfltZPYQKOtup+sFWvgQ=;
	b=Xn6rHQJAC+ItWcU5zZ2ngpz0DYUCeh8YEnu1pNlc/NvDFoSP8Q8GK5VR6qDoO5Yn5bNLmq
	fdYCUOXNrGibMiqI/AaDlZuRrvuWTT3EsMZnQrjXSx+DPfWCuJ9IJm6c29UiOoZz8lx7rK
	M15gf7QXsJYXErGtVm0yI7KYpD8NlNA=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-575-17vYs97SPe6OA9_8vkqBNQ-1; Tue,
 02 Dec 2025 07:19:39 -0500
X-MC-Unique: 17vYs97SPe6OA9_8vkqBNQ-1
X-Mimecast-MFC-AGG-ID: 17vYs97SPe6OA9_8vkqBNQ_1764677978
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 6E3831956051;
	Tue,  2 Dec 2025 12:19:38 +0000 (UTC)
Received: from localhost (unknown [10.72.116.20])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 68D631800451;
	Tue,  2 Dec 2025 12:19:37 +0000 (UTC)
From: Ming Lei <ming.lei@redhat.com>
To: Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org
Cc: Caleb Sander Mateos <csander@purestorage.com>,
	Uday Shankar <ushankar@purestorage.com>,
	Ming Lei <ming.lei@redhat.com>
Subject: [PATCH V5 00/21] ublk: add UBLK_F_BATCH_IO
Date: Tue,  2 Dec 2025 20:18:54 +0800
Message-ID: <20251202121917.1412280-1-ming.lei@redhat.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

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


Performance test result(IOPS) on V3:

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


V5:
	- rebase on for-6.19/block
	- fix fetch command leak in ublk_batch_attach() by marking correct
	  uring_cmd as cancellable
	- add ublk_batch_queue_rqs() for building per-queue batch
	- add __ublk_deinit_queue() for fixing failure path of initializing
	  queue(Caleb Sander Mateos)
	- explicitly disable UBLK_F_NEED_GET_DATA for BATCH_IO(Caleb Sander Mateos)
	- kill unnecessary check in ublk_batch_commit_io_check()(Caleb Sander Mateos)
	- rename `ublk_batch_fcmd` as `ublk_batch_fetch_cmd`(Caleb Sander Mateos)
	- improve ublk_batch_dispatch() by not running inline dispatch for different
	  fetch command(Caleb Sander Mateos)
	- use READ_ONCE() for reading all ubq->active_fcmd(Caleb Sander Mateos)
	- simplify ublk_abort_batch_queue()(Caleb Sander Mateos)
	- improve handling for non-batch commands(Caleb Sander Mateos)
	- document fetch command lifetime(Caleb Sander Mateos)
	- patch style, sizeof(tag), signed/unsigned changes(Caleb Sander Mateos)
	- add recovery function test for BATCH_IO in generic_04/genereic_05

V4:
	- fix handling in case of running out of mshot buffer, request has to
	  be un-prepared for zero copy
	- don't expose unused tag to userspace
	- replace fixed buffer with plain user buffer for
	  UBLK_U_IO_PREP_IO_CMDS and UBLK_U_IO_COMMIT_IO_CMDS
	- replace iov iterator with plain copy_from_user() for
	  ublk_walk_cmd_buf(), code is simplified with performance improvement
	- don't touch sqe->len for UBLK_U_IO_PREP_IO_CMDS and
	  UBLK_U_IO_COMMIT_IO_CMDS(Caleb Sander Mateos)
	- use READ_ONCE() for access sqe->addr (Caleb Sander Mateos)
	- all kinds of patch style fix(Caleb Sander Mateos)
	- inline __kfifo_alloc() (Caleb Sander Mateos)


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



Ming Lei (21):
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

 Documentation/block/ublk.rst                  |   64 +-
 drivers/block/ublk_drv.c                      | 1144 ++++++++++++++++-
 include/uapi/linux/ublk_cmd.h                 |   85 ++
 tools/testing/selftests/ublk/Makefile         |    7 +-
 tools/testing/selftests/ublk/batch.c          |  604 +++++++++
 tools/testing/selftests/ublk/common.c         |    2 +-
 tools/testing/selftests/ublk/file_backed.c    |   11 +-
 tools/testing/selftests/ublk/kublk.c          |  143 ++-
 tools/testing/selftests/ublk/kublk.h          |  195 ++-
 tools/testing/selftests/ublk/null.c           |   18 +-
 tools/testing/selftests/ublk/stripe.c         |   17 +-
 .../testing/selftests/ublk/test_generic_04.sh |    5 +
 .../testing/selftests/ublk/test_generic_05.sh |    5 +
 .../testing/selftests/ublk/test_generic_14.sh |   32 +
 .../testing/selftests/ublk/test_generic_15.sh |   30 +
 .../testing/selftests/ublk/test_generic_16.sh |   30 +
 .../testing/selftests/ublk/test_stress_06.sh  |   45 +
 .../testing/selftests/ublk/test_stress_07.sh  |   44 +
 tools/testing/selftests/ublk/utils.h          |   64 +
 19 files changed, 2445 insertions(+), 100 deletions(-)
 create mode 100644 tools/testing/selftests/ublk/batch.c
 create mode 100755 tools/testing/selftests/ublk/test_generic_14.sh
 create mode 100755 tools/testing/selftests/ublk/test_generic_15.sh
 create mode 100755 tools/testing/selftests/ublk/test_generic_16.sh
 create mode 100755 tools/testing/selftests/ublk/test_stress_06.sh
 create mode 100755 tools/testing/selftests/ublk/test_stress_07.sh

-- 
2.47.0


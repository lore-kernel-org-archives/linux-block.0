Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DB44328630
	for <linux-block@vger.kernel.org>; Fri, 16 Jan 2026 14:19:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768573154; cv=none; b=fmiVZJaylGP1KDAJBXKb7Z9q9ijhA4hJy7Sx4zFNcuPCbGEapBkPlDui5ZCMGxIL4Yy1/7wwF0BeiZFXXIsQOkW/oFW90bkmy/iErPfULPVHCNSC/i+/1gn711GFjZsgLYZTx1zLoaA5FfjiTNk+efbCpXhS3wAbee1mFDHTDr0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768573154; c=relaxed/simple;
	bh=Bz5Sd4ylRUWMyWjmOMutYm7RRREWSeDhtOsmPdyzmB8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=TAV1PTSC1QkGtNg+PK44XZ4vuhQqjt5zMNDX7QM+bayY0o2sopSCcOF9qREx6GAIsRpkVV6MwGZiAVGIefsnVsbJr6KqP9LjFQE25trLU7eK5X9PagYRxBk0cyBSw9WjS6fU21gxK6WlX2QVN076hzDwYURFgUIHcdaLNG/Zsjk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=E/Sgm7lW; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="E/Sgm7lW"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1768573148;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=jZ1AwD9wd6q4D0KI0M7coJWJc+0XlSyfg1Ez1BoV4lg=;
	b=E/Sgm7lWTejbwwUHaxxwhlaSIkNjaoH/1+proFQPJt0/t8Lp48T7C5pmR06B7qTT+6rB82
	mgnP/81FoWtrZ3j8kTk7nCpgDUHO8SI5m6JJSNcUAGhG15o48tzpzxM9hNvtuImfL79Vxn
	4DJv1Ty349ZdkJ/5AhzPw4pkc4q6Mf8=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-604-F2pVo0aANBqVMgu3RQRU1Q-1; Fri,
 16 Jan 2026 09:19:07 -0500
X-MC-Unique: F2pVo0aANBqVMgu3RQRU1Q-1
X-Mimecast-MFC-AGG-ID: F2pVo0aANBqVMgu3RQRU1Q_1768573146
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 1244318005B3;
	Fri, 16 Jan 2026 14:19:06 +0000 (UTC)
Received: from localhost (unknown [10.72.116.198])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 1168F19560A7;
	Fri, 16 Jan 2026 14:19:04 +0000 (UTC)
From: Ming Lei <ming.lei@redhat.com>
To: Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org
Cc: Caleb Sander Mateos <csander@purestorage.com>,
	Uday Shankar <ushankar@purestorage.com>,
	Ming Lei <ming.lei@redhat.com>
Subject: [PATCH V6 00/24] ublk: add UBLK_F_BATCH_IO
Date: Fri, 16 Jan 2026 22:18:33 +0800
Message-ID: <20260116141859.719929-1-ming.lei@redhat.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

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


Links: https://lore.kernel.org/linux-block/20251202121917.1412280-1-ming.lei@redhat.com/
Links: https://lore.kernel.org/linux-block/20251121015851.3672073-1-ming.lei@redhat.com/
Links: https://lore.kernel.org/linux-block/20251112093808.2134129-1-ming.lei@redhat.com/
Links: https://lore.kernel.org/linux-block/20251023153234.2548062-1-ming.lei@redhat.com/
Links: https://lore.kernel.org/linux-block/20250901100242.3231000-1-ming.lei@redhat.com/


This patchset is based on for-7.0/block with the following two patches:

	[PATCH v4] ublk: fix ublksrv pid handling for pid namespaces ( https://lore.kernel.org/linux-block/20260115025952.2321238-1-sconnor@purestorage.com/ )

	[PATCH 0/3] selftests/ublk: three bug fixes ( https://lore.kernel.org/linux-block/20260113085805.233214-1-ming.lei@redhat.com/ ) 


V6:
	- rebase on for-7.0/block
	- fix ublk_handle_non_batch_cmd() (Caleb Sander Mateos)
	- add `ublk: refactor ublk_queue_rq() and add ublk_batch_queue_rq()` (Caleb Sander Mateos)
	- add `ublk: fix batch I/O recovery -ENODEV error`
	- increase selftest timeout for running more things in some generic tests
	- fix kublk utility wrt. ->cmd_inflight accounting for BATCH_IO
	- pass all selftest after applying the io_uring cancel fix

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


Ming Lei (24):
  ublk: define ublk_ch_batch_io_fops for the coming feature F_BATCH_IO
  ublk: prepare for not tracking task context for command batch
  ublk: add new batch command UBLK_U_IO_PREP_IO_CMDS &
    UBLK_U_IO_COMMIT_IO_CMDS
  ublk: handle UBLK_U_IO_PREP_IO_CMDS
  ublk: handle UBLK_U_IO_COMMIT_IO_CMDS
  ublk: add io events fifo structure
  ublk: add batch I/O dispatch infrastructure
  ublk: add UBLK_U_IO_FETCH_IO_CMDS for batch I/O processing
  ublk: refactor ublk_queue_rq() and add ublk_batch_queue_rq()
  ublk: abort requests filled in event kfifo
  ublk: add new feature UBLK_F_BATCH_IO
  ublk: document feature UBLK_F_BATCH_IO
  ublk: implement batch request completion via
    blk_mq_end_request_batch()
  ublk: fix batch I/O recovery -ENODEV error
  selftests: ublk: fix user_data truncation for tgt_data >= 256
  selftests: ublk: replace assert() with ublk_assert()
  selftests: ublk: add ublk_io_buf_idx() for returning io buffer index
  selftests: ublk: add batch buffer management infrastructure
  selftests: ublk: handle UBLK_U_IO_PREP_IO_CMDS
  selftests: ublk: handle UBLK_U_IO_COMMIT_IO_CMDS
  selftests: ublk: handle UBLK_U_IO_FETCH_IO_CMDS
  selftests: ublk: increase timeout to 150 seconds
  selftests: ublk: add --batch/-b for enabling F_BATCH_IO
  selftests: ublk: support arbitrary threads/queues combination

 Documentation/block/ublk.rst                  |   64 +-
 drivers/block/ublk_drv.c                      | 1303 ++++++++++++++++-
 include/uapi/linux/ublk_cmd.h                 |   84 ++
 tools/testing/selftests/ublk/Makefile         |    8 +
 tools/testing/selftests/ublk/batch.c          |  607 ++++++++
 tools/testing/selftests/ublk/common.c         |    2 +-
 tools/testing/selftests/ublk/file_backed.c    |   11 +-
 tools/testing/selftests/ublk/kublk.c          |  149 +-
 tools/testing/selftests/ublk/kublk.h          |  195 ++-
 tools/testing/selftests/ublk/null.c           |   18 +-
 tools/testing/selftests/ublk/settings         |    1 +
 tools/testing/selftests/ublk/stripe.c         |   17 +-
 tools/testing/selftests/ublk/test_batch_01.sh |   32 +
 tools/testing/selftests/ublk/test_batch_02.sh |   30 +
 tools/testing/selftests/ublk/test_batch_03.sh |   30 +
 .../testing/selftests/ublk/test_generic_04.sh |    5 +
 .../testing/selftests/ublk/test_generic_05.sh |    5 +
 .../testing/selftests/ublk/test_stress_08.sh  |   45 +
 .../testing/selftests/ublk/test_stress_09.sh  |   44 +
 tools/testing/selftests/ublk/utils.h          |   64 +
 20 files changed, 2569 insertions(+), 145 deletions(-)
 create mode 100644 tools/testing/selftests/ublk/batch.c
 create mode 100644 tools/testing/selftests/ublk/settings
 create mode 100755 tools/testing/selftests/ublk/test_batch_01.sh
 create mode 100755 tools/testing/selftests/ublk/test_batch_02.sh
 create mode 100755 tools/testing/selftests/ublk/test_batch_03.sh
 create mode 100755 tools/testing/selftests/ublk/test_stress_08.sh
 create mode 100755 tools/testing/selftests/ublk/test_stress_09.sh

-- 
2.47.0


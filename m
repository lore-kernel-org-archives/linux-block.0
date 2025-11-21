Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F127D22541B
	for <linux-block@vger.kernel.org>; Fri, 21 Nov 2025 01:59:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763690352; cv=none; b=mtX2Ilt4XpjBhYzzClUzGiSXmJDkI2ScUxXBMbf+tNoKS2v3qiNFSTY13GUXZpA+w+N5DSFSdFzEBZXziKNcKT+1YjC/AND6ai8Y5NGWbNNV9LF0f6Ys4p7b7Z2aPy69gRpJjE9P5i5iwuPrEtx5w3K8U7P9qzDRLChkNR7l01g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763690352; c=relaxed/simple;
	bh=iUktVEyVexZ3EBgfmJQKB7wO8HTboUXEIR0kxis5E4I=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=byLIz4q/INfQbW0IaCYtdL2o9nFa5BLnOufZ5BVudFddJ33UuJNzloHyztsG1Nk58zecDGok6QBXgrk6n56rTuvxv6dce6/FHa18C5bNtzkC+PMXHH9YMQr+nj4GMkqLc0DXohFnZ8YXtLrepnQjmF5qqiMXanuTRn50Yju+fNU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=IKJWqnXl; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IKJWqnXl"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1763690347;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=riyYp0QIykanlxTB5WL9dg3Xji/x+29u+OT+gvbocpE=;
	b=IKJWqnXlsIVULsLb14N65qiHOCBXj4dwDkEFD54mPW4FyD1dIIT7hBYexGaFrs/IwG/NIk
	zLvvOJpFqe8YU09ZN+fT2jAjt4/s1dbjuHn0D6/8nYYVALDyXFKiG5m6Yp2MqP2iQpw+R4
	ErVY/nuZgztAIN0b/fazMTLciYm5QVs=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-397-yZXE4H4XOYufhti-13ZnPA-1; Thu,
 20 Nov 2025 20:59:06 -0500
X-MC-Unique: yZXE4H4XOYufhti-13ZnPA-1
X-Mimecast-MFC-AGG-ID: yZXE4H4XOYufhti-13ZnPA_1763690345
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 6DB091956096;
	Fri, 21 Nov 2025 01:59:04 +0000 (UTC)
Received: from localhost (unknown [10.72.116.211])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id D9DC51956045;
	Fri, 21 Nov 2025 01:59:02 +0000 (UTC)
From: Ming Lei <ming.lei@redhat.com>
To: Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org
Cc: Caleb Sander Mateos <csander@purestorage.com>,
	Uday Shankar <ushankar@purestorage.com>,
	Stefani Seibold <stefani@seibold.net>,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-kernel@vger.kernel.org,
	Ming Lei <ming.lei@redhat.com>
Subject: [PATCH V4 00/27] ublk: add UBLK_F_BATCH_IO
Date: Fri, 21 Nov 2025 09:58:22 +0800
Message-ID: <20251121015851.3672073-1-ming.lei@redhat.com>
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
 drivers/block/ublk_drv.c                      | 1312 +++++++++++++++--
 include/linux/kfifo.h                         |   34 +-
 include/uapi/linux/ublk_cmd.h                 |   85 ++
 lib/kfifo.c                                   |    8 +-
 tools/testing/selftests/ublk/Makefile         |    7 +-
 tools/testing/selftests/ublk/batch.c          |  604 ++++++++
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
 19 files changed, 2563 insertions(+), 178 deletions(-)
 create mode 100644 tools/testing/selftests/ublk/batch.c
 create mode 100755 tools/testing/selftests/ublk/test_generic_14.sh
 create mode 100755 tools/testing/selftests/ublk/test_generic_15.sh
 create mode 100755 tools/testing/selftests/ublk/test_generic_16.sh
 create mode 100755 tools/testing/selftests/ublk/test_stress_06.sh
 create mode 100755 tools/testing/selftests/ublk/test_stress_07.sh

-- 
2.47.0


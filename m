Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF3E833C50D
	for <linux-block@vger.kernel.org>; Thu, 23 Oct 2025 15:32:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761233573; cv=none; b=ap8lHlfyVwBNPDmzxsogIROF6ydDhaBRFOuQKNzJr20Xb/Bsygb+52c+NuI1hlLAkIQPptXi/dXC++OxUEFhzK7SFuDbmm/LpiZKU7Jqk68+B0ECqbcAo8XsIgXMUlVtDzILnZQGreSgGWjrrRF1BXvIPphvNxOpDcNK4sf2qKo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761233573; c=relaxed/simple;
	bh=q/weF3KPa0Oaoe+K+Z5n1bZxa7FXWWwL9grm073/DFI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=teoSNUWXJL7O5fS6u+rxIbwjMJRHZJ2iJ2LBb7/T5yvQglfmJRb5cKFx21clSmFpcHa0pokBqpitYr/pHsw/ahVdtJod73f+YHvGBMKzarAoQzZeer3YQrt33Gw9919Ztfm9fopbFLcRENp2FSjJ9Qh8XfMLodqoOuMtEyJZnNA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=a3HjGBp2; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="a3HjGBp2"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1761233570;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=cCTnBWmPV0dKjo8GM2Wnyv53D13EYNpJavaiKqdaVKE=;
	b=a3HjGBp2BqF8tkzHQKWHVl6pIa/VcGeHTPf6su/LgmIKxBnR0zUfKIFNihXYzd4HLDg8mg
	iapZD9o7+OhWvFd0iYF/HCGPPgPV0St/sjQdd9X9TSjEPm2qLLL1pjd16LTsmSqGvHI9rm
	L+lk5CxScubQin00yuhj+tYbvodJiKI=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-596-DfVOJjlnNwKNJGGUYqn2og-1; Thu,
 23 Oct 2025 11:32:47 -0400
X-MC-Unique: DfVOJjlnNwKNJGGUYqn2og-1
X-Mimecast-MFC-AGG-ID: DfVOJjlnNwKNJGGUYqn2og_1761233566
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 2B2F419540DA;
	Thu, 23 Oct 2025 15:32:46 +0000 (UTC)
Received: from localhost (unknown [10.72.120.30])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 1A44719560B5;
	Thu, 23 Oct 2025 15:32:43 +0000 (UTC)
From: Ming Lei <ming.lei@redhat.com>
To: Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org
Cc: Uday Shankar <ushankar@purestorage.com>,
	Caleb Sander Mateos <csander@purestorage.com>,
	Ming Lei <ming.lei@redhat.com>
Subject: [PATCH V2 00/25] ublk: add UBLK_F_BATCH_IO
Date: Thu, 23 Oct 2025 23:32:05 +0800
Message-ID: <20251023153234.2548062-1-ming.lei@redhat.com>
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

- **Per-queue vs Per-I/O**: Commands operate on queues rather than individual I/Os

- **Batch processing**: Multiple I/Os are handled in single operation

- **Multishot commands**: Use io_uring multishot for reducing submission overhead

- **Flexible task assignment**: Any task can handle any I/O (no per-I/O daemons)

- **Better load balancing**: Tasks can adjust their workload dynamically

- **help for future optimizations**:
	- blk-mq batch tags free
  	- support io-poll
	- per-task batch for avoiding per-io lock
	- fetch command priority

- ** simplify command cancel process with per-queue lock **

selftest are provided.

~5% IOPS improvement is observed(40M IOPS vs. 42M IOPS) on ublk/null:

  taskset -c 0-31 ~/git/fio/t/io_uring -p0 -n16 -r 40 /dev/ublkb0

- ublk device created by builtin selftest utility:

	./kublk add -t null -q 16 --auto_zc -d 512

	vs.

	./kublk add -t null -q 16 --auto_zc -d 512 -b	

feedback & review is welcome!

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


Thanks,
Ming

Ming Lei (25):
  ublk: add parameter `struct io_uring_cmd *` to
    ublk_prep_auto_buf_reg()
  ublk: add `union ublk_io_buf` with improved naming
  ublk: refactor auto buffer register in ublk_dispatch_req()
  ublk: add helper of __ublk_fetch()
  ublk: define ublk_ch_batch_io_fops for the coming feature F_BATCH_IO
  ublk: prepare for not tracking task context for command batch
  ublk: pass const pointer to ublk_queue_is_zoned()
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
 drivers/block/ublk_drv.c                      | 1238 +++++++++++++++--
 include/uapi/linux/ublk_cmd.h                 |   91 ++
 tools/testing/selftests/ublk/Makefile         |    7 +-
 tools/testing/selftests/ublk/batch.c          |  610 ++++++++
 tools/testing/selftests/ublk/common.c         |    2 +-
 tools/testing/selftests/ublk/file_backed.c    |   11 +-
 tools/testing/selftests/ublk/kublk.c          |  128 +-
 tools/testing/selftests/ublk/kublk.h          |  192 ++-
 tools/testing/selftests/ublk/null.c           |   18 +-
 tools/testing/selftests/ublk/stripe.c         |   17 +-
 .../testing/selftests/ublk/test_generic_14.sh |   32 +
 .../testing/selftests/ublk/test_generic_15.sh |   30 +
 .../testing/selftests/ublk/test_generic_16.sh |   30 +
 .../testing/selftests/ublk/test_stress_06.sh  |   45 +
 .../testing/selftests/ublk/test_stress_07.sh  |   44 +
 tools/testing/selftests/ublk/utils.h          |   64 +
 17 files changed, 2454 insertions(+), 165 deletions(-)
 create mode 100644 tools/testing/selftests/ublk/batch.c
 create mode 100755 tools/testing/selftests/ublk/test_generic_14.sh
 create mode 100755 tools/testing/selftests/ublk/test_generic_15.sh
 create mode 100755 tools/testing/selftests/ublk/test_generic_16.sh
 create mode 100755 tools/testing/selftests/ublk/test_stress_06.sh
 create mode 100755 tools/testing/selftests/ublk/test_stress_07.sh

-- 
2.47.0


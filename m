Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 906581A9F8C
	for <linux-block@vger.kernel.org>; Mon,  1 Sep 2025 10:02:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756720977; cv=none; b=azaxaO6Hil9MCGkTwoHdDIbWPgKLdAiQeKv3qbhTyh6CWXzpEwSFRoLBoWXlxMcBRmq5ZnIwgJjI6ImykMwf8au5IGtqhXx3kAj3OAEH2we1TwOq6P/VYhsfmGKGYSbr6avVsyOc6RWh6sFGkzWtvB9DYBLfZeHfMbRjTmCMXLM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756720977; c=relaxed/simple;
	bh=Q6zGO7uiPA/2rX2ZBn8KT9Mrjlgez6p/EgOH20/wWfg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=S3+bnqsrnyxhJJlGosM3JuXs+1vMF4PhDmQWRwlur4PmYoUzVCyfwBq32Km5YaGbuddrlT0Tcc5hnS8npZb0R41FPNqBWU39/qP5JdZN1ExC0PSqaqr/wQHJF3/4DZRPA+vWh/GzJwj16TYE2AAyEzeyVdi2EIVyFPoF/dpkcEs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=IrDPFRgS; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IrDPFRgS"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1756720974;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=FcgwTCck96hmtVaUIWTvtBdoB4O8lXvfgaZyvdNdAzg=;
	b=IrDPFRgSHl0MJut43CNcYlgMZwneB32slAGdPg2QQoCzznyyd8++kyiic+z/sAT6+mgxoD
	IneJKBzFv14eTClcyPQSUI+rol4gufBpJY3O8v1zY9AxRzSBEIH8wSWqGET+DZkUPNncF2
	QuQVAphPTs5DeV1LYVf4tE+Gg8zA8BA=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-664-00SUfkOmN_2KI88N-3_bIA-1; Mon,
 01 Sep 2025 06:02:53 -0400
X-MC-Unique: 00SUfkOmN_2KI88N-3_bIA-1
X-Mimecast-MFC-AGG-ID: 00SUfkOmN_2KI88N-3_bIA_1756720972
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id E3D881800561;
	Mon,  1 Sep 2025 10:02:51 +0000 (UTC)
Received: from localhost (unknown [10.72.116.17])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id C4AB430001B5;
	Mon,  1 Sep 2025 10:02:50 +0000 (UTC)
From: Ming Lei <ming.lei@redhat.com>
To: Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org
Cc: Uday Shankar <ushankar@purestorage.com>,
	Caleb Sander Mateos <csander@purestorage.com>,
	Ming Lei <ming.lei@redhat.com>
Subject: [PATCH 00/23] ublk: add UBLK_F_BATCH_IO
Date: Mon,  1 Sep 2025 18:02:17 +0800
Message-ID: <20250901100242.3231000-1-ming.lei@redhat.com>
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

- **Per-queue vs Per-I/O**: Commands operate on queues rather than individual I/Os
- **Batch processing**: Multiple I/Os are handled in single operation
- **Multishot commands**: Use io_uring multishot for reducing submission overhead
- **Flexible task assignment**: Any task can handle any I/O (no per-I/O daemons)
- **Better load balancing**: Tasks can adjust their workload dynamically
- **help for following future optimizations**:
	- blk-mq batch tags allocation/free,
  	- easier to support io-poll
	- per-task batch for avoiding per-io lock

selftest for this feature are provided.

This patchset depends on uring_cmd multishot support, which is merged to for-6.18/io_uring.


Thanks,
Ming


Ming Lei (23):
  ublk: add parameter `struct io_uring_cmd *` to
    ublk_prep_auto_buf_reg()
  ublk: add `union ublk_io_buf` with improved naming
  ublk: refactor auto buffer register in ublk_dispatch_req()
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
  selftests: ublk: replace assert() with ublk_assert()
  selftests: ublk: add ublk_io_buf_idx() for returning io buffer index
  selftests: ublk: add batch buffer management infrastructure
  selftests: ublk: handle UBLK_U_IO_PREP_IO_CMDS
  selftests: ublk: handle UBLK_U_IO_COMMIT_IO_CMDS
  selftests: ublk: handle UBLK_U_IO_FETCH_IO_CMDS
  selftests: ublk: add --batch/-b for enabling F_BATCH_IO
  selftests: ublk: support arbitrary threads/queues combination

 Documentation/block/ublk.rst                  |   60 +-
 drivers/block/ublk_drv.c                      | 1208 +++++++++++++++--
 include/uapi/linux/ublk_cmd.h                 |   91 ++
 tools/testing/selftests/ublk/Makefile         |    7 +-
 tools/testing/selftests/ublk/batch.c          |  610 +++++++++
 tools/testing/selftests/ublk/common.c         |    2 +-
 tools/testing/selftests/ublk/file_backed.c    |   11 +-
 tools/testing/selftests/ublk/kublk.c          |  128 +-
 tools/testing/selftests/ublk/kublk.h          |  190 ++-
 tools/testing/selftests/ublk/null.c           |   18 +-
 tools/testing/selftests/ublk/stripe.c         |   17 +-
 .../testing/selftests/ublk/test_generic_13.sh |   32 +
 .../testing/selftests/ublk/test_generic_14.sh |   30 +
 .../testing/selftests/ublk/test_generic_15.sh |   30 +
 .../testing/selftests/ublk/test_stress_06.sh  |   45 +
 .../testing/selftests/ublk/test_stress_07.sh  |   44 +
 tools/testing/selftests/ublk/utils.h          |   64 +
 17 files changed, 2431 insertions(+), 156 deletions(-)
 create mode 100644 tools/testing/selftests/ublk/batch.c
 create mode 100755 tools/testing/selftests/ublk/test_generic_13.sh
 create mode 100755 tools/testing/selftests/ublk/test_generic_14.sh
 create mode 100755 tools/testing/selftests/ublk/test_generic_15.sh
 create mode 100755 tools/testing/selftests/ublk/test_stress_06.sh
 create mode 100755 tools/testing/selftests/ublk/test_stress_07.sh

-- 
2.47.0


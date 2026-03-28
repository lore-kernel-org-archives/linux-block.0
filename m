Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D8E740DFA3
	for <linux-block@vger.kernel.org>; Sat, 28 Mar 2026 13:49:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774705769; cv=none; b=FF8oDxju5mAAVSqm7ubbRUSjtobUhvCUtc2g4kysbaAhHZK6vjtsnRbR4xF4zUfdwoSyBLt/Nl0C4FXZyUbhJ3tzaA0eYXYrgAxR6b5+ne1zwU/5O49AwTE4DCVl9f+S5l22nvcPdKqXiRXo+hoAC1OxGC9H8xnhuSx/5hy389I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774705769; c=relaxed/simple;
	bh=6g+fa6rusBbYMVvQS3Bfu0yA/XkaVJWIjPo/3dLsyEU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=S9FRNVQhnNQu0kY+6sloMNoML0x4zVcewtaRctfQ9IC4uSO1b/2GfR3LoXqWnKXSblio/xI/r8Z7YJpZg88bJqJLhkgFfnaqmHddtirFSPY2LduZtt/+uwMJntizg1J3/9hlAPW/CwtTffmh/whv5Tw+GjCQPmYOicQkumptWOU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=S09dAhgx; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="S09dAhgx"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1774705767;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=DmuuiXHuiSoCqGsBJJOOuW/fCT7Ls6pQN6cE7phxGrc=;
	b=S09dAhgxyWgtxU+QRq4fRsrAkHmO0KkYr+FIRSYbOnklfFx+lVuAGsC+r/0bnc9zoDkvT1
	9qkNup035869BHMs4VZFPZn0WDBb3zrwK6oW/FOMxALw/0J+0R2/UegU5w1Q2womLu6Bah
	pweC46VEDumhBAvR8SG2mH+a+g9AxXY=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-217-lVruTBxeOjiwCAX_tTNwSQ-1; Sat,
 28 Mar 2026 09:49:25 -0400
X-MC-Unique: lVruTBxeOjiwCAX_tTNwSQ-1
X-Mimecast-MFC-AGG-ID: lVruTBxeOjiwCAX_tTNwSQ_1774705764
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id B2AFE195609D;
	Sat, 28 Mar 2026 13:49:23 +0000 (UTC)
Received: from localhost (unknown [10.72.116.100])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 9B8481955D84;
	Sat, 28 Mar 2026 13:49:21 +0000 (UTC)
From: Ming Lei <ming.lei@redhat.com>
To: Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org
Cc: Caleb Sander Mateos <csander@purestorage.com>,
	Ming Lei <ming.lei@redhat.com>
Subject: [PATCH 0/8] ublk: add shared memory zero-copy support
Date: Sat, 28 Mar 2026 21:48:55 +0800
Message-ID: <20260328134909.3207377-1-ming.lei@redhat.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

Hello,

Add shared memory based zero-copy (UBLK_F_SHMEM_ZC) support for ublk.

The ublk server and its client share a memory region (e.g. memfd or
hugetlbfs file) via MAP_SHARED mmap. The server registers this region
with the kernel via UBLK_U_CMD_REG_BUF, which pins the pages and
builds a PFN maple tree. When I/O arrives, the driver looks up bio
pages in the maple tree — if they match registered buffer pages, the
data is used directly without copying.

Please see details on document added in patch 3.

Patches 1-3 implement the kernel side:
 - buffer register/unregister control commands with PFN coalescing
 - PFN-based matching in the I/O path
 - UBLK_F_SHMEM_ZC feature flag

Patches 4-8 add kublk (selftest server) support and tests:
 - hugetlbfs buffer sharing (both kublk and fio mmap the same file)
 - null target and loop target tests with fio verify
 - filesystem-level test (ext4 on ublk, fio verify on a file)

Ming Lei (8):
  ublk: add UBLK_U_CMD_REG_BUF/UNREG_BUF control commands
  ublk: add PFN-based buffer matching in I/O path
  ublk: enable UBLK_F_SHMEM_ZC feature flag
  selftests/ublk: add shared memory zero-copy support in kublk
  selftests/ublk: add UBLK_F_SHMEM_ZC support for loop target
  selftests/ublk: add shared memory zero-copy test
  selftests/ublk: add hugetlbfs shmem_zc test for loop target
  selftests/ublk: add filesystem fio verify test for shmem_zc

 Documentation/block/ublk.rst                  | 117 ++++++
 drivers/block/ublk_drv.c                      | 365 +++++++++++++++++-
 include/uapi/linux/ublk_cmd.h                 |  75 ++++
 tools/testing/selftests/ublk/Makefile         |   4 +
 tools/testing/selftests/ublk/file_backed.c    |  38 ++
 tools/testing/selftests/ublk/kublk.c          | 339 +++++++++++++++-
 tools/testing/selftests/ublk/kublk.h          |  14 +
 tools/testing/selftests/ublk/test_common.sh   |  15 +-
 .../testing/selftests/ublk/test_shmemzc_01.sh |  72 ++++
 .../testing/selftests/ublk/test_shmemzc_02.sh |  68 ++++
 .../testing/selftests/ublk/test_shmemzc_03.sh |  69 ++++
 11 files changed, 1168 insertions(+), 8 deletions(-)
 create mode 100755 tools/testing/selftests/ublk/test_shmemzc_01.sh
 create mode 100755 tools/testing/selftests/ublk/test_shmemzc_02.sh
 create mode 100755 tools/testing/selftests/ublk/test_shmemzc_03.sh

-- 
2.53.0


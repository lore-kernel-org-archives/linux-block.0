Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72B3E201278
	for <linux-block@vger.kernel.org>; Tue, 28 Oct 2025 08:56:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761641812; cv=none; b=POCb9CwgCe3CdDJvcIIVjSxHfeqTiqUHjtYqUnSGUOk0FgVd11tMfnOl9fFEBGZyHiNeck4m/rBPQBt0x5aC7wfTULBsiRG2lh5fjD9SgbIaaNp2n5NFPESorBxFsKBuZOATI5AnBQLQjk9Dbn5kxCoPrBYNT4QWfZ3qOcPN5R8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761641812; c=relaxed/simple;
	bh=ZLFgckHozr7eW4YKlduIQ3+65EtueBf+Qrv64FdSIKs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=bJeW5z1NKdRWs80TPzVxKviBVKu2ozxyp1vx05tV3R/zXdZv1CbMs96JoxuN3KFEtQSdtV/R1MRm96XrIofKhAkS/5y0u8uu9bBqUU/+gtB21C1M3WuXocEWrOYb3b4y8O2BO4kg9XMA2rWAVpWU2atqIIRWZRW/U8g0/NvhsG8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=IZgqHo0/; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IZgqHo0/"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1761641809;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=Vjq2XI1PL0QsCw5h3Oq1TkpcHLH9Us8qyuyRZAfMVnw=;
	b=IZgqHo0/nkdytmIF3MJGgzeLt9rkKybyL+u9XnO7YRAHluad6JNFkKi9FS0fxz+AbZNO3i
	1owyzpheu01G5NEI0ua0+doI2WaBLCAOSbt0tWDXfgzg1hRvjd6AgUy2GR5f2O/sGaYiC9
	iTKPm7m/Qaalw0UGD31k+EX0V2httN0=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-235-gLO9Uw6_OT-r35tsPHE72g-1; Tue,
 28 Oct 2025 04:56:45 -0400
X-MC-Unique: gLO9Uw6_OT-r35tsPHE72g-1
X-Mimecast-MFC-AGG-ID: gLO9Uw6_OT-r35tsPHE72g_1761641804
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 5BBB5195608E;
	Tue, 28 Oct 2025 08:56:44 +0000 (UTC)
Received: from localhost (unknown [10.72.120.23])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 1EFF530001A7;
	Tue, 28 Oct 2025 08:56:42 +0000 (UTC)
From: Ming Lei <ming.lei@redhat.com>
To: Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org
Cc: Uday Shankar <ushankar@purestorage.com>,
	Caleb Sander Mateos <csander@purestorage.com>,
	Ming Lei <ming.lei@redhat.com>
Subject: [PATCH V2 0/5] ublk: NUMA-aware memory allocation
Date: Tue, 28 Oct 2025 16:56:29 +0800
Message-ID: <20251028085636.185714-1-ming.lei@redhat.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

Hi Jens,

The 1st two patches implement ublk driver NUMA aware memory allocation.

The last two patches implement it for ublk selftest utility.

`taskset -c 0-31 ~/git/fio/t/io_uring -p0 -n16 -r 40 /dev/ublkb0` shows
5%~10% IOPS improvement on one AMD zen4 dual socket machine when creating
ublk/null with 16 queues and AUTO_BUF_REG(zero copy).


V2:
	- use a flexible array member for queues field, save one indirection
	  for retrieving ublk queue
	- rename __queues into queues 
	- remove the queue_size field from struct ublk_device
	- Move queue allocation and deallocation into ublk_init_queue() and
	ublk_deinit_queue() 
	- use flexible array for ublk_queue.ios
	- convert ublk_thread_set_sched_affinity() to use pthread_setaffinity_np()

Ming Lei (5):
  ublk: reorder tag_set initialization before queue allocation
  ublk: implement NUMA-aware memory allocation
  ublk: use flexible array for ublk_queue.ios
  selftests: ublk: set CPU affinity before thread initialization
  selftests: ublk: make ublk_thread thread-local variable

 drivers/block/ublk_drv.c             | 99 +++++++++++++++++-----------
 tools/testing/selftests/ublk/kublk.c | 70 ++++++++++++--------
 tools/testing/selftests/ublk/kublk.h |  9 +--
 3 files changed, 106 insertions(+), 72 deletions(-)

-- 
2.47.0


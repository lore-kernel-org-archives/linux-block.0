Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 354E91D7E4A
	for <linux-block@vger.kernel.org>; Sun, 13 Jul 2025 14:34:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752417270; cv=none; b=AhC8/0HLfWNQW4+8W+FD5kS0TSX1naXBc1dORwCNylokhvRJrcQ5xjkMi6Kp1erEiVjTPs4y2sSBmmz+3CoU9YD9jl/2hQjk5orZFkoNczIBxkZjr+L76Q4cJTS9tjAT7VKTJhh+hHf1mRQYuFHj4pDVWdTSQ8BHCEOLtf9TSFo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752417270; c=relaxed/simple;
	bh=HTIHC1ZIrE+boP4DB6+O3EgJ3GRUaL7fx6YhKFJK0Zc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=KUYlOJTNeIx9CoUW3HP6xgfa5XoX7/MrcWxOFl8lQfL0uAem5WlsWziRh4jIGftEbZj+962OCIzmQJwpmulofzOLIg6HNvMqY62APN5jPZJjF5MZK99tf0OCSQMFllfv/Kv/CqQZWWbTTgJb7veuenUXLEI8qNQYILqI+skBxLo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=UW5XiSde; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UW5XiSde"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1752417267;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=97XwedurIkuM+1wgrdf3/BvyjD6eaXe45RsTrm1C5Z0=;
	b=UW5XiSde9JvXaQ7YSnGDb4g1VEdof6BMABW5PGjyQd9ACFrYkdO11Zgmmzh3kgoi5gRv6n
	+XNoArPhvXhfnNAacua72iAF/9gbeFNtHowWXAhQBeN/xmJl7EzErpHaVDsxFgGl6L/gNu
	jlkgVdgoNLPogQDHDuujLLZQrPV9o4k=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-685--szXYEdZMp6TE_JB2fk3zg-1; Sun,
 13 Jul 2025 10:34:24 -0400
X-MC-Unique: -szXYEdZMp6TE_JB2fk3zg-1
X-Mimecast-MFC-AGG-ID: -szXYEdZMp6TE_JB2fk3zg_1752417264
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 849C3195608C;
	Sun, 13 Jul 2025 14:34:23 +0000 (UTC)
Received: from localhost (unknown [10.72.116.36])
	by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 6A30F19560A3;
	Sun, 13 Jul 2025 14:34:22 +0000 (UTC)
From: Ming Lei <ming.lei@redhat.com>
To: Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org
Cc: Uday Shankar <ushankar@purestorage.com>,
	Caleb Sander Mateos <csander@purestorage.com>,
	Ming Lei <ming.lei@redhat.com>
Subject: [PATCH V3 00/17] ublk: cleanup for supporting batch IO command
Date: Sun, 13 Jul 2025 22:33:55 +0800
Message-ID: <20250713143415.2857561-1-ming.lei@redhat.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40

Hi Jens,

The 1st 9 patches cleans ublk driver, and prepare for supporting
batch IO command which needs per-io lock.

The others are selftest cleanup, and prepare for supporting arbitrary
task context & ublk queue combination, which will be allowed with
batch IO feature.

ublk Batch IO feature introduction:

	- use per-queue multshot uring_cmd for fetching incoming io commands,
	and io command tag is saved to provided buffer

	- use per-queue uring_cmd for completing io command result, and io tag
	& result are filled in uring_cmd buffer

	- this way improves communication efficiency, also:

		- allows each queue to be handled in any pthread contexts, and each
		pthread context can handle any number of queues, and driver
		doesn't care ublk server context any more

		- help to apply blk-mq batch optimization in future

		- help to support io polling in future

	- github:

		https://github.com/ming1/linux/commits/ublk2-cmd-batch.v3/

Almost all feedback are from Caleb, and great thanks Caleb's review!

V3:	
	- add patch "ublk: validate ublk server pid"
	- clean "ublk: let ublk_fill_io_cmd() cover more things" by not setting
	  io->res in ublk_fill_io_cmd()
	- improve commit log
	- misc patch style fix
	- add reviewed-by tag

V2:
	- remove one unnecessary check (Caleb Sander Mateos)
	- add reviewed-by tag
	- rebase on latest for-6.17/block


Ming Lei (17):
  ublk: validate ublk server pid
  ublk: look up ublk task via its pid in timeout handler
  ublk: move fake timeout logic into __ublk_complete_rq()
  ublk: let ublk_fill_io_cmd() cover more things
  ublk: avoid to pass `struct ublksrv_io_cmd *` to
    ublk_commit_and_fetch()
  ublk: move auto buffer register handling into one dedicated helper
  ublk: store auto buffer register data into `struct ublk_io`
  ublk: add helper ublk_check_fetch_buf()
  ublk: remove ublk_commit_and_fetch()
  ublk: pass 'const struct ublk_io *' to ublk_[un]map_io()
  selftests: ublk: remove `tag` parameter of ->tgt_io_done()
  selftests: ublk: pass 'ublk_thread *' to ->queue_io() and
    ->tgt_io_done()
  selftests: ublk: pass 'ublk_thread *' to more common helpers
  selftests: ublk: remove ublk queue self-defined flags
  selftests: ublk: improve flags naming
  selftests: ublk: add helper ublk_handle_uring_cmd() for handle ublk
    command
  selftests: ublk: add utils.h

 drivers/block/ublk_drv.c                    | 254 ++++++++++++--------
 tools/testing/selftests/ublk/fault_inject.c |  15 +-
 tools/testing/selftests/ublk/file_backed.c  |  32 +--
 tools/testing/selftests/ublk/kublk.c        | 140 ++++++-----
 tools/testing/selftests/ublk/kublk.h        | 135 ++++-------
 tools/testing/selftests/ublk/null.c         |  32 +--
 tools/testing/selftests/ublk/stripe.c       |  33 +--
 tools/testing/selftests/ublk/utils.h        |  70 ++++++
 8 files changed, 391 insertions(+), 320 deletions(-)
 create mode 100644 tools/testing/selftests/ublk/utils.h

-- 
2.47.0


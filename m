Received: from mta0.migadu.com (out-253.mta0.migadu.com [91.218.175.253])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5255025B087
	for <linux-block@vger.kernel.org>; Sun, 30 Aug 2026 01:20:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.253
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788052821; cv=none; b=jA31OM3Bdk+69fTxQ7skkVXL8Vahd09/nXYT79KtxeU0XZNLW5quyybGjzcZmTjZsnQR/qzB7u1YCPVSSDz6D4gNXvY8GfsquyHyyGNtdpFY3YSU0fyEv4iEJOF8vflXoaa2LBsmdLsYpmWv7kK7NgwjoEIeZGpM5y1MblsiuGE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788052821; c=relaxed/simple;
	bh=gpQGpG7qEtQyNJlJklh36DqnhFW2herm9oLTciFJX0g=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=If6FreuEdyM5ZgNJ+en9NfwQt1u/XIdUQrc3vcgWGP68NUVaohmJTql3FJlPuPIf+MNGEIhkZR1tL3Vn7z4EWZh23ZCdnjrJ8luYp4uBbdIHOINHqOtS5Xd34/AETPK89LMHli97vvjo8WhlsiWJrmRXuzoy0pmoKK183MJQEGw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=iUtofOqm; arc=none smtp.client-ip=91.218.175.253
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="iUtofOqm"
X-Envelope-To: linux-block@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=gpQGpG7qEtQyNJlJklh36DqnhFW2herm9oLTciFJX0g=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1788052817; v=1; x=1788657617;
 b=iUtofOqmZ01GC7Hpujm5hHtY0QnXkq2ApNzbn8P1Pth9qBmRd3uM3gkyuVMv2Ae+zRH2CCfo
 HHEnx3xFkWJakvl9112etMM4LYNrL/PIrde3WnOhgGzvDsyUl8rrCM20aEudiNBYrEGh9hB3XJl
 Z+eboQV560VdlORie4j/PmAE=
X-Envelope-To: linux-block@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 5543b2e961126628;
	Sun, 30 Aug 2026 01:20:10 +0000
X-Mizu-Trace-ID: 5543b2e961126628
X-Migadu-Flow: FLOW_OUT
From: Md Haris Iqbal <haris.iqbal@linux.dev>
To: Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	Christoph Hellwig <hch@lst.de>,
	Keith Busch <kbusch@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>,
	linux-doc@vger.kernel.org,
	Md Haris Iqbal <haris.iqbal@linux.dev>
Subject: [v2 for-next 0/3] block: delay support for error injection
Date: Sun, 30 Aug 2026 03:19:59 +0200
Message-ID: <20260830012002.80275-1-haris.iqbal@linux.dev>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Error injection can only fail a bio today.  This adds a delay_us option so
that a rule can hold a bio back first, to model a slow device.

The delay happens above the driver, so it is invisible to the I/O
statistics and never reaches the blk-mq timeout handler or SCSI error
handling.  What it does exercise is the code waiting above the block
layer: io_uring cancellation, hung task detection, and filesystem or
userspace timeouts.

Two things are worth a look.  A delayed bio is marked with a new
BIO_ERROR_INJECTED bio flag, so the rules are not applied to it again and
it can never pick up a status from another rule.  Resubmitting it below the
injection hook is not enough on its own, because a bio is split below the
hook and the remainder is resubmitted above it.  And holding a bio back
reorders it against bios submitted later, which breaks sequential write
ordering on zoned devices.  Both are documented in patch 3.

Patch 1 is a prep cleanup.  It moves the rejection of an unknown status
tag into the parser, because patch 2 makes a rule without a status valid.

v1: https://lore.kernel.org/linux-block/20260827000115.128093-1-haris.iqbal@linux.dev/

Changes since v1:

 - Add the BIO_ERROR_INJECTED bio flag.  v1 only resubmitted a delayed bio
   below the injection hook, which left the remainder of a split going
   through the hook and matching the same rule again, so a bio was held
   once per split instead of once.

 - Patch 1: tag_to_blk_status() returns an error and passes the status back
   through a pointer, instead of returning BLK_STS_OK for both the "OK" tag
   and an unknown one.  A delay-only rule has no status, so the two have to
   be told apart.

 - Documentation: a delayed bio is held once rather than once per split.

Tested in a VM.

Md Haris Iqbal (3):
  block: reject unknown status tags in error injection rules
  block: allow error injection rules to delay bios
  Documentation: block: document error injection delays

 Documentation/block/error-injection.rst |  58 ++++++++-
 block/blk-core.c                        |  27 ++--
 block/blk.h                             |   3 +-
 block/error-injection.c                 | 165 +++++++++++++++++++++---
 block/error-injection.h                 |   1 +
 include/linux/blk_types.h               |   1 +
 6 files changed, 222 insertions(+), 33 deletions(-)

-- 
2.53.0


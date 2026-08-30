Received: from mta0.migadu.com (out-8.mta0.migadu.com [91.218.175.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 942FE148850
	for <linux-block@vger.kernel.org>; Sun, 30 Aug 2026 01:20:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788052829; cv=none; b=Hh6gTMc2VOerJo0PycJGZ4FAB1poPJe6C4buNRoOqVS7/+uFgEJqvUU5WYBBMXqLNbS3biJOzfxmO1z+HBXlE9qgWTm1JVtPX1eod+c6dfD/vu8a1Sh35g2uiEcW8HVZs16w0MKvjmYeNT4LmQEDH7BgEawe34gim+S4HQWy8tk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788052829; c=relaxed/simple;
	bh=cXHnugjrYFIs1UwN0nVV8md0Hm/sTFj0FoTfSt8CKkQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Kw3qdD4RQBVFD60T4Q6BIV14g19qtuwz82/dPe/FrQFXVF7uHhZbDQc1ldU2FCTYAsZgOrO0z9ZSAjJJDkHRiOtYALxo7aOtVJp7P8Owy1uW9tx/P5kWgRhivgJpSIKmBBPkzcDgieXgnwY8vCpiX5jD5lB2Xkeuyybb7ldMDUE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=uj+g9NvU; arc=none smtp.client-ip=91.218.175.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="uj+g9NvU"
X-Envelope-To: linux-block@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=cXHnugjrYFIs1UwN0nVV8md0Hm/sTFj0FoTfSt8CKkQ=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1788052825; v=1; x=1788657625;
 b=uj+g9NvUax7kkrmIpYg5SAngii4rI5NgZzTsmimdl7DRGWtZKrBbA4vzOltKw3RmjP45oemd
 c4Hn8XvTb+1yIkyINTqftazhZ8oPSr+ZUCLw2B2zLD+nJPvNohSU6CBT06lVB0SRDhdzxYx//6L
 nQJ2sM9NxgDidSbFkEHYpY58=
X-Envelope-To: linux-block@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 0ca15c6cd765ee62;
	Sun, 30 Aug 2026 01:20:25 +0000
X-Mizu-Trace-ID: 0ca15c6cd765ee62
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
Subject: [v2 for-next 3/3] Documentation: block: document error injection delays
Date: Sun, 30 Aug 2026 03:20:02 +0200
Message-ID: <20260830012002.80275-4-haris.iqbal@linux.dev>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260830012002.80275-1-haris.iqbal@linux.dev>
References: <20260830012002.80275-1-haris.iqbal@linux.dev>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Document the delay_us option: the delay happens above the driver, a
delayed bio is not run through the rules again, and holding a bio back
reorders it against bios submitted later.

Cc: Christoph Hellwig <hch@lst.de>
Signed-off-by: Md Haris Iqbal <haris.iqbal@linux.dev>
---
 Documentation/block/error-injection.rst | 58 ++++++++++++++++++++++++-
 1 file changed, 56 insertions(+), 2 deletions(-)

diff --git a/Documentation/block/error-injection.rst b/Documentation/block/error-injection.rst
index 81f31af82e65..a1f50d41211d 100644
--- a/Documentation/block/error-injection.rst
+++ b/Documentation/block/error-injection.rst
@@ -9,7 +9,8 @@ Overview
 
 Configurable error injection allows injecting specific block layer status codes
 for sector ranges of a block device.  Errors can be injected unconditionally, or
-with a given probability.
+with a given probability.  Instead of, or before, failing a bio it can also be
+held back for a while to model a slow device.
 
 To use configurable error injection, CONFIG_BLK_ERROR_INJECTION must be enabled.
 
@@ -34,15 +35,60 @@ op=<string>		block layer operation this rule applies to.  This uses
 			the XYZ for each REQ_OP_XYZ operation, e.g. READ, WRITE
 			or DISCARD. Mandatory.
 status=<string>		Status to return.  This uses XYZ for each BLK_STS_XYZ
-			code, e.g. IOERR or MEDIUM. Mandatory.
+			code, e.g. IOERR or MEDIUM. Mandatory unless delay_us
+			is given.
 start=<number>		First block layer sector the rule applies to.
 			Optional, defaults to 0.
 nr_sectors=<number>	Number of sectors this rule applies.
 			Optional, defaults to the remainder of the device.
 chance=<number>		Only return a failure with a likelihood of 1/chance.
 			Optional, defaults to 1 (always).
+delay_us=<number>	Hold the bio back for this many microseconds.  Without
+			status the bio is then submitted to the device as
+			usual, with status it is failed once the delay has
+			expired.  Optional, defaults to 0 (no delay).
+			Values above 600 seconds are rejected.
 ===================	=======================================================
 
+Delays
+------
+
+A delayed bio is held before it is submitted, so the device itself never sees a
+slow I/O: the delay is not visible to the driver, to the I/O statistics, or to
+anything else below submission such as writeback throttling.  Throttling by
+blk-throttle happens before a bio can be delayed, so it is not affected either.
+What it does exercise is everything waiting above the block layer, for instance
+io_uring cancellation, hung task detection, and filesystem or userspace
+timeouts.  Because the low level driver is not involved, a delay does not reach
+the blk-mq timeout handler or SCSI error handling.
+
+Once a bio has been delayed no rule is evaluated for it a second time, not when
+its delay expires and it is submitted below the injection hook, and not when
+the block layer splits it and resubmits the remainder above the hook.  A bio
+that matched a delay rule therefore never gets an error from another rule, even
+one covering the same sectors, and is held for the delay once rather than once
+per split.  Put the delay and the status in a single rule to fail a bio after
+holding it back.
+
+A delayed bio is issued after bios submitted while it was held, which reorders
+the I/O stream.  On zoned devices this breaks sequential write ordering: zone
+write plugging happens below the injection hook, so the writes issued while a
+write is held reach the zone out of order and are failed as misaligned.  Only
+delay reads there.
+
+Bios that must not block are never delayed.  A bio with REQ_NOWAIT set is
+submitted, or failed with the rule's status, immediately.
+
+The delay is a lower bound for anything longer than a timer tick, and the timer
+wheel adds further slack as the delay grows.  Values shorter than a tick are of
+little use: they expire on the next tick, which is anywhere between now and one
+tick away.
+
+Removing rules does not release bios that are already being delayed by them;
+those run out on their own.  A delayed bio whose disk is removed in the meantime
+is not submitted until its delay expires, by which point the queue no longer
+accepts I/O, so it fails with EIO.
+
 Example
 -------
 
@@ -54,6 +100,14 @@ Return BLK_STS_MEDIUM for every write to /dev/nvme0n1:
 
 	$ echo 'add,op=WRITE,start=0,status=MEDIUM' > /sys/kernel/debug/block/nvme0n1/error_injection
 
+Delay every read of /dev/nvme0n1 by 10 milliseconds, then issue it normally:
+
+	$ echo 'add,op=READ,delay_us=10000' > /sys/kernel/debug/block/nvme0n1/error_injection
+
+Fail one in 100 writes with BLK_STS_TIMEOUT, but only after 30 seconds:
+
+	$ echo 'add,op=WRITE,status=TIMEOUT,chance=100,delay_us=30000000' > /sys/kernel/debug/block/nvme0n1/error_injection
+
 Remove all rules for /dev/nvme0n1:
 
 	$ echo 'removeall' > /sys/kernel/debug/block/nvme0n1/error_injection
-- 
2.53.0


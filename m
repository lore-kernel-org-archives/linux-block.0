Received: from mta1.migadu.com (out-166.mta1.migadu.com [95.215.58.166])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 329DF259C82
	for <linux-block@vger.kernel.org>; Thu, 27 Aug 2026 00:01:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.166
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787788896; cv=none; b=nabKZrdn0FGDH7bF4ndv0Q/02zKiZReRDa+a9QjVYwb0Y+HA7I7Z3N1Wk+E4S5HdPd3ScTEap062uRzSInWqzLfkAjzDlAoJ+EhkCsL3zd2ot4Ch+yEDIPdIQizEgvSvKzoEv1xWbGViJKMHQATKrYmYmZ0Zxy7yFzR+kY27Nfo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787788896; c=relaxed/simple;
	bh=pG+zyDcr41wPY5rZsh7Dk2WwsFc7q1ojUQ0WexYU4FI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gQRy/SS+daH36mzNF49ZslBioZsc7qfV+OkRVIWXfCUyu8kvGTgAyXg9aJ1tfBOaI2znhbtuFgjJ2MYSSFVP/Duye02RgctDrmRgRswHlJQywWhLmsGKtTkH2AIhP39h022UFwvG03IcB8cHT35QWtH45uyiinuKxNXeMzFSP5w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=OnrMH8UT; arc=none smtp.client-ip=95.215.58.166
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="OnrMH8UT"
X-Envelope-To: linux-block@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=pG+zyDcr41wPY5rZsh7Dk2WwsFc7q1ojUQ0WexYU4FI=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1787788892; v=1; x=1788393692;
 b=OnrMH8UTvZ3WmdgAwHDvgF8PqoHHp5t1ozf8FXWTKiOmyTdKTQHB/LujXxdoxp0fO87KNz91
 bbQzpZ4vAS0xH68ZejMQ6NTiRvK79N/nM0j54e7D4NJUjXq/r/9+8gILDWfsyjmx8stm8KG5RW+
 X5kkFJ+d8z9Mr9/DcdMaGjaA=
X-Envelope-To: linux-block@vger.kernel.org
Received: from dragon-master.speedport.ip (2003:fc:df23:7abd:c598:7cec:94a0:927b)
	by smtp.migadu.com with ESMTPS id 2c6467ffe6f12a37;
	Thu, 27 Aug 2026 00:01:32 +0000
X-Mizu-Trace-ID: 2c6467ffe6f12a37
X-Migadu-Flow: FLOW_OUT
From: Md Haris Iqbal <haris.iqbal@linux.dev>
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Jonathan Corbet <corbet@lwn.net>,
	Md Haris Iqbal <haris.iqbal@linux.dev>,
	Christoph Hellwig <hch@lst.de>
Subject: [RFC for-next 3/3] Documentation: block: document error injection delays
Date: Thu, 27 Aug 2026 02:01:15 +0200
Message-ID: <20260827000115.128093-4-haris.iqbal@linux.dev>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260827000115.128093-1-haris.iqbal@linux.dev>
References: <20260827000115.128093-1-haris.iqbal@linux.dev>
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
 Documentation/block/error-injection.rst | 56 ++++++++++++++++++++++++-
 1 file changed, 54 insertions(+), 2 deletions(-)

diff --git a/Documentation/block/error-injection.rst b/Documentation/block/error-injection.rst
index 81f31af82e65..54490c23cde7 100644
--- a/Documentation/block/error-injection.rst
+++ b/Documentation/block/error-injection.rst
@@ -9,7 +9,8 @@ Overview
 
 Configurable error injection allows injecting specific block layer status codes
 for sector ranges of a block device.  Errors can be injected unconditionally, or
-with a given probability.
+with a given probability.  Instead of, or before, failing a bio it can also be
+held back for a while to model a slow device.
 
 To use configurable error injection, CONFIG_BLK_ERROR_INJECTION must be enabled.
 
@@ -34,15 +35,58 @@ op=<string>		block layer operation this rule applies to.  This uses
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
+Once its delay expires a bio is submitted below the injection hook, so no rule
+is evaluated for it a second time.  A bio that matched a delay rule therefore
+never gets an error from another rule, even one covering the same sectors.  Put
+the delay and the status in a single rule to fail a bio after holding it back.
+
+A delayed bio is issued after bios submitted while it was held, which reorders
+the I/O stream.  On zoned devices this breaks sequential write ordering: zone
+write plugging happens below the injection hook, so the writes issued while a
+write is held reach the zone out of order and are failed as misaligned.  Only
+delay reads there.  For the same reason, delaying one half of a split bio
+issues it out of order with the other half.
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
 
@@ -54,6 +98,14 @@ Return BLK_STS_MEDIUM for every write to /dev/nvme0n1:
 
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


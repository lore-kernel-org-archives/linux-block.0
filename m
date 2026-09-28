Received: from mta0.migadu.com (out-29.mta0.migadu.com [91.218.175.29])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7EF84915A0
	for <linux-block@vger.kernel.org>; Mon, 28 Sep 2026 22:17:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.29
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790633824; cv=none; b=aETtOzkOhPkbxtGEeGgq54rX0fDVhYVAOBJm/EdVZkXGGlVQ2CL5E8MzvpteHDwbbzDPyMfNWu0dehEkbYghp2t9Kd8jCYqAxCq917vCNFfJg9/wbQwZx3SWbI/N/W90Dn68sCYrl5xa7nEASU1XFLJ0bummaoFJ5cSgLGHHEhA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790633824; c=relaxed/simple;
	bh=MZdoZAnwAB9GP6tC7A/yxqOu30lwP/0wcpM/tqMatbo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rlQXtFxOY2HAc7ZB0BGr+MCC48LHU2exmr+MTQGmW6pDrIyCj76Zrx6XOXHq3ZxFiMS0fHdEu7360ciuKYXvpkqHnxj42ep5l+SNYeM3P30YCTtVdfc3NmixEOpJJRR7AOKYDFh9kzgm033qro6rWjIl0XtuLi0yNaLfnLsFmGE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=mPzj3Oqy; arc=none smtp.client-ip=91.218.175.29
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="mPzj3Oqy"
X-Envelope-To: linux-block@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=MZdoZAnwAB9GP6tC7A/yxqOu30lwP/0wcpM/tqMatbo=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1790633820; v=1; x=1791238620;
 b=mPzj3OqyOi6Q+sq+7oQrkrleAVCuoxT9FGk+MPNnhQ3KyrL4DjWuQRmF+1CtFGN8SG28ZNwb
 Vjn/0fuAxXYdyFKWebtcIxIybZDLSmX2mLk+UYv3h6Zi5ielP8nABmKJdJ+BAqHmL10r4MNiLj/
 UTS4qTyeW095VtS0/7JAGS68=
X-Envelope-To: linux-block@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 3f08fd830f2b654e;
	Mon, 28 Sep 2026 22:17:00 +0000
X-Mizu-Trace-ID: 3f08fd830f2b654e
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
Subject: [v3 for-next 3/3] Documentation: block: document error injection delay feature
Date: Tue, 29 Sep 2026 00:16:34 +0200
Message-ID: <20260928221634.43239-4-haris.iqbal@linux.dev>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260928221634.43239-1-haris.iqbal@linux.dev>
References: <20260928221634.43239-1-haris.iqbal@linux.dev>
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
Assisted-by: Claude:claude-opus-5
Signed-off-by: Md Haris Iqbal <haris.iqbal@linux.dev>
---
 Documentation/block/error-injection.rst | 39 +++++++++++++++++++++----
 1 file changed, 34 insertions(+), 5 deletions(-)

diff --git a/Documentation/block/error-injection.rst b/Documentation/block/error-injection.rst
index 81f31af82e65..6f7609b91d24 100644
--- a/Documentation/block/error-injection.rst
+++ b/Documentation/block/error-injection.rst
@@ -7,9 +7,9 @@ Configurable Error Injection
 Overview
 --------
 
-Configurable error injection allows injecting specific block layer status codes
-for sector ranges of a block device.  Errors can be injected unconditionally, or
-with a given probability.
+Configurable error injection allows injecting delays and/or specific block
+layer status codes for sector ranges of a block device by adding rules.  The
+rules can be configured to trigger unconditionally, or with a given probability.
 
 To use configurable error injection, CONFIG_BLK_ERROR_INJECTION must be enabled.
 
@@ -34,15 +34,36 @@ op=<string>		block layer operation this rule applies to.  This uses
 			the XYZ for each REQ_OP_XYZ operation, e.g. READ, WRITE
 			or DISCARD. Mandatory.
 status=<string>		Status to return.  This uses XYZ for each BLK_STS_XYZ
-			code, e.g. IOERR or MEDIUM. Mandatory.
+			code, e.g. IOERR or MEDIUM.  Mandatory unless delay_us
+			is given.
 start=<number>		First block layer sector the rule applies to.
 			Optional, defaults to 0.
 nr_sectors=<number>	Number of sectors this rule applies.
 			Optional, defaults to the remainder of the device.
-chance=<number>		Only return a failure with a likelihood of 1/chance.
+chance=<number>		Only apply the rule with a likelihood of 1/chance.
 			Optional, defaults to 1 (always).
+delay_us=<number>	Hold the bio back for this many microseconds.  Without
+			status the bio is then submitted to the device as
+			usual.  With status it is failed once the delay has
+			expired.  Bios with REQ_NOWAIT set are never delayed.
+			Optional, defaults to 0 (no delay).  Values above 600
+			seconds are rejected.
 ===================	=======================================================
 
+Delays
+------
+
+A delayed bio is held above the driver, so the device never sees a slow I/O.
+A delay does not reach the blk-mq timeout handler or SCSI error handling.
+
+A bio that matched a delay rule is not evaluated against the rules again, even
+after it is split and resubmitted internally.  Removing a rule does not release
+bios it is already delaying.
+
+Holding a bio back reorders it against bios submitted later.  On zoned devices
+this breaks sequential write ordering and the block layer fails the
+out-of-order writes, so only delay reads there.
+
 Example
 -------
 
@@ -54,6 +75,14 @@ Return BLK_STS_MEDIUM for every write to /dev/nvme0n1:
 
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


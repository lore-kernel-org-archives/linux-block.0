Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=91.218.175.71
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794434333;
	b=MCID/QlGR28hBugg03HjhlTAS//ju/b5lY5b3LxtIPkifBMtfNS10pR3MQ9o/RhQCw4x
	 QczEHN8Eed+YKCQA41HUCZXZz2XvGz8IpQgLREG46RmQ8zI98/DzyjBH1Q6F/JAF4UN2t
	 dJIw9ZelsI/+vXb10v/JrRAb7X2jxMNKW99LDNxuAZzOWKmvg2YkF4mJs+qlHjqCbYu+j
	 X4IMD87RMfltdzBtypUYxVR94/yy+HtktXfHUr9/CbjMnT1wlYYoamR9svP7xqoRGxX9Y
	 RX9pVNTxKxGT6JV+hkBhsXse+YqoxHjrP7Frg0KsodZ/xWzpcTCHLUdvZJrVepjrQOg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794434333;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=x1LsmbxOAx5CXXj8AXKZuuDkplqUnZlYf0CHx0xt86k=;
	b=k3nUfa0RS0Mcp9+SngP+mPSgTAd9fvA19VgaiQTCiecmq78y2h3xE3X00rkJCUKp121/
	 uPO+zuc6hmGrXMZk/8VqsH4YpeBOUCsLM5sTgBJeSXscWFc0F5yPJ3QthX+rObJoz4wGQ
	 K0+2mqYJuV01zU8HiWjYIgR3YnJvh+k9/9lG1QkQfZAsjAdiCGVZ39xeubYVLKqWQC36g
	 Jqtkd26kS8HMW55pMhJgDP1G1CD2X0fXZXoZBH51Qw6fSIE+RhHbRRDZmhP7FLXq6WbrK
	 qjRjesfzlj5GwQEm9ukiZRhY5L8RUZrVkW0em4zXbL1lYXTiQyj9q1MmxOwZe1wbk7A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=dYQYnpiM;
	arc=none smtp.remote-ip=91.218.175.71
Received: from mta0.migadu.com (out-71.mta0.migadu.com [91.218.175.71])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C9F5606A8B7
	for <linux-block@vger.kernel.org>; Wed, 11 Nov 2026 21:58:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9C9F5606A8B7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=dYQYnpiM
X-Envelope-To: linux-block@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=tiZlHIKEfkKGCmYVTR7dQpyeUw+qsEmn5z+EEQEQDqE=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1794434330; v=1; x=1795039130;
 b=dYQYnpiM8xHuFoDFccnswGD2mZ/elVIIHaAZpSXKS+q8NDpE6G/pcO/vakqaYWD0LQZYRcMf
 4XaPjBH97r2W3Rj/y+I+7pFE3ySQIjFIqRqAklavXTA9wotQFcJyiHTGHaTor7Ch2eG+qb18Rvs
 BkvPQcW/MLDhIiYT2abNZXuA=
X-Envelope-To: linux-block@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id c9c772de2866fb27;
	Wed, 11 Nov 2026 21:58:50 +0000
X-Mizu-Trace-ID: c9c772de2866fb27
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
Subject: [v4 3/3] Documentation: block: document error injection delay feature
Date: Wed, 11 Nov 2026 22:58:38 +0100
Message-ID: <20261111215838.103356-4-haris.iqbal@linux.dev>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261111215838.103356-1-haris.iqbal@linux.dev>
References: <20261111215838.103356-1-haris.iqbal@linux.dev>
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Post: <mailto:linux-block@vger.kernel.org>
List-Help: <mailto:linux-block+help@vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-block+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Document the delay_us option: the delay happens above the driver, a
delayed bio is not run through the rules again, and holding a bio back
reorders it against bios submitted later.

Cc: Christoph Hellwig <hch@lst.de>
Signed-off-by: Md Haris Iqbal <haris.iqbal@linux.dev>
---
 Documentation/block/error-injection.rst | 39 +++++++++++++++++++++----
 1 file changed, 34 insertions(+), 5 deletions(-)

diff --git a/Documentation/block/error-injection.rst b/Documentation/block/error-injection.rst
index 81f31af82e65..3c86defddb80 100644
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
+			expired.  Bios with REQ_NOWAIT set fail with
+			BLK_STS_AGAIN.  Optional, defaults to 0 (no delay).
+			Values above 600 seconds are rejected.
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


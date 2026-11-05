Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=79.135.106.112
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793843085;
	b=Vu2cbrXWqr7VyatnjKpKFKYa2bYcBnBdgxHZVRGpmSWlq3XZN18dBwSXDTpWasVtMqJa
	 Ru4WwBcK1JlzCTWgXGceiowufhycfsaDQDydYRYjq6QwXvCj5XN80BX5CwE62XaXrFaYz
	 UMx1EGZUApw4SzQE62XR+etkJnphFFj+kFwoyrmJNu5P+sTihJrfwOB7BthCRbcp1wnuG
	 mEx6NFuefE9dEAPg/HJaQGhmPbAqfEYS34rfsaV8DAaS2l4WJ+wafL9hMnUOlMH8qBUgF
	 SCdya5PqsHmTEO7tbafYPyvDBEGLnuPcI1MahbcM0kParwRfkfBZ9XB6UZ8cJK0ReVw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793843085;
	h=DMARC-Filter:DKIM-Signature:X-Pm-Submission-Id:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=KCPP0dcD8EhOUqbX6pSZ0CLuO8QQgf4ncI0Xmf3yuyY=;
	b=cP2LeABb04fOdMZeP4DhFKzG/xs78yTSTX9WzESZ5UYfXzV+FXDGgHPsUE5AhuuwR3zk
	 RO+vDbU3bkOBZrrL/kRjz2vbHNvDKaOd0nLueQ4W6bzYN9LSdQQFXD12EX153J2ItxTDE
	 FdBM5ihN3fOrCHxNSYFDWNJTclrYBhS9GBsqC7TTRRs7CFAKhOX4oGxpyEnPer54Hf2OT
	 VQVqxTwe5RBuW3x152USgPY008hu+/+1OS5g61a/+3jTOM5N0YeOVd4HVWp+LPkIU/+kc
	 g1Gf2AWLPnlWRoyu5DwoJ0ChKvIw752Mn1+prq1uInFFT3L3vIBhsijGQ2maxOBZ4Zw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=raidlab.org;
	spf=pass smtp.mailfrom=raidlab.org;
	dkim=pass header.d=raidlab.org header.i=@raidlab.org header.a=rsa-sha256 header.s=protonmail header.b=O+Wjvewa;
	arc=none smtp.remote-ip=79.135.106.112
Received: from mail-106112.protonmail.ch (mail-106112.protonmail.ch [79.135.106.112])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1995606A326
	for <linux-block@vger.kernel.org>; Thu,  5 Nov 2026 01:44:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E1995606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=raidlab.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=raidlab.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=raidlab.org header.i=@raidlab.org header.a=rsa-sha256 header.s=protonmail header.b=O+Wjvewa
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=raidlab.org;
	s=protonmail; t=1793843081; x=1794102281;
	bh=KCPP0dcD8EhOUqbX6pSZ0CLuO8QQgf4ncI0Xmf3yuyY=;
	h=From:To:Cc:Subject:Date:Message-ID:From:To:Cc:Date:Subject:
	 Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
	b=O+WjvewahS1O7uDT8Yim7m+7q/1JG9unKziCUB3Ti6maqnoJeIL6y30bPDdqs6v6G
	 YCPJGBZuz0QjvW7DsY7io32qvLwQD1SUs8quAvycFed7kDEXcJH+qbb2Eqy5faP3UK
	 ky6HDmKW2xS+Bsp9aPw/MCa1nsErvvUHpQO7mA3z2v4mjAhiT6AXkWjW+qlqor8K8Y
	 /rBShc8/vbkH+UkgqFGED2zlrmQy4F9CM3PmGZeIItV8zpAvDsiqHCl/HaiDgqjkiB
	 6V1E7P9W6OxLA7uSUk1RdZQ4CmzGKdtBgnAeH9QfWh1r68EBQm7ZZSctHFUpR6qXIh
	 gCdt+X3PN9nrw==
X-Pm-Submission-Id: 4jKlVJ1dv4z2ScX3
From: Miroslav Cimerman <mc@raidlab.org>
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Miroslav Cimerman <mc@raidlab.org>
Subject: [PATCH] null_blk: reset throttled state before device setup
Date: Thu,  5 Nov 2026 01:42:45 +0000
Message-ID: <20261105014245.436826-1-mc@raidlab.org>
X-Mailer: git-send-email 2.53.0
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

The NULLB_DEV_FL_THROTTLED flag is set at power on when mbps is set, and
is never cleared. Since commit 00a8cdb84fcb ("null_blk: remove
NULLB_DEV_FL_CONFIGURED on turning off nullb device") mbps can change
when the device is off. After a change to 0, the stale THROTTLED flag
sends I/O into the throttled I/O handler, whose hrtimer_active() runs on
an uninitialized timer, dereferencing a NULL pointer. A crash happens at
power on, as the first I/O that triggers the NULL dereference is
partition scanning I/O. This sequence triggers the crash:

  echo 100 > mbps; echo 1 > power; echo 0 > power; echo 0 > mbps;
  echo 1 > power

Clear the flag at the start of null_add_dev(), as is done in commit
5a4236bf2262 ("null_blk: reset cache state before device setup") for
NULLB_DEV_FL_CACHE. It is set again when mbps is set.

Fixes: 00a8cdb84fcb ("null_blk: remove NULLB_DEV_FL_CONFIGURED on turning off nullb device")
Signed-off-by: Miroslav Cimerman <mc@raidlab.org>
---
 drivers/block/null_blk/main.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/block/null_blk/main.c b/drivers/block/null_blk/main.c
index ec0d7ba4d938..924ec6cfdcaa 100644
--- a/drivers/block/null_blk/main.c
+++ b/drivers/block/null_blk/main.c
@@ -1977,6 +1977,7 @@ static int null_add_dev(struct nullb_device *dev)
 	if (rv)
 		return rv;
 	clear_bit(NULLB_DEV_FL_CACHE, &dev->flags);
+	clear_bit(NULLB_DEV_FL_THROTTLED, &dev->flags);
 
 	nullb = kzalloc_node(sizeof(*nullb), GFP_KERNEL, dev->home_node);
 	if (!nullb) {

base-commit: e6ac1da6a53c5f670bf09e60a2500d15be68d2fc
-- 
2.53.0


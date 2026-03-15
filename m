Received: from pdx-out-004.esa.us-west-2.outbound.mail-perimeter.amazon.com (pdx-out-004.esa.us-west-2.outbound.mail-perimeter.amazon.com [44.246.77.92])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4654717B43F;
	Sun, 15 Mar 2026 14:32:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=44.246.77.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773585159; cv=none; b=j9yhJajT6hnQ5oSZTUxfNg8tMMzOZaGOn73TTfPWrenzefyX20ohdv+8jjOIgXw4rkcRamr5+d/IRP2H1ZrQsSXSGHi5qOf8E4ESiY8RcJ99MsRwcrhcILjU8LYAr34iA5PmM36bCmg07pKR00MUGoJKtwofkFACuu89MsOkBZQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773585159; c=relaxed/simple;
	bh=8tio//65nu2QkUsp3azPRixBkUeGk3qPQ+FsUc1YQzE=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=DuYE7PftUnkeFnvG3pgazn5wKRFFHZoSZT7ez0QMhTBfaeTrBfUH9VczNXXXxFWRRV51EfwUwq+9i+vIoRRPztd1iLG1JM3rOfO9TgYiB0Mctp3MgVp32gIZddwgGohthqxx57QfJ6gIP0k56ULAPsWNPWi34mDySfZlRmyY48c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.com; dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b=K3VkBJzZ; arc=none smtp.client-ip=44.246.77.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b="K3VkBJzZ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazoncorp2;
  t=1773585158; x=1805121158;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=xNpo8UZillkzK3SUmUYU8l66d+ulaExYLIW8f3bbwkE=;
  b=K3VkBJzZVg1fyZiNtQomrO2WqVOkCrZfxw2lJ8jrxlNcAHZfaZrvPo0u
   d/B6/fLev4zcsg6ZPGih9FIqSgy/RBeeq6tjIeaOImSUGPjXzYBSJ7w84
   yfQ6fYw0XdufE9lNKO20NLMVcCWPIlk7K+cNcsEwngBVaixhinmcPR7E4
   6FN1NwHPb4Uv5BEPJ3uLlJfRY4zuVF6bAPnmNH+RI/b9Q0N0KUIAmk2FP
   qfoDuOrHwOBoXkr4sDN4Hj/Gn9wweqF3q4ePkqgI6GYjVSFtBhnuKIxvU
   Op/b7+WJ2uoWE7pqs9gyapzWcNbQCevN7KBBb57GiaEGILVeUl3NjJbJh
   w==;
X-CSE-ConnectionGUID: ywFoNB1mTHmDOGsy9LzAgw==
X-CSE-MsgGUID: E/frN9ovQdyTgDlU3gdc8g==
X-IronPort-AV: E=Sophos;i="6.23,122,1770595200"; 
   d="scan'208";a="15063387"
Received: from ip-10-5-12-219.us-west-2.compute.internal (HELO smtpout.naws.us-west-2.prod.farcaster.email.amazon.dev) ([10.5.12.219])
  by internal-pdx-out-004.esa.us-west-2.outbound.mail-perimeter.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Mar 2026 14:32:35 +0000
Received: from EX19MTAUWA002.ant.amazon.com [205.251.233.178:5227]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.22.225:2525] with esmtp (Farcaster)
 id 18ca6aee-e01a-40e4-b3f7-7ed9d1c4e035; Sun, 15 Mar 2026 14:32:35 +0000 (UTC)
X-Farcaster-Flow-ID: 18ca6aee-e01a-40e4-b3f7-7ed9d1c4e035
Received: from EX19D001UWA001.ant.amazon.com (10.13.138.214) by
 EX19MTAUWA002.ant.amazon.com (10.250.64.202) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.37;
 Sun, 15 Mar 2026 14:32:35 +0000
Received: from c889f3b07a0a.amazon.com (10.106.83.8) by
 EX19D001UWA001.ant.amazon.com (10.13.138.214) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.37;
 Sun, 15 Mar 2026 14:32:33 +0000
From: Yuto Ohnuki <ytohnuki@amazon.com>
To: Jens Axboe <axboe@kernel.dk>
CC: Yu Kuai <yukuai@fnnas.com>, Nilay Shroff <nilay@linux.ibm.com>, Ming Lei
	<ming.lei@redhat.com>, <linux-block@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Yuto Ohnuki <ytohnuki@amazon.com>,
	<syzbot+71fcf20f7c1e5043d78c@syzkaller.appspotmail.com>
Subject: [PATCH] blk-wbt: remove WARN_ON_ONCE from wbt_init_enable_default()
Date: Sun, 15 Mar 2026 14:31:38 +0000
Message-ID: <20260315143137.13547-2-ytohnuki@amazon.com>
X-Mailer: git-send-email 2.50.0
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ClientProxiedBy: EX19D031UWA001.ant.amazon.com (10.13.139.88) To
 EX19D001UWA001.ant.amazon.com (10.13.138.214)
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

wbt_init_enable_default() uses WARN_ON_ONCE to check for failures from
wbt_alloc() and wbt_init(). However, both are expected failure paths:

- wbt_alloc() can return NULL under memory pressure (-ENOMEM)
- wbt_init() can fail with -EBUSY if wbt is already registered

syzbot triggers this by injecting memory allocation failures during MTD
partition creation via ioctl(BLKPG), causing a spurious warning.

wbt_init_enable_default() is a best-effort initialization called from
blk_register_queue() with a void return type. Failure simply means the
disk operates without writeback throttling, which is harmless.

Replace WARN_ON_ONCE with plain if-checks, consistent with how
wbt_set_lat() in the same file already handles these failures.

Reported-by: syzbot+71fcf20f7c1e5043d78c@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=71fcf20f7c1e5043d78c
Fixes: 41afaeeda509 ("blk-wbt: fix possible deadlock to nest pcpu_alloc_mutex under q_usage_counter")
Signed-off-by: Yuto Ohnuki <ytohnuki@amazon.com>
---
 block/blk-wbt.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/block/blk-wbt.c b/block/blk-wbt.c
index 33006edfccd4..4337cbb7380c 100644
--- a/block/blk-wbt.c
+++ b/block/blk-wbt.c
@@ -782,10 +782,10 @@ void wbt_init_enable_default(struct gendisk *disk)
 		return;
 
 	rwb = wbt_alloc();
-	if (WARN_ON_ONCE(!rwb))
+	if (!rwb)
 		return;
 
-	if (WARN_ON_ONCE(wbt_init(disk, rwb))) {
+	if (wbt_init(disk, rwb)) {
 		wbt_free(rwb);
 		return;
 	}
-- 
2.50.1




Amazon Web Services EMEA SARL, 38 avenue John F. Kennedy, L-1855 Luxembourg, R.C.S. Luxembourg B186284

Amazon Web Services EMEA SARL, Irish Branch, One Burlington Plaza, Burlington Road, Dublin 4, Ireland, branch registration number 908705




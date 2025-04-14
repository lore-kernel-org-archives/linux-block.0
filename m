Received: from szxga07-in.huawei.com (szxga07-in.huawei.com [45.249.212.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB13B15F306
	for <linux-block@vger.kernel.org>; Mon, 14 Apr 2025 13:37:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.35
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744637845; cv=none; b=OLYZ1W7bVigA5B/0EW471JXJGJG/xSoYEMNyHY7JlXgIQdEIJE7LIU8Y9+zCOymF8Q+pCEdgg2pcpzpPdf7+8zodOKGwp1JyV96I1RHmFdTtupLItyEBYVjNSGQx4S+96bOMzhnYZleJ5iUAgS7xE322dxqVSEcTeCKux34Mp2s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744637845; c=relaxed/simple;
	bh=aHALtZuZlmwLX902cyZ802hELlO07nD4Z466j2QN5xw=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=U4EUIZSAJNIo7Wa9m2llJlfzC+OxkiBUl3gA1c3uuHmoGGYX2gaoZtU+U+pl5d4hmSRe1DpguPSsYp8zJ0+rmSOA1r3loFmzj+j5MnPnSKTyvWPEBTKklLf49nzmrB8RFMWAoejfZrW05aHMdJsGoYFcPX6YLV5n1IAao8mvrb8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.17])
	by szxga07-in.huawei.com (SkyGuard) with ESMTP id 4ZbpHX5P9yzsSnH;
	Mon, 14 Apr 2025 21:37:12 +0800 (CST)
Received: from kwepemf100017.china.huawei.com (unknown [7.202.181.16])
	by mail.maildlp.com (Postfix) with ESMTPS id 9FFA31A0188;
	Mon, 14 Apr 2025 21:37:18 +0800 (CST)
Received: from localhost.localdomain (10.175.112.188) by
 kwepemf100017.china.huawei.com (7.202.181.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Mon, 14 Apr 2025 21:37:17 +0800
From: Zizhi Wo <wozizhi@huawei.com>
To: <axboe@kernel.dk>, <linux-block@vger.kernel.org>
CC: <yangerkun@huawei.com>, <yukuai3@huawei.com>, <wozizhi@huawei.com>,
	<ming.lei@redhat.com>, <tj@kernel.org>
Subject: [PATCH 0/7] blk-throttle: Split the blkthrotl queue to solve the IO delay issue
Date: Mon, 14 Apr 2025 21:27:24 +0800
Message-ID: <20250414132731.167620-1-wozizhi@huawei.com>
X-Mailer: git-send-email 2.46.1
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 kwepemf100017.china.huawei.com (7.202.181.16)

[BUG]
The current blkthrotl code provides two types of throttling: BPS limit and
IOPS limit. When both limits are enabled, an IO is only dispatched if it
meets both the BPS and IOPS restrictions. However, when both BPS and IOPS
are limited simultaneously, an IO delayed dispatch issue can occur due to
IO splitting. For example, if two 1MB IOs are issued with a BPS limit of
1MB/s and a very high IOPS limit, the IO splitting will cause both IOs to
complete almost "simultaneously" in 2 seconds.

[CAUSE]
The root cause of this issue is that blkthrotl mixes BPS and IOPS into a
single queue. When issuing multiple IOs sequentially, the continuously
split IOs will repeatedly enter the same queue. As they alternately go
through the throtl process, IOs that have already been throttled will have
to wait for IOs that have not yet been throttled. As a result, all IOs will
eventually complete almost together.

[FIX]
Since IO requests that have already been split no longer need to go through
BPS throttling but still require IOPS control, this patchset splits the
existing blkthrotl queue into two separate queues: BPS and IOPS.
1) IO requests must first pass through the BPS queue.
2) Once they meet the BPS limit, they proceed to the IOPS queue before
being dispatched.
3) Already split IO requests bypass the BPS queue and go directly to the
IOPS queue.

[OVERVIEW]
This patchset consists of 7 patches:
1) Patch 1 is a simple clean_up.
2) Patch 2-4, to facilitate the subsequent splitting of queues. Patch 2-3
separate the -dispatch- and -charge- functions based on the BPS and IOPS.
Patch 4 introduce a new flag to prevent double counting.
3) Patch 5-6 splits the original single queue into two separate queues(BPS
and IOPS) without altering the existing code logic.
4) Patch 7 ensures that split IO requests bypass the BPS queue, preventing
unnecessary throttling and eliminating the delay issue.

Zizhi Wo (7):
  blk-throttle: Rename tg_may_dispatch() to tg_dispatch_time()
  blk-throttle: Refactor tg_dispatch_time by extracting
    tg_dispatch_bps/iops_time
  blk-throttle: Split throtl_charge_bio() into bps and iops functions
  blk-throttle: Introduce flag "BIO_TG_BPS_THROTTLED"
  blk-throttle: Split the blkthrotl queue
  blk-throttle: Split the service queue
  blk-throttle: Prevents the bps restricted io from entering the bps
    queue again

 block/blk-throttle.c      | 288 +++++++++++++++++++++++++-------------
 block/blk-throttle.h      |  14 +-
 include/linux/blk_types.h |   5 +
 3 files changed, 202 insertions(+), 105 deletions(-)

-- 
2.46.1


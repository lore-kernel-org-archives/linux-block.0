Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68E111F16B
	for <linux-block@vger.kernel.org>; Wed, 23 Apr 2025 02:33:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745375605; cv=none; b=bc85SYKqA9o9LhEXggB2hNB21PAFPhEynye2AWcoMlva6LfAuQkgBVhh7O0y7HLl4BTMwhA06dj46Rz9c+7ZzEGL3RFZBLiBRoZLqgS9hqNDkCiLd5wcT5N46yOociEsolGkZUxHcdvmmrBEurSb/Vr2h42Oum7L3QiSxxtuK3M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745375605; c=relaxed/simple;
	bh=q8iNEepY34XyAFsk9ihOW1EbKY18bisuBlVuVP8CCDE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=kSN7DleoGppTHx918Lz+QdT3XHmmzqmE7nOczD+7f2XatJxUavOATSns5XrpzbKlMzM6sheI5fA2lMo196FN3E2Iej7ZSnYyZ9qHTp74taWFIr4xJYWpyIgPTNoe0Q8X5EZ8DaR1vZlP2ZqFJyxDSU0wPYz4X1WF0w+9LpxNFYM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.93.142])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4Zj3711LFhz4f3kJw
	for <linux-block@vger.kernel.org>; Wed, 23 Apr 2025 10:33:01 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id CDA2E1A07BB
	for <linux-block@vger.kernel.org>; Wed, 23 Apr 2025 10:33:19 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.112.188])
	by APP4 (Coremail) with SMTP id gCh0CgB3219rUQhoCGcsKQ--.37591S4;
	Wed, 23 Apr 2025 10:33:17 +0800 (CST)
From: Zizhi Wo <wozizhi@huaweicloud.com>
To: axboe@kernel.dk,
	linux-block@vger.kernel.org
Cc: yangerkun@huawei.com,
	yukuai3@huawei.com,
	wozizhi@huaweicloud.com,
	ming.lei@redhat.com,
	tj@kernel.org
Subject: [PATCH V4 0/7] blk-throttle: Split the blkthrotl queue to solve the IO delay issue
Date: Wed, 23 Apr 2025 10:22:54 +0800
Message-ID: <20250423022301.3354136-1-wozizhi@huaweicloud.com>
X-Mailer: git-send-email 2.46.1
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgB3219rUQhoCGcsKQ--.37591S4
X-Coremail-Antispam: 1UD129KBjvJXoWxJFyfuryfAw4rAFW8Wr13XFb_yoW5Aw47pr
	WfWw4Yk3WkJFsrK34fWrnIqaySq3ykJrZrCr97JrW3J3WkZrW0qr1fKrW8ZFWxAF9xWa1a
	gryUtrs5uF1UZrDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUkG14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26F1j6w1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4U
	JVWxJr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gc
	CE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E
	2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJV
	W8JwACjcxG0xvY0x0EwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lc7CjxVAaw2AFwI0_
	JF0_Jw1l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67
	AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r126r1DMIIY
	rxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14
	v26r1j6r4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8
	JwCI42IY6I8E87Iv6xkF7I0E14v26r1j6r4UYxBIdaVFxhVjvjDU0xZFpf9x0JUBVbkUUU
	UU=
X-CM-SenderInfo: pzr2x6tkl6x35dzhxuhorxvhhfrp/

Changes since V1-3:
1) Updated the comments in patches 4 and 6 for greater specificity.
2) In patch 6, replaced the @queued parameter with @sq in both
throtl_qnode_add_bio and throtl_pop_queued to facilitate internal changes.
And the potential problem of null pointer dereference has been fixed.

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

Noted, a regression test is posted earlier:
https://lore.kernel.org/all/20250307080318.3860858-3-yukuai1@huaweicloud.com/

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

 block/blk-throttle.c      | 302 ++++++++++++++++++++++++--------------
 block/blk-throttle.h      |  17 ++-
 include/linux/blk_types.h |   8 +
 3 files changed, 214 insertions(+), 113 deletions(-)

-- 
2.46.1


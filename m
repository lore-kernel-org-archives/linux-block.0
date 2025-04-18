Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AF502522A1
	for <linux-block@vger.kernel.org>; Fri, 18 Apr 2025 04:19:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744949969; cv=none; b=QAjdLGmj8KMuBT2AXdO08h8rPe2A6tdmwOF3NU8hcs3tlH6oeJphDdDe6Qdv6g8LZOTFJocHMWoO/O1BEwnds8RXICgOc4QB9JAbdtUzFhWV0mdTNDeDfiPTgfvrVIbTAaw56pBOK94ltDS+jpZt4zs+diIQwLcx0TSkaNzKuEg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744949969; c=relaxed/simple;
	bh=I0gw0QFbXVW3X8/HPDvj+oolg8GFQUD+hOH9HoK1wyY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=FPvL65+B6Bgz1g9pBsDb5sGWnVwj9a6qCf1XtfGF79jaVK08L9oSrcpLW5UN3t1GOdgouTS5R2/EN2CdmOAw9EIXlkz/9zN5fO/caCuxF13hAmFz1T5ycY1NiVYWjSVE1ojo8QL9pbIhR/CYmJUYCZguITgZT0SLiGGcP2ix5wc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.216])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4Zf1jb5Yrmz4f3jsm
	for <linux-block@vger.kernel.org>; Fri, 18 Apr 2025 12:18:59 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 8870D1A1969
	for <linux-block@vger.kernel.org>; Fri, 18 Apr 2025 12:19:23 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.112.188])
	by APP4 (Coremail) with SMTP id gCh0CgBXul7K0gFoPDtDJw--.14109S4;
	Fri, 18 Apr 2025 12:19:23 +0800 (CST)
From: Zizhi Wo <wozizhi@huaweicloud.com>
To: axboe@kernel.dk,
	linux-block@vger.kernel.org
Cc: yangerkun@huawei.com,
	yukuai3@huawei.com,
	wozizhi@huaweicloud.com,
	ming.lei@redhat.com,
	tj@kernel.org
Subject: [PATCH V3 0/7] blk-throttle: Split the blkthrotl queue to solve the IO delay issue
Date: Fri, 18 Apr 2025 12:09:17 +0800
Message-ID: <20250418040924.486324-1-wozizhi@huaweicloud.com>
X-Mailer: git-send-email 2.46.1
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgBXul7K0gFoPDtDJw--.14109S4
X-Coremail-Antispam: 1UD129KBjvJXoWxAF1xCrWrtF1ktFWxJF1rtFb_yoW5Ww1kpr
	WfWw4Yka1kJFsrK34fWrnIqaySqa97JrZrCr97JrW3J3WkZrW0qr1ftrW8ZFWxAasxua1a
	qryUtrs5uF1UA3DanT9S1TB71UUUUUDqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUkC14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26w1j6s0DM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4U
	JVWxJr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gc
	CE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E
	2Ix0cI8IcVAFwI0_JrI_JrylYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJV
	W8JwACjcxG0xvY0x0EwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lc7CjxVAaw2AFwI0_
	JF0_Jw1l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67
	AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r126r1DMIIY
	rxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_JFI_Gr1lIxAIcVC0I7IYx2IY6xkF7I0E14
	v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8
	JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjfUr2-eDU
	UUU
X-CM-SenderInfo: pzr2x6tkl6x35dzhxuhorxvhhfrp/

From: Zizhi Wo <wozizhi@huawei.com>

Changes since V1-2:
1) Fixed minor comment issues in patch 4.
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
 block/blk-throttle.h      |  14 +-
 include/linux/blk_types.h |   5 +
 3 files changed, 208 insertions(+), 113 deletions(-)

-- 
2.46.1


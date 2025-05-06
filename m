Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65DC92FF2B5
	for <linux-block@vger.kernel.org>; Tue,  6 May 2025 02:20:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746498043; cv=none; b=CBQ9E31sCgVb0y/kJLDUnUmXEqSYwDR3dda498wZsz+lQI8KMRSo2fw3+Po9j4ryjrp/fQBZWBuSkYYLncd5i79ru3dPk1jqpU3TwstZRcP1OjfHq1Rms7OsWUz+NV6UNgWubl06qVX6NIkvzg3N3iumBW1E6R3nRpDWPj8AcC0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746498043; c=relaxed/simple;
	bh=OD0+JvfZvsAqZv4GDomtpHD/2lTEqO3/fs9DnX+gGWU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=jObWXMcY4Z5GGKwlPs11WqDH0QTfPXaJxRJiBf4zpqn2VlrXH+gYW2qfA9mHmMPrDy6przbnQiBaM1Qfd96pivZ0vdmV9CIHX4YTa6RPPgkupUdebOjW2sl/291dSVdczlBqfj1TRPnOD4YvZUV8PTInSr9QWzKQIAdwcg/ybL8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.93.142])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4Zs2DD1Ggyz4f3l2k
	for <linux-block@vger.kernel.org>; Tue,  6 May 2025 10:20:12 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 9C2EE1A0359
	for <linux-block@vger.kernel.org>; Tue,  6 May 2025 10:20:36 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.112.188])
	by APP4 (Coremail) with SMTP id gCh0CgBXvGDxcRloS3NDLg--.28694S4;
	Tue, 06 May 2025 10:20:35 +0800 (CST)
From: Zizhi Wo <wozizhi@huaweicloud.com>
To: axboe@kernel.dk,
	linux-block@vger.kernel.org
Cc: yangerkun@huawei.com,
	yukuai3@huawei.com,
	wozizhi@huaweicloud.com,
	ming.lei@redhat.com,
	tj@kernel.org
Subject: [PATCH V5 0/7] blk-throttle: Split the blkthrotl queue to solve the IO delay issue
Date: Tue,  6 May 2025 10:09:27 +0800
Message-ID: <20250506020935.655574-1-wozizhi@huaweicloud.com>
X-Mailer: git-send-email 2.46.1
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgBXvGDxcRloS3NDLg--.28694S4
X-Coremail-Antispam: 1UD129KBjvJXoWxJFyfuryfAw4rAFW8Wr13XFb_yoW5CF1fpr
	WfWw4Yka1kAFsrK34fWrnFqaySq3ykJrZrCr97JrW3J3Z5ZrW0qr4Syr48ZFWxAasxW3Wa
	gryUtrs5uF1UZ37anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUkG14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26F1j6w1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26F4j
	6r4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oV
	Cq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0
	I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r
	4UM4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwCY1x0262kKe7AKxVWU
	AVWUtwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14
	v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_JF0_Jw1lIxkG
	c2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI
	0_Jr0_Gr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r4U
	MIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x0JUBVbkUUU
	UU=
X-CM-SenderInfo: pzr2x6tkl6x35dzhxuhorxvhhfrp/

Changes since V4:
Patch 6 was modified to resolve the conflict.

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

 block/blk-throttle.c      | 300 ++++++++++++++++++++++++--------------
 block/blk-throttle.h      |  17 ++-
 include/linux/blk_types.h |   8 +
 3 files changed, 213 insertions(+), 112 deletions(-)

-- 
2.46.1


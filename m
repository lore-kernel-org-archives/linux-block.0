Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D10FA210F49
	for <linux-block@vger.kernel.org>; Thu, 17 Apr 2025 11:08:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744888121; cv=none; b=SZyR1D2KdFaR/of+upaRKFUfxxXM/twMy0qQfrUibwaxHHmCRTyAWXs/PJQMwFs8rKejawRvClDmJ5Thi52c9yqgkzi5oTFh2bcK9a+c5werX3GZnJvcLVNMh6HAZRE/LXXabU/JPnyfe2pdv+MPIdRYvdFpSjSlejMNKYnwa0s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744888121; c=relaxed/simple;
	bh=3TLQ0+gO2FEaQTQ7QwApFwCufhhWeeHhir9Qal1xm4E=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=V5g7qBr5KdSgnGjYnCFfeYxzJJe2MrXkT+qt31X/vK0Js6wOuq3OjbC3Om/rDMu00QU6g+cjvYyE1Q9Up3sB5Z8CPAnpew8lSqPPETr8vhVW1l3EV8v4sfUj29CTDEsVpExC2azeOK0Z/WGT3YrLiUJK0g5Pe8r5IdIr36buW0Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.235])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4ZdZrC5zHPz4f3jtF
	for <linux-block@vger.kernel.org>; Thu, 17 Apr 2025 19:08:11 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 386941A058E
	for <linux-block@vger.kernel.org>; Thu, 17 Apr 2025 19:08:30 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.112.188])
	by APP4 (Coremail) with SMTP id gCh0CgC3Gl8s4QBoyDT8Jg--.2150S4;
	Thu, 17 Apr 2025 19:08:30 +0800 (CST)
From: Zizhi Wo <wozizhi@huawei.com>
To: axboe@kernel.dk,
	linux-block@vger.kernel.org
Cc: yangerkun@huawei.com,
	yukuai3@huawei.com,
	wozizhi@huaweicloud.com,
	ming.lei@redhat.com,
	tj@kernel.org
Subject: [PATCH V2 0/7] blk-throttle: Split the blkthrotl queue to solve the IO delay issue
Date: Thu, 17 Apr 2025 18:58:26 +0800
Message-ID: <20250417105833.1930283-1-wozizhi@huawei.com>
X-Mailer: git-send-email 2.46.1
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgC3Gl8s4QBoyDT8Jg--.2150S4
X-Coremail-Antispam: 1UD129KBjvJXoWxGrWDJw48WryxuF4xXw47urg_yoW5Xw43pr
	WfWw4Yka1kAFsrK34fur1aqaySqa97JrZrGr97Jr43Jw1kZrW0qr1ftrW8ZFWxAasxWa1a
	gry5trs5uF1UA3DanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUU9Kb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x
	0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
	6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFV
	Cjc4AY6r1j6r4UM4x0Y48IcxkI7VAKI48JM4x0aVACjI8F5VA0II8E6IAqYI8I648v4I1l
	c7CjxVAaw2AFwI0_JF0_Jw1l42xK82IYc2Ij64vIr41l42xK82IY64kExVAvwVAq07x20x
	yl4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK
	67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r126r1DMIIYrxkI7VAKI48JMIIF0xvE2Ix0cI
	8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r1j6r4UMIIF0xvE42xK8VAv
	wI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14
	v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjxUwsqXDUUUU
Sender: wozizhi@huaweicloud.com
X-CM-SenderInfo: pzr2x6tkl6x35dzhxuhorxvhhfrp/

Changes since V1:
1) Fixed minor comment issues in patch 4.
2) In patch 6, replaced the @queued parameter with @sq in both
throtl_qnode_add_bio and throtl_pop_queued to facilitate internal changes.

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

 block/blk-throttle.c      | 301 ++++++++++++++++++++++++--------------
 block/blk-throttle.h      |  14 +-
 include/linux/blk_types.h |   5 +
 3 files changed, 207 insertions(+), 113 deletions(-)

-- 
2.46.1


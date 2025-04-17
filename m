Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5F0117E00E
	for <linux-block@vger.kernel.org>; Thu, 17 Apr 2025 13:30:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744896657; cv=none; b=FMM/ydKSlyGi/7zvG4TIzwRsFuT1bq3evM/OQxN3o/+ZyKujyJbdKRbnsVPQpf4tWt9iPIy0kSciQwCw25Y7zkp62JJd/rTXlwg5hnVw5rqeL54ulMKbPuYVTzs4jcdh33M27MuXX6GdDcB4rQ+4PIRkJg1MC3u1ykzKZz6yww0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744896657; c=relaxed/simple;
	bh=u1alj+Qix8CevZwSf56DQzAQ1XpFM/axvjDx3sybMFs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=D9/Nrh7qh8+c/6mDcq+K2wr9Q4+BbFfarvcIDZscKN6PFzII3ODlX0vyxvtoMYHi/y47Bis329TOPqsprZRrKqhiplcULTane9e5YakBRO7S1CkwuSScwlRzHwW87AoJCHVFoXtNW8ZD1uNI5oQiGc5TgCYO3SHuk1PITXBRtTA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.235])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4Zdf0K5f0wz4f3lg9
	for <linux-block@vger.kernel.org>; Thu, 17 Apr 2025 21:30:25 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 1473A1A06DC
	for <linux-block@vger.kernel.org>; Thu, 17 Apr 2025 21:30:51 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.112.188])
	by APP4 (Coremail) with SMTP id gCh0CgDXOl+KAgFoiwYGJw--.9194S4;
	Thu, 17 Apr 2025 21:30:50 +0800 (CST)
From: Zizhi Wo <wozizhi@huaweicloud.com>
To: axboe@kernel.dk,
	linux-block@vger.kernel.org
Cc: yangerkun@huawei.com,
	yukuai3@huawei.com,
	wozizhi@huaweicloud.com,
	ming.lei@redhat.com,
	tj@kernel.org
Subject: [PATCH V2 0/3] blk-throttle: Some bugfixes and modifications
Date: Thu, 17 Apr 2025 21:20:51 +0800
Message-ID: <20250417132054.2866409-1-wozizhi@huaweicloud.com>
X-Mailer: git-send-email 2.46.1
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgDXOl+KAgFoiwYGJw--.9194S4
X-Coremail-Antispam: 1UD129KBjvdXoWrKF4DAFy5Cw4DurW8XryDGFg_yoW3Jrc_XF
	Z7tFyrJw1UXa4rAFZ3GFn5uryjka1jgr18C3Z8KFW3Ary7J3W5Xr97t3yxWFsrZayI9FyD
	Jrn0qF1rAr1SqjkaLaAFLSUrUUUUbb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJTRUUUb4xFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k26cxKx2IYs7xG
	6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8w
	A2z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr1j
	6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oV
	Cq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0
	I7IYx2IY67AKxVWUGVWUXwAv7VC2z280aVAFwI0_Gr0_Cr1lOx8S6xCaFVCjc4AY6r1j6r
	4UM4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwCY1x0262kKe7AKxVWU
	AVWUtwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14
	v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_JF0_Jw1lIxkG
	c2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI
	0_Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r4j6F4U
	MIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x0JUvXd8UUU
	UU=
X-CM-SenderInfo: pzr2x6tkl6x35dzhxuhorxvhhfrp/

Changes since V1:
Modified patch 1 and 3 to make the changes more concise, without
introducing additional logic changes.

The patchset mainly address the update logic of tg->[bytes/io]_disp and add
related overflow checks. The last patch also simplified the process.

Zizhi Wo (3):
  blk-throttle: Fix wrong tg->[bytes/io]_disp update in
    __tg_update_carryover()
  blk-throttle: Delete unnecessary carryover-related fields from
    throtl_grp
  blk-throttle: Add an additional overflow check to the call
    calculate_bytes/io_allowed

 block/blk-throttle.c | 113 +++++++++++++++++++++++++++++++------------
 block/blk-throttle.h |  19 +++-----
 2 files changed, 90 insertions(+), 42 deletions(-)

-- 
2.46.1


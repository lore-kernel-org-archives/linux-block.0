Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F13579EA
	for <linux-block@vger.kernel.org>; Wed, 17 Apr 2024 02:29:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713320943; cv=none; b=GXC+jaEmEQO3didbHdoRLYFdawndsGbJsaLoMTCK6ok4JLkPFHtHlb2tB4DZUuz769uyZ+j2CrpwEFU5FZo7yMDfKzVng1GKyMai2DWoEeArLNRUjhhpyi3mitfXC58myhqW8HTEohJgJF5R9XU/Fw+oV9bT67tUhyRBkwRtbb0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713320943; c=relaxed/simple;
	bh=uCJmNF+zzfFl9wdCITH/ra6IF7WqP07wKKdnsanNEi0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=ENb0BeEmy2s0LZtYQWKuGKLrgAR1gIjCfQvARRosIgzrbYINWoCpsRbJlc/kfw5V0ZmY/Ce7KRhlzryMgGcGY+3tEIDxuhbIaAQLb3lLnczPXnFVRPyij4y+hWU45mDm6gt0oXg8c0tkVZcTxShVXTdRdXtW/zf9loUI9UN3mGs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.216])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4VK4bK2qq2z4f3jJ9
	for <linux-block@vger.kernel.org>; Wed, 17 Apr 2024 10:28:45 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
	by mail.maildlp.com (Postfix) with ESMTP id 8ECD91A0851
	for <linux-block@vger.kernel.org>; Wed, 17 Apr 2024 10:28:52 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.104.67])
	by APP1 (Coremail) with SMTP id cCh0CgBHGBHiMx9mtJvAKA--.38748S4;
	Wed, 17 Apr 2024 10:28:52 +0800 (CST)
From: Yu Kuai <yukuai1@huaweicloud.com>
To: saranyamohan@google.com,
	tj@kernel.org,
	axboe@kernel.dk
Cc: linux-block@vger.kernel.org,
	yukuai3@huawei.com,
	yukuai1@huaweicloud.com,
	yangerkun@huawei.com
Subject: [PATCH v2 blktests 0/5] add new tests for blk-throttle
Date: Wed, 17 Apr 2024 10:20:00 +0800
Message-Id: <20240417022005.1410525-1-yukuai1@huaweicloud.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:cCh0CgBHGBHiMx9mtJvAKA--.38748S4
X-Coremail-Antispam: 1UD129KBjvdXoW7WryUJFyruF1DCF13KF1kGrg_yoWkKFbE9r
	1vkryvkF48A3WUCFy0kF109rW5KrWxCF17tF15JF9xZrsIgF18XFn3tr1DurZrAF13Xr1a
	yw4DGrW8Ar13JjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJTRUUUbzkFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k26cxKx2IYs7xG
	6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8w
	A2z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr1j
	6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oV
	Cq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0
	I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r
	4UM4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwCF04k20xvY0x0EwIxG
	rwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4
	vE14v26r106r1rMI8E67AF67kF1VAFwI0_JF0_Jw1lIxkGc2Ij64vIr41lIxAIcVC0I7IY
	x2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Jr0_Gr1lIxAIcVCF04k26c
	xKx2IYs7xG6rWUJVWrZr1UMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7Cj
	xVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x0JUdHUDUUUUU=
X-CM-SenderInfo: 51xn3trlr6x35dzhxuhorxvhhfrp/

From: Yu Kuai <yukuai3@huawei.com>

changes in v2:
 - move lots of functions to rc

Yu Kuai (5):
  tests/throtl: add first test for blk-throttle
  tests/throtl: add a new test 002
  tests/throtl: add a new test 003
  tests/throtl: add a new test 004
  tests/throtl: add a new test 005

 tests/throtl/001     | 39 ++++++++++++++++++
 tests/throtl/001.out |  6 +++
 tests/throtl/002     | 30 ++++++++++++++
 tests/throtl/002.out |  4 ++
 tests/throtl/003     | 32 +++++++++++++++
 tests/throtl/003.out |  4 ++
 tests/throtl/004     | 37 +++++++++++++++++
 tests/throtl/004.out |  4 ++
 tests/throtl/005     | 37 +++++++++++++++++
 tests/throtl/005.out |  3 ++
 tests/throtl/rc      | 95 ++++++++++++++++++++++++++++++++++++++++++++
 11 files changed, 291 insertions(+)
 create mode 100755 tests/throtl/001
 create mode 100644 tests/throtl/001.out
 create mode 100755 tests/throtl/002
 create mode 100644 tests/throtl/002.out
 create mode 100755 tests/throtl/003
 create mode 100644 tests/throtl/003.out
 create mode 100755 tests/throtl/004
 create mode 100644 tests/throtl/004.out
 create mode 100755 tests/throtl/005
 create mode 100644 tests/throtl/005.out
 create mode 100644 tests/throtl/rc

-- 
2.39.2


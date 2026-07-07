Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BA9737DAA9;
	Tue,  7 Jul 2026 03:03:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783393410; cv=none; b=U0yuxE7SxrTsuG3taUJ0jcuS0Rr9FiNtbNf6EOBJ1u1ONDFonuJc9zr4SLxebIbQ0ke5mramqQse61T7k1/9mkZsbgo7XUkEtOnyW0whQsHJ3dqThQ6haIDEmVrf3mqqvoVeKP77y3iM0INQhdKhh6NaEATgJ97gLGfO35wcOm8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783393410; c=relaxed/simple;
	bh=FRwqfZg0/i+oZNFh4OTWXLDliYduZYWAhfUuEHrSTcE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=c6EtGRNkGU0ROC6re2az+tmhTTH5M7lqNMdw8G+ii40ctaq296xhmytH/MKQ9TxFunAdSdhinSS04JT9UgSBrqKZg++/8FMvUbJOUrXNu6nAKXkEq10zUQ4/zwbzsvRqBUQjY8e+cE3cqdr2JTE383Zv/eWgLBl4R/OVRFjkUPI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.198])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTPS id 4gvQyg2KzszKHMLC;
	Tue,  7 Jul 2026 11:03:07 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
	by mail.maildlp.com (Postfix) with ESMTP id 08D0440561;
	Tue,  7 Jul 2026 11:03:26 +0800 (CST)
Received: from huaweicloud.com (unknown [10.50.85.155])
	by APP1 (Coremail) with UTF8SMTPSA id cCh0CgA3SHR8bExq6ahUAQ--.61638S4;
	Tue, 07 Jul 2026 11:03:25 +0800 (CST)
From: Zizhi Wo <wozizhi@huaweicloud.com>
To: axboe@kernel.dk,
	dlemoal@kernel.org,
	nilay@linux.ibm.com,
	linux-block@vger.kernel.org,
	kch@nvidia.com,
	johannes.thumshirn@wdc.com,
	kbusch@kernel.org,
	bvanassche@acm.org
Cc: linux-kernel@vger.kernel.org,
	yangerkun@huawei.com,
	chengzhihao1@huawei.com,
	wozizhi@huawei.com
Subject: [PATCH V2 0/6] null_blk: fix init/exit races, leaks and cleanup
Date: Tue,  7 Jul 2026 10:55:36 +0800
Message-ID: <20260707025542.1299859-1-wozizhi@huaweicloud.com>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:cCh0CgA3SHR8bExq6ahUAQ--.61638S4
X-Coremail-Antispam: 1UD129KBjvJXoW7uw1fWw1rCr43Cr4rAw4xJFb_yoW8Gr4rpa
	yfWwnxKryUGr43Xr4ayw4fWr1rJa1rGrWUGr1fJw1fKFZ09ry0vrn2kF4rWFW5J397Jwsa
	qr1vvF95uFyDA37anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUvFb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Xr0_Ar1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVWxJr0_GcWl84ACjcxK6I8E87Iv6xkF7I
	0E14v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40E
	x7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x
	0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41lFIxGxcIEc7CjxVA2Y2ka0xkIwI1lc7CjxVAa
	w2AFwI0_Jw0_GFyl42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxV
	Aqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q
	6r43MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6x
	kF7I0E14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AK
	xVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvj
	xUF1v3UUUUU
X-CM-SenderInfo: pzr2x6tkl6x35dzhxuhorxvhhfrp/

This series fixes several issues in null_blk around lock initialization,
concurrent configfs access, and module init/exit cleanup.

Patches 1-2 fix the uninitialized mutex. Following Bart's suggestion, the
fix now uses DEFINE_MUTEX() and renames the lock.

Patch 3 fixes configfs registration concurrency.

Patch 4 reorders resource release in null_exit() to match null_init().

Patch 5 fixes a data race where the NULLB_DEVICE_ATTR macro locklessly
overwrote dev state already set under the lock by apply_fn().

Patch 6 fixes a global tag_set leak on the null_init() error path.

See the individual patch descriptions for details.

Changes since v1:
- Added patches 4-6, and modify the lock name in patch 2.
https://lore.kernel.org/all/20260706123507.3809871-1-wozizhi@huaweicloud.com/

Zizhi Wo (6):
  null_blk: use DEFINE_MUTEX for the file-scope mutex
  null_blk: give the file-scope mutex a descriptive name
  null_blk: register configfs subsystem after creating default devices
  null_blk: move unregister_blkdev() after destroying dev in null_exit()
  null_blk: don't locklessly overwrite dev state after apply_fn
  null_blk: free global tag_set on init error path

 drivers/block/null_blk/main.c | 70 +++++++++++++++++------------------
 1 file changed, 34 insertions(+), 36 deletions(-)

-- 
2.52.0


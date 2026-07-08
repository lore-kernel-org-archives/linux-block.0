Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88AA33A1A27;
	Wed,  8 Jul 2026 07:47:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783496843; cv=none; b=Rgq3TYpYp5rAhfULdiPuMstoioyINmwbfTDOZggvQ5jXZ1r2fwpC/eCaRXhINMDXQjeA3dXMmN2h5/zQv/NCfIjzHJdxUDHLE0Wd+L2+hoASgBbBK6gdxa/1GQeFW9OkG2/9gz0JlOjhmI0qYayh7MtRwC3iWiFg+l7Q3zTeet4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783496843; c=relaxed/simple;
	bh=Oc6zPEgDNut3riGtIVSc6wjyl2/Bu9yYiNUfsUyUSKU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=YMGdjqZBdUpGniC2JHfvqneFoL46Lf1Tu0AnCVx9bFgUeBa44hhAzzfulcRk42KZlpPVajefpfKuJqiBAm2zzX0d9IYuXXSoJTW3Lhr8JHgGzMCLNUgwvANogdn5aH2pMr0kmALVPeN+oRukgN0RH92l+dpT1EG8AZCeHbHM67g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=none smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.170])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTPS id 4gw9Cm6srMzYQtk4;
	Wed,  8 Jul 2026 15:47:00 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
	by mail.maildlp.com (Postfix) with ESMTP id 9FDB44056F;
	Wed,  8 Jul 2026 15:47:05 +0800 (CST)
Received: from huaweicloud.com (unknown [10.50.85.155])
	by APP1 (Coremail) with UTF8SMTPSA id cCh0CgCnt3N4AE5qQOTkAQ--.19577S4;
	Wed, 08 Jul 2026 15:47:05 +0800 (CST)
From: Zizhi Wo <wozizhi@huaweicloud.com>
To: axboe@kernel.dk,
	dlemoal@kernel.org,
	nilay@linux.ibm.com,
	kch@nvidia.com,
	johannes.thumshirn@wdc.com,
	kbusch@kernel.org,
	bvanassche@acm.org,
	linux-block@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	yangerkun@huawei.com,
	chengzhihao1@huawei.com,
	wozizhi@huawei.com
Subject: [PATCH V3 0/6] null_blk: fix init/exit races and memleaks
Date: Wed,  8 Jul 2026 15:39:11 +0800
Message-ID: <20260708073917.2172392-1-wozizhi@huaweicloud.com>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:cCh0CgCnt3N4AE5qQOTkAQ--.19577S4
X-Coremail-Antispam: 1UD129KBjvJXoW7uw1xKF4fGw43Aw1UtrWfGrg_yoW8Zry8pa
	yYgw4rKr1UGr17XwsrAw4xuFyru3WrGFW7Gr13tw1FyFZ09FySvrn7KF4rZFy7J393Kwna
	qa1vvFyrZryDZaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUvFb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Gr0_Xr1l84ACjcxK6xIIjxv20xvEc7Cj
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
concurrent configfs access, and module init/exit.

Patch 1 fixes the uninitialized mutex. Following Bart's suggestion, the
fix now uses DEFINE_MUTEX(). This series no longer renames the lock;
following Damien Le Moal's suggestion, the rename and locking rework will
be sent as a separate series.

Patch 2 fixes configfs registration concurrency.

Patch 3 reorders resource release in null_exit() to match null_init().

Patch 4 fixes a global tag_set leak on the null_init() error path.

Patch 5 fixes a mid-setup race where a store changes a field before
CONFIGURED is set, causing out-of-bounds dev->zones[] access

Patch 6 adds READ_ONCE()/WRITE_ONCE() to the configfs attribute
reads/writes that race with each other.

Changes since v2:
- Dropped the lock rename patch; the rename and locking rework will be
  sent as a separate series (per Damien's suggestion).
- Patch 3: fixed the tense in the commit message.
- Patch 5: Mofify the lock position in v2 patch 4 to fix a mid-setup race.
- Added new patch 6.
https://lore.kernel.org/all/20260707025542.1299859-1-wozizhi@huaweicloud.com/

Changes since v1:
- Added patches 4-6, and modify the lock name in patch 2.
https://lore.kernel.org/all/20260706123507.3809871-1-wozizhi@huaweicloud.com/

Zizhi Wo (6):
  null_blk: use DEFINE_MUTEX for the file-scope mutex
  null_blk: register configfs subsystem after creating default devices
  null_blk: move unregister_blkdev() after destroying dev in null_exit()
  null_blk: free global tag_set on init error path
  null_blk: serialize configfs attribute stores with device setup
  null_blk: mark racy configfs attribute accesses with
    READ_ONCE/WRITE_ONCE

 drivers/block/null_blk/main.c  | 92 +++++++++++++++-------------------
 drivers/block/null_blk/zoned.c | 18 +++----
 2 files changed, 49 insertions(+), 61 deletions(-)

-- 
2.52.0


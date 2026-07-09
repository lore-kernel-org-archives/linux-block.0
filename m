Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE975410D13;
	Thu,  9 Jul 2026 10:12:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783591975; cv=none; b=hBtuCgSZ6dTyUpxrnKuaxlQ1z37EPRMAiLz7XOqQIq4Z3ttZyG3Yx+SoeObH3d1yLQCrBQyNrXXJIjCLltXuwhxexWRp5oGwGs9/BvM87vVZ2Gxfpx8rX770uprFPVJ3UiJ8l3UVPbnJ7cQp97YAZXP5quzwo86M6V41w5DCDiI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783591975; c=relaxed/simple;
	bh=POiq8km4FbYHP6DYY6ZDQYyGt8XS3P+ClFeCFoaVjpg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Iw7CZINoRLktWTUvIt/CzKHAOQcnaP0ngEzkK32GCUcAcB6kHo9O0k/QByUD0y7DYSsOj5e43c9Rf1kpKkBKAHqp6Mt1MyFNLq5EFSpmJMdgH2YAHcopxQ5Dlb55MuiJy1/AsYINr+RUtM3KVr9G+SG1xTZ0RxjplCWj9bMmdWs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.198])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTPS id 4gwrPK2McGzYQtxx;
	Thu,  9 Jul 2026 18:12:37 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
	by mail.maildlp.com (Postfix) with ESMTP id DDCCC4070E;
	Thu,  9 Jul 2026 18:12:43 +0800 (CST)
Received: from huaweicloud.com (unknown [10.50.85.155])
	by APP1 (Coremail) with UTF8SMTPSA id cCh0CgBHV3MadE9qn4RpAg--.38318S4;
	Thu, 09 Jul 2026 18:12:43 +0800 (CST)
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
Subject: [PATCH V4 0/9] null_blk: fix init/exit races and memleaks
Date: Thu,  9 Jul 2026 18:04:42 +0800
Message-ID: <20260709100452.3520482-1-wozizhi@huaweicloud.com>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:cCh0CgBHV3MadE9qn4RpAg--.38318S4
X-Coremail-Antispam: 1UD129KBjvJXoW7Ww4rWr48JFy7Kw1rtF47Jwb_yoW8tw1fpa
	yYgw15Gr4DKr17XwsrCa1fWFyrZ3Z5G3y5KFnxJw1rCFWY9ryIvr97Kr45XFW7J393GrZI
	ganrZr95ua4jva7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
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

From: Zizhi Wo <wozizhi@huawei.com>

This series fixes several issues in null_blk around lock initialization,
memory leaks, concurrent configfs access, and module init/exit.

Patches 1-4 are unchanged from v3.
Patch 5 fixes another memory leak of the zones array, and patch 6 is a
related cleanup.
Patch 7 fixes a NULL-ptr-deref of hctx when shrinking submit_queues on a
device that shares the global tag_set.
Patch 8 fixes a data race, similar to patch 5 in v3, but adjusts the
return value handling.
Patch 9 serializes configfs attribute shows to close the remaining
show-vs-write races.

See the individual patch descriptions for details.

Changes since v3:
- Added patch 5 (zones array memleak) and patch 6 (cleanup).
- Added patch 7 (NULL-ptr-deref on shared tag_set queue shrink).
- Patch 9: reworked the fix from v3's patch 6 to take the file-scope
  lock in _store instead of scattering READ_ONCE/WRITE_ONCE.
https://lore.kernel.org/all/20260708073917.2172392-1-wozizhi@huaweicloud.com/

Changes since v2:
- Dropped the lock rename patch; the rename and locking rework will be
  sent as a separate series (per Damien's suggestion).
- Patch 3: fixed the tense in the commit message.
- Patch 4: also update dev->NAME in the "!dev->nullb" path, which was
  previously lost.
https://lore.kernel.org/all/20260707025542.1299859-1-wozizhi@huaweicloud.com/

Changes since v1:
- Added patches 4-6, and modify the lock name in patch 2.
https://lore.kernel.org/all/20260706123507.3809871-1-wozizhi@huaweicloud.com/

Zizhi Wo (9):
  null_blk: use DEFINE_MUTEX for the file-scope mutex
  null_blk: register configfs subsystem after creating default devices
  null_blk: move unregister_blkdev() after destroying dev in null_exit()
  null_blk: free global tag_set on init error path
  null_blk: free zones array on device power-off
  null_blk: clean up null_del_dev() to use cached dev pointer
  null_blk: reject per-device queue resize for shared tag set
  null_blk: serialize configfs attribute stores with device setup
  null_blk: serialize configfs attribute shows with the file-scope lock

 drivers/block/null_blk/main.c | 79 +++++++++++++++++++----------------
 1 file changed, 44 insertions(+), 35 deletions(-)

-- 
2.52.0


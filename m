Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56A622D5C68;
	Tue, 14 Jul 2026 04:26:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784003180; cv=none; b=GkkEuOcUVzcL2TkOzJeBhP/VZ2Cx/mRFwothJQuCVuLqcKZaAKDAFzvw2sXIx/Uh2Xr+ebSN5sM6Kja7Wszw2owFL0iy4Q1GuhP7h62qi4kXoGsaCaiKk7XmmcusljbQqDh89xqPG8fFv4KlcKhxFdbjY3dZ3a+sNphAr/aO26U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784003180; c=relaxed/simple;
	bh=LzMY2pS3w70kq/Nhe09NESbJ4v/VAt0OWEvYsqLNfeU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=YKwYGBKwyuUyx4VU5//86lhBbes0XhkG8k/OVHt4u0W43dd1aWmwzJespGrM3lp8mlDB4GMnFix2vSAYxFLfTP6TLMFMw09e8pey5FZ3Zgcg9rk0h9Yll7dRxlTI/99/Nas1LNedSN3hKLmkSzGyPgrUagIFvFYJTN1Vt5a2vL4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=none smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.177])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTPS id 4gzmT305sjzYQtLZ;
	Tue, 14 Jul 2026 12:25:59 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
	by mail.maildlp.com (Postfix) with ESMTP id B5A5E4058F;
	Tue, 14 Jul 2026 12:26:13 +0800 (CST)
Received: from huaweicloud.com (unknown [10.50.85.155])
	by APP1 (Coremail) with UTF8SMTPSA id cCh0CgBHWHRkulVq2zKnBA--.54416S4;
	Tue, 14 Jul 2026 12:26:13 +0800 (CST)
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
Subject: [PATCH V5 0/9] null_blk: fix init/exit races and memleaks
Date: Tue, 14 Jul 2026 12:17:56 +0800
Message-ID: <20260714041805.1088702-1-wozizhi@huaweicloud.com>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:cCh0CgBHWHRkulVq2zKnBA--.54416S4
X-Coremail-Antispam: 1UD129KBjvJXoW7Ww4rWr43tr1furW5CF13CFg_yoW8uFW3p3
	yYgw15Gr4DKr17JwsFya13uFyYqws5G3yUKF9rJw1fCFWY9Fy0yrs7KF45XFyUJ393GrZI
	qanFvr9ava4qv37anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUvIb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Jr0_JF4l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Cr0_Gr1UM28EF7xvwVC2z280aVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIEc7
	CjxVAFwI0_GcCE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8C
	rVC2j2WlYx0E2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4
	IE7xkEbVWUJVW8JwACjcxG0xvY0x0EwIxGrwACI402YVCY1x02628vn2kIc2xKxwCY1x02
	62kKe7AKxVWUtVW8ZwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s
	026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_
	Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20x
	vEc7CjxVAFwI0_Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE
	14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf
	9x07UAwIDUUUUU=
X-CM-SenderInfo: pzr2x6tkl6x35dzhxuhorxvhhfrp/

From: Zizhi Wo <wozizhi@huawei.com>

This series fixes several issues in null_blk around lock initialization,
memory leaks, concurrent configfs access, and module init/exit.

No functional changes to patches 1-4, 6, and 8-9.

See the individual patch descriptions for details.

Changes since v4:
- Modified patch 5 to fix the check-and-deref race on dev->zones in
  zone_cond_store().
- Simplified the fix in patch 7.
https://lore.kernel.org/all/20260709100452.3520482-1-wozizhi@huaweicloud.com/

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

 drivers/block/null_blk/main.c | 93 +++++++++++++++++++++--------------
 1 file changed, 56 insertions(+), 37 deletions(-)

-- 
2.52.0


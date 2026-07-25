Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 202D334404B
	for <linux-block@vger.kernel.org>; Sat, 25 Jul 2026 02:33:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784946844; cv=none; b=ek2FBD/o58D1bYmvFw4t7OC96F6zkm0eah9MlvqeaG95tj35pOFO8/OSH6Ti5neqhy5RiEFae03/Q/GXcFu7WqojrRDsYQsGC63NRBm0AQSktSo8EZm8Ph80BuSnXbXigI+5mtEjKmEgAnzcIaCZAkWn6MIEq85v8PFMdk2bBGQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784946844; c=relaxed/simple;
	bh=17nBPiVM1wMvOb/LdScLEadfpyg83tKIFZLEuQKeqog=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=R6eVopxU5jh5gqIORhlNUKTLo8KNbY/HnE4s179bRqmqKYNDsLkv6ylkJuTjOEbfYlTlcRw96ae/vTPQh3vO918730/l34z2XcovDPBw3LHeSouIS5Cs34QN6ubaAsarlc3bYWutRtWYHIsqtUImeX7vNpMYdNecRDeZyPVSuDI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.198])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTPS id 4h6TRl6wdXzKHMWb
	for <linux-block@vger.kernel.org>; Sat, 25 Jul 2026 10:33:07 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
	by mail.maildlp.com (Postfix) with ESMTP id D16124081F
	for <linux-block@vger.kernel.org>; Sat, 25 Jul 2026 10:33:55 +0800 (CST)
Received: from huaweicloud.com (unknown [10.50.85.155])
	by APP1 (Coremail) with UTF8SMTPSA id cCh0CgA3SHSSIGRqCkPTCQ--.40042S4;
	Sat, 25 Jul 2026 10:33:55 +0800 (CST)
From: Zizhi Wo <wozizhi@huaweicloud.com>
To: axboe@kernel.dk,
	dlemoal@kernel.org,
	nilay@linux.ibm.com,
	bvanassche@acm.org,
	yukuai@fygo.io,
	kch@nvidia.com,
	johannes.thumshirn@wdc.com,
	kbusch@kernel.org,
	linux-block@vger.kernel.org
Cc: yangerkun@huawei.com,
	chengzhihao1@huawei.com,
	wozizhi@huawei.com
Subject: [PATCH V6 00/10] null_blk: fix init/exit races and memleaks
Date: Sat, 25 Jul 2026 10:24:59 +0800
Message-ID: <20260725022509.714271-1-wozizhi@huaweicloud.com>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:cCh0CgA3SHSSIGRqCkPTCQ--.40042S4
X-Coremail-Antispam: 1UD129KBjvJXoW7Ww4rWr45ZryfAr1rJFykAFb_yoW8KFyrp3
	yYgw13Wr4DKr17XrsFka17ua4Fqwn5G3yjgFnrJw1rCFWY9F10vrs2kr45XFyUJ393W39I
	qFsrZr9ava4qv37anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUv2b4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Jr0_JF4l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVCY1x
	0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
	6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFV
	Cjc4AY6r1j6r4UM4x0Y48IcxkI7VAKI48JM4IIrI8v6xkF7I0E8cxan2IY04v7MxkF7I0E
	n4kS14v26r1q6r43MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I
	0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWU
	tVW8ZwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcV
	CY1x0267AKxVW8JVWxJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAF
	wI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa
	7IU17KsUUUUUU==
X-CM-SenderInfo: pzr2x6tkl6x35dzhxuhorxvhhfrp/

From: Zizhi Wo <wozizhi@huawei.com>

This series fixes several issues in null_blk around lock initialization,
memory leaks, concurrent configfs access, and module init/exit.

See the individual patch descriptions for details.

Changes since v5:
- Add a new patch converting the file-scope mutex users to gaurd(mutex).
- Simplify the last two patches accordingly.
https://lore.kernel.org/all/20260714041805.1088702-1-wozizhi@huaweicloud.com/

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


Zizhi Wo (10):
  null_blk: use DEFINE_MUTEX for the file-scope mutex
  null_blk: register configfs subsystem after creating default devices
  null_blk: move unregister_blkdev() after destroying dev in null_exit()
  null_blk: free global tag_set on init error path
  null_blk: free zones array on device power-off
  null_blk: clean up null_del_dev() to use cached dev pointer
  null_blk: reject per-device queue resize for shared tag set
  null_blk: convert file-scope mutex users to guard(mutex)
  null_blk: serialize configfs attribute stores with the lock
  null_blk: serialize configfs attribute shows with the lock

 drivers/block/null_blk/main.c | 92 ++++++++++++++++-------------------
 1 file changed, 43 insertions(+), 49 deletions(-)

-- 
2.52.0


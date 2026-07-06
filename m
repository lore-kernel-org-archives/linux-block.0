Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95195424645;
	Mon,  6 Jul 2026 12:42:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783341775; cv=none; b=FSUoAJt+2XdWFiKs28eytak4Q/RdtU8B7qDtJixBjOlr9JGhoeFAriVSk7g9Elcy/FRCxTLuv6gIDdTwS1GZMz5zAjwh/Fi5TuKWdcw48v7pfMi2txywROlzwBMC6bOuaYDzByS0Hd5kgWQK7BYSPKeKIz7mN3Jkm9OKuOpXsv4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783341775; c=relaxed/simple;
	bh=Oqmrr2oAr6HVVBi43hJJniaq4v8uhG3SEeXUDaU8EpQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=D5uCF9pQ94/AlPFeJUuyekRn/cxHOrNhn5u0GrTFB/tiZbqQHrsTNjsbCUYkHd0PM/QLMmCX1VxazljqXOec5yfLdv0ZuQR3b9KTOmY0iCzpSfYKx1MiATFcdrEQJWoeh9UpdFopr93WF6WS5+56ySgOO3D2AHiuz5m1u3humFo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.198])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTPS id 4gv3sz75hpzYQtqg;
	Mon,  6 Jul 2026 20:42:47 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
	by mail.maildlp.com (Postfix) with ESMTP id 9469F40583;
	Mon,  6 Jul 2026 20:42:49 +0800 (CST)
Received: from huaweicloud.com (unknown [10.50.85.155])
	by APP1 (Coremail) with UTF8SMTPSA id cCh0CgCnt3PIoktqeukMAQ--.50096S4;
	Mon, 06 Jul 2026 20:42:49 +0800 (CST)
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
Subject: [PATCH 0/3] null_blk: fix mutex initialization and configfs teardown race
Date: Mon,  6 Jul 2026 20:35:04 +0800
Message-ID: <20260706123507.3809871-1-wozizhi@huaweicloud.com>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:cCh0CgCnt3PIoktqeukMAQ--.50096S4
X-Coremail-Antispam: 1UD129KBjvdXoW7JF4UuF18Xw18Zr4rKF18uFg_yoWfGwcE9F
	WrtFy8Ja1kWF15GFW7tF4rAryjkr4j9rn5JF1UtrZ3u3s3XrsxJ3Z7GrWrZr1UW3W7G3Z8
	tFs3ZrWxZwnrtjkaLaAFLSUrUUUUbb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJTRUUUbI8YFVCjjxCrM7AC8VAFwI0_Gr0_Xr1l1xkIjI8I6I8E6xAIw20E
	Y4v20xvaj40_Wr0E3s1l1IIY67AEw4v_Jr0_Jr4l8cAvFVAK0II2c7xJM28CjxkF64kEwV
	A0rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVW8JVW5JwA2z4x0Y4vE2Ix0cI8IcVCY1x02
	67AKxVWxJVW8Jr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxV
	AFwI0_GcCE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2
	j2WlYx0E2Ix0cI8IcVAFwI0_JrI_JrylYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7x
	kEbVWUJVW8JwACjcxG0xvY0x0EwIxGrwACI402YVCY1x02628vn2kIc2xKxwCY1x0262kK
	e7AKxVW8ZVWrXwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c
	02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_
	GFylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7
	CjxVAFwI0_Cr0_Gr1UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AK
	xVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvj
	xU4NB_UUUUU
X-CM-SenderInfo: pzr2x6tkl6x35dzhxuhorxvhhfrp/

This series fixes a few simple issues in null_blk.

Patches 1-2 fix a problem where the null_blk mutex was left uninitialized.
The fix for the first issue was originally sent as a separate patch[1].
Following Bart's suggestion, it now use DEFINE_MUTEX() and the lock has
been renamed to a more descriptive name.

Patch 3 fixes concurrency issues around configfs registration.

See the individual patch descriptions for details.

[1] https://lore.kernel.org/all/20260704092323.748772-1-wozizhi@huaweicloud.com/

Zizhi Wo (3):
  null_blk: use DEFINE_MUTEX for the file-scope mutex
  null_blk: give the file-scope mutex a descriptive name
  null_blk: register configfs subsystem after creating default devices

 drivers/block/null_blk/main.c | 50 +++++++++++++++--------------------
 1 file changed, 22 insertions(+), 28 deletions(-)

-- 
2.52.0


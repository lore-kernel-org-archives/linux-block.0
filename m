Received: from out-171.mta1.migadu.com (out-171.mta1.migadu.com [95.215.58.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33FC646450
	for <linux-block@vger.kernel.org>; Sat, 24 Feb 2024 13:46:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708782417; cv=none; b=ioskqB3XwZsQEIxQlRJN5uX4d9hZP+kjZPuQUU55SwOJ2xZDuPbC+cOyBKr6cxT35xn228FrW+eX/9quz92RGOAnmvMAQloxc+XVP9OoAeU8evfDaPE7/sgx/RPOfF+kO1LB5uxtTbTPo/sp/rhG6cVh2HVCiSL7m7wBE48CZrA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708782417; c=relaxed/simple;
	bh=9o4ItFnQkF0G7rDEIpOqVgLxMM11vE0VMqUAksQdmYQ=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=lV/85o3xaaA+CLrF+yui6lXGW8ALABS7IjroBXazdHyfnL0DTUTv7NKg+SrMZfOa60WdW/NtF8FjWZu4Dsgyw4eN3DPoIaSZ8f4GKJANLj4BSmQEPuGhDDLg+H3LLai1H5gswHzy4jjk6bS7WedycMGT8mr0ApTVeD8x951m5w8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=C5GnozRH; arc=none smtp.client-ip=95.215.58.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="C5GnozRH"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1708782414;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=R0N4mdAY/CNTfeRGszBe8GaA+/sz2rbWH4NYR0SsEuE=;
	b=C5GnozRHe5XmCcqz5SvmjsgVf95ZmodYUD55amGF7DYdFB9Zsh2x83jKl3IYFdrq6eAd1K
	LR44recvXsKiIeglG/WvxXD75EdIkkWfVRotkbmlvsxySTdHWtV/DGddSqccftOdBYbeov
	UwVn123fC8GgnPcN8kaU5x53CHHQRtk=
From: chengming.zhou@linux.dev
To: axboe@kernel.dk
Cc: linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	vbabka@suse.cz,
	roman.gushchin@linux.dev,
	Xiongwei.Song@windriver.com,
	chengming.zhou@linux.dev,
	Chengming Zhou <zhouchengming@bytedance.com>
Subject: [PATCH] bdev: remove SLAB_MEM_SPREAD flag usage
Date: Sat, 24 Feb 2024 13:46:46 +0000
Message-Id: <20240224134646.829105-1-chengming.zhou@linux.dev>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

From: Chengming Zhou <zhouchengming@bytedance.com>

The SLAB_MEM_SPREAD flag is already a no-op as of 6.8-rc1, remove
its usage so we can delete it from slab. No functional change.

Signed-off-by: Chengming Zhou <zhouchengming@bytedance.com>
---
 block/bdev.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/block/bdev.c b/block/bdev.c
index 140093c99bdc..e7adaaf1c219 100644
--- a/block/bdev.c
+++ b/block/bdev.c
@@ -383,7 +383,7 @@ void __init bdev_cache_init(void)
 
 	bdev_cachep = kmem_cache_create("bdev_cache", sizeof(struct bdev_inode),
 			0, (SLAB_HWCACHE_ALIGN|SLAB_RECLAIM_ACCOUNT|
-				SLAB_MEM_SPREAD|SLAB_ACCOUNT|SLAB_PANIC),
+				SLAB_ACCOUNT|SLAB_PANIC),
 			init_once);
 	err = register_filesystem(&bd_type);
 	if (err)
-- 
2.40.1


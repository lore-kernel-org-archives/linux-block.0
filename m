Received: from m16.mail.126.com (m16.mail.126.com [117.135.210.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D271424E4BD;
	Fri, 15 Aug 2025 09:08:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755248941; cv=none; b=cFXCa/jF7d0UpP8Tx2BfqU6YqnZnDcZurG1I4cZq8O0c2Gpme94wXZ3Phr5of51q/kC2xbM0mYcqKq2/PscxMy41b7l7m/4WcdbXQ8t1H4CWZmLsaJiC4fNW4kaK0QWOmoHhqusmSKTQqsNeMlqv1x1FdiPoZT5I0PzojlcQBY0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755248941; c=relaxed/simple;
	bh=Ib0rLmgRr75p5p+Us9QCh6/Rw0bcD0RjRsjyrx2Zh+Q=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=a5oohIU7n0oMM4+CL65TMuICopEhBkoOIlsVobDuXsbpuuwuP+b5nLnP6nRN51OVSWLdwDyhcMWdaK80GlF5V+J7oTiUrCa4tC9wpDRDJxtJppsJkh0u89IxOLx88Me9TKx7H/SNk4gnAne0IE5+pOVvLIthQgihKopgOKOG4LI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=126.com; spf=pass smtp.mailfrom=126.com; dkim=pass (1024-bit key) header.d=126.com header.i=@126.com header.b=XeJrVWWw; arc=none smtp.client-ip=117.135.210.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=126.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=126.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=126.com header.i=@126.com header.b="XeJrVWWw"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=126.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=ny
	5ii1rw2MF2Sep0fJUZ8uqET0SiKpLe8TvBVtoY/us=; b=XeJrVWWwdJqMuZIGV+
	Ladviyyc1vu0WFBgyqP2hrVfXpmjKkn2rQwwyd6bCS9tzphU35+rCDJNyFryLnie
	7tw2CdsobzcaR+uPfWL4nX2InZuA0npIEpox++Wwqr4B3n5N56Ksnjicm29AvIPD
	tFsn9+4cFJM2XTDR4UejsAt3o=
Received: from localhost.localdomain (unknown [])
	by gzga-smtp-mtada-g1-3 (Coremail) with SMTP id _____wD3r1La+J5own4VCA--.56213S4;
	Fri, 15 Aug 2025 17:07:57 +0800 (CST)
From: Genjian <zhanggenjian@126.com>
To: axboe@kernel.dk,
	dlemoal@kernel.org,
	shinichiro.kawasaki@wdc.com,
	johannes.thumshirn@wdc.com,
	kch@nvidia.com,
	zhengqixing@huawei.com,
	willy@infradead.org,
	namcao@linutronix.de,
	vincent.fu@samsung.com
Cc: linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	zhanggenjian@126.com,
	Genjian Zhang <zhanggenjian@kylinos.cn>
Subject: [PATCH v2] null_blk: Fix the description of the cache_size module argument
Date: Fri, 15 Aug 2025 17:07:32 +0800
Message-Id: <20250815090732.1813343-1-zhanggenjian@126.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wD3r1La+J5own4VCA--.56213S4
X-Coremail-Antispam: 1Uf129KBjvJXoW7ZFyUury7GFyrWrWrJw1kXwb_yoW8WryUpr
	ZrAF18JrW29F109a1DGws3ZFy5Ja48JFWYg3yak34Yvr4fXryxAwnrtas8urWUJ347Ar4f
	ZF9rXasagFyDCaUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0zEf-P5UUUUU=
X-CM-SenderInfo: x2kd0wxjhqyxldq6ij2wof0z/1tbi5Qqqfmie920V5gAAsk

From: Genjian Zhang <zhanggenjian@kylinos.cn>

When executing modinfo null_blk, there is an error in the description
of module parameter mbps, and the output information of cache_size is
incomplete.The output of modinfo before and after applying this patch
is as follows:

Before:
[...]
parm:           cache_size:ulong
[...]
parm:           mbps:Cache size in MiB for memory-backed device.
		Default: 0 (none) (uint)
[...]

After:
[...]
parm:           cache_size:Cache size in MiB for memory-backed device.
		Default: 0 (none) (ulong)
[...]
parm:           mbps:Limit maximum bandwidth (in MiB/s).
		Default: 0 (no limit) (uint)
[...]

Fixes: 058efe000b31 ("null_blk: add module parameters for 4 options")
Signed-off-by: Genjian Zhang <zhanggenjian@kylinos.cn>
Reviewed-by: Damien Le Moal <dlemoal@kernel.org>
---
 drivers/block/null_blk/main.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/block/null_blk/main.c b/drivers/block/null_blk/main.c
index 91642c9a3b29..f982027e8c85 100644
--- a/drivers/block/null_blk/main.c
+++ b/drivers/block/null_blk/main.c
@@ -223,7 +223,7 @@ MODULE_PARM_DESC(discard, "Support discard operations (requires memory-backed nu
 
 static unsigned long g_cache_size;
 module_param_named(cache_size, g_cache_size, ulong, 0444);
-MODULE_PARM_DESC(mbps, "Cache size in MiB for memory-backed device. Default: 0 (none)");
+MODULE_PARM_DESC(cache_size, "Cache size in MiB for memory-backed device. Default: 0 (none)");
 
 static bool g_fua = true;
 module_param_named(fua, g_fua, bool, 0444);
-- 
2.25.1


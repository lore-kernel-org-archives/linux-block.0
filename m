Received: from m16.mail.126.com (m16.mail.126.com [117.135.210.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59B74184E;
	Fri, 15 Aug 2025 04:32:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.6
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755232383; cv=none; b=Wbm9k4xzX3CodBUDAoRBEsoRrqRSZKFjWJy6LHqCYwSr8hLsvNyZ2gS/rNfVsnMW8WegCFh49kQCAHz18HW/jAVrLTFsRfOV8e97/4CKMn47Mac+3JyHnss/uuiqD4+Wjh8PKHlnqy4Kiu7nj74YkP9iuqLCiqNuDUPsm4j3uBk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755232383; c=relaxed/simple;
	bh=q7UvJdsMzjG/34LxSKbYRnNhNGY0pN9Ki6l0mvw8PVg=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=XeIECQyPOg6T9g3MC2IwZAgbA1qbWdU3bt44LDaeOE1/7/COdjq4LlVVJT55fCd7497DiRgtUAnDH5cIjW9Vfo2Cby3rptCQbA/KBMhvN3P6SH1Hzw+blO6MJPJ47LLfF18kGNzFJBRK8YSUP0sz6b34kyj7aUOidCHkjyfLmPg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=126.com; spf=pass smtp.mailfrom=126.com; dkim=pass (1024-bit key) header.d=126.com header.i=@126.com header.b=SzorFoQt; arc=none smtp.client-ip=117.135.210.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=126.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=126.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=126.com header.i=@126.com header.b="SzorFoQt"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=126.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=93
	VcQzgpbl4Du+IaucieEQcX0w+7qtFnVJnT8ClmGfs=; b=SzorFoQtRXu99q8ZgR
	iLhduDDEX0+0nZcQo7pAGpfsiRNGwG0HrhEy/FWN+ffI3N04O75yy2sd8zdBzd95
	NVLYBpzVBfmbPBq6PFJS+D/krr/WhVNLEBGjSfVvSJ5vdrqcaA450azhWv5gFWVA
	jheqXvDbP20elgizXLrk1zXAU=
Received: from localhost.localdomain (unknown [])
	by gzga-smtp-mtada-g1-0 (Coremail) with SMTP id _____wD3L4b3t55oIiHABQ--.58302S4;
	Fri, 15 Aug 2025 12:30:59 +0800 (CST)
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
Subject: [PATCH] null_blk: Fix correct parameter desc for the module
Date: Fri, 15 Aug 2025 12:30:33 +0800
Message-Id: <20250815043033.1534949-1-zhanggenjian@126.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wD3L4b3t55oIiHABQ--.58302S4
X-Coremail-Antispam: 1Uf129KBjvJXoW7ZFyUury7GFyrWrWrJw1kXwb_yoW8XFW3pr
	ZrAF18JrZF9F109a1DGws3XFy5Ja48GFZ0g3yak34Yvr4fXryxA3Zrtas8urWUK3y7Ar4f
	ZF93Xas3WFykCaUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0zib18dUUUUU=
X-CM-SenderInfo: x2kd0wxjhqyxldq6ij2wof0z/1tbi5RKqfmieqIGbfAABsa

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


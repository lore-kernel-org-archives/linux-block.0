Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAA4421767D;
	Tue,  4 Aug 2026 06:59:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785826798; cv=none; b=OJLelUGNHckWt8SUMQZbhHGmrzfVuWEYL3SkiR+1fadPlCvtf+K3FgyECdYGnVpKS6Z4tltpyjdkUqR3DHbfauybijUpCcWLBN7iQtMJLJ5aEs+P72eI0z8OF5sOdir6kjGm7WeLBITPoLi8voCD+qIYDxvAJT4Src06yx8Bgws=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785826798; c=relaxed/simple;
	bh=kbHP2i7vkemjR3HAVVxYVnyyHvZfDBdyyg6SWgyZEy8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Jqcfn53NEo3Zi3l3q8c+l1pfJncV0pkGyoYctqSP84kn7es+ljltMVu4TDp3bpZGlPIZJXkPYbIe1NbZV/tNkUt3kbBBrCAIkMqKA3KaEqh/aDaspCKOqPSoUM4RVefXsIw5tXEjlouRPhDyg04hYVw0cnIdavsjKVXE/IKu7Xg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=lbPbMecm; arc=none smtp.client-ip=117.135.210.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="lbPbMecm"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=rl
	ts6FRGWQPc7PzhKhKXPEyH/qtfVTl1BIuIlpqm3Rg=; b=lbPbMecmmO4u/IvnZC
	Gg27JqY9gfJYd69P/d9j1nptLin7C0dOlenPvjT3cgxs0VCPQiVnUiMOUe04zrf8
	2DGAMXr33IBBfFwdHF2psd8bCWo+Old+WUXG3vYJTOQPPf6M0VvlAYuXSQm4z3Dx
	IDATEDDtHkprpzoUl/2m6W4uU=
Received: from XLL-9950X.localdomain (unknown [])
	by gzga-smtp-mtada-g0-3 (Coremail) with SMTP id _____wAnD2LOjXFqfGujNQ--.47278S2;
	Tue, 04 Aug 2026 14:59:26 +0800 (CST)
From: Longlong Xia <xialonglong2025@163.com>
To: Minchan Kim <minchan@kernel.org>,
	Sergey Senozhatsky <senozhatsky@chromium.org>
Cc: Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Longlong Xia <xialonglong@kylinos.cn>
Subject: [PATCH 0/2] zram: fix stale scan bounds after reinitialization
Date: Tue,  4 Aug 2026 14:59:17 +0800
Message-ID: <20260804065919.3970386-1-xialonglong2025@163.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wAnD2LOjXFqfGujNQ--.47278S2
X-Coremail-Antispam: 1Uf129KBjvdXoWrtFWxtw4UJr1fXw1DGw17Wrg_yoWDKrX_ua
	s2qr97Ga18KFZIyF1fJFn8AryIkr4j9345Zrn8AF9xX3yxX34kZFyDWrnYvF1kGa9xuFyf
	Cr90va1Ykwn7ujkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUvcSsGvfC2KfnxnUUI43ZEXa7IU8SdgJUUUUU==
X-CM-SenderInfo: x0ldz0pqjo00rjsqjki6rwjhhfrp/xtbC3A6Nhmpxjc4q8wAA3Y

From: Longlong Xia <xialonglong@kylinos.cn>

Both writeback_store() and read_block_state() derive their table scan
bounds from zram->disksize before acquiring dev_lock. If the device is
reset and reinitialized with a smaller disksize between that read and lock
acquisition, the bound can describe the old table while the scan operates
on the new one. This can lead to out-of-bounds slot accesses.

Move both bound calculations under dev_lock so each bound remains
consistent with the table throughout its scan. Keep the fixes separate
because the affected interfaces originate from different commits and can
be backported independently.

The series has been checked with:

  scripts/checkpatch.pl --strict <patches>
  make M=drivers/block/zram modules

Longlong Xia (2):
  zram: fix out-of-bounds access in writeback_store()
  zram: fix out-of-bounds access in read_block_state()

 drivers/block/zram/zram_drv.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)


base-commit: 848acc8ffe1b7cd5f1bf427b93069becfebc2c9d
-- 
2.43.0


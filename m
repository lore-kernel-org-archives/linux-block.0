Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1074735F60E;
	Fri, 21 Aug 2026 10:31:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.2
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787308287; cv=none; b=h2fkcQvNqh6wuRAYKYRoaCJCRvLrsfNc2M8Ohig6RhEpFwiu57z/6oZptMLMThbZMMJyuk0/Yxf1UA+4QMngOORMbZyn0W4rst5z1SVVmNShzbYpKdrUlOolTruw4o3p7tfW0x+HvWVfyK0CwFN+1URJilTdu3EIRz2TkDhQpow=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787308287; c=relaxed/simple;
	bh=27SVYE6P/q1hDpbqA0C5cJAMx7EfYIZDzdtvlQXuBns=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=EnXypA5LkqH8RgcJRRcGdq9EZaOOWJU1JzVGBKpPo4LOU51axW94mbaWVx6EvLe9MuKBrnBwnnzNp0VC6R1u7CYzgl6FmU5h1ne6EthWL0RMYjnaUEiN2Mh2zK95e3RvlzpcwIWT21RY1o7duorSne+5b8MHF4ynEU+Mrydtxhg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=eAF+5cBK; arc=none smtp.client-ip=220.197.31.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="eAF+5cBK"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=s1
	0aB+eHQfKtUNec5dRvzsTqM5gWxQrG0CzXZAj+ezA=; b=eAF+5cBKyBW0KhkCAo
	R5H48LX0KPxk3WnPpouLIiByGjYuZSbJWLCuqLggk4ySEZ9h/ZlWO6zMRpFXr0Q/
	hJxOEJ+4UjYciLeTonuGHpGmEPPNVCEAFr7wYP+IYEbXJYwWf4EkesSNtUQU6rWg
	QRjmjGbMEHLN5g7AoQx+lB6Oo=
Received: from localhost.localdomain (unknown [])
	by gzga-smtp-mtada-g0-4 (Coremail) with SMTP id _____wDnZ5fZKIhq2WaORA--.42749S2;
	Fri, 21 Aug 2026 18:30:51 +0800 (CST)
From: Yang Xiuwei <yangxiuwei@kylinos.cn>
To: tom.leiming@gmail.com,
	axboe@kernel.dk
Cc: linux-block@vger.kernel.org,
	shuah@kernel.org,
	linux-kselftest@vger.kernel.org,
	Yang Xiuwei <yangxiuwei@kylinos.cn>
Subject: [PATCH 0/2] ublk: fix force_abort leftover after quiesce recover
Date: Fri, 21 Aug 2026 18:30:45 +0800
Message-Id: <20260821103047.369522-1-yangxiuwei@kylinos.cn>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wDnZ5fZKIhq2WaORA--.42749S2
X-Coremail-Antispam: 1Uf129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7v73
	VFW2AGmfu7bjvjm3AaLaJ3UbIYCTnIWIevJa73UjIFyTuYvjxU4VyIUUUUU
Sender: yangxiuwei2025@163.com
X-CM-SenderInfo: p1dqw55lxzvxisqskqqrwthudrp/xtbCwRv8jWqIKNtSoAAA3I

Hi,

Quiesce on a batch device leaves ubq->force_abort set. Recovery does
not clear it, so batch fetch fails with -ENODEV and the device stays
QUIESCED.

Patch 1 clears force_abort in ublk_queue_reset_io_flags().
Patch 2 adds -b coverage to recover_03.

Tested: recover_01, recover_03 (with and without -b).

Yang Xiuwei (2):
  ublk: clear force_abort in ublk_queue_reset_io_flags()
  selftests: ublk: add batch IO cases to recover_03

 drivers/block/ublk_drv.c                        | 1 +
 tools/testing/selftests/ublk/test_recover_03.sh | 5 +++++
 2 files changed, 6 insertions(+)

-- 
2.25.1


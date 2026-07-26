Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 687BB1A6803
	for <linux-block@vger.kernel.org>; Sun, 26 Jul 2026 01:24:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785029055; cv=none; b=uYkXyA7AF08/4kRz38bD/iXe32jmtID56I74IF3DUtTb24tvirTnAj69zPR2SPM96GyoFZrd3pkEO8Z9AdYPbvEIXPC6Jz1OscLjq60Sa3iSporK+5UsbeoPCDW5iPk7w1ZKjLZTRvrvCLR+Rbf/09twPke18z4M3Ax50ImhFh4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785029055; c=relaxed/simple;
	bh=tqPJZmhXDZNB9OFBiDkz/6NeZ56Qzn5Lue1dvW8u2vs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=nJwlcEp5dCQ7hdmsOB2JCkRlb+wh5MfeXa3k9BgVwM0ZBSHCPQ0xrwXoYvkiYp7m989XGVAS1IaeQjgt/jW759rNqanEGbI20rHE5yO3z0iC6vslX9umi9pcSTnAhkM6r7cTg5U1jD+DqKR34rXQApySFfEzePem1mldaw/bUYA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=iHpJBbxj; arc=none smtp.client-ip=220.197.31.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="iHpJBbxj"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=tq
	PJZmhXDZNB9OFBiDkz/6NeZ56Qzn5Lue1dvW8u2vs=; b=iHpJBbxjS1rM05y6jN
	l8ukBjzXON1aiDYGVYeConAcUN23VCH4l+Dx9+uW+6S4l6g5L5at6eDnGcXspgMU
	t07hNo9GoXG8crJOFJYYkPfqVYfVog6eWBgkeCR8ruUIlYCcsnXXBS7BAW7kEDYk
	hKqAOGwD4OD83szzjfykCL/3I=
Received: from localhost.localdomain (unknown [])
	by gzga-smtp-mtada-g1-3 (Coremail) with SMTP id _____wDXxPKfYWVq_rVDKQ--.451S2;
	Sun, 26 Jul 2026 09:23:45 +0800 (CST)
From: Yang Xiuwei <yangxiuwei@kylinos.cn>
To: Caleb Sander Mateos <csander@purestorage.com>
Cc: Ming Lei <tom.leiming@gmail.com>,
	Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org
Subject: Re: [PATCH] ublk: configure io buffer before taking uring_cmd
Date: Sun, 26 Jul 2026 09:23:43 +0800
Message-Id: <20260726012343.2075302-1-yangxiuwei@kylinos.cn>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <CADUfDZq1djzvp0rmG48jwavAZGWAZ4Fe3BUCCFxLMUPewbcH5Q@mail.gmail.com>
References: <20260724100327.43482-1-yangxiuwei@kylinos.cn> <CADUfDZq1djzvp0rmG48jwavAZGWAZ4Fe3BUCCFxLMUPewbcH5Q@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wDXxPKfYWVq_rVDKQ--.451S2
X-Coremail-Antispam: 1Uf129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7v73
	VFW2AGmfu7bjvjm3AaLaJ3UbIYCTnIWIevJa73UjIFyTuYvjxUjHUqUUUUU
Sender: yangxiuwei2025@163.com
X-CM-SenderInfo: p1dqw55lxzvxisqskqqrwthudrp/xtbC6QF0BWplYaH9qgAA3B

Hi Caleb,

On Sat, Jul 25, 2026 at 12:18:55PM -0700, Caleb Sander Mateos wrote:
> I'm not sure this ordering works either. __ublk_fetch() is responsible
> for checking that the I/O is in a valid state to fetch (device not yet
> started, I/O not yet fetched). It wouldn't be safe to overwrite
> io->buf before this check. Probably it would make sense to perform the
> sqe->addr validation before calling __ublk_fetch() and then make
> ublk_config_io_buf() infallible.

Agreed, will fix that in v2.

Thanks,
Yang Xiuwei


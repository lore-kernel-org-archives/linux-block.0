Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05DA6197
	for <linux-block@vger.kernel.org>; Fri, 21 Jun 2024 03:15:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718939708; cv=none; b=UDNdQRi3yr1tbg3omm4NKfzPA8wKB899haILCk+b3AIsyfvztR4Hg0I1Jx/y/Y9mUfIaXQq/nnp8TM+V9QtFQpVQ71BVbNOYLAhA5hrxs0gBgX/1i1vA3pkHmnjetLEVg5SG6pT9TTyivzqJ4FF2kPDZ916t9A4VaAgxuBSk90U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718939708; c=relaxed/simple;
	bh=7R9Pe1qschShhKq2GY36Dfi2wNH44drMQ8SM5RUvvcM=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=Rcj9Ieslq8lYIDrtq+EJ0w0wZltR0qeXRPe+pA3592a4mt6mKgOqJP8ZOGKHkaRuyiJ4YXV8LXHW2fGlkMoH2RhATEPGumHLuEqtorCKtWoM4cd761gvXsx+LXC1zNtGcMu62qSVYefH4D6NOIO0ZeRdkuNgQEGIMWlPaANABqg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Qwozs0b8; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Qwozs0b8"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 41390C2BD10;
	Fri, 21 Jun 2024 03:15:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718939707;
	bh=7R9Pe1qschShhKq2GY36Dfi2wNH44drMQ8SM5RUvvcM=;
	h=From:To:Subject:Date:From;
	b=Qwozs0b8Rvu0/i7z6sLqNd6IkVNsHYQHrkxjpCIdXn4WR/oVsNAdbwJu+IKjLnQrU
	 G+L1eKxUuLGg4WQN9tRnFdkoim/hRbXRGwGCUwOacs8lkVgzB1FfdqM6MYqlpGvTpa
	 t2+16CdPQU8ak/aG1ZK4eIRb6vnMLTExfyOdVm8dlt4T8ik4g2h32Y2c4Kmq69gs+0
	 0BwCacicBhu6gdVj0fY8i/a9t6h6nsKMAChtlGwA5LjjL7dgVdo6PnNBpsbOn6cLX4
	 vJjSCCAAQlGHjSxNAvM3z9x7sBICByvKbp5gfqrldSQbbkT1UwN5hk6FdBW3mqUj4O
	 kBFKCEcsIcBbQ==
From: Damien Le Moal <dlemoal@kernel.org>
To: Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org
Subject: [PATCH 0/3] Cleanup blkdev zone helpers
Date: Fri, 21 Jun 2024 12:15:03 +0900
Message-ID: <20240621031506.759397-1-dlemoal@kernel.org>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The first patch removes a useless initialization of the number of zones
of a zoned null_blk device. The following 2 patches rework the zone
related inline helper functions in blkdev.h to simplify their
definition, removing uneeded code.

Damien Le Moal (3):
  null_blk: Do not set disk->nr_zones
  block: Define bdev_nr_zones() as an inline function
  block: Cleanup block device zone helpers

 block/blk-zoned.c              | 18 -------------
 drivers/block/null_blk/zoned.c |  2 --
 include/linux/blkdev.h         | 46 +++++++++++-----------------------
 3 files changed, 15 insertions(+), 51 deletions(-)

-- 
2.45.2


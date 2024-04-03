Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58F44168BD
	for <linux-block@vger.kernel.org>; Wed,  3 Apr 2024 14:18:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712153887; cv=none; b=QzWEUVhyN8c6apefrl1QcAZarlsEDPv+D2GdpGFDwHcK9u87x1/OUzykCNaKvPzt9QPsQV/5VSEMTB/XmjAfafMaRWWtC3tJmkEB1qTDW4k1V6VsZR1ySrOPqJKgtZEqN6enBMEEtbF46VlbPCgQnYjBTfsD4QGnUebuhZ/rXew=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712153887; c=relaxed/simple;
	bh=5WLxOnkBJjo+0/yjmhaPs0wdHBWPf/7+izSo8rpQdYc=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=PduksuO0yv8hNiM1d0FiufXYR3GxoOhOgAuvyG06cz0vfdmxh+dgl6SFcoOaOgMplZ2JJJ+21sDjcBeR2k0kArSlLfmZp7tIXiM/kXf/A2ZAXYjoU6oHCji9XnsqbI5rUPuCi9qWEgIiLTdEkTagmwLwTCMGP7olCsKH3NKZ3q4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NuWtTg5K; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NuWtTg5K"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 443F0C433C7;
	Wed,  3 Apr 2024 14:18:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712153886;
	bh=5WLxOnkBJjo+0/yjmhaPs0wdHBWPf/7+izSo8rpQdYc=;
	h=From:To:Cc:Subject:Date:From;
	b=NuWtTg5KxYV2VyFxLPwASt9nk5SyyAAczmPsX6EqVXaE+uy0yZTf+Qg14SSrtFhH/
	 1d64qMKMjSK6F6ho+1suRE9a6BymHSKdGfGlPSwlfjp0aTEW1/9Bke0R3hT06E+ADy
	 5RyCeU8DMjya/pZ1QOkZXgyZvUXLR6+29DC854Ek5hDLigHSKd3ulX5Z/Kccpip8Ey
	 SU33r1KwSqFZB4lTwdPKTkF9+zBoq4t3wx4aNRC23KNx5W8ZbFyRnqT/wSdxAwi6qW
	 re/WQP81gDnWrsC3vUSqpkH5bJL/wFzsiSAYf6TI5n1Abd9qN5qP4WOQA7QQBmiNis
	 BfRRRHp4HlgMw==
From: Hannes Reinecke <hare@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Keith Busch <kbusch@kernel.org>,
	Sagi Grimberg <sagi@grimberg.me>,
	Jens Axboe <axboe@kernel.dk>,
	linux-nvme@lists.infradead.org,
	linux-block@vger.kernel.org,
	Hannes Reinecke <hare@kernel.org>
Subject: [PATCHv2 0/2] block,nvme: latency-based I/O scheduler
Date: Wed,  3 Apr 2024 16:17:54 +0200
Message-Id: <20240403141756.88233-1-hare@kernel.org>
X-Mailer: git-send-email 2.35.3
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi all,

there had been several attempts to implement a latency-based I/O
scheduler for native nvme multipath, all of which had its issues.

So time to start afresh, this time using the QoS framework
already present in the block layer.
It consists of two parts:
- a new 'blk-nlatency' QoS module, which is just a simple per-node
  latency tracker
- a 'latency' nvme I/O policy

Using the 'tiobench' fio script with 512 byte blocksize I'm getting
the following latencies (in usecs) as a baseline:
- seq write: avg 186 stddev 331
- rand write: avg 4598 stddev 7903
- seq read: avg 149 stddev 65
- rand read: avg 150 stddev 68

Enabling the 'latency' iopolicy:
- seq write: avg 178 stddev 113
- rand write: avg 3427 stddev 6703
- seq read: avg 140 stddev 59
- rand read: avg 141 stddev 58

Setting the 'decay' parameter to 10:
- seq write: avg 182 stddev 65
- rand write: avg 2619 stddev 5894
- seq read: avg 142 stddev 57
- rand read: avg 140 stddev 57  

That's on a 32G FC testbed running against a brd target,
fio running with 48 threads. So promises are met: latency
goes down, and we're even able to control the standard
deviation via the 'decay' parameter.

As usual, comments and reviews are welcome.

Changes to the original version:
- split the rqos debugfs entries
- Modify commit message to indicate latency
- rename to blk-nlatency

Hannes Reinecke (2):
  block: track per-node I/O latency
  nvme: add 'latency' iopolicy

 block/Kconfig                 |   6 +
 block/Makefile                |   1 +
 block/blk-mq-debugfs.c        |   2 +
 block/blk-nlatency.c          | 388 ++++++++++++++++++++++++++++++++++
 block/blk-rq-qos.h            |   6 +
 drivers/nvme/host/multipath.c |  57 ++++-
 drivers/nvme/host/nvme.h      |   1 +
 include/linux/blk-mq.h        |  11 +
 8 files changed, 465 insertions(+), 7 deletions(-)
 create mode 100644 block/blk-nlatency.c

-- 
2.35.3


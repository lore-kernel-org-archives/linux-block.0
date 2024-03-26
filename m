Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9723113CF80
	for <linux-block@vger.kernel.org>; Tue, 26 Mar 2024 15:35:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711467345; cv=none; b=SFpNYqKKgwOSLwmdf/BBbgCIhoVh6DhLroDJyQ9uw3GTdtptQMLIJT5gesZOq34l1A5xaknQN8pIWF12MqR/u5Z4aqymcGHhNVffelj9HUTSxFk1kX/+xErJOqePsYLTNaBhqpxOieuOoVyrNm6Q1sIUNJpsyLVsDTFev7OMaMU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711467345; c=relaxed/simple;
	bh=+NvJmxYGsuSk9QvPxWPrs/QuQrrlwDBVa5xA8JoGAxk=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=N2Z8BHliJgXPmj5R2OoPk8D/vbpW0CQKSGYKTiFlU3Bn/pWTyGax7SW3BvkCHbQ2+CelHrhZLsp6iZbOQNNFHApOQXtS1RV4PETQyeHmusPzB4wTSjWROci2u7cJdMMldpr46oRtkBA3iZMk030Y4Ha9ZawjWEjACcnW8OG5dT0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DaQZgJvN; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DaQZgJvN"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 857AEC433C7;
	Tue, 26 Mar 2024 15:35:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711467345;
	bh=+NvJmxYGsuSk9QvPxWPrs/QuQrrlwDBVa5xA8JoGAxk=;
	h=From:To:Cc:Subject:Date:From;
	b=DaQZgJvNsJUyeVi6igAjGhE3GF3jr1Y6Vl/QEu8cr66A2UoCuBMOol3abtzAzpytz
	 ZEcsP+AUr6/Tq1TRhnX4RhoylECDumO1XfTOqSr04PiPVUZLWqh1Np0TNhj5lhL55+
	 ulvWjzXhQUyoVWuHmzS7fS4NS/Yji9O9wYhG/m2O5xB8k1aRwzVRoUnoidlDWWRMzp
	 vuPyd3IZBdZPWJd/9TRkIN6AMyXiDbK4ojUxGy82RSOad7AIViBfTJri3jUFhl62iO
	 8RamkzF+r5XaOqHoGOWoWRPhcJOewRVokUeE5I4w4yaT0UOUijGmZbcWTcvS8cHlFf
	 S/MPk2gJueq0Q==
From: Hannes Reinecke <hare@kernel.org>
To: Jens Axboe <axboe@kernel.dk>
Cc: Keith Busch <kbusch@kernel.org>,
	Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>,
	linux-nvme@lists.infradead.org,
	linux-block@vger.kernel.org,
	Hannes Reinecke <hare@kernel.org>
Subject: [PATCH RFC 0/2] block,nvme: latency-based I/O scheduler
Date: Tue, 26 Mar 2024 16:35:27 +0100
Message-Id: <20240326153529.75989-1-hare@kernel.org>
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
- a new 'blk-nodelat' QoS module, which is just a simple per-node
  latency tracker
- a 'latency' nvme I/O policy

Using the 'tiobench' fio script I'm getting:
  WRITE: bw=531MiB/s (556MB/s), 33.2MiB/s-52.4MiB/s
  (34.8MB/s-54.9MB/s), io=4096MiB (4295MB), run=4888-7718msec
    WRITE: bw=539MiB/s (566MB/s), 33.7MiB/s-50.9MiB/s
  (35.3MB/s-53.3MB/s), io=4096MiB (4295MB), run=5033-7594msec
     READ: bw=898MiB/s (942MB/s), 56.1MiB/s-75.4MiB/s
  (58.9MB/s-79.0MB/s), io=4096MiB (4295MB), run=3397-4560msec
     READ: bw=1023MiB/s (1072MB/s), 63.9MiB/s-75.1MiB/s
  (67.0MB/s-78.8MB/s), io=4096MiB (4295MB), run=3408-4005msec

for 'round-robin' and

  WRITE: bw=574MiB/s (601MB/s), 35.8MiB/s-45.5MiB/s
  (37.6MB/s-47.7MB/s), io=4096MiB (4295MB), run=5629-7142msec
    WRITE: bw=639MiB/s (670MB/s), 39.9MiB/s-47.5MiB/s
  (41.9MB/s-49.8MB/s), io=4096MiB (4295MB), run=5388-6408msec
     READ: bw=1024MiB/s (1074MB/s), 64.0MiB/s-73.7MiB/s
  (67.1MB/s-77.2MB/s), io=4096MiB (4295MB), run=3475-4000msec
     READ: bw=1013MiB/s (1063MB/s), 63.3MiB/s-72.6MiB/s
  (66.4MB/s-76.2MB/s), io=4096MiB (4295MB), run=3524-4042msec
  
for 'latency' with 'decay' set to 10.
That's on a 32G FC testbed running against a brd target,
fio running with 16 thread.

As usual, comments and reviews are welcome.

Hannes Reinecke (2):
  block: track per-node I/O latency
  nvme: add 'latency' iopolicy

 block/Kconfig                 |   7 +
 block/Makefile                |   1 +
 block/blk-mq-debugfs.c        |   2 +
 block/blk-nodelat.c           | 368 ++++++++++++++++++++++++++++++++++
 block/blk-rq-qos.h            |   6 +
 drivers/nvme/host/multipath.c |  46 ++++-
 drivers/nvme/host/nvme.h      |   2 +
 include/linux/blk-mq.h        |  11 +
 8 files changed, 439 insertions(+), 4 deletions(-)
 create mode 100644 block/blk-nodelat.c

-- 
2.35.3


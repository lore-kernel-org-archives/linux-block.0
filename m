Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FEBE25949A
	for <linux-block@vger.kernel.org>; Sat,  4 Jan 2025 13:25:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735997159; cv=none; b=A3dJ5vtteO0wdaRMH/cRvU7UpdKtSX4Uy89al4noXSk3O83AbCGwLTrwlG75bKgt4FMLryAUN3IP57s1tf/fDbtAAUepHNjsU7949fx0yUpc4zaU+J1XlhorM7MhiqmEteuOFyTYVsxy/R5APkiFzMF79tsHrEcH+jUh+rSXm00=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735997159; c=relaxed/simple;
	bh=har1/GhEcZrPJFeBVnIml94XvalIgKbFhgx19QnyqSs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=LDRqYENuElgEWijXBYBbxYI+lDYzsXKhSariocHILOiQwRjxqTpPuloNEQqR2x/ROwWE6qpKOwP1c/NtRgnoMYU6m6QSgMbsvUUqMAqrNS2DvSV3c4wdciAi4nlHTMqq1EAnQXbVXBnmfXa5UBg84LdSYGCEGxwLQjv5IVLQg7Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YNJAs4Po; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YNJAs4Po"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EA960C4CED1;
	Sat,  4 Jan 2025 13:25:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1735997159;
	bh=har1/GhEcZrPJFeBVnIml94XvalIgKbFhgx19QnyqSs=;
	h=From:To:Cc:Subject:Date:From;
	b=YNJAs4Po56ImaJXQNeMoij9BIPW0FM8b8wd2994m93QnXpf5MiI4kWPBw7m43S8Mb
	 Hjg/mngVTH5CuY+G7c6/xiewDKFBErFFh5IzO3NuxFtI7VbhwyOvYrOh14QuVgh2UG
	 WPlsTRYtL+gHrZT9ttV/bLp804db09LNgeIP81LeqZXQcSYELBOQaMGigsVHsf6ohR
	 XbGpGE26OjVJ7CdRYeHnYwMGxTFS8o55Mlxe195s0ciHgebz15gLfodRjDer3Nx2M9
	 PxJdiSM9z/7ekWDGSG0ks5Oq1Xe2iphSrygjIhu61C72ZEzpKvzXjbKGgS1b5Rb2rz
	 HKRSXAu7f6D2g==
From: Damien Le Moal <dlemoal@kernel.org>
To: Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org,
	linux-nvme@lists.infradead.org,
	Christoph Hellwig <hch@lst.de>,
	Keith Busch <kbusch@kernel.org>,
	Sagi Grimberg <sagi@grimberg.me>
Cc: Ming Lei <ming.lei@redhat.com>,
	Nilay Shroff <nilay@linux.ibm.com>
Subject: [PATCH 0/3] Fix queue freeze and limit locking order
Date: Sat,  4 Jan 2025 22:25:19 +0900
Message-ID: <20250104132522.247376-1-dlemoal@kernel.org>
X-Mailer: git-send-email 2.47.1
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Three patches to fix the ordering of freezing a queue with
blk_mq_freeze_queue() and obtaining a device queue limits lock with
queue_limits_start_update(). These changes ensure that a devie queue is
always frozen after the device limits lock is obtained to avoid
potential ABBA deadlocks in drivers that need to issue commands to probe
a device limits with the limits lock held (e.g. the SCSI sd driver).

Damien Le Moal (3):
  block: Fix sysfs queue freeze and limits lock order
  block: Fix __blk_mq_update_nr_hw_queues() queue freeze and limits lock
    order
  nvme: Fix queue freeze and limits lock order

 block/blk-mq.c           |  25 +++++---
 block/blk-sysfs.c        | 123 ++++++++++++++++++++-------------------
 drivers/nvme/host/core.c |   8 ++-
 3 files changed, 85 insertions(+), 71 deletions(-)

-- 
2.47.1


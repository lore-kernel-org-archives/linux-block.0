Received: from mail.nearlyone.de (mail.nearlyone.de [49.12.199.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 239B7E570;
	Fri, 21 Jun 2024 13:53:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=49.12.199.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718978008; cv=none; b=P8lSxZn2Cbr+/z9hyxVPIuE8RJVhk3UupR8mhoqW6D/djGNdT26C9jsVj/QKaaSNG6h3q382QkhntZiXoUd/MFmb0anPDyvJ2b4SQdpIfHD4pIf3+wWuLwsrsHoLt16Xm1Amc1y1A+cXXtdqNs2UNyiAnHvjSDbknEnvTN+eXQY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718978008; c=relaxed/simple;
	bh=HERWvHiosibkb6xs37g2sRWI61DDqpniVfuihxfKeTM=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=JeV5Qvd/Zvq04F53rRYY8ZosBcYrh7mWN07df1ZgLTjhxnWL2J5bXTz2Fh2SmAFcEs65Nx8Y4+bPTvuOyi6J1k0lpaf5dvdvCqqBdbJcfeRZ04vutpVWhX3/VD+M4SBvj8yOWZ1EQ9CC1b0ll4OKm/sLjHGoR8mtSy3qfapK5ag=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=monom.org; dkim=pass (2048-bit key) header.d=monom.org header.i=@monom.org header.b=yWJ/xzg3; arc=none smtp.client-ip=49.12.199.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=monom.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=monom.org header.i=@monom.org header.b="yWJ/xzg3"
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 69FC6DACC5;
	Fri, 21 Jun 2024 15:53:13 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monom.org; s=dkim;
	t=1718977996; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding; bh=LrRiLJQXq0+Fgwzc1RJ29wpifhbk8AA0zZF7QAW4mmA=;
	b=yWJ/xzg3bE7n2o+trwoFxNp6mRlE0vbdQigzbdeJfQOPJQdqaAsvexGzMv7ITsnFrTPjsN
	QAOJtY/FwxE9lQ+uOUIe1hvr3j5vvEd3QdpaAOeKBMMGhMzqFfEgQWSkRV9tGwZBaVlF3z
	/BaqH5zMdWapOrzyXrkJKUnQkcZyIVIQn0pSZc1ShzlSTVrLIKR5pnlyxHRZ1iyaBXxeMo
	n2pNVnSIxmRX2CsLINfKEYwgqk27QwHRSmO8ABw1VELnV9nVprxluUV9lC7aDsRTiltAhK
	SNCCTwx+86DOdgy1uZ/4XtUDlblVPpPzmt1sdGxx3otPMGSC+5jEuOjiKlfwxQ==
From: Daniel Wagner <dwagner@suse.de>
Subject: [PATCH 0/3] nvme-pci: honor isolcpus configuration
Date: Fri, 21 Jun 2024 15:53:09 +0200
Message-Id: <20240621-isolcpus-io-queues-v1-0-8b169bf41083@suse.de>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAMWFdWYC/x3MQQqAIBBA0avErBswkZKuEi2yxhqILAcjCO+et
 HyL/18QikwCffVCpJuFw1HQ1BXM23SshLwUg1baqFYrZAn7fCZBDnglSiTYTNaSM5331kEJz0i
 en386jDl/FhjDFmQAAAA=
To: Jens Axboe <axboe@kernel.dk>, Keith Busch <kbusch@kernel.org>, 
 Sagi Grimberg <sagi@grimberg.me>, Thomas Gleixner <tglx@linutronix.de>, 
 Christoph Hellwig <hch@lst.de>
Cc: Frederic Weisbecker <fweisbecker@suse.com>, 
 Mel Gorman <mgorman@suse.de>, Hannes Reinecke <hare@suse.de>, 
 Sridhar Balaraman <sbalaraman@parallelwireless.com>, 
 "brookxu.cn" <brookxu.cn@gmail.com>, Ming Lei <ming.lei@redhat.com>, 
 linux-kernel@vger.kernel.org, linux-block@vger.kernel.org, 
 linux-nvme@lists.infradead.org, Daniel Wagner <dwagner@suse.de>
X-Mailer: b4 0.13.0
X-Last-TLS-Session-Version: TLSv1.3

The nvme-pci driver is ignoring the isolcpus configuration. There were several
attempts to fix this in the past [1][2]. This is another attempt but this time
trying to address the feedback and solve it in the core code.

The first patch introduces a new option for isolcpus 'io_queue', but I'm not
really sure if this is needed and we could just use the managed_irq option
instead. I guess depends if there is an use case which depens on queues on the
isolated CPUs.

The second patch introduces a new block layer helper which returns the number of
possible queues. I suspect it would makes sense also to make this helper a bit
smarter and also consider the number of queues the hardware supports.

And the last patch updates the group_cpus_evenly function so that it uses only
the housekeeping CPUs when they are defined

Note this series is not addressing the affinity setting of the admin queue
(queue 0). I'd like to address this after we agreed on how to solve this.
Currently, the admin queue affinity can be controlled by the irq_afffinity
command line option, so there is at least a workaround for it.

Baseline:

available: 2 nodes (0-1)
node 0 cpus: 0 1 2 3
node 0 size: 1536 MB
node 0 free: 1227 MB
node 1 cpus: 4 5 6 7
node 1 size: 1729 MB
node 1 free: 1422 MB
node distances:
node   0   1
  0:  10  20
  1:  20  10

options nvme write_queues=4 poll_queues=4

55: 0 41 0 0 0 0 0 0 PCI-MSIX-0000:00:05.0 0-edge nvme0q0 affinity: 0-3
63: 0 0 0 0 0 0 0 0 PCI-MSIX-0000:00:05.0 1-edge nvme0q1 affinity: 4-5
64: 0 0 0 0 0 0 0 0 PCI-MSIX-0000:00:05.0 2-edge nvme0q2 affinity: 6-7
65: 0 0 0 0 0 0 0 0 PCI-MSIX-0000:00:05.0 3-edge nvme0q3 affinity: 0-1
66: 0 0 0 0 0 0 0 0 PCI-MSIX-0000:00:05.0 4-edge nvme0q4 affinity: 2-3
67: 0 0 0 0 24 0 0 0 PCI-MSIX-0000:00:05.0 5-edge nvme0q5 affinity: 4
68: 0 0 0 0 0 1 0 0 PCI-MSIX-0000:00:05.0 6-edge nvme0q6 affinity: 5
69: 0 0 0 0 0 0 41 0 PCI-MSIX-0000:00:05.0 7-edge nvme0q7 affinity: 6
70: 0 0 0 0 0 0 0 3 PCI-MSIX-0000:00:05.0 8-edge nvme0q8 affinity: 7
71: 1 0 0 0 0 0 0 0 PCI-MSIX-0000:00:05.0 9-edge nvme0q9 affinity: 0
72: 0 18 0 0 0 0 0 0 PCI-MSIX-0000:00:05.0 10-edge nvme0q10 affinity: 1
73: 0 0 0 0 0 0 0 0 PCI-MSIX-0000:00:05.0 11-edge nvme0q11 affinity: 2
74: 0 0 0 3 0 0 0 0 PCI-MSIX-0000:00:05.0 12-edge nvme0q12 affinity: 3

queue mapping for /dev/nvme0n1
        hctx0: default 4 5
        hctx1: default 6 7
        hctx2: default 0 1
        hctx3: default 2 3
        hctx4: read 4
        hctx5: read 5
        hctx6: read 6
        hctx7: read 7
        hctx8: read 0
        hctx9: read 1
        hctx10: read 2
        hctx11: read 3
        hctx12: poll 4 5
        hctx13: poll 6 7
        hctx14: poll 0 1
        hctx15: poll 2 3

PCI name is 00:05.0: nvme0n1
        irq 55, cpu list 0-3, effective list 1
        irq 63, cpu list 4-5, effective list 5
        irq 64, cpu list 6-7, effective list 7
        irq 65, cpu list 0-1, effective list 1
        irq 66, cpu list 2-3, effective list 3
        irq 67, cpu list 4, effective list 4
        irq 68, cpu list 5, effective list 5
        irq 69, cpu list 6, effective list 6
        irq 70, cpu list 7, effective list 7
        irq 71, cpu list 0, effective list 0
        irq 72, cpu list 1, effective list 1
        irq 73, cpu list 2, effective list 2
        irq 74, cpu list 3, effective list 3

* patched:

48: 0 0 33 0 0 0 0 0 PCI-MSIX-0000:00:05.0 0-edge nvme0q0 affinity: 0-3
58: 0 0 0 0 0 0 0 0 PCI-MSIX-0000:00:05.0 1-edge nvme0q1 affinity: 4
59: 0 0 0 0 0 0 0 0 PCI-MSIX-0000:00:05.0 2-edge nvme0q2 affinity: 5
60: 0 0 0 0 0 0 0 0 PCI-MSIX-0000:00:05.0 3-edge nvme0q3 affinity: 0
61: 0 0 0 0 0 0 0 0 PCI-MSIX-0000:00:05.0 4-edge nvme0q4 affinity: 1
62: 0 0 0 0 45 0 0 0 PCI-MSIX-0000:00:05.0 5-edge nvme0q5 affinity: 4
63: 0 0 0 0 0 12 0 0 PCI-MSIX-0000:00:05.0 6-edge nvme0q6 affinity: 5
64: 2 0 0 0 0 0 0 0 PCI-MSIX-0000:00:05.0 7-edge nvme0q7 affinity: 0
65: 0 35 0 0 0 0 0 0 PCI-MSIX-0000:00:05.0 8-edge nvme0q8 affinity: 1

queue mapping for /dev/nvme0n1
        hctx0: default 2 3 4 6 7
        hctx1: default 5
        hctx2: default 0
        hctx3: default 1
        hctx4: read 4
        hctx5: read 5
        hctx6: read 0
        hctx7: read 1
        hctx8: poll 4
        hctx9: poll 5
        hctx10: poll 0
        hctx11: poll 1

PCI name is 00:05.0: nvme0n1
        irq 48, cpu list 0-3, effective list 2
        irq 58, cpu list 4, effective list 4
        irq 59, cpu list 5, effective list 5
        irq 60, cpu list 0, effective list 0
        irq 61, cpu list 1, effective list 1
        irq 62, cpu list 4, effective list 4
        irq 63, cpu list 5, effective list 5
        irq 64, cpu list 0, effective list 0
        irq 65, cpu list 1, effective list 1

[1] https://lore.kernel.org/lkml/20220423054331.GA17823@lst.de/T/#m9939195a465accbf83187caf346167c4242e798d
[2] https://lore.kernel.org/linux-nvme/87fruci5nj.ffs@tglx/

Signed-off-by: Daniel Wagner <dwagner@suse.de>
---
Daniel Wagner (3):
      sched/isolation: Add io_queue housekeeping option
      nvme-pci: limit queue count to housekeeping cpus
      lib/group_cpus.c: honor housekeeping config when grouping CPUs

 block/blk-mq-cpumap.c           | 13 +++++++++
 drivers/nvme/host/pci.c         |  4 +--
 include/linux/blk-mq.h          |  1 +
 include/linux/sched/isolation.h |  1 +
 kernel/sched/isolation.c        |  7 +++++
 lib/group_cpus.c                | 64 +++++++++++++++++++++++++++++++++++++++--
 6 files changed, 86 insertions(+), 4 deletions(-)
---
base-commit: 6ba59ff4227927d3a8530fc2973b80e94b54d58f
change-id: 20240620-isolcpus-io-queues-1a88eb47ff8b

Best regards,
-- 
Daniel Wagner <dwagner@suse.de>


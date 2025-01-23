Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4114B2F3B;
	Thu, 23 Jan 2025 13:08:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737637715; cv=none; b=IhseofWmheEuJNjQOkdyr7bD+uDC/8wOjZmAsVEIXm0xMFZ1DZ65nblCXC/+VCym+R9hFnO0Ae0diuoVfAcxd1C0GTOEbEiBYQci4+fjojTNOxntfYTM+mLdLgVoPavHH5VlWqn3urOc55KknmGPPRPwKx2ogBpWvdcAdFjMIo4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737637715; c=relaxed/simple;
	bh=bokt7W96nNVQcWceuR7vwKQMgtuaAZDEF/ZkyrMVbOA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=KpJMRDvchh9JWZhFdE55PK30K0tk4Vlcwk3pj9gvXcmvuMiDbZkPnIWIUWsGlL9i2ghxlhdwCf2AXYrKZMeg2BD7pv0I7r92Yc8TWTQI0HMXpxuAEdFpRH7oudD5Sdv3bBR4q58K6/Y5ln/8/vxYIbPKJHxi00dFBLxc0gT9KU4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Oh6EQioA; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Oh6EQioA"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5EDA8C4CED3;
	Thu, 23 Jan 2025 13:08:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737637714;
	bh=bokt7W96nNVQcWceuR7vwKQMgtuaAZDEF/ZkyrMVbOA=;
	h=From:Date:Subject:To:Cc:From;
	b=Oh6EQioAvayPDPoHbD7hPAaWQ21bLDN1HFBoXN0BFy+76dke9nmbg+HJ/Rj4VV1Bb
	 Q9CGY1qtsUUBokJT7Qm+ausy1BMnQkxofS/ucj3DCa2uCeTT7V/Id3HEP/Krjt03ju
	 ktAG2IklCWAg5J3Uv4wnRyovHlBqv6TU8x00KoCsjtgIqqDPiGrB0ApUV8sv5RRLDb
	 4leg4p6oa4eCMLIyCzbDwujpvPCX9Hu3TDUa1px5JRqSuCiisnF4sKidhtE/HZ6skP
	 FdYVWjnXz0KOY6tdY77OuKBpOF2J3t9GJFjfXMEL38/NwWVqNNHZUO6t1QLDY5xjtH
	 EduajJX0YaeMg==
From: Daniel Wagner <wagi@kernel.org>
Date: Thu, 23 Jan 2025 14:08:29 +0100
Subject: [PATCH] blk-mq: create correct map for fallback case
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250123-fix-blk_mq_map_hw_queues-v1-1-08dbd01f2c39@kernel.org>
X-B4-Tracking: v=1; b=H4sIAEw/kmcC/x2M7QpAMBRAX2Xd31Y2obyKtK65uGHY8lHy7pafp
 845DwTyTAEq8YCnkwOvLoJKBNgR3UCSu8igU52nSmey51u282SW3Sy4mfEy+0EHBdnZUmOBypY
 KIeabp+j+67p53w8IAUkQagAAAA==
X-Change-ID: 20250123-fix-blk_mq_map_hw_queues-dc72a6a1c71a
To: Jens Axboe <axboe@kernel.dk>
Cc: Steven Rostedt <rostedt@goodmis.org>, Hannes Reinecke <hare@suse.de>, 
 Ming Lei <ming.lei@redhat.com>, John Garry <john.g.garry@oracle.com>, 
 linux-block@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Daniel Wagner <wagi@kernel.org>
X-Mailer: b4 0.14.2

The fallback code in blk_mq_map_hw_queues is original from
blk_mq_pci_map_queues and was added to handle the case where
pci_irq_get_affinity will return NULL for !SMP configuration.

blk_mq_map_hw_queues replaces besides blk_mq_pci_map_queues also
blk_mq_virtio_map_queues which used to use blk_mq_map_queues for the
fallback.

It's possible to use blk_mq_map_queues for both cases though.
blk_mq_map_queues creates the same map as blk_mq_clear_mq_map for !SMP
that is CPU 0 will be mapped to hctx 0.

The WARN_ON_ONCE has to be dropped for virtio as the fallback is also
taken for certain configuration on default. Though there is still a
WARN_ON_ONCE check in lib/group_cpus.c:

       WARN_ON(nr_present + nr_others < numgrps);

which will trigger if the caller tries to create more hardware queues
than CPUs. It tests the same as the WARN_ON_ONCE in
blk_mq_pci_map_queues did.

Fixes: a5665c3d150c ("virtio: blk/scsi: replace blk_mq_virtio_map_queues with blk_mq_map_hw_queues")
Reported-by: Steven Rostedt <rostedt@goodmis.org>
Closes: https://lore.kernel.org/all/20250122093020.6e8a4e5b@gandalf.local.home/
Signed-off-by: Daniel Wagner <wagi@kernel.org>
---
 block/blk-mq-cpumap.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/block/blk-mq-cpumap.c b/block/blk-mq-cpumap.c
index ad8d6a363f24ae11968b42f7bcfd6a719a0499b7..444798c5374f48088b661b519f2638bda8556cf2 100644
--- a/block/blk-mq-cpumap.c
+++ b/block/blk-mq-cpumap.c
@@ -87,7 +87,6 @@ void blk_mq_map_hw_queues(struct blk_mq_queue_map *qmap,
 	return;
 
 fallback:
-	WARN_ON_ONCE(qmap->nr_queues > 1);
-	blk_mq_clear_mq_map(qmap);
+	blk_mq_map_queues(qmap);
 }
 EXPORT_SYMBOL_GPL(blk_mq_map_hw_queues);

---
base-commit: c4b9570cfb63501638db720f3bee9f6dfd044b82
change-id: 20250123-fix-blk_mq_map_hw_queues-dc72a6a1c71a

Best regards,
-- 
Daniel Wagner <wagi@kernel.org>


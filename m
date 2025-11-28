Received: from esa7.hc1455-7.c3s2.iphmx.com (esa7.hc1455-7.c3s2.iphmx.com [139.138.61.252])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E73425333F
	for <linux-block@vger.kernel.org>; Fri, 28 Nov 2025 05:21:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=139.138.61.252
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764307295; cv=none; b=nmTN59U1BhnY6RUT1VLIRfR7yynJb0szCU8v9A82F+T7KMnvpXfb6qLRZCUYrXDCCprr5V3N8q/iXRkPGCLfNwY3hTnJDIPMDixt8SVFxT8tU6leR6ZkTgTcfJ6PFh+rmPBW/rloxjhAIYcwi6fVOqEI86KsXqcHj1zXMQh9108=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764307295; c=relaxed/simple;
	bh=Q2McucdX5hvuoyL1dzqsD7aM9eEha5kXECt4ki3+/Ms=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=OdmK2eSl6Ub60+VqCM2Gbz+ndU7KqY7bG5xH3mJS2eH3XliYkNXKWY29KvyKFJ0/5oA6dBBdSW76+3orM9yV+ft8on5s2fGmdnvqmb61QoDpj5x4JnGn/ORfPgnjztmYOx2c9RsTmwfjOVyLzrHLI/IFvAsUjehzPALW27j7zyg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fujitsu.com; spf=pass smtp.mailfrom=fujitsu.com; dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b=aK72yZ8T; arc=none smtp.client-ip=139.138.61.252
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fujitsu.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fujitsu.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b="aK72yZ8T"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj2;
  t=1764307292; x=1795843292;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=Q2McucdX5hvuoyL1dzqsD7aM9eEha5kXECt4ki3+/Ms=;
  b=aK72yZ8Tsk5iC8Tm7UvgwfhoaNtdQ11msqdK7C/XI41XQaEsdPhQf8Fu
   /d3j5jhQld91lBBipX4v2NClxyyPLKHtO9f/uq5ceKISJIkZYQbIOuqK9
   sqhPPEKFIfuuxcIkmODfm3TXqgcOah/m+LB3ij0PzSZQwdC/+AIND7xpe
   ckugWDf0i1nF05iQ89/QoiFGs+xzyfTNaZedkkZBRHVDX3lvg9di4j9Ea
   IeRSWiOzHWohBTIgpMt4nyO8XTXodguAeLBsmJwEsQrk2MqcshyqNkKCl
   yRSYEgQBviXWzt80C0udTceHlyJ3jVtZDdvQD7EBQp+S+1kmmY1BmLnPQ
   Q==;
X-CSE-ConnectionGUID: 8Msua348T2+CIV10bAj8Fg==
X-CSE-MsgGUID: bGlJD1PiSJqMT55Yk7ZKkQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11626"; a="199591177"
X-IronPort-AV: E=Sophos;i="6.20,232,1758553200"; 
   d="scan'208";a="199591177"
Received: from unknown (HELO az2nlsmgr3.o.css.fujitsu.com) ([20.61.8.234])
  by esa7.hc1455-7.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Nov 2025 14:20:21 +0900
Received: from az2nlsmgm4.fujitsu.com (unknown [10.150.26.204])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by az2nlsmgr3.o.css.fujitsu.com (Postfix) with ESMTPS id C59D91000363
	for <linux-block@vger.kernel.org>; Fri, 28 Nov 2025 05:20:21 +0000 (UTC)
Received: from az2nlsmom3.fujitsu.com (az2nlsmom3.o.css.fujitsu.com [10.150.26.199])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by az2nlsmgm4.fujitsu.com (Postfix) with ESMTPS id 81810100711E
	for <linux-block@vger.kernel.org>; Fri, 28 Nov 2025 05:20:21 +0000 (UTC)
Received: from iaas-rdma.. (unknown [10.167.135.44])
	by az2nlsmom3.fujitsu.com (Postfix) with ESMTP id 6E0C5101906B;
	Fri, 28 Nov 2025 05:20:18 +0000 (UTC)
From: Li Zhijian <lizhijian@fujitsu.com>
To: linux-block@vger.kernel.org
Cc: shinichiro.kawasaki@wdc.com,
	Bart Van Assche <bvanassche@acm.org>,
	Yu Kuai <yukuai@fnnas.com>,
	Li Zhijian <lizhijian@fujitsu.com>
Subject: [PATCH blktests v2] test/throtl: don't specify sector_size for scsi_debug target
Date: Fri, 28 Nov 2025 13:22:35 +0800
Message-ID: <20251128052235.67745-1-lizhijian@fujitsu.com>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Currently, `scsi_debug` only supported a maximum `sector_size` of 4096
bytes. However, on systems with a `PAGE_SIZE` greater than 4KB, some
`throtl` tests (002, 003, and 007) attempt to load `scsi_debug`
with `sector_size=$PAGE_SIZE`.

This mismatch causes `scsi_debug` module loading to fail, resulting in
test failures such as:

> throtl/003 (sdebug) (bps limit over IO split)                [failed]
>     runtime  0.147s  ...  0.146s
>     --- tests/throtl/003.out    2025-04-04 04:36:43.175999880 +0800
>     +++ /root/blktests/results/nodev_sdebug/throtl/003.out.bad  2025-11-16 09:26:07.287964459 +0800
>     @@ -1,4 +1,3 @@
>      Running throtl/003
>     -1
>     -1
>     -Test complete
>     +modprobe: ERROR: could not insert 'scsi_debug': Invalid argument
>     +Loading scsi_debug dev_size_mb=1024 sector_size=65536 failed

After discussion[1] in the community, simply remove this parameter to leave
it as the default sector size.

[1] https://lore.kernel.org/linux-block/3407c6bc-9832-41d5-81c7-7216dd81f5e2@fnnas.com/

Signed-off-by: Li Zhijian <lizhijian@fujitsu.com>
---
 tests/throtl/rc | 1 -
 1 file changed, 1 deletion(-)

diff --git a/tests/throtl/rc b/tests/throtl/rc
index d1afefd..2887101 100644
--- a/tests/throtl/rc
+++ b/tests/throtl/rc
@@ -76,7 +76,6 @@ _configure_throtl_blkdev() {
 		;;
 	sdebug)
 		args=(dev_size_mb=1024)
-		((sector_size)) && args+=(sector_size="${sector_size}")
 		if _configure_scsi_debug "${args[@]}"; then
 			THROTL_DEV=${SCSI_DEBUG_DEVICES[0]}
 			return
-- 
2.44.0


Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F19F126ED41
	for <linux-block@vger.kernel.org>; Thu,  6 Aug 2026 02:47:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785984456; cv=none; b=QzgzBpPL0wC0BVSbVycuxbMizhT88H9qH5Z2dRteyT6UFz+nIurrsoAQplqKaWTktjPhRVRyrNx8QMLZKlNc4iZBEqkE8tv8L3dPD0Mw97qXkINS63bU2QpRpagCztp8bRlJ43oUAsLl3RmkeToG30fOQZTMU+Zz+hssKAlf1jA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785984456; c=relaxed/simple;
	bh=cFcguZ0KioPLlILpOn6PF/AuxEDFVJd7LV7CkIZMSGY=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=M3uISu1IUx8SsDjViVPDs1AIXwE4UIB5kApDjsVgE6QBKyW1fKGY8xqVqlPPoN0mWBMXZHsGBIWitam+1TyEGEbwkOatqN8+CMl5MjoMUgJ2SatyhIMqjEJ6PJXSfp/Ow2q4KUaM8KTziwaJSttqnYV0dc5njVZY2oIjxfiWDT0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 28caa4e8914111f1aa26b74ffac11d73-20260806
X-CTIC-Tags:
	HR_CC_COUNT, HR_CC_DOMAIN_COUNT, HR_CC_NAME, HR_CC_NO_NAME, HR_CTE_8B
	HR_CTT_MISS, HR_DATE_H, HR_DATE_WKD, HR_DATE_ZONE, HR_FROM_NAME
	HR_SJ_DIGIT_LEN, HR_SJ_LANG, HR_SJ_LEN, HR_SJ_LETTER, HR_SJ_NOR_SYM
	HR_SJ_PHRASE, HR_SJ_PHRASE_LEN, HR_SJ_WS, HR_TO_COUNT, HR_TO_DOMAIN_COUNT
	HR_TO_NAME, IP_TRUSTED, SRC_TRUSTED, DN_TRUSTED, SA_TRUSTED
	SA_EXISTED, SN_TRUSTED, SN_EXISTED, SPF_NOPASS, DKIM_NOPASS
	DMARC_NOPASS, CIE_BAD, CIE_GOOD, CIE_GOOD_SPF, GTI_FG_BS
	GTI_RG_INFO, GTI_C_BU, AMN_GOOD, ABX_MISS_RDNS
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.12,REQID:a57f6063-1c1e-420d-8b19-d2d39e85c900,IP:10,
	URL:0,TC:0,Content:-5,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTIO
	N:release,TS:5
X-CID-INFO: VERSION:1.3.12,REQID:a57f6063-1c1e-420d-8b19-d2d39e85c900,IP:10,UR
	L:0,TC:0,Content:-5,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:5
X-CID-META: VersionHash:e7bac3a,CLOUDID:3d8dfee83539f0cfc41b5df24b4021d8,BulkI
	D:260806102001MKX985AD,BulkQuantity:1,Recheck:0,SF:10|38|66|78|102|127|850
	|865|898,TC:nil,Content:0|15|50,EDM:-3,IP:-2,URL:99|1,File:nil,RT:nil,Bulk
	:40,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,B
	RE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_ULS
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 28caa4e8914111f1aa26b74ffac11d73-20260806
X-User: sangyao@kylinos.cn
Received: from localhost.localdomain [(223.70.159.239)] by mailgw.kylinos.cn
	(envelope-from <sangyao@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 2047902434; Thu, 06 Aug 2026 10:47:26 +0800
From: Yao Sang <sangyao@kylinos.cn>
To: Jens Axboe <axboe@kernel.dk>,
	Keith Busch <kbusch@kernel.org>,
	Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>
Cc: linux-block@vger.kernel.org,
	linux-nvme@lists.infradead.org,
	Yao Sang <sangyao@kylinos.cn>
Subject: [PATCH v2 0/4] block/nvme: split path limits for namespace heads
Date: Thu,  6 Aug 2026 10:46:54 +0800
Message-Id: <20260806024658.4193386-1-sangyao@kylinos.cn>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

An NVMe namespace head and each path refer to the same namespace. Using
queue_limits_stack_bdev() for the head treats a path as a bottom-device
range and applies the full blk_stack_limits() model. That model is for
generic stacked devices, not for an NVMe namespace head.

For a generic stacked device, the top device maps its data to a range in a
bottom device. blk_stack_limits() must then combine the limits that depend
on that bottom-device range with the limits that must be supported by every
bottom queue. For an NVMe namespace head, all paths address the same LBA
space, so the head should refresh namespace layout values from the
namespace scan and only combine the path limits across paths.

This series makes that split explicit. Topology limits are the block size,
alignment, io_min, io_opt and chunk_sectors values that depend on where the
top device data starts in the bottom device. Path limits are the all-path
execution feature bits, such as NOWAIT, POLL and PCI_P2PDMA, and hardware
limits that every queue which may execute an I/O must support. Operation
and resource limits, such as discard, write zeroes, atomic writes and zoned
resources, keep their own rules.

The first block patch moves the topology work into a static helper. The
second block patch moves the path feature checks and the sector, segment,
integrity segment and DMA alignment updates into blk_stack_path_limits().
The final patch exports that helper and the existing atomic write helper
when adding the NVMe namespace head caller. Existing callers of
blk_stack_limits() continue to use the full function with no behavior
change.

The topology helper uses start, the first data sector in the bottom device
used by the top device, when calculating alignment_offset. A failed
topology check sets BLK_FLAG_MISALIGNED and makes blk_stack_limits()
return -1. This keeps the existing behavior and only moves the code into
the helper. The atomic write helper uses start only in
blk_atomic_write_start_sect_aligned(); a failed check disables atomic
writes without changing the return value. Keep these parts separate even
though both use start. The existing discard alignment handling also
remains in blk_stack_limits().

Changes since v1:
- factor block size and alignment handling out of blk_stack_limits();
- factor the explicitly listed all-path feature and hardware limit updates
  into a block helper;
- export the block helpers only when adding the NVMe caller;
- retain the existing atomic write helper name and parameter types.

Tests:
- blktests nvme/004, 005, 006, 008, 010, 012, 014, 016, 017, 018,
  019, 021, 022, 023, 025, 026, 027, 028, 029, 030, 031, 040, 041,
  042, 043, 044, 045, 049, 051, 052, 053, 054, 057, 058, 059, 065,
  067 and 068 passed.
- blktests zbd/001, 003, 004, 005, 006, 008, 009, 011, 012, and 013
  passed.
- blktests block/003, 004, and 012, and scsi/009 and 010 passed.
- xfstests xfs/643, xfs/646, generic/765, and generic/773 passed.

Link to v1:
https://lore.kernel.org/all/20260720022205.1798805-3-sangyao@kylinos.cn/

Yao Sang (4):
  nvme: factor namespace-head queue-limit update
  block: factor block size and alignment handling out of
    blk_stack_limits
  block: factor out path limit stacking
  block, nvme: use lower-level limit helpers for namespace heads

 block/blk-settings.c     | 171 +++++++++++++++++++++++---------------
 drivers/nvme/host/core.c | 169 +++++++++++++++++++++++++++------------
 include/linux/blkdev.h   |   4 +
 3 files changed, 224 insertions(+), 120 deletions(-)

-- 
2.25.1

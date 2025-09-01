Received: from mailout3.samsung.com (mailout3.samsung.com [203.254.224.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAB1A2FE06D
	for <linux-block@vger.kernel.org>; Mon,  1 Sep 2025 08:48:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756716525; cv=none; b=oIgc/Y8ZU4VrKgvQLaFvmniPZdJl+btQQlpE7aX4uHYHjoZfuttTXzMucWsrvhRv4wH21IjHLfStwllB1GyqwG6v78NfVNUTDe7D7msr5PchOX+PK8R1eHuv3bLoWe+H1WjPqW833vOXJZs14xDvHhN9DGA+B0URYMI6zHOxCpE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756716525; c=relaxed/simple;
	bh=nDUefRFJgIpCXOdGPm4VWR5UXiX2SJ345ziR0YrDGco=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type:
	 References; b=ZWUy2hveFUTyV3bwAtErrDDZQGhVj9bkXBgAppx2MpqjmGrR0W8Jj4AXGlcLtUwUW15VHuM0LG4CMeh3rrT6ATWuf0jSK5rFdT6JjoIlM2C+33q5+89qh2Sk9pgbWaQkwZaLRb5mNifi7cl0SarxDT3yCOS44HVgtw2Jjq5kUf0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=hp1JZNn+; arc=none smtp.client-ip=203.254.224.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="hp1JZNn+"
Received: from epcas5p1.samsung.com (unknown [182.195.41.39])
	by mailout3.samsung.com (KnoxPortal) with ESMTP id 20250901084840epoutp03fbb5e8055a74de6bc5ebce44161ccbc3~hHF4unvF_1033110331epoutp03c
	for <linux-block@vger.kernel.org>; Mon,  1 Sep 2025 08:48:40 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20250901084840epoutp03fbb5e8055a74de6bc5ebce44161ccbc3~hHF4unvF_1033110331epoutp03c
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1756716520;
	bh=TilKFeQT9M5SnZybeAtnZNeeolgMBtWZzteXq1psp+o=;
	h=From:To:Cc:Subject:Date:References:From;
	b=hp1JZNn+dw/uLyc4j9Mtoi5PG4KX+iStZfEH7y1WFTDrZB5teeBZZg9GwhUjKZDy+
	 H+yGxgv2ODMHiaIp7/DEXIsZlKLVVpnFVoFZdbvIy96nqZFTcdU54JfJJ+2k+DpvUp
	 GtIj0SwcXn3Y6q2u8ZxPeQf+NJZkW2u+UZElMp2s=
Received: from epsnrtp01.localdomain (unknown [182.195.42.153]) by
	epcas5p1.samsung.com (KnoxPortal) with ESMTPS id
	20250901084839epcas5p1239b37f833a889b63e910e56acdca31c~hHF4P0y9T2477024770epcas5p1M;
	Mon,  1 Sep 2025 08:48:39 +0000 (GMT)
Received: from epcas5p4.samsung.com (unknown [182.195.38.91]) by
	epsnrtp01.localdomain (Postfix) with ESMTP id 4cFjFy6gxmz6B9m5; Mon,  1 Sep
	2025 08:48:38 +0000 (GMT)
Received: from epsmtip2.samsung.com (unknown [182.195.34.31]) by
	epcas5p1.samsung.com (KnoxPortal) with ESMTPA id
	20250901082648epcas5p18f81021213f2b8a050efa25f76e0fb54~hGyynP-sM1629316293epcas5p1p;
	Mon,  1 Sep 2025 08:26:48 +0000 (GMT)
Received: from node122.. (unknown [109.105.118.122]) by epsmtip2.samsung.com
	(KnoxPortal) with ESMTPA id
	20250901082647epsmtip2c335fdfb4a62178c61f72598f98cc029~hGyx9B0R-0905609056epsmtip2P;
	Mon,  1 Sep 2025 08:26:47 +0000 (GMT)
From: Xue He <xue01.he@samsung.com>
To: axboe@kernel.dk
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org, hexue
	<xue01.he@samsung.com>
Subject: [PATCH] block: plug attempts to batch allocate tags multiple times
Date: Mon,  1 Sep 2025 08:22:09 +0000
Message-Id: <20250901082209.13349-1-xue01.he@samsung.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CMS-MailID: 20250901082648epcas5p18f81021213f2b8a050efa25f76e0fb54
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
cpgsPolicy: CPGSC10-505,Y
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20250901082648epcas5p18f81021213f2b8a050efa25f76e0fb54
References: <CGME20250901082648epcas5p18f81021213f2b8a050efa25f76e0fb54@epcas5p1.samsung.com>

From: hexue <xue01.he@samsung.com>

In the existing plug mechanism, tags are allocated in batches based on
the number of requests. However, testing has shown that the plug only
attempts batch allocation of tags once at the beginning of a batch of
I/O operations. Since the tag_mask does not always have enough available
tags to satisfy the requested number, a full batch allocation is not
guaranteed to succeed each time. The remaining tags are then allocated
individually (occurs frequently), leading to multiple single-tag
allocation overheads.

This patch aims to allow the remaining I/O operations to retry batch
allocation of tags, reducing the overhead caused by multiple
individual tag allocations.

------------------------------------------------------------------------
test result
During testing of the PCIe Gen4 SSD Samsung PM9A3, the perf tool
observed CPU improvements. The CPU usage of the original function
_blk_mq_alloc_requests function was 1.39%, which decreased to 0.82%
after modification.

Additionally, performance variations were observed on different devices.
workload:randread
blocksize:4k
thread:1
------------------------------------------------------------------------
                  PCIe Gen3 SSD   PCIe Gen4 SSD    PCIe Gen5 SSD
native kernel     553k iops       633k iops        793k iops
modified          553k iops       635k iops        801k iops

with Optane SSDs, the performance like
two device one thread
cmd :sudo taskset -c 0 ./t/io_uring -b512 -d128 -c32 -s32 -p1 -F1 -B1
-n1 -r4 /dev/nvme0n1 /dev/nvme1n1

base: 6.4 Million IOPS
patch: 6.49 Million IOPS

two device two thread
cmd: sudo taskset -c 0 ./t/io_uring -b512 -d128 -c32 -s32 -p1 -F1 -B1
-n1 -r4 /dev/nvme0n1 /dev/nvme1n1

base: 7.34 Million IOPS
patch: 7.48 Million IOPS
-------------------------------------------------------------------------

Signed-off-by: hexue <xue01.he@samsung.com>
---
 block/blk-mq.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index b67d6c02eceb..1fb280764b76 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -587,9 +587,9 @@ static struct request *blk_mq_rq_cache_fill(struct request_queue *q,
 	if (blk_queue_enter(q, flags))
 		return NULL;
 
-	plug->nr_ios = 1;
-
 	rq = __blk_mq_alloc_requests(&data);
+	plug->nr_ios = data.nr_tags;
+
 	if (unlikely(!rq))
 		blk_queue_exit(q);
 	return rq;
@@ -3034,11 +3034,13 @@ static struct request *blk_mq_get_new_requests(struct request_queue *q,
 
 	if (plug) {
 		data.nr_tags = plug->nr_ios;
-		plug->nr_ios = 1;
 		data.cached_rqs = &plug->cached_rqs;
 	}
 
 	rq = __blk_mq_alloc_requests(&data);
+	if (plug)
+		plug->nr_ios = data.nr_tags;
+
 	if (unlikely(!rq))
 		rq_qos_cleanup(q, bio);
 	return rq;
-- 
2.34.1


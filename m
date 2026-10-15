Received: from mout-p-102.mailbox.org (mout-p-102.mailbox.org [80.241.56.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CDF546AEF1;
	Thu, 15 Oct 2026 18:43:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792089804; cv=none; b=nJNZo/AVwqcAOaR/GBGIV4jLBCgVYrmtc/HcmQULv3uMB1j8QNpbOQnkQK+VWwWdBzjE9rBm1BJCOYhA86H+AMheUiRMz9ROuPU3bNIGGLkfAm6v7OuC6PLOokKi0xAyLiNA2U1A2nBibhcLfWqKX4yN2OVdujmAX5sENj1P+Zo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792089804; c=relaxed/simple;
	bh=2nbazI1ztG5nMEwxaM7++j/y9IMyHe2N9tqtg9cKYm8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=offmOhPoon/3MLvAKDLfpgTpqZ3S442s2+uqq8xmsHZn427Rlg7TLgoqyEOg1V6E3KhAEZ0itjXlFPSQIbtDNO4kSw65SJx/Mi9eCWlz/G1xrBPibhlehG6WoQZKUrn4SkeqUzGuABgaDHPfJB1UsWM3M2Iq+RYKGfwRK2ueM4s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org; spf=pass smtp.mailfrom=mailbox.org; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=stg4i4tC; arc=none smtp.client-ip=80.241.56.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mailbox.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="stg4i4tC"
Received: from smtp1.mailbox.org (smtp1.mailbox.org [IPv6:2001:67c:2050:b231:465::1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519MLKEM768 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-102.mailbox.org (Postfix) with ESMTPS id 4j5H5K17HszKp1t;
	Thu, 15 Oct 2026 20:43:17 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1792089797;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=UX/ScQpB++PMVqQKSRy45nYkireTA+GVxkU1lh3v1uo=;
	b=stg4i4tCPqWxaiA4nlaPYtmxpvUojz4CRUHEFGWIpVBXRIyjtnnzpfiv7A9I+kPLPfgoXL
	+ymQElqTIH1K4DMdMsnguWD+4PwWeSIZh48pmNgYtXabWNVpaniF8sv2AyTES9lrEefGPX
	K6HgVrxK/99k56yeSVkzGwvGQVLoZXzCbKD5nn56OERrqVto96zfX0pJ1GOKcr2tWvH5CH
	OMC23ja+Vhl2usBF1jVV7+f+gDQUdTxDT+PtoKGMteKWsWD8ZB57Eap9jwGVXy1bRp/1SH
	ORw9WhvnuoAE6DybyHMBzmySYxboFVVeze2po0+5XzCSk5Ku9moKyZLnIMErmg==
From: Manuel Ebner <manuelebnerli@mailbox.org>
To: Jens Axboe <axboe@kernel.dk>,
	Kanchan Joshi <joshi.k@samsung.com>,
	Keith Busch <kbusch@kernel.org>,
	"Martin K. Petersen" <mkp@kernel.org>
Cc: Manuel Ebner <manuelebnerli@mailbox.org>,
	linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] blk-mq-dma: remove obsolete part of kernel-doc
Date: Thu, 15 Oct 2026 20:40:25 +0200
Message-ID: <20261015184025.1025312-2-manuelebnerli@mailbox.org>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-ID: 4f53ce9d8380791632a
X-MBO-RS-META: dmtiyx9o91b87u7ua6j8x8tg4foy9k4o

Variable 'state' is not part of blk_rq_integrity_dma_map_iter_next() nor
was it ever part. Therefore remove it.

Fixes: fec9b16dc555 ("blk-mq-dma: add scatter-less integrity data DMA mapping")
Signed-off-by: Manuel Ebner <manuelebnerli@mailbox.org>
---
 block/blk-mq-dma.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/block/blk-mq-dma.c b/block/blk-mq-dma.c
index 88fd9cbc9..b0a1a2fc7 100644
--- a/block/blk-mq-dma.c
+++ b/block/blk-mq-dma.c
@@ -361,7 +361,6 @@ EXPORT_SYMBOL_GPL(blk_rq_integrity_dma_map_iter_start);
  * 					 a request
  * @req:	request to map
  * @dma_dev:	device to map to
- * @state:	DMA IOVA state
  * @iter:	block layer DMA iterator
  *
  * Iterate to the next integrity mapping after a previous call to
-- 
2.55.0


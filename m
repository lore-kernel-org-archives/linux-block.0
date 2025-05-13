Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 179D21F03C5
	for <linux-block@vger.kernel.org>; Tue, 13 May 2025 07:14:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747120481; cv=none; b=TTokXs4S2W1opKsc17K8uM+tDJzc45wC1PSkiGleUfyqn6ZwU9z0tnKva+4zIBy5bGpp4btebTWTz8CEI7nQBgKNpfV31rjnBlv/Btsc4mNuEoIyMWU6HouWCbpLm1Mhv5P27LG3dWHj6CTTIXpuB0n06g3eIaLLYKvtjBarA38=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747120481; c=relaxed/simple;
	bh=LBar15IoW7NzWtpPkqRqtSMZNK71Lm7di0kAEm4Rddk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LisXPLuTGJU4BbDiE5me9Q+efViLwb795w8CAfZSCx9nKVXK+U/xthkV5XX7rjz6QBMRp8VkEYTHwehW2EuUbqV5YAdb/6A8qF2hLS5vENrzMiA7t80wAUjTwDYGY1DzKe3qqf0rFvI01HTCHptkOuQeZACearAvfjFcQ+mcGSw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=MtlVOEkY; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="MtlVOEkY"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender
	:Reply-To:Content-Type:Content-ID:Content-Description;
	bh=OvA5o5ybrfRL+VSUlWNSniaj9ezur7qcZJTS+15vyzI=; b=MtlVOEkYxIKEIyN694xqk+dxJp
	xqzVpIRPC+qdLPdHgV7aNTf1IzE5NmX9P53fU2fHICjngF9CnqOCOj+55MyM11RVq1w3evzqHYkwu
	07p3OajEdzbP89urQ9FfiVQJC7uAC2v3bz1AJu5QrhArUnh1yAFnx85rOxhuQ7ZCd8gWt5uhVTy3z
	dEYM83HlFc1p+OTeIzkhCdLaQDXqkMGCbEmNjzCuNcH9clHr5xCiAsAG8GMVKlWp1EI8hXIQpvtd3
	PcXojbEg+H8140uvrdJK9YaTyylji9AB6wE+OIjQFDCoDixkGqNjLdEHTB2W+aUUtQxcMdqWqqhw7
	xb3TEgfQ==;
Received: from 2a02-8389-2341-5b80-3c00-8f88-6e38-56f1.cable.dynamic.v6.surfer.at ([2a02:8389:2341:5b80:3c00:8f88:6e38:56f1] helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uEjqZ-0000000BauN-1Y2M;
	Tue, 13 May 2025 07:14:39 +0000
From: Christoph Hellwig <hch@lst.de>
To: axboe@kernel.dk
Cc: linux-block@vger.kernel.org
Subject: [PATCH 2/2] blk-mq: add a copyright notice to blk-mq-dma.c
Date: Tue, 13 May 2025 09:14:33 +0200
Message-ID: <20250513071433.836797-2-hch@lst.de>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250513071433.836797-1-hch@lst.de>
References: <20250513071433.836797-1-hch@lst.de>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

blk-mq-dma.c was split from blk-merge.c which has no copyright notice,
but except for some boilerplate code and comments left from the old
version this is all my code, so add my copyright.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 block/blk-mq-dma.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/block/blk-mq-dma.c b/block/blk-mq-dma.c
index 5822b8898bdd..82bae475dfa4 100644
--- a/block/blk-mq-dma.c
+++ b/block/blk-mq-dma.c
@@ -1,4 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (C) 2025 Christoph Hellwig
+ */
 #include "blk.h"
 
 struct phys_vec {
-- 
2.47.2


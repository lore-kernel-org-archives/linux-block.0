Received: from mout-p-103.mailbox.org (mout-p-103.mailbox.org [80.241.56.161])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1D2B2F28FF;
	Mon,  5 Oct 2026 06:52:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.161
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791183146; cv=none; b=WZ7YHLmL7jspkUtwKL4FuOIh+X+5xHJGOYXeqQdeU7hwaI004gvyqRYau4D618+6oqfGgD+u2VEhKLLvas2GzBm1uzm7pMo2c4fOFhwKOwZKLcjkqfg8KXwTCxDTgXYj0rRD+2qCulRcmVvryKNjlrR2y3ocwLJeTbtk3qi7+Wg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791183146; c=relaxed/simple;
	bh=jw6IP6+5XA5FDPtb0unS6I7tQnCy77iFCm6MKLnhIy8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=qfZ8H5DAULLalsyyYuKoZ6wLNeUFNc1cxJml8RSoJFm3HfVtyFVjZT4I0ipV5k+22ijNAjLnpKKqvqKsoIcbcmWcwSikqCFEf7a1W70C3v84rUGEnXLLtkoLFHEdSgpfS/4fZaCK78hnqB/C4BrcyHsebnR9fjJs3gnXeEy1pzc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org; spf=pass smtp.mailfrom=mailbox.org; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=xt3MJJa8; arc=none smtp.client-ip=80.241.56.161
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mailbox.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="xt3MJJa8"
Received: from smtp202.mailbox.org (smtp202.mailbox.org [IPv6:2001:67c:2050:b231:465::202])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519MLKEM768 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-103.mailbox.org (Postfix) with ESMTPS id 4hyqnW1WjqzKmLf;
	Mon, 05 Oct 2026 08:52:15 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1791183135;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=o3ON3Tyr2/LG2/FfJfTdOVgEgHd3Q8PcqO7Fzwm34m4=;
	b=xt3MJJa8auJrPEZKaHYycmGxDrl9DGyqQb0vbkhaVqWkzw/ZeTiTvWAfTPVkQPm9J0RUDI
	VYw480wbHPdkgIL4fIDBtj00gNRrOUn1LQG4TFXdyzaSpvPTIDJR8gilhD8zgVqTTDcIF1
	ewpavyc+/jweV7kSrC2AACIERIwS7tQkNPX8Uv/DC7+i0ui+LgQNnGcqmRks9MmffB/4Jg
	frveMAkycUYS0nKbbEB+GKiFkpXCFdVb22rcjtcIEME9FnMpUKno4p4sM2JNl2MtKb3Fr9
	IZMNtfjoVPkBaCzQTDx0UAIKM1jZF86hoijOIfwfeUtFoKsYOcVaXU4LWdkkQQ==
From: Manuel Ebner <manuelebnerli@mailbox.org>
To: Jens Axboe <axboe@kernel.dk>
Cc: Manuel Ebner <manuelebnerli@mailbox.org>,
	Fengnan Chang <changfengnan@bytedance.com>,
	Christoph Hellwig <hch@lst.de>,
	linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] block: fix kernel-doc of bio_copy_kern()
Date: Mon,  5 Oct 2026 08:48:49 +0200
Message-ID: <20261005064848.2879898-3-manuelebnerli@mailbox.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-ID: 904c79fb28a182ea332
X-MBO-RS-META: ij6mpc1yjzodh9o47xqn91ruqj1w8afq

Remove obsolete argument in kernel-doc fixing:

$ ./scripts/kernel-doc -none block/blk-map.c
Warning: block/blk-map.c:366 Excess function parameter 'op' description in 'bio_copy_kern'

Signed-off-by: Manuel Ebner <manuelebnerli@mailbox.org>
CC: Fengnan Chang <changfengnan@bytedance.com>
CC: Christoph Hellwig <hch@lst.de>
---
Let me know if 'op' should be explained as a variable instead.
---
 block/blk-map.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/block/blk-map.c b/block/blk-map.c
index 81cba3af4..e0c2b8236 100644
--- a/block/blk-map.c
+++ b/block/blk-map.c
@@ -356,7 +356,6 @@ static void bio_copy_kern_endio_read(struct bio *bio)
  *	@rq: request to fill
  *	@data: pointer to buffer to copy
  *	@len: length in bytes
- *	@op: bio/request operation
  *	@gfp_mask: allocation flags for bio and page allocation
  *
  *	copy the kernel address into a bio suitable for io to a block
-- 
2.55.0


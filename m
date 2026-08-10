Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E48B53F39CB
	for <linux-block@vger.kernel.org>; Mon, 10 Aug 2026 14:46:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786373173; cv=none; b=o/ukPW0paWxYK9LF5mkrR6XYVJRZSnc/W88QvKLLJRCUZj/c+0IjLOpcqcFvT4PvHYnIguG7qbbrGTX1ajpvEK1Q68ezpxvv2KIZTh0m9a5Ngw47Av0iHzKgVzSVjPrvfRhdzOUjvtcllp/n4oEHkoLV5o6/5TQ4fee/PLwDoeg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786373173; c=relaxed/simple;
	bh=Vt/AEzBMtPfGLWpVhpXZ/Q8RGrfJbRyYN5PR/V1TEEQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=cB2yv7vrrmVvy35uvMKambwoGPANaU4gtAwxNDgDEiORVkV/l1yktWypneBnttUDgc5DcE35oz0b25vZgcYAeEsO/L39UW4lnsL4qOUUo1gL3dKQkhRUV0z9MHd4HyEaUnr9tuuW4yu8VinOpoNZt7Iz12pn/SDL/dOglsdcp4M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=chhu9NIr; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="chhu9NIr"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
	Content-ID:Content-Description:In-Reply-To:References;
	bh=pzFfhB1iTcOk9qxfIOuPlXEK9N+9DCAW68e80MLqD+0=; b=chhu9NIr6V1/htazqKvjmmTUqx
	kMkNL9q+h4Gdut+SU1hCTHCnq8joCUAvBKst+bj6E7rAIlHmXcq4Rhh8lUlZGGQGfBmpyAK75LN7O
	MFNwXUWVROG1sQOOb4N3+C7e09rF/usm7/kJjPpNSlC4c2fn8QuxkfO66wTsgw0IWaUcQwG0jLiu5
	R5qz39GUiZVSiYV6QRVlNx9rOUFMb2sjLJ8MB1mBWfZAHMwps/UXy/x1t/c13/jF0Ga+7tfOnFoQn
	aa0x38EqBS6V/7dzC5P58h3NZQYYkcdI/gX+l9ocb4z+9nn2GAgNa8K1fCmAJl0o2bEwSZE2QkRHI
	YlW02tjA==;
Received: from [12.156.71.108] (helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wtRGT-0000000C4JH-1jKP;
	Mon, 10 Aug 2026 14:46:09 +0000
From: Christoph Hellwig <hch@lst.de>
To: axboe@kernel.dk
Cc: linux-block@vger.kernel.org
Subject: [PATCH] block: don't include blk-integrity.h in bdev.c
Date: Mon, 10 Aug 2026 07:45:59 -0700
Message-ID: <20260810144603.453283-1-hch@lst.de>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

Not needed, probably since this file was split out.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 block/bdev.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/block/bdev.c b/block/bdev.c
index 85ce57bd2ae4..90baef0bd174 100644
--- a/block/bdev.c
+++ b/block/bdev.c
@@ -12,7 +12,6 @@
 #include <linux/major.h>
 #include <linux/device_cgroup.h>
 #include <linux/blkdev.h>
-#include <linux/blk-integrity.h>
 #include <linux/backing-dev.h>
 #include <linux/module.h>
 #include <linux/blkpg.h>
-- 
2.53.0


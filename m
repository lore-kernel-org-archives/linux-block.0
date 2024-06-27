Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 893D613BACC
	for <linux-block@vger.kernel.org>; Thu, 27 Jun 2024 11:14:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719486854; cv=none; b=OCOSSfa35++l44pmm7m5VUuqNVLArBkT0KS3jKwoR0ifvv4CT9N77B1Evv958k9kev/4N0ZDuZTpmV/8936jWaU8fbcY97LYWPUad9iut7+B9vFuBkRAablXG/r9J3Q29e/sj0sUPrZ4Imwa0ctpvsTgjCsXguw1HIjI+yFYBTU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719486854; c=relaxed/simple;
	bh=cSM2MIyrXDaHLaMotjHi+JQPd8vD3wTjP9UNVrfOtvE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ua2Fev7Hsmx5MbETwjVuNgpy9jx9iN5IUEnVoHcVyxWBLG+/oH+cn5Xheo9zRSZfDaR6ntkkfQuEFPcKrnQ5x2AvlVfAh8D+rMLRMNuwZYlQpfZa5mk7T6Np0O49xWy1J1WyEO72DFCilmCBI9CWRvrX2deB3wluyzn0Nlskeco=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=5F7gFSK5; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="5F7gFSK5"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
	Content-ID:Content-Description:In-Reply-To:References;
	bh=BZ5iRMlmlU+74GXk9JpwfSqWP2VGyRQ1hVTM0AIIKHo=; b=5F7gFSK5Mq8R34FZn0v+rU0j2E
	dp//rFpHc9XS7xTh1nqTI/ZEz3sRV3B5zJEPzgV4llUDZitT1K2hTBRSJ3k2IpLvX9nuEFPbOSd3X
	efysZNT8Ke/xSYC6mdPy6lh/TXOPjgwKzi61AFkJoaLWjDe8jxq6KVxqDKpNQCRD5eFFIb0yZ6qUQ
	0GcJjSduua/qSc4Fojga5QinbiDv6ksiuiKz2Ll6miJriOdaIoH3QJJsyZX9XYw917exU5akB4aJI
	5M3bv/p6VsfyPlaitYKpmkLlaptWyBSuDDaLhWG+fvCpZF2zKMtUoolfHw9lBeD9oO/nVhNwFsrR5
	kPI8wlbA==;
Received: from [2001:4bb8:2dc:6d4c:6789:3c0c:a17:a2fe] (helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sMn4s-0000000A7FF-0bKB;
	Thu, 27 Jun 2024 11:14:10 +0000
From: Christoph Hellwig <hch@lst.de>
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org
Subject: de-duplicate the block sysfs code
Date: Thu, 27 Jun 2024 13:14:00 +0200
Message-ID: <20240627111407.476276-1-hch@lst.de>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

Hi Jens,

this series adds a few helpers to de-duplicate the block sysfs code,
and then switches it to operate on then gendisk, which is the object that
the kobject is embedded into.

Diffstat:
 block/blk-sysfs.c      |  389 ++++++++++++++++++-------------------------------
 block/elevator.c       |    9 -
 block/elevator.h       |    4 
 include/linux/blkdev.h |    7 
 4 files changed, 156 insertions(+), 253 deletions(-)
